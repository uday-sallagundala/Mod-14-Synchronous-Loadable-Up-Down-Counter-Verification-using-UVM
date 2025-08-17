module top;
	import counter_test_pkg::*;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

	bit clock;
	always #5 clock = ~clock;

	counter_if src_if0(clock);
	counter_if dest_if0(clock);
	
	counter DUV(.clock(clock),
				.reset(src_if0.reset),
				.load(src_if0.load),
				.up_down(src_if0.up_down),
				.data_in(src_if0.data_in),
				.count(dest_if0.count));	

	
	initial
		begin
		
			uvm_config_db #(virtual counter_if)::set(null,"*","src_if0",src_if0);
			uvm_config_db #(virtual counter_if)::set(null,"*","dest_if0",dest_if0);

			run_test();
		end
		
endmodule
	
