<!--#include file="../inc/Common.asp"-->
<%
Response.Expires = 0
Response.CacheControl = "no-cache"
Response.CharSet="GB2312"

If Request.QueryString("action")="GetMenu" Then
	Dim pId
	pId = Request.QueryString("pId")

	If Not IsInteger(pId) Then
		Response.End()
	End If 

	Call GetMenu(pId)
'	Response.Flush()
	Response.End()
End If

Function GetMenu(parentMenuId)
	Dim Rs, tempStr
	Set Rs = Lone.Execute("Select * From LCMS_Menu Where Menu_Parent_Id="&parentMenuId&" Order By Menu_Orders")
	If Not Rs.EOF Then
		Response.Write "<ul>"
		Do While Not Rs.EOF
			If Rs("Menu_Child_Count")>0 Then %>
	<li><div onClick="Unfold_Menu(this);" id="lcms_menu(<%= Rs("Menu_Id") %>)" menutype="<%= Rs("Menu_Type") %>"><img src="../public/images/manage/menu_fold.gif" width="15" height="15" /> <%= Rs("Menu_Name") %></div></li>
		<%	Else %>
	<li><div id="lcms_menu(<%= Rs("Menu_Id") %>)" onClick="setMenuId(this);" menutype="<%= Rs("Menu_Type") %>"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> <%= Rs("Menu_Name") %></div></li>
<%			End If
			Rs.MoveNext
		Loop
		Response.Write "</ul>"
	End If
	Rs.Close
	Set Rs = Nothing
End Function 
%>
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<script language="JavaScript" src="../public/js/menu.js"></script>
<script language="JavaScript">

function closenavi() {
window.parent.testframeset.cols = '0,*';
}
function Modify()
{
		
		var argu = "dialogWidth:22em; dialogHeight:15em;center:yes;status:no;help:no";
		window.showModalDialog("dialog.htm?ModifyPass:1","修改密码",argu);
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" onselectstart="return false;" oncontextmenu="return false;">
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td height="20" style="padding-top:3px"><nobr>&nbsp;站点导航</nobr></td>
<td width="20" align="center" valign="top">&nbsp;</td>
<td width="20" align="center" valign="middle"><img src="../Public/Images/Manage/icon-close.gif" width="16" height="15"  vspace="2" alt="关闭左栏" class="button" onClick="closenavi()"></td>
</tr>
</table>

<div id="navi" style="position:relative; width:100%; height:expression(body.offsetHeight-control.offsetHeight-2); z-index:1; left: 0px; top: 0px; overflow: auto">
<table width="180" border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="top" width="12"></td>
<td valign="top">&nbsp;</td>
</tr>
<tr>
<td valign="top">&nbsp;</td>
<td valign="top">
<ul id="Menu">
	<li><div id="lcms_menu(0)" class="shadow" onClick="setMenuId(this);"><img src="../public/images/manage/menu_root.gif" width="15" height="18" /> 站点根目录</div></li>
	<% 
	Set Rs = Lone.Execute("select * From LCMS_Menu Where Menu_Parent_Id=0 Order By Menu_Orders")
	Do While Not Rs.EOF
	If Rs("Menu_Child_Count")>0 Then
	%>
	<li><div onClick="Unfold_Menu(this);" id="lcms_menu(<%= Rs("Menu_Id") %>)" menutype="<%= Rs("Menu_Type") %>"><img src="../public/images/manage/menu_fold.gif" width="15" height="15" /> <%= Rs("Menu_Name") %></div></li>
	<% Else %>
	<li><div id="lcms_menu(<%= Rs("Menu_Id") %>)" onClick="setMenuId(this);" menutype="<%= Rs("Menu_Type") %>"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> <%= Rs("Menu_Name") %></div></li>
	<% End If %>
	<%
	Rs.MoveNext()
	Loop
	Rs.Close()
	Set Rs = Nothing
	%>
</ul>
<!--
<ul id="Menu">
<li><div><img src="../public/images/manage/Icon_Roles.gif" width="16" height="16" /> 会员管理系统</div></li>
	<li><div onClick="getURL('LCMS_User.asp?UserType=2', this);" id="lcms_menu(-2)"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> 企业会员</div></li>
	<li><div onClick="getURL('LCMS_User.asp?UserType=1', this);" id="lcms_menu(-1)"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> 个人会员</div></li>
</ul>
-->
<ul id="Menu">
<li><div><img src="../public/images/manage/Icon_File_Setup.gif" width="16" height="14" /> 系统管理</div></li>
	<li><div onClick="getURL('UpdateDb.asp', this);" id="lcms_menu(-9)"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> 在线升级</div></li>	
	<li><div onClick="getURL('Admin_UpFiles.asp', this);" id="lcms_menu(-3)"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> 远程文件</div></li>
	<li><div onClick="Modify();" id="lcms_menu(-4)"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> 修改密码</div></li>
	<li><div onClick="if(confirm('确定要退出内容管理系统吗？'))window.top.location.href='Login_Chk.asp';" id="lcms_menu(-5)"><img src="../public/images/manage/menu_unfold.gif" width="15" height="15" /> 退出系统</div></li>
</ul>
</td>
</tr>
</table>
</div>
</body>
</html>
<% Set Lone = Nothing %>