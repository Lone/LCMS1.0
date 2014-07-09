<!--#include file="../inc/Common.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
validkey = Session(Lone.CacheName & "_ValidKey")
If validkey="" Then
	Logout
Else
	If Trim(Request.form(validkey))=validkey Then
		ChkLogin
	Else
		Logout
	End If
End If

Set Lone_Data = Nothing
Set Lone = Nothing

Sub Logout()
	'Session.TimeOut = 1
	Session.Abandon()
	Response.Cookies(Lone.CacheName)("Admin_ID") = Empty
	Response.Cookies(Lone.CacheName)("Admin_Name") = Empty
	Response.Cookies(Lone.CacheName)("Admin_Level") = Empty
	Response.Cookies(Lone.CacheName)("Admin_Options") = Empty
	Response.Cookies(Lone.CacheName).Expires=DateAdd("n",0,now())
	Response.Redirect("./")
End Sub

Sub ChkLogin()
	Dim ChkCode,sLog
	ChkCode = Trim(Session("GetCode"))
	Session("GetCode")=""
	If LCase(Trim(Request.Form("CheckCode")))<>LCase(ChkCode) Then
		ErrMsg = "验证码不正确，请重试。"
		Call MsgBox(ErrMsg,"gourl","./")
	End If
	Dim userpwd	,UserName
	userpwd	= Trim(Request.Form("password"))
	username = Checkstr(Trim(Request.Form("username")))
	userpwd	= md5(userpwd)

	sql = "select * from LCMS_Administrator Where " &_
	"Admin_UserName='" & username & "' And Admin_PassWord='"&userpwd&"'"


	set Rs = Lone.Execute(sql)
	If Rs.EOF Then
		sLog = "Error: " & username & "登录失败."
		Lone.AddToLog(sLog)
		MsgBox "您输入了错误的帐号或口令，请再次输入.","gourl","./"
	End If
	If Rs("Admin_Usableness")=0 Then
		MsgBox "您的帐号已被停用，请与管理员联系.","gourl","./"
	End If
	Session(Lone.CacheName & "_ValidKey") = Empty
	Session(Lone.CacheName & "_AdminLogin") = "Yes"
	Response.Cookies(Lone.CacheName)("Admin_ID") = Rs("Admin_Id")
	Response.Cookies(Lone.CacheName)("Admin_Name") = Rs("Admin_UserName")
	Response.Cookies(Lone.CacheName)("Admin_Level") = Rs("Admin_Name")
	Response.Cookies(Lone.CacheName)("Admin_Options") = Rs("Admin_Options")
	Session.TimeOut = 120
	sLog = username & "登录成功."
	Lone.AddToLog(sLog)
	Response.Redirect("./")
End Sub

%>