<!--#include file="../inc/common.asp"-->
<%
Dim Content_Id
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

Content_Id = Trim(Request.Querystring("id"))


If Not IsInteger(Content_Id) Then
	MsgBox "请指定要进行操作的记录。", "back", ""
End If

Dim Menu_Id, Menu_Type
Menu_Id = trim(Request.QueryString("Menu_Id"))
if not isInteger(Menu_Id) then Menu_Id=0 Else Menu_Id=Cint(Menu_Id)
Set Rs = Lone.Execute("Select Menu_Data_Table, Menu_Type  From LCMS_Menu Where Menu_Id=" & Menu_Id)
If Rs.EOF Then
	MsgBox "栏目不存在，可能已经删除。", "back", ""
End If 
Menu_Data_Table = ChkIsNull(Rs(0))
Menu_Type = CInt(Rs(1))
Rs.Close
Set Rs = Nothing


Set Rs = Lone.Execute("Select * From LCMS_Content"&Menu_Data_Table&" Where Content_Id=" & Content_Id)
If Rs.EOF Then
	MsgBox "要操作的记录不存在。", "back", ""
End If 
Content_Title = Rs("Content_Title")
Content_Title_Color = Rs("Content_Title_Color")
Content_User_Id = Rs("Content_User_Id")
Content_Keyword = Rs("Content_Keyword")
Content_Description = Rs("Content_Description")
Content_Author = Rs("Content_Author")
Content_Editor = Rs("Content_Editor")
Content_Copy_From = Rs("Content_Copy_From")
Content_Price = Rs("Content_Price")
Content_Content = Rs("Content_Content")
Content_Has_Image = Rs("Content_Has_Image")
Content_Image_URL = Rs("Content_Image_URL")
Content_sImage_URL = Rs("Content_sImage_URL")
Content_Version = Rs("Content_Version")
Content_Language = Rs("Content_Language")
Content_License = Rs("Content_License")
Content_RunOS = Rs("Content_RunOS")
Content_Size = Rs("Content_Size")
Content_DemoURL = Rs("Content_DemoURL")
Content_RegURL = Rs("Content_RegURL")
Content_DownURLs = Rs("Content_DownURLs")

Content_On_Top = Rs("Content_On_Top")
Content_Is_Best = Rs("Content_Is_Best")
Content_Locked = Rs("Content_Locked")
Content_Add_Time = Rs("Content_Add_Time")
Content_Clicks = Rs("Content_Clicks")
Content_URL = Rs("Content_URL")
Content_Deleted = Rs("Content_Deleted")
Content_Orders = Rs("Content_Orders")

Rs.Close
Set Rs = Nothing

%>
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<script language="JavaScript" src="../public/js/admin.js"></script>

<script language="JavaScript">
<!--
function CheckForm()
{
	if(form1.classid.options.length==0)
	{
		alert("没有可发布的类别.");
		return false;
	}else{
		if(form1.classid.value==""){
			alert("该类别不可发布.");
			form1.classid.focus();
			return false;	
		}
	}
	if(form1.title.value==""){
		alert("文章标题不能为空");
		form1.title.focus();
		return false;
	}
	return true;
}
function ShowDialog(url, objSetValue, vWidth, vHeight) {
	if(!objSetValue)return false;
	var arr = showModalDialog(url, window, "dialogWidth:" + vWidth + "px;dialogHeight:" + vHeight + "px;help:yes;scroll:no;status:no");
	if(arr && arr!="" && arr!="undefined")
	objSetValue.value = arr;
}

function SelectColor(what){
	var dEL = document.all("d_"+what);
	var sEL = document.all("s_"+what);
	var url = "../Editor/Dialog/selcolor.htm?color="+encodeURIComponent(dEL.value);
	var arr = showModalDialog(url,window,"dialogWidth:280px;dialogHeight:250px;help:no;scroll:no;status:no");
	if (arr) {
		dEL.value=arr;
		sEL.style.backgroundColor=arr;
	}
}
function CreateSmallImage(){
	var sImgObj = $('sImage_URL');
	var ImgObj = $('Image_URL');

	if (ImgObj.value=="")
	{
		alert("请先上传大图片！");
		return false;
	}
	var url = "sImg.asp?BI=" + escape(ImgObj.value);
	sImgObj.value = '正在生成缩略图，请稍候...';
	var _size = window.prompt("请输入要生成的图片尺寸","<%= PREVIEWIMAGE_WIDTH & "*" & PREVIEWIMAGE_HEIGHT %>");

	url += "&size=" + escape(_size);
	var http = CreateAjax();
	if (!http) {
		sImgObj.value = '读取数据失败。';
		return false;
	}
	
	http.onreadystatechange = function(){
	if (http.readyState == 4)
	{
		var str = http.responseText.split(':');
		if (str.length==2)
		{
			if (str[0]!="OK")
			{
				alert(str[1]);
				sImgObj.value = "";
			}else{
				sImgObj.value = str[1]
			}
		}else{
			alert("读取数据失败。");
			sImgObj.value = "";
		}
		http = null;
	}	

	}
	http.open("GET", url, true);
	http.send(null);
}

//-->
</script>

</head>

<body class="borderon">
<br />
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
  <form method="post" action="LCMS_ContentEdit_Save.asp" name="form1">
  <input type="hidden" name="Menu_Data_Table" value="<%=Menu_Data_Table%>" />
    <tr class="tdbg">
    	<td>标题名称：</td>
      <td colspan="2">
      <input name="title" type="text" id="title" size="60" value="<%= Content_Title %>" /> 
	  <img border=0 src="../Editor/sysImage/rect.gif" width=18 style="cursor:hand;background-color:<%= Content_Title_Color %>" id="s_bgcolor" onClick="SelectColor('bgcolor')" align="absmiddle" alt="选择标题颜色" />
	  <input type="hidden" name="d_bgcolor" value="<%= Content_Title_Color %>" />
		</td>
    </tr>	
    	
    <tr class="tdbg">
    	<td>
    		关键字：
      </td>
      <td colspan="2"><input name="KeyWord" type="text" size="40" id="KeyWord" value="<%= Content_KeyWord %>" />
    </td>
    </tr>
    <tr class="tdbg">
    	<td>
    		描述(200字内)：
      </td>
      <td colspan="2"><textarea name="Description" cols="50" rows="2" id="Description"><%= Content_Description %></textarea>
	  <input type="button" value="HTML" onclick="window.open('../editor/popup.asp?form=form1&field=Description&style=standard','html', 'width=550,height=350');">
    </td>
    </tr>
	
   <tr class="tdbg"> 
      <td nowrap>作者：</td>
      <td colspan="2">
	  <input name="Author" type="text" id="Author" value="<%= Content_Author %>" size="20">
 	  </td>
    </tr>
   <% 
  if Menu_Type=0 then
   %>    	
    <tr class="tdbg">
    	<td>来 源：</td>
      <td colspan="2"> <input type="text" name="CopyFrom" value="<%= Content_Copy_From %>" size="20" />
    </td>
    </tr>
  <% 
  elseif Menu_Type=5 then
   %>  
    <tr class="tdbg">
    	<td>开发商主页：</td>
      <td colspan="2"> <input type="text" name="CopyFrom" value="<%= Content_Copy_From %>" size="40" />
    </td>
    </tr>
       <% end if
	 if Menu_Type=2 or Menu_Type=3 then %>  
       <tr class="tdbg">
    	<td>价 格：</td>
      <td colspan="2"> <input type="text" name="Price" value="<%= Content_Price %>" size="20" />
    </td>
    </tr>     
 <% end if %>  
    <% 
  if Menu_Type=5 then
   %> 
      <tr class="tdbg">
      <td>
      	屏幕截图：</td>
      <td colspan="2">
      	  <input name="Image_URL" id="Image_URL" type="text" size="40" value="<%= Content_Image_URL %>" onclick="viewImage(this.value, 0);" />
          <input type="button" onClick="ShowDialog('upimage.htm',Image_URL,350,170);" value="上传" />
                </td>
    </tr>  
 <% else%>
    <tr class="tdbg">
      <td>
      	图片：</td>
      <td colspan="2">
      	  <input name="Image_URL" id="Image_URL" type="text" size="40" value="<%= Content_Image_URL %>" onclick="viewImage(this.value, 0);" />
          <input type="button" onClick="ShowDialog('upimage.htm',Image_URL,350,170);" value="上传" />
                </td>
    </tr>   
 <% end if %>
<%
 if Menu_Type=4 then
%>	

    <tr class="tdbg">
      <td>
      	音频/视频：</td>
      <td colspan="2">
      	  <input name="sImage_URL" id="sImage_URL" type="text" size="40" value="<%= Content_sImage_URL %>" />
		  <input type="button" onClick="ShowDialog('upmusic.htm',sImage_URL,350,170);" value="上传" />
		  <input type="button" onClick="ShowDialog('dialog.htm?SelectFile:1',sImage_URL,350,170);" value="选择" />
                </td>
    </tr> 
 <% else%>	
    <tr class="tdbg">
      <td>
      	缩略图：</td>
      <td colspan="2">
      	  <input name="sImage_URL" id="sImage_URL" type="text" size="40" value="<%= Content_sImage_URL %>" onclick="viewImage(this.value, 1);" />
          <input type="button" onClick="CreateSmallImage();" value="自动生成" />
		  <input type="button" onClick="ShowDialog('upimage.htm',sImage_URL,350,170);" value="上传" />
                </td>
    </tr> 
 <% end if %>
 <% If Menu_Type=5 Then
 '软件下载
 %>
    <tr class="tdbg">
      <td>
      	软件版本：</td>
      <td colspan="2">
      	  <input name="Version" id="Version" type="text" size="40" value="<%= Content_Version %>" />
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	软件语言：</td>
      <td colspan="2">
      	  <input name="Language" id="Language" type="text" size="40" value="<%= Content_Language %>" />
		  <select name="select1" id="select1" onchange="setValues('Language',this.value, true);">
                  <option value="" selected>请选择</option><option value="简体中文">简体中文</option><option value="繁体中文">繁体中文</option><option value="英语">英语</option><option value="多国语言">多国语言</option>
                </select>
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	授权方式：</td>
      <td colspan="2">
      	  <input name="License" id="License" type="text" size="40" value="<%= Content_License %>" />
		  <select name="select1" id="select1" onchange="setValues('License',this.value, true);">
                  <option value="" selected>请选择</option><option value="免费">免费</option><option value="共享">共享</option><option value="试用">试用</option><option value="演示">演示</option><option value="注册">注册</option><option value="破解">破解</option><option value="零售">零售</option>
                </select>
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	运行平台：</td>
      <td colspan="2">
      	  <input name="RunOS" id="RunOS" type="text" size="40" value="<%= Content_RunOS %>" />
		  <select name="select2" id="select2" onchange="setValues('RunOS',this.value, false);">
                  <option value="" selected>请选择</option>
				  <option value="Windows 98">Win9X</option>
				  <option value="Windows XP">WinXP</option>
				  <option value="Windows 2000">Win2000</option>
				  <option value="Windows 2003">Win2003</option>
				  <option value="Windows Vista">Vista</option>
				  <option value="Windows 2008">Win2008</option>
				  <option value="Linux">Linux</option>
				  <option value="DOS">DOS</option>
				  <option value="Mac OS">Mac OS</option>
                </select>
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	文件大小：</td>
      <td colspan="2">
      	  <input name="Size" id="Size" type="text" size="40" value="<%= Content_Size %>" />
                </td>
    </tr>
    <tr class="tdbg">
      <td>
      	演示地址：</td>
      <td colspan="2">
      	  <input name="DemoURL" id="DemoURL" type="text" size="40" value="<%= Content_DemoURL %>" />
                </td>
    </tr>	
    <tr class="tdbg">
      <td>
      	注册地址：</td>
      <td colspan="2">
      	  <input name="RegURL" id="RegURL" type="text" size="40" value="<%= Content_RegURL %>" />
                </td>
    </tr>
    <tr class="tdbg">
      <td valign="top">
      	下载地址：</td>
      <td colspan="2">
<%
	DownURLs = Split(chkIsNull(Content_DownURLs&"||"), "||")
%>			
      	  <input name="DownURLs" id="DownURLs" type="text" size="40" value="<%=DownURLs(0)%>" />
		  <img src="../Editor/ButtonImage/standard/sizeplus.gif" style="cursor:pointer;" onclick="lcms_add_field();" align="absmiddle" alt="添加下载地址" />
<% For I=1 To UBound(DownURLs)-1 %>
		  <br />
		  <input name="DownURLs" id="DownURLs<%=I%>" type="text" size="40" value="<%=DownURLs(I)%>" />
<% Next %>
                </td>
    </tr>

  <% end if %>
    <tr class="tdbg">
    <td>选项：</td>
      <td colspan="2">
	  <input name="On_Top" type="checkbox" id="On_Top" value="1"<% If Content_On_Top Then Response.Write(" checked")%> /><label for="On_Top">置顶</label>
	  <input name="isBest" type="checkbox" id="isBest" value="1"<% If Content_is_Best Then Response.Write(" checked")%> /><label for="isBest">推荐</label>
	  <input name="Has_Image" type="checkbox" id="Has_Image" value="1"<% If Content_Has_Image Then Response.Write(" checked")%> /><label for="Has_Image">图文</label>
	  <input name="Locked" type="checkbox" id="Locked" value="1"<% If Content_Locked Then Response.Write(" checked")%> /><label for="Locked">锁定</label>
	 
	  	
      </td>   
	</tr>	
    <tr class="tdbg">
      <td align="left" valign="top">详细内容：</td>
      <td colspan="2">
	 <div id="preLoadEditor" style="display:;"><img src="../public/images/manage/loading.gif" />正在载入编辑器...</div>
	 <iframe ID="Editor1" src="../Editor/eWebEditor.asp?id=content" frameborder="0" scrolling="no" width="0" HEIGHT="0" onload="preLoadEditor.style.display='none'; this.width='550'; this.height='350'"></iframe>	  </td>
    </tr>
    <script language="javascript">
		document.write('<input name="Content_Id" type="hidden" value="' + window.top.document.content_edit_id + '">');
		document.write('<input name="Menu_Id" id="Menu_Id" type="hidden" value="' + window.top.document.selected_menu_id + '">');
	</script>
	<input name="content" type="hidden" id="content" value="<%= Server.HTMLEncode(Content_Content) %>" />
  </form>
</table>
<script language="javascript">
document.write('<div style="position:absolute; width:10px; height:10px; left:-100px; height:-100px; border: 1px solid #bbbbbb; padding: 2px; background-color: #ffffff;" onclick="hiddeImg();" id="infoRange"></div>');
var o;
var oPopup = window.createPopup();
oPopup.document.body.onclick = function(){oPopup.hide()};

var imgs = new Array(2);
function viewImage(td, imgIndex){
	var imageURL = td;
	if (td=="") return;
	var imgExt = ".jpg|.jpeg|.gif|.bmp|.png|.tif|"
	var ext = imageURL.substr(imageURL.lastIndexOf(".")).toLowerCase();
	if (imgExt.indexOf(ext)==-1) return;
	if (td==o) {hiddeImg(); return; }
	//展示图片

	var div = document.getElementById("infoRange");	
	div.innerHTML = "";
	var img = document.createElement('img');
	div.style.left = event.x;
	div.style.top = event.y+20;

	if (imgs[imgIndex] && imgs[imgIndex].src==imageURL)
	{
		img.src = imgs[imgIndex].src;
		img.width = imgs[imgIndex].width;
		img.height = imgs[imgIndex].height;
		div.appendChild(img);
		oPopup.document.body.style.border = "1px solid #bbbbbb";
		oPopup.document.body.innerHTML = div.innerHTML;
		hiddeImg();
		oPopup.show(event.x, event.y, img.width, img.height, document.body);

		return;
	}

	var tempImg = new Image;
	tempImg.src = imageURL;

	if (tempImg.height>0 && tempImg.width>0)
	{
		w = tempImg.width;
		if (w>300){ w = 300;
		tempImg.height = parseInt(tempImg.height * 300/tempImg.width);
		tempImg.width = w;}
		imgs[imgIndex] = new Image;
		imgs[imgIndex].src = tempImg.src;
		imgs[imgIndex].width = w;
		imgs[imgIndex].height = tempImg.height;
		tempImg = null;	
		img.src = imgs[imgIndex].src;
		img.width = imgs[imgIndex].width;
		img.height = imgs[imgIndex].height;
		div.appendChild(img);
		oPopup.document.body.style.border = "1px solid #bbbbbb";
		oPopup.document.body.innerHTML = div.innerHTML;
		oPopup.show(event.x, event.y+20, img.width, img.height, document.body);
		hiddeImg();
		return;
	}

	img.src = "../public/images/manage/loading.gif";
	div.appendChild(img);
	div.appendChild(document.createTextNode('Loading...'));

	o = td;
	tempImg.onload = function (){
		div.innerHTML = "";
		w = tempImg.width;
		if (w>300){ w = 300;
		tempImg.height = parseInt(tempImg.height * 300/tempImg.width);
		tempImg.width = w;}
		div.appendChild(tempImg);
		oPopup.document.body.style.border = "1px solid #bbbbbb";
		oPopup.document.body.innerHTML = div.innerHTML;

		oPopup.show(div.offsetLeft, div.offsetTop, tempImg.width, tempImg.height, document.body);
		hiddeImg();
		imgs[imgIndex] = new Image;
		imgs[imgIndex].src = tempImg.src;
		imgs[imgIndex].width = w;
		imgs[imgIndex].height = tempImg.height;
		tempImg = null;
	}
	tempImg.onerror = function(){
		div.innerHTML = "<div style='width:200px'>加载图片失败，<br />图片不存在或格式不正确！</div>";	
	};

}


function hiddeImg(){
	var div = document.getElementById("infoRange");
	div.innerHTML = "";
	div.style.left = "-100px";
	div.style.top = "-100px";
	o = null;
}

function setValues(oField, value, replace)
{
	if(value=='')return;
	var oV = $(oField).value;
	if (replace)
	{
		$(oField).value = value;
		return;
	}
	if (('|'+oV+'|').indexOf('|'+value+'|')==-1)
	{
		oV += (oV=='')?'':'|';
		oV += value;
	}
	$(oField).value = oV;
}
function lcms_add_field(){
	var node = $('DownURLs');
	var node1 = node.cloneNode(true);
	node1.value = '';
	node1.setAttribute('id', 'DownURLs'+node.parentNode.childNodes.length)
	node.parentNode.appendChild(document.createElement('<br />'));	
	node.parentNode.appendChild(node1);
}
function $(d){return document.getElementById(d);}
</script>
</body>
</html>