module rx_module (
	input        clk        , // Clock
	input        rst_n      , // Asynchronous reset active low
	input        rx_pin_in  ,
	input        rx_en_sig  ,
	output       rx_done_sig,
	output [7:0] rx_data
);

	logic h2l_sig  ;
	logic bps_clk  ;
	logic count_sig;

	/*==========================================================*/

	////module instantiation       

	/*==========================================================*/
	rx_detect_module u0_rx_detect_module(
		.clk(clk),
		.rst_n(rst_n),
		.rx_pin_in(rx_pin_in),
		.h2l_sig(h2l_sig)

	);

	/*----------------------------------------------------------*/
	rx_bps_module u0_rx_bps_module(
		.clk(clk),
		.rst_n(rst_n),
		.count_sig(count_sig),
		.bps_clk(bps_clk)

	);

	/*----------------------------------------------------------*/
	rx_control_module u0_rx_control_module(
		.clk(clk),
		.rst_n(rst_n),
		.h2l_sig(h2l_sig),
		.rx_pin_in(rx_pin_in),
		.bps_clk(bps_clk),
		.rx_en_sig(rx_en_sig),
		.count_sig(count_sig),
		.rx_done_sig(rx_done_sig),
		.rx_data(rx_data)

	);
	
	/*==========================================================*/


endmodule