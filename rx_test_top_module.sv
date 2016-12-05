module rx_test_top_module (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	input rx_pin_in,
	output [3:0] number_data_sig
);

/*=====================================================================*/

/*----------------------------block function---------------------------*/

/*=====================================================================*/
    logic rx_en_sig;
    logic rx_done_sig;
    logic [7:0] rx_data;
    logic [7:0] number_data;

    rx_module u0_rx_module(
        .clk        (clk),
        .rst_n      (rst_n),
        .rx_pin_in  (rx_pin_in),
        .rx_en_sig  (rx_en_sig),
        .rx_done_sig(rx_done_sig),
        .rx_data    (rx_data)

    	);

/*---------------------------------------------------------------------*/
    rx_test_module u0_rx_test_module(
    	.clk        (clk),
    	.rst_n      (rst_n),
    	.rx_done_sig(rx_done_sig),
    	.rx_en_sig  (rx_en_sig),
    	.rx_data    (rx_data),
    	.number_data(number_data)

    	);
/*---------------------------------------------------------------------*/

    assign number_data_sig = number_data[3:0];

/*=====================================================================*/


endmodule