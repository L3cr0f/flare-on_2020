import os
import sys

hashes = [
	0x726774C,
	0x6B8029,
	0xE0DF0FEA,
	0x6174A599,
	0x56A2B5F0,
	0x5FC8D902,
	0xE553A458
]

MAX_VALUE = 0xFFFFFFFF
INT_BITS = 32

# Right rotate of bits
def rotr(num, bits):
	return ((num >> bits)|(num << (INT_BITS - bits))) & MAX_VALUE

def get_hash(name):
	result = 0
	counter = 0
	while counter < len(name):
		result = (rotr(result, 0xD) + ord(name[counter])) & MAX_VALUE
		counter = counter + 1

	return result

def check_hash(lib_hash, symbol_name, hash_value):
	return (lib_hash + get_hash(symbol_name)) & MAX_VALUE == hash_value

def format_symbol_name(symbol_name):
	return symbol_name + "\x00"

def format_lib_name(lib_name):
	lib_name = lib_name.upper()
	return "\x00" + "\x00".join([lib_name[i:i+1] for i in range(0, len(lib_name), 1)]) + "\x00\x00\x00"

# Reads the file
def read_file(file, lib_name):
	lib_hash = get_hash(format_lib_name(lib_name))
	for hash_value in hashes:
		found = False
		with open(file, "r") as wordlist:
			symbol_name = wordlist.readline().rstrip('\n')
			while symbol_name and not found:
				found = check_hash(lib_hash, format_symbol_name(symbol_name), hash_value)
				if not found:
					symbol_name = wordlist.readline().rstrip('\n')

			if found:
				print("Occurrence found! The decrypted hash " + hex(hash_value) + " is: " + symbol_name)
			else:
				print("No occurrence found for hash " + hex(hash_value) + "!")

# Gets file from args
def get_file_from_args():
	if len(sys.argv) > 2:
		filename = sys.argv[1]
		if os.path.exists(filename):
			return filename

# Gets DLL name from args
def get_lib_name_from_args():
	if len(sys.argv) == 3:
		return sys.argv[2]

file = get_file_from_args()
lib_name = get_lib_name_from_args()
if file and lib_name:
	read_file(file, lib_name)
else:
	print("Usage:")
	print("python3 " + argv[0] + " <wordlist> <dll name>")