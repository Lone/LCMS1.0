<!--#include file="../inc/common.asp"-->
<%
Dim Menu_Id
Menu_Id = Request.QueryString("Menu_Id")
If Not IsInteger(Menu_Id) Then 
	MsgBox "未知的目录ID", "back", ""
End If 

If DatabaseType=2 Then
	Lone.Execute ("Update LCMS_Menu Set Menu_Child_Count=Menu_Child_Count-1 Where Menu_Id=(select Menu_Parent_Id from LCMS_Menu where Menu_Id=" & Menu_Id & ")")
End If 
sLog = Lone.Admin_Name & "删除目录:"
Call DeleteMenu(Menu_Id)

Sub DeleteMenu(ByVal vMenuId)
	Dim Rs, MenuId
	MenuId = vMenuId
	Set rs=server.CreateObject("adodb.recordset")
	sql="select * from LCMS_Menu Where Menu_Id=" & MenuId
	rs.open sql,conn,1,3
	If Not rs.eof Then
	sLog = sLog & Rs("Menu_Name") & ";"
	Lone.Execute("Delete From LCMS_Content"&ChkIsNull(Rs("Menu_Data_Table"))&" Where Content_Menu_Id=" & MenuId)
	Rs.Delete
	End If 
	Rs.Close
	Set Rs = Nothing

	Set Rs = Conn.Execute("Select Menu_Id From LCMS_Menu Where Menu_Parent_Id=" & MenuId)

	Do While Not Rs.EOF
		Call DeleteMenu(Rs("Menu_Id"))
		Rs.MoveNext
	Loop
	Rs.Close
	Set Rs = Nothing

End Sub


Lone.AddToLog(sLog)
%>
<script language="javascript">
	window.onload = function () {
		window.top.location.reload();		
		//window.top.frames["mainFrame"].location.href='LCMS_Content.htm';
	}
</script>
<%
Set Lone = Nothing 

%>