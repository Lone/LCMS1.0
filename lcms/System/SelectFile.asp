<!--#include file="../inc/common.asp"-->
<%
Response.Expires = 0
Response.CacheControl = "no-cache"

Dim ParentFolder

ParentFolder = Trim(Request.QueryString("PId"))

If chkIsNull(ParentFolder)="" Then
	ParentFolder = "/"
End If
%>
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="GENERATOR" content="EditPlus" />
<meta name="AUTHOR" content="Lone Chain" />
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css" />
<style type="text/css">
.ListView {
	list-style: none;
	margin: 0px;
	padding-left: 12px;
	cursor: default;
	width: 100%;
	height: 100%;
	overflow: auto;
	overflow-x: hidden;
}
.ListView li {
	height: 20px;
	line-height: 20px;
	width: 100%;
	padding-top: 3px;
	text-align: left;
	overflow: hidden;
}
.ListView li img { margin-right: 6px;}
.ListView li span {
	float: right;
	margin: 0px;
}
.ListView input.count { width: 30px; height: auto; font-size: 12px;}

</style>
<script language="javascript">
var windowReturnValue = "";
function Selected(sItem,id){
	//var ul = document.getElementById("ProvinceList");
	var li = sItem.parentNode.childNodes
	var index = 0
	for (var i=0; i<li.length; i++)
	{
		li[i].style.backgroundColor = "";
		li[i].style.color = "#000000";
		if (li[i]==sItem)index=i;
	}
	sItem.style.backgroundColor = "#0000ff";
	sItem.style.color = "#ffffff";
	windowReturnValue = id;


}

function ContentPub(){
//	dialogArguments.top.document.selected_menu_id = dialogArguments.frames["iframemain"].form1.Menu_Id.value;
	window.returnValue = windowReturnValue;
	window.close();
}
</script>
</head>

<body bgcolor="#FFFFFF" scroll="no" text="#000000" onselectstart="return false;">
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td height="20" width="50" align="center" class="button" onClick="ContentPub();"><img border="0" src="../public/images/Manage/Icon_File_Save.gif" align="absmiddle"> 保存</td>
<% If ParentFolder <> "/" Then 
History = Left(ParentFolder, InstrRev(Left(ParentFolder, Len(ParentFolder)-1), "/"))
%>
<td width="50" align="center" class="button" onClick="location.href='?PId=<%= History %>';"><img border="0" src="../public/images/Manage/Icon_Up.gif" align="absmiddle"> 返回</td>
<% End If %>
<td>&nbsp;</td>
</tr>
</table>

<table width="100%" style="height:expression(document.body.offsetHeight-25)" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="center" valign="top" width="100%" height="100%">
<ul class="ListView">
<% 
Set FSO = Server.CreateObject(LONE_FSO)

Set cFolder = FSO.GetFolder(Server.MapPath(ParentFolder))

For Each Folder In cFolder.SubFolders
%>
<li onClick="Selected(this, '<%=ParentFolder&Folder.Name&"/"%>');" onDblClick="location.href='?PId=<%=ParentFolder&Folder.Name&"/"%>'"><img src="../public/images/Manage/icon-folder.gif" width="15" height="12" align="absmiddle" /><%= Folder.Name %></li>
<%
Next

For Each File In cFolder.Files
 %>
<li onClick="Selected(this, '<%=ParentFolder&File.Name%>');"><img src="../public/images/sysImage/file/<%= FSO.getExtensionName(File.Name) %>.gif" onerror="this.src='../public/images/sysImage/file/unknow.gif'" align="absmiddle" /><%= File.Name %></li>
<%
Next

%>
</ul>
</td>
</tr>
</table>
</body>
</html>