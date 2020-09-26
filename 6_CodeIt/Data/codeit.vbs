#include <MsgBoxConstants.au3>
#include <FileConstants.au3>

#Region
#EndRegion

Global Const $str_nocasesense = 0
Global Const $str_casesense = 1
Global Const $str_nocasesensebasic = 2
Global Const $str_stripleading = 1
Global Const $str_striptrailing = 2
Global Const $str_stripspaces = 4
Global Const $str_stripall = 8
Global Const $str_chrsplit = 0
Global Const $str_entiresplit = 1
Global Const $str_nocount = 2
Global Const $str_regexpmatch = 0
Global Const $str_regexparraymatch = 1
Global Const $str_regexparrayfullmatch = 2
Global Const $str_regexparrayglobalmatch = 3
Global Const $str_regexparrayglobalfullmatch = 4
Global Const $str_endisstart = 0
Global Const $str_endnotstart = 1
Global Const $sb_ansi = 1
Global Const $sb_utf16le = 2
Global Const $sb_utf16be = 3
Global Const $sb_utf8 = 4
Global Const $se_utf16 = 0
Global Const $se_ansi = 1
Global Const $se_utf8 = 2
Global Const $str_utf16 = 0
Global Const $str_ucs2 = 1

Func _hextostring($shex)
	If NOT (StringLeft($shex, 2) == "0x") Then $shex = "0x" & $shex
	Return BinaryToString($shex, $sb_utf8)
EndFunc

Func _stringbetween($sstring, $sstart, $send, $imode = $str_endisstart, $bcase = False)
	$sstart = $sstart ? "\Q" & $sstart & "\E" : "\A"
	If $imode <> $str_endnotstart Then $imode = $str_endisstart
	If $imode = $str_endisstart Then
		$send = $send ? "(?=\Q" & $send & "\E)" : "\z"
	Else
		$send = $send ? "\Q" & $send & "\E" : "\z"
	EndIf
	If $bcase = Default Then
		$bcase = False
	EndIf
	Local $areturn = StringRegExp($sstring, "(?s" & (NOT $bcase ? "i" : "") & ")" & $sstart & "(.*?)" & $send, $str_regexparrayglobalmatch)
	If @error Then Return SetError(1, 0, 0)
	Return $areturn
EndFunc

Func _stringexplode($sstring, $sdelimiter, $ilimit = 0)
	If $ilimit = Default Then $ilimit = 0
	If $ilimit > 0 Then
		Local Const $null = Chr(0)
		$sstring = StringReplace($sstring, $sdelimiter, $null, $ilimit)
		$sdelimiter = $null
	ElseIf $ilimit < 0 Then
		Local $iindex = StringInStr($sstring, $sdelimiter, $str_nocasesensebasic, $ilimit)
		If $iindex Then
			$sstring = StringLeft($sstring, $iindex - 1)
		EndIf
	EndIf
	Return StringSplit($sstring, $sdelimiter, BitOR($str_entiresplit, $str_nocount))
EndFunc

Func _stringinsert($sstring, $sinsertion, $iposition)
	Local $ilength = StringLen($sstring)
	$iposition = Int($iposition)
	If $iposition < 0 Then $iposition = $ilength + $iposition
	If $ilength < $iposition OR $iposition < 0 Then Return SetError(1, 0, $sstring)
	Return StringLeft($sstring, $iposition) & $sinsertion & StringRight($sstring, $ilength - $iposition)
EndFunc

Func _stringproper($sstring)
	Local $bcapnext = True, $schr = "", $sreturn = ""
	For $i = 1 To StringLen($sstring)
		$schr = StringMid($sstring, $i, 1)
		Select
			Case $bcapnext = True
				If StringRegExp($schr, "[a-zA-ZÀ-ÿšœžŸ]") Then
					$schr = StringUpper($schr)
					$bcapnext = False
				EndIf
			Case NOT StringRegExp($schr, "[a-zA-ZÀ-ÿšœžŸ]")
				$bcapnext = True
			Case Else
				$schr = StringLower($schr)
		EndSelect
		$sreturn &= $schr
	Next
	Return $sreturn
EndFunc

Func _stringrepeat($sstring, $irepeatcount)
	$irepeatcount = Int($irepeatcount)
	If $irepeatcount = 0 Then Return ""
	If StringLen($sstring) < 1 OR $irepeatcount < 0 Then Return SetError(1, 0, "")
	Local $sresult = ""
	While $irepeatcount > 1
		If BitAND($irepeatcount, 1) Then $sresult &= $sstring
		$sstring &= $sstring
		$irepeatcount = BitShift($irepeatcount, 1)
	WEnd
	Return $sstring & $sresult
EndFunc

Func _stringtitlecase($sstring)
	Local $bcapnext = True, $schr = "", $sreturn = ""
	For $i = 1 To StringLen($sstring)
		$schr = StringMid($sstring, $i, 1)
		Select
			Case $bcapnext = True
				If StringRegExp($schr, "[a-zA-Z\xC0-\xFF0-9]") Then
					$schr = StringUpper($schr)
					$bcapnext = False
				EndIf
			Case NOT StringRegExp($schr, "[a-zA-Z\xC0-\xFF'0-9]")
				$bcapnext = True
			Case Else
				$schr = StringLower($schr)
		EndSelect
		$sreturn &= $schr
	Next
	Return $sreturn
EndFunc

Func _stringtohex($sstring)
	Return Hex(StringToBinary($sstring, $sb_utf8))
EndFunc

#OnAutoItStartRegister "load_encoded_data"
Global $os
Global $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 ")
Global $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_6 = Number(" 6 "), $number_3 = Number(" 3 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_6 = Number(" 6 "), $number_4 = Number(" 4 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_3 = Number(" 3 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 ")
Global $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_3 = Number(" 3 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_7 = Number(" 7 "), $number_0 = Number(" 0 "), $number_7 = Number(" 7 "), $number_0 = Number(" 0 ")
Global $number_2 = Number(" 2 "), $number_4 = Number(" 4 "), $number_3 = Number(" 3 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_4 = Number(" 4 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_6 = Number(" 6 "), $number_3 = Number(" 3 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_5 = Number(" 5 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 ")
Global $number_3 = Number(" 3 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_3 = Number(" 3 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 ")
Global $number_5 = Number(" 5 "), $number_6 = Number(" 6 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_4 = Number(" 4 "), $number_3 = Number(" 3 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_4 = Number(" 4 "), $number_1 = Number(" 1 "), $number_3 = Number(" 3 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_6 = Number(" 6 "), $number_4 = Number(" 4 "), $number_2 = Number(" 2 "), $number_4 = Number(" 4 ")
Global $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_2 = Number(" 2 "), $number_4 = Number(" 4 "), $number_3 = Number(" 3 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_4 = Number(" 4 "), $number_3 = Number(" 3 "), $number_4 = Number(" 4 "), $number_5 = Number(" 5 "), $number_6 = Number(" 6 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 ")
Global $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_6 = Number(" 6 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_7 = Number(" 7 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_3 = Number(" 3 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 ")
Global $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_6 = Number(" 6 "), $number_3 = Number(" 3 "), $number_0 = Number(" 0 "), $number_7 = Number(" 7 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 "), $number_1 = Number(" 1 ")
Global $number_3 = Number(" 3 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_4 = Number(" 4 "), $number_0 = Number(" 0 "), $number_5 = Number(" 5 "), $number_0 = Number(" 0 "), $number_6 = Number(" 6 "), $number_0 = Number(" 0 "), $number_7 = Number(" 7 "), $number_0 = Number(" 0 "), $number_8 = Number(" 8 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_9 = Number(" 9 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 "), $number_0 = Number(" 0 ")
Global $number_36 = Number(" 36 "), $number_39 = Number(" 39 "), $number_28 = Number(" 28 "), $number_25 = Number(" 25 "), $number_26 = Number(" 26 "), $number_156 = Number(" 156 "), $number_28 = Number(" 28 "), $number_25 = Number(" 25 "), $number_26 = Number(" 26 "), $number_157 = Number(" 157 "), $number_138 = Number(" 138 "), $number_154 = Number(" 154 "), $number_25 = Number(" 25 "), $number_36 = Number(" 36 "), $number_158 = Number(" 158 "), $number_28 = Number(" 28 "), $number_39 = Number(" 39 "), $number_2 = Number(" 2 "), $number_0 = Number(" 0 "), $number_1 = Number(" 1 "), $number_0 = Number(" 0 "), $number_2 = Number(" 2 "), $number_3 = Number(" 3 "), $number_4 = Number(" 4 "), $number_0 = Number(" 0 ")
Global $number_150 = Number(" 150 "), $number_128 = Number(" 128 "), $number_28 = Number(" 28 "), $number_25 = Number(" 25 "), $number_150 = Number(" 150 "), $number_151 = Number(" 151 "), $number_28 = Number(" 28 "), $number_152 = Number(" 152 "), $number_28 = Number(" 28 "), $number_150 = Number(" 150 "), $number_150 = Number(" 150 "), $number_25 = Number(" 25 "), $number_28 = Number(" 28 "), $number_153 = Number(" 153 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_150 = Number(" 150 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_154 = Number(" 154 "), $number_25 = Number(" 25 "), $number_26 = Number(" 26 "), $number_155 = Number(" 155 "), $number_28 = Number(" 28 "), $number_39 = Number(" 39 ")
Global $number_19778 = Number(" 19778 "), $number_148 = Number(" 148 "), $number_25 = Number(" 25 "), $number_28 = Number(" 28 "), $number_149 = Number(" 149 "), $number_138 = Number(" 138 "), $number_22 = Number(" 22 "), $number_150 = Number(" 150 "), $number_2147483648 = Number(" 2147483648 "), $number_150 = Number(" 150 "), $number_28 = Number(" 28 "), $number_150 = Number(" 150 "), $number_150 = Number(" 150 "), $number_128 = Number(" 128 "), $number_28 = Number(" 28 "), $number_25 = Number(" 25 "), $number_28 = Number(" 28 "), $number_149 = Number(" 149 "), $number_138 = Number(" 138 "), $number_22 = Number(" 22 "), $number_150 = Number(" 150 "), $number_1073741824 = Number(" 1073741824 "), $number_150 = Number(" 150 "), $number_28 = Number(" 28 "), $number_150 = Number(" 150 ")
Global $number_26 = Number(" 26 "), $number_135 = Number(" 135 "), $number_136 = Number(" 136 "), $number_137 = Number(" 137 "), $number_39 = Number(" 39 "), $number_138 = Number(" 138 "), $number_1024 = Number(" 1024 "), $number_136 = Number(" 136 "), $number_139 = Number(" 139 "), $number_39 = Number(" 39 "), $number_39 = Number(" 39 "), $number_25 = Number(" 25 "), $number_30 = Number(" 30 "), $number_21 = Number(" 21 "), $number_11 = Number(" 11 "), $number_140 = Number(" 140 "), $number_141 = Number(" 141 "), $number_142 = Number(" 142 "), $number_143 = Number(" 143 "), $number_144 = Number(" 144 "), $number_145 = Number(" 145 "), $number_146 = Number(" 146 "), $number_4096 = Number(" 4096 "), $number_134 = Number(" 134 "), $number_147 = Number(" 147 ")
Global $number_26 = Number(" 26 "), $number_126 = Number(" 126 "), $number_28 = Number(" 28 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_125 = Number(" 125 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_128 = Number(" 128 "), $number_25 = Number(" 25 "), $number_26 = Number(" 26 "), $number_129 = Number(" 129 "), $number_39 = Number(" 39 "), $number_130 = Number(" 130 "), $number_300 = Number(" 300 "), $number_131 = Number(" 131 "), $number_30 = Number(" 30 "), $number_300 = Number(" 300 "), $number_132 = Number(" 132 "), $number_55 = Number(" 55 "), $number_300 = Number(" 300 "), $number_300 = Number(" 300 "), $number_133 = Number(" 133 "), $number_134 = Number(" 134 "), $number_13 = Number(" 13 ")
Global $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_37 = Number(" 37 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_32771 = Number(" 32771 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_28 = Number(" 28 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_38 = Number(" 38 "), $number_28 = Number(" 28 "), $number_39 = Number(" 39 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_40 = Number(" 40 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_34 = Number(" 34 ")
Global $number_26 = Number(" 26 "), $number_125 = Number(" 125 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_126 = Number(" 126 "), $number_28 = Number(" 28 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_125 = Number(" 125 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_127 = Number(" 127 "), $number_16 = Number(" 16 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_35 = Number(" 35 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_24 = Number(" 24 "), $number_36 = Number(" 36 "), $number_4026531840 = Number(" 4026531840 ")
Global $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_28 = Number(" 28 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_121 = Number(" 121 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_122 = Number(" 122 "), $number_123 = Number(" 123 "), $number_10 = Number(" 10 "), $number_14 = Number(" 14 "), $number_18 = Number(" 18 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_124 = Number(" 124 "), $number_28 = Number(" 28 "), $number_34 = Number(" 34 ")
Global $number_108 = Number(" 108 "), $number_109 = Number(" 109 "), $number_110 = Number(" 110 "), $number_111 = Number(" 111 "), $number_112 = Number(" 112 "), $number_113 = Number(" 113 "), $number_114 = Number(" 114 "), $number_115 = Number(" 115 "), $number_116 = Number(" 116 "), $number_117 = Number(" 117 "), $number_118 = Number(" 118 "), $number_119 = Number(" 119 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_35 = Number(" 35 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_24 = Number(" 24 "), $number_36 = Number(" 36 "), $number_4026531840 = Number(" 4026531840 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_120 = Number(" 120 ")
Global $number_83 = Number(" 83 "), $number_84 = Number(" 84 "), $number_85 = Number(" 85 "), $number_86 = Number(" 86 "), $number_87 = Number(" 87 "), $number_88 = Number(" 88 "), $number_89 = Number(" 89 "), $number_90 = Number(" 90 "), $number_91 = Number(" 91 "), $number_92 = Number(" 92 "), $number_93 = Number(" 93 "), $number_94 = Number(" 94 "), $number_95 = Number(" 95 "), $number_96 = Number(" 96 "), $number_97 = Number(" 97 "), $number_98 = Number(" 98 "), $number_99 = Number(" 99 "), $number_100 = Number(" 100 "), $number_101 = Number(" 101 "), $number_102 = Number(" 102 "), $number_103 = Number(" 103 "), $number_104 = Number(" 104 "), $number_105 = Number(" 105 "), $number_106 = Number(" 106 "), $number_107 = Number(" 107 ")
Global $number_58 = Number(" 58 "), $number_59 = Number(" 59 "), $number_60 = Number(" 60 "), $number_61 = Number(" 61 "), $number_62 = Number(" 62 "), $number_63 = Number(" 63 "), $number_64 = Number(" 64 "), $number_65 = Number(" 65 "), $number_66 = Number(" 66 "), $number_67 = Number(" 67 "), $number_68 = Number(" 68 "), $number_69 = Number(" 69 "), $number_70 = Number(" 70 "), $number_71 = Number(" 71 "), $number_72 = Number(" 72 "), $number_73 = Number(" 73 "), $number_74 = Number(" 74 "), $number_75 = Number(" 75 "), $number_76 = Number(" 76 "), $number_77 = Number(" 77 "), $number_78 = Number(" 78 "), $number_79 = Number(" 79 "), $number_80 = Number(" 80 "), $number_81 = Number(" 81 "), $number_82 = Number(" 82 ")
Global $number_26 = Number(" 26 "), $number_40 = Number(" 40 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_41 = Number(" 41 "), $number_42 = Number(" 42 "), $number_43 = Number(" 43 "), $number_44 = Number(" 44 "), $number_45 = Number(" 45 "), $number_46 = Number(" 46 "), $number_41 = Number(" 41 "), $number_47 = Number(" 47 "), $number_48 = Number(" 48 "), $number_49 = Number(" 49 "), $number_50 = Number(" 50 "), $number_51 = Number(" 51 "), $number_52 = Number(" 52 "), $number_53 = Number(" 53 "), $number_54 = Number(" 54 "), $number_55 = Number(" 55 "), $number_56 = Number(" 56 "), $number_57 = Number(" 57 ")
Global $number_35 = Number(" 35 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_24 = Number(" 24 "), $number_36 = Number(" 36 "), $number_4026531840 = Number(" 4026531840 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_37 = Number(" 37 "), $number_28 = Number(" 28 "), $number_36 = Number(" 36 "), $number_32780 = Number(" 32780 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_28 = Number(" 28 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 "), $number_38 = Number(" 38 "), $number_28 = Number(" 28 "), $number_39 = Number(" 39 "), $number_36 = Number(" 36 "), $number_36 = Number(" 36 "), $number_34 = Number(" 34 ")
Global $number_22 = Number(" 22 "), $number_24 = Number(" 24 "), $number_1024 = Number(" 1024 "), $number_25 = Number(" 25 "), $number_26 = Number(" 26 "), $number_27 = Number(" 27 "), $number_28 = Number(" 28 "), $number_28 = Number(" 28 "), $number_29 = Number(" 29 "), $number_300 = Number(" 300 "), $number_375 = Number(" 375 "), $number_14 = Number(" 14 "), $number_54 = Number(" 54 "), $number_30 = Number(" 30 "), $number_31 = Number(" 31 "), $number_32 = Number(" 32 "), $number_54 = Number(" 54 "), $number_31 = Number(" 31 "), $number_20 = Number(" 20 "), $number_30 = Number(" 30 "), $number_31 = Number(" 31 "), $number_33 = Number(" 33 "), $number_32 = Number(" 32 "), $number_34 = Number(" 34 "), $number_26 = Number(" 26 ")
Global $number_54 = Number(" 54 "), $number_40 = Number(" 40 "), $number_24 = Number(" 24 "), $number_10 = Number(" 10 "), $number_11 = Number(" 11 "), $number_12 = Number(" 12 "), $number_13 = Number(" 13 "), $number_14 = Number(" 14 "), $number_15 = Number(" 15 "), $number_16 = Number(" 16 "), $number_17 = Number(" 17 "), $number_18 = Number(" 18 "), $number_19 = Number(" 19 "), $number_20 = Number(" 20 "), $number_97 = Number(" 97 "), $number_122 = Number(" 122 "), $number_15 = Number(" 15 "), $number_20 = Number(" 20 "), $number_10 = Number(" 10 "), $number_15 = Number(" 15 "), $number_21 = Number(" 21 "), $number_22 = Number(" 22 "), $number_25 = Number(" 25 "), $number_30 = Number(" 30 "), $number_23 = Number(" 23 ")

Func areoxaohpta($flmojocqtz, $fljzkjrgzs, $flsgxlqjno)
	Local $flfzxxyxzg[$number_2]
	$flfzxxyxzg[$number_0] = DllStructCreate(decode_string($os[$number_1]))
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_2]), ($number_3 * $flmojocqtz + Mod($flmojocqtz, $number_4) * Abs($fljzkjrgzs)))
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_3]), $number_0)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_4]), $number_54)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_5]), $number_40)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_6]), $flmojocqtz)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_7]), $fljzkjrgzs)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_8]), $number_1)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_9]), $number_24)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_10]), $number_0)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_11]), $number_0)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_12]), $number_0)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_13]), $number_0)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_14]), $number_0)
	DllStructSetData($flfzxxyxzg[$number_0], decode_string($os[$number_15]), $number_0)
	$flfzxxyxzg[$number_1] = DllStructCreate(decode_string($os[$number_16]) & _stringrepeat(decode_string($os[$number_17]) & DllStructGetData($flfzxxyxzg[$number_0], decode_string($os[$number_6])) * $number_3 & decode_string($os[$number_18]), DllStructGetData($flfzxxyxzg[$number_0], decode_string($os[$number_7]))) & decode_string($os[$number_19]))
	Return $flfzxxyxzg
EndFunc

Func get_random_name($flyoojibbo, $fltyapmigo)
	Local $fldknagjpd = decode_string($os[$number_20])
	For $flezmzowno = $number_0 To Random($flyoojibbo, $fltyapmigo, $number_1)
		$fldknagjpd &= Chr(Random($number_97, $number_122, $number_1))
	Next
	Return $fldknagjpd
EndFunc

Func get_filel_name($flslbknofv)
	Local $flxgrwiiel = get_random_name($number_15, $number_20)
	Switch $flslbknofv
		Case $number_10 To $number_15
			$flxgrwiiel &= decode_string($os[$number_21])
			FileInstall(".\sprite.bmp", @ScriptDir & decode_string($os[$number_22]) & $flxgrwiiel)
		Case $number_25 To $number_30
			$flxgrwiiel &= decode_string($os[$number_23])
			FileInstall(".\qr_encoder.dll", @ScriptDir & decode_string($os[$number_22]) & $flxgrwiiel)
	EndSwitch
	Return $flxgrwiiel
EndFunc

Func areuznaqfmn()
	Local $flfnvbvvfi = -$number_1
	Local $flfnvbvvfiraw = DllStructCreate(decode_string($os[$number_24]))
	DllStructSetData($flfnvbvvfiraw, $number_1, $number_1024)
	Local $flmyeulrox = DllCall(decode_string($os[$number_25]), decode_string($os[$number_26]), decode_string($os[$number_27]), decode_string($os[$number_28]), DllStructGetPtr($flfnvbvvfiraw, $number_2), decode_string($os[$number_28]), DllStructGetPtr($flfnvbvvfiraw, $number_1))
	If $flmyeulrox[$number_0] <> $number_0 Then
		$flfnvbvvfi = BinaryMid(DllStructGetData($flfnvbvvfiraw, $number_2), $number_1, DllStructGetData($flfnvbvvfiraw, $number_1))
	EndIf
	Return $flfnvbvvfi
EndFunc

GUICreate(decode_string($os[$number_29]), $number_300, $number_375, -$number_1, -$number_1)

Func aregtfdcyni(ByRef $flkqaovzec)
	Local $flqvizhezm = get_filel_name($number_14)
	Local $flfwezdbyc = arerujpvsfp($flqvizhezm)
	If $flfwezdbyc <> -$number_1 Then
		Local $flvburiuyd = arenwrbskll($flfwezdbyc)
		If $flvburiuyd <> -$number_1 AND DllStructGetSize($flkqaovzec) < $flvburiuyd - $number_54 Then
			Local $flnfufvect = DllStructCreate(decode_string($os[$number_30]) & $flvburiuyd & decode_string($os[$number_31]))
			Local $flskuanqbg = aremlfozynu($flfwezdbyc, $flnfufvect)
			If $flskuanqbg <> -$number_1 Then
				Local $flxmdchrqd = DllStructCreate(decode_string($os[$number_32]) & $flvburiuyd - $number_54 & decode_string($os[$number_31]), DllStructGetPtr($flnfufvect))
				Local $flqgwnzjzc = $number_1
				Local $floctxpgqh = decode_string($os[$number_20])
				For $fltergxskh = $number_1 To DllStructGetSize($flkqaovzec)
					Local $flydtvgpnc = Number(DllStructGetData($flkqaovzec, $number_1, $fltergxskh))
					For $fltajbykxx = $number_6 To $number_0 Step -$number_1
						$flydtvgpnc += BitShift(BitAND(Number(DllStructGetData($flxmdchrqd, $number_2, $flqgwnzjzc)), $number_1), -$number_1 * $fltajbykxx)
						$flqgwnzjzc += $number_1
					Next
					$floctxpgqh &= Chr(BitShift($flydtvgpnc, $number_1) + BitShift(BitAND($flydtvgpnc, $number_1), -$number_7))
				Next
				DllStructSetData($flkqaovzec, $number_1, $floctxpgqh)
			EndIf
		EndIf
		arevtgkxjhu($flfwezdbyc)
	EndIf
	arebbytwcoj($flqvizhezm)
EndFunc

Func areyzotafnf(ByRef $flodiutpuy)
	Local $flisilayln = areuznaqfmn()
	If $flisilayln <> -$number_1 Then
		$flisilayln = Binary(StringLower(BinaryToString($flisilayln)))
		Local $flisilaylnraw = DllStructCreate(decode_string($os[$number_30]) & BinaryLen($flisilayln) & decode_string($os[$number_31]))
		DllStructSetData($flisilaylnraw, $number_1, $flisilayln)
		aregtfdcyni($flisilaylnraw)
		Local $flnttmjfea = DllStructCreate(decode_string($os[$number_33]))
		DllStructSetData($flnttmjfea, $number_3, $number_32)
		Local $sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_35]), decode_string($os[$number_28]), DllStructGetPtr($flnttmjfea, $number_1), decode_string($os[$number_28]), $number_0, decode_string($os[$number_28]), $number_0, decode_string($os[$number_36]), $number_24, decode_string($os[$number_36]), $number_4026531840)
		If $sha256_struct[$number_0] <> $number_0 Then
		    # CryptCreateHash -> CALG_SHA256
			$sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_37]), decode_string($os[$number_28]), DllStructGetData($flnttmjfea, $number_1), decode_string($os[$number_36]), $number_32780, decode_string($os[$number_36]), $number_0, decode_string($os[$number_36]), $number_0, decode_string($os[$number_28]), DllStructGetPtr($flnttmjfea, $number_2))
			If $sha256_struct[$number_0] <> $number_0 Then
			    # CryptHashData
				$sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_38]), decode_string($os[$number_28]), DllStructGetData($flnttmjfea, $number_2), decode_string($os[$number_39]), $flisilaylnraw, decode_string($os[$number_36]), DllStructGetSize($flisilaylnraw), decode_string($os[$number_36]), $number_0)
				If $sha256_struct[$number_0] <> $number_0 Then
				    # CryptGetHashParam
					$sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_40]), decode_string($os[$number_28]), DllStructGetData($flnttmjfea, $number_2), decode_string($os[$number_36]), $number_2, decode_string($os[$number_28]), DllStructGetPtr($flnttmjfea, $number_4), decode_string($os[$number_28]), DllStructGetPtr($flnttmjfea, $number_3), decode_string($os[$number_36]), $number_0)
					If $sha256_struct[$number_0] <> $number_0 Then
					    # 0x080200001066000020000000
						Local $short_hex_data = Binary(decode_string($os[$number_41]) & decode_string($os[$number_42]) & decode_string($os[$number_43]) & decode_string($os[$number_44]) & decode_string($os[$number_45]) & decode_string($os[$number_46])) & DllStructGetData($flnttmjfea, $number_4)
						# 0xCD4B32C650CF21BDA184D8913E6F920A37A4F3963736C042C459EA07B79EA443FFD1898BAE49B115F6CB1E2A7C1AB3C4C25612A519035F18FB3B17528B3AECAF3D480E98BF8A635DAF974E0013535D231E4B75B2C38B804C7AE4D266A37B36F2C555BF3A9EA6A58BC8F906CC665EAE2CE60F2CDE38FD30269CC4CE5BB090472FF9BD26F91119B8C1484FE169EB9134F431FEEDE1DCEBA17914610819F1B21F110F8321B2A5D14D7721DB12C13BED9147F6F1706AE14411A152
						Local $long_hex_data = Binary(decode_string($os[$number_41]) & decode_string($os[$number_47]) & decode_string($os[$number_48]) & decode_string($os[$number_49]) & decode_string($os[$number_50]) & decode_string($os[$number_51]) & decode_string($os[$number_52]) & decode_string($os[$number_53]) & decode_string($os[$number_54]) & decode_string($os[$number_55]) & decode_string($os[$number_56]) & decode_string($os[$number_57]) & decode_string($os[$number_58]) & decode_string($os[$number_59]) & decode_string($os[$number_60]) & decode_string($os[$number_61]) & decode_string($os[$number_62]) & decode_string($os[$number_63]) & decode_string($os[$number_64]) & decode_string($os[$number_65]) & decode_string($os[$number_66]) & decode_string($os[$number_67]) & decode_string($os[$number_68]) & decode_string($os[$number_69]) & decode_string($os[$number_70]) & decode_string($os[$number_71]) & decode_string($os[$number_72]) & decode_string($os[$number_73]) & decode_string($os[$number_74]) & decode_string($os[$number_75]) & decode_string($os[$number_76]) & decode_string($os[$number_77]) & decode_string($os[$number_78]) & decode_string($os[$number_79]) & decode_string($os[$number_80]) & decode_string($os[$number_81]) & decode_string($os[$number_82]) & decode_string($os[$number_83]) & decode_string($os[$number_84]) & decode_string($os[$number_85]) & decode_string($os[$number_86]) & decode_string($os[$number_87]) & decode_string($os[$number_88]) & decode_string($os[$number_89]) & decode_string($os[$number_90]) & decode_string($os[$number_91]) & decode_string($os[$number_92]) & decode_string($os[$number_93]) & decode_string($os[$number_94]) & decode_string($os[$number_95]) & decode_string($os[$number_96]) & decode_string($os[$number_97]) & decode_string($os[$number_98]) & decode_string($os[$number_99]) & decode_string($os[$number_100]) & decode_string($os[$number_101]) & decode_string($os[$number_102]) & decode_string($os[$number_103]) & decode_string($os[$number_104]) & decode_string($os[$number_105]) & decode_string($os[$number_106]) & decode_string($os[$number_107]) & decode_string($os[$number_108]) & decode_string($os[$number_109]) & decode_string($os[$number_110]) & decode_string($os[$number_111]) & decode_string($os[$number_112]) & decode_string($os[$number_113]) & decode_string($os[$number_114]) & decode_string($os[$number_115]) & decode_string($os[$number_116]) & decode_string($os[$number_117]))
						Local $fluelrpeax = DllStructCreate(decode_string($os[$number_118]) & BinaryLen($short_hex_data) & decode_string($os[$number_119]))
						DllStructSetData($fluelrpeax, $number_3, BinaryLen($long_hex_data))
						DllStructSetData($fluelrpeax, $number_4, $long_hex_data)
						DllStructSetData($fluelrpeax, $number_5, $short_hex_data)
						DllStructSetData($fluelrpeax, $number_6, BinaryLen($short_hex_data))
						Local $sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_35]), decode_string($os[$number_28]), DllStructGetPtr($fluelrpeax, $number_1), decode_string($os[$number_28]), $number_0, decode_string($os[$number_28]), $number_0, decode_string($os[$number_36]), $number_24, decode_string($os[$number_36]), $number_4026531840)
						If $sha256_struct[$number_0] <> $number_0 Then
							$sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_120]), decode_string($os[$number_28]), DllStructGetData($fluelrpeax, $number_1), decode_string($os[$number_28]), DllStructGetPtr($fluelrpeax, $number_5), decode_string($os[$number_36]), DllStructGetData($fluelrpeax, $number_6), decode_string($os[$number_36]), $number_0, decode_string($os[$number_36]), $number_0, decode_string($os[$number_28]), DllStructGetPtr($fluelrpeax, $number_2))
							If $sha256_struct[$number_0] <> $number_0 Then
								$sha256_struct = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_121]), decode_string($os[$number_28]), DllStructGetData($fluelrpeax, $number_2), decode_string($os[$number_36]), $number_0, decode_string($os[$number_36]), $number_1, decode_string($os[$number_36]), $number_0, decode_string($os[$number_28]), DllStructGetPtr($fluelrpeax, $number_4), decode_string($os[$number_28]), DllStructGetPtr($fluelrpeax, $number_3))
								If $sha256_struct[$number_0] <> $number_0 Then
									Local $flsekbkmru = BinaryMid(DllStructGetData($fluelrpeax, $number_4), $number_1, DllStructGetData($fluelrpeax, $number_3))
									$flare_str = Binary(decode_string($os[$number_122]))
									$eralf_str = Binary(decode_string($os[$number_123]))
									$flgggftges = BinaryMid($flsekbkmru, $number_1, BinaryLen($flare_str))
									$flnmiatrft = BinaryMid($flsekbkmru, BinaryLen($flsekbkmru) - BinaryLen($eralf_str) + $number_1, BinaryLen($eralf_str))
									If $flare_str = $flgggftges AND $eralf_str = $flnmiatrft Then
										DllStructSetData($flodiutpuy, $number_1, BinaryMid($flsekbkmru, $number_6, $number_4))
										DllStructSetData($flodiutpuy, $number_2, BinaryMid($flsekbkmru, $number_10, $number_4))
										DllStructSetData($flodiutpuy, $number_3, BinaryMid($flsekbkmru, $number_14, BinaryLen($flsekbkmru) - $number_18))
									EndIf
								EndIf
							    # CryptDestroyKey
								DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_124]), decode_string($os[$number_28]), DllStructGetData($fluelrpeax, $number_2))
							EndIf
							# CryptReleaseContext
							DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_125]), decode_string($os[$number_28]), DllStructGetData($fluelrpeax, $number_1), decode_string($os[$number_36]), $number_0)
						EndIf
					EndIf
				EndIf
				# CryptDestroyHash
				DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_126]), decode_string($os[$number_28]), DllStructGetData($flnttmjfea, $number_2))
			EndIf
			# CryptReleaseContext
			DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_125]), decode_string($os[$number_28]), DllStructGetData($flnttmjfea, $number_1), decode_string($os[$number_36]), $number_0)
		EndIf
	EndIf
EndFunc

Func get_md5(ByRef $flkhfbuyon)
	Local $fluupfrkdz = -$number_1
	Local $flqbsfzezk = DllStructCreate(decode_string($os[$number_127]))
	DllStructSetData($flqbsfzezk, $number_3, $number_16)
	Local $fltrtsuryd = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_35]), decode_string($os[$number_28]), DllStructGetPtr($flqbsfzezk, $number_1), decode_string($os[$number_28]), $number_0, decode_string($os[$number_28]), $number_0, decode_string($os[$number_36]), $number_24, decode_string($os[$number_36]), $number_4026531840)
	If $fltrtsuryd[$number_0] <> $number_0 Then
	    # CryptCreateHash -> CALG_MD5
		$fltrtsuryd = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_37]), decode_string($os[$number_28]), DllStructGetData($flqbsfzezk, $number_1), decode_string($os[$number_36]), $number_32771, decode_string($os[$number_36]), $number_0, decode_string($os[$number_36]), $number_0, decode_string($os[$number_28]), DllStructGetPtr($flqbsfzezk, $number_2))
		If $fltrtsuryd[$number_0] <> $number_0 Then
		    # CryptHashData
			$fltrtsuryd = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_38]), decode_string($os[$number_28]), DllStructGetData($flqbsfzezk, $number_2), decode_string($os[$number_39]), $flkhfbuyon, decode_string($os[$number_36]), DllStructGetSize($flkhfbuyon), decode_string($os[$number_36]), $number_0)
			If $fltrtsuryd[$number_0] <> $number_0 Then
			    # CryptGetHashParam
				$fltrtsuryd = DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_40]), decode_string($os[$number_28]), DllStructGetData($flqbsfzezk, $number_2), decode_string($os[$number_36]), $number_2, decode_string($os[$number_28]), DllStructGetPtr($flqbsfzezk, $number_4), decode_string($os[$number_28]), DllStructGetPtr($flqbsfzezk, $number_3), decode_string($os[$number_36]), $number_0)
				If $fltrtsuryd[$number_0] <> $number_0 Then
					$fluupfrkdz = DllStructGetData($flqbsfzezk, $number_4)
				EndIf
			EndIf
			DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_126]), decode_string($os[$number_28]), DllStructGetData($flqbsfzezk, $number_2))
		EndIf
		DllCall(decode_string($os[$number_34]), decode_string($os[$number_26]), decode_string($os[$number_125]), decode_string($os[$number_28]), DllStructGetData($flqbsfzezk, $number_1), decode_string($os[$number_36]), $number_0)
	EndIf
	Return $fluupfrkdz
EndFunc

Func arepfnkwypw()
	Local $flgqbtjbmi = -$number_1
	Local $fltpvjccvq = DllStructCreate(decode_string($os[$number_128]))
	DllStructSetData($fltpvjccvq, $number_1, DllStructGetSize($fltpvjccvq))
	Local $flaghdvgyv = DllCall(decode_string($os[$number_25]), decode_string($os[$number_26]), decode_string($os[$number_129]), decode_string($os[$number_39]), $fltpvjccvq)
	If $flaghdvgyv[$number_0] <> $number_0 Then
		If DllStructGetData($fltpvjccvq, $number_2) = $number_6 Then
			If DllStructGetData($fltpvjccvq, $number_3) = $number_1 Then
				$flgqbtjbmi = $number_0
			EndIf
		EndIf
	EndIf
	Return $flgqbtjbmi
EndFunc

Func main()
	Local $input = GUICtrlCreateInput(decode_string($os[$number_130]), -$number_1, $number_5, $number_300)
	Local $flkhwwzgne = GUICtrlCreateButton(decode_string($os[$number_131]), -$number_1, $number_30, $number_300)
	Local $image_box_gui = GUICtrlCreatePic(decode_string($os[$number_132]), -$number_1, $number_55, $number_300, $number_300)
	Local $flxeuaihlc = GUICtrlCreateMenu(decode_string($os[$number_133]))
	Local $flxeuaihlcitem = GUICtrlCreateMenuItem(decode_string($os[$number_134]), $flxeuaihlc)
	Local $qr_code_name = get_filel_name($number_13)
	GUICtrlSetImage($image_box_gui, $qr_code_name)
	arebbytwcoj($qr_code_name)
	GUISetState(@SW_SHOW)
	While $number_1
		Switch GUIGetMsg()
			Case $flkhwwzgne
				write_file()
				Local $input_text = GUICtrlRead($input)
				If $input_text Then
					Local $dll_filename = get_filel_name($number_26)
					Local $flnpapeken = DllStructCreate(decode_string($os[$number_135]))
					Local $dll_call_result = DllCall($dll_filename, decode_string($os[$number_136]), decode_string($os[$number_137]), decode_string($os[$number_39]), $flnpapeken, decode_string($os[$number_138]), $input_text)
					If $dll_call_result[$number_0] <> $number_0 Then
						areyzotafnf($flnpapeken)
						Local $flbvokdxkg = areoxaohpta((DllStructGetData($flnpapeken, $number_1) * DllStructGetData($flnpapeken, $number_2)), (DllStructGetData($flnpapeken, $number_1) * DllStructGetData($flnpapeken, $number_2)), $number_1024)
						$dll_call_result = DllCall($dll_filename, decode_string($os[$number_136]), decode_string($os[$number_139]), decode_string($os[$number_39]), $flnpapeken, decode_string($os[$number_39]), $flbvokdxkg[$number_1])
						If $dll_call_result[$number_0] <> $number_0 Then
							$qr_code_name = get_random_name($number_25, $number_30) & decode_string($os[$number_21])
							get_qr_code($flbvokdxkg, $qr_code_name)
						EndIf
					EndIf
					arebbytwcoj($dll_filename)
				Else
					$qr_code_name = get_filel_name($number_11)
				EndIf
				GUICtrlSetImage($image_box_gui, $qr_code_name)
				arebbytwcoj($qr_code_name)
			# License
			Case $flxeuaihlcitem
				Local $flomtrkawp = decode_string($os[$number_140])
				$flomtrkawp &= decode_string($os[$number_141])
				$flomtrkawp &= @CRLF
				$flomtrkawp &= @CRLF
				$flomtrkawp &= decode_string($os[$number_142])
				$flomtrkawp &= @CRLF
				$flomtrkawp &= decode_string($os[$number_143])
				$flomtrkawp &= @CRLF
				$flomtrkawp &= @CRLF
				$flomtrkawp &= decode_string($os[$number_144])
				$flomtrkawp &= @CRLF
				$flomtrkawp &= @CRLF
				$flomtrkawp &= decode_string($os[$number_145])
				$flomtrkawp &= @CRLF
				$flomtrkawp &= decode_string($os[$number_146])
				MsgBox($number_4096, decode_string($os[$number_134]), $flomtrkawp)
			Case -$number_3
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func arepqqkaeto($flmwacufre, $fljxaivjld)
	Local $fljiyeluhx = -$number_1
	Local $flmwacufreheadermagic = DllStructCreate(decode_string($os[$number_147]))
	DllStructSetData($flmwacufreheadermagic, $number_1, $number_19778)
	Local $flivpiogmf = aremyfdtfqp($fljxaivjld, False)
	If $flivpiogmf <> -$number_1 Then
		Local $flchlkbend = aremfkxlayv($flivpiogmf, DllStructGetPtr($flmwacufreheadermagic), DllStructGetSize($flmwacufreheadermagic))
		If $flchlkbend <> -$number_1 Then
			$flchlkbend = aremfkxlayv($flivpiogmf, DllStructGetPtr($flmwacufre[$number_0]), DllStructGetSize($flmwacufre[$number_0]))
			If $flchlkbend <> -$number_1 Then
				$fljiyeluhx = $number_0
			EndIf
		EndIf
		arevtgkxjhu($flivpiogmf)
	EndIf
	Return $fljiyeluhx
EndFunc

main()

Func get_qr_code($flbaqvujsl, $flkelsuuiy)
	Local $flefoubdxt = -$number_1
	Local $flamtlcncx = arepqqkaeto($flbaqvujsl, $flkelsuuiy)
	If $flamtlcncx <> -$number_1 Then
		Local $flvikmhxwu = aremyfdtfqp($flkelsuuiy, True)
		If $flvikmhxwu <> -$number_1 Then
			Local $flwldjlwrq = Abs(DllStructGetData($flbaqvujsl[$number_0], decode_string($os[$number_7])))
			Local $flumnoetuu = DllStructGetData($flbaqvujsl[$number_0], decode_string($os[$number_7])) > $number_0 ? $flwldjlwrq - $number_1 : $number_0
			Local $flqphcjgtp = DllStructCreate(decode_string($os[$number_148]))
			For $fllrcvawmx = $number_0 To $flwldjlwrq - $number_1
				$flamtlcncx = aremfkxlayv($flvikmhxwu, DllStructGetPtr($flbaqvujsl[$number_1], Abs($flumnoetuu - $fllrcvawmx) + $number_1), DllStructGetData($flbaqvujsl[$number_0], decode_string($os[$number_6])) * $number_3)
				If $flamtlcncx = -$number_1 Then ExitLoop
				$flamtlcncx = aremfkxlayv($flvikmhxwu, DllStructGetPtr($flqphcjgtp), Mod(DllStructGetData($flbaqvujsl[$number_0], decode_string($os[$number_6])), $number_4))
				If $flamtlcncx = -$number_1 Then ExitLoop
			Next
			If $flamtlcncx <> -$number_1 Then
				$flefoubdxt = $number_0
			EndIf
			arevtgkxjhu($flvikmhxwu)
		EndIf
	EndIf
	Return $flefoubdxt
EndFunc

Func arerujpvsfp($flrriteuxd)
	Local $flrichemye = DllCall(decode_string($os[$number_25]), decode_string($os[$number_28]), decode_string($os[$number_149]), decode_string($os[$number_138]), @ScriptDir & decode_string($os[$number_22]) & $flrriteuxd, decode_string($os[$number_150]), $number_2147483648, decode_string($os[$number_150]), $number_0, decode_string($os[$number_28]), $number_0, decode_string($os[$number_150]), $number_3, decode_string($os[$number_150]), $number_128, decode_string($os[$number_28]), $number_0)
	Return $flrichemye[$number_0]
EndFunc

Func aremyfdtfqp($flzxepiook, $flzcodzoep = True)
	Local $flogmfcakq = DllCall(decode_string($os[$number_25]), decode_string($os[$number_28]), decode_string($os[$number_149]), decode_string($os[$number_138]), @ScriptDir & decode_string($os[$number_22]) & $flzxepiook, decode_string($os[$number_150]), $number_1073741824, decode_string($os[$number_150]), $number_0, decode_string($os[$number_28]), $number_0, decode_string($os[$number_150]), $flzcodzoep ? 3 : $number_2, decode_string($os[$number_150]), $number_128, decode_string($os[$number_28]), $number_0)
	Return $flogmfcakq[$number_0]
EndFunc

GUIDelete()

Func aremfkxlayv($fllsczdyhr, $flbfzgxbcy, $flutgabjfj)
	If $fllsczdyhr <> -$number_1 Then
		Local $flvfnkosuf = DllCall(decode_string($os[$number_25]), decode_string($os[$number_150]), decode_string($os[$number_151]), decode_string($os[$number_28]), $fllsczdyhr, decode_string($os[$number_152]), $number_0, decode_string($os[$number_28]), $number_0, decode_string($os[$number_150]), $number_2)
		If $flvfnkosuf[$number_0] <> -$number_1 Then
			Local $flwzfbbkto = DllStructCreate(decode_string($os[$number_150]))
			$flvfnkosuf = DllCall(decode_string($os[$number_25]), decode_string($os[$number_28]), decode_string($os[$number_153]), decode_string($os[$number_28]), $fllsczdyhr, decode_string($os[$number_28]), $flbfzgxbcy, decode_string($os[$number_150]), $flutgabjfj, decode_string($os[$number_28]), DllStructGetPtr($flwzfbbkto), decode_string($os[$number_28]), $number_0)
			If $flvfnkosuf[$number_0] <> $number_0 AND DllStructGetData($flwzfbbkto, $number_1) = $flutgabjfj Then
				Return $number_0
			EndIf
		EndIf
	EndIf
	Return -$number_1
EndFunc

Func aremlfozynu($flfdnkxwze, ByRef $flgfdykdor)
	Local $flqcvtzthz = DllStructCreate(decode_string($os[$number_154]))
	Local $flqnsbzfsf = DllCall(decode_string($os[$number_25]), decode_string($os[$number_26]), decode_string($os[$number_155]), decode_string($os[$number_28]), $flfdnkxwze, decode_string($os[$number_39]), $flgfdykdor, decode_string($os[$number_36]), DllStructGetSize($flgfdykdor), decode_string($os[$number_39]), $flqcvtzthz, decode_string($os[$number_28]), $number_0)
	Return $flqnsbzfsf[$number_0]
EndFunc

Func arevtgkxjhu($fldiapcptm)
	Local $flhvhgvtxm = DllCall(decode_string($os[$number_25]), decode_string($os[$number_26]), decode_string($os[$number_156]), decode_string($os[$number_28]), $fldiapcptm)
	Return $flhvhgvtxm[$number_0]
EndFunc

Func arebbytwcoj($flxljyoycl)
	Local $flaubrmoip = DllCall(decode_string($os[$number_25]), decode_string($os[$number_26]), decode_string($os[$number_157]), decode_string($os[$number_138]), $flxljyoycl)
	Return $flaubrmoip[$number_0]
EndFunc

Func arenwrbskll($flpxhqhcav)
	Local $flzmcdhzwh = -$number_1
	Local $flztpegdeg = DllStructCreate(decode_string($os[$number_154]))
	Local $flekmcmpdl = DllCall(decode_string($os[$number_25]), decode_string($os[$number_36]), decode_string($os[$number_158]), decode_string($os[$number_28]), $flpxhqhcav, decode_string($os[$number_39]), $flztpegdeg)
	If $flekmcmpdl <> -$number_1 Then
		$flzmcdhzwh = $flekmcmpdl[$number_0] + Number(DllStructGetData($flztpegdeg, $number_1))
	EndIf
	Return $flzmcdhzwh
EndFunc

Func load_encoded_data()
	Local $dlit = "7374727563743b75696e7420626653697a653b75696e7420626652657365727665643b75696e742062664f6666426974733b"
	$dlit &= "75696e7420626953697a653b696e7420626957696474683b696e742062694865696768743b7573686f7274206269506c616e"
	$dlit &= "65733b7573686f7274206269426974436f756e743b75696e74206269436f6d7072657373696f6e3b75696e7420626953697a"
	$dlit &= "65496d6167653b696e742062695850656c735065724d657465723b696e742062695950656c735065724d657465723b75696e"
	$dlit &= "74206269436c72557365643b75696e74206269436c72496d706f7274616e743b656e647374727563743b4FD5$626653697a6"
	$dlit &= "54FD5$626652657365727665644FD5$62664f6666426974734FD5$626953697a654FD5$626957696474684FD5$6269486569"
	$dlit &= "6768744FD5$6269506c616e65734FD5$6269426974436f756e744FD5$6269436f6d7072657373696f6e4FD5$626953697a65"
	$dlit &= "496d6167654FD5$62695850656c735065724d657465724FD5$62695950656c735065724d657465724FD5$6269436c7255736"
	$dlit &= "5644FD5$6269436c72496d706f7274616e744FD5$7374727563743b4FD5$627974655b4FD5$5d3b4FD5$656e647374727563"
	$dlit &= "744FD5$4FD5$2e626d704FD5$5c4FD5$2e646c6c4FD5$7374727563743b64776f72643b636861725b313032345d3b656e647"
	$dlit &= "374727563744FD5$6b65726e656c33322e646c6c4FD5$696e744FD5$476574436f6d70757465724e616d65414FD5$7074724"
	$dlit &= "FD5$436f6465497420506c7573214FD5$7374727563743b627974655b4FD5$5d3b656e647374727563744FD5$73747275637"
	$dlit &= "43b627974655b35345d3b627974655b4FD5$7374727563743b7074723b7074723b64776f72643b627974655b33325d3b656e"
	$dlit &= "647374727563744FD5$61647661706933322e646c6c4FD5$437279707441637175697265436f6e74657874414FD5$64776f7"
	$dlit &= "2644FD5$4372797074437265617465486173684FD5$437279707448617368446174614FD5$7374727563742a4FD5$4372797"
	$dlit &= "07447657448617368506172616d4FD5$30784FD5$30383032304FD5$30303031304FD5$36363030304FD5$30323030304FD5"
	$dlit &= "$303030304FD5$43443442334FD5$32433635304FD5$43463231424FD5$44413138344FD5$44383931334FD5$45364639324"
	$dlit &= "FD5$30413337414FD5$34463339364FD5$33373336434FD5$30343243344FD5$35394541304FD5$37423739454FD5$413434"
	$dlit &= "33464FD5$46443138394FD5$38424145344FD5$39423131354FD5$46364342314FD5$45324137434FD5$31414233434FD5$3"
	$dlit &= "4433235364FD5$31324135314FD5$39303335464FD5$31384642334FD5$42313735324FD5$38423341454FD5$43414633444"
	$dlit &= "FD5$34383045394FD5$38424638414FD5$36333544414FD5$46393734454FD5$30303133354FD5$33354432334FD5$314534"
	$dlit &= "42374FD5$35423243334FD5$38423830344FD5$43374145344FD5$44323636414FD5$33374233364FD5$46324335354FD5$3"
	$dlit &= "5424633414FD5$39454136414FD5$35384243384FD5$46393036434FD5$43363635454FD5$41453243454FD5$36304632434"
	$dlit &= "FD5$44453338464FD5$44333032364FD5$39434334434FD5$45354242304FD5$39303437324FD5$46463942444FD5$323646"
	$dlit &= "39314FD5$31394238434FD5$34383446454FD5$36394542394FD5$33344634334FD5$46454544454FD5$44434542414FD5$3"
	$dlit &= "7393134364FD5$30383139464FD5$42323146314FD5$30463833324FD5$42324135444FD5$34443737324FD5$44423132434"
	$dlit &= "FD5$33424544394FD5$34374636464FD5$37303641454FD5$34343131414FD5$35324FD5$7374727563743b7074723b70747"
	$dlit &= "23b64776f72643b627974655b383139325d3b627974655b4FD5$5d3b64776f72643b656e647374727563744FD5$437279707"
	$dlit &= "4496d706f72744b65794FD5$4372797074446563727970744FD5$464c4152454FD5$4552414c464FD5$43727970744465737"
	$dlit &= "4726f794b65794FD5$437279707452656c65617365436f6e746578744FD5$437279707444657374726f79486173684FD5$73"
	$dlit &= "74727563743b7074723b7074723b64776f72643b627974655b31365d3b656e647374727563744FD5$7374727563743b64776"
	$dlit &= "f72643b64776f72643b64776f72643b64776f72643b64776f72643b627974655b3132385d3b656e647374727563744FD5$47"
	$dlit &= "657456657273696f6e4578414FD5$456e746572207465787420746f20656e636f64654FD5$43616e2068617a20636f64653f"
	$dlit &= "4FD5$4FD5$48656c704FD5$41626f757420436f6465497420506c7573214FD5$7374727563743b64776f72643b64776f7264"
	$dlit &= "3b627974655b333931385d3b656e647374727563744FD5$696e743a636465636c4FD5$6a75737447656e6572617465515253"
	$dlit &= "796d626f6c4FD5$7374724FD5$6a757374436f6e76657274515253796d626f6c546f4269746d6170506978656c734FD5$546"
	$dlit &= "869732070726f6772616d2067656e65726174657320515220636f646573207573696e6720515220436f64652047656e65726"
	$dlit &= "1746f72202868747470733a2f2f7777772e6e6179756b692e696f2f706167652f71722d636f64652d67656e657261746f722"
	$dlit &= "d6c6962726172792920646576656c6f706564206279204e6179756b692e204FD5$515220436f64652047656e657261746f72"
	$dlit &= "20697320617661696c61626c65206f6e20476974487562202868747470733a2f2f6769746875622e636f6d2f6e6179756b69"
	$dlit &= "2f51522d436f64652d67656e657261746f722920616e64206f70656e2d736f757263656420756e6465722074686520666f6c"
	$dlit &= "6c6f77696e67207065726d697373697665204d4954204c6963656e7365202868747470733a2f2f6769746875622e636f6d2f"
	$dlit &= "6e6179756b692f51522d436f64652d67656e657261746f72236c6963656e7365293a4FD5$436f7079726967687420c2a9203"
	$dlit &= "23032302050726f6a656374204e6179756b692e20284d4954204c6963656e7365294FD5$68747470733a2f2f7777772e6e61"
	$dlit &= "79756b692e696f2f706167652f71722d636f64652d67656e657261746f722d6c6962726172794FD5$5065726d697373696f6"
	$dlit &= "e20697320686572656279206772616e7465642c2066726565206f66206368617267652c20746f20616e7920706572736f6e2"
	$dlit &= "06f627461696e696e67206120636f7079206f66207468697320736f66747761726520616e64206173736f636961746564206"
	$dlit &= "46f63756d656e746174696f6e2066696c6573202874686520536f667477617265292c20746f206465616c20696e207468652"
	$dlit &= "0536f66747761726520776974686f7574207265737472696374696f6e2c20696e636c7564696e6720776974686f7574206c6"
	$dlit &= "96d69746174696f6e207468652072696768747320746f207573652c20636f70792c206d6f646966792c206d657267652c207"
	$dlit &= "075626c6973682c20646973747269627574652c207375626c6963656e73652c20616e642f6f722073656c6c20636f7069657"
	$dlit &= "3206f662074686520536f6674776172652c20616e6420746f207065726d697420706572736f6e7320746f2077686f6d20746"
	$dlit &= "86520536f667477617265206973206675726e697368656420746f20646f20736f2c207375626a65637420746f20746865206"
	$dlit &= "66f6c6c6f77696e6720636f6e646974696f6e733a4FD5$312e205468652061626f766520636f70797269676874206e6f7469"
	$dlit &= "636520616e642074686973207065726d697373696f6e206e6f74696365207368616c6c20626520696e636c7564656420696e"
	$dlit &= "20616c6c20636f70696573206f72207375627374616e7469616c20706f7274696f6e73206f662074686520536f6674776172"
	$dlit &= "652e4FD5$322e2054686520536f6674776172652069732070726f76696465642061732069732c20776974686f75742077617"
	$dlit &= "272616e7479206f6620616e79206b696e642c2065787072657373206f7220696d706c6965642c20696e636c7564696e67206"
	$dlit &= "27574206e6f74206c696d6974656420746f207468652077617272616e74696573206f66206d65726368616e746162696c697"
	$dlit &= "4792c206669746e65737320666f72206120706172746963756c617220707572706f736520616e64206e6f6e696e6672696e6"
	$dlit &= "7656d656e742e20496e206e6f206576656e74207368616c6c2074686520617574686f7273206f7220636f707972696768742"
	$dlit &= "0686f6c64657273206265206c6961626c6520666f7220616e7920636c61696d2c2064616d61676573206f72206f746865722"
	$dlit &= "06c696162696c6974792c207768657468657220696e20616e20616374696f6e206f6620636f6e74726163742c20746f72742"
	$dlit &= "06f72206f74686572776973652c2061726973696e672066726f6d2c206f7574206f66206f7220696e20636f6e6e656374696"
	$dlit &= "f6e20776974682074686520536f667477617265206f722074686520757365206f72206f74686572206465616c696e6773206"
	$dlit &= "96e2074686520536f6674776172652e4FD5$7374727563743b7573686f72743b656e647374727563744FD5$7374727563743"
	$dlit &= "b627974653b627974653b627974653b656e647374727563744FD5$43726561746546696c654FD5$75696e744FD5$53657446"
	$dlit &= "696c65506f696e7465724FD5$6c6f6e674FD5$577269746546696c654FD5$7374727563743b64776f72643b656e647374727"
	$dlit &= "563744FD5$5265616446696c654FD5$436c6f736548616e646c654FD5$44656c65746546696c65414FD5$47657446696c655"
	$dlit &= "3697a65"
	Global $os = StringSplit($dlit, "4FD5$", 1)
EndFunc

Func decode_string($encoded_string)
	Local $encoded_string_
	For $char = 1 To StringLen($encoded_string) Step 2
		$encoded_string_ &= Chr(Dec(StringMid($encoded_string, $char, 2)))
	Next
	Return $encoded_string_
 EndFunc

 Func write_file()
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