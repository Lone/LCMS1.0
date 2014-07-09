<!--#include file="../inc/common.asp"-->
<%
Dim Content_ID, Content_Menu_Id
Content_ID = Request.QueryString("ID")
Content_Menu_Id = trim(Request.QueryString("Menu_Id"))
if not isInteger(Content_Menu_Id) then Content_Menu_Id=0 Else Content_Menu_Id=Cint(Content_Menu_Id)
Set Rs = Lone.Execute("Select Menu_Data_Table, Menu_Type  From LCMS_Menu Where Menu_Id=" & Content_Menu_Id)
If Rs.EOF Then
	MsgBox "栏目不存在，可能已经删除。", "close", ""
End If 
Menu_Data_Table = ChkIsNull(Rs(0))
Rs.Close
Set Rs = Nothing

If Not IsInteger(Content_Id) then
	msgbox "参数丢失。", "close", ""
ENd If

SQL = "Select * From LCMS_Content"&Menu_Data_Table&" Where Content_Id=" & Content_ID 
set rs=server.CreateObject("adodb.recordset")

rs.open sql,conn,1,1

if rs.eof then
	msgbox "文件不存在。", "close", ""
end if 

if rs("Content_URL")<>"" then
	Response.Redirect(Rs("Content_URL"))
end if
Content_Menu_Id = rs("Content_Menu_Id")


Dim Settings, dFileName

Set Settings = Lone.GetChannelSetting(Content_Menu_Id)
If chkIsNull(Settings("Menu_Content_Template"))<>"" Then
	Call Lone.CreateTemplateFile(Settings("Menu_Content_Template"), "content", Content_Id)
	Response.Redirect(Lone.S_TemplateFileName)
Else
%>
<h2><%= Rs("content_title") %></h2>
<hr />
<%= Rs("content_content") %>
<%
End If
Rs.Close
Set Rs = Nothing

Set Lone = Nothing 
%>