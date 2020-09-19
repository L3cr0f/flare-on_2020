# TODO ARREGLAR EBX

MAX_VALUE = 0xFFFFFFFF

SCORE = 0x128

# 0 = down
# 1 = up
KEY = [
	0, 0, 1, 1, 0, 0, 0, 1,
	0, 1, 1, 1, 0, 1, 0, 0,
	0, 1, 0, 1, 1, 1, 1, 1,
	0, 1, 1, 0, 1, 0, 0, 1,
	0, 0, 1, 1, 0, 1, 0, 1,
	0, 1, 0, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 0, 1, 1, 1,
	0, 1, 0, 0, 0, 1, 0, 1,
	0, 1, 1, 0, 0, 1, 0, 0,
	0, 1, 1, 0, 1, 1, 1, 0,
	0, 0, 1, 1, 0, 0, 1, 1,
	0, 1, 1, 1, 0, 0, 1, 1,
	0, 1, 1, 0, 0, 1, 0, 0,
	0, 0, 1, 1, 0, 1, 0, 0,
	0, 1, 1, 1, 1, 0, 0, 1,
	0, 1, 0, 1, 1, 1, 1, 1,
	0, 1, 1, 0, 1, 1, 0, 1,
	0, 1, 0, 1, 1, 0, 0, 1,
	0, 1, 0, 1, 1, 1, 1, 1,
	0, 1, 0, 0, 0, 1, 0, 0,
	0, 1, 1, 1, 0, 1, 0, 1,
	0, 1, 1, 0, 0, 1, 0, 0,
	0, 0, 1, 1, 0, 0, 1, 1,
	0, 1, 1, 1, 0, 0, 1, 1,
	0, 1, 0, 0, 0, 0, 0, 0,
	0, 1, 1, 0, 0, 1, 1, 0,
	0, 1, 1, 0, 1, 1, 0, 0,
	0, 1, 1, 0, 0, 0, 0, 1,
	0, 1, 1, 1, 0, 0, 1, 0,
	0, 1, 1, 0, 0, 1, 0, 1,
	0, 0, 1, 0, 1, 1, 0, 1,
	0, 1, 1, 0, 1, 1, 1, 1,
	0, 1, 1, 0, 1, 1, 1, 0,
	0, 0, 1, 0, 1, 1, 1, 0,
	0, 1, 1, 0, 0, 0, 1, 1,
	0, 1, 1, 0, 1, 1, 1, 1,
	0, 1, 1, 0, 1, 1, 0, 1
]

def sign_extend(value, bits):
    sign_bit = 1 << (bits - 1)
    return (value & (sign_bit - 1)) - (value & sign_bit)

def tohex(val, nbits):
  return (val + (1 << nbits)) % (1 << nbits)

def get_flag(score):
	final_string = ""
	EBX = 0
	EBP = 0
	ESI = 0
	while ESI < score:
		EBX = (EBX & 0xFF) | (KEY[EBP])
		ESI = 1
		if EBP != 0:
			ESI = EBP + 1
			if ESI % 8 == 0:
				EBP = sign_extend(EBX, 8)
				EBX = 0
				final_string = final_string + chr(EBP)
			else:
				EBX = sign_extend(EBX, 8)
				EDX = EBX + EBX
				EBX = EDX
				# TODO para que sirve
				EDX = (EDX - sign_extend(0xFFFFFF80, 32)) & MAX_VALUE
		else:
			EBX = sign_extend(EBX, 8)
			EDX = EBX + EBX
			EBX = EDX
			# TODO para que sirve
			EDX = (EDX - 0xFFFFFF80) & MAX_VALUE
		EBP = ESI

	return final_string

print(get_flag(SCORE))