<!--#include file="../inc/common.asp"-->
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<LINK href="../public/css/Admin.css" rel="stylesheet">
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

document.selected_menu_id = 0;
document.do_flag = "";
document.content_edit_id = 0;
document.menu_type = 0;

function goURL(){
	var smid = document.selected_menu_id;
	var df = document.do_flag;
	if (!smid || smid=="")smid = 0;
	if (!df || df=="")df = "content";
	var url = "System_" + df + ".asp?"
}
// -->
</script>
</HEAD>
<% 
If Trim(Session(Lone.CacheName & "_AdminLogin"))="" Then
	validkey = randomStr(16)
	Session(Lone.CacheName & "_ValidKey") = validkey
	LoginUI
else
	Main
End if

Set Lone = Nothing

Sub LoginUI() %>
<body onselectstart="return false">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
	<table width="400" border="0" cellpadding="0" cellspacing="0" class="border">
	  <tr>
		<td height="210" valign="top" class="td">
		
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="border: 1px solid #D4D0C8;">
			  <tr>
				<td height="19" class="login_title"><img src="../Public/Images/sysImage/file/htm.gif" width="18" height="18" align="absmiddle" />&nbsp;登录到后台系统</td>
			  </tr>
			  <tr>
				<td height="71"><img src="../Public/Images/Manage/Main.gif" width="394" height="71" /></td>
			  </tr>
			  <tr>
			    <td height="3" bgcolor="#0A246A"></td>
		      </tr>
			  <tr>
				<td valign="top" bordercolor="#D4D0C8" bgcolor="#D4D0C8">
				<form id="form1" name="form1" method="post" action="login_chk.asp" target="_top">
				<input type="hidden" name="<%=validkey%>" value="<%=validkey%>" />
				<table width="100%" border="0" cellspacing="1" cellpadding="6">
                  <tr>
                    <td width="19%" align="center">用户名：</td>
                    <td width="81%"><input name="username" type="text" id="username" style="width: 250px;" /></td>
                  </tr>
                  <tr>
                    <td align="center">密&nbsp;&nbsp;码：</td>
                    <td><input name="password" type="password" id="password" style="width: 250px;" /></td>
                  </tr>
                  <tr>
                    <td align="center">&nbsp;</td>
                    <td align="right"><input type="submit" name="Submit" value="提交" />
                      &nbsp;&nbsp;
                      <input type="reset" name="Submit2" value="取消" onclick="window.opener=self;window.close();" />
                      &nbsp;&nbsp;</td>
                  </tr>
                </table>
                  </form>
			    </td>
			  </tr>
			</table>
		</td>
	  </tr>
	</table>
	</td>
  </tr>
</table>
</body>
<% end Sub %>
</html>
<% Sub Main() %>
<frameset id=testframeset cols="200,*" rows="*" bordercolor="menu" border="6" framespacing="6"> 
<frame name="leftFrame" src="menu.asp" frameborder="1" border="1" scrolling="NO">	
<frame name="mainFrame" src="helloworld.asp" frameborder="1" border="1" scrolling="NO">
</frameset>
<noframes>
<body bgcolor="#FFFFFF" text="#000000" >
</body>
</noframes>
<% end sub%>