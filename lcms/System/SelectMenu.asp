<!--#include file="../inc/common.asp"-->
<%
Response.Expires = 0
Response.CacheControl = "no-cache"
Dim ParentId
ParentId = Request.QueryString("PId")
If Not IsInteger(ParentId) Then
	ParentId = 0
End If 


Dim Rs, tempStr
Set Rs = Lone.Execute("Select * From LCMS_Menu Where Menu_Parent_Id="&parentId&" Order By Menu_Orders")

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
var return_value = '0';
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

	//dialogArguments.frames["iframemain"].form1.Menu_Id.value = id;
	return_value = id;
}

function ContentPub(){
//	dialogArguments.top.document.selected_menu_id = dialogArguments.frames["iframemain"].form1.Menu_Id.value;
	window.returnValue = return_value;
	window.close();
}
</script>
</head>

<body bgcolor="#FFFFFF" scroll="no" text="#000000" onselectstart="return false;">
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td height="20" width="50" align="center" class="button" onclick="ContentPub();"><img border="0" src="../public/images/Manage/Icon_File_Save.gif" align="absmiddle"> 保存</td>
<% If ParentId>0 Then 
oParentId = Lone.Execute("Select Menu_Parent_Id From LCMS_Menu Where Menu_Id=" & ParentId)(0)

%>
<td width="50" align="center" class="button" onclick="location.href='?PId=<%= oParentId %>';"><img border="0" src="../public/images/Manage/Icon_Up.gif" align="absmiddle"> 返回</td>
<% End If %>
<td>&nbsp;</td>
</tr>
</table>

<table width="100%" style="height:expression(document.body.offsetHeight-25)" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="center" valign="top" width="100%" height="100%">
<ul class="ListView">
<% Do While Not Rs.EOF 
	If Rs("Menu_Child_Count")>0 Then
%>
<li onclick="Selected(this, '<%= Rs("Menu_Id") %>');" ondblclick="location.href='?PId=<%= Rs("Menu_Id") %>'"><img src="../public/images/Manage/icon-folder.gif" width="15" height="12" /><%= Rs("Menu_Name") %></li>
<%	Else %>
<li onclick="Selected(this, '<%= Rs("Menu_Id") %>');"><img src="../public/images/Manage/icon-blank.gif" width="15" height="12" /><%= Rs("Menu_Name") %></li>
<%
	End If
Rs.MoveNext
Loop
Rs.Close
Set Rs = Nothing
%>
</ul>
</td>
</tr>
</table>
</body>
</html>