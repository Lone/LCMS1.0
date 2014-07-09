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
	Response.Write("<p class=alert>���ķ�������֧��FSO���޷�ʹ��LCMS�ṩ�Ĺ��ܡ�</p>")
	Response.Flush()
	Response.End()
End if
If Not IsObjInstalled("MSXML2.XMLHTTP") Then
	Response.Write("<p class=alert>���ķ�������֧��XMLHTTP���޷�ʹ��LCMS�ṩ�Ĺ��ܡ�</p>")
	Response.Flush()
	Response.End()	
End if
If Not IsObjInstalled("ADODB.STREAM") Then
	Response.Write("<p class=alert>���ķ�������֧��ADODB.STREAM���޷�ʹ��LCMS�ṩ�Ĺ��ܡ�</p>")
	Response.Flush()
	Response.End()	
End if
If Not IsObjInstalled("SCRIPTING.DICTIONARY") Then
	Response.Write("<p class=alert>���ķ�������֧��DICTIONARY���޷�ʹ��LCMS�ṩ�Ĺ��ܡ�</p>")
	Response.Flush()
	Response.End()	
End if
Dim db
db = trim(Request.QueryString("db"))
If db<>"1" Then db="2"

%>

<form name="form1" action="?step=2" method="post">
<input type="hidden" name="db" value="<%=db%>" />
<h2>���ݿ�����</h2>
<% If db="1" Then %>
<p>
	��������ַ��<input type="text" name="db_host" class="border" value="localhost" /><br />
    ���ݿ����ƣ�<input type="text" name="db_name" class="border" value="" /><br />
    ��¼�û�����<input type="text" name="db_user" class="border" value="" /><br /> 
    ��¼�ܡ��룺<input type="text" name="db_pwds" class="border" value="" /><br />        
</p>
<% Else %>
<p>
	���ݿ�·����<input type="text" name="db_host" size="30" class="border" value="/data/lcms<%=replace(SYS_VERSION, " ", "_") %>.mdb" /><br />
    ��ʹ������ڷ�������Ŀ¼��·����	
</p>
<% End If%>
<h2>��̬ҳ��������</h2>
<p>
	Ĭ��ҳ�棺<input type="text" name="index_name" class="border" value="default.shtml" /><br />
    ���������<input type="radio" name="allow_inc" value="False" checked="checked" /> ��
    <input type="radio" name="allow_inc" value="True" /> ��
    <br />
        
</p>

<p class="step">
	<input type="submit" class="button" value="��ʼ��װ" />
</p>
</form>
<%

End Sub
%>
</body>
</html>

<% Sub Main %>

<p>��ӭʹ��LCMS <%=SYS_VERSION %> ���ݹ���ϵͳ��</p>


<p>����㲻��ʹ��/LCMS/��Ϊ��̨������ڣ��������޸����Ŀ¼���ƺ������д˰�װ����</p>

<p>LCMSϵͳҪ���������FSOд��Ȩ�ޣ������޷�������װ��</p>

<p>��ѡ�����ݿ����ͽ��а�װ��</p>

<p class="step">
	<a href="?step=1&db=1" class="button">MS SQL Server</a>
	<a href="?step=1&db=2" class="button">MS Access</a>
</p>
<p>�����ʹ��MS SQL Server��Ϊ���ݿ⣬��ȷ�����Ѿ�ӵ��������Ϣ��</p>
<ol>
	<li>���ݿ�����</li>
	<li>���ݿ��û���</li>
	<li>���ݿ�����</li>
	<li>���ݿ�������ַ</li>
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
		Response.Write ("<p>���������ļ�config.asp��ɡ�</p>")
		Response.Flush()
	Else
		Response.Write ("<p class=alert>��װ�����޷����������ļ�����ȷ�Ϸ�������д��Ȩ�ޡ�</p>")
		Response.Flush()
		Exit Sub
	End If
	
	
	
	If db = "1" Then
		
		Set Conn = Server.CreateObject("ADODB.Connection")
		Conn.open "Provider = Sqloledb;" & ConnString
		If Err Then
			Set Conn = Nothing
			Response.Write "<p class=alert>�޷����������ݿ�����������ӡ�</p>"
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
			Response.Write ""&DoInstall&"...��ɡ�<br />"
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
		
		Response.Write("<p>��ʼ������...��ɡ�</p>")	
		
		Response.Write("<p class=alert>Ԥ�����Ա�ʺţ�lone ���룺admin�����¼���޸ġ�</p>")
		Response.Flush()			
		
	Else
		Dim FS, F
		Call AutoCreateDirectory (ConnString)
		Set FS = Server.CreateObject("SCRIPTING.FILESYSTEMOBJECT")
		FS.CopyFile Server.MapPath("db/access.sql"), Server.MapPath(ConnString), True
		Set FS = Nothing
		
		Response.Write("<p>��װ���ݿ��ļ�"&ConnString&"...��ɡ�</p>")
		
		Response.Write("<p>��ʼ������...��ɡ�</p>")	
		
		Response.Write("<p class=alert>Ԥ�����Ա�ʺţ�admin ���룺admin888�����¼���޸ġ�</p>")
		Response.Flush()
	
	End If
	
	Response.Write("<p class=step><a href=""../system/"" class=""button"">��¼�����̨</a></p>")
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