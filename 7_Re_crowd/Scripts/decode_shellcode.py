def decode_shellcode():
	encoded_bytes = read_alphanumeric_shellcode()
	length = int(len(encoded_bytes) / 2)
	decoded_bytes = bytearray()
	for i in range(length):
		block = encoded_bytes[i*2:i*2+2]
		decoded_byte_low = ord(block[1]) & 0x0F
		decoded_byte_high = ((ord(block[1]) >> 4) + (ord(block[0]) & 0x0F)) & 0x0F
		decoded_byte = decoded_byte_low + (decoded_byte_high <<4)
		decoded_bytes.append(decoded_byte)

	save_shellcode(decoded_bytes)

def read_alphanumeric_shellcode():
	shellcode = ""
	with open("shellcode.bin", "r") as shellcode_file:
		letter = shellcode_file.read(1)
		while letter:
			shellcode += letter
			letter = shellcode_file.read(1)

	return shellcode

def save_shellcode(decoded_bytes):
	decoded_file = open("decoded_shellcode.bin", "wb")
	decoded_file.write(decoded_bytes)

decode_shellcode()