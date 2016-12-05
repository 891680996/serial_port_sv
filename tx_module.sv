module tx_module (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	input tx_en_sig,
	input [7:0] tx_data,
	output tx_done_sig,
	output tx_pin_out
);

/*=====================================================================*/

/*------------------------instantiation modules------------------------*/

/*=====================================================================*/
    logic bps_clk;


    tx_bps_module u0_tx_bps_module(
    	.clk      (clk),
    	.rst_n    (rst_n),
    	.count_sig(tx_en_sig),
    	.bps_clk  (bps_clk)

    	);

    tx_control_module u0_control_module(
    	.clk        (clk),
    	.rst_n      (rst_n),
    	.tx_data    (tx_data),
    	.bps_clk    (bps_clk),
    	.tx_en_sig  (tx_en_sig),
    	.tx_done_sig(tx_done_sig),
    	.tx_pin_out (tx_pin_out)

    	);


/*---------------------------------------------------------------------*/



/*=====================================================================*/



endmodule