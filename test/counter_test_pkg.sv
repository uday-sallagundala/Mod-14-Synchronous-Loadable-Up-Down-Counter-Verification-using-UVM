package counter_test_pkg;


	import uvm_pkg::*;

	`include "uvm_macros.svh"

	//`include "tb_defs.sv"
	`include "source_xtn.sv"
	`include "source_agent_config.sv"
	`include "dest_agent_config.sv"
	`include "counter_env_config.sv"
	`include "source_driver.sv"
	`include "source_monitor.sv"
	`include "source_sequencer.sv"
	`include "source_agent.sv"
	`include "source_agent_top.sv"
	`include "source_sequence.sv"

	`include "dest_xtn.sv"
	`include "dest_monitor.sv"
	`include "dest_sequencer.sv"
	`include "dest_sequence.sv"
	`include "dest_driver.sv"
	`include "dest_agent.sv"	
	`include "dest_agent_top.sv"

	`include "counter_virtual_sequencer.sv"
	`include "counter_virtual_sequence.sv"
	`include "counter_scoreboard.sv"
	`include "counter_reference_model.sv"
	`include "counter_env.sv"

	`include "counter_test.sv"
endpackage
