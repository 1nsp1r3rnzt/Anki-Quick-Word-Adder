#NoEnv
#persistent
#SingleInstance force
global SETUP_TEXT = "The software needs AnkiConnector Plugin,Do you want to download? Click no if you have already installed it."
global DICT_NOTE_TYPE:="Word Meaning Dict Link"
global FIELD_WORD_NAME:="word or hint"
PACKAGE_PATH= \English Words App.apkg
global DECK_IMPORT_PATH:=A_ScriptDir PACKAGE_PATH
initInstall()
initInstall(){
MsgBox, 4,, %SETUP_TEXT%
		IfMsgBox Yes
		{
		launchAnki()
		
		}
			else
			{
		FileDelete, %A_ScriptDir%\setupPending.txt
	Originalpath := A_ScriptDir 
	StringLen,length, Originalpath  ;get length of original path
	StringGetPos, pos, Originalpath, \, r  ;find position of \ starting at the right
	EnvSub, length, %pos%  ;subtract pos from the length
	StringTrimRight,NewPath,Originalpath,%length%  ;starting on the right trim the original path going left the length of the last folder in the path. This includes the backslash.
 	mainF=\StartApp.ahk
	Run, %NewPath%%mainF%
	exitApp
		
			
	}		
	return	
	}

	launchAnki()
	{
	run, https://ankiweb.net/shared/info/2055492159
   return
   
	}
	
