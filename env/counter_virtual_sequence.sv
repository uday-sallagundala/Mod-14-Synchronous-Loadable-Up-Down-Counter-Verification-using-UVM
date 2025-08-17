class counter_virtual_sequence extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(counter_virtual_sequence)

	counter_virtual_sequencer  v_seqr;
	source_sequencer src_seqr[];
	dest_sequencer dest_seqr[];	
	counter_env_config m_cfg;

	function new(string name = "counter_virtual_sequence");
		super.new(name);
	endfunction

	task body();
	 	if(!uvm_config_db #(counter_env_config)::get(null,get_full_name(),"counter_env_config",m_cfg))
			`uvm_fatal("vir_seqs","cannot get env config")
		src_seqr = new[m_cfg.no_of_source_agents];
		dest_seqr = new[m_cfg.no_of_dest_agents];
		
		if(!($cast(v_seqr,m_sequencer)))
    			`uvm_error("BODY", "Error in $cast of virtual sequencer")

  		foreach(src_seqr[i])
			src_seqr = v_seqr.src_seqr;
		foreach(dest_seqr[i])
			dest_seqr = v_seqr.dest_seqr;
	endtask
endclass

class small_vseq extends counter_virtual_sequence;
	`uvm_object_utils(small_vseq)

	small_sequence sml_seq;

	function new(string name = "small_vseq");
		super.new(name);
	endfunction

	task body();
		super.body();	
		sml_seq=small_sequence::type_id::create("sml_seq");
		//fork
			foreach(src_seqr[i]) 
				sml_seq.start(src_seqr[i]);
		//join
	endtask
endclass

class medium_vseq extends counter_virtual_sequence;
	`uvm_object_utils(medium_vseq)

	medium_sequence mdm_seq;

	function new(string name = "medium_vseq");
		super.new(name);
	endfunction

	task body();
		super.body();	
		mdm_seq=medium_sequence::type_id::create("mdm_seq");
		//fork
			foreach(src_seqr[i]) 
				mdm_seq.start(src_seqr[i]);
		//join
	endtask
endclass

