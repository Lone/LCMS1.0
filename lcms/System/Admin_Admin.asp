<!--#include file="./inc/common.asp"-->
<!--#include file="./inc/md5.asp"-->
<% 
Lone.chkAdmin(10)
Dim action,uList
Const MaxPerPage = 20
Dim CurrentPage, AllRecords
Dim thisFileName

action = LCase(Trim(Request("action")))
uList = Trim(Request("List"))
uKey = Trim(Request("uKey"))
thisFileName = "Admin_Order.asp?action=list&list=" & uList & "uKey=" & uKey
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Gomye System</title>
<LINK href="./css/Admin.css" rel="stylesheet">
<link href="./css/Admin_Style.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="./js/coolbuttons.js"></SCRIPT>
<script language="javascript" src="./js/main.js"></script>
</head>

<body oncontextmenu="self.event.returnValue=false" onselectstart="event.returnValue=false">
<%
Select Case action
Case "edit"
	Call Edit()
Case "saveedit"
	Call SaveEdit()
Case "add"
	Call Add()
Case "saveadd"
	Call SaveAdd()	
Case "delete"
	Call Delete()
Case Else
	Call List()
End Select
%>
<!--#include file="Foot.asp"-->
<% 
Sub List()
Set Rs = Server.CreateObject("ADODB.Recordset")
SQL = "select * from Content_Master ORDER BY Master_Id ASC"
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
<TABLE class="coolBar" style="HEIGHT: 20px" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR>
		<TD width="5"><SPAN class="handbtn"></SPAN></TD>
		<td class="coolButton" nowrap onclick="location.href='?action=add';" title="添加管理员" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Master_on.gif" align="absmiddle"> 添加
		</td>
		<td class="coolButton" nowrap onclick="if(confirm('确定要删除选中的用户吗?'))form1.submit();" title="删除选中的项" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Master_off.gif" align="absmiddle"> 删除
		</td>	
		<TD>&nbsp;</TD>
	</TR>
</TABLE>

<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">

  <tr class="tdbg1">
	<th width="5%"><input type="checkbox" value="" id="chkAll" style="border:0;" onclick="selectAll(this.form)" /></th>  	
	<th width="5%">ID</th>
	<th width="15%">登录帐号</th>
	<th width="15%">用户角色</th>
	<th width="20%">邮箱</th>
	<th width="15%">电话</th>
	<th width="15%">日期</th>
	<th width="10%">操作</th>
  </tr>
 <form name="form1" action="Admin_Admin.asp?action=delete" method="post">
<%
	For I=1 To MaxPerPage
		If Rs.EOF Then Exit For
%>
  <tr class="tdbg" onmouseover="this.className='heigthlight'" onmouseout="this.className='tdbg'">
	<td align="center"><input type="checkbox" value="<%= Rs("Master_Id") %>" name="id" style="border:0;" /></td>	
	<td align="center"><%= Rs("Master_Id") %></td>
	<td align="center"><a href="?action=edit&id=<%= Rs("Master_Id") %>"><%
		If Rs("Master_Usableness")=0 Then
			Response.Write("<span style='color:red'>" & Rs("Master_UserName") & "</span>")
		Else
		 	Response.Write(Rs("Master_UserName"))
		End if
		 	 %></a></td>
	<td align="center"><%= Rs("Master_Name") %></td>
	<td><a href="mailto:<%= Rs("Master_Email") %>"><%= Rs("Master_Email") %></a></td>	
	<td><%= Rs("Master_Tel") %></td>
	<td align="center"><%= Rs("Master_AddDate") %></td>
	<td align="center">
		<a href="?action=edit&id=<%= Rs("Master_Id") %>">修改</a> | 
		<a href="?action=delete&id=<%= Rs("Master_Id") %>" onclick="return confirm('确定要删除吗?');">删除</a></td>
  </tr>
<% 
	Rs.MoveNext
	Next
	Rs.Close
	Set Rs = Nothing
%>
 </form>
</table>
<% 
Call showpage(thisFileName,AllRecords,maxperpage,True,False,"条记录")
End Sub 


Sub Delete()
	Id = Trim(Request("Id"))
	If Id="" Then
		ErrMsg = "请选择要删除的记录."
		Call WriteErrMsg()
		Exit Sub
	End If
	
	If InStr(Id&",",Lone.Admin_Id) Then
		ErrMsg = "您不能删除正在使用的帐号."
		Call WriteErrMsg()
		Exit Sub
	End If
	delAdmin = Lone.Execute("Select Master_UserName FROM Content_Master WHERE Master_Id In (" & Id & ")").GetString(, , "", ",", "")
	sLog = Lone.Admin_Name & "删除管理帐号:" & delAdmin
	Lone.AddToLog(sLog)
	Lone.Execute("DELETE FROM Content_Master WHERE Master_Id In (" & Id & ")")
	sucMsg = "删除完成。"
	sucMsg =  sucMsg & "<p align=center><a href='?action=list'>返回列表页</a></p>"
	WriteSucMsg(sucMsg)
End Sub

Sub Add()
%>
<TABLE class="coolBar" style="HEIGHT: 20px" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR>
		<TD width="5"><SPAN class="handbtn"></SPAN></TD>
		<td class="coolButton" nowrap onclick="if(Lone_chkForm(frmAddUser))frmAddUser.submit();" title="保存管理员设置" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_File_Save.gif" align="absmiddle"> 保存
		</td>	
		<td class="coolButton" nowrap onclick="location.href='?action=List';" title="返回用户列表" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Up.gif" align="absmiddle"> 返回
		</td>			
		<TD>&nbsp;</TD>
	</TR>
</TABLE>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	 <form name="frmAddUser" action="Admin_Admin.asp?action=saveadd" method="post">
	<tr>
		<th align="right" class="tdbg1" width="150">登录帐号:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_UserName" class="input" mustFill="1" info="登录帐号不能为空" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">密码:</th>
		<td class="tdbg"><input type="password" size="20" name="Master_Password" class="input" mustFill="1" info="登录密码不能为空" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">角色名称:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Name" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">Email:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Email" class="input" isEmail="1" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">电话:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Phone" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">开通:</th>
		<td class="tdbg">
			<input type="radio" name="Master_Usabled" id="enable" value="1" checked /><label for="enable">可用</label>
			<input type="radio" name="Master_Usabled" id="unable" value="0" /><label for="unable">禁用</label>
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">说明:</th>
		<td class="tdbg">
			<textarea cols="50" rows="4" name="Master_Note"></textarea>		
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">管理权限:</th>
		<td class="tdbg">
			<b>系统管理：</b><input type="checkbox" name="Master_Options" id="opt12" value="12" /><label for="opt12">系统频道管理</label>
			<input type="checkbox" name="Master_Options" id="opt10" value="10" /><label for="opt10">系统帐号管理</label>
			<input type="checkbox" name="Master_Options" id="opt13" value="13" /><label for="opt13">远程文件管理</label>
			<input type="checkbox" name="Master_Options" id="opt11" value="11" /><label for="opt11">系统日志管理</label>
			<b>交易管理：</b><input type="checkbox" name="Master_Options" id="opt20" value="20" /><label for="opt20">订单管理</label>

			<br />
			<b>站点管理：</b><input type="checkbox" name="Master_Options" id="opt30" value="30" /><label for="opt30">站点设置</label>
			<input type="checkbox" name="Master_Options" id="opt31" value="31" /><label for="opt31">模板管理</label>

<%
Dim Rct
Set Rct=Lone.Execute("Select ChannelID,ChannelName,ChannelItemName,ManageFlag From [Content_Channel] Where yn=1 And Deleted = 0 order by orderId")
Do while Not Rct.eof
%>		
			<br />
			<b><%= Rct(1) %>：</b><input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>0" value="<%= Rct(3) %>0" /><label for="opt<%= Rct(3) %>0"><%= Rct(2) %>分类管理</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>1" value="<%= Rct(3) %>1" /><label for="opt<%= Rct(3) %>1"><%= Rct(2) %>发布</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>2" value="<%= Rct(3) %>2" /><label for="opt<%= Rct(3) %>2"><%= Rct(2) %>发布</label>
<%
Rct.MoveNext
Loop
%>
			</td>
	</tr>
</form>
</table>
<%
End Sub

Sub SaveAdd()
Dim Admin,Admin_Id
	Admin = Trim(Request.Form("Master_UserName"))
	If Lone.Execute("select count(*) From CONTENT_Master Where Master_UserNAME='" & Admin & "'")(0)>0 Then
		MsgBox "用户名已经存在.","back",""
	End If
	Admin_Id = Lone.Execute("select Id_Number From CONTENT_ID Where ID_NAME='Master_Id'")(0)
	Lone.Execute("Update CONTENT_ID Set Id_Number=Id_Number+1 Where ID_NAME='Master_Id'")

	Lone.Execute("Insert Into Content_Master Values (" & Admin_Id &_
	", '" & Trim(Request.Form("Master_Name")) & "'" &_
	", '" & Admin & "'" &_
	", '" & Md5(Trim(Request.Form("Master_Password"))) & "'" &_
	", '" & Trim(Request.Form("Master_Email")) & "'" &_
	", '" & Trim(Request.Form("Master_Phone")) & "'" &_
	", '" & Trim(Request.Form("Master_Usabled")) & "'" &_
	", '" & Trim(Request.Form("Master_Note")) & "'" &_	
	", getdate()" &_
	", '" & Trim(Request.Form("Master_Options")) & "')")
	sLog = Lone.Admin_Name & "添加管理帐号:" & Admin
	Lone.AddToLog(sLog)
	sucMsg = "保存新帐号完成。"	
	sucMsg =  sucMsg & "<p align=center><a href='?action=list'>返回列表页</a></p>"
	WriteSucMsg(sucMsg)
End Sub

Sub SaveEdit()
Dim Admin,Admin_Id
	Admin_Id = Trim(Request.Form("Id"))
	Admin = Trim(Request.Form("Master_UserName"))
	If Lone.Execute("select count(*) From CONTENT_Master Where Master_UserNAME='" & Admin & "' And Master_Id != " & Admin_Id)(0)>0 Then
		MsgBox "用户名已经存在.","back",""
	End If
	SQL = "Update Content_Master Set " &_
	"Master_Name = '" & Trim(Request.Form("Master_Name")) & "', " &_
	"Master_UserNAME = '" & Admin & "', "
	If Trim(Request.Form("Master_Password"))<>"" Then
		SQL = SQL & "Master_Password = '" & Md5(Trim(Request.Form("Master_Password"))) & "', "
	End If
	SQL = SQL & "Master_Email = '" & Trim(Request.Form("Master_Email")) & "', " &_
	"Master_Tel = '" & Trim(Request.Form("Master_Phone")) & "'," &_
	"Master_Usableness = '" & Trim(Request.Form("Master_Usabled")) & "', " &_
	"Master_Note = '" & Trim(Request.Form("Master_Note")) & "', " &_
	"Master_Options = '" & Trim(Request.Form("Master_Options")) & "' " &_
	"Where Master_Id=" & Admin_Id
	Lone.Execute(SQL)
	If CInt(Admin_Id) = CInt(Lone.Admin_Id) Then
		Response.Cookies(Lone.CacheName)("Admin_Options") = ", " & Trim(Request.Form("Master_Options")) & ","
	End If 
	sLog = Lone.Admin_Name & "修改管理帐号:" & Admin
	Lone.AddToLog(sLog)
	sucMsg = "保存帐号设置完成。"	
	sucMsg =  sucMsg & "<p align=center><a href='?action=list'>返回列表页</a></p>"
	WriteSucMsg(sucMsg)
End Sub
Sub Edit()
Id = Trim(Request.Querystring("Id"))
Set Rs = Lone.Execute("Select * From Content_Master Where Master_Id=" & Id)
If Rs.EOF Then
	MsgBox "没有该用户资料.","back",""
End If
%>
<TABLE class="coolBar" style="HEIGHT: 20px" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR>
		<TD width="5"><SPAN class="handbtn"></SPAN></TD>
		<td class="coolButton" nowrap onclick="if(Lone_chkForm(frmAddUser))frmAddUser.submit();" title="保存管理员设置" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_File_Save.gif" align="absmiddle"> 保存
		</td>	
		<td class="coolButton" nowrap onclick="location.href='?action=List';" title="返回用户列表" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Up.gif" align="absmiddle"> 返回
		</td>			
		<TD>&nbsp;</TD>
	</TR>
</TABLE>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	 <form name="frmAddUser" action="Admin_Admin.asp?action=saveedit" method="post">
	 	<input type="hidden" name="id" value="<%= Id %>" />
	<tr>
		<th align="right" class="tdbg1" width="150">登录帐号:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_UserName" value="<%= Rs("Master_UserName") %>" class="input" mustFill="1" info="登录帐号不能为空" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">密码:</th>
		<td class="tdbg"><input type="password" size="20" name="Master_Password" class="input" /> 如果不修改请留空.</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">角色名称:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Name" value="<%= Rs("Master_Name") %>" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">Email:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Email" value="<%= Rs("Master_Email") %>" class="input" isEmail="1" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">电话:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Phone" value="<%= Rs("Master_Tel") %>" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">开通:</th>
		<td class="tdbg">
			<input type="radio" name="Master_Usabled" id="enable" value="1"<% If Rs("Master_Usableness")=1 Then Response.Write(" checked") %> /><label for="enable">可用</label>
			<input type="radio" name="Master_Usabled" id="unable" value="0"<% If Rs("Master_Usableness")=0 Then Response.Write(" checked") %> /><label for="unable">禁用</label>
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">说明:</th>
		<td class="tdbg">
			<textarea cols="50" rows="4" name="Master_Note"><%= Rs("Master_Note") %></textarea>
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">管理权限:</th>
		<td class="tdbg">
			<%
			Options = ", " & Rs("Master_Options") & ","
			%>
			<b>系统管理：</b><input type="checkbox" name="Master_Options" id="opt12" value="12"<% If Instr(Options,", 12,") Then Response.Write(" checked") %> /><label for="opt12">系统频道管理</label>
			<input type="checkbox" name="Master_Options" id="opt10" value="10"<% If Instr(Options,", 10,") Then Response.Write(" checked") %> /><label for="opt10">系统帐号管理</label>
			<input type="checkbox" name="Master_Options" id="opt13" value="13"<% If Instr(Options,", 13,") Then Response.Write(" checked") %> /><label for="opt13">远程文件管理</label>
			<input type="checkbox" name="Master_Options" id="opt11" value="11"<% If Instr(Options,", 11,") Then Response.Write(" checked") %> /><label for="opt11">系统日志管理</label>
			<br />
			<b>交易管理：</b><input type="checkbox" name="Master_Options" id="opt20" value="20"<% If Instr(Options,", 20,") Then Response.Write(" checked") %> /><label for="opt20" />订单管理</label>


			<br />
			<b>站点管理：</b><input type="checkbox" name="Master_Options" id="opt30" value="30"<% If Instr(Options,", 30,") Then Response.Write(" checked") %> /><label for="opt30">站点设置</label>
			<input type="checkbox" name="Master_Options" id="opt31" value="31"<% If Instr(Options,", 31,") Then Response.Write(" checked") %> /><label for="opt31">模板管理</label>
<%
Dim Rct
Set Rct=Lone.Execute("Select ChannelID,ChannelName,ChannelItemName,ManageFlag From [Content_Channel] Where yn=1 And Deleted = 0 order by orderId")
Do while Not Rct.eof
%>		
			<br />
			<b><%= Rct(1) %>：</b><input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>0" value="<%= Rct(3) %>0"<% If Instr(", " & Options,Rct(3) & "0,") Then Response.Write(" checked") %> /><label for="opt<%= Rct(3) %>0"><%= Rct(2) %>分类管理</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>1" value="<%= Rct(3) %>1"<% If Instr(", " & Options,Rct(3) & "1,") Then Response.Write(" checked") %> /><label for="opt<%= Rct(3) %>1"><%= Rct(2) %>发布</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>2" value="<%= Rct(3) %>2"<% If Instr(", " & Options,Rct(3) & "2,") Then Response.Write(" checked") %> /><label for="opt<%= Rct(3) %>2"><%= Rct(2) %>管理</label>
<%
Rct.MoveNext
Loop
%>
	 </td>
	</tr>
</form>
</table>
<%
End Sub
%>