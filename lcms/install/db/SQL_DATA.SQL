INSERT INTO [LCMS_Administrator]([Admin_Name],[Admin_UserName] ,[Admin_Password],[Admin_Usableness],[Admin_Note],[Admin_AddDate],[Admin_LastDate],[Admin_IP],[Admin_Options])VALUES('ϵͳ����Ա','lone','21232F297A57A5A743894A0E4A801FC3','1',N'',getdate(),getdate(),N'','0,');

insert into eWebEditor_Button values ('About','���� - eWebEditor','about.gif',null,'0','ShowDialog(''dialog/about.htm'',''400'',''220'')','Btn','206','1');
insert into eWebEditor_Button values ('absolutePosition','���Ի����λ��','abspos.gif',null,'0','absolutePosition()','Btn','115','1');
insert into eWebEditor_Button values ('Anchor','��ǩ����','anchor.gif',null,'0','ShowDialog(''dialog/anchor.htm'', 270, 220, true);','Btn','87','1');
insert into eWebEditor_Button values ('BackColor','���屳����ɫ','backcolor.gif',null,'0','ShowDialog(''dialog/selcolor.htm?action=backcolor'', 280, 250, true)','Btn','23','1');
insert into eWebEditor_Button values ('BackImage','����ͼƬ','bgpic.gif',null,'0','ShowDialog(''dialog/backimage.htm'', 350, 210, true)','Btn','24','1');
insert into eWebEditor_Button values ('BgColor','���󱳾���ɫ','bgcolor.gif',null,'0','ShowDialog(''dialog/selcolor.htm?action=bgcolor'', 280, 250, true)','Btn','22','1');
insert into eWebEditor_Button values ('Big','��������','tobig.gif',null,'0','insert(''big'')','Btn','5','1');
insert into eWebEditor_Button values ('Bold','����','bold.gif',null,'0','format(''bold'')','Btn','9','1');
insert into eWebEditor_Button values ('BR','���뻻�з�','BR.gif',null,'0','insert(''br'')','Btn','82','1');
insert into eWebEditor_Button values ('Code','������ʽ','code.gif',null,'0','insert(''code'')','Btn','111','1');
insert into eWebEditor_Button values ('ComponentMenu','����˵�','ComponentMenu.gif',null,'0','showToolMenu(''component'')','Btn','0','1');
insert into eWebEditor_Button values ('Copy','����','copy.gif',null,'0','format(''copy'')','Btn','41','1');
insert into eWebEditor_Button values ('CreateLink','������޸ĳ�������','CreateLink.gif',null,'0','createLink()','Btn','84','1');
insert into eWebEditor_Button values ('Cut','����','cut.gif',null,'0','format(''cut'')','Btn','40','1');
insert into eWebEditor_Button values ('Delete','ɾ��','delete.gif',null,'0','format(''delete'')','Btn','46','1');
insert into eWebEditor_Button values ('EditMenu','�༭�˵�','editmenu.gif',null,'0','showToolMenu(''edit'')','Btn','0','1');
insert into eWebEditor_Button values ('Emot','�������ͼ��','emot.gif',null,'0','ShowDialog(''dialog/emot.htm'', 300, 180, true)','Btn','102','1');
insert into eWebEditor_Button values ('Excel','����Excel����','excel.gif',null,'0','insert(''excel'')','Btn','100','1');
insert into eWebEditor_Button values ('Fieldset','������޸���Ŀ��','fieldset.gif',null,'0','ShowDialog(''dialog/fieldset.htm'', 350, 170, true)','Btn','88','1');
insert into eWebEditor_Button values ('File','���������ļ�','file.gif',null,'0','ShowDialog(''dialog/file.htm'', 350, 200, true)','Btn','93','1');
insert into eWebEditor_Button values ('FileMenu','�ļ���ͼ�˵�','filemenu.gif',null,'0','showToolMenu(''file'')','Btn','0','1');
insert into eWebEditor_Button values ('FindReplace','�����滻','findreplace.gif',null,'0','findReplace()','Btn','45','1');
insert into eWebEditor_Button values ('Flash','����Flash����','flash.gif',null,'0','ShowDialog(''dialog/flash.htm'', 350, 200, true)','Btn','91','1');
insert into eWebEditor_Button values ('FontMenu','����˵�','fontmenu.gif',null,'0','showToolMenu(''font'')','Btn','0','1');
insert into eWebEditor_Button values ('FontName','����',null,'<option selected>����</option>
<option value="����">����</option>
<option value="����">����</option>
<option value="����_GB2312">����</option>
<option value="����_GB2312">����</option>
<option value="����">����</option>
<option value="��Բ">��Բ</option>
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
insert into eWebEditor_Button values ('FontSize','�����С',null,'<option selected>�ֺ�</option>
<option value="7">һ��</option>
<option value="6">����</option>
<option value="5">����</option>
<option value="4">�ĺ�</option>
<option value="3">���</option>
<option value="2">����</option>
<option value="1">�ߺ�</option>','1','format(''fontsize'',this[this.selectedIndex].value);this.selectedIndex=0','TBGen','6','1');
insert into eWebEditor_Button values ('ForeColor','������ɫ','forecolor.gif',null,'0','ShowDialog(''dialog/selcolor.htm?action=forecolor'', 280, 250, true)','Btn','21','1');
insert into eWebEditor_Button values ('FormatBlock','������ʽ',null,'<option selected>������ʽ</option>
<option value="&lt;P&gt;">��ͨ</option>
<option value="&lt;H1&gt;">����һ</option>
<option value="&lt;H2&gt;">�����</option>
<option value="&lt;H3&gt;">������</option>
<option value="&lt;H4&gt;">������</option>
<option value="&lt;H5&gt;">������</option>
<option value="&lt;H6&gt;">������</option>
<option value="&lt;p&gt;">����</option>
<option value="&lt;dd&gt;">����</option>
<option value="&lt;dt&gt;">���ﶨ��</option>
<option value="&lt;dir&gt;">Ŀ¼�б�</option>
<option value="&lt;menu&gt;">�˵��б�</option>
<option value="&lt;PRE&gt;">�ѱ��Ÿ�ʽ</option>','1','format(''FormatBlock'',this[this.selectedIndex].value);this.selectedIndex=0','TBGen','8','1');
insert into eWebEditor_Button values ('FormButton','���밴ť','FormButton.gif',null,'0','format(''InsertButton'')','Btn','76','1');
insert into eWebEditor_Button values ('FormCheckbox','���븴ѡ��','FormCheckbox.gif',null,'0','ShowDialog(''dialog/checkbox.htm'', 350, 200, true)','Btn','74','1');
insert into eWebEditor_Button values ('FormDropdown','����������','FormDropdown.gif',null,'0','format(''InsertSelectDropdown'')','Btn','75','1');
insert into eWebEditor_Button values ('FormMenu','�����˵�','FormMenu.gif',null,'0','showToolMenu(''form'')','Btn','70','1');
insert into eWebEditor_Button values ('FormRadio','���뵥ѡť','FormRadio.gif',null,'0','ShowDialog(''dialog/radio.htm'', 350, 200, true)','Btn','73','1');
insert into eWebEditor_Button values ('FormText','���������','FormText.gif',null,'0','format(''InsertInputText'')','Btn','71','1');
insert into eWebEditor_Button values ('FormTextArea','��������������','FormTextArea.gif',null,'0','format(''InsertTextArea'')','Btn','72','1');
insert into eWebEditor_Button values ('Help','�鿴ʹ�ð���','help.gif',null,'0','ShowDialog(''dialog/help.htm'',''400'',''300'')','Btn','205','1');
insert into eWebEditor_Button values ('HorizontalRule','����ˮƽ��','InsertHorizontalRule.gif',null,'0','format(''InsertHorizontalRule'')','Btn','81','1');
insert into eWebEditor_Button values ('Iframe','������޸���ҳ֡','iframe.gif',null,'0','ShowDialog(''dialog/iframe.htm'', 350, 200, true)','Btn','89','1');
insert into eWebEditor_Button values ('Image','������޸�ͼƬ','img.gif',null,'0','ShowDialog(''dialog/img.htm'', 350, 315, true)','Btn','90','1');
insert into eWebEditor_Button values ('Indent','����������','indent.gif',null,'0','format(''indent'')','Btn','19','1');
insert into eWebEditor_Button values ('Italic','б��','italic.gif',null,'0','format(''italic'')','Btn','10','1');
insert into eWebEditor_Button values ('JustifyCenter','���ж���','JustifyCenter.gif',null,'0','format(''justifycenter'')','Btn','14','1');
insert into eWebEditor_Button values ('JustifyFull','���˶���','JustifyFull.gif',null,'0','format(''JustifyFull'')','Btn','16','1');
insert into eWebEditor_Button values ('JustifyLeft','�����','JustifyLeft.gif',null,'0','format(''justifyleft'')','Btn','13','1');
insert into eWebEditor_Button values ('JustifyRight','�Ҷ���','JustifyRight.gif',null,'0','format(''justifyright'')','Btn','15','1');
insert into eWebEditor_Button values ('Map','ͼ���ȵ�����','map.gif',null,'0','mapEdit()','Btn','86','1');
insert into eWebEditor_Button values ('Marquee','������޸���Ļ','Marquee.gif',null,'0','ShowDialog(''dialog/marquee.htm'', 395, 150, true)','Btn','80','1');
insert into eWebEditor_Button values ('Maximize','ȫ���༭','maximize.gif',null,'0','Maximize()','Btn','130','1');
insert into eWebEditor_Button values ('Media','�����Զ����ŵ�ý���ļ�','Media.gif',null,'0','ShowDialog(''dialog/media.htm'', 350, 200, true)','Btn','92','1');
insert into eWebEditor_Button values ('Minimize','ȫ������','minimize.gif',null,'0','parent.Minimize()','Btn','131','0');
insert into eWebEditor_Button values ('ModeCode','����״̬','modecodebtn.gif',null,'0','setMode(''CODE'')','Btn','200','1');
insert into eWebEditor_Button values ('ModeEdit','�༭״̬','modeeditbtn.gif',null,'0','setMode(''EDIT'')','Btn','201','1');
insert into eWebEditor_Button values ('ModeText','�ı�״̬','modetextbtn.gif',null,'0','setMode(''TEXT'')','Btn','202','1');
insert into eWebEditor_Button values ('ModeView','Ԥ��״̬','modeviewbtn.gif',null,'0','setMode(''VIEW'')','Btn','203','1');
insert into eWebEditor_Button values ('NowDate','���뵱ǰ����','date.gif',null,'0','insert(''nowdate'')','Btn','103','1');
insert into eWebEditor_Button values ('ObjectMenu','����Ч���˵�','objectmenu.gif',null,'0','showToolMenu(''object'')','Btn','0','1');
insert into eWebEditor_Button values ('OrderedList','���','insertorderedlist.gif',null,'0','format(''insertorderedlist'')','Btn','17','1');
insert into eWebEditor_Button values ('Outdent','����������','outdent.gif',null,'0','format(''outdent'')','Btn','20','1');
insert into eWebEditor_Button values ('Paragraph','�������','InsertParagraph.gif',null,'0','format(''InsertParagraph'')','Btn','83','1');
insert into eWebEditor_Button values ('ParagraphMenu','����˵�','ParagraphMenu.gif',null,'0','showToolMenu(''paragraph'')','Btn','0','1');
insert into eWebEditor_Button values ('Paste','����ճ��','paste.gif',null,'0','format(''paste'')','Btn','42','1');
insert into eWebEditor_Button values ('PasteText','���ı�ճ��','pastetext.gif',null,'0','PasteText()','Btn','43','1');
insert into eWebEditor_Button values ('PasteWord','��Word��ճ��','pasteword.gif',null,'0','PasteWord()','Btn','44','1');
insert into eWebEditor_Button values ('Print','��ӡ','print.gif',null,'0','format(''Print'')','Btn','204','1');
insert into eWebEditor_Button values ('Quote','������ʽ','quote.gif',null,'0','insert(''quote'')','Btn','110','1');
insert into eWebEditor_Button values ('ReDo','�ָ�','redo.gif',null,'0','goHistory(1)','Btn','28','1');
insert into eWebEditor_Button values ('Refresh','�½�','refresh.gif',null,'0','format(''refresh'')','Btn','114','1');
insert into eWebEditor_Button values ('RemoteUpload','Զ���Զ��ϴ�','remoteupload.gif',null,'0','remoteUpload()','Btn','133','1');
insert into eWebEditor_Button values ('RemoveFormat','ɾ�����ָ�ʽ','RemoveFormat.gif',null,'0','format(''RemoveFormat'')','Btn','47','1');
insert into eWebEditor_Button values ('Save','���沢����','save.gif',null,'0','parent.doSave()','Btn','132','1');
insert into eWebEditor_Button values ('SelectAll','ȫ��ѡ��','selectAll.gif',null,'0','format(''SelectAll'')','Btn','29','1');
insert into eWebEditor_Button values ('ShowBorders','��ʾ������ָ������','ShowBorders.gif',null,'0','showBorders()','Btn','112','1');
insert into eWebEditor_Button values ('Site','eWebEditorվ��','site.gif',null,'0','window.open(''http://ewebeditor.webasp.net'')','Btn','207','1');
insert into eWebEditor_Button values ('SizeMinus','��С�༭��','sizeminus.gif',null,'0','sizeChange(-300)','Btn','121','1');
insert into eWebEditor_Button values ('SizePlus','���߱༭��','sizeplus.gif',null,'0','sizeChange(300)','Btn','120','1');
insert into eWebEditor_Button values ('Small','�����С','tosmall.gif',null,'0','insert(''small'')','Btn','7','1');
insert into eWebEditor_Button values ('Space','�ո�',null,'&nbsp;','2',null,'TBGen','3','1');
insert into eWebEditor_Button values ('SpellCheck','ƴд���','spellCheck.gif',null,'0','spellCheck()','Btn','0','0');
insert into eWebEditor_Button values ('StrikeThrough','�л���','strikethrough.gif',null,'0','format(''StrikeThrough'')','Btn','12','1');
insert into eWebEditor_Button values ('SubScript','�±�','subscript.gif',null,'0','format(''subscript'')','Btn','26','1');
insert into eWebEditor_Button values ('SuperScript','�ϱ�','superscript.gif',null,'0','format(''superscript'')','Btn','25','1');
insert into eWebEditor_Button values ('Symbol','���������ַ�','symbol.gif',null,'0','ShowDialog(''dialog/symbol.htm'', 350, 220, true)','Btn','101','1');
insert into eWebEditor_Button values ('TableCellProp','��Ԫ������','TableCellProp.gif',null,'0','TableCellProp()','Btn','53','1');
insert into eWebEditor_Button values ('TableCellSplit','��ֵ�Ԫ��','TableCellSplit.gif',null,'0','TableCellSplit()','Btn','54','1');
insert into eWebEditor_Button values ('TableColDelete','ɾ����','TableColDelete.gif',null,'0','TableColDelete()','Btn','65','1');
insert into eWebEditor_Button values ('TableColInsertLeft','�����У�����ࣩ','TableColInsertLeft.gif',null,'0','TableColInsertLeft()','Btn','61','1');
insert into eWebEditor_Button values ('TableColInsertRight','�����У����Ҳࣩ','TableColInsertRight.gif',null,'0','TableColInsertRight()','Btn','62','1');
insert into eWebEditor_Button values ('TableColMerge','�ϲ��У����Ҳࣩ','TableColMerge.gif',null,'0','TableColMerge()','Btn','63','1');
insert into eWebEditor_Button values ('TableColSplit','�����','TableColSplit.gif',null,'0','TableColSplit(2)','Btn','64','1');
insert into eWebEditor_Button values ('TableInsert','�������','tableinsert.gif',null,'0','TableInsert()','Btn','51','1');
insert into eWebEditor_Button values ('TableMenu','����˵�','tablemenu.gif',null,'0','showToolMenu(''table'')','Btn','50','1');
insert into eWebEditor_Button values ('TableProp','�޸ı�������','tableProp.gif',null,'0','TableProp()','Btn','52','1');
insert into eWebEditor_Button values ('TableRowDelete','ɾ����','TableRowDelete.gif',null,'0','TableRowDelete()','Btn','60','1');
insert into eWebEditor_Button values ('TableRowInsertAbove','�����У����Ϸ���','TableRowInsertAbove.gif',null,'0','TableRowInsertAbove()','Btn','56','1');
insert into eWebEditor_Button values ('TableRowInsertBelow','�����У����·���','TableRowInsertBelow.gif',null,'0','TableRowInsertBelow()','Btn','57','1');
insert into eWebEditor_Button values ('TableRowMerge','�ϲ��У����·���','TableRowMerge.gif',null,'0','TableRowMerge()','Btn','58','1');
insert into eWebEditor_Button values ('TableRowProp','����������','TableRowProp.gif',null,'0','TableRowProp()','Btn','55','1');
insert into eWebEditor_Button values ('TableRowSplit','�����','TableRowSplit.gif',null,'0','TableRowSplit(2)','Btn','59','1');
insert into eWebEditor_Button values ('TBHandle','������ͷ',null,null,'2',null,'TBHandle','2','1');
insert into eWebEditor_Button values ('TBSep','�ָ���',null,null,'2',null,'TBSep','1','1');
insert into eWebEditor_Button values ('ToolMenu','���߲˵�','toolmenu.gif',null,'0','showToolMenu(''tool'')','Btn','0','1');
insert into eWebEditor_Button values ('UnderLine','�»���','underline.gif',null,'0','format(''underline'')','Btn','11','1');
insert into eWebEditor_Button values ('UnDo','����','undo.gif',null,'0','goHistory(-1)','Btn','27','1');
insert into eWebEditor_Button values ('Unlink','ȡ���������ӻ��ǩ','Unlink.gif',null,'0','format(''UnLink'')','Btn','85','1');
insert into eWebEditor_Button values ('UnOrderedList','��Ŀ����','insertunorderedlist.gif',null,'0','format(''insertunorderedlist'')','Btn','18','1');
insert into eWebEditor_Button values ('UnSelect','ȡ��ѡ��','unselect.gif',null,'0','format(''Unselect'')','Btn','30','1');
insert into eWebEditor_Button values ('zIndexBackward','����һ��','backward.gif',null,'0','zIndex(''backward'')','Btn','116','1');
insert into eWebEditor_Button values ('zIndexForward','����һ��','forward.gif',null,'0','zIndex(''forward'')','Btn','117','1');
insert into eWebEditor_Button values ('ZoomMenu','���Ų˵�','zoommenu.gif',null,'0','showToolMenu(''zoom'')','Btn','114','1');
insert into eWebEditor_Button values ('ZoomSelect','����������',null,'<option value="10">10%</option>
<option value="25">25%</option>
<option value="50">50%</option>
<option value="75">75%</option>
<option value="100" selected>100%</option>
<option value="150">150%</option>
<option value="200">200%</option>
<option value="500">500%</option>','1','doZoom(this[this.selectedIndex].value)','TBGen','113','1');
insert into eWebEditor_Button values ('Favorite','�����ղر�ҳ����','Favorite.gif',null,'0','insert(''favorite'')','Btn','208','1');
insert into eWebEditor_Button values ('NowTime','���뵱ǰʱ��','time.gif',null,'0','insert(''nowtime'')','Btn','104','1');
insert into eWebEditor_Button values ('AutoFormat','�Զ��Ű�','AutoFormat.gif',null,'0','AutoFormat()','Btn','209','1');


set identity_insert eWebEditor_Style on;
insert into eWebEditor_Style(S_ID,S_Name,S_Dir,S_CSS,S_UploadDir,S_Width,S_Height,S_Memo,S_IsSys,S_FileExt,S_FlashExt,S_ImageExt,S_MediaExt,S_RemoteExt,S_FileSize,S_FlashSize,S_ImageSize,S_MediaSize,S_RemoteSize,S_StateFlag,S_DetectFromWord,S_InitMode,S_BaseUrl,S_UploadObject,S_AutoDir,S_BaseHref,S_ContentPath,S_AutoRemote,S_ShowBorder) values ('14','standard','standard','office','/Upload/','550','350','Office��׼��񣬲��ֳ��ð�ť����׼�ʺϽ�����ȣ�Ĭ����ʽ','0','rar|zip|doc|pdf|chm|hlp','swf','gif|jpg|jpeg|bmp|png','rm|ra|avi|mpg|mpeg|asf|asx|mov|wmv','gif|jpg|jpeg|bmp|png','2000','1000','1000','2000','500','1','true','EDIT','1','0','2','','','1','0');
insert into eWebEditor_Style(S_ID,S_Name,S_Dir,S_CSS,S_UploadDir,S_Width,S_Height,S_Memo,S_IsSys,S_FileExt,S_FlashExt,S_ImageExt,S_MediaExt,S_RemoteExt,S_FileSize,S_FlashSize,S_ImageSize,S_MediaSize,S_RemoteSize,S_StateFlag,S_DetectFromWord,S_InitMode,S_BaseUrl,S_UploadObject,S_AutoDir,S_BaseHref,S_ContentPath,S_AutoRemote,S_ShowBorder) values ('15','member','standard','blue','/Upload/','550','350','Office��׼��񣬲��ֳ��ð�ť����׼�ʺϽ�����ȣ�Ĭ����ʽ','0','rar|zip|doc|pdf|chm|hlp','swf','gif|jpg|jpeg|bmp|png','rm|ra|avi|mpg|mpeg|asf|asx|mov|wmv','gif|jpg|jpeg|bmp|png','2000','1000','1000','2000','500','1','true','EDIT','1','0','2',null,null,'1','0');
insert into eWebEditor_Style(S_ID,S_Name,S_Dir,S_CSS,S_UploadDir,S_Width,S_Height,S_Memo,S_IsSys,S_FileExt,S_FlashExt,S_ImageExt,S_MediaExt,S_RemoteExt,S_FileSize,S_FlashSize,S_ImageSize,S_MediaSize,S_RemoteSize,S_StateFlag,S_DetectFromWord,S_InitMode,S_BaseUrl,S_UploadObject,S_AutoDir,S_BaseHref,S_ContentPath,S_AutoRemote,S_ShowBorder) values ('16','music','standard','office','/Upload/','550','350','Office��׼��񣬲��ֳ��ð�ť����׼�ʺϽ�����ȣ�Ĭ����ʽ','0','rar|zip|doc|pdf|chm|hlp','swf','gif|jpg|jpeg|bmp|png','rm|ram|mp3|wma|wmv|flv','gif|jpg|jpeg|bmp|png','2000','1000','1000','10000','500','1','true','EDIT','1','0','2',null,null,'1','0');
set identity_insert eWebEditor_Style off;

set identity_insert eWebEditor_ToolBar on;
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('47','14','��ʽ������','1','TBHandle|FormatBlock|FontName|FontSize|ZoomSelect|Bold|Italic|UnderLine|StrikeThrough|SuperScript|SubScript|TBSep|JustifyLeft|JustifyCenter|JustifyRight|JustifyFull');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('48','14','���ù�����','2','TBHandle|Cut|Copy|Paste|PasteText|PasteWord|TBSep|FindReplace|Delete|RemoveFormat|TBSep|UnDo|ReDo|TBSep|SelectAll|UnSelect|TBSep|OrderedList|UnOrderedList|Indent|Outdent|TBSep|ForeColor|BgColor|BackColor|BackImage|TBSep|absolutePosition|zIndexForward|zIndexBackward');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('49','14','�߼�������','3','TBHandle|Image|Flash|Media|File|TBSep|TableMenu|ShowBorders|TBSep|Fieldset|Iframe|HorizontalRule|Marquee|TBSep|CreateLink|Map|Unlink|TBSep|Symbol|Emot|Excel|NowDate|NowTime|TBSep|Quote|TBSep|Maximize|RemoteUpload|AutoFormat|Favorite');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('50','15','��ʽ������','1','TBHandle|FormatBlock|FontName|FontSize|ZoomSelect|Bold|Italic|UnderLine|StrikeThrough|SuperScript|SubScript|TBSep|JustifyLeft|JustifyCenter|JustifyRight|JustifyFull');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('51','15','���ù�����','2','TBHandle|Cut|Copy|Paste|PasteText|PasteWord|TBSep|FindReplace|Delete|RemoveFormat|TBSep|UnDo|ReDo|TBSep|SelectAll|UnSelect|TBSep|OrderedList|UnOrderedList|Indent|Outdent|TBSep|ForeColor|BgColor|BackColor|BackImage|TBSep|absolutePosition|zIndexForward|zIndexBackward');
insert into eWebEditor_ToolBar(T_ID,S_ID,T_Name,T_Order,T_Button) values ('52','15','�߼�������','3','TBHandle|Image|Flash|Media|File|TBSep|TableMenu|ShowBorders|TBSep|Fieldset|Iframe|HorizontalRule|Marquee|TBSep|CreateLink|Map|Unlink|TBSep|Symbol|Emot|Excel|NowDate|NowTime|TBSep|Quote|TBSep|Maximize|RemoteUpload|AutoFormat|Favorite');
set identity_insert eWebEditor_ToolBar off;