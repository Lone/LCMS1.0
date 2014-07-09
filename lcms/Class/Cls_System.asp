<%
Class Cls_Lone
	public UserTrueIP,WebSite_sn,FileName
	public CacheName,Cache_Data
	Public Admin_Id,Admin_name,Admin_Level,Admin_Options
	Public User_Id,User_Name,User_Level,User_Options
	private Reloadtime,LocalCacheName
	Private s_MainTemplate
	Public s_TemplateFileName

	Private Sub Class_Initialize()
		CacheName="LoneCMS2.0"
		Reloadtime=14400		
		WebSite_sn = LCase(Request.ServerVariables("HTTP_HOST"))
		FileName = LCase(Request.ServerVariables("SCRIPT_NAME"))
		UserTrueIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		Admin_Id = Request.Cookies(CacheName)("Admin_Id")		
		Admin_Name = Request.Cookies(CacheName)("Admin_Name")
		Admin_Level= Request.Cookies(CacheName)("Admin_Level")
		Admin_Options = Request.Cookies(CacheName)("Admin_Options")
		If UserTrueIP = "" Then UserTrueIP = Request.ServerVariables("REMOTE_ADDR")
		UserTrueIP = CheckStr(UserTrueIP)
		s_MainTemplate = "../Public/Temp_Main.asp"
		s_TemplateFileName = SystemDirectory & "/Public/lone_template_"&Replace(Replace(WebSite_sn,".","_"),":","_")&".asp"
	end sub

	Private Sub class_terminate()
		If TypeName(Conn)="Connection" Then Conn.Close : Set Conn = Nothing	
	End Sub
	
	Public Property Let Name(ByVal vNewValue)
		LocalCacheName = LCase(vNewValue)
		Cache_Data=Application(CacheName & "_" & LocalCacheName)
	End Property
	
	Public Property Let Value(ByVal vNewValue)
		If LocalCacheName<>"" Then 
			ReDim Cache_Data(2)
			Cache_Data(0)=vNewValue
			Cache_Data(1)=Now()
			Application.Lock
			Application(CacheName & "_" & LocalCacheName) = Cache_Data
			Application.unLock
		Else
			Err.Raise vbObjectError + 1, "loneCacheServer", " please change the CacheName."
		End If
	End Property
	
	Public Property Get Value()
		If LocalCacheName<>"" Then 
			If IsArray(Cache_Data) Then
				Value=Cache_Data(0)
			Else
				Err.Raise vbObjectError + 1, "loneCacheServer", " The Cache_Data("&LocalCacheName&") Is Empty."
			End If
		Else
			Err.Raise vbObjectError + 1, "loneCacheServer", " please change the CacheName."
		End If
	End Property
	
	Public Sub AddToLog(strLog)
		Execute "Insert Into LCMS_Log (Log_Date, Log_IP, Log_Content) Values ("&NOW_STRING&",'" & UserTrueIP & "','" & strLog & "')"
	End Sub

	Public Sub DelCache(MyCaheName)
		MyCaheName = Lcase(MyCaheName)
		Application.Lock
		Application.Contents.Remove(CacheName & "_" & MyCaheName)
		Application.unLock
	End Sub	
	
	Public Function ObjIsEmpty()
		ObjIsEmpty=True	
		Cache_Data=Application(CacheName & "_" & LocalCacheName)
		If Not IsArray(Cache_Data) Then Exit Function
		If Not IsDate(Cache_Data(1)) Then Exit Function
		If DateDiff("s",CDate(Cache_Data(1)),Now()) < (60*Reloadtime) Then ObjIsEmpty=False		
	End Function

	Public Function Execute(Command)
	   If Not IsObject(Conn) Then Call CreateConnection(Conn)
	    If IsDeBug = 0 Then 
		    On Error Resume Next
		    Set Execute = Conn.Execute(Command)
		    If Err Then
			    err.Clear
			    Set Conn = Nothing
			    Response.Write "数据库连接出错，请检查连接字串。"&Command
			    Response.End()
		    End If
		Else
			On Error Resume Next
			Set Execute = Conn.Execute(Command)
			If Err Then
				Response.Write command & "<br>"
				Response.Write "错误信息："& Err.Description &"<BR>"
    		    Response.Write "出错文件："& Err.Source &"<BR>"
    		    Response.Write "出错行："&  Err.Line &"<BR>"
				err.Clear
			End If
		End if
	End Function

	Rem 判断发言是否来自外部
	Public Function ChkPost()
		Dim server_v1,server_v2
		Chkpost=False 
		server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
		server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
		If Mid(server_v1,8,len(server_v2))=server_v2 Then Chkpost=True 
	End Function

	Public Function iHTMLEncode(fString)
		If Not IsNull(fString) Then
			fString = replace(fString, ">", "&gt;")
			fString = replace(fString, "<", "&lt;")
			fString = Replace(fString, CHR(32), " ")
			fString = Replace(fString, CHR(9), " ")
			fString = Replace(fString, CHR(34), "&quot;")
			fString = Replace(fString, CHR(39), "&#39;")
			fString = Replace(fString, CHR(13), "")
			fString = Replace(fString, CHR(10) & CHR(10), "</P><P> ")
			fString = Replace(fString, CHR(10), "<BR> ")
			iHTMLEncode = fString
		End If
	End Function
	

	Public Function chkAdmin(AdminIndex)
		If Admin_Id="" Then
			MsgBox "您还没有登录，请登录以后再操作。","gourl","default.asp"
		End If
		If Trim(Session(CacheName & "_AdminLogin"))="" Then
			MsgBox "登录超时，请重新登录。","gourl","default.asp"
		End If
		'If AdminIndex<>"" Then
		'AdminIndex = ", " & AdminIndex & ","
		'If Instr(Admin_Options,AdminIndex)=0 Then
		'	MsgBox "您没有对这个项的管理权限。","back","Admin_Login.asp"
		'End If
		'End If
	End Function
	
	Public Function TestAdmin(AdminIndex)
		Dim tempItems
		TestAdmin = True
		If Trim(AdminIndex)="" Then
			Exit Function
		End If
		tempItems = Split(AdminIndex,",")
		For I=0 To Ubound(tempItems)
			If Instr(Admin_Options,", "&tempItems(I)&",") Then
				Exit Function
			End If
		Next
		TestAdmin = False
	End Function
	
	Public Sub ShowErr()
	  response.Redirect("ShowErr.asp?action=AdminErr&ErrMsg="&Server.URLEncode(ErrMsg)&"")
		response.end()
	End sub
	
	Public Sub ShowSuc()
	  response.Redirect("ShowErr.asp?action=AdminSuc&info="&Server.URLEncode(info)&"")
		response.end()
	End sub
	
	Public Function XMLEncode(str)
		str = Replace(str,"&amp;","&")
		str = Replace(str,"&#39;","")
		str = Replace(str,"&#34;","")
		str = Replace(str,"&nbsp;","")
		str = Replace(str,"&","")
		XMLEncode = str
	End Function

	Public Function LoadFile(sFilePath, Flag)
		Dim MapPath, FS, F, temp
		MapPath = Server.MapPath(sFilePath)
		Set FS = Server.CreateObject(Lone_FSO)
		If FS.FileExists(MapPath) Then
			Set F = FS.OpenTextFile(MapPath, 1, True)
			temp = F.ReadAll()
			If Flag Then
				If Not LONE_STATIC_HTML Then
					temp = Replace(temp, "<!--#include ", "<!--# include ")
					temp = Replace(temp, "<!-- #include ", "<!--# include ")
					temp = Replace(temp, "<"&"%", "<!--$%")
					temp = Replace(temp, "%"&">", "%$-->")
				Else
					temp = Replace(temp, "<"&"%", "<!--")
					temp = Replace(temp, "%"&">", "-->")
				End If 
				temp = Replace(temp, "<!--%", "<"&"%")
				temp = Replace(temp, "%-->", "%"&">")
			End If
			LoadFile = temp
			temp = Empty 
		End If
		Set F = Nothing
		Set FS = Nothing
	End Function

	Public Sub SaveToFile(ByVal strBody, ByVal File)
		Dim objStream
		On Error Resume Next
		Set objStream = Server.CreateObject(LONE_STREAM)

		With objStream
			.Type = 2
			.Open
			.Charset = "GB2312"
			.Position = objStream.Size
			.WriteText = strBody
			.SaveToFile Server.MapPath(File), 2
			.Cancel()
			.Close()
		End With
		Set objStream = Nothing

	End Sub

	Public Sub CreateTemplateFile(ByVal template, tType, intId)
		Dim Content, tempValue
		Content = LoadFile(s_MainTemplate, False)

		If tType="list" Then
			Parames = "LCMS.ChannelId = " & intId & "" & vbNewLine
			Parames = Parames & "LCMS.GetList()"
		ElseIf tType="banch" Then
			Parames = "LCMS.ChannelId=" & Content_Menu_Id & vbNewLine
			Parames = Parames & "LCMS.GetContent(Trim(Request(""Id"")))"
		ElseIf tType="link" Then
			Parames = "LCMS.ChannelId = " & intId
		ElseIf tType="userlist" Then
			Parames = "LCMS." & getMemberListFlag & " = """ & intId & """"	
		ElseIf tType="search" Then
			Parames = "LCMS.Filter = """ & intId & """" & vbNewLine
			Parames = Parames & "Set LCMS.Channel = Server.CreateObject(LONE_DICTIONARY)" & vbNewLine
			Parames = Parames & "LCMS.Channel.Add ""List_URL"", DEFAULT_FILENAME " & vbNewLine
			Parames = Parames & "LCMS.Channel.Add ""List_Count"", " & SEARCH_MAXPERPAGE & vbNewLine
			Parames = Parames & "LCMS.Channel.Add ""Data_Table"", """ & sTableName & """" & vbNewLine
			Parames = Parames & "LCMS.GetList()" & vbNewLine
			Parames = Parames & "LCMS.Filter = """ & Key & """"
		Else
			Parames = "LCMS.ChannelId=" & Content_Menu_Id & vbNewLine
			Parames = Parames & "LCMS.GetContent(" & intId & ")"
		End If 
		Content = Replace(Content, "'Parames", Parames)
		tempValue = Split(Content, "<!--Lone_CMS_Template_Content-->")
		Content = tempValue(0)
		Content = Content & LoadFile(template, True)
		Content = Content & tempValue(1)

		'response.write(Content)
		SaveToFile Content, s_TemplateFileName
	End Sub

	Public Function SavePageContent(ByVal s_LocalFileName, Parame)
		On Error Resume Next
		Dim f_HTTP_Obj, PageContent, Ads, Content_FileName
		Set f_HTTP_Obj = Server.CreateObject(LONE_XMLHTTP)
		Content_FileName = s_TemplateFileName & Parame
		Randomize
		Content_FileName = JoinChar(Content_FileName) & CStr(Rnd())

		With f_HTTP_Obj 
			.Open "Get", "http://" & WebSite_sn & Content_FileName, False, "", ""
			.Send
		End With

		if f_HTTP_Obj.ReadyState <> 4 then
			Set f_HTTP_Obj = Nothing
			Exit Function
		end If
		If Right(s_LocalFileName, 1)="/" Then s_LocalFileName = s_LocalFileName & DEFAULT_FILENAME
		AutoCreateDirectory(s_LocalFileName)
		PageContent = f_HTTP_Obj.ResponseBody
		Set f_HTTP_Obj = Nothing

		If Not LONE_STATIC_HTML Then
			PageContent = Binary2String(PageContent, "gb2312")
			PageContent = Replace(PageContent, "<!--$%", "<"&"%")
			PageContent = Replace(PageContent, "%$-->", "%"&">")
			PageContent = Replace(PageContent, "<!--# include ", "<!--#include ")
			SaveToFile PageContent, s_LocalFileName
		Else
			Set Ads = Server.CreateObject(LONE_STREAM)
			With Ads
				.Type = 1
				.Open
				.Write PageContent
				.SaveToFile Server.MapPath(s_LocalFileName), 2
				.Cancel()
				.Close()
			End With
			Set Ads = Nothing
		End If 
		If Err Then Err.Clear
	End Function

	Public Function CreateFileName(str, initNum)
		Dim temp, d, dt, tm
		temp = str
		CreateFileName = ""
		If temp="" Then Exit Function
		d = Now()
		dt = Year(d)&Month(d)&Day(d)
		tm = Hour(d)&Minute(d)&Second(d)
		temp = Replace(temp, "{$id}", initNum)
		temp = Replace(temp, "{$date}", dt)
		temp = Replace(temp, "{$time}", tm)
		temp = Replace(temp, "{$datetime}", dt & tm)
		temp = Replace(temp, "{$md5}", Md5(CacheName&initNum))
		temp = Replace(temp, "{$title}", GetPinYin(initNum))
		
		CreateFileName = temp
	End Function

	Public Function DeleteTemplateFile()
		Dim FS, MapPath
		MapPath = Server.MapPath(s_TemplateFileName)
		Set FS = Server.CreateObject(Lone_FSO)
		If FS.FileExists(MapPath) Then
			Fs.DeleteFile(MapPath)
		End If
		Set FS = Nothing	
	End Function

	Public Function AutoCreateDirectory(strdir)
		Dim FS, MapPath, Dir, I
		MapPath = Server.MapPath("/")
		Set FS = Server.CreateObject(Lone_FSO)
		Dir = Split(strdir, "/")
		For I=1 To UBound(Dir)-1
			MapPath = MapPath & "\" & Dir(I)
			'response.write MapPath
			If Not FS.FolderExists(MapPath) Then
				Fs.CreateFolder(MapPath)
			End If
		Next
		Set FS = Nothing			
	End Function

	Public Function GetChannelSetting(ByVal Var_Menu_Id)
		Dim Rs, Dict
		Set Rs = Execute("Select * From LCMS_Menu Where Menu_Id=" & Var_Menu_Id)
		Set Dict = Server.CreateObject(LONE_DICTIONARY)
		For Each Field In Rs.Fields
			Dict.Add Field.Name, Field.Value
		Next
		Set GetChannelSetting = Dict
		Rs.Close
		Set Rs = Nothing
	End Function

	Public Function IP_Check()
		Dim Rs
		Set Rs = Execute("Select count(*) From LCMS_IP_Black Where IP='" & UserTrueIP & "'")
		If Rs(0)=0 Then
			IP_Check = True
		Else
			IP_Check = False
		End If
		Rs.Close
		Set Rs = Nothing
	End Function
End Class
%>