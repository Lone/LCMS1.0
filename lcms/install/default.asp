<!--#include file="../inc/function.asp"-->
<!--#include file="../inc/ver.asp"-->
<!--#include file="../inc/md5.asp"-->
<%

Response.Buffer = True
Dim Steps
Steps = Trim(Request.QueryString("step"))

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>LCMS V <%=SYS_VERSION %></title>
<link href="../Public/Css/install.css" rel="stylesheet" type="text/css" />
</head>

<body>
<h1 id="logo"><img src="../Public/Images/Manage/Main.gif" width="394" height="71" /></h1>
<%
Select Case Steps
Case "1" : Step1
Case "2" : Step2
Case Else : Main
End Select 
%>

<%
Sub Step1
If Not IsObjInstalled("SCRIPTING.FILESYSTEMOBJECT") Then
	Response.Write("<p class=alert>您的服务器不支持FSO，无法使用LCMS提供的功能。</p>")
	Response.Flush()
	Response.End()
End if
If Not IsObjInstalled("MSXML2.XMLHTTP") Then
	Response.Write("<p class=alert>您的服务器不支持XMLHTTP，无法使用LCMS提供的功能。</p>")
	Response.Flush()
	Response.End()	
End if
If Not IsObjInstalled("ADODB.STREAM") Then
	Response.Write("<p class=alert>您的服务器不支持ADODB.STREAM，无法使用LCMS提供的功能。</p>")
	Response.Flush()
	Response.End()	
End if
If Not IsObjInstalled("SCRIPTING.DICTIONARY") Then
	Response.Write("<p class=alert>您的服务器不支持DICTIONARY，无法使用LCMS提供的功能。</p>")
	Response.Flush()
	Response.End()	
End if
Dim db
db = trim(Request.QueryString("db"))
If db<>"1" Then db="2"

%>

<form name="form1" action="?step=2" method="post">
<input type="hidden" name="db" value="<%=db%>" />
<h2>数据库配置</h2>
<% If db="1" Then %>
<p>
	服务器地址：<input type="text" name="db_host" class="border" value="localhost" /><br />
    数据库名称：<input type="text" name="db_name" class="border" value="" /><br />
    登录用户名：<input type="text" name="db_user" class="border" value="" /><br /> 
    登录密　码：<input type="text" name="db_pwds" class="border" value="" /><br />        
</p>
<% Else %>
<p>
	数据库路径：<input type="text" name="db_host" size="30" class="border" value="/data/lcms<%=replace(SYS_VERSION, " ", "_") %>.mdb" /><br />
    请使用相对于服务器根目录的路径。	
</p>
<% End If%>
<h2>静态页发布配置</h2>
<p>
	默认页面：<input type="text" name="index_name" class="border" value="default.shtml" /><br />
    允许包含：<input type="radio" name="allow_inc" value="False" checked="checked" /> 是
    <input type="radio" name="allow_inc" value="True" /> 否
    <br />
        
</p>

<p class="step">
	<input type="submit" class="button" value="开始安装" />
</p>
</form>
<%

End Sub
%>
</body>
</html>

<% Sub Main %>

<p>欢迎使用LCMS <%=SYS_VERSION %> 内容管理系统！</p>


<p>如果你不想使用/LCMS/做为后台管理入口，可以先修改这个目录名称后再运行此安装程序。</p>

<p>LCMS系统要求服务器有FSO写入权限，否则无法正常安装。</p>

<p>请选择数据库类型进行安装：</p>

<p class="step">
	<a href="?step=1&db=1" class="button">MS SQL Server</a>
	<a href="?step=1&db=2" class="button">MS Access</a>
</p>
<p>如果您使用MS SQL Server做为数据库，请确认您已经拥有以下信息：</p>
<ol>
	<li>数据库名称</li>
	<li>数据库用户名</li>
	<li>数据库密码</li>
	<li>数据库主机地址</li>
</ol>
<% End Sub %>

<%
Sub Step2
	Dim db
	Dim db_host, db_name, db_user, db_pwds
	Dim Conn, ConnString
	Dim Settings
		
	On Error Resume Next	
	db_host = trim(request.Form("db_host"))
	db_name = trim(request.Form("db_name"))	
	db_user = trim(request.Form("db_user"))	
	db_pwds = trim(request.Form("db_pwds"))
	db = trim(Request.Form("db"))
	If db<>"1" Then db="2"
	Dim WebSite_sn, chkKey
	WebSite_sn = LCase(Request.ServerVariables("HTTP_HOST"))
	chkKey = ""
	SYS_TOKEN = Array(76,111,110,101,67,111,110,116,101,110,116,77,97,110,97,103,101,109,101,110,116,83,121,115,116,101,109,86,101,114,50,46,48)	
	For I=0 To UBound(SYS_TOKEN)
		If IsNumeric(SYS_TOKEN(I)) Then
			chkKey = chkKey & Chr(SYS_TOKEN(I))
		Else
			chkKey = chkKey & SYS_TOKEN(I)
		End If
	Next
	chkKey = chkKey & WebSite_sn
	
	ThisPath = lcase(Request.ServerVariables("PATH_INFO"))
	ThisPath = Left(ThisPath, Instr(ThisPath, "/install")-1)
	
	If db = "1" Then 
		ConnString = "User ID="&db_user&"; Password="&db_pwds&"; Initial Catalog="&db_name&"; Data Source="&db_host&";"
	Else
		ConnString = db_host
	End If
	
	Settings = "<" & "%" & vbNewLine 
	Settings = Settings & "Const IsDeBug = 0 " & vbNewLine 
	Settings = Settings & "Const DatabaseType = " & db & vbNewLine
	Settings = Settings & "Const ConnectionString = """ & ConnString & """" & vbNewLine 
	Settings = Settings & "Const SystemDirectory = """ & ThisPath & """" & vbNewLine 
	Settings = Settings & "Const LONE_XMLHTTP = ""MSXML2.XMLHTTP""" & vbNewLine 
	Settings = Settings & "Const LONE_STREAM = ""ADODB.STREAM""" & vbNewLine 
	Settings = Settings & "Const LONE_FSO = ""SCRIPTING.FILESYSTEMOBJECT""" & vbNewLine 
	Settings = Settings & "Const LONE_DICTIONARY = ""SCRIPTING.DICTIONARY""" & vbNewLine 
	Settings = Settings & "Const DEFAULT_FILENAME = """ & Trim(Request.Form("index_name")) & """" & vbNewLine 
	Settings = Settings & "Const LONE_STATIC_HTML = " & Trim(Request.Form("allow_inc")) & vbNewLine 
	Settings = Settings & "Const PREVIEWIMAGE_WIDTH = 150" & vbNewLine 
	Settings = Settings & "Const PREVIEWIMAGE_HEIGHT = 150" & vbNewLine 
	Settings = Settings & "Const PREVIEWIMAGE_FILLFLAG = True" & vbNewLine 
	Settings = Settings & "Const LONE_CMS_SN = """ & CGL_makeDataBasePWD(chkKey, 18) & """" & vbNewLine 
	Settings = Settings & "Const LONE_UPDATE_SERVER = ""http://lcms.zhuiyun.net/""	" & vbNewLine 	
	Settings = Settings & "%" & ">"
	
	If SaveToFile(Settings, "/config.asp") Then
		Response.Write ("<p>创建配置文件config.asp完成。</p>")
		Response.Flush()
	Else
		Response.Write ("<p class=alert>安装程序无法创建配置文件，请确认服务器有写入权限。</p>")
		Response.Flush()
		Exit Sub
	End If
	
	
	
	If db = "1" Then
		
		Set Conn = Server.CreateObject("ADODB.Connection")
		Conn.open "Provider = Sqloledb;" & ConnString
		If Err Then
			Set Conn = Nothing
			Response.Write "<p class=alert>无法创建与数据库服务器的连接。</p>"
			Response.Flush()
			err.Clear
			Exit Sub
		End If
		
		sql = LoadFile("db/sql.sql")
		sqls = split(sql, "GO")
		Response.Write("<p>")
		For I=0 To Ubound(sqls)
			sql = sqls(I)
			DoInstall = Left(sql, Instr(sql, "(")-1)
			Conn.Execute(sql)
			Response.Write ""&DoInstall&"...完成。<br />"
			Response.Flush()	
		Next
		Response.Write("</p>")
		
		sql = "CREATE TRIGGER [UpdateChildCount] ON [LCMS_Menu] " & vbCRLF
		sql = sql & "FOR INSERT,  DELETE " & vbCRLF
		sql = sql & " AS " & vbCRLF
		sql = sql & "Update LCMS_Menu  Set Menu_Child_Count = (" & vbCRLF
		sql = sql & "	select count(*) from LCMS_Menu B where B.Menu_Parent_Id=LCMS_Menu.Menu_Id" & vbCRLF
		sql = sql & ")"
		Conn.Execute(sql)
		
		sql = LoadFile("db/sql_data.sql")
		Conn.Execute(sql)	
		
		Response.Write("<p>初始化数据...完成。</p>")	
		
		Response.Write("<p class=alert>预设管理员帐号：lone 密码：admin，请登录后修改。</p>")
		Response.Flush()			
		
	Else
		Dim FS, F
		Call AutoCreateDirectory (ConnString)
		Set FS = Server.CreateObject("SCRIPTING.FILESYSTEMOBJECT")
		FS.CopyFile Server.MapPath("db/access.sql"), Server.MapPath(ConnString), True
		Set FS = Nothing
		
		Response.Write("<p>安装数据库文件"&ConnString&"...完成。</p>")
		
		Response.Write("<p>初始化数据...完成。</p>")	
		
		Response.Write("<p class=alert>预设管理员帐号：admin 密码：admin888，请登录后修改。</p>")
		Response.Flush()
	
	End If
	
	Response.Write("<p class=step><a href=""../system/"" class=""button"">登录管理后台</a></p>")
	Response.Flush()
	
	KillInstall ThisPath

End Sub


Function SaveToFile(ByVal strBody, ByVal File)
	Dim objStream
	SaveToFile = True
	On Error Resume Next
	Set objStream = Server.CreateObject("ADODB.STREAM")

	With objStream
		.Type = 2
		.Open
		.Charset = "GB2312"
		.Position = objStream.Size
		.WriteText = strBody
		.SaveToFile Server.MapPath(File), 2
		.Cancel()
		.Close()
	End With
	Set objStream = Nothing
	
	If Err Then 
		SaveToFile = False
		Err.Clear
	End if 
End Function

Function AutoCreateDirectory(strdir)
	Dim FS, MapPath, Dir, I
	MapPath = Server.MapPath("/")
	Set FS = Server.CreateObject("SCRIPTING.FILESYSTEMOBJECT")
	Dir = Split(strdir, "/")
	For I=1 To UBound(Dir)-1
		MapPath = MapPath & "\" & Dir(I)
		If Not FS.FolderExists(MapPath) Then
			Fs.CreateFolder(MapPath)
		End If
	Next
	Set FS = Nothing		
End Function

Function LoadFile(sFilePath)
	Dim MapPath, FS, F, temp
	MapPath = Server.MapPath(sFilePath)
	Set FS = Server.CreateObject("SCRIPTING.FILESYSTEMOBJECT")
	If FS.FileExists(MapPath) Then
		Set F = FS.OpenTextFile(MapPath, 1, True)
		temp = F.ReadAll()
		LoadFile = temp
		temp = Empty 
	End If
	Set F = Nothing
	Set FS = Nothing
End Function

Sub KillInstall(byval sysDir)
	Set FS = Server.CreateObject("SCRIPTING.FILESYSTEMOBJECT")
	Set FO = FS.GetFolder(Server.MapPath(sysDir&"/install"))
	FO.Delete(True)
	Set FO = Nothing
	Set FS = Nothing
End Sub
%>