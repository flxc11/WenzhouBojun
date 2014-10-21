var dialog		= window.parent ;
var oEditor		= dialog.InnerDialogLoaded() ;
var FCK			= oEditor.FCK ;
var FCKLang		= oEditor.FCKLang ;
var FCKConfig	= oEditor.FCKConfig ;
var FCKDebug	= oEditor.FCKDebug ;
var FCKTools	= oEditor.FCKTools ;

dialog.AddTab('Info',FCKLang.DlgFileInfoTab);
dialog.AddTab('Upload',FCKLang.DlgFileUploadTab);

if (FCKConfig.FileBrowser)
	dialog.AddTab('FileBrowser',FCKLang.DlgFileBrowserTag);

function OnDialogTabChange(tabCode)
{
	ShowE('divInfo', (tabCode == 'Info'));
	ShowE('divFileBrowser',(tabCode =='FileBrowser'));
	ShowE('divUpload',(tabCode =='Upload'));
}

window.onload = function()
{
	oEditor.FCKLanguageManager.TranslatePage(document);
	GetE('tdBrowse').style.display = FCKConfig.FileBrowser	? '' : 'none' ;
	if (FCKConfig.FileBrowser)
		GetE('iframeFileBrowser').src=FCKConfig.FileBrowserURL;
	GetE('frmUpload').action = FCKConfig.FileUploadURL;
	dialog.SetAutoSize(true);
	dialog.SetOkButton(true);
}

function BrowseServer()
{
	dialog.SetSelectedTab('FileBrowser');
}

function SetUrl(url,width,height,alt)
{
	GetE('txtUrl').value = url;
	dialog.SetSelectedTab('Info');
}

function OnUploadCompleted( errorNumber, fileUrl,fileName,customMsg)
{
	window.parent.Throbber.Hide() ;
	GetE('divUpload').style.display  = '' ;

	switch (errorNumber)
	{
		case 0 :
			alert('\u6587\u4ef6\u4e0a\u4f20\u64cd\u4f5c\u6210\u529f');
			break ;
		case 1 :	// Custom error
			alert(customMsg);
			return ;
		case 101 :	// Custom warning
			alert(customMsg);
			break ;
		case 201 :
			alert('\u6709\u540c\u540d\u6587\u4ef6\u5b58\u5728\uff0c\u6587\u4ef6\u88ab\u81ea\u52a8\u91cd\u547d\u540d\u6210"'+fileName+'"');
			break ;
		case 202 :
			alert('\u4e0d\u652f\u6301\u4e0a\u4f20\u8be5\u6587\u4ef6\u683c\u5f0f');
			return ;
		case 203 :
			alert("\u4e0a\u4f20\u5931\u8d25\uff0c\u8bf7\u68c0\u67e5\u670d\u52a1\u5668\u5b89\u5168\u8bbe\u7f6e");
			return ;
		case 500 :
			alert('\u4e0a\u4f20\u63a5\u53e3\u672a\u542f\u7528');
			break ;
		default :
			alert('\u4e0a\u4f20\u5931\u8d25\uff0c\u9519\u8bef\u539f\u56e0\uff1a'+errorNumber);
			return ;
	}

	sActualBrowser = '';
	SetUrl(fileUrl);
	GetE('frmUpload').reset();
}

var oUploadAllowedExtRegex	= new RegExp( FCKConfig.FileUploadAllowedExtensions, 'i' ) ;
var oUploadDeniedExtRegex	= new RegExp( FCKConfig.FileUploadDeniedExtensions, 'i' ) ;

function CheckUpload()
{
	var sFile = GetE('txtUploadFile0').value;
	if (sFile.length == 0)
	{
		alert('\u8bf7\u9009\u62e9\u9700\u8981\u4e0a\u4f20\u7684\u6587\u4ef6\u3002');
		return false ;
	}

	if ((FCKConfig.FileUploadAllowedExtensions.length > 0 && !oUploadAllowedExtRegex.test(sFile))||
		(FCKConfig.FileUploadDeniedExtensions.length > 0 && oUploadDeniedExtRegex.test(sFile)))
	{
		OnUploadCompleted(202);
		return false ;
	}

	window.parent.Throbber.Show(100);
	GetE('divUpload').style.display ='none';
	return true ;
}

function Ok()
{   
	oEditor.FCKUndo.SaveUndoStep();	
	var oName=GetE('txtFileName').value;
	var oUrl=GetE('txtUrl').value;
	if (oUrl.length == 0)
	{
		GetE('txtUrl').focus();
		alert('\u94fe\u63a5\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a');
		return false ;
	}
	var FilePath = GetE('txtUrl').value;
	var str= new Array();
	str=FilePath.split("|");
	for (i=0;i<str.length ;i++)
	{
		if (oName.length == 0){oName=str[i];}
		var oLink=oEditor.FCK.InsertElement('a');
		oLink.href = str[i];
		oLink.innerHTML=oName;
		//SetAttribute(oLink,'target','_blank');
	}
	//oEditor.FCKSelection.SelectNode(oLink);
	return true ;
}
