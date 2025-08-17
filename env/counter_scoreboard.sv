class counter_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(counter_scoreboard)
		
	uvm_tlm_analysis_fifo #(source_xtn) src_fifo[];
	uvm_tlm_analysis_fifo #(dest_xtn) dest_fifo[];
	
	counter_env_config m_cfg;
	source_xtn source_data;
	dest_xtn dest_data;
	
	int data_verified = 0;
	int src_data_count = 0;
	int dest_data_count = 0;
	static bit [3:0]ref_count;
	
	function new(string name = "counter_scoreboard", uvm_component parent);
		super.new(name,parent);
		counter_cov = new();
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(counter_env_config)::get(this,"","counter_env_config",m_cfg))
			`uvm_fatal("scoreboard","could not counter_env_config")
		src_fifo = new[m_cfg.no_of_source_agents];
		dest_fifo = new[m_cfg.no_of_dest_agents];
		foreach(src_fifo[i])
			src_fifo[i] = new($sformatf("src_fifo[%0d]",i),this);
		foreach(dest_fifo[i])
			dest_fifo[i] = new($sformatf("dest_fifo[%0d]",i),this);
		source_data = source_xtn::type_id::create("source_data");
		dest_data = dest_xtn::type_id::create("dest_data");
		
	endfunction
	
	covergroup counter_cov;
		option.per_instance = 1;
		LOAD: coverpoint source_data.load {
			bins low = {0};
			bins high = {1};

			}
		UP_DOWN: coverpoint source_data.up_down {
			bins low = {0};
			bins high = {1};
			}
		DATA_IN: coverpoint source_data.data_in {
			bins data[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13};
			}
	endgroup

	task run_phase(uvm_phase phase);
	forever
		begin
			fork
				begin	
					src_fifo[0].get(source_data);
					`uvm_info("sb",$sformatf("source_data printing from sb \n %s",source_data.sprint()),UVM_LOW)
					check_task(source_data);
					src_data_count++;
				end
				begin	
					dest_fifo[0].get(dest_data);
					compare(dest_data);
					dest_data_count++;
					`uvm_info("sb",$sformatf("dest_data printing from sb \n %s",dest_data.sprint()),UVM_LOW)
				end
			join
		end
	endtask

	task check_task(source_xtn source_data);
		if (source_data.reset) 
        	begin           
          		ref_count <= 4'd0;
        	end    
  
        	else if (source_data.load && source_data.data_in <= 4'd13)   
        	begin  
          		ref_count <= source_data.data_in;
        	end   
   
        	else if (source_data.up_down) 
      		begin      
            		if (ref_count == 4'd13)   
                		ref_count <= 4'd0;
            		else
               	 		ref_count <= ref_count + 1'b1;
      		end    
  
        	else
      		begin                  
            		if (ref_count == 4'd0)    
                		ref_count <= 4'd13;
            		else
                		ref_count <= ref_count - 1;
      		end
		$display("ref_count = %0d",ref_count);
    endtask
	
	task compare(dest_xtn dest_data);
		$display("%0t:    %0d",$time,ref_count);
		if(dest_data.count==ref_count) 
		begin
			//source_data=dest_data;
			counter_cov.sample();
			data_verified++;
			`uvm_info("COUNTER_SB","=====================================COUNT MATCHES========================================",UVM_LOW) 
		end
		else
			`uvm_info("MINI_SB","===============================count is not matched===============================",UVM_LOW)
	endtask
	function void report_phase(uvm_phase phase);
		`uvm_info("COUNTER_SB",$sformatf("src_data_count is %0d",src_data_count),UVM_LOW)
		`uvm_info("COUNTER_SB",$sformatf("dest_data_count is %0d",dest_data_count),UVM_LOW)
		`uvm_info("COUNTER_SB",$sformatf("data_verified is %0d",data_verified),UVM_LOW)
	endfunction
endclass
