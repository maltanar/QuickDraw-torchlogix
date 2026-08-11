YOSYS_PARAM ?=
YOSYS_CMDS ?=
YOSYS_DEFS_OPT ?=
TARGETS ?= impl
FPGA ?= CCGM1A1
VERILOG_FILES ?= top.v
TOP ?= top
FIRMWARE ?= firmware.bin
ROOT_DIR=$(dir $(lastword $(MAKEFILE_LIST)))
OFL   = openFPGALoader
NEXTPNR = nextpnr-himbaechel
YOSYS = yosys
GMPACK = gmpack
GMUNPACK = gmunpack
EQY_CLOCK = async2sync
SCOPENAME ?=
BUILD_DIR ?= $(abspath $(ROOT_DIR)/../build/fpga-imgpreproc)

SYNTH_LOG := $(BUILD_DIR)/synth.log
SYNTH_V := $(BUILD_DIR)/$(TEST_CASE)_synth.v
JSON_FILE := $(BUILD_DIR)/$(TEST_CASE).json
YS_V := $(BUILD_DIR)/$(TEST_CASE)_ys.v
CFG_FILE := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD)_00.cfg
CFG_BASE := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD)
PR_TXT_FILE := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD)_00.txt
NEXTPNR_TXT := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD).txt
PNR_JSON := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD)_pnr.json
SDF_FILE := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD).sdf
BIT_FILE := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD).bit
PNR_V := $(BUILD_DIR)/$(TEST_CASE)_$(BOARD)_pnr.v
CHECK_YOSYS_EQY := $(BUILD_DIR)/check_yosys.eqy
CHECK_PNR_EQY := $(BUILD_DIR)/check_pnr.eqy
CHECK_PNR_POST_EQY := $(BUILD_DIR)/check_pnr_post.eqy

define check_cc_tool
  $(if $(CC_TOOL), \
    $(eval P_R := $(CC_TOOL)/bin/p_r/p_r), \
    $(error CC_TOOL variable is not set))
endef

ifndef BOARD
$(error BOARD variable is not set)
endif

ifeq ($(BOARD), olimex)
OFL_BOARD=-b olimex_gatemateevb
FREQ = 10
else ifeq ($(BOARD), kolsch)
OFL_BOARD=-c dirtyJtag
FREQ = 48
else
OFL_BOARD=-b gatemate_evb_jtag
FREQ = 10
endif

ifdef SEED
SEED_OPT=--seed $(SEED)
endif

ifdef MULTICLOCK
EQY_CLOCK=clk2fflogic
endif

ifdef YOSYS_DEFS
YOSYS_DEFS_OPT=verilog_defines $(YOSYS_DEFS);
endif

SDC_OPT ?=
ifneq ($(wildcard constraints.sdc),)
SDC_OPT = --sdc constraints.sdc
endif

//NEXTPNR_PARAMS ?= --vopt clk-cp
//NEXTPNR_PARAMS ?= --vopt no-bridges --vopt clk-cp --vopt no-cpe-cp
NEXTPNR_PARAMS ?=
ifdef DIE
NEXTPNR_PARAMS = --vopt force_die=$(DIE)
endif
ifdef STRATEGY
NEXTPNR_PARAMS += --vopt strategy=$(STRATEGY)
endif

all:
	@echo "Use one of targets for '$(BOARD)' board:"
	@echo " - synth - running Yosys synthesys only"
	@echo " - pr - Yosys + p_r"
	@echo " - unpack - Unpack p_r bitstream"
	@echo " - jtag_pr - programming bitstream produced by p_r"
	@echo " - json - Yosys for nextpnr"
	@echo " - nextpnr - Yosys + nextpnr"
	@echo " - jtag - programming bitstream produced by nextpnr"
	@echo " - post - generate post pnr verilog netlist by nextpnr"
	@exit

$(BUILD_DIR):
	@mkdir -p $@

synth: $(SYNTH_V)
json: $(JSON_FILE)

$(SYNTH_V): $(BOARD).vh $(VERILOG_FILES) | $(BUILD_DIR)
	@echo "Running Yosys"
	@$(YOSYS) -ql $(SYNTH_LOG) -p '$(YOSYS_DEFS_OPT) read_verilog -defer -sv $^; $(YOSYS_CMDS) synth_gatemate $(YOSYS_PARAM) -top $(TOP) -nomx8 -vlog $(SYNTH_V)'

$(JSON_FILE) $(YS_V): $(BOARD).vh $(VERILOG_FILES) | $(BUILD_DIR)
	@echo "Running Yosys"
ifneq ($(strip $(SCOPENAME)),)
	@$(YOSYS) -ql $(SYNTH_LOG) -p '$(YOSYS_DEFS_OPT) read_verilog -defer -sv $^; $(YOSYS_CMDS) synth_gatemate $(YOSYS_PARAM) -luttree -top $(TOP) -noflatten -noiopad; flatten -scopename; synth_gatemate $(YOSYS_PARAM) -luttree -top $(TOP); write_json $(JSON_FILE); write_verilog -norename -noattr $(YS_V)'
else
	@$(YOSYS) -ql $(SYNTH_LOG) -p '$(YOSYS_DEFS_OPT) read_verilog -defer -sv $^; $(YOSYS_CMDS) synth_gatemate $(YOSYS_PARAM) -luttree -top $(TOP) -json $(JSON_FILE); write_verilog -norename -noattr $(YS_V)'
endif

$(CFG_FILE): $(SYNTH_V) $(BOARD).ccf | $(BUILD_DIR)
	$(call check_cc_tool)
	@echo "Running P_R for '$(BOARD)' board"
	@$(P_R) -i $(SYNTH_V) ${PR_OPTS} -cCP -pr -ccf $(BOARD).ccf -o $(CFG_BASE)

$(NEXTPNR_TXT) $(PNR_JSON): $(JSON_FILE) $(BOARD).ccf | $(BUILD_DIR)
	@echo "Running nextpnr for '$(BOARD)' board"
	$(NEXTPNR) --device $(FPGA) --json $(JSON_FILE) --vopt ccf=$(BOARD).ccf --vopt out=$(NEXTPNR_TXT) --router router2 --freq $(FREQ) $(SEED_OPT) $(SDC_OPT) --write $(PNR_JSON) --sdf $(SDF_FILE) --placer-heap-beta 0.5 --vopt time_mode=typical $(NEXTPNR_PARAMS)

$(PR_TXT_FILE): $(CFG_FILE) | $(BUILD_DIR)
	@echo "Running unpack for '$(BOARD)' board"
	@$(GMUNPACK) $(CFG_FILE).bit $(PR_TXT_FILE)

pr: $(CFG_FILE)

unpack: $(PR_TXT_FILE)

nextpnr: $(NEXTPNR_TXT)

post: $(PNR_V)

jtag_pr: $(CFG_FILE)
	@echo "Running openFPGALoader for '$(BOARD)' board"
	@$(OFL) $(OFL_BOARD) --index-chain 0 $^

jtag: $(NEXTPNR_TXT)
	@echo "Running openFPGALoader for '$(BOARD)' board"
	@$(GMPACK) $(NEXTPNR_TXT) $(BIT_FILE)
	@$(OFL) $(OFL_BOARD) --index-chain 0 $(BIT_FILE)

$(PNR_V): $(NEXTPNR_TXT) | $(BUILD_DIR)
	@echo "Generate post PnR Verilog netlist"
	@$(YOSYS) -q -p 'read_json $(PNR_JSON); write_verilog -norename -noattr $(PNR_V)'

firmware: $(FIRMWARE)
	@echo "Running openFPGALoader to program '$(FIRMWARE)' on '$(BOARD)' board"
	@$(OFL) $(OFL_BOARD) --index-chain 0 -f -o 1048576 $(FIRMWARE)

clean:
	@rm -rf $(BUILD_DIR)
	@rm -rf *.history *.refwire *.refparam *.refcomp *.pos *.pathes *.path_struc *.net *.id *.prn
	@rm -rf *_00.v *.used *.place *.pin *.cdf *.idh *.min check_yosys check_pnr check_pnr_post

force-nextpnr:
	@mkdir -p $(BUILD_DIR)/logs
	$(NEXTPNR) --device $(FPGA) --json $(JSON_FILE) --vopt ccf=$(BOARD).ccf --vopt out=$(BUILD_DIR)/logs/$(TEST_CASE)_$(BOARD)_$(SEED).txt --router router2 --freq $(FREQ) $(SEED_OPT) $(SDC_OPT) --placer-heap-beta 0.5 --vopt time_mode=typical $(NEXTPNR_PARAMS)

.PHONY: synth json pr nextpnr force-nextpnr jtag_pr jtag unpack check_yosys check_pnr check_pnr_post

$(CHECK_YOSYS_EQY): $(YS_V) $(BOARD).vh $(VERILOG_FILES) | $(BUILD_DIR)
	@echo "Generang EQY file"
	@{ \
	  echo "[gold]"; \
	  echo "$(YOSYS_DEFS_OPT)"; \
	  echo "read_verilog -nowb -noblackbox +/gatemate/cells_sim.v ../cells_extra.v"; \
	  echo "read_verilog -defer -sv $(BOARD).vh $(VERILOG_FILES)"; \
	  echo "$(YOSYS_CMDS)"; \
	  echo "prep -top $(TOP)"; \
	  echo "flatten";\
	  echo "$(EQY_CLOCK)";\
	  echo "memory_map";\
	  echo ""; \
	  echo "[gate]"; \
	  echo "$(YOSYS_DEFS_OPT)"; \
	  echo "read_verilog -nowb -noblackbox +/gatemate/cells_sim.v ../cells_extra.v"; \
	  echo "read_verilog $(YS_V)"; \
	  echo "prep -top $(TOP)"; \
	  echo "flatten";\
	  echo "$(EQY_CLOCK)";\
	  echo "memory_map";\
	  echo ""; \
	  echo "[collect *]"; \
	  echo "bind *"; \
	  echo ""; \
	  echo "[strategy pdr]"; \
	  echo "use sby"; \
	  echo "engine abc scorr; pdr"; \
	} > $@

check_yosys: $(CHECK_YOSYS_EQY)
	@eqy -f $^

$(CHECK_PNR_EQY): $(PNR_V) $(BOARD).vh $(VERILOG_FILES) | $(BUILD_DIR)
	@echo "Generating EQY file"
	@{ \
	  echo "[gold]"; \
	  echo "$(YOSYS_DEFS_OPT)"; \
	  echo "read_verilog -nowb -noblackbox +/gatemate/cells_sim.v ../cells_extra.v"; \
	  echo "read_verilog -defer -sv $(BOARD).vh $(VERILOG_FILES)"; \
	  echo "$(YOSYS_CMDS)"; \
	  echo "prep -top $(TOP)"; \
	  echo "flatten";\
	  echo "$(EQY_CLOCK)";\
	  echo "memory_map";\
	  echo ""; \
	  echo "[gate]"; \
	  echo "$(YOSYS_DEFS_OPT)"; \
	  echo "read_verilog -nowb -noblackbox +/gatemate/cells_sim.v ../cpesim.v"; \
	  echo "read_verilog $(PNR_V)"; \
	  echo "rename top $(TOP)";\
	  echo "prep -top $(TOP)"; \
	  echo "flatten";\
	  echo "$(EQY_CLOCK)";\
	  echo "memory_map";\
	  echo ""; \
	  echo "[collect *]"; \
	  echo "bind *"; \
	  echo ""; \
	  echo "[strategy pdr]"; \
	  echo "use sby"; \
	  echo "engine abc scorr; pdr"; \
	} > $@

check_pnr: $(CHECK_PNR_EQY)
	@eqy -f $^

$(CHECK_PNR_POST_EQY): $(PNR_V) $(BOARD).vh $(YS_V) | $(BUILD_DIR)
	@echo "Generating EQY file"
	@{ \
	  echo "[gold]"; \
	  echo "$(YOSYS_DEFS_OPT)"; \
	  echo "read_verilog -nowb -noblackbox +/gatemate/cells_sim.v ../cells_extra.v"; \
	  echo "read_verilog $(YS_V)"; \
	  echo "prep -top $(TOP)"; \
	  echo "flatten";\
	  echo "$(EQY_CLOCK)";\
	  echo "memory_map";\
	  echo ""; \
	  echo "[gate]"; \
	  echo "$(YOSYS_DEFS_OPT)"; \
	  echo "read_verilog -nowb -noblackbox +/gatemate/cells_sim.v ../cpesim.v"; \
	  echo "read_verilog $(PNR_V)"; \
	  echo "rename top $(TOP)";\
	  echo "prep -top $(TOP)"; \
	  echo "flatten";\
	  echo "$(EQY_CLOCK)";\
	  echo "memory_map";\
	  echo ""; \
	  echo "[collect *]"; \
	  echo "bind *"; \
	  echo ""; \
	  echo "[strategy pdr]"; \
	  echo "use sby"; \
	  echo "engine abc scorr; pdr"; \
	} > $@

check_pnr_post: $(CHECK_PNR_POST_EQY)
	@eqy -f $^
