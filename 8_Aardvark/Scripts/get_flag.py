MAX_BYTE_VALUE = 0xFF

def print_bytearray(data):
	for byte in data:
		print(hex(byte) + " ", end="")
	print()

def encoded_data_initialization(encoded_data):
	for counter in range(len(encoded_data)):
		encoded_data[counter] = encoded_data[counter] ^ 0x4F

def decode_data_modules_mnt(encoded_data, string):
	global global_counter
	
	for char in string:
		encoded_data[global_counter] = encoded_data[global_counter] ^ ord(char)
		global_counter = (global_counter + 1) & 0xF

def decode_data_version_signature(encoded_data, string):
	global global_counter
	
	for counter in range(9):
		encoded_data[global_counter] = encoded_data[global_counter] ^ ord(string[counter])
		global_counter = (global_counter + 1) & 0xF

def decode_data_elf_pheader_vaddr_proc_lxstat(encoded_data, value):
	global global_counter
	
	while value != 0:
		encoded_data[global_counter] = encoded_data[global_counter] ^ (value & MAX_BYTE_VALUE)
		value = value >> 0x8
		global_counter = (global_counter + 1) & 0xF
# Ubuntu
def read_mnt(encoded_data):
	with open("proc_mnt.txt","r") as mnt_file:
		lines = mnt_file.read().splitlines()
		for line in lines:
			splitted_line = line.split(" ")
			if splitted_line[1] == "/":
				if splitted_line[2][0] != "f":
					for i in range(1, len(splitted_line[2])):
						if splitted_line[2][i] == "f":
							decode_data_modules_mnt(encoded_data, splitted_line[2][i:])
							break

# Ubuntu
def read_version_signature(encoded_data):
	with open("version_signature.txt","r") as mnt_file:
		line = mnt_file.readline()
		decode_data_version_signature(encoded_data, line)


def read_elf_pheader_vaddr(encoded_data):
	vaddr_values = [0x40, 0x238, 0x0, 0x201D28, 0x201D38, 0x254, 0x16B0, 0x0, 0x201D28]

	for vaddr in vaddr_values:
		value = vaddr >> 0x10
		if value != 0:
			decode_data_elf_pheader_vaddr_proc_lxstat(encoded_data, value)

# Debian
def read_proc_lxstat(encoded_data):
	inode_values = [4026532059, 4026531844, 4026532112, 4026532024, 4026532000, 4026531996, 4026532019, 4026532056, 4026532023, 4026532011, 4026532064, 4026532114, 4026531843, 4026532020, 4026531858, 4026531855, 4026532012, 4026532014, 4026532015, 4026532055, 4026532017, 4026532018, 4026532060, 4026532021, 4026532013, 4026532061, 4026532022, 4026531859, 4026531856, 4026532062, 4026532115, 4026532113, 4026531997, 4026532016, 4026532025, 4026532026, 4026532116, 4026532058, 4026532054, 4026532065, 4026532027, 4026532057, 4026532063, 4026531857, 4026531841, 4026531842]

	for inode in inode_values:
		value = inode >> 0x10
		if value != 0:
			decode_data_elf_pheader_vaddr_proc_lxstat(encoded_data, value)

def return_flag(data):
	return data.decode("unicode_escape") + "@flare-on.com"

global_counter = 0
encoded_data = bytearray([0x4A, 0x82, 0x43, 0xAB, 0x95, 0xED, 0x8F, 0x7E, 0x9C, 0xBC, 0xAD, 0x84, 0x17, 0x91, 0x06, 0x15])

encoded_data_initialization(encoded_data)
#decode_data_modules_mnt(encoded_data, "cpufreq_")
read_mnt(encoded_data)
read_version_signature(encoded_data)
read_elf_pheader_vaddr(encoded_data)
#read_proc_lxstat(encoded_data)
print(return_flag(encoded_data))