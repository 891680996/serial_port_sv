module tx_test_module (
	input        clk        , // Clock
	input        rst_n      , // Asynchronous reset active low
	input        tx_done_sig,
	output       tx_en_sig  ,
	output [7:0] tx_data
);

/*=====================================================================*/

/*---------------------frequency demultiplication----------------------*/
//generate a pulse per second

/*=====================================================================*/
	parameter T1S = 26'd49_999_999;

	logic [25:0] count_sec;

	always_ff @(posedge clk or negedge rst_n) begin : proc_count_sec
		if(~rst_n) begin
			count_sec <= 26'b0;
		end else begin
			if(count_sec == T1S) begin
				count_sec <= 26'b0;
			end else begin
				count_sec <= count_sec + 1'b1;
			end
		end
	end

/*=====================================================================*/

/*-------------sent ox31 to test module per second---------------------*/

/*=====================================================================*/
	logic       rtx_en_sig;
	logic [7:0] rtx_data  ;

	always_ff @(posedge clk or negedge rst_n) begin : proc_rtx_data
		if(~rst_n) begin
			rtx_data   <= 8'h31;
			rtx_en_sig <= 1'b0;
		end else begin
			if(tx_done_sig) begin
				rtx_data   <= 8'h31;
				rtx_en_sig <= 1'b0;
			end else begin
				if(count_sec == T1S) begin
					rtx_en_sig <= 1'b1;
				end
			end
		end
	end

/*---------------------------------------------------------------------*/

	assign tx_data   = rtx_data;
	assign tx_en_sig = rtx_en_sig;

/*=====================================================================*/

endmodule