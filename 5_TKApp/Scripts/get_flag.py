import hashlib
from Crypto.Cipher import AES
import base64

password = "mullethat"
note = "keep steaks for dinner"
step = "magic"
desc = "water"

text = [
	desc[2],
	password[6],
	password[4],
	note[4],
	note[0],
	note[17],
	note[18],
	note[16],
	note[11],
	note[13],
	note[12],
	note[15],
	step[4],
	password[6],
	desc[1],
	password[2],
	password[2],
	password[4],
	note[18],
	step[2],
	password[4],
	note[5],
	note[4],
	desc[0],
	desc[3],
	note[15],
	note[8],
	desc[4],
	desc[3],
	note[4],
	step[2],
	note[13],
	note[18],
	note[18],
	note[8],
	note[4],
	password[0],
	password[7],
	note[0],
	password[4],
	note[11],
	password[6],
	password[4],
	desc[4],
	desc[3]
]

key = hashlib.sha256("".join(text).encode("UTF-8")).digest()
iv = b"NoSaltOfTheEarth"

encrypted_file = open("Runtime.dll", "rb")
encrypted_data = encrypted_file.read()

cipher = AES.new(key, AES.MODE_CBC, iv=iv)
decrypted_data = cipher.decrypt(encrypted_data)

data = base64.b64decode(decrypted_data)

decrypted_file = open("decrypted_file.jpg", "wb")
decrypted_file.write(data)

