<!--#include file="../inc/common.asp"-->
<!--#include file="../inc/md5.asp"-->
<%
Dim Content_Id
Dim Content_Menu_Id
Dim Content_Title
Dim Content_Title_Color
Dim Content_User_Id
Dim Content_Keyword
Dim Content_Description
Dim Content_Author
Dim Content_Editor
Dim Content_Copy_From
Dim Content_Price
Dim Content_Content
Dim Content_Has_Image
Dim Content_Image_URL
Dim Content_sImage_URL
Dim Content_On_Top
Dim Content_Is_Best
Dim Content_Locked
Dim Content_Add_Time
Dim Content_Clicks
Dim Content_URL
Dim Content_Deleted
Dim Content_Orders
Dim Content_Version,Content_Language,Content_License,Content_RunOS
Dim Content_Size,Content_DemoURL,Content_RegURL,Content_DownURLs

Call chkPostData()
Call SaveContent()

Dim Settings, dFileName
If Content_Locked=0 Then 
	Set Settings = Lone.GetChannelSetting(Content_Menu_Id)
	If chkIsNull(Settings("Menu_Content_Template"))<>"" Then
		Call Lone.CreateTemplateFile(Settings("Menu_Content_Template"), "content", Content_Id)
		dFileName = Lone.CreateFileName(Settings("Menu_Content_URL"), Content_Id)
		If chkIsNull(dFileName)<>"" Then
			Lone.SavePageContent dFileName, ""
			Lone.Execute("Update LCMS_Content"&chkIsNull(Settings("Menu_Data_Table"))&" Set Content_URL='" & dFileName & "' Where Content_Id=" & Content_Id)
		End If
		Lone.DeleteTemplateFile
	End If
End If
%>
<script language="javascript">
	window.onload = function () {
		window.top.frames["mainFrame"].location.href='LCMS_Content.htm';
	}
</script>
<%
Set Lone = Nothing 


Sub chkPostData()
	If Not Lone.chkPost Then
		sLog = Lone.Admin_Name & "从外部提交数据！"
		Lone.AddToLog(sLog)
		MsgBox "非法操作：请不要从外部提交数据！", "back", ""
	End If

	Content_Menu_Id		= RequestForm("Menu_Id")
	Content_Title		= RequestForm("Title")
	Content_Title_Color = RequestForm("d_bgcolor")
	Content_User_Id		= 0
	Content_Keyword		= RequestForm("Keyword")
	Content_Description = Request.Form("Description")
	Content_Author		= RequestForm("Author")
	Content_Editor		= Lone.Admin_Name
	Content_Copy_From	= RequestForm("CopyFrom")
	Content_Price 		= RequestForm("Price")
	Content_Content		= Request.Form("content")
	Content_Image_URL	= RequestForm("Image_URL")
	Content_sImage_URL	= RequestForm("sImage_URL")
	Content_Version		= RequestForm("Version")
	Content_Language	= RequestForm("Language")
	Content_License		= RequestForm("License")
	Content_RunOS		= RequestForm("RunOS")
	Content_Size		= RequestForm("Size")
	Content_DemoURL		= RequestForm("DemoURL")
	Content_RegURL		= RequestForm("RegURL")
	For I=1 To Request.Form("DownURLs").Count
		If Trim(Request.Form("DownURLs")(I))<>"" Then
			If Content_DownURLs<>"" Then Content_DownURLs = Content_DownURLs & "||"
			Content_DownURLs = Content_DownURLs & Request.Form("DownURLs")(I)
		End If
	Next

	If RequestForm("Has_Image")="1" Then
		Content_Has_Image	= 1
	Else
		Content_Has_Image	= 0
	End If 
	If RequestForm("On_Top")="1" Then
		Content_On_Top	= 1
	Else
		Content_On_Top	= 0
	End If
	If RequestForm("isBest")="1" Then
		Content_Is_Best	= 1
	Else
		Content_Is_Best	= 0
	End If
	If RequestForm("Locked")="1" Then
		Content_Locked	= 1
	Else
		Content_Locked	= 0
	End If
	Content_Add_Time	= Now()
	Content_Clicks		= 0
	Content_URL			= ""
	Content_Deleted		= 0
	Content_Orders		= 0
	if not isinteger(Content_Price) then Content_Price=0

	If Not IsInteger(Content_Menu_Id) Then
		MsgBox "请选择发布的栏目！", "back", ""
	End If 
	If Content_Title="" Then
		MsgBox "标题不能为空！", "back", ""
	End If 

End Sub

Sub SaveContent()
	Dim Rs, SQL
	set rs=server.CreateObject("adodb.recordset")
	Menu_Data_Table = Lone.Execute("Select Menu_Data_Table From LCMS_Menu Where Menu_Id=" & Content_Menu_Id)(0)
	sql="select * from LCMS_Content"&chkIsNull(Menu_Data_Table)&" Where Content_Id Is Null"
	rs.open sql,conn,1,3
	rs.addnew
	rs("Content_Menu_Id")		= Content_Menu_Id
	rs("Content_User_Id")		= Content_User_Id
	rs("Content_Title")			= Content_Title
	rs("Content_Title_Color")	= Content_Title_Color
	rs("Content_Author")		= Content_Author
	rs("Content_Editor")		= Content_Editor
	rs("Content_Keyword")		= Content_Keyword
	rs("Content_Description")	= Content_Description
	rs("Content_Copy_From")		= Content_Copy_From
	rs("Content_Price")			= Content_Price
	rs("Content_Content")		= Content_Content
	rs("Content_Add_Time")		= Content_Add_Time
	rs("Content_Locked")		= Content_Locked
	rs("Content_Is_Best")		= Content_Is_Best
	rs("Content_On_Top")		= Content_On_Top
	rs("Content_Has_Image")		= Content_Has_Image
	rs("Content_Clicks")		= Content_Clicks
	rs("Content_Image_URL")		= Content_Image_URL
	rs("Content_sImage_URL")	= Content_sImage_URL

	rs("Content_Version")		= Content_Version
	rs("Content_Language")		= Content_Language
	rs("Content_License")		= Content_License
	rs("Content_RunOS")			= Content_RunOS
	rs("Content_Size")			= Content_Size
	rs("Content_DemoURL")		= Content_DemoURL
	rs("Content_RegURL")		= Content_RegURL
	rs("Content_DownURLs")		= Content_DownURLs

	rs("Content_URL")		= Content_URL
	rs("Content_Orders")		= Content_Orders
	rs.update
	rs.close
	set rs=Nothing
	
	Lone.Execute("Update LCMS_Content"&chkIsNull(Menu_Data_Table)&" Set Content_Orders = Content_Orders + 1")
	Content_Id = Lone.Execute("Select Max(Content_Id) From LCMS_Content"&chkIsNull(Menu_Data_Table)&"")(0)
	sLog = Lone.Admin_Name & "新建发布:" & Content_Title
	Lone.AddToLog(sLog)
End Sub 
%>