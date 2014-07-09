INSERT INTO [LCMS_Administrator]([Admin_Name],[Admin_UserName] ,[Admin_Password],[Admin_Usableness],[Admin_Note],[Admin_AddDate],[Admin_LastDate],[Admin_IP],[Admin_Options])VALUES('系统管理员','lone','21232F297A57A5A743894A0E4A801FC3','1',N'',getdate(),getdate(),N'','0,');

insert into eWebEditor_Button values ('About','关于 - eWebEditor','about.gif',null,'0','ShowDialog(''dialog/about.htm'',''400'',''220'')','Btn','206','1');
insert into eWebEditor_Button values ('absolutePosition','绝对或相对位置','abspos.gif',null,'0','absolutePosition()','Btn','115','1');
insert into eWebEditor_Button values ('Anchor','书签管理','anchor.gif',null,'0','ShowDialog(''dialog/anchor.htm'', 270, 220, true);','Btn','87','1');
insert into eWebEditor_Button values ('BackColor','字体背景颜色','backcolor.gif',null,'0','ShowDialog(''dialog/selcolor.htm?action=backcolor'', 280, 250, true)','Btn','23','1');
insert into eWebEditor_Button values ('BackImage','背景图片','bgpic.gif',null,'0','ShowDialog(''dialog/backimage.htm'', 350, 210, true)','Btn','24','1');
insert into eWebEditor_Button values ('BgColor','对象背景颜色','bgcolor.gif',null,'0','ShowDialog(''dialog/selcolor.htm?action=bgcolor'', 280, 250, true)','Btn','22','1');
insert into eWebEditor_Button values ('Big','字体增大','tobig.gif',null,'0','insert(''big'')','Btn','5','1');
insert into eWebEditor_Button values ('Bold','粗体','bold.gif',null,'0','format(''bold'')','Btn','9','1');
insert into eWebEditor_Button values ('BR','插入换行符','BR.gif',null,'0','insert(''br'')','Btn','82','1');
insert into eWebEditor_Button values ('Code','代码样式','code.gif',null,'0','insert(''code'')','Btn','111','1');
insert into eWebEditor_Button values ('ComponentMenu','组件菜单','ComponentMenu.gif',null,'0','showToolMenu(''component'')','Btn','0','1');
insert into eWebEditor_Button values ('Copy','复制','copy.gif',null,'0','format(''copy'')','Btn','41','1');
insert into eWebEditor_Button values ('CreateLink','插入或修改超级链接','CreateLink.gif',null,'0','createLink()','Btn','84','1');
insert into eWebEditor_Button values ('Cut','剪切','cut.gif',null,'0','format(''cut'')','Btn','40','1');
insert into eWebEditor_Button values ('Delete','删除','delete.gif',null,'0','format(''delete'')','Btn','46','1');
insert into eWebEditor_Button values ('EditMenu','编辑菜单','editmenu.gif',null,'0','showToolMenu(''edit'')','Btn','0','1');
insert into eWebEditor_Button values ('Emot','插入表情图标','emot.gif',null,'0','ShowDialog(''dialog/emot.htm'', 300, 180, true)','Btn','102','1');
insert into eWebEditor_Button values ('Excel','插入Excel表格','excel.gif',null,'0','insert(''excel'')','Btn','100','1');
insert into eWebEditor_Button values ('Fieldset','插入或修改栏目框','fieldset.gif',null,'0','ShowDialog(''dialog/fieldset.htm'', 350, 170, true)','Btn','88','1');
insert into eWebEditor_Button values ('File','插入其他文件','file.gif',null,'0','ShowDialog(''dialog/file.htm'', 350, 200, true)','Btn','93','1');
insert into eWebEditor_Button values ('FileMenu','文件视图菜单','filemenu.gif',null,'0','showToolMenu(''file'')','Btn','0','1');
insert into eWebEditor_Button values ('FindReplace','查找替换','findreplace.gif',null,'0','findReplace()','Btn','45','1');
insert into eWebEditor_Button values ('Flash','插入Flash动画','flash.gif',null,'0','ShowDialog(''dialog/flash.htm'', 350, 200, true)','Btn','91','1');
insert into eWebEditor_Button values ('FontMenu','字体菜单','fontmenu.gif',null,'0','showToolMenu(''font'')','Btn','0','1');
insert into eWebEditor_Button values ('FontName','字体',null,'<option selected>字体</option>
<option value="宋体">宋体</option>
<option value="黑体">黑体</option>
<option value="楷体_GB2312">楷体</option>
<option value="仿宋_GB2312">仿宋</option>
<option value="隶书">隶书</option>
<option value="幼圆">幼圆</option>
<option value="Arial">Arial</option>
<option value="Arial Black">Arial Black</option>
<option value="Arial Narrow">Arial Narrow</option>
<option value="Brush Script	MT">Brush Script MT</option>
<option value="Century Gothic">Century Gothic</option>
<option value="Comic Sans MS">Comic Sans MS</option>
<option value="Courier">Courier</option>
<option value="Courier New">Courier New</option>
<option value="MS Sans Serif">MS Sans Serif</option>
<option value="Script">Script</option>
<option value="System">System</option>
<option value="Times New Roman">Times New Roman</option>
<option value="Verdana">Verdana</option>
<option value="Wide Latin">Wide Latin</option>
<option value="Wingdings">Wingdings</option>','1','format(''fontname'',this[this.selectedIndex].value);this.selectedIndex=0','TBGen','4','1');
insert into eWebEditor_Button values ('FontSize','字体大小',null,'<option selected>字号</option>
<option value="7">一号</option>
<option value="6">二号</option>
<option value="5">三号</option>
<option value="4">四号</option>
<option value="3">五号</option>
<option value="2">六号</option>
<option value="1">七号</option>','1','format(''fontsize'',this[this.selectedIndex].value);this.selectedIndex=0','TBGen','6','1');
insert into eWebEditor_Button values ('ForeColor','字体颜色','forecolor.gif',null,'0','ShowDialog(''dialog/selcolor.htm?action=forecolor'', 280, 250, true)','Btn','21','1');
insert into eWebEditor_Button values ('FormatBlock','段落样式',null,'<option selected>段落样式</option>
<option value="&lt;P&gt;">普通</option>
<option value="&lt;H1&gt;">标题一</option>
<option value="&lt;H2&gt;">标题二</option>
<option value="&lt;H3&gt;">标题三</option>
<option value="&lt;H4&gt;">标题四</option>
<option value="&lt;H5&gt;">标题五</option>
<option value="&lt;H6&gt;">标题六</option>
<option value="&lt;p&gt;">段落</option>
<option value="&lt;dd&gt;">定义</option>
<option value="&lt;dt&gt;">术语定义</option>
<option value="&lt;dir&gt;">目录列表</option>
<option value="&lt;menu&gt;">菜单列表</option>
<option value="&lt;PRE&gt;">已编排格式</option>','1','format(''FormatBlock'',this[this.selectedIndex].value);this.selectedIndex=0','TBGen','8','1');
insert into eWebEditor_Button values ('FormButton','插入按钮','FormButton.gif',null,'0','format(''InsertButton'')','Btn','76','1');
insert into eWebEditor_Button values ('FormCheckbox','插入复选框','FormCheckbox.gif',null,'0','ShowDialog(''dialog/checkbox.htm'', 350, 200, true)','Btn','74','1');
insert into eWebEditor_Button values ('FormDropdown','插入下拉框','FormDropdown.gif',null,'0','format(''InsertSelectDropdown'')','Btn','75','1');
insert into eWebEditor_Button values ('FormMenu','表单菜单','FormMenu.gif',null,'0','showToolMenu(''form'')','Btn','70','1');
insert into eWebEditor_Button values ('FormRadio','插入单选钮','FormRadio.gif',null,'0','ShowDialog(''dialog/radio.htm'', 350, 200, true)','Btn','73','1');
insert into eWebEditor_Button values ('FormText','插入输入框','FormText.gif',null,'0','format(''InsertInputText'')','Btn','71','1');
insert into eWebEditor_Button values ('FormTextArea','插入文字输入区','FormTextArea.gif',null,'0','format(''InsertTextArea'')','Btn','72','1');
insert into eWebEditor_Button values ('Help','查看使用帮助','help.gif',null,'0','ShowDialog(''dialog/help.htm'',''400'',''300'')','Btn','205','1');
insert into eWebEditor_Button values ('HorizontalRule','插入水平尺','InsertHorizontalRule.gif',null,'0','format(''InsertHorizontalRule'')','Btn','81','1');
insert into eWebEditor_Button values ('Iframe','插入或修改网页帧','iframe.gif',null,'0','ShowDialog(''dialog/iframe.htm'', 350, 200, true)','Btn','89','1');
insert into eWebEditor_Button values ('Image','插入或修改图片','img.gif',null,'0','ShowDialog(''dialog/img.htm'', 350, 315, true)','Btn','90','1');
insert into eWebEditor_Button values ('Indent','增加缩进量','indent.gif',null,'0','format(''indent'')','Btn','19','1');
insert into eWebEditor_Button values ('Italic','斜体','italic.gif',null,'0','format(''italic'')','Btn','10','1');
insert into eWebEditor_Button values ('JustifyCenter','居中对齐','JustifyCenter.gif',null,'0','format(''justifycenter'')','Btn','14','1');
insert into eWebEditor_Button values ('JustifyFull','两端对齐','JustifyFull.gif',null,'0','format(''JustifyFull'')','Btn','16','1');
insert into eWebEditor_Button values ('JustifyLeft','左对齐','JustifyLeft.gif',null,'0','format(''justifyleft'')','Btn','13','1');
insert into eWebEditor_Button values ('JustifyRight','右对齐','JustifyRight.gif',null,'0','format(''justifyright'')','Btn','15','1');
insert into eWebEditor_Button values ('Map','图形热点链接','map.gif',null,'0','mapEdit()','Btn','86','1');
insert into eWebEditor_Button values ('Marquee','插入或修改字幕','Marquee.gif',null,'0','ShowDialog(''dialog/marquee.htm'', 395, 150, true)','Btn','80','1');
insert into eWebEditor_Button values ('Maximize','全屏编辑','maximize.gif',null,'0','Maximize()','Btn','130','1');
insert into eWebEditor_Button values ('Media','插入自动播放的媒体文件','Media.gif',null,'0','ShowDialog(''dialog/media.htm'', 350, 200, true)','Btn','92','1');
insert into eWebEditor_Button values ('Minimize','全屏返回','minimize.gif',null,'0','parent.Minimize()','Btn','131','0');
insert into eWebEditor_Button values ('ModeCode','代码状态','modecodebtn.gif',null,'0','setMode(''CODE'')','Btn','200','1');
insert into eWebEditor_Button values ('ModeEdit','编辑状态','modeeditbtn.gif',null,'0','setMode(''EDIT'')','Btn','201','1');
insert into eWebEditor_Button values ('ModeText','文本状态','modetextbtn.gif',null,'0','setMode(''TEXT'')','Btn','202','1');
insert into eWebEditor_Button values ('ModeView','预览状态','modeviewbtn.gif',null,'0','setMode(''VIEW'')','Btn','203','1');
insert into eWebEditor_Button values ('NowDate','插入当前日期','date.gif',null,'0','insert(''nowdate'')','Btn','103','1');
insert into eWebEditor_Button values ('ObjectMenu','对象效果菜单','objectmenu.gif',null,'0','showToolMenu(''object'')','Btn','0','1');
insert into eWebEditor_Button values ('OrderedList','编号','insertorderedlist.gif',null,'0','format(''insertorderedlist'')','Btn','17','1');
insert into eWebEditor_Button values ('Outdent','减少缩进量','outdent.gif',null,'0','format(''outdent'')','Btn','20','1');
insert into eWebEditor_Button values ('Paragraph','插入段落','InsertParagraph.gif',null,'0','format(''InsertParagraph'')','Btn','83','1');
insert into eWebEditor_Button values ('ParagraphMenu','段落菜单','ParagraphMenu.gif',null,'0','showToolMenu(''paragraph'')','Btn','0','1');
insert into eWebEditor_Button values ('Paste','常规粘贴','paste.gif',null,'0','format(''paste'')','Btn','42','1');
insert into eWebEditor_Button values ('PasteText','纯文本粘贴','pastetext.gif',null,'0','PasteText()','Btn','43','1');
insert into eWebEditor_Button values ('PasteWord','从Word中粘贴','pasteword.gif',null,'0','PasteWord()','Btn','44','1');
insert into eWebEditor_Button values ('Print','打印','print.gif',null,'0','format(''Print'')','Btn','204','1');
insert into eWebEditor_Button values ('Quote','引用样式','quote.gif',null,'0','insert(''quote'')','Btn','110','1');
insert into eWebEditor_Button values ('ReDo','恢复','redo.gif',null,'0','goHistory(1)','Btn','28','1');
insert into eWebEditor_Button values ('Refresh','新建','refresh.gif',null,'0','format(''refresh'')','Btn','114','1');
insert into eWebEditor_Button values ('RemoteUpload','远程自动上传','remoteupload.gif',null,'0','remoteUpload()','Btn','133','1');
insert into eWebEditor_Button values ('RemoveFormat','删除文字格式','RemoveFormat.gif',null,'0','format(''RemoveFormat'')','Btn','47','1');
insert into eWebEditor_Button values ('Save','保存并返回','save.gif',null,'0','parent.doSave()','Btn','132','1');
insert into eWebEditor_Button values ('SelectAll','全部选中','selectAll.gif',null,'0','format(''SelectAll'')','Btn','29','1');
insert into eWebEditor_Button values ('ShowBorders','显示或隐藏指导方针','ShowBorders.gif',null,'0','showBorders()','Btn','112','1');
insert into eWebEditor_Button values ('Site','eWebEditor站点','site.gif',null,'0','window.open(''http://ewebeditor.webasp.net'')','Btn','207','1');
insert into eWebEditor_Button values ('SizeMinus','减小编辑区','sizeminus.gif',null,'0','sizeChange(-300)','Btn','121','1');
insert into eWebEditor_Button values ('SizePlus','增高编辑区','sizeplus.gif',null,'0','sizeChange(300)','Btn','120','1');
insert into eWebEditor_Button values ('Small','字体减小','tosmall.gif',null,'0','insert(''small'')','Btn','7','1');
insert into eWebEditor_Button values ('Space','空格',null,'&nbsp;','2',null,'TBGen','3','1');
insert into eWebEditor_Button values ('SpellCheck','拼写检查','spellCheck.gif',null,'0','spellCheck()','Btn','0','0');
insert into eWebEditor_Button values ('StrikeThrough','中划线','strikethrough.gif',null,'0','format(''StrikeThrough'')','Btn','12','1');
insert into eWebEditor_Button values ('SubScript','下标','subscript.gif',null,'0','format(''subscript'')','Btn','26','1');
insert into eWebEditor_Button values ('SuperScript','上标','superscript.gif',null,'0','format(''superscript'')','Btn','25','1');
insert into eWebEditor_Button values ('Symbol','插入特殊字符','symbol.gif',null,'0','ShowDialog(''dialog/symbol.htm'', 350, 220, true)','Btn','101','1');
insert into eWebEditor_Button values ('TableCellProp','单元格属性','TableCellProp.gif',null,'0','TableCellProp()','Btn','53','1');
insert into eWebEditor_Button values ('TableCellSplit','拆分单元格','TableCellSplit.gif',null,'0','TableCellSplit()','Btn','54','1');
insert into eWebEditor_Button values ('TableColDelete','删除列','TableColDelete.gif',null,'0','TableColDelete()','Btn','65','1');
insert into eWebEditor_Button values ('TableColInsertLeft','插入列（在左侧）','TableColInsertLeft.gif',null,'0','TableColInsertLeft()','Btn','61','1');
insert into eWebEditor_Button values ('TableColInsertRight','插入列（在右侧）','TableColInsertRight.gif',null,'0','TableColInsertRight()','Btn','62','1');
insert into eWebEditor_Button values ('TableColMerge','合并列（向右侧）','TableColMerge.gif',null,'0','TableColMerge()','Btn','63','1');
insert into eWebEditor_Button values ('TableColSplit','拆分列','TableColSplit.gif',null,'0','TableColSplit(2)','Btn','64','1');
insert into eWebEditor_Button values ('TableInsert','插入表格','tableinsert.gif',null,'0','TableInsert()','Btn','51','1');
insert into eWebEditor_Button values ('TableMenu','表格菜单','tablemenu.gif',null,'0','showToolMenu(''table'')','Btn','50','1');
insert into eWebEditor_Button values ('TableProp','修改表格属性','tableProp.gif',null,'0','TableProp()','Btn','52','1');
insert into eWebEditor_Button values ('TableRowDelete','删除行','TableRowDelete.gif',null,'0','TableRowDelete()','Btn','60','1');
insert into eWebEditor_Button values ('TableRowInsertAbove','插入行（在上方）','TableRowInsertAbove.gif',null,'0','TableRowInsertAbove()','Btn','56','1');
insert into eWebEditor_Button values ('TableRowInsertBelow','插入行（在下方）','TableRowInsertBelow.gif',null,'0','TableRowInsertBelow()','Btn','57','1');
insert into eWebEditor_Button values ('TableRowMerge','合并行（向下方）','TableRowMerge.gif',null,'0','TableRowMerge()','Btn','58','1');
insert into eWebEditor_Button values ('TableRowProp','表格行属性','TableRowProp.gif',null,'0','TableRowProp()','Btn','55','1');
insert into eWebEditor_Button values ('TableRowSplit','拆分行','TableRowSplit.gif',null,'0','TableRowSplit(2)','Btn','59','1');
insert into eWebEditor_Button values ('TBHandle','工具栏头',null,null,'2',null,'TBHandle','2','1');
insert into eWebEditor_Button values ('TBSep','分隔线',null,null,'2',null,'TBSep','1','1');
insert into eWebEditor_Button values ('ToolMenu','工具菜单','toolmenu.gif',null,'0','showToolMenu(''tool'')','Btn','0','1');
insert into eWebEditor_Button values ('UnderLine','下划线','underline.gif',null,'0','format(''underline'')','Btn','11','1');
insert into eWebEditor_Button values ('UnDo','撤消','undo.gif',null,'0','goHistory(-1)','Btn','27','1');
insert into eWebEditor_Button values ('Unlink','取消超级链接或标签','Unlink.gif',null,'0','format(''UnLink'')','Btn','85','1');
insert into eWebEditor_Button values ('UnOrderedList','项目符号','insertunorderedlist.gif',null,'0','format(''insertunorderedlist'')','Btn','18','1');
insert into eWebEditor_Button values ('UnSelect','取消选择','unselect.gif',null,'0','format(''Unselect'')','Btn','30','1');
insert into eWebEditor_Button values ('zIndexBackward','下移一层','backward.gif',null,'0','zIndex(''backward'')','Btn','116','1');
insert into eWebEditor_Button values ('zIndexForward','上移一层','forward.gif',null,'0','zIndex(''forward'')','Btn','117','1');
insert into eWebEditor_Button values ('ZoomMenu','缩放菜单','zoommenu.gif',null,'0','showToolMenu(''zoom'')','Btn','114','1');
insert into eWebEditor_Button values ('ZoomSelect','缩放下拉框',null,'<option value="10">10%</option>
<option value="25">25%</option>
<option value="50">50%</option>
<option value="75">75%</option>
<option value="100" selected>100%</option>
<option value="150">150%</option>
<option value="200">200%</option>
<option value="500">500%</option>','1','doZoom(this[this.selectedIndex].value)','TBGen','113','1');
insert into eWebEditor_Button values ('Favorite','加入收藏本页代码','Favorite.gif',null,'0','insert(''favorite'')','Btn','208','1');
insert into eWebEditor_Button values ('NowTime','插入当前时间','time.gif',null,'0','insert(''nowtime'')','Btn','104','1');
insert into eWebEditor_Button values ('AutoFormat','自动排版','AutoFormat.gif',null,'0','AutoFormat()','Btn','209','1');


set identity_insert eWebEditor_Style on;
insert into eWebEditor_Style(S_ID,S_Name,S_Dir,S_CSS,S_UploadDir,S_Width,S_Height,S_Memo,S_IsSys,S_FileExt,S_FlashExt,S_ImageExt,S_MediaExt,S_RemoteExt,S_FileSize,S_FlashSize,S_ImageSize,S_MediaSize,S_RemoteSize,S_StateFlag,S_DetectFromWord,S_InitMode,S_BaseUrl,S_UploadObject,S_AutoDir,S_BaseHref,S_ContentPath,S_AutoRemote,S_ShowBorder) values ('14','standard','standard','office','/Upload/','550','350','Office标准风格，部分常用按钮，标准适合界面宽度，默认样式','0','rar|zip|doc|pdf|chm|hlp','swf','gif|jpg|jpeg|bmp|png','rm|ra|avi|mpg|mpeg|asf|asx|mov|wmv','gif|jpg|jpeg|bmp|png','2000','1000','1000','2000','500','1','true','EDIT','1','0','2','','','1','0');
insert into eWebEditor_Style(S_ID,S_Name,S_Dir,S_CSS,S_UploadDir,S_Width,S_Height,S_Memo,S_IsSys,S_FileExt,S_FlashExt,S_ImageExt,S_MediaExt,S_RemoteExt,S_FileSize,S_FlashSize,S_ImageSize,S_MediaSize,S_RemoteSize,S_StateFlag,S_DetectFromWord,S_InitMode,S_BaseUrl,S_UploadObject,S_AutoDir,S_BaseHref,S_ContentPath,S_AutoRemote,S_ShowBorder) values ('15','member','standard','blue','/Upload/','550','350','Office标准风格，部分常用按钮，标准适合界面宽度，默认样式','0','rar|zip|doc|pdf|chm|hlp','swf','gif|jpg|jpeg|bmp|png','rm|ra|avi|mpg|mpeg|asf|asx|mov|wmv','gif|jpg|jpeg|bmp|png','2000','1000','1000','2000','500','1','true','EDIT','1','0','2',null,null,'1','0');
insert into eWebEditor_Style(S_ID,S_Name,S_Dir,S_CSS,S_UploadDir,S_Width,S_Height,S_Memo,S_IsSys,S_FileExt,S_FlashExt,S_ImageExt,S_MediaExt,S_RemoteExt,S_FileSize,S_FlashSize,S_ImageSize,S_MediaSize,S_RemoteSize,S_StateFlag,S_DetectFromWord,S_InitMode,S_BaseUrl,S_UploadObject,S_AutoDir,S_BaseHref,S_ContentPath,S_AutoRemote,S_ShowBorder) values ('16','music','standard','office','/Upload/','550','350','Office标准风格，部分常用按钮，标准适合界面宽度，默认样式','0','rar|zip|doc|pdf|chm|hlp','swf','gif|jpg|jpeg|bmp|png','rm|ram|mp3|wma|wmv|flv','gif|jpg|jpeg|bmp|png','2000','1000','1000','10000','500','1','true','EDIT','1','0','2',null,null,'1','0');
set identity_insert eWebEditor_Style off;

set identity_insert eWebEditor_ToolBar on;
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('47','14','格式工具栏','1','TBHandle|FormatBlock|FontName|FontSize|ZoomSelect|Bold|Italic|UnderLine|StrikeThrough|SuperScript|SubScript|TBSep|JustifyLeft|JustifyCenter|JustifyRight|JustifyFull');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('48','14','常用工具栏','2','TBHandle|Cut|Copy|Paste|PasteText|PasteWord|TBSep|FindReplace|Delete|RemoveFormat|TBSep|UnDo|ReDo|TBSep|SelectAll|UnSelect|TBSep|OrderedList|UnOrderedList|Indent|Outdent|TBSep|ForeColor|BgColor|BackColor|BackImage|TBSep|absolutePosition|zIndexForward|zIndexBackward');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('49','14','高级工具栏','3','TBHandle|Image|Flash|Media|File|TBSep|TableMenu|ShowBorders|TBSep|Fieldset|Iframe|HorizontalRule|Marquee|TBSep|CreateLink|Map|Unlink|TBSep|Symbol|Emot|Excel|NowDate|NowTime|TBSep|Quote|TBSep|Maximize|RemoteUpload|AutoFormat|Favorite');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('50','15','格式工具栏','1','TBHandle|FormatBlock|FontName|FontSize|ZoomSelect|Bold|Italic|UnderLine|StrikeThrough|SuperScript|SubScript|TBSep|JustifyLeft|JustifyCenter|JustifyRight|JustifyFull');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('51','15','常用工具栏','2','TBHandle|Cut|Copy|Paste|PasteText|PasteWord|TBSep|FindReplace|Delete|RemoveFormat|TBSep|UnDo|ReDo|TBSep|SelectAll|UnSelect|TBSep|OrderedList|UnOrderedList|Indent|Outdent|TBSep|ForeColor|BgColor|BackColor|BackImage|TBSep|absolutePosition|zIndexForward|zIndexBackward');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('52','15','高级工具栏','3','TBHandle|Image|Flash|Media|File|TBSep|TableMenu|ShowBorders|TBSep|Fieldset|Iframe|HorizontalRule|Marquee|TBSep|CreateLink|Map|Unlink|TBSep|Symbol|Emot|Excel|NowDate|NowTime|TBSep|Quote|TBSep|Maximize|RemoteUpload|AutoFormat|Favorite');
set identity_insert eWebEditor_ToolBar off;