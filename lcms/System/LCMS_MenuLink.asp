<!--#include file="../inc/common.asp"-->
<%
Dim Menu_Id, Id
Menu_Id = Request("mid")
Id = Request("id")

If Not (IsInteger(Menu_Id) OR IsInteger(Id)) Then
	MsgBox "请选择要修改的栏目！", "close", ""
End If 

if request.querystring("action")="delete" then
	lone.Execute("delete from LCMS_Link where Link_Id=" & cint(Request("id")))
    response.write("<script>opener.location.reload();window.close();</script>")
    response.end
end if

if request.querystring("action")="save" then
	lone.Execute("insert into LCMS_Link ([Link_MenuId], [Link_Name], [Link_Template], [Link_URL]) Values("&Menu_Id&",'"&RequestForm("textfield")&"','"&RequestForm("textfield2")&"','"&RequestForm("textfield3")&"')")
    response.write("<script>opener.location.reload();window.close();</script>")
    response.end
end if

if request.querystring("action")="saveedit" then
	lone.Execute("update LCMS_Link set Link_Name='"&RequestForm("textfield")&"',Link_Template='"&RequestForm("textfield2")&"',Link_URL='"&RequestForm("textfield3")&"' where link_id=" & id)
    response.write("<script>opener.location.reload();window.close();</script>")
    response.end
end if

if request.querystring("action")="edit" then
	set rs = lone.execute("select * from LCMS_Link where link_id="&  id)
    if not rs.eof then
    	action = "edit&id=" & id
        lname = rs("Link_Name")
        ltemp = rs("Link_Template")
        lurl = rs("Link_URL")             
    end if
    rs.close
    set rs = nothing
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<script language="JavaScript">
<!--
function ShowDialog(url, objSetValue, vWidth, vHeight) {
	if(!objSetValue)return false;
	var arr = showModalDialog(url, window, "dialogWidth:" + vWidth + "px;dialogHeight:" + vHeight + "px;help:yes;scroll:no;status:no");
	if(arr && arr!="" && arr!="undefined")
	objSetValue.value = arr;
}
//-->
</script>
</head>

<body>   
<form id="form1" name="form1" method="post" action="?action=save<%=action%>">
<input type="hidden" name="mid" value="<%= Menu_Id %>" />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
    <td width="80">&nbsp;名称：</td>
    <td><input name="textfield" type="text" id="textfield" size="20" value="<%=lname%>" /></td>
  </tr>
  <tr>
    <td>&nbsp;模板：</td>
    <td><input name="textfield2" type="text" id="textfield2" size="40" value="<%=ltemp%>" /><input type="button" onClick="ShowDialog('dialog.htm?SelectFile:1',textfield2,350,170);" value="选择" /></td>
  </tr>
  <tr>
    <td>&nbsp;URL：</td>
    <td><input name="textfield3" type="text" id="textfield3" size="40" value="<%=lurl%>" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="button" id="button" value="提交" /></td>
  </tr>
</table>
</form>
</body>
</html>
