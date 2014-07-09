//Ajax TreeMenu By Lone Chain

function createAjax(){
	var http;
	try{ http = new ActiveXObject("MSXML2.XMLHTTP"); }catch (e){
	try{ http = new XMLHttpRequest(); }catch (e){http=null;}
	}
	return http;
}

function Unfold_Menu(objMenu){
	if (!objMenu) return;
	var Menu_Id = eval(objMenu.id);
	objMenu.onclick = function(){Fold_Menu(objMenu);}
	var icon = objMenu.firstChild.src;
	if (icon.indexOf("menu_root"))
	{
		objMenu.firstChild.src = icon.replace("menu_fold","menu_unfold")
	}
	setMenuId(objMenu);
	if (objMenu.parentNode.lastChild.style.display=="none")
	{
		objMenu.parentNode.lastChild.style.display = "";
		return;
	}
	var xmlHttp = createAjax();
	var div = document.createElement("div");
	div.innerHTML = '<img src="../public/images/manage/loading.gif" width="16" height="16" align="absmiddle" />Loading...';
	objMenu.parentNode.appendChild(div);
	var url = "menu.asp?action=GetMenu&pId="+Menu_Id;
	if (!xmlHttp)return;
	xmlHttp.onreadystatechange = function(){
		if (xmlHttp.readyState == 4)
		{
			var menuStr = xmlHttp.responseText;
			var ul = document.createElement("div");
			ul.innerHTML = menuStr;
			objMenu.parentNode.removeChild(div);
			objMenu.parentNode.appendChild(ul.firstChild);
			xmlHttp = null;
		}
	}
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function Fold_Menu(objMenu){
	if (!objMenu) return;
	objMenu.onclick = function(){Unfold_Menu(objMenu);}
	objMenu.firstChild.src = objMenu.firstChild.src.replace("menu_unfold","menu_fold")
	objMenu.parentNode.lastChild.style.display = 'none';
	setMenuId(objMenu);
}

function setMenuId(objMenu){
	var oId = window.top.document.selected_menu_id;
	var Id = eval(objMenu.id);
	if (Id==oId) return;
	$('lcms_menu('+oId+')').className = '';
	objMenu.className = 'shadow';
	window.top.document.selected_menu_id = Id;
	window.top.document.menu_type = objMenu.getAttribute("menutype");
	if (Id==0) {
		top.frames["mainFrame"].location.href = 'helloworld.asp';
	}else{
		top.frames["mainFrame"].location.href = 'LCMS_Content.htm';
	}
}
function lcms_menu(id){ return id;}
function $(d){ return document.getElementById(d);}
window.onerror = function(){return true;}

function getURL(vUrl, objMenu){
	if (! vUrl || vUrl=='') return;
	var oId = window.top.document.selected_menu_id;
	var Id = eval(objMenu.id);
	if (Id==oId) return;
	$('lcms_menu('+oId+')').className = '';
	objMenu.className = 'shadow';
	window.top.document.selected_menu_id = Id;
	top.frames["mainFrame"].location.href = vUrl;
}