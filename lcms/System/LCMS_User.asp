<!--#include file="../inc/common.asp"-->
<%
Const MaxPerPage = 20
Dim CurrentPage, AllRecords, ShowPageList
Dim Rs, SQL, thisFileName
Dim action
CurrentPage = 0 : AllRecords = 0
ShowPageList = True

thisFileName = Lone.FileName
'thisFileName = JoinChar(Lone.FileName) & "Menu_Id=" & ClassId

Lone.chkAdmin("")
action = Request.QueryString("action")
If action = "Manage" Then 
	Call Manage()
End If
If action = "Delete" Then 
	Call Delete()
End If
If action = "save" Then 
	Call Save()
End If


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
		var url = "LCMS_User.asp?id=" + id + "&action=" + flag;
		if(flag=="delete"){
			url = "LCMS_User.asp?action=Delete&UserId=" + id;
			if(!confirm('确定要删除这条数据吗？'))return false;
		}
		location.href=url;
	}
	function Edit(id){
		if (!id)
		{
			alert("没有可操作的数据。");
			return false;
		}
		//var url = "/Member/?UserId=" + id;
		var url = "LCMS_User.asp?action=Manage&UserId=" + id;
		//window.top.document.content_edit_id = id;
		window.open(url);
	}
	function MemberCreate(vType){
		if (vType=="") return false;
		var url = "pubUserList.htm?" + vType;
		var arr = showModalDialog(url,window,"dialogWidth:450px;dialogHeight:250px;help:no;scroll:no;status:no");	
	}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" onselectstart="return false;">
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td height="20" width="80"><img src="../public/images/manage/icon-default.gif" width="16" height="15" class="button" onClick="javascript:window.parent.testframeset.cols = '200,*';" vspace="2" hspace="1" alt="恢复左栏默认宽度"></td>
<td width="80" align="center" class="button" onclick="MemberCreate('<%=Request.QueryString("UserType")%>');">生成列表</td>
<td>&nbsp;</td>
</tr>
</table>
<table id=control width="100%" style="height:expression(document.body.offsetHeight-25)" border="0" cellspacing="0" cellpadding="3" class="borderon">
<tr>
<td align="center" valign="top" bgcolor="#ffffff">

<% 
If action="edit" Then
	Edit
Else
	Main 
End If
%>

</td>
</tr>
</table>
</body>
</html>
<%
Set Lone = Nothing 
%>

<%
Sub Main()

%>
<ul>
<li class="LI0"><strong>ID</strong></li>
<li class="LI1"><strong>帐号</strong></li>
<li class="LI3"><strong>注册日期</strong></li>
<li class="LI4"><strong>锁定</strong></li>
<li class="LI5"><strong>操作</strong></li>
</ul>

<%
Dim UserType
UserType = Request.QueryString("UserType")
If Not IsInteger(UserType) Then
	MsgBox "参数错误", "back", ""
End If

SQL = "Select * From LCMS_User Where (UserType = " & UserType & ") Order By RegTime Desc"
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
%>
<ul class="UL<%=I Mod 2%>" onDblClick="Edit(<%= rs("UserId") %>);">
<li class="LI0"><%= rs("UserId") %></li>
<li class="LI1"><a href="javascript:Manage(<%= rs("UserId") %>,'edit');"><span<%=color%>><%= rs("UserName") %></span></a></li>
<li class="LI3"><%= rs("RegTime") %></li>
<li class="LI4"><% If Rs("Locked") Then %><img src="../public/images/manage/icon-locked.gif" /><% Else %><img src="../public/images/manage/icon-blank.gif" /><% End If %></li>
<li class="LI5"><img src="../public/images/manage/icon-view.gif" class="button" align="absmiddle" onClick="Edit('<%= rs("UserId") %>');" alt="进入用户后台" /><img src="../public/images/manage/icon-close.gif" class="button" align="absmiddle" onClick="Manage('<%= rs("UserId") %>','delete');" alt="删除" /></li>
</ul>
<%
rs.MoveNext
Next

%>
<% If ShowPageList Then %>
<div id="PageHolder" align="center"><%Call showpage(thisFileName,AllRecords,maxperpage,True,True, "条") %></div>
<% End If 
rs.close
Set rs = Nothing

End Sub 

Sub Manage()
Dim UserId

UserId = Request.QueryString("UserId")
If Not IsInteger(UserId) Then
	MsgBox "参数错误", "close", ""
End If

Call Lone.SaveToFile("True", "../Plugins/API.asp")

Response.Redirect("/Member/?UserId=" & UserId)

Response.End()
End Sub 

Sub Save()
Dim UserId

UserId = Request.Form("UserId")
If Not IsInteger(UserId) Then
	MsgBox "参数错误", "close", ""
End If
UserType = RequestForm("UserType")
Locked = RequestForm("Locked")
If Locked ="" Then Locked =0

Lone.Execute("Update LCMS_User Set Locked=" & Locked & "")

Response.Redirect("LCMS_User.Asp?UserType=" & UserType & "&Page=" & Session("page"))

Response.End()
End Sub 

Sub Delete()
	Dim UserId
	If Not Lone.chkPost Then
		sLog = Lone.Admin_Name & "从外部提交数据！"
		Lone.AddToLog(sLog)
		MsgBox "非法操作：请不要从外部提交数据！", "back", ""
	End If
	UserId = Request.QueryString("UserId")
	If Not IsInteger(UserId) Then
		MsgBox "参数错误", "back", ""
	End If
	
	Set rs = Server.CreateObject("ADODb.Recordset")
	Rs.open "select * from LCMS_User Where UserId=" & UserId, Conn, 3, 3
	If Rs.EOF Then
		MsgBox "没有这条记录。", "close", ""
	End If 

	UserName = Rs("username")
	UserType = Rs("UserType")

	Rs.Delete
	Rs.Update

	Rs.Close
	Set Rs = Nothing 

	'Lone.Execute("Delete From LCMS_User Where UserId=" & UserId)
	'Lone.Execute("Delete From LCMS_UserInfo Where UserId=" & UserId)
	'Lone.Execute("Delete From LCMS_User_Setting Where User_Id=" & UserId)
	'Lone.Execute("Delete From LCMS_Sub Where Sub_User_Id=" & UserId)

	sLog = Lone.Admin_Name & "删除用户: " & UserName
	Lone.AddToLog(sLog)

	Response.Redirect("LCMS_User.Asp?UserType=" & UserType & "&Page=" & Session("page"))
	Response.End()
End Sub 

Sub Edit()
Dim Id
Id = Request.QueryString("Id")
If Not Isinteger(Id ) Then
	MsgBox "参数错误", "back", ""
End If
Set Rs = Lone.Execute("select * from LCMS_User Where UserId=" & ID)
%>
<form action="?action=save" name="form1" method="post">
<input type="hidden" name="userid" value="<%=id%>" />
<input type="hidden" name="usertype" value="<%=rs("UserType")%>" />
<div align="left">
<input type="checkbox" name="Locked" value="1"<% if rs("Locked") then response.Write(" checked") %> />锁定
</div>
<input  type="submit" name="submit" value="确定" />
<input  type="reset" name="t" value="取消" onClick="history.back();" />
</form>
<%

	Rs.Close
	Set Rs = Nothing 
End Sub 
%>