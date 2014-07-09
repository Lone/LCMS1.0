<!--#include file="../inc/common.asp"-->
<%
Response.CharSet = "gb2312"
On Error Resume Next 
Dim sWidth, sHeight, bImageURL,imgSize
imgSize = Trim(Request.QueryString("size"))

sWidth = PREVIEWIMAGE_WIDTH
sHeight = PREVIEWIMAGE_HEIGHT
If imgSize<>"" Then
	imgSize = Split(imgSize, "*")
	If UBound(imgSize)=1 Then
		If isInteger(imgSize(0)) Then sWidth = CInt(imgSize(0))
		If isInteger(imgSize(1)) Then sHeight = CInt(imgSize(1))
	End If
End If



bImageURL = Trim(Request.QueryString("BI"))
'bImageURL = "/Upload/2007-11/2007111023130645.jpg"
If bImageURL="" Then
	response.write "Error:请先上传大图片。"
	response.End()	
End If

If Not IsObjInstalled("Persits.Jpeg") Then
	response.write "Error:系统未安装ASPJpeg组件。"
	response.End()
End If 

FilePath = Server.MapPath(bImageURL)
FileDir = Left(bImageURL, InstrRev(bImageURL, "/"))
FileName = Mid(bImageURL, InstrRev(bImageURL, "/")+1)
sImageURL = FileDir & "s_" & FileName


Set Img = Server.CreateObject("Persits.Jpeg")
Img.Open FilePath

Img.PreserveAspectRatio = True
If Img.OriginalWidth > sWidth OR Img.OriginalHeight > sHeight Then
	If Img.OriginalWidth > Img.OriginalHeight Then
	   Img.Width = sWidth
	Else
	   Img.Height = sHeight
	End If
End If

If PREVIEWIMAGE_FILLFLAG Then
	Set Jpeg = Server.CreateObject("Persits.Jpeg")
	Jpeg.New sWidth, sHeight, &HFFFFFF
	Jpeg.Canvas.DrawImage (sWidth-Img.Width)/2, (sHeight - Img.Height)/2, Img
	Jpeg.Save Server.MapPath(sImageURL)
	Set Jpeg = Nothing
Else
	Img.Save Server.MapPath(sImageURL)
End If 

If Err Then
	Response.Write "Error:" & "读取数据失败"
Else
	Response.Write("OK:" & sImageURL)
End If 


Set Img = Nothing
Set Lone = Nothing
%>