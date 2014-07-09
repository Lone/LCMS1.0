<!--#include file="../inc/conn.asp"-->
<!--#include file="../class/Cls_System.asp"-->
<!--#include file="function.asp"-->

<%
Dim ErrMsg, FindError, Info
Dim Lone, LCMS

Set Lone = new Cls_Lone
Call CreateConnection(Conn) '建立数据库连接。
FindError = False
%>
