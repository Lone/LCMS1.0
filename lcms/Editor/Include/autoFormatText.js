function formattext(text){
	text = text.replace(/<br(\/?)>/gi, "<p>");
	text = text.replace(/<\/p>/gi, "\n");
	text = text.replace(/<p([^>]*)>/gi, "<p>");
	text = text.replace(/<\/div>/gi, "\n");
	text = text.replace(/<div([^>]*)>/gi, "<p>");
	text = text.replace(/<font([^>]*)>[\s(&nbsp;)　]*<\/font>/gi, "");
	text = text.replace(/<strong([^>]*)>[\s(&nbsp;)　]*<\/strong>/gi, "");
	text = text.replace(/<span([^>]*)>[\s(&nbsp;)　]*<\/span>/gi, "");
	var naivete_array =text.split("<p>");
	if (naivete_array.length >0){
	text="";
		for (loop=0; loop < naivete_array.length;loop++){
				 text = text + mytrim(naivete_array[loop]);
		}
	}
return text;
}

function mytrim(text){
//去除段落前面的空格,包括空格、制表符、换行符等等
	text = text.replace(/(^[\s(&nbsp;)　]*)|(\s*$)/gi,"")
	return (text!="")? "<p>" + text + "</p>" : ""
}