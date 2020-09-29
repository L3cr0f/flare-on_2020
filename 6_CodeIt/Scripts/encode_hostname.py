def encode_buffer(buffer):
	file = open("fzajhccetyiiltfl.bmp", "rb")
	# The first 54 bytes are discarded, which represent the BMP header
	file.seek(0x36)
	file_buffer = file.read()
	encoded_buffer = ""
	counter = 0
	for i in range(len(buffer)):
		byte_buffer = buffer[i]
		for j in range(6, -1, -1):
			byte_buffer = byte_buffer + ((file_buffer[counter] & 0x1) << (0x1 * j))
			counter = counter + 1
		encoded_buffer = encoded_buffer + chr((byte_buffer >> 0x1) + ((byte_buffer & 0x1) << 0x7))

	return encoded_buffer

hostname = b"aut01tfan1999"

result = encode_buffer(hostname.lower())
print(result)