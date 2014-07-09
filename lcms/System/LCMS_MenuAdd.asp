<!--#include file="../inc/common.asp"-->
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="EditPlus">
<meta name="AUTHOR" content="Lone Chain">
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css">
<script language="JavaScript">
<!--
function ShowDialog(url, objSetValue, vWidth, vHeight) {
	if(!objSetValue)return false;
	var arr = showModalDialog(url, window, "dialogWidth:" + vWidth + "px;dialogHeight:" + vHeight + "px;help:yes;scroll:no;status:no");
	if(arr && arr!="" && arr!="undefined")
	objSetValue.value = arr;
}
//-->
</script>
</head>

<body class="borderon">
<br />
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
  <form method="post" action="LCMS_MenuAdd_Save.asp" name="form1">
    <tr class="tdbg">
    	<td width="100">中文名称：</td>
      <td>
      <input name="Menu_Name" type="text" value="" id="Menu_Name" size="40">		</td>
    </tr>	
    	
    <tr class="tdbg">
    	<td>
    		英文名称：      </td>
      <td><input name="Menu_English_Name" type="text" size="40" id="Menu_English_Name" value="" />    </td>
    </tr>
    <tr class="tdbg">
      <td>栏目类别：</td>
      <td><select name="Menu_Type" id="Menu_Type">
        <option value="0">普通文章</option>
        <option value="1">个人日志</option>
        <option value="2">商城产品</option>
        <option value="3">供求信息</option>
        <option value="4">音乐专辑</option> 
        <option value="5">软件下载</option> 		
      </select>
      </td>
    </tr>
<% If  DatabaseType=1 Then %>
    <tr class="tdbg">
      <td>数据表：</td>
      <td><input name="Menu_Data_Table" type="text" maxlength="5" size="10" id="Menu_Data_Table" value="" />
	  请使用数字或字母，不超过5个字符。填写以后不可更改，不填则使用默认数据表
      </td>
    </tr>
<% End If %>
<!--
    <tr class="tdbg">
      <td>
      	发布权限：</td>
      <td>
      	 <input name="Menu_Master_Pub" id="Menu_Master_Pub" type="checkbox" checked value="1" />
		 <label for="Menu_Master_Pub">管理员</label>
      	 <input name="Menu_Company_Pub" id="Menu_Company_Pub" type="checkbox" value="1" />
		 <label for="Menu_Company_Pub">企业用户</label>
      	 <input name="Menu_Member_Pub" id="Menu_Member_Pub" type="checkbox" value="1" />
		 <label for="Menu_Member_Pub">普通用户</label>
      </td>
    </tr>
-->
    <tr class="tdbg">
      <td>
      	图片：</td>
      <td>
      	  <input name="Menu_Icon" id="Menu_Icon" type="text" size="40" value="" onclick="viewImage(this.value, 0);" />
          <input type="button" onClick="ShowDialog('upimage.htm',Menu_Icon,350,170);" value="上传" />                </td>
    </tr>
    <tr class="tdbg">
      <td>
      	列表页模板：</td>
      <td>
      	  <input name="Menu_List_Template" id="Menu_List_Template" type="text" size="40" value="">
<input type="button" onClick="ShowDialog('dialog.htm?SelectFile:1',Menu_List_Template,350,170);" value="选择" />                 </td>
    </tr>
    <tr class="tdbg">
      <td>
      	列表页命名：</td>
      <td>
      	  <input name="Menu_List_URL" id="Menu_List_URL" type="text" size="40" value="">                </td>
    </tr>
    <tr class="tdbg">
      <td>
      	内容页模板：</td>
      <td>
      	  <input name="Menu_Content_Template" id="Menu_Content_Template" type="text" size="40" value=""> <input type="button" onClick="ShowDialog('dialog.htm?SelectFile:1',Menu_Content_Template,350,170);" value="选择" />               </td>
    </tr>
    <tr class="tdbg">
      <td>
      	内容页命名：</td>
      <td>
      	  <input name="Menu_Content_URL" id="Menu_Content_URL" type="text" size="40" value="">
		  支持参数：{$id}, {$datetime}, {$md5}, {$title}     </td>
    </tr>

    <tr class="tdbg">
      <td>
      	列表分页：</td>
      <td>
      	  <input name="Menu_List_Count" id="Menu_List_Count" type="text" size="40" value="20">      </td>
    </tr>

    <tr class="tdbg">
    	<td>
    		说明(200字以内)：      </td>
      <td><textarea name="Menu_Infomation" cols="40" rows="4" id="Menu_Infomation"></textarea>   
	  <input type="button" value="HTML" onclick="window.open('../editor/popup.asp?form=form1&field=Menu_Infomation&style=standard','html', 'width=550,height=350');">
	  </td>
    </tr>
	<script language="javascript">
		document.write('<input name="Menu_Parent_Id" type="hidden" value="' + window.top.document.selected_menu_id + '">')
	</script>
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
</script>
</body>
</html>