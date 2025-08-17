class counter_test extends uvm_test;
	`uvm_component_utils(counter_test)
	
	counter_env envh;
	counter_env_config m_cfg;
	source_agent_config src_agt_cfg[];
	dest_agent_config dest_agt_cfg[];
	
	int no_of_source_agents = 1;
	int no_of_dest_agents = 1;
	
	
	function new(string name ="counter_test", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		
		m_cfg = counter_env_config::type_id::create("m_cfg");
		uvm_config_db #(counter_env_config)::set(this,"*","counter_env_config",m_cfg);
		
		src_agt_cfg = new[no_of_source_agents];
		foreach(src_agt_cfg[i])
			begin
				src_agt_cfg[i] = source_agent_config::type_id::create($sformatf("src_agt_cfg[%0d]",i));	
				m_cfg.src_agt_cfg = src_agt_cfg;
				src_agt_cfg[i].is_active = UVM_ACTIVE;
				uvm_config_db #(source_agent_config)::set(this,$sformatf("envh.src_agt_top.src_agt[%0d]*",i),"source_agent_config",src_agt_cfg[i]);
				if(!uvm_config_db #(virtual counter_if)::get(this,"",$sformatf("src_if%0d",i),src_agt_cfg[i].vif))
					`uvm_fatal("router_test","could not get virtual interface into src_agt_cfg")
			end
			
		dest_agt_cfg = new[no_of_dest_agents];
		foreach(dest_agt_cfg[i])
			begin
				dest_agt_cfg[i] = dest_agent_config::type_id::create($sformatf("dest_agt_cfg[%0d]",i));			
				m_cfg.dest_agt_cfg = dest_agt_cfg;
				dest_agt_cfg[i].is_active = UVM_PASSIVE;
				uvm_config_db #(dest_agent_config)::set(this,$sformatf("envh.dest_agt_top.dest_agt[%0d]*",i),"dest_agent_config",dest_agt_cfg[i]);
				if(!uvm_config_db #(virtual counter_if)::get(this,"",$sformatf("dest_if%0d",i),dest_agt_cfg[i].vif))
					`uvm_fatal("router_test","could not get virtual interface into dest_agt_cfg")
			end
			
		m_cfg.no_of_source_agents = no_of_source_agents;
		m_cfg.no_of_dest_agents = no_of_dest_agents;
	
		super.build_phase(phase);
		envh = counter_env::type_id::create("envh",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

endclass

class small_test extends counter_test;	
	`uvm_component_utils(small_test)
	
	//small_sequence seqh;
	small_vseq sml_vseq;

	function new(string name="small_test", uvm_component parent);
		super.new(name,parent);
	endfunction: new	
	    
	function void build_phase(uvm_phase phase);
            super.build_phase(phase);
		//seqh = small_sequence::type_id::create("seqh");
		sml_vseq = small_vseq::type_id::create("sml_vseq");
		
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);		
		//for(int i=0; i<no_of_source_agents; i++)
		//	seqh.start(envh.src_agt_top.src_agt[0].sqrh);
		sml_vseq.start(envh.v_seqr);
		#100;
		phase.drop_objection(this);
	endtask
endclass

class medium_test extends counter_test;	
	`uvm_component_utils(medium_test)
	
	medium_vseq mdm_vseq;

	function new(string name="medium_test", uvm_component parent);
		super.new(name,parent);
	endfunction: new	
	    
	function void build_phase(uvm_phase phase);
            super.build_phase(phase);
		mdm_vseq = medium_vseq::type_id::create("mdm_vseq");
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);		
		mdm_vseq.start(envh.v_seqr);
		#100;
		phase.drop_objection(this);
	endtask
endclass
