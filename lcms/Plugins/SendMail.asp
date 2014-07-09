<!--#include file="../inc/Common.asp"-->
<!--#include file="../inc/Jmail.asp"-->
<%
Function LoadFile(ByVal sFilePath)
	Dim MapPath, FS, F, temp
	MapPath = Server.MapPath(sFilePath)
	Set FS = Server.CreateObject(LONE_FSO)
	If FS.FileExists(MapPath) Then
		Set F = FS.OpenTextFile(MapPath, 1, True)
		temp = F.ReadAll()
		LoadFile = temp
		temp = Empty 
	End If
	Set F = Nothing
	Set FS = Nothing
End Function

Function ReplaceItems(ByVal sContent)
	Dim temp
	temp = sContent
	For Each Field In Request.Form
		temp = Replace(temp, "{$_"&Field&"}", Replace(Request.Form(Field), vbNewLine, "<br />"))
	Next
	ReplaceItems = temp
	temp = Empty 
End Function

Function ReturnMsg(ByVal vMsg, ByVal vFlag)
	Dim script
	script = "<script language=javascript>"
	If vMsg<>"" Then
		script = script & "alert('" & vMsg & "');"
	End If 
	If vFlag Then
		script = script & "location.href = '" & Request.ServerVariables("HTTP_REFERER") & "';"
	Else
		script = script & "history.back();"
	End If
	script = script & "</script>"
	Response.Write (script)
End Function

Dim Jmail, MailContent, SendStatus

Set Jmail = New Cls_Jmail
SendStatus = False 
MailContent = LoadFile(Lone_MailTemplate)
MailContent = ReplaceItems(MailContent)

Jmail.Subject = Lone_Subject
Jmail.FromMail = Lone_FromMail
Jmail.FromName = Lone_FromName
Jmail.ToMail = Lone_ToMail
Jmail.SMTPHost = Lone_SMTPHost
Jmail.SMTPUser = Lone_SMTPUser
Jmail.SMTPPass = Lone_SMTPPass
Jmail.CharSet = Lone_CharSet
Jmail.MailBody = MailContent

If Jmail.Log<>"Error" Then
	SendStatus = JMail.Send()
End If

Set Jmail = Nothing

If SendStatus Then
	ReturnMsg Lone_SucMessage, True
Else
	ReturnMsg Lone_ErrMessage, False
End If

%>