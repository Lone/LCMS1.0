<!--#include file="../inc/common.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
Response.Expires = 0
Response.CacheControl = "no-cache"
Server.ScriptTimeOut = 9999
Session.TimeOut = 60

Dim Content_Menu_Id, Content_Id
Dim Settings, Action, Script



Action = Request.QueryString("action")

If Action="getmenu" Then
	'取得需要生成的目录清单
	Content_Menu_Id = Request.QueryString("MenuId")
	Session("Menu") = Content_Menu_Id
	Session("NowMenu") = Empty

	If Request.QueryString("IncludeChildren")="1" Then
		Call GetChilds(Content_Menu_Id)
	End If
	If Request.QueryString("pub")="list" Then
		Session("Content") = "skip"
	Else
		Session("Content") = ""
	End If 
	Session("PublishConfig") = Trim(Request.QueryString("pub")) & "|" &_
	Trim(Request.QueryString("pubtoday")) & "|" & Trim(Request.QueryString("pubnew"))

	response.redirect("createlist.asp")
Else
	If Trim(Session("Menu"))="" Then
		Session("NowMenu") = Empty
		Session("Created") = Empty
		Session("ContentCount") = Empty
		Session("Content") = Empty
		Session("Menu") = Empty
		Session("Pages") = Empty
		Session("PublishConfig") = Empty
		Lone.DeleteTemplateFile()
		Script = "window.close();"
	Else
		Menu = Split(Session("Menu"))
		If CStr(Session("NowMenu")) = CStr(Menu(0)) Then
			Content_Menu_Id = Session("NowMenu")
			Call CreateContent()
			Session("Created") = CInt(Session("Created")) + 1
			If CInt(Session("ContentCount"))>0 Then
				Width = CInt(CInt(Session("Created"))/CInt(Session("ContentCount"))*100)
			End If
		Else
			
			Call CreateList()
		End If 
		Script = Script & "parent.Reload(" & Width & ");"
	End If
	
End If


Sub GetChilds(rootid)
	Dim Rs
	Set Rs = Lone.Execute("select menu_id from lcms_menu where menu_parent_id="&rootid)
	Do While Not Rs.Eof
		Session("Menu") = Session("Menu") & " " & Rs(0)
		Call GetChilds(Rs(0))
		Rs.MoveNext
	Loop
	Rs.Close
	Set Rs = Nothing
End Sub

Sub CreateList()
	Dim MenuId, Setting
	Menu = Split(Session("Menu"))
	MenuId = Menu(0)

	Set Setting = GetChannelSetting(MenuId)

	If Split(Session("PublishConfig"),"|")(0)="content" Then
		Session("NowMenu") = MenuId
	Else
'*****************************
'	实现生成列表代码：
		If Setting("Menu_List_Template")="" Then
			Session("Pages") = 0
			Call CreateLinkPublish(MenuId)
		Else
			If Not IsInteger(Session("Pages")) Then
				Call CreateLinkPublish(MenuId)
				sql = "select count(*) from LCMS_Content" & ChkIsNull(Setting("Menu_Data_Table")) &_
				" where content_menu_id=" & MenuId &_
				" And Content_Locked="&SQL_False&" And Content_Deleted="&SQL_False&""
				RC = Lone.Execute(sql)(0)
				
				If RC=0 Then 
					Session("Pages") = 0
				Else
					Session("Pages") = RC \ Setting("Menu_List_Count")
					If (Rc Mod Setting("Menu_List_Count"))>0 Then
						Session("Pages") = CInt(Session("Pages")) + 1
					End If
					Call Lone.CreateTemplateFile(Setting("Menu_List_Template"), "list", MenuId)	
				End If 
			End If 
		End If 
		
		dFileName = Setting("Menu_List_URL")
		CurrentPage = CInt(Session("Pages"))

		If CurrentPage=0 Or chkIsNull(dFileName)="" Then
			Session("Pages") = ""
			If Session("Content") = "skip" Then
				Menu(0) = ""
				Session("Menu") = Trim(Join(Menu))
				Exit Sub
			Else
				Session("NowMenu") = Trim(Menu(0))
			End If
		Else
			If CurrentPage>1 Then
				URL = Left(dFileName, InstrRev(dFileName, ".")-1)
				URL = URL & (CurrentPage) & Mid(dFileName, InstrRev(dFileName, "."))
				dFileName = URL
			End If
			Script = Script & "parent.Display('正在发布："&Setting("Menu_Name") & "<br />"&dFileName&"');"
			Lone.SavePageContent dFileName, "?Page=" & CurrentPage
			Session("Pages") = CurrentPage - 1
			Exit Sub
		End If
	End If

'/////////////////////////////
'	创建内容页模板
	If chkIsNull(Setting("Menu_Content_Template"))="" Then 
		Session("Content") = ""
		Exit Sub
	End If
	Content_Menu_Id = MenuId
	Call Lone.CreateTemplateFile(Setting("Menu_Content_Template"), "banch", "")
	Session("ContentCount") = 0
	Session("Content") = GetContentId(MenuId)
	Session("Created") = 0
	Set Setting = Nothing 
End Sub

Sub CreateLinkPublish(ByVal MenuId)
'/////////////////////////////
'	实现生成附带发布代码：
	On Error Resume Next
	Dim Rs
	Set Rs = Lone.Execute("Select * From LCMS_Link Where Link_MenuId=" & MenuId)
	Do While Not Rs.EOf
		Lone.CreateTemplateFile Rs("Link_Template"), "link", MenuId
		Lone.SavePageContent Rs("Link_URL"), ""
		Rs.MoveNext
	Loop
	Rs.close
	Set Rs = Nothing
End Sub

Sub CreateContent()
	Dim Menu, Content, ContentId
	If Trim(Session("Content"))="" Then
		Session("ContentCount") = 0
		Menu = Split(Session("Menu"))
		Menu(0) = ""
		Session("Menu") = Trim(Join(Menu))
		Exit Sub
	End If 
	Content = Split(Session("Content"))
	ContentId = Content(0)
	Content(0) = ""
	Session("Content") = Trim(Join(Content))


'********************
'实现生成内容页代码：
	Dim MenuId, Settings
	MenuId = Session("NowMenu")
	Set Settings = GetChannelSetting(MenuId)
	dFileName = Lone.CreateFileName(Settings("Menu_Content_URL"), ContentId)
	If chkIsNull(dFileName)<>"" Then
		Lone.SavePageContent dFileName, "?Id=" & ContentId & "&Menu_Id=" & MenuId
		Lone.Execute("Update LCMS_Content"&ChkIsNull(Settings("Menu_Data_Table"))&" Set Content_URL='" & dFileName & "' Where Content_Id=" & ContentId)
		Script = Script & "parent.Display('正在发布："&Settings("Menu_Name") & "<br />" &dFileName&"');"
	End If

'//////////////////
	Set Settings = Nothing 
End Sub

Function GetContentId(ByVal MenuId)
	Dim Rs, sql, PublishConfig
	PublishConfig = Split(session("PublishConfig")&"||","|")
	Set Rs = Server.CreateObject("ADODB.RECORDSET")
	Menu_Data_Table = Lone.Execute("Select Menu_Data_Table From LCMS_Menu Where Menu_Id=" & MenuId)(0)
	sql = "select Content_id from lcms_Content"&ChkIsNull(Menu_Data_Table)&" where content_menu_id="&MenuId&" and Content_Locked="&SQL_False&" "

	If PublishConfig(1)="1" Then
		'只发布今日数据
		If DatabaseType=1 Then
			sql = sql & "and DateDiff(d,Content_Add_Time,getdate())=0 "
		Else
			sql = sql & "and DateDiff('d',Content_Add_Time,Now())=0 "
		End If 
	End If
	If PublishConfig(2)="1" Then
		'只发布新增数据
		sql = sql & "and (Content_URL='' Or (Content_URL is null)) "
	End If

	Rs.Open sql, Conn, 1, 1
	If Rs.EOF Then
		GetContentId = ""
	Else 
		Session("ContentCount") = Rs.RecordCount
		GetContentId = Trim(Rs.GetString(,,," "))

	End If 
	Rs.Close
	Set Rs = Nothing
End Function 

Function GetChannelSetting(ByVal MenuId)
	Dim Rs, Dict
	Set Rs = Lone.Execute("Select * From LCMS_Menu Where Menu_Id=" & MenuId)
	Set Dict = Server.CreateObject("SCRIPTING.DICTIONARY")
	For Each Field In Rs.Fields
		Dict.Add Field.Name, Field.Value
	Next
	Set GetChannelSetting = Dict
	Set Dict = Nothing 
End Function
%>
<script language="javascript">
	<%= Script %>
</script>