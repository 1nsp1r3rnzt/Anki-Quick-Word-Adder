SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global wordFile = "helper\words.txt"
searchForImageLocal(wordToFind){
	
	if FileExist(wordFile)
	{
		
		Loop, read, %wordFile%
		{
			Haystack := A_LoopReadLine
			
			If InStr(Haystack, wordToFind)
			{
			global imagePath:=A_LoopReadLine
			return true
			break
			}
						
			
		}
	}
	else
	
	{
	msgbox, File does not exist
	return
	}
	
	Return
}