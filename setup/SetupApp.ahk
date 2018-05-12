#NoEnv
#persistent
#SingleInstance force
global SETUP_TEXT = "The software will try to open Anki,Then, Please save your cards if your are editing right now and close Anki. Press yes, to add card and deck type. Press No, if you already have a Deck for English Cards"
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
		addDeckType()
		}
			else
			{
		
		MsgBox,,, This software needs custom Card type. Import English Words App.apkg by yourself. Refer to instructions.
		exitApp
			
	}		
	return	
	}

	launchAnki()
	{
	
	if (WinExist("ahk_exe anki.exe") or WinExist("Anki - User 1"))
   {
      WinActivate  ; Uses the last found window.
     msgbox, This will edit your Anki to add new deck and new card type so that the software can process,Please don't press any key or move your mouse. Thanks. 
	 return
		
		
   }
   else  {
      if FileExist("C:\Program Files (x86)\Anki\Anki.exe")
	  {
	  
	  run, C:\Program Files (x86)\Anki\Anki.exe
	  sleep,2000
	  }
	  else
	  {
		MsgBox, Anki is not installed at default location. Please open Anki and run this software again.
	  }
      sleep 4500
      return
	  
   }
   return
   
	}
	
	
	
	addDeckType(){
	if (WinExist("ahk_exe anki.exe") or WinExist("Anki - User 1"))
   {
      WinActivate  ; Uses the last found window.	
	  sleep, 2000
	 send {ctrl down}
	send i
	send {ctrl up}
	sleep 100
	 send %DECK_IMPORT_PATH%
	 send {enter}
	 sleep, 2000
	Process,Close,anki.exe
	sleep 200
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
   else
   {
   msgbox, Anki is not running
   return
   }
	
	}
	
	
	