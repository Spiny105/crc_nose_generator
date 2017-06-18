module crc_1(
	input clock
);

reg [2 : 0] polynom;			//Для хранения состояния сдвигового регистра
reg [2 : 0] mem [0: 0]; 	//Для загрузки начального состояния из файла
integer output_file;			//Для записи результатов

always @ (posedge clock) begin	
	
	polynom[2 : 1] <= polynom[1 : 0];
	polynom[0]	<= polynom[1] ^ polynom[2];
	//$fdisplay(output_file, "Значение регистра = %b", polynom);

end

initial begin
	$readmemb("start.txt", mem);
	//output_file = $fopen("out.txt");
	polynom = mem[0];
end

endmodule