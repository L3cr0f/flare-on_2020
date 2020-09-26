import fileinput

def replace_string(text_to_search, replacement_text):
	with open('codeit.txt', 'r', encoding="utf-8") as file :
	  filedata = file.read()

	filedata = filedata.replace(text_to_search, replacement_text)

	with open('codeit.txt', 'w', encoding="utf-8") as file:
	  file.write(filedata)

def read_and_replace():
	with open("global_replacements.txt", "r", encoding="utf-8") as replacements_file:
		line = replacements_file.readline().rstrip('\n')
		while line:
			replacement_data = line.split(",")
			replace_string(replacement_data[0], replacement_data[1])
			line = replacements_file.readline().rstrip('\n')

read_and_replace()