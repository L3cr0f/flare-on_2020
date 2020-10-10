import idautils
import string
import ida_bytes

# Max values
MAX_BYTE_VALUE = 0xFF
MAX_32_BIT_VALUE = 0xFFFFFFFF
MAX_64_BIT_VALUE = 0xFFFFFFFFFFFFFFFF

# Address memory limit to go backwards from an xref address of the 0x00064479 function
LIMIT = 0x20

# Decryption function address
DECRYPT_UNK_ADDRESS = 0x140001CA8

# Decryption constant
DECRYPTION_NUMBER = 0x4

# Array to store patched addresses to no patch them twice
patched_addresses = []


# Converts big endian value to little endian
def big_endian_to_little_endian_array(value):
	return [
		value & 0x000000FF,
		(value & 0x0000FF00) >> 0x8,
		(value & 0x00FF0000) >> 0x10,
		value >> 0x18
	]


# Checks if a value is hexadecimal (IDA Pro notation: 47A1C9h)
def check_if_hex(operand):
	return all(c in string.hexdigits for c in operand[0:-1]) and operand[-1] == "h"

def decode_data(encoded_data):
	key = bytearray([0x3C, 0x67, 0x7E, 0x7B, 0x3C, 0x69, 0x74])
	source = bytearray()
	encoded_data_size = len(encoded_data)
	counter = 0

	for byte in encoded_data:
		decoded_byte = (key[counter & MAX_32_BIT_VALUE] & MAX_BYTE_VALUE) ^ byte
		source.append(decoded_byte)
		prev_counter = counter + 1
		aux_value = ((prev_counter * 0x2492492492492493) >> 0x40) & MAX_64_BIT_VALUE
		counter = (prev_counter - aux_value) & MAX_64_BIT_VALUE
		counter = counter >> 1
		counter = (counter + aux_value) & MAX_64_BIT_VALUE
		counter = counter >> 2
		counter = (counter * 0x7) & MAX_64_BIT_VALUE
		counter = (prev_counter - counter) & MAX_64_BIT_VALUE
		
	return source


# Get the value of "lea" instructions as integer to avoid python from adding the letter "L" (eg: 0xf78dd431L)
def get_value_from_lea_instruction(instr_address):
	instruction_bytes = get_bytes(instr_address, ItemSize(instr_address))
	value = 0
	for index in range(3, ItemSize(instr_address)):
		value = value + (ord(instruction_bytes[index]) << (0x8 * (index - 3)))

	return value + instr_address + 7

# Get the value of "mov" instructions as integer to avoid python from adding the letter "L" (eg: 0xf78dd431L)
def get_value_from_mov_instruction(instr_address):
	instruction_bytes = get_bytes(instr_address, ItemSize(instr_address))
	value = 0
	for index in range(1, ItemSize(instr_address)):
		value = value + (ord(instruction_bytes[index]) << (0x8 * (index - 1)))

	return value


# Gets the vale of a registry going backwards in a recursive way
# Get the value of EDX:
#	mov ecx, 1ah
#	mov edx, ecx
#	mov ebx, edx
def get_value_from_register(initial_instr_address, register):
	register_value = 0

	# Gets the instruction set from the current address minus 0x100 to the current address
	instructions = reversed(list(Heads(initial_instr_address - LIMIT, initial_instr_address)))
	for instr_address in instructions:
		# If the instruction is a "mov" plus the register we are looking for
		# Eg: expected register = "ECX" -> mov ecx, ANY
		if GetMnem(instr_address) == "mov" and GetOpnd(instr_address, 0) == register:
			operand = GetOpnd(instr_address, 1)
			if "offset" in operand or check_if_hex(operand) or operand.isdigit:
				# Get the value
				register_value = get_value_from_mov_instruction(instr_address)
			else:
				# Look for recursively
				register_value = get_value_from_register(instr_address, GetOpnd(instr_address, 1))
			break

	return register_value


# Gets the address of the buffer to decrypt and its associated data (IV and size)
def get_decryption_data(xref_address):
	encrypted_buffer_address = "0"
	buffer_size = 0

	push_counter = 0

	instructions = reversed(list(Heads(xref_address - LIMIT, xref_address)))
	for instr_address in instructions:
		# If the values have not been found
		if encrypted_buffer_address == "0" or buffer_size == 0:
			# If the instruction is a "mov" plus the register in the destination operand is "ecx"
			# and the buffer address has not been found yet, we get this value
			if GetMnem(instr_address) == "lea" and GetOpnd(instr_address, 0) == "rcx" and encrypted_buffer_address == "0":
 				encrypted_buffer_address = get_value_from_lea_instruction(instr_address)
			elif GetMnem(instr_address) == "lea" and GetOpnd(instr_address, 0) == "edx" and buffer_size == 0:
				operand = GetOpnd(instr_address, 1)
				if "r8" in operand:
					buffer_size = ida_bytes.get_byte(instr_address + 3)
				else:
					buffer_size = ida_bytes.get_byte(instr_address + 2)
			# If the instruction is a "mov" plus the register in the destination operand is "edx"
			# and the buffer size has not been found yet, we get this value
			elif GetMnem(instr_address) == "mov" and GetOpnd(instr_address, 0) == "edx" and buffer_size == 0:
				operand = GetOpnd(instr_address, 0)
 				# If the operand of the instruction is a digit or an hex value, it is the size
				if check_if_hex(operand) or operand.isdigit:
					buffer_size = get_value_from_mov_instruction(instr_address)
 				# If not, we look for the value in a recursive way
				else:
					buffer_size = get_value_from_register(instr_address, GetOpnd(instr_address, 1))
			# If the buffer size could not be obtained, we set it to 1, since it is real value in the binary
			elif GetMnem(instr_address) == "inc" and GetOpnd(instr_address, 0) == "edx" and buffer_size == 0:
				buffer_size = 1
		# If all values has been found, we stop the search
		else:
			break

	decryption_data = {
		"encrypted_buffer_address": str(encrypted_buffer_address),
		"buffer_size": str(buffer_size)
	}

	return decryption_data


# Patches the unkwown buffer bytes with the decrypted buffer bytes and converts it to an ASCII string,
# also, to not patch twice the same buffer, we add its address to an array that we check prior patching any buffer
def patch_encrypted_buffer(encrypted_buffer_address, decrypted_buffer):
	if (encrypted_buffer_address not in patched_addresses):
		for index in range(0, len(decrypted_buffer)):
			ida_bytes.patch_byte(encrypted_buffer_address + index, decrypted_buffer[index])
		MakeStr(encrypted_buffer_address, encrypted_buffer_address + len(decrypted_buffer))
		patched_addresses.append(encrypted_buffer_address)


# Main function

print("Decrypting strings...")

# Gets all xrefs from the decryption function (0x00064479 in our case)
xrefs_dec_unk = XrefsTo(DECRYPT_UNK_ADDRESS, 0)
for xref in xrefs_dec_unk:
	decryption_data = get_decryption_data(xref.frm)

	buffer_size = int(decryption_data["buffer_size"], 10)

	encrypted_buffer_address = int(decryption_data["encrypted_buffer_address"], 10)
	print(buffer_size)
	if encrypted_buffer_address != 0:
		encrypted_buffer = bytearray(get_bytes(encrypted_buffer_address, buffer_size))

		decrypted_buffer = decode_data(encrypted_buffer)

		patch_encrypted_buffer(encrypted_buffer_address, decrypted_buffer)
	else:
		print("Some strings could not be decrypted!")
	
print("Strings decrypted!")
