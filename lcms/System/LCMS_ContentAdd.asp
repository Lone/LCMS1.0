<!--#include file="../inc/common.asp"-->
<%
Dim Menu_Type
Menu_Type = trim(Request.QueryString("menutype"))
if not isInteger(Menu_Type) then Menu_Type=0 Else Menu_Type=Cint(Menu_Type)
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
		alert("û�пɷ��������.");
		return false;
	}else{
		if(form1.classid.value==""){
			alert("����𲻿ɷ���.");
			form1.classid.focus();
			return false;	
		}
	}
	if(form1.title.value==""){
		alert("���±��ⲻ��Ϊ��");
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
		alert("�����ϴ���ͼƬ��");
		return false;
	}
	var url = "sImg.asp?BI=" + escape(ImgObj.value);
	sImgObj.value = '������������ͼ�����Ժ�...';
	var _size = window.prompt("������Ҫ���ɵ�ͼƬ�ߴ�","<%= PREVIEWIMAGE_WIDTH & "*" & PREVIEWIMAGE_HEIGHT %>");
	url += "&size=" +  escape(_size);

	var http = CreateAjax();
	if (!http) {
		sImgObj.value = '��ȡ����ʧ�ܡ�';
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
			alert("��ȡ����ʧ�ܡ�");
			sImgObj.value = "";
		}
		http = null;
	}	

	}
	http.open("GET", url, true);
	http.send(null);
}

function ToCopyFrom(addTitle)
{ 
  document.form1.CopyFrom.value=addTitle;
  document.form1.CopyFrom.focus(); 
  return; 
}
function ToAuthorName(addTitle)
{ 
  document.form1.Author.value=addTitle;
  document.form1.Author.focus(); 
  return; 
}
function ToEditor(addTitle)
{ 
  document.form1.Editor.value=addTitle;
  document.form1.Editor.focus(); 
  return; 
}
function ToKeyWords(addTitle)
{ 
  document.form1.KeyWord.value=addTitle;
  document.form1.KeyWord.focus(); 
  return; 
}

//-->
</script>
</head>

<body class="borderon">
<br />
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
  <form method="post" action="LCMS_ContentAdd_Save.asp" name="form1">
    <tr class="tdbg">
    	<td>�������ƣ�</td>
      <td colspan="2">
      <input name="title" type="text" value="" id="title" size="60" /> 
	  <img border=0 src="../Editor/sysImage/rect.gif" width=18 style="cursor:hand;background-color:" id="s_bgcolor" onClick="SelectColor('bgcolor')" align="absmiddle" alt="ѡ�������ɫ" />
	  <input type="hidden" name="d_bgcolor" value="" />
		</td>
    </tr>
    	
    <tr class="tdbg">
    	<td>
    		�ؼ��֣�
      </td>
      <td colspan="2"><input name="KeyWord" type="text" size="40" id="KeyWord" value="" />
    </td>
    </tr>
    <tr class="tdbg">
    	<td>
    		����(200����)��
      </td>
      <td colspan="2"><textarea name="Description" cols="50" rows="2" id="Description" value=""></textarea>
	  <input type="button" value="HTML" onClick="window.open('../editor/popup.asp?form=form1&field=Description&style=standard','html', 'width=550,height=350');">
    </td>
    </tr>
	
   <tr class="tdbg"> 
      <td nowrap>���ߣ�</td>
      <td colspan="2">
	  <input name="Author" type="text" id="Author" value="" size="20" />
	  ��<a href="javascript:ToAuthorName('����')"><font color='green'>����</font></a>�� 
 	  </td>
    </tr>
  <% 
  if Menu_Type=0 then
   %>  	
    <tr class="tdbg">
    	<td>�� Դ��</td>
      <td colspan="2"> <input type="text" name="CopyFrom" value="" size="20" />
      ��<a href="javascript:ToCopyFrom('��վԭ��')"><font color='green'>��վԭ��</font></a>����<a href="javascript:ToCopyFrom('ת��')"><font color='green'>ת��</font></a>��
    </td>
    </tr>
  <% 
  elseif Menu_Type=5 then
   %>  
    <tr class="tdbg">
    	<td>��������ҳ��</td>
      <td colspan="2"> <input type="text" name="CopyFrom" value="" size="40" />
    </td>
    </tr>
  <% end if
	 if Menu_Type=2 or Menu_Type=3 then %>  
       <tr class="tdbg">
    	<td>�� ��</td>
      <td colspan="2"> <input type="text" name="Price" value="" size="20" />
    </td>
    </tr>     
 <% end if %>

   <% 
  if Menu_Type=5 then
   %> 
      <tr class="tdbg">
      <td>
      	��Ļ��ͼ��</td>
      <td colspan="2">
      	  <input name="Image_URL" id="Image_URL" type="text" size="40" value="" onClick="viewImage(this.value, 0);" />
          <input type="button" onClick="ShowDialog('upimage.htm',Image_URL,350,170);" value="�ϴ�" />
                </td>
    </tr>  
 <% else%>
      <tr class="tdbg">
      <td>
      	ͼƬ��</td>
      <td colspan="2">
      	  <input name="Image_URL" id="Image_URL" type="text" size="40" value="" onClick="viewImage(this.value, 0);" />
          <input type="button" onClick="ShowDialog('upimage.htm',Image_URL,350,170);" value="�ϴ�" />
                </td>
    </tr>  
 <% end if %>
<%
 if Menu_Type=4 then
%>	

    <tr class="tdbg">
      <td>
      	��Ƶ/��Ƶ��</td>
      <td colspan="2">
      	  <input name="sImage_URL" id="sImage_URL" type="text" size="40" value="" />
		  <input type="button" onClick="ShowDialog('upmusic.htm',sImage_URL,350,170);" value="�ϴ�" />
		   <input type="button" onClick="ShowDialog('dialog.htm?SelectFile:1',sImage_URL,350,170);" value="ѡ��" />
                </td>
    </tr> 
 <% else%>

    <tr class="tdbg">
      <td>
      	����ͼ��</td>
      <td colspan="2">
      	  <input name="sImage_URL" id="sImage_URL" type="text" size="40" value="" onClick="viewImage(this.value, 1);" />
          <input type="button" onClick="CreateSmallImage();" value="�Զ�����" />
		  <input type="button" onClick="ShowDialog('upimage.htm',sImage_URL,350,170);" value="�ϴ�" />
                </td>
    </tr> 
 <% end if %>

 <% If Menu_Type=5 Then
 '�������
 %>
    <tr class="tdbg">
      <td>
      	����汾��</td>
      <td colspan="2">
      	  <input name="Version" id="Version" type="text" size="40" value="" />
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	������ԣ�</td>
      <td colspan="2">
      	  <input name="Language" id="Language" type="text" size="40" value="" />
		  <select name="select1" id="select1" onChange="setValues('Language',this.value, true);">
                  <option value="" selected>��ѡ��</option><option value="��������">��������</option><option value="��������">��������</option><option value="Ӣ��">Ӣ��</option><option value="�������">�������</option>
                </select>
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	��Ȩ��ʽ��</td>
      <td colspan="2">
      	  <input name="License" id="License" type="text" size="40" value="" />
		  <select name="select1" id="select1" onChange="setValues('License',this.value, true);">
                  <option value="" selected>��ѡ��</option><option value="���">���</option><option value="����">����</option><option value="����">����</option><option value="��ʾ">��ʾ</option><option value="ע��">ע��</option><option value="�ƽ�">�ƽ�</option><option value="����">����</option>
                </select>
                </td>
    </tr> 
    <tr class="tdbg">
      <td>
      	����ƽ̨��</td>
      <td colspan="2">
      	  <input name="RunOS" id="RunOS" type="text" size="40" value="" />
		  <select name="select2" id="select2" onChange="setValues('RunOS',this.value, false);">
                  <option value="" selected>��ѡ��</option>
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
      	�ļ���С��</td>
      <td colspan="2">
      	  <input name="Size" id="Size" type="text" size="40" value="" />
                </td>
    </tr>
    <tr class="tdbg">
      <td>
      	��ʾ��ַ��</td>
      <td colspan="2">
      	  <input name="DemoURL" id="DemoURL" type="text" size="40" value="" />
                </td>
    </tr>	
    <tr class="tdbg">
      <td>
      	ע���ַ��</td>
      <td colspan="2">
      	  <input name="RegURL" id="RegURL" type="text" size="40" value="" />
                </td>
    </tr>
    <tr class="tdbg">
      <td valign="top">
      	���ص�ַ��
		</td>
      <td colspan="2">
      	  <input name="DownURLs" id="DownURLs" type="text" size="40" value="" />
		  <img src="../Editor/ButtonImage/standard/sizeplus.gif" style="cursor:pointer;" onClick="lcms_add_field();" align="absmiddle" alt="������ص�ַ" />
      </td>
    </tr>

  <% end if %>
    <tr class="tdbg">
    <td>ѡ�</td>
      <td colspan="2">
	  <input name="On_Top" type="checkbox" id="On_Top" value="1" /><label for="On_Top">�ö�</label>
	  <input name="isBest" type="checkbox" id="isBest" value="1" /><label for="isBest">�Ƽ�</label>
	  <input name="Has_Image" type="checkbox" id="Has_Image" value="1" /><label for="Has_Image">ͼ��</label>
	  <input name="Locked" type="checkbox" id="Locked" value="1" /><label for="Locked">����</label>
	 
	  	
      </td>   
	</tr>	
    <tr class="tdbg">
      <td align="left" valign="top">��ϸ���ݣ�</td>
      <td colspan="2">
	 <div id="preLoadEditor" style="display:;"><img src="../public/images/manage/loading.gif" />��������༭��...</div>
	 <iframe ID="Editor1" src="../Editor/eWebEditor.asp?id=content" frameborder="0" scrolling="no" width="0" HEIGHT="0" onload="preLoadEditor.style.display='none'; this.width='550'; this.height='350'"></iframe>	  </td>
    </tr>
    <script language="javascript">
		document.write('<input name="Menu_Id" type="hidden" value="' + window.top.document.selected_menu_id + '">')
	</script>
	<input name="content" type="hidden" id="content" value="" />
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
	//չʾͼƬ

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
		div.innerHTML = "<div style='width:200px'>����ͼƬʧ�ܣ�<br />ͼƬ�����ڻ��ʽ����ȷ��</div>";	
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