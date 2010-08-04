#NoTrayIcon
SetBatchLines, 10ms
Process, Priority, , R

b = 0 ; UTC bias (e.g. -1030, 8000)
t = %A_Temp%\time.dat

Loop {
	UrlDownLoadToFile, http://time.nist.gov:13/, %t%
	If ErrorLevel = 0
		Break
	If A_Index = 25
		ExitApp
	Sleep, 2500
}

FileRead, ntp, %t%
FileDelete, %t%
If ntp !=
{
	VarSetCapacity(t, 8 * 4, 0)
	StringSplit, t, ntp, -`t :
	NumPut(2000 + t2, t, 0, "Short")
	NumPut(t3, t, 2, "Short")
	NumPut(t4, t, 6, "Short")
	NumPut(t5 + b0 := Floor(b / 100), t, 8, "Short")
	NumPut(t6 - b0 * 100, t, 10, "Short")
	NumPut(t7, t, 12, "Short")
	DllCall("SetSystemTime", "UInt", &t)
	PostMessage, 0x1e, , , , ahk_id 0xffff ; broadcast WM_TIMECHANGE
}
