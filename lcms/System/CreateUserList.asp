<!--#include file="../inc/common.asp"-->
<%
Response.Expires = 0
Response.CacheControl = "no-cache"
Server.ScriptTimeOut = 9999
Session.TimeOut = 60

Dim UserType, UserTypeName, TypeInt
Dim getMemberListFlag

UserType = Trim(Request.QueryString("UserType"))
UserTypeName = Trim(Request.QueryString("typename"))
TypeInt = Trim(Request.QueryString("i"))

If UserType="1" Then
	getMemberListFlag = "MemberType"
ElseIf UserType="2" Then
	getMemberListFlag = "CompanyType"
End If	

Lone.CreateTemplateFile "/Templates/ee.txt", "userlist", UserTypeName
Lone.SavePageContent "/User/" & PinYin(UserTypeName) & "-" & TypeInt & ".html", ""

%>
<script language="javascript">
	window.onload = function(){
		parent.Reload();
	}
</script>