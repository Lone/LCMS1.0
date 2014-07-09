<!--#include file="../inc/Common.asp"-->
<%
Response.Charset = "gb2312"
Dim action
action = Trim(Request.QueryString("ac"))
Select Case action
Case "update" : Update
Case Else : Main

End Select 
Set Lone = Nothing
%>
<%
Sub Main
%>
<html>
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<style type="text/css">
body { margin: 20px; }
p.alert { color: red; }
ul { margin: 0px; padding:0px; width:100%; clear: both;}
ul.UL1 { background-color: #efefef;}
ul.UL1 Li { background-color: #efefef;}
ul li { line-height: 180%; height: 22px; float: left;}
li.LI0 { width: 5%; text-align: left; padding-left: 12px; overflow: hidden;}
li.fname { width: 44%;text-align: left; padding-left: 6px; overflow: hidden;}
li.LI2 { width: 10%;text-align: left; overflow: hidden;}
li.ftitle { width: 15%;text-align: left; overflow: hidden;}
li.LI4 { width: 4%;text-align: center; overflow: hidden;}
li.fdo { width: 35%;text-align: center; overflow: hidden;}
li.hidden { display: none;}
div {clear: both;}
.submit input, .button, .button-secondary {
	font-family: "Lucida Grande", Verdana, Arial, "Bitstream Vera Sans", sans-serif;
	text-decoration: none;
	font-size: 14px !important;
	line-height: 16px;
	padding: 6px 12px;
	cursor: pointer;
	border: 1px solid #bbb;
	color: #464646;
	-moz-border-radius: 15px;
	-khtml-border-radius: 15px;
	-webkit-border-radius: 15px;
	border-radius: 15px;
	-moz-box-sizing: content-box;
	-webkit-box-sizing: content-box;
	-khtml-box-sizing: content-box;
	box-sizing: content-box;
}

.button:hover, .button-secondary:hover, .submit input:hover {
	color: #000;
	border-color: #666;
}

.button, .submit input, .button-secondary {
	background: #f2f2f2 url(../images/white-grad.png) repeat-x scroll left top;
}

.button:active, .submit input:active, .button-secondary:active {
	background: #eee url(../images/white-grad-active.png) repeat-x scroll left top;
}
</style>
<script language="javascript" src="../public/js/ajax.js"></script>
<script language="javascript">
function update_start(){
	var do_list = $('lcms_update_details').getElementsByTagName('UL');
	for (var i=0; i<do_list.length; i++)
	{
		var lis = do_list[i].getElementsByTagName('LI');
		var _url = 'updatedb.asp?ac=update';
		_url += '&t=' + escape(lis[0].innerHTML);
		_url += '&r=' + escape(lis[1].innerHTML);
		_url += '&l=' + escape(lis[3].innerHTML);
		getValue (_url, lis[4]);
	}
	getValue ('updatedb.asp?ac=update&do=ver', 'do_update');
}
</script>
</head>

<body>
<%chk_Version%>
</body>
</html>
<%

End Sub 

Function GetRemoteFile(ByVal rURL, ReturnType)
	
	'On Error Resume Next
	GetRemoteFile = "0"
	Dim Retrieval
	Set Retrieval = Server.CreateObject("Microsoft.XMLHTTP")
	With Retrieval
		.Open "Get", rURL, False, "", ""
		.Send
		If ReturnType="text" Then
			GetRemoteFile = Binary2String(.ResponseBody,"gb2312")
		Else
			GetRemoteFile = .ResponseBody
		End If 
	End With
	Set Retrieval = Nothing
	If Err Then	GetRemoteFile = "1" : Err.Clear
End Function


Public Sub SaveBinaryFile(ByVal strBody, ByVal File)
	Dim objStream
	On Error Resume Next
	Set objStream = Server.CreateObject(LONE_STREAM)

	With objStream
		.Type = 1
		.Open
		.Charset = "GB2312"
		.Write = strBody
		.SaveToFile Server.MapPath(File), 2
		.Cancel()
		.Close()
	End With
	Set objStream = Nothing
End Sub

Sub Chk_Version()
	Dim UpdateSettings, Arr_UpdateSettings, Content_FileName
	Dim FileCount, NewVersion
	Dim Arr_FileInfo
	Randomize
	Content_FileName = LONE_UPDATE_SERVER&"?v="&server.URLEncode(SYS_VERSION)
	Content_FileName = JoinChar(Content_FileName) & CStr(Rnd())

	UpdateSettings = GetRemoteFile(Content_FileName, "text")
	DBType = Array("","MS SQL Server","MS Access")

	Response.Write ("<p>当前版本：" & SYS_VERSION & "&nbsp;&nbsp;数据库：" & DBType(DatabaseType) & "</p>")
	
	If UpdateSettings="0" Then
		Response.Write ("<p>你使用的已经是最新版本，不需要升级。</p>")
		Exit Sub
	ElseIf UpdateSettings="1" Then
		Response.Write ("<p class=alert>无法连接到升级服务器。</p>")
		Exit Sub
	End If 
	Arr_UpdateSettings = Split(UpdateSettings,"|")
	FileCount = UBound(Arr_UpdateSettings)
	NewVersion = Arr_UpdateSettings(FileCount)
	Response.Cookies("SYS_VERSION") = NewVersion
	Response.Write ("<p class=alert>程序检测到新版本：LCMS Ver " & NewVersion & "</p>")
	Response.Write ("<p class=info>共有" & CStr(FileCount) & "个文件需要升级</p>")
	Response.Write ("<div id='lcms_update_details' class='flist'>")
	For I = 0 To FileCount-1
		Arr_FileInfo = Split(Arr_UpdateSettings(I),",")	
		Response.Write ("<ul class=UL" & ((I+1) Mod 2) & ">")
		Response.Write ("<li class=hidden>" & Arr_FileInfo(5) & "</li>")
		Response.Write ("<li class=hidden>" & Arr_FileInfo(2) & "</li>")
		Response.Write ("<li class=ftitle>" & Arr_FileInfo(4) & "</li>")
		Response.Write ("<li class=fname>" & SystemDirectory & Arr_FileInfo(3) & "</li>")
		Response.Write ("<li class=fdo>等待升级</li>")
		Response.Write ("</ul>")
	Next
	Response.Write ("</div>")

	Response.Write ("<p id='do_update'><a href=""javascript:update_start();"" class=""button"">开始升级</a></p>")
End Sub 

Sub Update
	On Error Resume Next
	Dim RemoteFileURL, LocalFileName, UpdateType
	Dim ReturnString
	UpdateType = Trim(Request.QueryString("t"))
	RemoteFileURL = Trim(Request.QueryString("r"))
	LocalFileName = Trim(Request.QueryString("l"))
	Set FS = Server.CreateObject("SCRIPTING.FILESYSTEMOBJECT")
	Dir = Split(LocalFileName, "/")
	MapPath = Server.MapPath("/")
	For I=1 To UBound(Dir)-1
		MapPath = MapPath & "\" & Dir(I)
		If Not FS.FolderExists(MapPath) Then
			Fs.CreateFolder(MapPath)
		End If
	Next
	If Trim(Request.QueryString("do"))="ver" Then
		Settings = "<"&"%" & vbNewLine
		Settings = Settings & "Const SYS_VERSION = """ & Request.Cookies("SYS_VERSION") & """" & vbNewLine
		Settings = Settings & "%"&">"
		Lone.SaveToFile Settings, "../inc/ver.asp"
		ReturnString = "升级完成！"
	Else
		If UpdateType="1" Then
			sql = GetRemoteFile(LONE_UPDATE_SERVER&"files/" & RemoteFileURL, "text")
			If sql<>"" Then 
				sqls = split(sql, "/*--access--*/")
				If DatabaseType=1 And sqls(0)<>"" Then Lone.Execute(sqls(0))
				If DatabaseType=2 And sqls(1)<>"" Then Lone.Execute(sqls(1))
			End If 
		ElseIf UpdateType="0" Then
			Lone.SaveToFile GetRemoteFile(LONE_UPDATE_SERVER&"files/" & RemoteFileURL, "text"), LocalFileName
		Else
			SaveBinaryFile GetRemoteFile(LONE_UPDATE_SERVER&"files/" & RemoteFileURL, "bin"), LocalFileName
		End If
		ReturnString = "<font color=green>OK!</font>"
	End If 

	If Err Then ReturnString = "<font color=red>升级失败</font>"&Err.descritpion
	Response.Write (ReturnString)
End Sub 
%>