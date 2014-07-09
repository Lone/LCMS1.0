<!--#include file="../inc/Common.asp"-->
<%
Content_Id=Cint(Request("Id"))
If Request("Type")="user" then
	Lone.Execute("update LCMS_User Set Visitors=Visitors+1 Where UserId=" & Content_Id)
else
	Lone.Execute("update LCMS_Content Set Content_Clicks=Content_Clicks+1 Where Content_Id=" & Content_Id)
end if 

Set Lone = Nothing
%>