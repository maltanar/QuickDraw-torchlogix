TEST_CASE := ov7670
YOSYS_PARAM := -nomx8
VERILOG_FILES := \
    top.v \
    uart.v \
    camera_axis_source.v \
    threshold_stream.v \
    capture_buffer.v \
    roi_capture.v \
    roi_inferencer.v \
    renderer.v \
    vga_scanout.v \
    control_uart.v \
	camera_configure.v \
    camera_read.v \
    score_argmax10.v \
    hvsync_generator.v \
    OV7670_config_rom.v \
    OV7670_config.v \
    SCCB_interface.v \
    gatemate_25MHz_pll.v \

include makefile.inc

.PHONY: synth_module_reports

synth_module_reports: $(BOARD).vh $(VERILOG_FILES) | $(BUILD_DIR)
	@echo "Generating hierarchical synthesis JSON"
	@$(YOSYS) -ql $(BUILD_DIR)/synth_hier.log -p '$(YOSYS_DEFS_OPT) read_verilog -defer -sv $(BOARD).vh $(VERILOG_FILES); $(YOSYS_CMDS) synth_gatemate $(YOSYS_PARAM) -luttree -top $(TOP) -noflatten -noiopad -json $(BUILD_DIR)/$(TEST_CASE)_hier.json'
	@$(YOSYS) -Q -p 'read_json $(BUILD_DIR)/$(TEST_CASE)_hier.json; tee -o $(BUILD_DIR)/$(TEST_CASE)_stat_hier.json stat -json -hierarchy'
	@echo "Generating flattened synthesis JSON with scoped instance names"
	@$(MAKE) --no-print-directory json BOARD=$(BOARD) SCOPENAME=1
	@$(YOSYS) -Q -p 'read_json $(JSON_FILE); tee -o $(BUILD_DIR)/$(TEST_CASE)_stat_flat.json stat -json'
	@echo "count,instance_path" > $(BUILD_DIR)/$(TEST_CASE)_instance_group.csv
	@grep -o '\\top[/.][^ ]*' $(YS_V) | sed 's/^\\//' | sed 's/\./\//g' | awk -F/ 'NF >= 2 {print $$1 "/" $$2}' | sort | uniq -c | awk '{print $$1 "," $$2}' >> $(BUILD_DIR)/$(TEST_CASE)_instance_group.csv
	@echo "Wrote $(BUILD_DIR)/$(TEST_CASE)_stat_hier.json, $(BUILD_DIR)/$(TEST_CASE)_stat_flat.json, $(BUILD_DIR)/$(TEST_CASE)_instance_group.csv"
