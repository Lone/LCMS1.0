<!--#include file="../inc/common.asp"-->
<% 
Lone.chkAdmin(11)
Dim action
Const MaxPerPage = 20
Dim CurrentPage, AllRecords
Dim thisFileName,DateOf

action = LCase(Trim(Request("action")))
DateOf = Trim(Request("DateOf"))
If Not IsDate(DateOf) Then
	DateOf = ""
End If

thisFileName = "Admin_Log.asp"
If action="dele" Then
	Lone.Execute("DELETE FROM CONTENT_LOG WHERE DateDiff(d,LOG_DATE,getdate())>2")
	Response.Redirect("Admin_Log.asp")
End If

'Response.Write(Lone.Admin_Options)
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Gomye System</title>
<link href="../public/css/Admin_Style.css" rel="stylesheet" type="text/css">
<LINK href="../public/css/Admin.css" rel="stylesheet">
<SCRIPT language=JavaScript src="../public/js/coolbuttons.js"></SCRIPT>
<script language="javascript" src="../public/js/main.js"></script>
<script language="javascript" src="../public/js/calendar.js"></script>
</head>

<body oncontextmenu="self.event.returnValue=false" onselectstart="event.returnValue=false">
<TABLE class="coolBar" style="HEIGHT: 20px" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<form name="form1" method="post" action="" onsubmit="return Lone_chkForm(this);">
	 
	</form>
<form method="post" action="Admin_Log.asp" name="form2">
	<TR>
		<TD width="5"><SPAN class="handbtn"></SPAN></TD>
		<td class="coolButton" nowrap onclick="if(confirm('为了系统安全，两天以内的日志将不会被删除。\n确定要清空日志吗？'))location.href='?action=Dele';" title="删除所有日志" width="50"
		height="20"><img border="0" src="../public/images/Manage/Icon_File_Delete.gif" align="absmiddle"> 清空
		</td>	
		<TD>&nbsp;</TD>
		<TD align="right">
			<input type="text" size="20" name="DateOf" class="input" value="<%= DateOf %>" mustFill="1" isDate="1" info="请输入要查看的日期" onclick="show_cele_date(this,'','',this,this.value)" />
		</TD>		
		<td class="coolButton" nowrap onclick="if(Lone_chkForm(form2))form2.submit();" title="按日期查看" width="50"
		height="20"><img border="0" src="../public/images/Manage/search_s.gif" align="absmiddle"> 查看
		</td>	
		<TD width="5"><SPAN class="sepbtn1"></SPAN></TD>
	</TR>
</form>
</TABLE>

<%
	Call List()
%>
<!--#include file="Foot.asp"-->
<% 
Sub List()
Set Rs = Server.CreateObject("ADODB.Recordset")
SQL = "select * from Content_Log "
If DateOf<>"" Then
	SQL = SQL & " Where DateDiff(d,Log_Date,'" & FormatDateTime(DateOf,2) & "')=0"
	thisFileName = thisFileName & "?DateOf=" & DateOf
End If
SQL = SQL & " Order By Log_Date Desc"
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
  <tr class="tdbg1">
	<th width="15%">日期</th>
	<th width="15%">IP</th>
	<th width="70%">日志</th>
  </tr>
<%
	For I=1 To MaxPerPage
		If Rs.EOF Then Exit For	
%>
  <tr class="tdbg" onmouseover="this.className='heigthlight'" onmouseout="this.className='tdbg'">
	<td align="center"><%= Rs("Log_Date") %></td>
	<td align="center"><%= Rs("Log_IP") %></td>
	<td><%= Rs("Log_Content") %></td>
  </tr>
<% 
	Rs.MoveNext
	Next
	Rs.Close
	Set Rs = Nothing
%>
</table>
<% 
Call showpage(thisFileName,AllRecords,maxperpage,True,False,"条记录")
End Sub 

%>