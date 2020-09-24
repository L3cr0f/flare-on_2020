encoded_password = bytearray([62, 38, 63, 63, 54, 39, 59, 50, 39])

decryption_key = 83

password = ""

for encoded_char in encoded_password:
	password = password + chr((decryption_key ^ encoded_char))

print("The decrypted password is: " + password)