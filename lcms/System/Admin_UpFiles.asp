<!--#include file="../inc/common.asp"-->
<% 
Lone.chkAdmin(13)
Dim action
Const MaxPerPage = 20
Dim CurrentPage, AllRecords
Dim thisFileName,DateOf

action = LCase(Trim(Request("action")))
DateOf = Trim(Request("DateOf"))
If Not IsDate(DateOf) Then
	DateOf = ""
End If

thisFileName = "Admin_Upfiles.asp"
If action="dele" Then
	If not IsObjInstalled("Scripting.FileSystemObject") Then
		MsgBox "你的服务器不支持 FSO(Scripting.FileSystemObject)! ", "back", ""
	Else
		Files = ""
		Set Rs = Server.CreateObject("AdoDb.RecordSet")
		set fso=CreateObject("Scripting.FileSystemObject")
		Rs.Open "select [URL] From Upload_Files Where Id In (" & Request("Id") & ")", Conn, 1, 3
		Do While Not Rs.EOf
			Files = Files & Rs(0) & "<br />"
			whichfile = Server.MapPath(Rs(0))
			If fso.FileExists(whichfile) Then
				FSO.DeleteFile(whichfile)
			End If
			bImageURL = Rs(0)
			FileDir = Left(bImageURL, InstrRev(bImageURL, "/"))
			FileName = Mid(bImageURL, InstrRev(bImageURL, "/")+1)
			sImageURL = FileDir & "s_" & FileName
			whichfile = Server.MapPath(sImageURL)
			If fso.FileExists(whichfile) Then
				FSO.DeleteFile(whichfile)
			End If

			Rs.Delete()
			Rs.MoveNext
		Loop
		Rs.Close
		Set Rs = Nothing
		sLog = Lone.Admin_Name & "删除远程文件: <br />" & Files & ""
		Lone.AddToLog(sLog)
		Response.Redirect("Admin_UpFiles.asp")
	End If
End If

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<link rel="stylesheet" href="../public/css/admin_style.css" type="text/css">
<script language="javascript" src="../public/js/admin.js"></script>
<script language="javascript" src="../public/js/main.js"></script>
<script language="javascript" src="../public/js/calendar.js"></script>
</head>

<body>
<table id=control width="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<form method="post" action="Admin_UpFiles.asp" name="form2">
<tr>
<td height="20" width="80"><img src="../public/images/manage/icon-default.gif" width="16" height="15" class="button" onClick="javascript:window.parent.testframeset.cols = '200,*';" vspace="2" hspace="1" alt="恢复左栏默认宽度"></td>
<td width="50" align="center" class="button" onClick="if(confirm('确定要删除选中的文件吗？'))form1.submit();">
<img border="0" src="../public/images/Manage/Icon_File_Delete.gif" align="absmiddle"> 删除
		</td>	
		<TD>&nbsp;</TD>


		<TD align="right">
			<input type="text" size="20" name="DateOf" class="input" value="<%= DateOf %>" mustFill="1" isDate="1" info="请输入要查看的日期" onclick="show_cele_date(this,'','',this,this.value)" />
		</TD>	
		<td class="button" nowrap onclick="if(Lone_chkForm(form2))form2.submit();" title="按日期查看" width="50"
		height="20"><img border="0" src="../public/images/Manage/search_s.gif" align="absmiddle"> 查看
		</td>	
		<TD width="5"><SPAN class="sepbtn1"></SPAN></TD>
	</TR>
</form>
</TABLE>
<div id="navi" style="position:relative; width:100%; height:expression(body.offsetHeight-control.offsetHeight-2); z-index:1; left: 0px; top: 0px; overflow: auto">
<%
	Call List()
%>
</div>
<% 
Sub List()
Set Rs = Server.CreateObject("ADODB.Recordset")
SQL = "select * from Upload_Files Where Id>0 "

'If Lone.Admin_Level="1" Then
'	SQL = SQL & "And FileFrom=0 "
'ElseIf Lone.Admin_Level="2" Then
'	SQL = SQL & "And FileFrom=1 "
'ElseIf Lone.Admin_Level="3" Then
'	SQL = SQL & "And UploadUser='" & Lone.Admin_Name & "' "
'End If

If DateOf<>"" Then
	If DatabaseType = 1 Then
		SQL = SQL & "And DateDiff(d,UploadTime,'" & FormatDateTime(DateOf,2) & "')=0 "
	Else
		SQL = SQL & "And DateDiff('d',UploadTime,'" & FormatDateTime(DateOf,2) & "')=0 "
	End If
	thisFileName = JoinChar(thisFileName) & "DateOf=" & DateOf
End If
SQL = SQL & "Order By UploadTime Desc"
'response.write sql

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
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="border">
  <form name="form1" method="post" action="?action=dele">
  <tr class="tdbg1">
	  <td width="5%" height="25" align="center">
		<input type="checkbox" value="" id="chkAll" style="border:0;" title="全部选中" onclick="CheckAll(this.form)" />
	  </td> 
	<th width="200">文件名</th>
	<th>URL</th>
	<th width="8%">文件大小</th>
	<th width="15%">上传时间</th>
	<th width="8%">上传人</th>
	<th width="10%">IP</th>
  </tr>
<%
	For I=1 To MaxPerPage
		If Rs.EOF Then Exit For	
	Icon = 	Mid(Rs("FileName"),InstrRev(Rs("FileName"),".")+1) & ".gif"
%>
  <tr class="tdbg" onMouseOver="this.className='heigthlight'" onmouseout="this.className='tdbg'">
  <td align="center"><input type="checkbox" value="<%= Rs("Id") %>" name="Id" style="border:0;" /></td>
	<td align="left"><div class="inLine" title="<%= Rs("FileName") %>"><img src="../public/images/sysImage/File/<%= Icon %>" border="0" onerror="this.src='../public/images/sysImage/file/unknow.gif'" align="absmiddle" /><strong><%= Rs("FileName") %></strong></div></td>
	<td align="left"  onclick="viewImage(this, <%=I%>);"><%= Rs("URL") %></td>
	<td align="center"><%= getFileSize(Rs("FileSize")) %></td>
	<td align="center"><%= Rs("UploadTime") %></td>
	<td align="center"><%= Rs("UpLoadUser") %></td>
	<td align="center"><%= Rs("IP") %></td>
  </tr>
<% 
	Rs.MoveNext
	Next
	Rs.Close
	Set Rs = Nothing
%>
</form>
</table>
<script language="javascript">
document.write('<div style="position:absolute; width:10px; height:10px; left:-100px; height:-100px; border: 1px solid #bbbbbb; padding: 2px; background-color: #ffffff;" onclick="hiddeImg();" id="infoRange"></div>');
var o;
var imgs = new Array(<%=MaxPerPage%>);
function viewImage(td, imgIndex){
	var imageURL = td.innerHTML;
	var imgExt = ".jpg|.jpeg|.gif|.bmp|.png|.tif|"
	var ext = imageURL.substr(imageURL.lastIndexOf(".")).toLowerCase();
	if (imgExt.indexOf(ext)==-1) return;
	if (td==o) {hiddeImg(); return; }
	//展示图片

	var div = document.getElementById("infoRange");	
	div.innerHTML = "";
	var img = document.createElement('img');
	div.style.left = event.x;
	div.style.top = event.y;

	if (imgs[imgIndex])
	{
		img.src = imgs[imgIndex].src;
		img.width = imgs[imgIndex].width;
		img.height = imgs[imgIndex].height;
		div.appendChild(img);
		return;
	}

	var tempImg = new Image;
	tempImg.src = imageURL;

	if (tempImg.height>0 && tempImg.width>0)
	{
		w = tempImg.width;
		if (w>300){ w = 300;
		tempImg.height = parseInt(tempImg.height * 300/tempImg.width);
		tempImg.width = w;}
		imgs[imgIndex] = new Image;
		imgs[imgIndex].src = tempImg.src;
		imgs[imgIndex].width = w;
		imgs[imgIndex].height = tempImg.height;
		tempImg = null;	
		img.src = imgs[imgIndex].src;
		img.width = imgs[imgIndex].width;
		img.height = imgs[imgIndex].height;
		div.appendChild(img);
		return;
	}

	img.src = "../public/images/Manage/loading.gif";
	div.appendChild(img);
	div.appendChild(document.createTextNode('Loading...'));

	o = td;
	tempImg.onload = function (){
		div.innerHTML = "";
		w = tempImg.width;
		if (w>300){ w = 300;
		tempImg.height = parseInt(tempImg.height * 300/tempImg.width);
		tempImg.width = w;}
		div.appendChild(tempImg);
		imgs[imgIndex] = new Image;
		imgs[imgIndex].src = tempImg.src;
		imgs[imgIndex].width = w;
		imgs[imgIndex].height = tempImg.height;
		tempImg = null;
	}
	//tempImg.onerror = hiddeImg;

}


function hiddeImg(){
	var div = document.getElementById("infoRange");
	div.innerHTML = "";
	div.style.left = "-100px";
	div.style.top = "-100px";
	o = null;
}
</script>
<p align="center">
<% 
Call showpage(thisFileName,AllRecords,maxperpage,True,False,"个文件")
End Sub 


Function getFileSize(fsz)
	If Not isInteger(fsz) Then
		getFileSize = "unknown"
		Exit Function
	End If
	fsz = Int(fsz)
	If fsz<1000 Then
		getFileSize = fsz & " Byte"
	ElseIf fsz<1000000 Then
		getFileSize = FormatNumber(fsz/1000,1) & " KB"
	Else
		getFileSize = FormatNumber(fsz/1000000,2) & " MB"
	End If
End Function
%> 




