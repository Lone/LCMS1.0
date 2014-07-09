<!--#include file="../inc/common.asp"-->
<%
Const MaxPerPage = 20
Dim CurrentPage, AllRecords, ShowPageList
Dim Rs, SQL, thisFileName
CurrentPage = 0 : AllRecords = 0
ShowPageList = true
ClassId = Trim(Request.QueryString("Menu_Id"))
If Not IsInteger(ClassId) Then
	MsgBox "参数丢失。", "back", ""
End If 
thisFileName = JoinChar(Lone.FileName) & "Menu_Id=" & ClassId
Menu_Data_Table = Lone.Execute("Select Menu_Data_Table From LCMS_Menu Where Menu_Id=" & ClassId)(0)
%>
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<style type="text/css">
ul { margin: 0px; padding:0px; width:100%; clear: both;}
ul.UL1 { background-color: #efefef;}
ul.UL1 Li { background-color: #efefef;}
ul li { line-height: 180%; height: 22px; float: left;}
li.LI0 { width: 5%; text-align: left; padding-left: 12px; overflow: hidden;}
li.LI1 { width: 44%;text-align: left; padding-left: 6px; overflow: hidden;}
li.LI2 { width: 10%;text-align: left; overflow: hidden;}
li.LI3 { width: 15%;text-align: left; overflow: hidden;}
li.LI4 { width: 4%;text-align: center; overflow: hidden;}
li.LI5 { width: 10%;text-align: center; overflow: hidden;}
div {clear: both;}
</style>
<script language="javascript">
	function Manage(id, flag){
		var url = "LCMS_Content_Manage.asp?id=" + id + "&flag=" + flag + "&menu_id=" + window.top.document.selected_menu_id;
		if(flag=="delete")
		if(!confirm('确定要删除这条数据吗？'))return false;
		location.href=url;
	}
	function Edit(id){
		if (!id)
		{
			alert("没有可操作的数据。");
			return false;
		}
		var url = "LCMS_ContentEdit.htm";
		window.top.document.content_edit_id = id;
		window.top.frames["mainFrame"].location.href = url;
	}
	function PreView(id){
		window.open("LCMS_ContentView.asp?id=" + id + "&menu_id=" + window.top.document.selected_menu_id);
	}
</script>
</head>

<body bgcolor="#FFFFFF" scroll="yes" text="#000000" oncontextmenu="return true;">
<ul>
<li class="LI0"><strong>ID</strong></li>
<li class="LI1"><strong>标题</strong></li>
<li class="LI2"><strong>作者</strong></li>
<li class="LI3"><strong>日期</strong></li>
<li class="LI4"><strong>置顶</strong></li>
<li class="LI4"><strong>推荐</strong></li>
<li class="LI4"><strong>图文</strong></li>
<li class="LI4"><strong>锁定</strong></li>
<li class="LI5"><strong>操作</strong></li>
</ul>
<%
SQL = "Select * From LCMS_Content"&chkIsNull(Menu_Data_Table)&" Where Content_Menu_Id=" & ClassId & " And Content_Deleted=0 Order By Content_On_Top Desc, Content_Orders"
set rs=server.CreateObject("adodb.recordset")

rs.open sql,conn,1,1
If Not Rs.EOF Then
	CurrentPage = Trim(Request("Page"))
	rs.PageSize = MaxPerPage
	If CurrentPage="" Or IsNumeric(CurrentPage)=False Then CurrentPage=1 Else CurrentPage=CInt(CurrentPage)
	If CurrentPage<1 Then CurrentPage=1
	If CurrentPage>rs.PageCount Then CurrentPage=rs.PageCount
	AllRecords = rs.RecordCount
	rs.absolutePage = CurrentPage
	session("page")=CurrentPage
	If rs.PageCount>1 Then ShowPageList=True
End If
bgcolor = "#efefef"
for i=1 to MaxPerpage
	if rs.eof then exit For
	If ChkIsNull(rs("Content_Title_Color"))="" Then 
		color="" 
	Else 
		color=" style='color:" & Trim(rs("Content_Title_Color")) & "'"
	End If 
%>
<ul class="UL<%=I Mod 2%>" onDblClick="Edit(<%= rs("content_id") %>);">
<li class="LI0"><%= rs("content_id") %></li>
<li class="LI1"><a href="javascript:Edit(<%= rs("content_id") %>);"><span<%=color%>><%= rs("Content_Title") %></span></a></li>
<li class="LI2"><%= rs("content_author") %></li>
<li class="LI3"><%= rs("content_Add_Time") %></li>
<li class="LI4"><% If Rs("Content_On_Top") Then %><img src="../public/images/manage/icon-ontop.gif" /><% Else %><img src="../public/images/manage/icon-blank.gif" /><% End If %></li>
<li class="LI4"><% If Rs("Content_Is_Best") Then %><img src="../public/images/manage/icon-isbest.gif" /><% Else %><img src="../public/images/manage/icon-blank.gif" /><% End If %></li>
<li class="LI4"><% If Rs("Content_Has_Image") Then %><img src="../public/images/manage/icon-hasimage.gif" /><% Else %><img src="../public/images/manage/icon-blank.gif" /><% End If %></li>
<li class="LI4"><% If Rs("Content_Locked") Then %><img src="../public/images/manage/icon-locked.gif" /><% Else %><img src="../public/images/manage/icon-blank.gif" /><% End If %></li>
<li class="LI5"><img src="../public/images/manage/icon-up.gif" class="button" onClick="Manage('<%= rs("content_id") %>','upOrders');" alt="上移一行" align="absmiddle" /><img src="../public/images/manage/icon-down.gif" class="button" onClick="Manage('<%= rs("content_id") %>','downOrders');" align="absmiddle" alt="下移一行" /><img src="../public/images/manage/icon-view.gif" class="button" align="absmiddle" onClick="PreView('<%= rs("content_id") %>');" alt="预览" /><img src="../public/images/manage/icon-close.gif" class="button" align="absmiddle" onClick="Manage('<%= rs("content_id") %>','delete');" alt="删除" /></li>
</ul>
<%
rs.MoveNext
Next

%>
<% If ShowPageList Then %>
<div id="PageHolder" align="center"><%Call showpage(thisFileName,AllRecords,maxperpage,True,True, "条") %></div>
<% End If %>
</body>
</html>
<%
rs.close
Set rs = Nothing
Set Lone = Nothing 
%>