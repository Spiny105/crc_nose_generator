`timescale 1ns / 1ns
module testbench();

//------------------------  Подготовка к тесту

//Тактовый сигнал и сигнал сброса
reg clock;
reg reset_b;		//Сигнал сброса. Если равен 1 - штатная работа модуля, куда он заведен, если 0, то режим сброса

//Описание поведения тактового сигнала + логгирование
always begin
#20 clock = ~clock;
if (clock) begin
	$fdisplay(output_file, "Значение регистра = %b", poly_wire);
	$fdisplay(matrix_output_file, "Значение регистра = %b", matrix_output);
	end
end

//Описание поведения сигнала сброса и начального состояния тактового сигнала
initial begin
	reset_b = 0;
	clock = 0;
	#100 reset_b = 1;	//Ждем несколько тактов, пака производится инициализация модулей
end





//------------------------  Задание №1

wire [7 : 0] poly_wire;		//Для вывода состояния регстра
integer output_file;			//Для записи результатов в файл
reg [7 : 0] mem [0: 0]; 	//Для загрузки начального состояния из файла

//Модуль для теста
crc_2 module_under_test_2
(	
	.clock(clock), 
	.polynom(poly_wire),
	.reset_b(reset_b),
	.start_val(mem[0])
);

//Сам тест
initial begin

	output_file = $fopen("out_2.txt");
	$readmemb("start_2.txt", mem);
	
	#20000
	$fclose(output_file);
	$finish;
end






//------------------------  Задание №2 

reg [7 : 0] matrix_mem [8: 0];		//Для загрузки начального состояния из файла
integer matrix_output_file;			//Для записи результатов
wire [7 : 0] matrix_output;

//Модуль для теста
matrix_crc matrix_crc_test
(
	.clock(clock),
	.reset_b(reset_b),
	.poly_start_val(matrix_mem[0]),
	.matrix_row_0_start(matrix_mem[1]),
	.matrix_row_1_start(matrix_mem[2]),
	.matrix_row_2_start(matrix_mem[3]),
	.matrix_row_3_start(matrix_mem[4]),
	.matrix_row_4_start(matrix_mem[5]),
	.matrix_row_5_start(matrix_mem[6]),
	.matrix_row_6_start(matrix_mem[7]),
	.matrix_row_7_start(matrix_mem[8]),
	.current_crc(matrix_output)
);

//Сам тест
initial begin
	matrix_output_file = $fopen("out_matrix.txt");
	$readmemb("matrix_start.txt", matrix_mem);
	
	#20000
	$fclose(matrix_output_file);
	$finish;
end

endmodule