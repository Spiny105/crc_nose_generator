module matrix_crc
(
	input clock,
	input reset_b,
	input [7 : 0] poly_start_val,			//Начальное значение регистра
	input [7 : 0] matrix_row_0_start,	//Для записи строк таблицы
	input [7 : 0] matrix_row_1_start,
	input [7 : 0] matrix_row_2_start,
	input [7 : 0] matrix_row_3_start,
	input [7 : 0] matrix_row_4_start,
	input [7 : 0] matrix_row_5_start,
	input [7 : 0] matrix_row_6_start,
	input [7 : 0] matrix_row_7_start,
	output reg [7 : 0] current_crc		//Текущее состояние регистра
);
	
//Строки таблицы
reg [7 : 0] matrix_row_0;
reg [7 : 0] matrix_row_1;
reg [7 : 0] matrix_row_2;
reg [7 : 0] matrix_row_3;
reg [7 : 0] matrix_row_4;
reg [7 : 0] matrix_row_5;
reg [7 : 0] matrix_row_6;
reg [7 : 0] matrix_row_7;


reg [7 : 0] next_crc;	//Временная переменная для вычисления следующего значения

always @ (posedge clock, negedge reset_b)
//Инициализация при сбросе 
if (~reset_b)
	begin
		current_crc  <= poly_start_val;
		matrix_row_0 <= matrix_row_0_start;
		matrix_row_1 <= matrix_row_1_start;
		matrix_row_2 <= matrix_row_2_start;
		matrix_row_3 <= matrix_row_3_start;
		matrix_row_4 <= matrix_row_4_start;
		matrix_row_5 <= matrix_row_5_start;
		matrix_row_6 <= matrix_row_6_start;
		matrix_row_7 <= matrix_row_7_start;
	end
//Нормальная работа модуля
else begin	
	next_crc = 0;
	
	if (current_crc[0] == 1)
		next_crc = next_crc ^ matrix_row_0;
	if (current_crc[1] == 1)
		next_crc = next_crc ^ matrix_row_1;
	if (current_crc[2] == 1)
		next_crc = next_crc ^ matrix_row_2;
	if (current_crc[3] == 1)
		next_crc = next_crc ^ matrix_row_3;
	if (current_crc[4] == 1)
		next_crc = next_crc ^ matrix_row_4;
	if (current_crc[5] == 1)
		next_crc = next_crc ^ matrix_row_5;
	if (current_crc[6] == 1)
		next_crc = next_crc ^ matrix_row_6;
	if (current_crc[7] == 1)
		next_crc = next_crc ^ matrix_row_7;
		
	current_crc = next_crc;
end

endmodule