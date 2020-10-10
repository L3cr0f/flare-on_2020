def write_binary_file(decoded_data):
	decoded_file = open("decoded_binary.bin", "wb")
	decoded_file.write(decoded_data)

def decode_encoded_data():
	key = bytearray([0x08, 0x67, 0x53, 0x09])
	decoded_data = bytearray()
	counter = 0
	with open("encoded_binary.bin", "rb") as encrypted_file:
		encrypted_byte = encrypted_file.read(1)
		while encrypted_byte:
			decrypted_byte = int.from_bytes(encrypted_byte, byteorder="big") ^ key[counter]
			decoded_data.append(decrypted_byte)
			counter = (counter + 1) & 3
			encrypted_byte = encrypted_file.read(1)

	write_binary_file(decoded_data)

decode_encoded_data()