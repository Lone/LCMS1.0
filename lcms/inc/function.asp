<%
Function LoseHTML(strHTML)
	On Error Resume Next 
	Dim objRegExp, strOutput
	Set objRegExp = New Regexp
	objRegExp.IgnoreCase = True
	objRegExp.Global = True
	objRegExp.Pattern = "<.+?>"
	strHTML = strHTML & ""
	if strHTML="" Then LoseHTML="":Exit Function
	strOutput = objRegExp.Replace(strHTML, "")
	strOutput = Replace(strOutput, "<", "&lt;")
	strOutput = Replace(strOutput, ">", "&gt;")
	strOutput = Replace(strOutput, "&nbsp;", "")
	LoseHTML = Trim(strOutput)
 Set objRegExp = Nothing
End Function

Public Function Checkstr(Str)
		If Isnull(Str) or str = "" Then
			CheckStr = ""
			Exit Function 
		End If
		Str = Replace(Str,Chr(0),"")
		Str = Replace(Str,Chr(10),"")
		Str = Replace(Str,Chr(13),"")
		CheckStr = Replace(Str,"'","''")
		CheckStr = Replace(Str,"%","")
End Function

Rem 空字段则赋值为零长度字符串
Function ChkIsNull(str)
	If IsNull(str) then
		ChkIsNull = ""
	Else
		ChkIsNull = str
	End If
End Function

Rem *************测字符串长度**************
Function CheckStringLength(txt)
  txt=trim(txt)
  x = len(txt) 
  y = 0 
  for ii = 1 to x 
    if asc(mid(txt,ii,1)) < 0 or asc(mid(txt,ii,1)) >255 then     '如果是汉字 
      y = y + 2 
    else 
      y = y + 1 
    end if 
  next 
  CheckStringLength = y 
End Function 

'***********************************************
'函数名：JoinChar
'作  用：向地址中加入 ? 或 &
'参  数：strUrl  ----网址
'返回值：加了 ? 或 & 的网址
'***********************************************
function JoinChar(strUrl)
	if strUrl="" then
		JoinChar=""
		exit function
	end if
	if InStr(strUrl,"?")<len(strUrl) then 
		if InStr(strUrl,"?")>1 then
			if InStr(strUrl,"&")<len(strUrl) then 
				JoinChar=strUrl & "&"
			else
				JoinChar=strUrl
			end if
		else
			JoinChar=strUrl & "?"
		end if
	else
		JoinChar=strUrl
	end if
end function

'********************************************
'函数名：IsValidEmail
'作  用：检查Email地址合法性
'参  数：email ----要检查的Email地址
'返回值：True  ----Email地址合法
'       False ----Email地址不合法
'********************************************
function IsValidEmail(email)
	dim names, name, i, c
	IsValidEmail = true
	names = Split(email, "@")
	if UBound(names) <> 1 then
	   IsValidEmail = false
	   exit function
	end if
	for each name in names
		if Len(name) <= 0 then
			IsValidEmail = false
    		exit function
		end if
		for i = 1 to Len(name)
		    c = Lcase(Mid(name, i, 1))
			if InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 and not IsNumeric(c) then
		       IsValidEmail = false
		       exit function
		     end if
	   next
	   if Left(name, 1) = "." or Right(name, 1) = "." then
    	  IsValidEmail = false
	      exit function
	   end if
	next
	if InStr(names(1), ".") <= 0 then
		IsValidEmail = false
	   exit function
	end if
	i = Len(names(1)) - InStrRev(names(1), ".")
	if i <> 2 and i <> 3 then
	   IsValidEmail = false
	   exit function
	end if
	if InStr(email, "..") > 0 then
	   IsValidEmail = false
	end if
end function

'***************************************************
'函数名：IsObjInstalled
'作  用：检查组件是否已经安装
'参  数：strClassString ----组件名
'返回值：True  ----已经安装
'       False ----没有安装
'***************************************************
Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

Function getver(Classstr)
	On Error Resume Next
	getver=""
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(Classstr)
	If 0 = Err Then getver=xtesTobj.version
	Set xTestObj = Nothing
	Err = 0
End Function

'*************************************
'反转换HTML代码
'*************************************
Function HTMLDecode(ByVal reString)
	Dim Str:Str=reString
	If Not IsNull(Str) Then
		Str = Replace(Str, "&gt;", ">")
		Str = Replace(Str, "&lt;", "<")
	    Str = Replace(Str, "&nbsp;", CHR(9))
		Str = Replace(Str, "&#160;&#160;&#160;&#160;", CHR(9))
		Str = Replace(Str, "&#39;", CHR(39))
		Str = Replace(Str, "&quot;", CHR(34))
		Str = Replace(Str, "", CHR(13))
		Str = Replace(Str, "</P><P>", CHR(10) & CHR(10))
		Str = Replace(Str, "<BR>", CHR(10))
		HTMLDecode = Str
	End If
End Function

Function HTMLEncode(ByVal fString)
	If Not IsNull(fString) Then
		fString = replace(fString, ">", "&gt;")
		fString = replace(fString, "<", "&lt;")
		fString = Replace(fString, CHR(32), " ")
		fString = Replace(fString, CHR(9), " ")
		fString = Replace(fString, CHR(34), "&quot;")
		fString = Replace(fString, CHR(39), "&#39;")
		fString = Replace(fString, CHR(13), "")
		HTMLEncode = fString
	End If
End Function

Sub MsgBox(str,stype,url)
	response.write "<script language=javascript>"
	If chkisnull(str)<>"" Then
		response.write "alert('"&str&"');"
	End If 
	select case stype
		case "back"
			response.write "history.go(-1);"
		case "gourl"
			response.write "window.location='"&url&"';"
		case "close"
			response.write "window.opener=self;window.close();"
	end select
	response.write "</script>"
	response.end
End Sub

'*************************************
'检测是否只包含英文和数字
'************************************* 
Function IsValidChars(str)
	Dim re,chkstr
	Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True
	re.Pattern="[^_\.a-zA-Z\d]"
	IsValidChars=True
	chkstr=re.Replace(str,"")
	if chkstr<>str then IsValidChars=False
	set re=nothing
End Function

'*************************************
'检测是否包含在允许的字符范围
'************************************* 
Function IsvalidValue(ArrayN,Str)
	IsvalidValue = false
	Dim GName
	For Each GName in ArrayN
		If Str = GName Then
			 IsvalidValue = true
			Exit For
		End If
	Next
End Function 

'*************************************
'检测是否有效的数字
'*************************************
Function IsInteger(Para) 
	IsInteger=False
	If Not (IsNull(Para) Or Trim(Para)="" Or Not IsNumeric(Para)) Then
		IsInteger=True
	End If
End Function

'*************************************
'用户名检测
'*************************************
Function IsValidUserName(byVal UserName)
    on error resume next
	Dim i,c
	Dim VUserName
	IsValidUserName = True
	For i = 1 To Len(UserName)
		c = Lcase(Mid(UserName, i, 1))
		If InStr("$!<>?#^%@~`&*();:+='"" 	", c) > 0 Then
				IsValidUserName = False
				Exit Function
		End IF
	Next
	For Each VUserName in Register_UserName
		If UserName = VUserName Then
			IsValidUserName = False
			Exit For
		End If
	Next
End Function


'*************************************
'计算随机数
'*************************************
function randomStr(intLength)
    dim strSeed,seedLength,pos,str,i
    strSeed = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$&"
    seedLength=len(strSeed)
    str=""
    Randomize
    for i=1 to intLength
     str=str+mid(strSeed,int(seedLength*rnd)+1,1)
    next
    randomStr=str
end function

'***********************************************
'过程名：showpage
'作  用：显示“上一页 下一页”等信息
'参  数：sfilename  ----链接地址
'       totalnumber ----总数量
'       maxperpage  ----每页数量
'       ShowTotal   ----是否显示总数量
'       ShowAllPages ---是否用下拉列表显示所有页面以供跳转。有某些页面不能使用，否则会出现JS错误。
'       strUnit     ----计数单位
'***********************************************
sub showpage(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<form name='showpages' method='Post' action='" & sfilename & "'>"
	if ShowTotal=true then 
		strTemp=strTemp & "共 <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if
	strUrl=JoinChar(sfilename)
  	if CurrentPage<2 then
    		strTemp=strTemp & "首页 上一页&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=1'>首页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage-1) & "'>上一页</a>&nbsp;"
  	end if

  	if n-currentpage<1 then
    		strTemp=strTemp & "下一页 尾页"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage+1) & "'>下一页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & n & "'>尾页</a>"
  	end if
   	strTemp=strTemp & "&nbsp;页次：<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>页 "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "/页"
	if ShowAllPages=True then
		strTemp=strTemp & "&nbsp;转到：<select name='page' size='1' onchange='javascript:submit()'>"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(CurrentPage)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">第" & i & "页</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strTemp=strTemp & "</form>"
	response.write strTemp
end Sub

sub WriteErrMsg()
	Dim arrErr
	If Lang = "en" Then
		arrErr = Array("Error Message","","Back")
	Else 
		arrErr = Array("错误信息","产生错误的可能原因：","返回上一页")
	End If 
	dim strErr
	strErr=strErr & "<p>&nbsp;</p><table cellpadding=2 cellspacing=1 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td height='20' class='title'><strong>" & arrErr(0) & "</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' class='tdbg' valign='top'><b>" & arrErr(1) & "</b><br>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>&lt;&lt; " & arrErr(2) & "</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	response.write strErr
end sub

sub WriteSucMsg(sucMsg)
	dim strSuc
	Dim SucTitle
	If Lang = "en" Then
		SucTitle = "Message"
	Else 
		SucTitle = "成功信息"
	End If 
	strSuc=strSuc & "<p>&nbsp;</p><table cellpadding=2 cellspacing=1 border=0 width=400 class='border' align=center>" & vbcrlf
	strSuc=strSuc & "  <tr align='center'><td height='20' class='title'><strong>" & SucTitle & "</strong></td></tr>" & vbcrlf
	strSuc=strSuc & "  <tr><td height='100' class='tdbg' valign='top'>" & sucMsg &"</td></tr>" & vbcrlf
	strSuc=strSuc & "  <tr align='center'><td class='tdbg' height=25></td></tr>" & vbcrlf
	strSuc=strSuc & "</table>" & vbcrlf
	response.write strSuc
end sub

Function GotTopic(Str,Strlen)
 if Strlen = "" then Strlen = 0
   If Str="" or IsNull(Str) or Cint(Strlen) < 1 Then
     GotTopic = Str
     Exit Function
   End If
   Dim l,t,c, i
   l=Len(Str)
   t=0
   For i=1 To l
     c=Abs(Asc(Mid(Str,i,1)))
     If c>255 Then
	    t=t+2
     Else
	    t=t+1
     End If
     If t>=Strlen Then
	    GotTopic=Left(Str,i)
	    Exit For
    Else
	    GotTopic=Str
    End If
   Next
End Function

Function RequestForm(str)
	Dim Temp
	Temp = Request.Form(str)
	Temp = ChkIsNull(Temp)
	Temp = Lone.iHTMLEncode(Temp)
	RequestForm = Trim(Temp)
End Function 

Rem 检查是否为指定并返回指定的选择状态
Function ReturnSelect(P_Select,P_ReturnValue,P_FormName)
	If Trim(P_Select) = Trim(P_FormName) Then
		ReturnSelect = P_ReturnValue
	End If
End Function

Rem 替换频道项目
Function ReplaceChannelItem(P_ChannelItem,P_ChannelItemName,P_ChannelItemUnit)
	ReplaceChannelItem = Replace(P_ChannelItem,"{$ChannelItemName}",P_ChannelItemName)
	ReplaceChannelItem = Replace(ReplaceChannelItem,"{$ChannelItemUnit}",P_ChannelItemUnit)
End Function


Function Exists(obj)
	If IsObject(obj) Then
		Exists = True
	Else
		Exists = False
	End If 
End Function

' 获取拼音
Function PinYin(ByVal Chinese)
	Chinese = Replace(Chinese,"/","") : Chinese = Replace(Chinese,"\","")
	Chinese = Replace(Chinese,"*","") : Chinese = Replace(Chinese,"]","")
	Chinese = Replace(Chinese,"[","") : Chinese = Replace(Chinese,"}","")
	Chinese = Replace(Chinese,"{","") : Chinese = Replace(Chinese,"'","")
	Dim Pinyinstr,iStr,iIsCn,IsCn
	Dim PinyinConn,i,X
	'On Error Resume Next
	Set PinyinConn = Server.Createobject("Adodb.Connection")
	PinyinConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&server.mappath(SystemDirectory & "/Inc/Pinyin.Asp")
	If Err Then PinYin = "" : Set PinyinConn = Nothing : Exit Function
	IsCN = True
	For i = 1 To Len(Chinese)
		iIsCn = IsCn ' 获取上次是不是中文的值
		iStr = Mid(Chinese,i,1)
		X = Asc(iStr)
		If (X>=65 And X<=90) Or (X>=97 And X<=122) Or (X>=48 And X<=57) Or iStr = " " Then
			IsCn = False ' 这些是英文,数字(保留字符),不改动
			If iStr = " " Then iStr = "-"
		Else
			Set Rs = PinyinConn.Execute("Select Top 1 [Pinyin] From [5U_Pinyin] Where [Content] like '%"&iStr&"%';")
			If Not Rs.eof Then
				iStr = Rs(0) : IsCn = True ' 中文
			Else
				IsCn = False
				If iStr = " " Then iStr = "-" Else iStr = "" ' 将空格转换成-,如果是其他字符则清除
			End If
			Rs.Close : Set Rs = Nothing
		End If
		If iIsCn = IsCn Then Pinyinstr=Pinyinstr & iStr Else Pinyinstr = Pinyinstr & "-" & iStr
		Pinyinstr = Replace(Pinyinstr,"--","-")
		Pinyinstr = Replace(Pinyinstr,"__","_")
	Next
	If Right(Pinyinstr,1) = "-" Then Pinyinstr = Left(Pinyinstr,Len(Pinyinstr)-1)
	If Right(Pinyinstr,1) = "_" Then Pinyinstr = Left(Pinyinstr,Len(Pinyinstr)-1)
	If Left(Pinyinstr,1) = "-" Then Pinyinstr = Right(Pinyinstr,Len(Pinyinstr)-1)
	If Left(Pinyinstr,1) = "_" Then Pinyinstr = Right(Pinyinstr,Len(Pinyinstr)-1)
	PinyinConn.Close
	Set PinyinConn = Nothing
	PinYin = Trim(Pinyinstr)
End Function

Sub DeleteBlankFolder(vPath)
	Dim temp, FS, Fo
	temp = vPath
	If temp="" Or temp="/" Then Exit Sub 
	temp = server.MapPath(temp)
	Set FS = Server.CreateObject(Lone_FSO)
	If FS.FolderExists(temp) Then
		Set Fo = FS.getFolder(temp)
		If Fo.Files.Count=0 And Fo.SubFolders.Count=0 Then
			Fo.Delete 
			temp = Left(temp, InstrRev(temp, "/"))
			DeleteBlankFolder(temp)
		End If 
		Set Fo = Nothing 
	End If
	Set FS = Nothing
End Sub 


Function GetPinyin(Byval Id)
	Dim Title, Menu_Data_Table
	Dim Rs
	If isInteger(Id) Then 
		If isInteger(Content_Menu_Id) Then
			Menu_Data_Table = Lone.Execute("Select Menu_Data_Table From LCMS_Menu Where Menu_Id=" & Content_Menu_Id)(0)
		End If 
		Set Rs = Lone.Execute("Select Content_Title From LCMS_Content"&chkIsNull(Menu_Data_Table)&" Where Content_Id=" & Id)
		If Not Rs.EOF Then Title = Rs(0)
		Rs.Close
		Set Rs = Nothing
	Else
		Title = Trim(Id)
	End If 
	GetPinyin = PinYin(Title)
End Function


Function Binary2String(binstr, charset)
    Const adTypeBinary = 1
    Const adTypeText = 2
    Dim BytesStream,StringReturn
    Set BytesStream = Server.CreateObject("ADODB.Stream")
    With BytesStream
        .Type = adTypeText
        .Open
        .WriteText binstr
        .Position = 0 
        .Charset = charset
        .Position = 2
        StringReturn = .ReadText
        .close
    End With
    Set BytesStream = Nothing
    Binary2String = StringReturn
End Function
%>
