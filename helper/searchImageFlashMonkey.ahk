global FLASHMONKEYURL="http://flashcardmonkey.com/"
searchForFlashMonkey( wordToFind)
	{
fullurl :=FLASHMONKEYURL wordToFind
	if(GetUrlStatus(fullurl,10)==200)
		{	 
		winReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		winReq.Open("GET", fullurl, true)
		winReq.Send()
		winReq.WaitForResponse()
		HtmlText := winReq.ResponseText
		
		FoundImagePos := RegExMatch(HtmlText, "imU)<meta name=""twitter:image"" content=""(.*)"" />", SubPat)  ;
	
		if(FoundImagePos)
		{ 
			global fullFlashUrl := SubPat1
			return, true
		
		}
		else
		{
		return
		}
}
else
{
return
}
}