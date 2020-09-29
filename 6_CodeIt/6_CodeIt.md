# 6 - CodeIt

## Description

Reverse engineer this little compiled script to figure out what you need to do to make it give you the flag (as a QR code).

## Walkthrough

When we open this binary in a tool such as _PEview_ we can see that is packed using _UPX_, so we need to unpack it prior analyzing.

```
C:\> upx -d codeit.exe -o codeit_unpacked.exe
```

To load it in _IDA Pro_ we need to select _Manual Load_ and select _0x00400000_ as preferred _Image Base_, if we do not do so, we will see how it is loaded whatever it considers and thus, it will not be properly analyzed.

However, if we run it, the sample will be loaded at a random address, which will cause that the fixed memory addresses will cause memory corruption accesses.

To solve this, we have to disable the _IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE_ of the _DLL Characteristics_ field of the _PE Optional Header_ so as to remove _ASRL_. This can be done using _CFF Explorer_.

![CodeIt 1](Images/codeit_1.png)

Now, we can execute the sample and also debug it, but... An error message telling us "This is a third-party compiled AutoIt 
script." will be prompted.

So now we know it has been coded using _AutoIt_, which can be decompiled using the _Exe2Aut_ utility.

The resulting file is a completely executable file of _AutoIt_ source code (similar to _Basic_ language), wich can be executed using the _AutoIt_ engine.

However, these steps could be simplified by executing the _Exe2Aut_ utility with the original binary.

Once we have the source code of the sample, we will see that it is heavily obfuscated, something that will hinder the analysis.

To deobfuscated, we replaced all the names of the numeric variables using a _Python_ script (it con be found under "Scripts/find_replace.py"). This gives us a better understanding of the program.

Another improvement was printing the different strings of the program once they have been decoded. The code to do so is as follows:

```
Func write_file_aux()
    ; Create a constant variable in Local scope of the filepath that will be read/written to.
    Local Const $sFilePath = "aux_file.txt"

    ; Open the file for writing (append to the end of a file) and store the handle to a variable.
    Local $hFileOpen = FileOpen($sFilePath, $FO_APPEND)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
        Return False
    EndIf

    $counter = 0
    For $element in $os
	  FileWrite($hFileOpen, $counter & " - ")
	  FileWrite($hFileOpen, decode_string($element) & @CRLF)
	  $counter = $counter + 1
    Next

    ; Close the handle returned by FileOpen.
    FileClose($hFileOpen)
EndFunc
```

Now, when we find the following sentence:

```
Local $flhvhgvtxm = DllCall(decode_string($os[$number_25]), decode_string($os[$number_26]), decode_string($os[$number_156]), decode_string($os[$number_28]), $fldiapcptm)
```

We can translate it as follows:

```
Local $flhvhgvtxm = DllCall("kernel32.dll", "int", "CloseHandle", "ptr", $fldiapcptm)
```

The whole decoded strings are stored under "Data/decoded_strings.txt".

After analyzing the whole file, we have made several changes to it to make easier the "flag hunting process", all these changes can be seen in the file at "Data/codeit.au3".

To get the flag, we see how the function that we have called _modify_qr_code_ is called using the previous generated the _QR_ code, which suggest us that the app will modify it to show the expected _QR_ code.

```
# Main

	Local $qr_code_struct = DllStructCreate(decode_string($os[$number_135]))
	# justGenerateQRSymbol
	Local $dll_call_result = DllCall($dll_filename, decode_string($os[$number_136]), decode_string($os[$number_137]), decode_string($os[$number_39]), $qr_code_struct, decode_string($os[$number_138]), $input_text)
	If $dll_call_result[$number_0] <> $number_0 Then
		modify_qr_code($qr_code_struct)
```

This function will do the following:
	- Reading the hostname.
	- Lower case the hostname.
	- Encode the computer name.
	- Hash the encoded computer name using _SHA256_.
	- Use this _SHA256_ hash as a key to decrypt some data using _RSA_.
	- Compare the first and the bytes of the decrypted data with "FLARE" and "ERALF" strings to check that the decryption process has been succesful.
	- Use the decrypted data to modify the _QR_ code.

The first idea that comes up is brute-forcing the data, but this won't be possible. So only one thing can be done, analyzing the encoding routine of the hostname.

To better understand the process, we have developed the following _Python_ script:

```
def encode_buffer(buffer):
	file = open("fzajhccetyiiltfl.bmp", "rb")
	# The first 54 bytes are discarded, which represent the BMP header
	file.seek(0x36)
	file_buffer = file.read()
	encoded_buffer = ""
	counter = 0
	for i in range(len(buffer)):
		byte_buffer = buffer[i]
		for j in range(6, -1, -1):
			byte_buffer = byte_buffer + ((file_buffer[counter] & 0x1) << (0x1 * j))
			counter = counter + 1
		encoded_buffer = encoded_buffer + chr((byte_buffer >> 0x1) + ((byte_buffer & 0x1) << 0x7))

	return encoded_buffer
```

The file "fzajhccetyiiltfl.bmp" is the following:

![CodeIt 2](Images/codeit_2.bmp)

As we can see, it is the image of the main screen.

To "crack" this algorithm, we have to take a look at the file bytes, to check if we see something strange:

```
FF FF FE FE FE FE FF 
FF FF FF FE FF FE FF 
FF FF FF FE FF FE FE 
FE FF FF FE FE FE FE 
FE FF FF FE FE FE FF 
FF FF FF FE FF FE FE 
FF FF FE FE FF FF FE 
FF FF FE FE FE FE FF 
FF FF FE FF FF FF FE 
FE FF FF FE FE FE FF 
FE FF FF FF FE FE FF 
FE FF FF FF FE FE FF 
FE FF FF FF FE FE FF 
FF FF FF FF FF FF FF
FF FF FF FF FF FF FF
FF FF FF FF FF FF FF
...
```

Mmmm... It seems to have _0xFF_ as the main bytes, but some of them which are _0xFE_. This seems to be done on purpose and, to check so, we put a bunch of _0x00_ as the hostname and print every character after the first _for_ loop:

```
...
	for i in range(len(buffer)):
		byte_buffer = buffer[i]
		for j in range(6, -1, -1):
			byte_buffer = byte_buffer + ((file_buffer[counter] & 0x1) << (0x1 * j))
			counter = counter + 1
->		print(chr(byte_buffer))
		encoded_buffer = encoded_buffer + chr((byte_buffer >> 0x1) + ((byte_buffer & 0x1) << 0x7))

...

hostname = b"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"

...
```

If we execute it, we will see the expected hostname!

```
$ python3 encode_hostname.py 

a
u
t
0
1
t
f
a
n
1
9
9
9






...
```

Let's see what happens when we enter it as a the hostname

```
hostname = b"aut01tfan1999"
```

```
$ python3 encode_hostname.py 

aut01tfan1999
```

It gets the same result! The algorithm changes every string but the expected one.

Now, if we modify the _modify_qr_code_ function as follows:

```
$computer_name_bytes_lower = Binary("aut01tfan1999")
```

We will get the _QR_ code we were waiting for.

![CodeIt 3](Images/codeit_3.png)

The flag is: `L00ks_L1k3_Y0u_D1dnt_Run_Aut0_Tim3_0n_Th1s_0ne!@flare-on.com`