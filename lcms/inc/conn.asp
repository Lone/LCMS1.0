<!--#include virtual="/config.asp"-->
<!--#include file="ver.asp"-->
<%
Dim Conn, oConn
Dim NOW_STRING, SQL_True, SQL_False

If DatabaseType=1 Then
	NOW_STRING = "getdate()"
	SQL_True = "1"
	SQL_False = "0"
Else
	NOW_STRING = "now()"
	SQL_True = "1"
	SQL_False = "0"
End If

Function CreateConnection(X)
On Error Resume Next
Set X = Server.CreateObject("ADODB.Connection")
If DatabaseType=1 Then
	X.open "Provider = Sqloledb;" & ConnectionString
Else
	X.open "provider=microsoft.jet.oledb.4.0;data source=" & Server.MapPath(ConnectionString)
End If 
If Err Then
	Set X = Nothing
	Response.Write "数据库连接出错，请检查连接字串。" & Err.Description
	err.Clear
	Response.End
End If
End Function

Sub CloseData()
On Error Resume Next
conn.close
set conn = nothing
End Sub
%>