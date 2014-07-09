
function CheckAll(thisform){
	for (var i=0;i<thisform.elements.length;i++)
    {
	var e = thisform.elements[i];
	if (e.Name != "chkAll"&&e.disabled!=true)
		e.checked = thisform.chkAll.checked;
    }
}
function unselectall(thisform)
{
	var flag = true;	
	for (var i=0;i<thisform.ProductId.length;i++)
    {
		var e = thisform.ProductId[i];
		if (!e.checked){
			flag = false;
			break;
	
		}
    }
	thisform.chkAll.checked = flag;
}
function ConfirmDel(thisform)
{
	if(confirm("确定要删除选中的记录吗？"))
	    return true;
	else
	    return false;
}
function admin_Size(num,objname)
{
	var obj=document.getElementById(objname)
	if (parseInt(obj.rows)+num>=3) {
		obj.rows = parseInt(obj.rows) + num;
	}
	if (num>0)
	{
		obj.width="90%";
	}
}

function CreateAjax(){
	var http;
	try{ http = new ActiveXObject("MSXML2.XMLHTTP"); }catch (e){
	try{ http = new XMLHttpRequest(); }catch (e){http=null;}
	}
	return http;
}

function $(dom){
	return document.getElementById(dom);
}