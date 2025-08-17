class dest_agent_top extends uvm_env;

	`uvm_component_utils(dest_agent_top)
	counter_env_config m_cfg;
	dest_agent dest_agt[];
	
	function new(string name = "dest_agt_top", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(counter_env_config)::get(this,"*","counter_env_config",m_cfg))
			`uvm_fatal("dest_agt_top","could not get counter_env_config")
		dest_agt = new[m_cfg.no_of_dest_agents];
		foreach(dest_agt[i])
			dest_agt[i]=dest_agent::type_id::create($sformatf("dest_agt[%0d]",i), this);
	endfunction
endclass
