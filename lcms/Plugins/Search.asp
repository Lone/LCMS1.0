<!--#include file="../inc/Common.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
Response.Buffer = True
Response.Write ("正在查找...")
Response.Flush

Dim sFilter, Key, dFileName, sTableName
Key = CheckStr(Request("key"))
Key = Replace(key, "%", "[%]")
Key = Replace(key, "_", "[_]")
Key = Replace(key, ";", "")
sTableName = CheckStr(Request("class"))
sTableName = Replace(sTableName, " ", "")
sTableName = Replace(sTableName, "%20", "")

If Key="" Then
	MsgBox "请输入查询关键词。", "back", ""
End If
If LONE_SEARCH_TEMPLATE="" Or LONE_SEARCH_RESULT="" Then
	MsgBox "加载配置文件出错，请与管理员联系。", "back", ""
End If

'删除一天以前的搜索结果页面
DeleteFolder (Server.MapPath(LONE_SEARCH_ROOT_DIR))
dFileName = Replace(LCase(LONE_SEARCH_RESULT), "{$title}", Md5(Key))
If Not chkFolderExist(dFileName) Then
	sFilter = "Content_Title LIKE '%"&Key&"%' And Content_URL<>''"
	SQL = "Select count(*) From LCMS_Content"&sTableName&" Where (Content_Locked="&SQL_False&") And (Content_Deleted="&SQL_False&") "
	SQL = SQL & "And (" & sFilter & ") "
	RC = Lone.Execute(sql)(0)
	If RC=0 Then MsgBox "没有找到与您查询相关的记录。", "back", ""
	Call Lone.CreateTemplateFile(LONE_SEARCH_TEMPLATE, "search", sFilter)
	Pages = Rc \ SEARCH_MAXPERPAGE
	If (Rc Mod SEARCH_MAXPERPAGE)>0 Then Pages = Pages + 1
	If Right(dFileName, 1)="/" Then dFileName = dFileName & DEFAULT_FILENAME
	For I=1 To Pages
		If I>1 Then
			URL = Left(dFileName, InstrRev(dFileName, ".")-1)
			URL = URL & (I) & Mid(dFileName, InstrRev(dFileName, "."))
		Else
			URL = dFileName
		End If
		Call Lone.SavePageContent (URL, "?Page=" & I)
	Next
	Lone.DeleteTemplateFile()
End If

Set Lone = Nothing

Function DeleteFolder(byVal folderName)
	On Error Resume Next
	Dim FSO, Folder
	Set  fso=CreateObject("Scripting.FileSystemObject")
	If Not FSO.FolderExists(folderName) Then Exit Function
	Set Folder = FSO.GetFolder(folderName)
	For Each Fo In Folder.SubFolders
		If DateDiff("d", FO.DateCreated, Date())>0 Then
'			DeleteFolder (folderName & "/" & Fo.Name)
			Fo.Delete True
		End If 
	Next
	Set Folder = Nothing
	Set FSO = Nothing
End Function

Function chkFolderExist(byVal folderName)
	On Error Resume Next
	chkFolderExist = False
	Dim FSO, Folder
	Set  fso=CreateObject("Scripting.FileSystemObject")
	Folder = Left(folderName, InstrRev(folderName, "/"))
	Folder = Server.MapPath(Folder)
	If FSO.FolderExists(Folder) Then chkFolderExist = True
	Set FSO = Nothing
End Function

Function OutPut(ByVal dFileName)
	Dim Script
	Script = "<script language=""javascript"">" &_
	"window.onload = function(){ location.href = '" & dFileName & "'; }" &_
	"</script>"
	Response.Write (Script)
	Response.Flush()
End Function 

OutPut(dFileName)
%>