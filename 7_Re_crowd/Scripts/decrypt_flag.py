MAX_BYTE_VALUE = 0xFF

def get_xor_value(encryption_buffer):
	cl = encryption_buffer[0x100]
	bl = encryption_buffer[0x101]
	cl = (cl + 1) & MAX_BYTE_VALUE
	al = encryption_buffer[cl]
	bl = (bl + al) & MAX_BYTE_VALUE
	encryption_buffer[0x100] = cl
	encryption_buffer[0x101] = bl
	var_3 = encryption_buffer[bl]
	var_4 = encryption_buffer[cl]
	encryption_buffer[bl] = var_4
	encryption_buffer[cl] = var_3
	cl = encryption_buffer[bl]
	al = (var_3 + cl) & MAX_BYTE_VALUE
	result = encryption_buffer[al]

	return result

def decrypt_data(encrypted_data, encryption_buffer):
	decrypted_data = ""
	for byte in encrypted_data:
		decrypted_data = decrypted_data + chr(byte ^ get_xor_value(encryption_buffer))

	return decrypted_data

encrypted_data = bytearray([0x43, 0x66, 0x57, 0x83, 0xa5, 0x23, 0x89, 0x77, 0xbe, 0xac, 0x1b, 0x1f, 0x87, 0x8f, 0x58, 0x93, 0x3f, 0x24, 0xcf, 0x2c, 0xd3, 0x9a, 0xa8, 0xd1, 0x11, 0xc4, 0xbc, 0xa6, 0x7f, 0xcd, 0x38, 0xdb, 0xb3, 0x3c, 0x03, 0x4b, 0xab, 0xf5, 0x60, 0xc5, 0x60, 0xd2, 0x0d, 0x1d, 0x18, 0x88, 0x41, 0x5b, 0x4f, 0x06, 0x17, 0x6c, 0x9e, 0x0b, 0x01, 0x73, 0x9d, 0x83, 0x60, 0x18, 0xfa, 0x8b, 0xff, 0xf8, 0x4d, 0x78, 0xb2, 0xa4, 0x24, 0x6f, 0xae, 0xbd, 0x92, 0xd1, 0xec, 0xcc, 0x2d, 0x7c, 0x8b, 0xbf, 0xd0, 0x8c, 0xbd, 0xe2, 0x45, 0xef, 0x15, 0xb2, 0x88, 0xbc, 0xa4, 0x59, 0xbe, 0x20, 0xac, 0xf9, 0x57, 0xdf, 0x10, 0xba, 0xbc, 0xd9, 0x11, 0x93, 0x41, 0x19, 0x00, 0x9c, 0x02, 0x25, 0xef, 0xc4, 0x4a, 0x26, 0xfd, 0x25, 0xca, 0x9b, 0x85, 0x19, 0x64, 0x4e, 0xc5, 0x84, 0x9f, 0xa1, 0x00, 0x18, 0x2c, 0x68, 0x30, 0xdc, 0x70, 0x4c, 0xfe, 0x83, 0xf1, 0xc7, 0x00, 0x2b, 0x49, 0x7a, 0x83, 0x09, 0x05, 0x77, 0x6e, 0x0a, 0x08, 0x8d, 0x56, 0xe4, 0x38, 0x7e, 0x88, 0x0f, 0x2c, 0x41, 0xe4, 0x33, 0x66, 0xc9, 0xbc, 0x06, 0xaa, 0x2a, 0xa1, 0x96, 0x2d, 0x94, 0xc0, 0x08, 0x16, 0x1e, 0xa4, 0xf2, 0x81, 0x1a, 0x83, 0xf7, 0x7c, 0xb5, 0x7d, 0x63, 0x13, 0x00, 0x41, 0x96, 0xca, 0x69, 0x80, 0xae, 0x49, 0xe9, 0x5d, 0x0f, 0x7d, 0x89, 0x43, 0xd4, 0x89, 0x1a, 0x01, 0xb4, 0x61, 0x61, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
encryption_buffer = bytearray([0xDB, 0xBD, 0x4E, 0xAA, 0x9F, 0x01, 0xE3, 0xE5, 0x0F, 0xA0, 0xC8, 0x44, 0xBF, 0x87, 0xA8, 0x34, 0xAC, 0x79, 0x82, 0x20, 0x98, 0x5F, 0x86, 0x91, 0x95, 0x1D, 0x9B, 0xFA, 0x39, 0x3F, 0x21, 0x51, 0x3E, 0x52, 0xAB, 0x46, 0xFF, 0x2F, 0xFE, 0x8E, 0xDD, 0xC1, 0x41, 0x70, 0x61, 0x36, 0x89, 0x57, 0xB6, 0x55, 0x4D, 0x78, 0xF0, 0x83, 0xF7, 0xD6, 0x73, 0x60, 0x0C, 0x5E, 0xC9, 0xA5, 0xEC, 0x50, 0x80, 0x4F, 0x71, 0x29, 0xB1, 0x14, 0x92, 0x45, 0x68, 0xC7, 0xED, 0xDC, 0x99, 0x9A, 0xE6, 0xF4, 0xD1, 0xEF, 0x75, 0x31, 0x59, 0xEE, 0x17, 0xD5, 0x94, 0xA7, 0x5C, 0x33, 0x9C, 0xF8, 0x3D, 0x25, 0xB4, 0xA6, 0x6C, 0x7B, 0xD8, 0xD4, 0xFC, 0x77, 0xCA, 0x30, 0xF3, 0x11, 0x66, 0xCF, 0x03, 0xF6, 0x12, 0x13, 0x32, 0x28, 0x69, 0x8A, 0x54, 0x40, 0x90, 0x22, 0xFB, 0xB3, 0x93, 0x7D, 0xCC, 0x67, 0xF9, 0xE9, 0x65, 0x07, 0xB2, 0x3A, 0xCB, 0x35, 0x26, 0x5B, 0x47, 0xB5, 0x2C, 0x2A, 0xB7, 0x56, 0xD0, 0xBA, 0x09, 0x23, 0x8F, 0x3C, 0x64, 0xD7, 0xB8, 0xA3, 0x06, 0x9D, 0x37, 0xE1, 0x6A, 0x8C, 0x5A, 0xDF, 0xEA, 0xE7, 0xD3, 0xDA, 0xC6, 0x1E, 0x43, 0xEB, 0xC3, 0xF5, 0x04, 0x53, 0x48, 0x49, 0x6F, 0x3B, 0xC2, 0xC0, 0xAD, 0x4B, 0x1A, 0x27, 0x88, 0x85, 0xAF, 0xBC, 0xE0, 0x96, 0x42, 0x4A, 0x5D, 0x16, 0x02, 0xC5, 0x2D, 0x76, 0x1C, 0x7C, 0x8B, 0x63, 0xB0, 0x58, 0xFD, 0x0E, 0x00, 0x74, 0xD2, 0x0B, 0x7F, 0x72, 0xA4, 0xCE, 0x7E, 0x6B, 0xA1, 0x15, 0xA2, 0x2B, 0xE4, 0x6E, 0xA9, 0x4C, 0x97, 0x19, 0x81, 0x10, 0x62, 0x18, 0xAE, 0xF1, 0xF2, 0xD9, 0x0A, 0x1B, 0x1F, 0x9E, 0xE8, 0xCD, 0xDE, 0xBB, 0x8D, 0x6D, 0x0D, 0x2E, 0xBE, 0xC4, 0xB9, 0xE2, 0x7A, 0x24, 0x05, 0x08, 0x84, 0x38, 0x00, 0x00])

print(decrypt_data(encrypted_data, encryption_buffer))