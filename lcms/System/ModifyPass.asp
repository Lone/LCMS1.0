<!--#include file="../inc/Common.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
If Request.Querystring("action") = "saveedit" Then
	Dim NewPass, NewPass1
	NewPass = Request.Form("NewPass")
	NewPass1 = Request.Form("NewPass1")
	If NewPass="" Or NewPass1="" Then
		MsgBox "新密码不能为空！", "gourl", "about:blank"
	End If
	If NewPass <> NewPass1 Then
		MsgBox "两次输入的密码不一致！", "gourl", "about:blank"
	End If 
	Lone.Execute("Update LCMS_Administrator Set Admin_PassWord='" & md5(NewPass) & "', Admin_UserName='"&RequestForm("Email")&"' Where Admin_ID=" & Lone.Admin_Id)
	MsgBox "修改密码完成", "close", ""
	Response.End
End If


If Lone.Admin_ID="" Then
	MsgBox "没有权限", "close", ""
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
<td width="50" height="20" align="center" class="button" onclick="frmAddUser.submit();"><img border="0" src="../public/images/Manage/Icon_File_Save.gif" align="absmiddle"> 保存</td>
<td>&nbsp;</td>
</tr>
</table>
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	 <form name="frmAddUser" action="ModifyPass.asp?action=saveedit" method="post" target="uppassword">
	<tr>
		<th class="tdbg1" align="right">登录帐号：</th>
		<td class="tdbg">
		<input type="text" name="Email" size="30" value="<%=Lone.Admin_Name%>" mustFill="1" />	</td>
	</tr>	
	<tr>		
		<th align="right" class="tdbg1">新 密 码：</th>
		<td class="tdbg">
		<input type="password" name="NewPass" value="" size="30" mustFill="1" info="请输入密码" />
	 </td>
	</tr>
	<tr>		
		<th align="right" class="tdbg1">确认密码：</th>
		<td class="tdbg">
		<input type="password" name="NewPass1" value="" size="30" mustFill="1" info="请输入确认密码" />
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