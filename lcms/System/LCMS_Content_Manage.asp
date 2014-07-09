<!--#include file="../inc/common.asp"-->
<%
Dim Flag, Content_Id, Menu_Id
Dim Menu_Data_Table

Content_Id = Trim(Request.Querystring("id"))
Flag = Trim(Request.Querystring("flag"))
Menu_Id = Trim(Request.Querystring("menu_id"))


If Not IsInteger(Content_Id) Then
	MsgBox "请指定要进行操作的记录。", "back", ""
End If
If Flag="" Then
	MsgBox "请指定要进行操作的选项。", "back", ""
End If

If isInteger(Menu_Id) Then
	Menu_Data_Table = Lone.Execute("Select Menu_Data_Table From LCMS_Menu Where Menu_Id=" & Menu_Id)(0)
End If
Menu_Data_Table = ChkIsNull(Menu_Data_Table)

Select Case LCase(Flag)
Case "uporders" : UpOrders
Case "downorders" : downOrders
Case "ontop" : onTop
Case "untop" : unTop
Case "delete" : Delete
End Select

Response.Redirect("LCMS_Content.asp?Menu_Id=" & Menu_Id)
Set Lone = Nothing 

Sub UpOrders()
Dim Rs, Rs1

Set Rs = Server.CreateObject("ADODB.Recordset")
Set Rs1 = Server.CreateObject("ADODB.Recordset")

Rs.Open "Select * From LCMS_Content"&Menu_Data_Table&" Where Content_Id=" & Content_Id, Conn, 1, 3
OrderNum = Rs("Content_Orders")
Menu_Id = Rs("Content_Menu_Id")
If Rs("Content_On_Top") Then 
OnTOP = 1
Else
OnTOP = 0
End If 
SQL = "Select Top 1 Content_Id, Content_Orders From LCMS_Content"&Menu_Data_Table&" Where Content_Menu_Id=" & Menu_Id & " And Content_Orders<" & OrderNum & " And Content_On_Top=" & OnTOP & " Order By Content_Orders Desc"
'Response.Write SQL
Rs1.Open SQL, Conn, 1, 1
If Rs1.EOF Then
	Exit Sub
End if
Rs("Content_Orders") = Rs1("Content_Orders")
Content_Id1 = Rs1("Content_Id")
Rs1.Close

Lone.Execute("Update LCMS_Content"&Menu_Data_Table&" Set Content_Orders=" & OrderNum & " Where Content_Id=" & Content_Id1)

Rs.Update
Rs.Close
Set Rs = Nothing
End Sub 

Sub DownOrders()
Dim Rs, Rs1

Set Rs = Server.CreateObject("ADODB.Recordset")
Set Rs1 = Server.CreateObject("ADODB.Recordset")

Rs.Open "Select * From LCMS_Content"&Menu_Data_Table&" Where Content_Id=" & Content_Id, Conn, 1, 3
OrderNum = Rs("Content_Orders")
Menu_Id = Rs("Content_Menu_Id")
If Rs("Content_On_Top") Then 
OnTOP = 1
Else
OnTOP = 0
End If 

sql = "Select Top 1 Content_Id, Content_Orders From LCMS_Content"&Menu_Data_Table&" Where Content_Menu_Id=" & Menu_Id & " And Content_Orders>" & OrderNum & " And Content_On_Top=" & OnTOP & " Order By Content_Orders"

Rs1.Open sql, Conn, 1, 1
If Rs1.EOF Then
	Exit Sub
End if

Rs("Content_Orders") = Rs1("Content_Orders")
Content_Id1 = Rs1("Content_Id")
Rs1.Close

Lone.Execute("Update LCMS_Content"&Menu_Data_Table&" Set Content_Orders=" & OrderNum & " Where Content_Id=" & Content_Id1)

Rs.Update
Rs.Close
Set Rs = Nothing
End Sub 

Sub Delete()
	Dim Rs, Fs, MapPath

	Set Rs = Server.CreateObject("ADODB.Recordset")

	Rs.Open "Select * From LCMS_Content"&Menu_Data_Table&" Where Content_Id=" & Content_Id, Conn, 1, 3
	FileURL = Rs("Content_URL")
	Menu_Id = Rs("Content_Menu_Id")
	If Right(FileURL, 1)="/" Then FileURL = FileURL & DEFAULT_FILENAME
	If chkIsNull(FileURL)<>"" Then
		MapPath = Server.MapPath(FileURL)
		Set FS = Server.CreateObject(Lone_FSO)
		If FS.FileExists(MapPath) Then
			FS.DeleteFile MapPath, True 
			DeleteBlankFolder Left(FileURL, InstrRev(FileURL, "/"))
		End If
		Set FS = Nothing
	End If 
	Rs.Delete
	Rs.Close
	Set Rs = Nothing
End Sub 


%>