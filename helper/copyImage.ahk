#NoEnv
#SingleInstance force
#Include <WinClipAPI>	; http://www.autohotkey.com/board/topic/74670-class-winclip-direct-clipboard-manipulations/
#Include <WinClip>
SetBatchLines, -1


	;InputBox, ImageFile, Copy image to clipboard, Please input image path`, or image url:,, 500, 120
	;if ErrorLevel
	;	Return

	;;CopyImg(ImageFile)

	;ToolTip, % "`n`n" A_Tab "Copied!" A_Tab A_Tab "`n`n"
	;Sleep, 2000
	;ToolTip
;Return

CopyImg(ImageFile)
{
	; Expand to full path
	if !RegExMatch(ImageFile, "i)^(https?|ftp)://")
	{
		Loop, %ImageFile%
			ImageFile := A_LoopFileLongPath
	}

	html =
	(LTrim
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

		<HTML><HEAD></HEAD>

		<BODY><!--StartFragment--><IMG src="%ImageFile%"><!--EndFragment--></BODY>
		</HTML>
	)

	WinClip.Clear()
	WinClip.SetHTML( html )

	if RegExMatch(ImageFile, "i)^(https?|ftp)://")
		return

	WinClip.SetFiles( ImageFile )
	WinClip.SetBitmap( ImageFile )
	return
}