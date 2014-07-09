<!--#include file="../inc/common.asp"-->
<% 
Lone.chkAdmin(13)
Dim action
Const MaxPerPage = 20
Dim CurrentPage, AllRecords
Dim thisFileName,DateOf

action = LCase(Trim(Request("action")))


thisFileName = "Admin_BlackIP.asp"
If action="dele" Then
	Lone.Execute("Delete From LCMS_IP_Black Where Id In (" & RequestForm("Id") & ")")
	Response.Redirect(thisFileName & "?Page=" & Request("Page"))
End If

If action="add" Then
	Lone.Execute("Insert Into LCMS_IP_Black (IP) Values ('" & RequestForm("IP") & "')")
	Response.Redirect(thisFileName)
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<link rel="stylesheet" href="../public/css/admin_style.css" type="text/css">
<script language="javascript" src="../public/js/admin.js"></script>
<script language="javascript" src="../public/js/main.js"></script>
<script language="javascript" src="../public/js/calendar.js"></script>
</head>

<body>
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<form method="post" action="?action=add" name="form2">
<tr>
<td height="20" width="80"><img src="../public/images/manage/icon-default.gif" width="16" height="15" class="button" onClick="javascript:window.parent.testframeset.cols = '200,*';" vspace="2" hspace="1" alt="恢复左栏默认宽度"></td>
<td width="50" align="center" class="button" onClick="if(confirm('确定要删除选中的文件吗？'))form1.submit();">
<img border="0" src="../public/images/Manage/Icon_File_Delete.gif" align="absmiddle"> 删除
		</td>	
		<TD>&nbsp;</TD>


		<TD align="right">
			<input type="text" size="20" name="IP" class="input" value="" mustFill="1" info="请输入要添加的IP" />
		</TD>	
		<td class="button" nowrap onclick="if(Lone_chkForm(form2))form2.submit();" title="添加" width="50"
		height="20"><img border="0" src="../public/images/Manage/Icon_File_Push.gif" align="absmiddle"> 添加
		</td>	
		<TD width="5"><SPAN class="sepbtn1"></SPAN></TD>
	</TR>
</form>
</TABLE>
<div id="navi" style="position:relative; width:100%; height:expression(body.offsetHeight-control.offsetHeight-2); z-index:1; left: 0px; top: 0px; overflow: auto">
<%
	Call List()
%>
</div>
<% 
Sub List()
Set Rs = Server.CreateObject("ADODB.Recordset")
SQL = "select * from LCMS_IP_Black Order By Id Desc"

'response.write sql

Rs.Open SQL,Conn,1,1
If Not Rs.EOF Then
	CurrentPage = Trim(Request("Page"))
	rs.PageSize = MaxPerPage
	If CurrentPage="" Or IsNumeric(CurrentPage)=False Then CurrentPage=1 Else CurrentPage=CInt(CurrentPage)
	If CurrentPage<1 Then CurrentPage=1
	If CurrentPage>rs.PageCount Then CurrentPage=rs.PageCount
	AllRecords = rs.RecordCount
	rs.absolutePage = CurrentPage
End If
%>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="border">
  <form name="form1" method="post" action="?action=dele">
  <tr class="tdbg1">
	  <td width="5%" height="25" align="center">
		<input type="checkbox" value="" id="chkAll" style="border:0;" title="全部选中" onclick="CheckAll(this.form)" />
	  </td> 
	<th>IP</th>
  </tr>
<%
	For I=1 To MaxPerPage
		If Rs.EOF Then Exit For	
%>
  <tr class="tdbg" onMouseOver="this.className='heigthlight'" onmouseout="this.className='tdbg'">
  <td align="center"><input type="checkbox" value="<%= Rs("Id") %>" name="Id" style="border:0;" /></td>
	<td align="center"><%= Rs("IP") %></td>
  </tr>
<% 
	Rs.MoveNext
	Next
	Rs.Close
	Set Rs = Nothing
%>
<input type="hidden" name="Page" value="<%= CurrentPage %>" />
</form>
</table>

<p align="center">
<% 
Call showpage(thisFileName,AllRecords,maxperpage,True,False,"个文件")
End Sub 

%> 




