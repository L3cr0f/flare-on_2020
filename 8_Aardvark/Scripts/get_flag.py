

def encoded_data_initialization(encoded_data):
	init_encoded_data = bytearray()
	for byte in encoded_data:
		init_encoded_data.append(byte ^ 0x4F)

	return init_encoded_data

def decode_data_mnt(encoded_data, string):
	global global_counter
	
	for counter in range(len(string)):
		encoded_data[global_counter] = encoded_data[counter] ^ ord(string[counter])
		global_counter = global_counter + 1
		global_counter = global_counter & 0xF

	return encoded_data

def decode_data_version_signature(encoded_data, string):
	global global_counter
	
	for counter in range(9):
		encoded_data[global_counter] = encoded_data[counter] ^ ord(string[counter])
		global_counter = global_counter + 1
		global_counter = global_counter & 0xF

	return encoded_data

def read_mnt(encoded_data):
	with open("proc_mnt.txt","r") as mnt_file:
		lines = mnt_file.read().splitlines()
		for line in lines:
			splitted_line = line.split(" ")
			if splitted_line[1] == "/":
				if splitted_line[2][0] != "f":
					for i in range(1, len(splitted_line[2])):
						if splitted_line[2][i] == "f":
							encoded_data = decode_data_mnt(encoded_data, splitted_line[2][i:])
							break
	return encoded_data

def read_version_signature(encoded_data):
	with open("version_signature.txt","r") as mnt_file:
		line = mnt_file.readline()
		encoded_data = decode_data_version_signature(encoded_data, line)

	return encoded_data

def return_flag(data):
	return data.decode("UTF-8") + "@flare-on.com"

global_counter = 0
encoded_data = bytearray([0x4A, 0x82, 0x43, 0xAB, 0x95, 0xED, 0x8F, 0x7E, 0x9C, 0xBC, 0xAD, 0x84, 0x17, 0x91, 0x06, 0x15])
buffer = bytearray([0x48, 0xB8, 0x4F, 0x20, 0x77, 0x69, 0x6E, 0x73, 0x21, 0x0A])

encoded_data = read_mnt(encoded_data)
encoded_data = read_version_signature(encoded_data)
print(return_flag(data))

# TODO chdir /proc decoding