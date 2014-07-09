<!--#include file="../inc/common.asp"-->
<%
Dim Rs, SQL

If Not Lone.chkPost Then
	sLog = Lone.Admin_Name & "从外部提交数据！"
	Lone.AddToLog(sLog)
	MsgBox "非法操作：请不要从外部提交数据！", "back", ""
End If
Menu_Id = RequestForm("Menu_Id")
Menu_Name = RequestForm("Menu_Name")
Menu_English_Name = RequestForm("Menu_English_Name")
Menu_Parent_Id = RequestForm("Menu_Parent_Id")
Menu_Type = RequestForm("Menu_Type")
Menu_Allow_Pub = RequestForm("Menu_Allow_Pub")
Menu_Icon = RequestForm("Menu_Icon")
Menu_List_Template = RequestForm("Menu_List_Template")
Menu_Content_Template = RequestForm("Menu_Content_Template")
Menu_List_URL = RequestForm("Menu_List_URL")
Menu_Content_URL = RequestForm("Menu_Content_URL")
Menu_Infomation = Request.Form("Menu_Infomation")
Menu_Data_Table = RequestForm("Menu_Data_Table")

Menu_Master_Pub = RequestForm("Menu_Master_Pub")
Menu_Company_Pub= RequestForm("Menu_Company_Pub")
Menu_Member_Pub = RequestForm("Menu_Member_Pub")
Menu_Orders = RequestForm("Menu_Orders")

If Not IsInteger(Menu_Type) Then Menu_Type = 0
If Not IsInteger(Menu_Orders) Then Menu_Orders = 0
If Menu_Master_Pub <> "1" Then Menu_Master_Pub = 0
If Menu_Company_Pub <> "1" Then Menu_Company_Pub = 0
If Menu_Member_Pub <> "1" Then Menu_Member_Pub = 0

If Not IsInteger(RequestForm("Menu_List_Count")) Then
Menu_List_Count = 20
Else
Menu_List_Count = CInt(RequestForm("Menu_List_Count"))
End if

If Not IsInteger(Menu_Id) Then 
	MsgBox "未知的目录ID", "back", ""
End If 

set rs=server.CreateObject("adodb.recordset")
sql="select * from LCMS_Menu Where Menu_Id=" & Menu_Id
rs.open sql,conn,1,3

Rs("Menu_Name") = Menu_Name
Rs("Menu_English_Name") = Menu_English_Name
Rs("Menu_Icon") = Menu_Icon
Rs("Menu_Type") = Menu_Type
Rs("Menu_List_Template") = Menu_List_Template
Rs("Menu_Content_Template") = Menu_Content_Template
Rs("Menu_List_URL") = Menu_List_URL
Rs("Menu_Content_URL") = Menu_Content_URL
Rs("Menu_Infomation") = Menu_Infomation
'Rs("Menu_Data_Table") = Menu_Data_Table
Rs("Menu_List_Count") = Menu_List_Count
Rs("Menu_Master_Pub") = Menu_Master_Pub
Rs("Menu_Company_Pub") = Menu_Company_Pub
Rs("Menu_Member_Pub") = Menu_Member_Pub
Rs("Menu_Orders") = Menu_Orders
rs.update
rs.close
set rs=Nothing

sLog = Lone.Admin_Name & "修改目录:" & Menu_Name
Lone.AddToLog(sLog)
%>
<script language="javascript">
	window.onload = function () {
		window.top.location.reload();		
		//window.top.frames["mainFrame"].location.href='LCMS_Content.htm';
	}
</script>
<%
Set Lone = Nothing 

%>