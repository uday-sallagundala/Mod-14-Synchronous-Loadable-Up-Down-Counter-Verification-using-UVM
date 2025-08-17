class counter_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(counter_virtual_sequencer)

	source_sequencer src_seqr[];
	dest_sequencer dest_seqr[];
	counter_env_config m_cfg;

	function new(string name = "counter_virtual_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(counter_env_config)::get(this,"","counter_env_config",m_cfg))
			`uvm_fatal("vir_seqr","cannot get env_config()")
		src_seqr = new[m_cfg.no_of_source_agents];
		dest_seqr = new[m_cfg.no_of_dest_agents];
	endfunction
endclass
