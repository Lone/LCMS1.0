<!--
function CreateAjax(){
	var http;
	try{ http = new ActiveXObject("MSXML2.XMLHTTP"); }catch (e){
	try{ http = new XMLHttpRequest(); }catch (e){http=null;}
	}
	return http;
}

function getValue(url, objDiv){
	$(objDiv).innerHTML = '���ڶ�ȡ����...';

	var http = CreateAjax();
	if (!http) {
		$(objDiv).innerHTML = '��ȡ����ʧ�ܡ�';
		return false;
	}
	
	http.onreadystatechange = function(){
		//alert("hello")
	if (http.readyState == 4)
	{
		$(objDiv).innerHTML = http.responseText;
		http = null;
	}	
	//	callback(http, objDiv);
	}
	http.open("GET", url, true);
	http.send(null);
}

function callback(HTTP, oDiv){
	
	if (HTTP.readyState == 4)
	{
		$(oDiv).innerHTML = HTTP.responseText;
		HTTP = null;
	}
}

function $(el)
{
	if(!el)
	{
		return null;
	}
	else if(typeof el=='string')
	{
		return document.getElementById(el);
	}
	else if(typeof el=='object')
	{
		return el;
	}
}
-->