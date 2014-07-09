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
		<td class="coolButton" nowrap onclick="location.href='?action=add';" title="��ӹ���Ա" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Master_on.gif" align="absmiddle"> ���
		</td>
		<td class="coolButton" nowrap onclick="if(confirm('ȷ��Ҫɾ��ѡ�е��û���?'))form1.submit();" title="ɾ��ѡ�е���" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Master_off.gif" align="absmiddle"> ɾ��
		</td>	
		<TD>&nbsp;</TD>
	</TR>
</TABLE>

<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">

  <tr class="tdbg1">
	<th width="5%"><input type="checkbox" value="" id="chkAll" style="border:0;" onclick="selectAll(this.form)" /></th>  	
	<th width="5%">ID</th>
	<th width="15%">��¼�ʺ�</th>
	<th width="15%">�û���ɫ</th>
	<th width="20%">����</th>
	<th width="15%">�绰</th>
	<th width="15%">����</th>
	<th width="10%">����</th>
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
		<a href="?action=edit&id=<%= Rs("Master_Id") %>">�޸�</a> | 
		<a href="?action=delete&id=<%= Rs("Master_Id") %>" onclick="return confirm('ȷ��Ҫɾ����?');">ɾ��</a></td>
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
Call showpage(thisFileName,AllRecords,maxperpage,True,False,"����¼")
End Sub 


Sub Delete()
	Id = Trim(Request("Id"))
	If Id="" Then
		ErrMsg = "��ѡ��Ҫɾ���ļ�¼."
		Call WriteErrMsg()
		Exit Sub
	End If
	
	If InStr(Id&",",Lone.Admin_Id) Then
		ErrMsg = "������ɾ������ʹ�õ��ʺ�."
		Call WriteErrMsg()
		Exit Sub
	End If
	delAdmin = Lone.Execute("Select Master_UserName FROM Content_Master WHERE Master_Id In (" & Id & ")").GetString(, , "", ",", "")
	sLog = Lone.Admin_Name & "ɾ�������ʺ�:" & delAdmin
	Lone.AddToLog(sLog)
	Lone.Execute("DELETE FROM Content_Master WHERE Master_Id In (" & Id & ")")
	sucMsg = "ɾ����ɡ�"
	sucMsg =  sucMsg & "<p align=center><a href='?action=list'>�����б�ҳ</a></p>"
	WriteSucMsg(sucMsg)
End Sub

Sub Add()
%>
<TABLE class="coolBar" style="HEIGHT: 20px" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR>
		<TD width="5"><SPAN class="handbtn"></SPAN></TD>
		<td class="coolButton" nowrap onclick="if(Lone_chkForm(frmAddUser))frmAddUser.submit();" title="�������Ա����" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_File_Save.gif" align="absmiddle"> ����
		</td>	
		<td class="coolButton" nowrap onclick="location.href='?action=List';" title="�����û��б�" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Up.gif" align="absmiddle"> ����
		</td>			
		<TD>&nbsp;</TD>
	</TR>
</TABLE>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	 <form name="frmAddUser" action="Admin_Admin.asp?action=saveadd" method="post">
	<tr>
		<th align="right" class="tdbg1" width="150">��¼�ʺ�:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_UserName" class="input" mustFill="1" info="��¼�ʺŲ���Ϊ��" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">����:</th>
		<td class="tdbg"><input type="password" size="20" name="Master_Password" class="input" mustFill="1" info="��¼���벻��Ϊ��" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">��ɫ����:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Name" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">Email:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Email" class="input" isEmail="1" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">�绰:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Phone" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">��ͨ:</th>
		<td class="tdbg">
			<input type="radio" name="Master_Usabled" id="enable" value="1" checked /><label for="enable">����</label>
			<input type="radio" name="Master_Usabled" id="unable" value="0" /><label for="unable">����</label>
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">˵��:</th>
		<td class="tdbg">
			<textarea cols="50" rows="4" name="Master_Note"></textarea>		
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">����Ȩ��:</th>
		<td class="tdbg">
			<b>ϵͳ����</b><input type="checkbox" name="Master_Options" id="opt12" value="12" /><label for="opt12">ϵͳƵ������</label>
			<input type="checkbox" name="Master_Options" id="opt10" value="10" /><label for="opt10">ϵͳ�ʺŹ���</label>
			<input type="checkbox" name="Master_Options" id="opt13" value="13" /><label for="opt13">Զ���ļ�����</label>
			<input type="checkbox" name="Master_Options" id="opt11" value="11" /><label for="opt11">ϵͳ��־����</label>
			<b>���׹���</b><input type="checkbox" name="Master_Options" id="opt20" value="20" /><label for="opt20">��������</label>

			<br />
			<b>վ�����</b><input type="checkbox" name="Master_Options" id="opt30" value="30" /><label for="opt30">վ������</label>
			<input type="checkbox" name="Master_Options" id="opt31" value="31" /><label for="opt31">ģ�����</label>

<%
Dim Rct
Set Rct=Lone.Execute("Select ChannelID,ChannelName,ChannelItemName,ManageFlag From [Content_Channel] Where yn=1 And Deleted = 0 order by orderId")
Do while Not Rct.eof
%>		
			<br />
			<b><%= Rct(1) %>��</b><input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>0" value="<%= Rct(3) %>0" /><label for="opt<%= Rct(3) %>0"><%= Rct(2) %>�������</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>1" value="<%= Rct(3) %>1" /><label for="opt<%= Rct(3) %>1"><%= Rct(2) %>����</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>2" value="<%= Rct(3) %>2" /><label for="opt<%= Rct(3) %>2"><%= Rct(2) %>����</label>
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
		MsgBox "�û����Ѿ�����.","back",""
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
	sLog = Lone.Admin_Name & "��ӹ����ʺ�:" & Admin
	Lone.AddToLog(sLog)
	sucMsg = "�������ʺ���ɡ�"	
	sucMsg =  sucMsg & "<p align=center><a href='?action=list'>�����б�ҳ</a></p>"
	WriteSucMsg(sucMsg)
End Sub

Sub SaveEdit()
Dim Admin,Admin_Id
	Admin_Id = Trim(Request.Form("Id"))
	Admin = Trim(Request.Form("Master_UserName"))
	If Lone.Execute("select count(*) From CONTENT_Master Where Master_UserNAME='" & Admin & "' And Master_Id != " & Admin_Id)(0)>0 Then
		MsgBox "�û����Ѿ�����.","back",""
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
	sLog = Lone.Admin_Name & "�޸Ĺ����ʺ�:" & Admin
	Lone.AddToLog(sLog)
	sucMsg = "�����ʺ�������ɡ�"	
	sucMsg =  sucMsg & "<p align=center><a href='?action=list'>�����б�ҳ</a></p>"
	WriteSucMsg(sucMsg)
End Sub
Sub Edit()
Id = Trim(Request.Querystring("Id"))
Set Rs = Lone.Execute("Select * From Content_Master Where Master_Id=" & Id)
If Rs.EOF Then
	MsgBox "û�и��û�����.","back",""
End If
%>
<TABLE class="coolBar" style="HEIGHT: 20px" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR>
		<TD width="5"><SPAN class="handbtn"></SPAN></TD>
		<td class="coolButton" nowrap onclick="if(Lone_chkForm(frmAddUser))frmAddUser.submit();" title="�������Ա����" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_File_Save.gif" align="absmiddle"> ����
		</td>	
		<td class="coolButton" nowrap onclick="location.href='?action=List';" title="�����û��б�" width="50"
		height="20"><img border="0" src="./images/Manage/Icon_Up.gif" align="absmiddle"> ����
		</td>			
		<TD>&nbsp;</TD>
	</TR>
</TABLE>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	 <form name="frmAddUser" action="Admin_Admin.asp?action=saveedit" method="post">
	 	<input type="hidden" name="id" value="<%= Id %>" />
	<tr>
		<th align="right" class="tdbg1" width="150">��¼�ʺ�:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_UserName" value="<%= Rs("Master_UserName") %>" class="input" mustFill="1" info="��¼�ʺŲ���Ϊ��" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">����:</th>
		<td class="tdbg"><input type="password" size="20" name="Master_Password" class="input" /> ������޸�������.</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">��ɫ����:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Name" value="<%= Rs("Master_Name") %>" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">Email:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Email" value="<%= Rs("Master_Email") %>" class="input" isEmail="1" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">�绰:</th>
		<td class="tdbg"><input type="text" size="20" name="Master_Phone" value="<%= Rs("Master_Tel") %>" class="input" /></td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">��ͨ:</th>
		<td class="tdbg">
			<input type="radio" name="Master_Usabled" id="enable" value="1"<% If Rs("Master_Usableness")=1 Then Response.Write(" checked") %> /><label for="enable">����</label>
			<input type="radio" name="Master_Usabled" id="unable" value="0"<% If Rs("Master_Usableness")=0 Then Response.Write(" checked") %> /><label for="unable">����</label>
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">˵��:</th>
		<td class="tdbg">
			<textarea cols="50" rows="4" name="Master_Note"><%= Rs("Master_Note") %></textarea>
			</td>
	</tr>
	<tr>
		<th align="right" class="tdbg1">����Ȩ��:</th>
		<td class="tdbg">
			<%
			Options = ", " & Rs("Master_Options") & ","
			%>
			<b>ϵͳ����</b><input type="checkbox" name="Master_Options" id="opt12" value="12"<% If Instr(Options,", 12,") Then Response.Write(" checked") %> /><label for="opt12">ϵͳƵ������</label>
			<input type="checkbox" name="Master_Options" id="opt10" value="10"<% If Instr(Options,", 10,") Then Response.Write(" checked") %> /><label for="opt10">ϵͳ�ʺŹ���</label>
			<input type="checkbox" name="Master_Options" id="opt13" value="13"<% If Instr(Options,", 13,") Then Response.Write(" checked") %> /><label for="opt13">Զ���ļ�����</label>
			<input type="checkbox" name="Master_Options" id="opt11" value="11"<% If Instr(Options,", 11,") Then Response.Write(" checked") %> /><label for="opt11">ϵͳ��־����</label>
			<br />
			<b>���׹���</b><input type="checkbox" name="Master_Options" id="opt20" value="20"<% If Instr(Options,", 20,") Then Response.Write(" checked") %> /><label for="opt20" />��������</label>


			<br />
			<b>վ�����</b><input type="checkbox" name="Master_Options" id="opt30" value="30"<% If Instr(Options,", 30,") Then Response.Write(" checked") %> /><label for="opt30">վ������</label>
			<input type="checkbox" name="Master_Options" id="opt31" value="31"<% If Instr(Options,", 31,") Then Response.Write(" checked") %> /><label for="opt31">ģ�����</label>
<%
Dim Rct
Set Rct=Lone.Execute("Select ChannelID,ChannelName,ChannelItemName,ManageFlag From [Content_Channel] Where yn=1 And Deleted = 0 order by orderId")
Do while Not Rct.eof
%>		
			<br />
			<b><%= Rct(1) %>��</b><input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>0" value="<%= Rct(3) %>0"<% If Instr(", " & Options,Rct(3) & "0,") Then Response.Write(" checked") %> /><label for="opt<%= Rct(3) %>0"><%= Rct(2) %>�������</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>1" value="<%= Rct(3) %>1"<% If Instr(", " & Options,Rct(3) & "1,") Then Response.Write(" checked") %> /><label for="opt<%= Rct(3) %>1"><%= Rct(2) %>����</label>
			<input type="checkbox" name="Master_Options" id="opt<%= Rct(3) %>2" value="<%= Rct(3) %>2"<% If Instr(", " & Options,Rct(3) & "2,") Then Response.Write(" checked") %> /><label for="opt<%= Rct(3) %>2"><%= Rct(2) %>����</label>
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