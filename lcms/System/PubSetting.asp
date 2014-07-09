<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="GENERATOR" content="EditPlus" />
<meta name="AUTHOR" content="Lone Chain" />
<title>Lone Content Management System V<%=SYS_VERSION%></title>
<link rel="stylesheet" href="../public/css/admin.css" type="text/css" />
<script language="javascript" src="../public/js/admin.js"></script>
<script language="javascript">
function StartPub(menuid){
	var m_id = dialogArguments.top.document.selected_menu_id;
	var fw_list, fw_content, fw_all, opts, opts_today, opts_new
	if (!m_id)
	{
		alert("无法确定待发布的目录。");
		CancelPub();
	}

	fw_list = $("fw_list").checked;
	fw_content = $("fw_content").checked;
	fw_all = $("fw_all").checked;
	opts = $("opts").checked;
	opts_today = $("opts_today").checked;
	opts_new = $("opts_new").checked;
	$("Start").disabled = true;


	$("Descritpion").innerHTML = "正在获取数据...";
	var url= "createList.asp?action=getmenu";
	if (opts) url += "&IncludeChildren=1";
	if (fw_list) url += "&pub=list";
	if (fw_content) url += "&pub=content";
	if (fw_all) url += "&pub=all";
	if (opts_today) url += "&pubtoday=1";
	if (opts_new) url += "&pubnew=1";
	url += "&MenuId=" + m_id;
	//window.open(url);
	frames["pubFrame"].location.href = url;

}

function CancelPub(){
	if ($("Start").disabled)
		if (!confirm("操作还未完成，确定要结束操作吗？"))
			return false;
	window.close();
}

function Reload(w){
	if (w) {
	$('bar').style.backgroundColor = '#ffff00';
	$('bar').style.width = w + '%';
	}
	frames["pubFrame"].location.href='createlist.asp?q='+Math.random();
}
function Display(str){
	if (str!="")
	{
		$("Descritpion").innerHTML = str;
	}
}
</script>
</head>

<body bgcolor="#FFFFFF" scroll="no" text="#000000">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="borderon">
<tr>
<td align="left" valign="top" width="100%" height="100%">
<div id="Descritpion" style="padding: 12px; width:100%; height:60px;">
发布范围：
<input type="radio" name="fw" id="fw_list" value="1" checked /><label for="fw_list">仅列表页</label>
<input type="radio" name="fw" id="fw_content" value="1" /><label for="fw_content">仅内容页</label>
<input type="radio" name="fw" id="fw_all" value="1" /><label for="fw_all">列表和内容页</label>
<br />
发布选项：
<input type="checkbox" name="xx" id="opts" value="1" /><label for="opts">同时发布子栏目</label><br />
　　　　　
<input type="checkbox" name="xx" id="opts_today" value="1" /><label for="opts_today">仅发布今日内容</label><br />
　　　　　
<input type="checkbox" name="xx" id="opts_new" value="1" /><label for="opts_new">仅发布新增内容</label><br />
</div>
<div style="padding: 12px; width:100%; overflow: hidden;">
	<div id="bar" style="height: 20px; width:1px;">
	<iframe src="" name="pubFrame" frameborder="0" border="0" scrolling="no" style="width:0%; height:0px;background-color:menu;"></iframe>
	</div>
</div>
<p align="center">
<input type="button" name="Start" id="Start" value="开始发布" onclick="StartPub();"  />
<input type="button" name="Cancel" value=" 取 消 " onclick="CancelPub();" />
</p>
</td>
</tr>
</table>

</body>
</html>