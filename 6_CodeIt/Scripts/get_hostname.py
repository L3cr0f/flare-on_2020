

def encode_buffer(buffer):
	
	for i in range(len(buffer)):
		byte_buffer = ord(buffer[i])
		for j in range(6, -1, -1):
			byte_buffer = byte_buffer + (ord( << (-1 * j))


encode_buffer(hostname.encode("UTF-8"))



For $counter = $number_1 To DllStructGetSize($computer_name_bytes_lower_buffer)
	Local $int_byte_buffer = Number(DllStructGetData($computer_name_bytes_lower_buffer, $number_1, $counter))
	For $fltajbykxx = $number_6 To $number_0 Step -$number_1
		$int_byte_buffer += BitShift(BitAND(Number(DllStructGetData($flxmdchrqd, $number_2, $flqgwnzjzc)), $number_1), -$number_1 * $fltajbykxx)
		$flqgwnzjzc += $number_1
	Next
	$floctxpgqh &= Chr(BitShift($int_byte_buffer, $number_1) + BitShift(BitAND($int_byte_buffer, $number_1), -$number_7))
Next
DllStructSetData($computer_name_bytes_lower_buffer, $number_1, $floctxpgqh)