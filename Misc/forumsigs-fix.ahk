file = forumsigs.txt
IfNotExist, %file%
{
	MsgBox, Signature list does not exists.
	ExitApp
}
FileRead, urls, %file%
StringReplace, urls, urls, `r, , All
StringGetPos, pos, urls, `n
pos++
StringTrimLeft, urls, urls, %pos%
urls := RegExReplace(urls, "^\s+|\s+$")
Sort, urls, U
FileDelete, %file%
FileAppend, [Adblock]`n%urls%`n, %file%
