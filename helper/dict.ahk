
findLexicalId(wordoz)
{

checkForApi()
urltoload := "https://od-api.oxforddictionaries.com/api/v1/inflections/en/"
URL = %urltoload%%wordoz%

WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WebRequest.Open("GET",URL)
WebRequest.SetRequestHeader("app_id", APP_ID)
 WebRequest.SetRequestHeader("app_key", APP_KEY)
WebRequest.SetRequestHeader("Content-Type", "application/json")
WebRequest.Send()
Result := WebRequest.ResponseText
statuz:=WebRequest.Status()
if(WebRequest.Status()!=200)
{
msgbox, code not find meaning, error,%statuz% 
return
}
else
{
MyJsonInstance := new JSON()
JsonObject := MyJsonInstance.Load(Result)

for key,valuez in JsonObject.results.1.lexicalEntries.1.inflectionOf[1]

{
 inflectionOf = %valuez%

}

return %inflectionOf%
}
}
findMeaning(wordo)
{
urltoload := "https://od-api.oxforddictionaries.com/api/v1/entries/en/"
URL = %urltoload%%wordo%
WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WebRequest.Open("GET",URL)
WebRequest.SetRequestHeader("app_id",APP_ID)
 WebRequest.SetRequestHeader("app_key",APP_KEY)
WebRequest.SetRequestHeader("Content-Type", "application/json")
WebRequest.Send()
Result := WebRequest.ResponseText
MyJsonInstance := new JSON()
if(WebRequest.status!=200)
{
return 
}
else
{
JsonObject := MyJsonInstance.Load(Result)

for key,value in JsonObject.results[1].lexicalEntries[1].entries[1].senses[1].definitions

{
 definationFirst = %value%
}
for key,value in JsonObject.results[1].lexicalEntries[1].entries[1].senses[2].definitions

{
 definationSecond = %value%
}

if(definationSecond)
{

Var = <br>1. %definationFirst%<br>2. %definationSecond%  ; Add more text to the variable via another continuation section.
(

)

return %Var%
}
else
{
return %definationFirst%
}
}

}

checkForApi(){
if(APP_ID==""||APP_KEY=="")
{

MsgBox, 4, , Please set your APP_ID and APP_key in dictApi.ahk. click Yes to get Your Api Keys from %GET_API_LINK% or No to exit, 
IfMsgBox, No
		exitApp
IfMsgBox, yes
    
	Run Edit "dictApi.ahk"
	sleep 2000
	run, %GET_API_LINK%
; Otherwise, continue:

exitApp
}}