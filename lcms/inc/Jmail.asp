<%
Class Cls_Jmail
Public SMTPHost, SMTPUser, SMTPPass
Public FromMail, FromName, ToMail, ToMailcc
Public Subject, MailBody
Public Silent, Logging, CharSet, Priority, Log
Private JMail

Private Sub Class_Initialize()
	FromMail = "goebar@goebar.com"
	FromName = "购易吧(GOEBAR.COM)"
	SMTPHost = "mail.gomye.net"
	SMTPUser = "lone@gomye.net"
	SMTPPass = "lone"
	Priority = 3
	If IsObjInstalled("JMail.Message") Then
		Set JMail=Server.CreateObject("JMail.Message")
		Log = ""
	Else
		Log = "Error"
	End If
	Silent = True
	Logging = True
	CharSet = "gb2312"
	Log = ""
End Sub

Public Function Send()
	Dim toMails
	JMail.Silent = Silent
	jmail.Logging = Logging
	JMail.CharSet = CharSet
	JMail.From = FromMail
	If FromName<>"" Then Jmail.FromName = FromName
	JMail.Subject = Subject
	JMail.Recipients.Clear '清除已经存在的收件人。
	toMails = Split(ToMail, ";")
	For Each Mail In toMails
		If IsValidEmail(Mail) Then
			JMail.AddRecipient Mail
		End If 
	Next
	If ToMailcc <> "" Then JMail.AddRecipientCC ToMailcc
	If SMTPUser <> "" Then JMail.MailServerUserName = SMTPUser
	If SMTPPass <> "" Then JMail.MailServerPassword = SMTPPass
	JMail.HTMLBody = MailBody
	JMail.Body = LoseHTML(MailBody)
	JMail.Priority = Priority
	Send = JMail.Send(SMTPHost)
	Log = JMail.Log
End Function

Public Function IsValidEmail(username)
	If Trim(username)="" Then
		IsValidEmail = False
	Else
		Set re=new RegExp
			re.IgnoreCase =true
			re.Global=True
			re.Pattern = "^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
		chkstr = re.Replace(username, "")
		If chkstr="" Then
			IsValidEmail = True
		Else
			IsValidEmail = False
		End If
	End If
End Function

Private Function LoseHTML(strHTML)
	On Error Resume Next 
	Dim objRegExp, strOutput
	Set objRegExp = New Regexp
	objRegExp.IgnoreCase = True
	objRegExp.Global = True
	objRegExp.Pattern = "<.+?>"
	strHTML = strHTML & ""
	if strHTML="" Then LoseHTML="":Exit Function
	strOutput = objRegExp.Replace(strHTML, "")
	strOutput = Replace(strOutput, "<", "&lt;")
	strOutput = Replace(strOutput, ">", "&gt;")
	strOutput = Replace(strOutput, "&nbsp;", "")
	LoseHTML = Trim(strOutput)
 Set objRegExp = Nothing
End Function

Private Sub Class_Terminate()
JMail.Close
Set JMail=Nothing
If Err Then Err.Clear()
End Sub
End Class
%>