
addToAnki( URL,data, Timeout = -1 )
{
		HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		HttpObj.Open("POST", URL, 0)
		HttpObj.SetRequestHeader("Content-Type", "application/json")
		Body := data
		HttpObj.Send(Body)
		Result := HttpObj.ResponseText
		status := HttpObj.Status
		if(Status==200)
		{
		
		MyJsonInstance := new JSON()
		JsonObject := MyJsonInstance.Load(result)
		errorz:= % JsonObject.error 
		resultz:= % JsonObject.result 
		
		if(resultz)
		{
		SplashTextOn, 400, 300, Anki Adder,Added Successfully.
		Sleep, 2000 ; wait 4 seconds
		SplashTextOff ; remove the text
		}
		else if(findRegex("Note is duplicate", errorz))
		{
		msgbox,note is duplicate.
		}
		
		else if(findRegex("Collection was not found", errorz))
		{
				msgbox,Collection not found. please reload anki.

		}
		else
		{
			msgbox,UnKnown Error: %errorz%
		}
		
		
		}
	
	}
	
	findRegex(findwhat, findin)
	{
			findregex:= "iU)(.*?) . findwhat . (.*?)"

			FoundPos := RegExMatch(findin,findregex )  ; Returns 7 because the $ requires the match to be at the end.
			if(findwhat)
			{
			if(FoundPos)
			{
			return true
			}
			else
			{
			return false
			}
			}
			else{
			return false
			}
	}
		
	