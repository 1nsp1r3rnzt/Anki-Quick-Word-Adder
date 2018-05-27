#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#Include <JSON>
#Include %A_ScriptDir%\dictApi.ahk
#Include %A_ScriptDir%\helper\dict.ahk
#Include %A_ScriptDir%\helper\checkUrlStatus.ahk
#Include %A_ScriptDir%\helper\searchImageLocal.ahk
#Include %A_ScriptDir%\helper\searchImageFlashMonkey.ahk
#Include %A_ScriptDir%\helper\copyImage.ahk
#Include %A_ScriptDir%\helper\ankiPy.ahk

;;;;;;;;;User settings: 0 or 1;;;;;;;;;;;

;1st image
global ADD_IMAGES_FLASHMONKEY= 0

;2nd image
global ADD_IMAGES_WORDINFO = 0

;add quick meaning from chrome, also needs extension
global MEANING_FROM_CHROME=1


;;;;;;;;;;Default deck and card;;;;;;;;;;;;;;;;;;
global CARD_TYPE = "Work Meaning Dictionary Link"
global DECK_TYPE = "Language::English"

;additional field  name
global FIELD_WORD_NAME= "word or Hint"



;;;;;;;;;;;;DONT CHANGE SETTIINGS BELOW;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;Default settings: Dont change;;;;;;;
global GET_API_LINK="https://developer.oxforddictionaries.com"
global VERSION = "Anki QuickAdder 1.02"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;global keywords: Dont Change;;;;
global word
global meaning
global sentence
global finalMeaning
;;;;;;;;;;;;
initApp()
addMenu()
return

`::
	copyText("word")
	if(word!=null)
	{
		
		StringGetPos, pos, word, %A_Space%
		if (pos >= 0)
		{
		MsgBox, Space found in word: %word% please press the shortcut key to run again.
		exit
		}
	}
	if(MEANING_FROM_CHROME==1)
	{
	copyText("meaning")
	
	}
	else
	{
	meaning=
	}
	copyText("sentence")
	addWordToAnki()
return

copyText(textword)
{
	clearGlobalVariables()	
	clipboard =
	SplashTextOn, 100, 100, Copy %textword%,copy %textword%
	Sleep, 2000 ; wait 4 seconds
	SplashTextOff ; remove the text
	
	ClipWait, 7
	if ErrorLevel
	{
		SplashTextOn, 400, 300, Copy errorrrrrrzs %textword%,copy error %textword%
		Sleep, 2000 ; wait 4 seconds
		SplashTextOff ; remove the text
		return
	}
	textToTrim:=clipboard
	StringReplace, textToTrim, textToTrim, ",' , All
	textToTrim := regexreplace(textToTrim, "^\s+") ;trim beginning whitespace
	textToTrim := regexreplace(textToTrim, "\s+$") ;trim ending whitespace
	%textword% := textToTrim
	clipboard =
	cleanImageFiles()
	return 
}


addWordToAnki(){
	global
	ToolTip, Loading GUI. please Wait
	SetTimer, RemoveToolTip, 4000
	finalMeaning:= findMeaning(findLexicalId(word)) 
	if(meaning="")
	{
	
	}
	else
	{
	;remove . from chrome meaning
	meaningWithoutPeriod := StrReplace(meaning, ".")

	needle = im)%meaningWithoutPeriod%
	
	foundPos := RegExMatch(finalMeaning, needle)  ; 
	if(foundPos){
		meaning=
		;empty the meaning being same
		;msgbox, found meaning
	}
	
	
	}
	
	Gui, New, ,  %VERSION%
	Gui, Add,Text,x10 y10 ,Enter front word
	
	Gui, Add, Edit,h30 w100 x100 y10, %word%
	Gui, Add,Text,x10 y40 ,Enter word
	
	if(MyWord==""){
		Gui, Add, Edit,x100 y40 vMyWord,%word%
	}else  {
		Gui, Add, Edit,x100 y40 vMyWord,%MyWord%
	}
	
	Gui, Add,Text,h30 w100 x10 y70 ,Enter Sentence
	if(MySentence==""){
		Gui, Add, Edit,x100 y70 w340 vMySentence,%sentence%
	}else  {
		Gui, Add, Edit,x100 y70 w340 vMySentence,%MySentence%
	}
	Gui, Add,Text,x10 y130 ,Enter Meaning
	if(MyMeaning==""){
		Gui, Add, Edit,h60 w340 x100 y130 vMyMeaning,%meaning% %finalMeaning%
	}else  {
		Gui, Add, Edit,h60 w340 x100 y130 vMyMeaning,%MyMeaning%
	}
	
	;flashmonkey
	if(ADD_IMAGES_FLASHMONKEY==1){
		if(searchForFlashMonkey(word))
		{
			UrlDownloadToFile,%fullFlashUrl%, images\image2.png
			
			Gui, Add, Picture, x10 y210 w300 h-1, images\image2.png
			Gui, Add, Button, gremoveflashimage, &Remove Picture
		}
	}
	
	if(ADD_IMAGES_WORDINFO==1){
		if(searchForImageLocal(word))
		{
			URL_WORDINFO=http://wordinfo.info/words/images/
			extension=.jpg
			imageFullPath:= URL_WORDINFO imagePath extension
			if(GetUrlStatus(imageFullPath,10)==200)
			{
				UrlDownloadToFile,%imageFullPath%, images\image.jpg
				
				Gui, Add, Picture, x340 y210 w300 h-1 , images\image.jpg
				Gui, Add, Button,gremovewordimage, &Remove Picture
			}
		}
	}
	
	Gui, Add, Button, Default, OK
	Gui, show
	return
}

ButtonOK:
	Gui, Submit  ; Save the input
	Gui Destroy
	if(MyMeaning==null||MySentence==null||MyWord==null){
		msgbox, one of the field is empty. Please add the required field
		addWordToAnki()
		return
	}
	
	if (WinExist("ahk_exe anki.exe") or WinExist("Anki - User 1"))
	{
		;WinActivate  ; Uses the last found window.
		
		sendToAnki()
	}else  {
		run, C:\Program Files (x86)\Anki\Anki.exe
		sleep 4500
		sendToAnki()
	}
return


sendToAnki(){
global
				data = 
				(
				{
			"action": "addNote",
			"version": 6,
			"params": {
				"note": {
				
					"deckName": "%DECK_TYPE%",
					"modelName": "%CARD_TYPE%",
					"fields": {
						"Front": "%MyWord%",
						"Word": "%MyWord%",
						"Back": "%MyMeaning%<br>%MySentence%"
					},
					"tags": [
						
					],
					"audio": {
					}
				}
			}
		}
		)
		URL := "http://127.0.0.1:8765"
		addToAnki( URL,data, 10 )

		
		
		}
cleanImageFiles(){
	If FileExist("images\image.jpg")
	{
		FileDelete,images\image.jpg
	}
	If FileExist("images\image2.png")
	{
		FileDelete, images\image2.png
	}
	
	return
}     

pasteImages(){
	if(ADD_IMAGES_WORDINFO==1)
	{
		If FileExist("images\image.jpg")
		{
			sleep 500
			clipboard:=
			image1path = \images\image.jpg
			fullimagepath:=A_ScriptDir image1path		
			CopyImg(fullimagepath)
			clipwait, 4
			send {enter}
			send ^v
			 sleep 100
			send {enter}
			sleep 100
			send {enter}
			
		}
	}
	
	if(ADD_IMAGES_FLASHMONKEY==1)
	{
		If FileExist("images\image2.png")
		{
			sleep 300
			clipboard:=
			image2path = \images\image2.png
			fullimagepath:=A_ScriptDir image2path
			CopyImg(fullimagepath)
			
			clipwait, 3
			send {enter}
			send ^v
			
			send {enter}
		}
		
	}  
	return
}

removeflashimage:
	Gui, Submit  ;
	checkFlashMenu()
	Gui Destroy
	addWordToAnki()
return

removewordimage:
	Gui, Submit  ;
	checkWebWordMenu()
	Gui Destroy
	addWordToAnki()
	return

FlashToggle&Check:
	checkFlashMenu()
return



WordWebToggle&Check:
checkWebWordMenu()
return

CopyMeaningFromChromeToggle&Check:
checkChromeAddMenu()
return

addMenu()
{
	global
	menu, tray, add ; separator
		menu, tray, add, RESTART,restartApp
		menu, tray, add, Recover Last Word,showUiAgain

	menu, tray, add ; separator
	menu, tray, add, Download Chrome Dictionary Extension,DownloadDictionarychromeExtension
		menu, tray, add ; separator
	
menu, tray, add, FlashToggle&Check
	menu, tray, add, WordWebToggle&Check
		menu, tray, add ; separator

	menu, tray, add, CopyMeaningFromChromeToggle&Check

	
	if(ADD_IMAGES_FLASHMONKEY==1)
	{
		menu, tray, ToggleCheck, FlashToggle&Check
	}
	
	if(ADD_IMAGES_WORDINFO==1)
	{
		menu, tray, ToggleCheck, WordWebToggle&Check
	}
	if(MEANING_FROM_CHROME==1)
	{
		menu, tray, ToggleCheck, CopyMeaningFromChromeToggle&Check
	}
	return
}
checkWebWordMenu()
{
	global
	if(ADD_IMAGES_WORDINFO==1)
	{
		menu, tray, ToggleCheck, WordWebToggle&Check
		ADD_IMAGES_WORDINFO:=0
	}else  {
		menu, tray, ToggleCheck, WordWebToggle&Check
		ADD_IMAGES_WORDINFO:=1
	}
	return
}
checkFlashMenu()
{
	global
	if(ADD_IMAGES_FLASHMONKEY==1)
	{
		menu, tray, ToggleCheck, FlashToggle&Check
		ADD_IMAGES_FLASHMONKEY:=0
	}else  {
		menu, tray, ToggleCheck, FlashToggle&Check
		ADD_IMAGES_FLASHMONKEY:=1
	}
	return
}
checkChromeAddMenu()
{
	global
	if(MEANING_FROM_CHROME==1)
	{
		menu, tray, ToggleCheck, CopyMeaningFromChromeToggle&Check
		MEANING_FROM_CHROME:=0
	}else  {
		menu, tray, ToggleCheck, CopyMeaningFromChromeToggle&Check
		MEANING_FROM_CHROME:=1
	}
	return
}

initApp(){
	;check for setup folder
	If( InStr( FileExist("setup"), "D") )
	{
		if FileExist("setup\setupPending.txt")
		{
			if FileExist("setup\SetupApp.ahk")
			{
				Run,"%A_ScriptDir%\setup\SetupApp.ahk"
				ExitApp
			}
		}else  {
			FileMoveDir, setup, setup-done
			msgbox, Setup files cleaned Successfully. Please restart App by clicking StartApp.ahk
			ExitApp
		}
	}
	
	
	checkForApi()  ;check for API KEYS
	return
}


DownloadDictionarychromeExtension:
Run, https://chrome.google.com/webstore/detail/google-dictionary-by-goog/mgijmajocgfcbeboacabfgobmjgjcoja?hl=en
return

restartApp:
Reload
return     

showUiAgain:
if(MyWord==""||MySentence==""||MyMeaning="")
{
MsgBox, No gui Found
}
else
{

; To have a ToolTip disappear after a certain amount of time
; without having to use Sleep (which stops the current thread):

ToolTip, Loading GUI. please Wait
SetTimer, RemoveToolTip, 5000
addwordToAnki()
}
return     

clearGlobalVariables(){

	global MyWord:=""
	global MyMeaning:=""
	global MySentence:=""
}
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return


