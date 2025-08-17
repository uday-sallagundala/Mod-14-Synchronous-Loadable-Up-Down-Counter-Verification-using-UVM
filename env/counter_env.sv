class counter_env extends uvm_scoreboard;
	`uvm_component_utils(counter_env)
	
	counter_env_config m_cfg;
	source_agent_top src_agt_top;
	dest_agent_top dest_agt_top;
	counter_reference_model rm;
	counter_scoreboard sb;
	counter_virtual_sequencer v_seqr;
	
	function new(string name = "counter_env", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);		
		if(!uvm_config_db#(counter_env_config)::get(this,"","counter_env_config",m_cfg))
			`uvm_fatal("env config","cannot get env_config from uvm_config")
		src_agt_top=source_agent_top::type_id::create("src_agt_top",this);
		dest_agt_top=dest_agent_top::type_id::create("dest_agt_top",this);
		rm=counter_reference_model::type_id::create("rm",this);
		sb=counter_scoreboard::type_id::create("sb",this);
		v_seqr = counter_virtual_sequencer::type_id::create("v_seqr",this);
	endfunction		

	function void connect_phase(uvm_phase phase);
 		super.connect_phase(phase);
		for(int i=0;i<m_cfg.no_of_source_agents;i++)
			v_seqr.src_seqr[i] = src_agt_top.src_agt[i].sqrh;
		for(int i=0;i<m_cfg.no_of_dest_agents;i++)
			v_seqr.dest_seqr[i] = dest_agt_top.dest_agt[i].sqrh;
		for(int i=0;i<m_cfg.no_of_source_agents;i++)
			src_agt_top.src_agt[i].monh.src_monitor_port.connect(sb.src_fifo[i].analysis_export);
		for(int i=0;i<m_cfg.no_of_dest_agents;i++)
			dest_agt_top.dest_agt[i].monh.dest_monitor_port.connect(sb.dest_fifo[i].analysis_export);
	endfunction
endclass
