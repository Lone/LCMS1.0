<!--#include file="../inc/common.asp"-->
<%
Dim Rs, SQL

If Not Lone.chkPost Then
	sLog = Lone.Admin_Name & "从外部提交数据！"
	Lone.AddToLog(sLog)
	MsgBox "非法操作：请不要从外部提交数据！", "back", ""
End If
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
Menu_Data_Table = Replace(Menu_Data_Table," ","")
Menu_Master_Pub = RequestForm("Menu_Master_Pub")
Menu_Company_Pub= RequestForm("Menu_Company_Pub")
Menu_Member_Pub = RequestForm("Menu_Member_Pub")

If Not IsInteger(Menu_Type) Then Menu_Type = 0
If Menu_Master_Pub <> "1" Then Menu_Master_Pub = 0
If Menu_Company_Pub <> "1" Then Menu_Company_Pub = 0
If Menu_Member_Pub <> "1" Then Menu_Member_Pub = 0

If Not IsInteger(RequestForm("Menu_List_Count")) Then
Menu_List_Count = 20
Else
Menu_List_Count = CInt(RequestForm("Menu_List_Count"))
End if

If Not IsInteger(Menu_Parent_Id) Then 
	MsgBox "未知的父目录ID", "back", ""
End If 

Set rs = Lone.Execute("Select COUNT(*) From LCMS_Menu Where Menu_Parent_Id="&Menu_Parent_Id)
If isinteger(rs(0)) Then 
	orderNum = Rs(0)+1
Else
	orderNum = 1
End If 
set rs=Nothing
Call CreateBataTable(Menu_Data_Table)
set rs=server.CreateObject("adodb.recordset")
sql="select * from LCMS_Menu Where Menu_Id Is Null"
rs.open sql,conn,1,3

rs.addnew
Rs("Menu_Name") = Menu_Name
Rs("Menu_English_Name") = Menu_English_Name
Rs("Menu_Parent_Id") = Menu_Parent_Id
Rs("Menu_Icon") = Menu_Icon
Rs("Menu_Type") = Menu_Type
Rs("Menu_List_Template") = Menu_List_Template
Rs("Menu_Content_Template") = Menu_Content_Template
Rs("Menu_List_URL") = Menu_List_URL
Rs("Menu_Content_URL") = Menu_Content_URL
Rs("Menu_Infomation") = Menu_Infomation
Rs("Menu_Data_Table") = Menu_Data_Table
Rs("Menu_List_Count") = Menu_List_Count
Rs("Menu_Orders") = orderNum

Rs("Menu_Master_Pub") = Menu_Master_Pub
Rs("Menu_Company_Pub") = Menu_Company_Pub
Rs("Menu_Member_Pub") = Menu_Member_Pub
rs.update

rs.close
set rs=Nothing

If DatabaseType=2 Then
	Lone.Execute ("Update LCMS_Menu Set Menu_Child_Count=Menu_Child_Count+1 Where Menu_Id=" & Menu_Parent_Id)
End If 


sLog = Lone.Admin_Name & "新建目录:" & Menu_Name
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


Sub CreateBataTable(extName)
	If extName="" Then Exit Sub
	On Error Resume Next
	Dim SQL

	SQl = ""
	SQl = SQL & "If Not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LCMS_Content"&extName&"]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" & vbNewLine

	SQl = SQL & "CREATE TABLE [dbo].[LCMS_Content"&extName&"](" & vbNewLine
	SQl = SQL & "	[Content_Id] [int] IDENTITY(1,1) NOT NULL," & vbNewLine
	SQl = SQL & "	[Content_Menu_Id] [int] NOT NULL," & vbNewLine
	SQl = SQL & "	[Content_Title] [varchar](250) NULL," & vbNewLine
	SQl = SQL & "	[Content_Title_Color] [varchar](16) NULL," & vbNewLine
	SQl = SQL & "	[Content_User_Id] [int] NULL  DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Keyword] [varchar](100) NULL," & vbNewLine
	SQl = SQL & "	[Content_Description] [text] NULL," & vbNewLine
	SQl = SQL & "	[Content_Author] [varchar](150) NULL," & vbNewLine
	SQl = SQL & "	[Content_Editor] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_Copy_From] [varchar](150) NULL," & vbNewLine
	SQl = SQL & "	[Content_Content] [text] NULL," & vbNewLine
	SQl = SQL & "	[Content_Market_Price] [money] NULL," & vbNewLine
	SQl = SQL & "	[Content_Price] [money] NULL," & vbNewLine
	SQl = SQL & "	[Content_VIP_Price] [money] NULL," & vbNewLine
	SQl = SQL & "	[Content_Sale_Price] [money] NULL," & vbNewLine
	SQl = SQL & "	[Content_Has_Image] [int] NULL DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Image_URL] [varchar](150) NULL," & vbNewLine
	SQl = SQL & "	[Content_sImage_URL] [varchar](150) NULL," & vbNewLine
	SQl = SQL & "	[Content_On_Top] [int] NULL DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Is_Best] [int] NULL," & vbNewLine
	SQl = SQL & "	[Content_Locked] [int] NULL DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Clicks] [int] NULL DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Add_Time] [datetime] NULL DEFAULT (getdate())," & vbNewLine
	SQl = SQL & "	[Content_URL] [varchar](250) NULL," & vbNewLine
	SQl = SQL & "	[Content_Publish_Time] [datetime] NULL," & vbNewLine
	SQl = SQL & "	[Content_Deleted] [int] NULL DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Orders] [int] NULL," & vbNewLine
	SQl = SQL & "	[Content_SubId] [int] NULL DEFAULT ((0))," & vbNewLine
	SQl = SQL & "	[Content_Version] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_Language] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_License] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_RunOS] [varchar](250) NULL," & vbNewLine
	SQl = SQL & "	[Content_Size] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_DemoURL] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_RegURL] [varchar](50) NULL," & vbNewLine
	SQl = SQL & "	[Content_DownURLs] [text] NULL," & vbNewLine
	SQl = SQL & "	[Content_DownCount] [int] NULL DEFAULT ((0))" & vbNewLine
	SQl = SQL & ") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]" & vbNewLine

	Lone.Execute(SQL)
End Sub 
%>