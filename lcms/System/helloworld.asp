<!--#include file="../inc/ver.asp"-->
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<script>
function tick() {
var hours, minutes, seconds, ap;
var intHours, intMinutes, intSeconds;
var today;
today = new Date();
intHours = today.getHours();
intMinutes = today.getMinutes();
intSeconds = today.getSeconds();
if (intHours == 0) {
hours = "12:";
ap = "Midnight";
} else if (intHours < 12) { 
hours = intHours+":";
ap = "A.M.";
} else if (intHours == 12) {
hours = "12:";
ap = "Noon";
} else {
hours = intHours + ":";
ap = "P.M.";
}
if (intMinutes < 10) {
minutes = "0"+intMinutes+":";
} else {
minutes = intMinutes+":";
}
if (intSeconds < 10) {
seconds = "0"+intSeconds+" ";
} else {
seconds = intSeconds+" ";
} 
timeString = hours+minutes+seconds+ap;
Clock.innerHTML = timeString;
window.setTimeout("tick();", 1000);
}
window.onload = tick;
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" onselectstart="return false;">
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td height="20" width="80"><img src="../public/images/manage/icon-default.gif" width="16" height="15" class="button" onClick="javascript:window.parent.testframeset.cols = '200,*';" vspace="2" hspace="1" alt="恢复左栏默认宽度"></td>
<td width="80" align="center" class="button" onClick="location.href='LCMS_MenuAdd.htm';">新建子目录</td>

<td>&nbsp;</td>
</tr>
</table>
<table id=control width="100%" style="height:expression(document.body.offsetHeight-25)" border="0" cellspacing="0" cellpadding="3" class="borderon">
<tr>
<td align="center" valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
<tr>
<td valign="top"><div id=iframexxx style="visibility:hidden"><iframe name=iframemain width="100%" height="100%" marginwidth=0 marginheight=0 frameborder=0 vspace=0 hspace=0></iframe></div></td>
</tr>
</table>
</td>
</tr>
<tr>
<td align="right" valign="bottom" height="20">
<table border="0" cellspacing="0" cellpadding="2">
<tr>
<td align="center" class="borderoff"><span class="tden">Lone Content Management System <%=SYS_VERSION%> &nbsp;Copyright <font face="Arial">&copy;</font> 2008 All Rights Reserved.&nbsp;|&nbsp;<span id="Clock"></span>&nbsp;</span></td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>