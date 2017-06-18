module crc_2(
	input clock,
	input reset_b,
	input [7 : 0] start_val,
	output reg [7 : 0] polynom			//Для хранения состояния сдвигового регистра
);


always @ (posedge clock, negedge reset_b) 
//Задать начальное значение при сбросе
if (~reset_b)
	begin
		polynom <= start_val;
	end
//Нормальная работа модуля
else begin		
	polynom[7] <= polynom[6];
	polynom[6] <= polynom[5];
	polynom[5] <= polynom[4];
	polynom[4] <= polynom[3];
	polynom[3] <= polynom[2];
	polynom[2] <= polynom[1];
	polynom[1] <= polynom[0]; 
	polynom[0] <= polynom[7] ^ polynom[5] ^ polynom[4] ^ polynom[3];
end

endmodule