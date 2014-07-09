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
		alert("参数丢失。");
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
		alert("没有可查看的大图片。");
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
		alert("请先上传图片。");
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
			if(!info || info == "")info="带*号的是必须填写的。";
			alert("对不起，您没有填写完必要的表单信息。\n\n"+info);
			if(isVisual(input[i]))
			input[i].focus();
			return false;
		}
		if(input[i].isEmail && (!verifyMail(input[i].value))){
			var info = "电子邮件格式不正确。";
			alert("对不起，您填写的信息出现以下错误：\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
		if(input[i].isNumber && (!isNumeric(input[i].value))){
			var info = "请填写数字。";
			alert("对不起，您填写的信息出现以下错误：\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
		if(input[i].isDate && (!isDate(input[i].value))){
			var info = "请填写正确的日期。";
			alert("对不起，您填写的信息出现以下错误：\n\n"+info);
			if(isVisual(input[i]))
			input[i].select();
			return false;
		}
		if(input[i].isIdCard && (!cidInfo(input[i].value))){
			var info = "请填写正确的身份证号码。";
			alert("对不起，您填写的信息出现以下错误：\n\n"+info);
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
		11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
		21:"辽宁",22:"吉林",23:"黑龙江",
		31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",
		41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",
		50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",
		61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",
		71:"台湾",
		81:"香港",82:"澳门",
		91:"国外"
	}
	if(sId.length==15){
		if (!/^[\d]{15}$/i.test(sId)) return false;
		var sBirthday="19"+sId.substr(6,2)+"-"+Number(sId.substr(8,2))+"-"+Number(sId.substr(10,2));
		var d=new Date(sBirthday.replace(/-/g,"/"));
		if(sBirthday!=(d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()))return 'false2';
		if(flag)return aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(14,1)%2?"男":"女");
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
	if(flag)return aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"男":"女");
	return true;
}