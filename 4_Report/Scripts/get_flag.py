FILE_SIZE = 0x45C21

def get_key(string):
	n = len(string)
	key = bytearray(n)
	for i in range(n):
		key[(n - 1) - i] = ord(string[i])
	return key


def decrypt_file(initial_offset):
	key = get_key("FLARE-ON")

	counter = 0
	counter_four = 0
	decrypted_bytes = bytearray()
	with open("encrypted_data.txt", "r") as encrypted_file:
		encrypted_file.seek(initial_offset + counter_four)
		encrypted_data = encrypted_file.read(2)
		while encrypted_data and counter < FILE_SIZE:
			offset = initial_offset + counter_four
			decrypted_byte = int(encrypted_data, 16) ^ key[counter % len(key)]
			decrypted_bytes.append(decrypted_byte)
	
			counter = counter + 1
			counter_four = counter_four + 4
			encrypted_file.seek(initial_offset + counter_four)
			encrypted_data = encrypted_file.read(2)

	save_decrypted_file(decrypted_bytes)

def save_decrypted_file(decrypted_bytes):
	decrypted_file = open("decrypted_file.png", "wb")
	decrypted_file.write(decrypted_bytes)

decrypt_file(2)
