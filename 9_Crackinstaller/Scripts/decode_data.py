MAX_BYTE_VALUE = 0xFF
MAX_32_BIT_VALUE = 0xFFFFFFFF
MAX_64_BIT_VALUE = 0xFFFFFFFFFFFFFFFF

def decode_data(encoded_data):
	key = bytearray([0x3C, 0x67, 0x7E, 0x7B, 0x3C, 0x69, 0x74])
	source = ""
	encoded_data_size = len(encoded_data)
	counter = 0

	for byte in encoded_data:
		decoded_byte = (key[counter & MAX_32_BIT_VALUE] & MAX_BYTE_VALUE) ^ byte
		source = source + chr(decoded_byte)
		prev_counter = counter + 1
		aux_value = ((prev_counter * 0x2492492492492493) >> 0x40) & MAX_64_BIT_VALUE
		counter = (prev_counter - aux_value) & MAX_64_BIT_VALUE
		counter = counter >> 1
		counter = (counter + aux_value) & MAX_64_BIT_VALUE
		counter = counter >> 2
		counter = (counter * 0x7) & MAX_64_BIT_VALUE
		counter = (prev_counter - counter) & MAX_64_BIT_VALUE
		
	return source

encoded_data_1 = bytearray([0x7F, 0x5D, 0x22, 0x2C, 0x55, 0x07, 0x10, 0x53, 0x10, 0x0D, 0x27, 0x6F, 0x10, 0x07, 0x48, 0x02, 0x13, 0x48, 0x0E, 0x35, 0x17, 0x5A, 0x14, 0x50, 0x1F, 0x50, 0x05, 0x74])
encoded_data_2 = bytearray([0x5F, 0x01, 0x0D, 0x7B])
encoded_data_3 = bytearray([0x60, 0x3B, 0x50, 0x27, 0x74, 0x1D, 0x07, 0x45, 0x14, 0x13, 0x4C, 0x0E, 0x2F, 0x36, 0x3C])

print(decode_data(encoded_data_1))
print(decode_data(encoded_data_2))
print(decode_data(encoded_data_3))