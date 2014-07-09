<!--#include file="../inc/Common.asp"-->
<%
Dim Menu_Id
Dim Content_Id
Dim DownIndex
Dim Menu_Data_Table
Dim DownURLs

'On Error Resume Next 

Menu_Id = CInt(Request.QueryString("cid"))
Content_Id = CInt(Request.QueryString("id"))
DownIndex = CInt(Request.QueryString("i"))

Menu_Data_Table = Lone.Execute("Select Menu_Data_Table From LCMS_Menu Where Menu_Id=" & Menu_Id)(0)
DownURLs = Lone.Execute("Select Content_DownURLs From LCMS_Content"&Menu_Data_Table&" Where Content_Id=" & Content_Id)(0)

Lone.Execute("Update LCMS_Content"&Menu_Data_Table&" Set Content_DownCount=Content_DownCount+1 Where Content_Id=" & Content_Id)
DownURL = Split(DownURLs,"||")(DownIndex)

If LCase(Left(DownURL,7))<>"http://" Then
%>
<script language="javascript">
	window.onload = function(){
		if (!document.all)
		{
			alert('请使用IE浏览器下载本资源。');
			window.close();
		}
		var a = document.createElement('A');
		a.href = '<%= DownURL %>';
		document.body.appendChild(a);
		a.click();
		window.close();
	}
</script>
<%
Else
	Response.Redirect(DownURL)
End If
If Err Then Err.Clear()
Set Lone = Nothing
%>