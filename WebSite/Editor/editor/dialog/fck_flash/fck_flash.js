var dialog		= window.parent ;
var oEditor		= dialog.InnerDialogLoaded() ;
var FCK			= oEditor.FCK ;
var FCKLang		= oEditor.FCKLang ;
var FCKConfig	= oEditor.FCKConfig ;
var FCKTools	= oEditor.FCKTools ;

dialog.AddTab('Info',oEditor.FCKLang.DlgFlashInfoTab);

if (FCKConfig.FlashUpload)
	dialog.AddTab('Upload', FCKLang.DlgLnkUpload);

if (FCKConfig.FlashBrowser)
	dialog.AddTab('FlashBrowser', oEditor.FCKLang.DlgFlashBrowserTag);

if (!FCKConfig.FlashDlgHideAdvanced)
	dialog.AddTab('Advanced', oEditor.FCKLang.DlgAdvancedTag);

function OnDialogTabChange(tabCode)
{
	ShowE('divInfo'		, (tabCode == 'Info'));
	ShowE('divUpload'	, (tabCode == 'Upload'));
	ShowE('divAdvanced'	, (tabCode == 'Advanced'));
	ShowE('divFlashBrowser'	, (tabCode == 'FlashBrowser'));
}

var oFakeImage = dialog.Selection.GetSelectedElement() ;
var oEmbed ;

if ( oFakeImage )
{
	if ( oFakeImage.tagName == 'IMG' && oFakeImage.getAttribute('_fckflash') )
		oEmbed = FCK.GetRealElement( oFakeImage ) ;
	else
		oFakeImage = null ;
}

window.onload = function()
{
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	LoadSelection() ;
	GetE('tdBrowse').style.display = FCKConfig.FlashBrowser	? '' : 'none' ;
	if (FCKConfig.FlashUpload)
		GetE('frmUpload').action = FCKConfig.FlashUploadURL;
	if (FCKConfig.FlashBrowser)
		GetE('iframeFlashBrowser').src=FCKConfig.FlashBrowserURL;
	dialog.SetAutoSize(true);
	dialog.SetOkButton(true);
	SelectField('txtUrl');
}

function LoadSelection()
{
	if ( ! oEmbed ) return ;

	GetE('txtUrl').value    = GetAttribute( oEmbed, 'src', '' ) ;
	GetE('txtWidth').value  = GetAttribute( oEmbed, 'width', '' ) ;
	GetE('txtHeight').value = GetAttribute( oEmbed, 'height', '' ) ;

	// Get Advances Attributes
	GetE('txtAttId').value		= oEmbed.id ;
	GetE('chkAutoPlay').checked	= GetAttribute( oEmbed, 'play', 'true' ) == 'true' ;
	GetE('chkLoop').checked		= GetAttribute( oEmbed, 'loop', 'true' ) == 'true' ;
	GetE('chkMenu').checked		= GetAttribute( oEmbed, 'menu', 'true' ) == 'true' ;
	GetE('cmbScale').value		= GetAttribute( oEmbed, 'scale', '' ).toLowerCase() ;

	GetE('txtAttTitle').value		= oEmbed.title ;

	if ( oEditor.FCKBrowserInfo.IsIE )
	{
		GetE('txtAttClasses').value = oEmbed.getAttribute('className') || '' ;
		GetE('txtAttStyle').value = oEmbed.style.cssText ;
	}
	else
	{
		GetE('txtAttClasses').value = oEmbed.getAttribute('class',2) || '' ;
		GetE('txtAttStyle').value = oEmbed.getAttribute('style',2) || '' ;
	}

	UpdatePreview() ;
}

//#### The OK button was hit.
function Ok()
{
	if ( GetE('txtUrl').value.length == 0 )
	{
		dialog.SetSelectedTab( 'Info' ) ;
		GetE('txtUrl').focus() ;

		alert( oEditor.FCKLang.DlgAlertUrl ) ;

		return false ;
	}

	oEditor.FCKUndo.SaveUndoStep() ;
	if ( !oEmbed )
	{
		oEmbed		= FCK.EditorDocument.createElement( 'EMBED' ) ;
		oFakeImage  = null ;
	}
	UpdateEmbed( oEmbed ) ;

	if ( !oFakeImage )
	{
		oFakeImage	= oEditor.FCKDocumentProcessor_CreateFakeImage( 'FCK__Flash', oEmbed ) ;
		oFakeImage.setAttribute( '_fckflash', 'true', 0 ) ;
		oFakeImage	= FCK.InsertElement( oFakeImage ) ;
	}

	oEditor.FCKEmbedAndObjectProcessor.RefreshView( oFakeImage, oEmbed ) ;

	return true ;
}

function UpdateEmbed( e )
{
	SetAttribute( e, 'type'			, 'application/x-shockwave-flash' ) ;
	SetAttribute( e, 'pluginspage'	, 'http://www.macromedia.com/go/getflashplayer' ) ;

	SetAttribute( e, 'src', GetE('txtUrl').value ) ;
	SetAttribute( e, "width" , GetE('txtWidth').value ) ;
	SetAttribute( e, "height", GetE('txtHeight').value ) ;

	// Advances Attributes

	SetAttribute( e, 'id'	, GetE('txtAttId').value ) ;
	SetAttribute( e, 'scale', GetE('cmbScale').value ) ;

	SetAttribute( e, 'play', GetE('chkAutoPlay').checked ? 'true' : 'false' ) ;
	SetAttribute( e, 'loop', GetE('chkLoop').checked ? 'true' : 'false' ) ;
	SetAttribute( e, 'menu', GetE('chkMenu').checked ? 'true' : 'false' ) ;

	SetAttribute( e, 'title'	, GetE('txtAttTitle').value ) ;

	if ( oEditor.FCKBrowserInfo.IsIE )
	{
		SetAttribute( e, 'className', GetE('txtAttClasses').value ) ;
		e.style.cssText = GetE('txtAttStyle').value ;
	}
	else
	{
		SetAttribute( e, 'class', GetE('txtAttClasses').value ) ;
		SetAttribute( e, 'style', GetE('txtAttStyle').value ) ;
	}
}

var ePreview ;

function SetPreviewElement( previewEl )
{
	ePreview = previewEl ;

	if ( GetE('txtUrl').value.length > 0 )
		UpdatePreview() ;
}

function UpdatePreview()
{
	if ( !ePreview )
		return ;

	while ( ePreview.firstChild )
		ePreview.removeChild( ePreview.firstChild ) ;

	if ( GetE('txtUrl').value.length == 0 )
		ePreview.innerHTML = '&nbsp;' ;
	else
	{
		var oDoc	= ePreview.ownerDocument || ePreview.document ;
		var e		= oDoc.createElement( 'EMBED' ) ;

		SetAttribute( e, 'src', GetE('txtUrl').value ) ;
		SetAttribute( e, 'type', 'application/x-shockwave-flash' ) ;
		SetAttribute( e, 'width', '100%' ) ;
		SetAttribute( e, 'height', '100%' ) ;

		ePreview.appendChild( e ) ;
	}
}

// <embed id="ePreview" src="fck_flash/claims.swf" width="100%" height="100%" style="visibility:hidden" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">

function BrowseServer()
{
	dialog.SetSelectedTab('FlashBrowser');
}

function SetUrl( url, width, height )
{
	GetE('txtUrl').value = url ;

	if ( width )
		GetE('txtWidth').value = width ;

	if ( height )
		GetE('txtHeight').value = height ;

	UpdatePreview() ;

	dialog.SetSelectedTab( 'Info' ) ;
}

function OnUploadCompleted( errorNumber, fileUrl, fileName, customMsg )
{
	// Remove animation
	window.parent.Throbber.Hide() ;
	GetE( 'divUpload' ).style.display  = '' ;

	switch ( errorNumber )
	{
		case 0 :
			alert('\u6587\u4ef6\u4e0a\u4f20\u64cd\u4f5c\u6210\u529f');
			break ;
		case 1 :
			alert(customMsg);
			return ;
		case 101 :
			alert(customMsg);
			break ;
		case 201 :
			alert('\u6709\u540c\u540d\u6587\u4ef6\u5b58\u5728\uff0c\u6587\u4ef6\u88ab\u81ea\u52a8\u91cd\u547d\u540d\u6210"' + fileName + '"');
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
			alert('\u4e0a\u4f20\u5931\u8d25\uff0c\u9519\u8bef\u539f\u56e0\uff1a' + errorNumber);
			return ;
	}
	SetUrl( fileUrl ) ;
	GetE('frmUpload').reset() ;
}

var oUploadAllowedExtRegex	= new RegExp( FCKConfig.FlashUploadAllowedExtensions, 'i' ) ;
var oUploadDeniedExtRegex	= new RegExp( FCKConfig.FlashUploadDeniedExtensions, 'i' ) ;

function CheckUpload()
{
	var sFile = GetE('txtUploadFile').value ;

	if ( sFile.length == 0 )
	{
		alert( 'Please select a file to upload' ) ;
		return false ;
	}

	if ( ( FCKConfig.FlashUploadAllowedExtensions.length > 0 && !oUploadAllowedExtRegex.test( sFile ) ) ||
		( FCKConfig.FlashUploadDeniedExtensions.length > 0 && oUploadDeniedExtRegex.test( sFile ) ) )
	{
		OnUploadCompleted( 202 ) ;
		return false ;
	}

	window.parent.Throbber.Show( 100 ) ;
	GetE( 'divUpload' ).style.display  = 'none' ;

	return true ;
}
