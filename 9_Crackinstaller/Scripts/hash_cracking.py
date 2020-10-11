import os
import sys

hashes = [
	0x490A231A,
	0x34262863,
	0x1128974,
	0xE2A9259B,
	0xCF424038,
	0xCE968D51,
	0xB40D00D9,
	0xA95BE347
]


MAX_VALUE = 0xFFFFFFFF
INT_BITS = 32

# Right rotate of bits
def rotr(num, bits):
	return ((num >> bits)|(num << (INT_BITS - bits))) & MAX_VALUE

def get_hash(function_name):
	result = 0
	counter = 0
	while counter < len(function_name):
		result = (rotr(result, 0xE) + ord(function_name[counter])) & MAX_VALUE
		counter = counter + 1

	# It checks the end of string (0x00) after applying one last ROR operation
	result = rotr(result, 0xE)
	
	return result

def check_hash(function_name, hash_value):
	return get_hash(function_name) == hash_value

# Reads the file
def read_file(file):
	for hash_value in hashes:
		found = False
		with open(file, "r") as wordlist:
			function_name = wordlist.readline().rstrip('\n')
			while function_name and not found:
				found = check_hash(function_name, hash_value)
				if not found:
					function_name = wordlist.readline().rstrip('\n')

			if found:
				print("Occurrence found! The decrypted hash " + hex(hash_value) + " is: " + function_name)
			else:
				print("No occurrence found for hash " + hex(hash_value) + "!")

# Gets file from args
def get_file_from_args():
	if len(sys.argv) == 2:
		filename = sys.argv[1]
		if os.path.exists(filename):
			return filename

file = get_file_from_args()
if file:
	read_file(file)
else:
	print("Please provide a wordlist")