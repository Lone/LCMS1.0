<!--#include file="../inc/Common.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
If Request.Querystring("action") = "saveedit" Then
	Dim NewPass, NewPass1
	NewPass = Request.Form("NewPass")
	NewPass1 = Request.Form("NewPass1")
	If NewPass="" Or NewPass1="" Then
		MsgBox "�����벻��Ϊ�գ�", "gourl", "about:blank"
	End If
	If NewPass <> NewPass1 Then
		MsgBox "������������벻һ�£�", "gourl", "about:blank"
	End If 
	Lone.Execute("Update LCMS_Administrator Set Admin_PassWord='" & md5(NewPass) & "', Admin_UserName='"&RequestForm("Email")&"' Where Admin_ID=" & Lone.Admin_Id)
	MsgBox "�޸��������", "close", ""
	Response.End
End If


If Lone.Admin_ID="" Then
	MsgBox "û��Ȩ��", "close", ""
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Gomye System</title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<script language="javascript" src="../public/js/main.js"></script>
</head>

<body scroll="no">
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td width="50" height="20" align="center" class="button" onclick="frmAddUser.submit();"><img border="0" src="../public/images/Manage/Icon_File_Save.gif" align="absmiddle"> ����</td>
<td>&nbsp;</td>
</tr>
</table>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	 <form name="frmAddUser" action="ModifyPass.asp?action=saveedit" method="post" target="uppassword">
	<tr>
		<th class="tdbg1" align="right">��¼�ʺţ�</th>
		<td class="tdbg">
		<input type="text" name="Email" size="30" value="<%=Lone.Admin_Name%>" mustFill="1" />	</td>
	</tr>	
	<tr>		
		<th align="right" class="tdbg1">�� �� �룺</th>
		<td class="tdbg">
		<input type="password" name="NewPass" value="" size="30" mustFill="1" info="����������" />
	 </td>
	</tr>
	<tr>		
		<th align="right" class="tdbg1">ȷ�����룺</th>
		<td class="tdbg">
		<input type="password" name="NewPass1" value="" size="30" mustFill="1" info="������ȷ������" />
	 </td>
	</tr>

	</form>
</table>
<iframe width="0" height="0" name="uppassword" src=""></iframe>
</body>
</html>
<%
Set Lone = Nothing
%>