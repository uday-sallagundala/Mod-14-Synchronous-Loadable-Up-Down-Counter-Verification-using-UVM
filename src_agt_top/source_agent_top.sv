class source_agent_top extends uvm_env;
	
	`uvm_component_utils(source_agent_top)
	
	counter_env_config m_cfg;
	source_agent src_agt[];
	
	function new(string name = "source_agent_top", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(counter_env_config)::get(this,"*","counter_env_config",m_cfg))
				`uvm_fatal("source_agent_top","failed to get counter_env_config()")
			src_agt = new[m_cfg.no_of_source_agents];
			foreach(src_agt[i])
				src_agt[i] = source_agent::type_id::create($sformatf("src_agt[%0d]",i),this);
	endfunction
endclass
