GetUrlStatus( URL, Timeout = -1 )
{
		ComObjError(0)
		static WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		WinHttpReq.Open("get", URL)
		WinHttpReq.Send()

		WinHttpReq.WaitForResponse(Timeout) ; Return: Success = -1, Timeout = 0, No response = Empty String
		
		Return, WinHttpReq.Status()
}