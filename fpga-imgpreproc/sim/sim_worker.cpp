// sim_worker.cpp — C++ simulation harness for QuickDraw FPGA Simulator
//
// All per-cycle state machines (camera injection, UART RX/TX, VGA sampling)
// run entirely in C++, eliminating Python<->C++ boundary crossings for each
// clock cycle.  Exposed as a plain C API loaded by sim_ctypes.py via ctypes.
//
// Build: see build_worker.sh

#include "Vsim_top.h"
#include "verilated.h"
#ifdef VM_TRACE
#include "verilated_vcd_c.h"
#endif

#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <deque>
#include <vector>

// ============================================================
// Constants
// ============================================================
static const int BAUD_CYCLES = 217;   // 25 MHz / 115200 baud

// ============================================================
// Enums
// ============================================================
enum CamState {
    CAM_IDLE = 0, CAM_VSYNC_HIGH, CAM_ROW_START, CAM_PIXEL,
    CAM_ROW_END_PULSE, CAM_FRAME_END_PULSE
};
enum RxState { RX_IDLE = 0, RX_SENDING };
enum TxState { TX_IDLE = 0, TX_DATA, TX_STOP };

static const char* CAM_STATE_NAMES[] = {
    "idle", "vsync_high", "row_start", "pixel",
    "row_end_pulse", "frame_end_pulse"
};

// ============================================================
// Simulator state
// ============================================================
struct Sim {
    Vsim_top*  top;
#ifdef VM_TRACE
    VerilatedVcdC* tracer;
    vluint64_t     trace_time;
#endif
    long long  cycle;

    // --- Camera input state machine ---
    CamState   cam_state;
    uint8_t*   cam_frame;      // owned: cam_frame_h * cam_frame_w * 3 RGB bytes
    int        cam_frame_h;    // original canvas height  (= pixels per scanline)
    int        cam_frame_w;    // original canvas width   (= number of scanlines)
    int        cam_height;     // scanlines to send       (= canvas width)
    int        cam_width;      // pixels per scanline     (= canvas height)
    int        cam_x;          // pixel index within scanline  → canvas y-axis
    int        cam_y;          // scanline index               → canvas x-axis
    int        cam_byte;       // 0 or 1 (camera sends 2 bytes per pixel)
    int        cam_pclk;
    int        cam_countdown;
    int        cam_frames_sent;
    uint8_t*   cam_pending;    // most-recent submitted frame (replaces previous)
    int        cam_pending_h;
    int        cam_pending_w;

    // --- UART RX: driving rx_i into hardware ---
    std::deque<uint8_t> rx_queue;
    RxState    rx_state;
    uint8_t    rx_bits[12];    // [0]=start  [1..8]=data LSB-first  [9,10]=stop
    int        rx_bit_idx;
    int        rx_countdown;

    // --- UART TX: decoding tx_o from hardware ---
    TxState    tx_state;
    int        tx_bit_count;
    uint8_t    tx_bits;
    int        tx_sample_cd;
    std::vector<uint8_t> tx_decoded;

    // --- VGA output sampler ---
    // Flat array indexed by 16-bit VGA buffer address; -1 = no pixel written yet
    int32_t    vga_current[65536];
    int        vga_current_count;
    int        vga_last_vsync;
    int        vga_frames_received;
    std::vector<uint32_t> vga_addrs;
    std::vector<uint32_t> vga_rgb444;
    bool       vga_frame_ready;

    Sim()
        : top(nullptr),
#ifdef VM_TRACE
          tracer(nullptr), trace_time(0),
#endif
          cycle(0),
          cam_state(CAM_IDLE),
          cam_frame(nullptr),
          cam_frame_h(0), cam_frame_w(0),
          cam_height(0), cam_width(0),
          cam_x(0), cam_y(0),
          cam_byte(0), cam_pclk(0),
          cam_countdown(0), cam_frames_sent(0),
          cam_pending(nullptr), cam_pending_h(0), cam_pending_w(0),
          rx_state(RX_IDLE), rx_bit_idx(0), rx_countdown(0),
          tx_state(TX_IDLE), tx_bit_count(0), tx_bits(0), tx_sample_cd(0),
          vga_current_count(0),
          vga_last_vsync(1),
          vga_frames_received(0),
          vga_frame_ready(false)
    {
        memset(vga_current, -1, sizeof(vga_current));
        memset(rx_bits, 0, sizeof(rx_bits));
    }
};

// ============================================================
// Internal state machine helpers
// ============================================================

static inline void eval_lo(Sim* s) { s->top->clk = 0; s->top->eval(); }
static inline void eval_hi(Sim* s) { s->top->clk = 1; s->top->eval(); }

static void cam_load(Sim* s) {
    // cam_x = pixel index within scanline = canvas y-axis (row in frame array)
    // cam_y = scanline index              = canvas x-axis (col in frame array)
    if (!s->cam_frame ||
        s->cam_x >= s->cam_frame_h ||
        s->cam_y >= s->cam_frame_w) {
        s->top->sim_cam_data = 0;
        return;
    }
    // Transposed access: numpy row=cam_x (canvas y), col=cam_y (canvas x)
    const uint8_t* p = s->cam_frame + (s->cam_x * s->cam_frame_w + s->cam_y) * 3;
    int gray = ((int)p[0] + p[1] + p[2]) / 3;
    s->top->sim_cam_data = (uint8_t)gray;
}

static void drive_camera(Sim* s) {
    switch (s->cam_state) {

    case CAM_IDLE:
        if (s->cam_pending) {
            if (s->cam_frame) { free(s->cam_frame); s->cam_frame = nullptr; }
            s->cam_frame   = s->cam_pending;  s->cam_pending = nullptr;
            s->cam_frame_h = s->cam_pending_h;
            s->cam_frame_w = s->cam_pending_w;
            s->cam_height  = s->cam_frame_w;  // scanlines = canvas width
            s->cam_width   = s->cam_frame_h;  // pixels/scanline = canvas height
            s->cam_y = 0;  s->cam_x = 0;
            s->cam_byte = 0;  s->cam_pclk = 0;
            s->top->sim_cam_vsync = 1;
            s->top->sim_cam_href  = 0;
            s->top->sim_cam_pclk  = 0;
            s->cam_state     = CAM_VSYNC_HIGH;
            s->cam_countdown = 10;
        }
        break;

    case CAM_VSYNC_HIGH:
        if (--s->cam_countdown == 0) {
            s->top->sim_cam_vsync = 0;
            s->cam_state     = CAM_ROW_START;
            s->cam_countdown = 2;
        }
        break;

    case CAM_ROW_START:
        if (--s->cam_countdown == 0) {
            s->top->sim_cam_href = 1;
            s->cam_x = 0;  s->cam_byte = 0;  s->cam_pclk = 0;
            s->top->sim_cam_pclk = 0;
            cam_load(s);
            s->cam_state = CAM_PIXEL;
        }
        break;

    case CAM_PIXEL:
        if (s->cam_pclk == 0) {
            s->top->sim_cam_pclk = 1;  s->cam_pclk = 1;
        } else {
            s->top->sim_cam_pclk = 0;  s->cam_pclk = 0;
            if (++s->cam_byte >= 2) {
                s->cam_byte = 0;
                if (++s->cam_x >= s->cam_width) {
                    s->top->sim_cam_href = 0;
                    s->cam_y++;
                    s->cam_state = CAM_ROW_END_PULSE;
                } else {
                    cam_load(s);
                }
            } else {
                cam_load(s);
            }
        }
        break;

    case CAM_ROW_END_PULSE:
        // One pclk pulse with href=0 → camera_read increments col_count
        if (s->cam_pclk == 0) {
            s->top->sim_cam_pclk = 1;  s->cam_pclk = 1;
        } else {
            s->top->sim_cam_pclk = 0;  s->cam_pclk = 0;
            if (s->cam_y >= s->cam_height) {
                s->top->sim_cam_vsync = 1;
                s->cam_state = CAM_FRAME_END_PULSE;
            } else {
                s->cam_state     = CAM_ROW_START;
                s->cam_countdown = 2;
            }
        }
        break;

    case CAM_FRAME_END_PULSE:
        // One pclk pulse with vsync=1 → camera_read returns to WAIT_FRAME_START
        if (s->cam_pclk == 0) {
            s->top->sim_cam_pclk = 1;  s->cam_pclk = 1;
        } else {
            s->top->sim_cam_pclk = 0;  s->cam_pclk = 0;
            s->top->sim_cam_vsync = 0;
            s->cam_frames_sent++;
            s->cam_state = CAM_IDLE;
        }
        break;
    }
}

static void drive_uart_rx(Sim* s) {
    if (s->rx_state == RX_IDLE) {
        if (!s->rx_queue.empty()) {
            uint8_t byte = s->rx_queue.front();  s->rx_queue.pop_front();
            s->rx_bits[0] = 0;  // start bit
            for (int i = 0; i < 8; i++) s->rx_bits[1 + i] = (byte >> i) & 1;
            s->rx_bits[9] = s->rx_bits[10] = 1;  // stop bits
            s->rx_bit_idx   = 0;
            s->rx_countdown = BAUD_CYCLES / 2;
            s->rx_state     = RX_SENDING;
            s->top->rx_i    = s->rx_bits[0];
        }
    } else {
        if (--s->rx_countdown == 0) {
            if (++s->rx_bit_idx >= 11) {
                s->rx_state  = RX_IDLE;
                s->top->rx_i = 1;
            } else {
                s->rx_countdown = BAUD_CYCLES;
                s->top->rx_i    = s->rx_bits[s->rx_bit_idx];
            }
        }
    }
}

static void decode_uart_tx(Sim* s, uint8_t tx_bit) {
    switch (s->tx_state) {
    case TX_IDLE:
        if (tx_bit == 0) {
            s->tx_state     = TX_DATA;
            s->tx_bit_count = 0;
            s->tx_bits      = 0;
            s->tx_sample_cd = BAUD_CYCLES + BAUD_CYCLES / 2;
        }
        break;
    case TX_DATA:
        if (--s->tx_sample_cd == 0) {
            s->tx_bits |= (tx_bit & 1) << s->tx_bit_count;
            s->tx_sample_cd = BAUD_CYCLES;
            if (++s->tx_bit_count >= 8) s->tx_state = TX_STOP;
        }
        break;
    case TX_STOP:
        if (--s->tx_sample_cd == 0) {
            s->tx_decoded.push_back(s->tx_bits);
            s->tx_state = TX_IDLE;
        }
        break;
    }
}

static void sample_vga(Sim* s) {
    if (s->top->sim_vga_in_display) {
        uint32_t addr   = (uint32_t)s->top->sim_vga_pix_addr;
        uint32_t rgb444 = ((uint32_t)s->top->sim_vga_r << 8) |
                          ((uint32_t)s->top->sim_vga_g << 4) |
                           (uint32_t)s->top->sim_vga_b;
        if (s->vga_current[addr] < 0) s->vga_current_count++;
        s->vga_current[addr] = (int32_t)rgb444;
    }

    int vsync = (int)s->top->sim_vga_vsync;
    if (vsync == 0 && s->vga_last_vsync == 1 && s->vga_current_count > 0) {
        s->vga_addrs.clear();
        s->vga_rgb444.clear();
        for (int a = 0; a < 65536; a++) {
            if (s->vga_current[a] >= 0) {
                s->vga_addrs.push_back((uint32_t)a);
                s->vga_rgb444.push_back((uint32_t)s->vga_current[a]);
            }
        }
        s->vga_frame_ready = true;
        s->vga_frames_received++;
        memset(s->vga_current, -1, sizeof(s->vga_current));
        s->vga_current_count = 0;
    }
    s->vga_last_vsync = vsync;
}

// ============================================================
// C API
// ============================================================
extern "C" {

void* sw_create(int enable_trace, const char* vcd_path) {
    Sim* s = new Sim();

#ifdef VM_TRACE
    Verilated::traceEverOn(enable_trace != 0);
#endif
    s->top = new Vsim_top();

#ifdef VM_TRACE
    if (enable_trace && vcd_path) {
        s->tracer = new VerilatedVcdC();
        s->top->trace(s->tracer, 99);
        s->tracer->open(vcd_path);
    }
#else
    (void)enable_trace; (void)vcd_path;
#endif

    // Power-on reset
    s->top->rst_n         = 0;
    s->top->rx_i          = 1;
    s->top->sim_cam_vsync = 0;
    s->top->sim_cam_href  = 0;
    s->top->sim_cam_pclk  = 0;
    s->top->sim_cam_data  = 0;
    for (int i = 0; i < 10; i++) { eval_lo(s); eval_hi(s); eval_lo(s); s->cycle++; }
    s->top->rst_n = 1;
    for (int i = 0; i < 10; i++) { eval_lo(s); eval_hi(s); eval_lo(s); s->cycle++; }

    fprintf(stdout, "C++ simulator ready, cycle=%lld\n", s->cycle);
    fflush(stdout);
    return (void*)s;
}

void sw_destroy(void* h) {
    Sim* s = (Sim*)h;
#ifdef VM_TRACE
    if (s->tracer) { s->tracer->close(); delete s->tracer; }
#endif
    s->top->final();
    delete s->top;
    if (s->cam_frame)   free(s->cam_frame);
    if (s->cam_pending) free(s->cam_pending);
    delete s;
}

void sw_stop_trace(void* h) {
#ifdef VM_TRACE
    Sim* s = (Sim*)h;
    if (s->tracer) {
        s->tracer->close();
        delete s->tracer;
        s->tracer = nullptr;
        fprintf(stdout, "VCD trace closed\n");
        fflush(stdout);
    }
#else
    (void)h;
#endif
}

void sw_set_camera_frame(void* h, const uint8_t* rgb, int height, int width) {
    Sim* s = (Sim*)h;
    if (s->cam_pending) free(s->cam_pending);
    int sz = height * width * 3;
    s->cam_pending   = (uint8_t*)malloc(sz);
    memcpy(s->cam_pending, rgb, sz);
    s->cam_pending_h = height;
    s->cam_pending_w = width;
}

void sw_send_uart_bytes(void* h, const uint8_t* data, int len) {
    Sim* s = (Sim*)h;
    for (int i = 0; i < len; i++) s->rx_queue.push_back(data[i]);
}

int sw_step(void* h, int n) {
    Sim* s = (Sim*)h;
    for (int i = 0; i < n; i++) {
        drive_camera(s);
        drive_uart_rx(s);

        eval_lo(s);
        eval_hi(s);
        eval_lo(s);

#ifdef VM_TRACE
        if (s->tracer) s->tracer->dump((vluint64_t)s->cycle);
#endif
        decode_uart_tx(s, (uint8_t)s->top->tx_o);
        sample_vga(s);
        s->cycle++;
    }
    return n;
}

// Returns pixel count in latest completed frame, or -1 if none ready
int sw_get_vga_frame(void* h, uint32_t* addrs_out, uint32_t* rgb_out) {
    Sim* s = (Sim*)h;
    if (!s->vga_frame_ready) return -1;
    int n = (int)s->vga_addrs.size();
    memcpy(addrs_out, s->vga_addrs.data(),  n * sizeof(uint32_t));
    memcpy(rgb_out,   s->vga_rgb444.data(), n * sizeof(uint32_t));
    s->vga_frame_ready = false;
    return n;
}

// Returns bytes copied (0 if none)
int sw_recv_uart(void* h, uint8_t* buf, int maxlen) {
    Sim* s = (Sim*)h;
    int n = (int)s->tx_decoded.size();
    if (n == 0) return 0;
    if (n > maxlen) n = maxlen;
    memcpy(buf, s->tx_decoded.data(), n);
    s->tx_decoded.erase(s->tx_decoded.begin(), s->tx_decoded.begin() + n);
    return n;
}

long long   sw_get_cycle(void* h)              { return ((Sim*)h)->cycle; }
int         sw_get_cam_state(void* h)          { return (int)((Sim*)h)->cam_state; }
const char* sw_get_cam_state_name(void* h)     { return CAM_STATE_NAMES[((Sim*)h)->cam_state]; }
int         sw_get_cam_y(void* h)              { return ((Sim*)h)->cam_y; }
int         sw_get_cam_height(void* h)         { return ((Sim*)h)->cam_height; }
int         sw_get_cam_x(void* h)              { return ((Sim*)h)->cam_x; }
int         sw_get_cam_width(void* h)          { return ((Sim*)h)->cam_width; }
int         sw_get_cam_frames_sent(void* h)    { return ((Sim*)h)->cam_frames_sent; }
int         sw_get_vga_frames_received(void* h){ return ((Sim*)h)->vga_frames_received; }
int         sw_get_vga_current_pixels(void* h) { return ((Sim*)h)->vga_current_count; }

} // extern "C"
