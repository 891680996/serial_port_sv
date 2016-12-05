module tx_test_top_module (
	input  clk       , // Clock
	input  rst_n     , // Asynchronous reset active low
	output tx_pin_out
);

/*=====================================================================*/

/*----------------------------block function---------------------------*/

/*=====================================================================*/
	logic [7:0] tx_data    ;
	logic       tx_done_sig;
	logic       tx_en_sig  ;

	tx_module u0_tx_module (
		.clk        (clk        ),
		.rst_n      (rst_n      ),
		.tx_en_sig  (tx_en_sig  ),
		.tx_data    (tx_data    ),
		.tx_done_sig(tx_done_sig),
		.tx_pin_out (tx_pin_out )
	);

	tx_test_module u0_tx_test_module (
		.clk        (clk        ),
		.rst_n      (rst_n      ),
		.tx_done_sig(tx_done_sig),
		.tx_en_sig  (tx_en_sig  ),
		.tx_data    (tx_data    )
	);

/*=====================================================================*/


endmodule