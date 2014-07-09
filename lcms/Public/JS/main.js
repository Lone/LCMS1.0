// JavaScript Document
//Created By Lone 2006-12-10
function resizeImage(image,width,height)
{
var img = new Image;
img.src = image.src;
var w = img.width;
var h = img.height;
if(w>width && w>h){
	image.width=width;
	image.height = parseInt(h*(width/w));
	}
if(h>height && h>w){
	image.width = parseInt(w*(height/h));
	image.height = height;
	}
}

function popimgwin(imgurl){
	if(!imgurl || imgurl==""){
		alert("������ʧ��");
		return false;
	}
	var img = new Image
	img.src = imgurl
	height = img.height
	width = img.width
	var str = "location=0,status=no scrollbars=0 width="
	str += width + " height="
	str += height
	var newwin = window.open(img.src,'',str)
	newwin.document.body.style.margin=0;
	newwin.moveTo((screen.width-width)/2,(screen.height-height)/2);
	return false;
}

function showBig(url){
	if(!url || url==""){
		alert("û�пɲ鿴�Ĵ�ͼƬ��");
		return false;
	}
popimgwin(url);
}

function openWin(url,winname,width,height,scrollbars)
{
	var sb=0;
	if(scrollbars)sb = scrollbars;
	var newwin = window.open(url,winname,'toolbar=0,location=0,status=0,menubar=0,scrollbars='+sb+',resizable=0,width='+width+',height='+height);
	newwin.moveTo((screen.width-width)/2,(screen.height-height)/2);
	return false;
}

function popimgwin1(imgurl){
	if(!imgurl || imgurl==""){
		alert("�����ϴ�ͼƬ��");
		return false;
	}
	var img = new Image
	img.src = imgurl
	height = img.height
	width = img.width
	var str = "location=0,status=no scrollbars=0 width="
	str += width + " height="
	str += height
	var newwin = window.open(img.src,'',str)
	newwin.document.body.style.margin=0;
	newwin.moveTo((screen.width-width)/2,(screen.height-height)/2);
	return false;
}

function selectAll(objForm){
	var inputs = document.getElementsByTagName("input")
	//alert(inputs["chkAll"].checked)
	if(inputs["chkAll"].checked==true){
		for(var i=0;i<inputs.length;i++){
			if(inputs[i].type="checkbox")inputs[i].setAttribute("checked",true);
		}
	}else{
		for(var i=0;i<inputs.length;i++){
			if(inputs[i].type="checkbox")inputs[i].setAttribute("checked",false);
		}
	}
}

function Lone_chkForm(form) {
   var input=form.elements
	for(i=0;i<input.length;i++){
		if(input[i].mustFill&&input[i].value==""){
			var info = input[i].info;
			if(!info || info == "")info="��*�ŵ��Ǳ�����д�ġ�";
			alert("�Բ�����û����д���Ҫ�ı���Ϣ��\n\n"+info);
			if(isVisual(input[i]))
			input[i].focus();
			return false;
		}
		if(input[i].isEmail && (!verifyMail(input[i].value))){
			var info = "�����ʼ���ʽ����ȷ��";
			alert("�Բ�������д����Ϣ�������´���\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
		if(input[i].isNumber && (!isNumeric(input[i].value))){
			var info = "����д���֡�";
			alert("�Բ�������д����Ϣ�������´���\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
		if(input[i].isDate && (!isDate(input[i].value))){
			var info = "����д��ȷ�����ڡ�";
			alert("�Բ�������д����Ϣ�������´���\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
		if(input[i].isIdCard && (!cidInfo(input[i].value))){
			var info = "����д��ȷ�����֤���롣";
			alert("�Բ�������д����Ϣ�������´���\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
   }
return true;
}

function isVisual(ele)
{
	if(ele.disabled)return false;
	if(ele.readonly)return false;	
	if(ele.getAttribute("type")=="hidden")return false;
	return true;
}
function verifyMail(m_value) 
{ 
var email = m_value; 
	if (email=="")
	{
		return true;
	}
	//var pattern = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/; 
	var pattern = /^\s*([A-Za-z0-9_-]+(\.\w+)*@(\w+\.)+\w{2,3})\s*$/;
	flag = pattern.test(email); 
	if(flag) 
		return true;
	return false;
}

function isNumeric(m_value)
{
	var m = m_value;
	if (m=="")
	{
		return true;
	}
	var pattern = /^[0-9]\d*$|[1-9]\d*\.\d*|0\.\d*[1-9]\d*$/;
	flag = pattern.test(m); 
	if(flag)
		return true;
	return false;
}

function isDate(m_value)
{
	var m = m_value;
	if (m=="")
	{
		return true;
	}
	var pattern = /\d{4}-\d{1,2}-\d{1,2}/;
	flag = pattern.test(m); 
	if(flag) 
		return true;
	return false;
}

function cidInfo(sId,flag){
	var aCity={
		11:"����",12:"���",13:"�ӱ�",14:"ɽ��",15:"���ɹ�",
		21:"����",22:"����",23:"������",
		31:"�Ϻ�",32:"����",33:"�㽭",34:"����",35:"����",36:"����",37:"ɽ��",
		41:"����",42:"����",43:"����",44:"�㶫",45:"����",46:"����",
		50:"����",51:"�Ĵ�",52:"����",53:"����",54:"����",
		61:"����",62:"����",63:"�ຣ",64:"����",65:"�½�",
		71:"̨��",
		81:"���",82:"����",
		91:"����"
	}
	if(sId.length==15){
		if (!/^[\d]{15}$/i.test(sId)) return false;
		var sBirthday="19"+sId.substr(6,2)+"-"+Number(sId.substr(8,2))+"-"+Number(sId.substr(10,2));
		var d=new Date(sBirthday.replace(/-/g,"/"));
		if(sBirthday!=(d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()))return 'false2';
		if(flag)return aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(14,1)%2?"��":"Ů");
		return true;
	}
	var iSum=0
	if(!/^\d{17}(\d|x)$/i.test(sId))return false;
	sId=sId.replace(/x$/i,"a");
	if(aCity[parseInt(sId.substr(0,2))]==null)return false;
	var sBirthday=sId.substr(6,4)+"-"+Number(sId.substr(10,2))+"-"+Number(sId.substr(12,2));
	var d=new Date(sBirthday.replace(/-/g,"/"))
	if(sBirthday!=(d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()))return false;
	for(var i=17;i>=0;i--)iSum+=(Math.pow(2,i)%11)*parseInt(sId.charAt(17-i),11)
	if(iSum%11!=1)return false;
	if(flag)return aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"��":"Ů");
	return true;
}