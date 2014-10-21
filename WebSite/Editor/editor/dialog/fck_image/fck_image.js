var dialog		= window.parent ;
var oEditor		= dialog.InnerDialogLoaded() ;
var FCK			= oEditor.FCK ;
var FCKLang		= oEditor.FCKLang ;
var FCKConfig	= oEditor.FCKConfig ;
var FCKDebug	= oEditor.FCKDebug ;
var FCKTools	= oEditor.FCKTools ;

var bImageButton = ( document.location.search.length > 0 && document.location.search.substr(1) == 'ImageButton' ) ;

dialog.AddTab('Info',FCKLang.DlgImgInfoTab);
	
if (FCKConfig.ImageUpload)
	dialog.AddTab('Upload',FCKLang.DlgLnkUpload);
	
if (FCKConfig.ImageBrowser)
	dialog.AddTab('ImageBrowser',FCKLang.DlgImageBrowserTag);

function OnDialogTabChange( tabCode )
{
	ShowE('divInfo', (tabCode == 'Info'));
	ShowE('divUpload',( tabCode == 'Upload')) ;
	ShowE('divImageBrowser',(tabCode =='ImageBrowser'));
}

var oImage = dialog.Selection.GetSelectedElement() ;
if ( oImage && oImage.tagName != 'IMG' && !( oImage.tagName == 'INPUT' && oImage.type == 'image' ) )
	oImage = null ;
var oLink = dialog.Selection.GetSelection().MoveToAncestorNode( 'A' ) ;
var oImageOriginal ;

function UpdateOriginal( resetSize )
{
	if ( !eImgPreview )
		return ;

	if ( GetE('txtUrl').value.length == 0 )
	{
		oImageOriginal = null ;
		return ;
	}

	oImageOriginal = document.createElement( 'IMG' ) ;	// new Image() ;

	if ( resetSize )
	{
		oImageOriginal.onload = function()
		{
			this.onload = null ;
			ResetSizes() ;
		}
	}

	oImageOriginal.src = eImgPreview.src ;
}

var bPreviewInitialized ;

window.onload = function()
{
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	GetE('btnLockSizes').title = FCKLang.DlgImgLockRatio ;
	GetE('btnResetSize').title = FCKLang.DlgBtnResetSize ;
	LoadSelection() ;
	GetE('tdBrowse').style.display				= FCKConfig.ImageBrowser	? '' : 'none' ;
	GetE('divLnkBrowseServer').style.display	= FCKConfig.LinkBrowser		? '' : 'none' ;
	UpdateOriginal() ;
	if (FCKConfig.ImageUpload)
		GetE('frmUpload').action = FCKConfig.ImageUploadURL;
	if (FCKConfig.ImageBrowser)
		GetE('iframeImageBrowser').src=FCKConfig.ImageBrowserURL;
	dialog.SetAutoSize(true);
	dialog.SetOkButton(true);
	SelectField('txtUrl');
}
function LoadSelection()
{
	if (!oImage) return ;
	var sUrl = oImage.getAttribute( '_fcksavedurl' ) ;
	if ( sUrl == null )
		sUrl = GetAttribute( oImage, 'src', '' ) ;
	GetE('txtUrl').value    = sUrl ;
	GetE('txtAlt').value    = GetAttribute( oImage, 'alt', '' ) ;
	GetE('txtVSpace').value	= GetAttribute( oImage, 'vspace', '' ) ;
	GetE('txtHSpace').value	= GetAttribute( oImage, 'hspace', '' ) ;
	GetE('txtBorder').value	= GetAttribute( oImage, 'border', '' ) ;
	GetE('cmbAlign').value	= GetAttribute( oImage, 'align', '' ) ;
	var iWidth, iHeight ;
	var regexSize = /^\s*(\d+)px\s*$/i ;
	if (oImage.style.width)
	{
		var aMatchW  = oImage.style.width.match( regexSize ) ;
		if ( aMatchW )
		{
			iWidth = aMatchW[1] ;
			oImage.style.width = '' ;
			SetAttribute( oImage, 'width' , iWidth ) ;
		}
	}

	if ( oImage.style.height )
	{
		var aMatchH  = oImage.style.height.match( regexSize ) ;
		if ( aMatchH )
		{
			iHeight = aMatchH[1] ;
			oImage.style.height = '' ;
			SetAttribute( oImage, 'height', iHeight ) ;
		}
	}

	GetE('txtWidth').value	= iWidth ? iWidth : GetAttribute( oImage, "width", '' ) ;
	GetE('txtHeight').value	= iHeight ? iHeight : GetAttribute( oImage, "height", '' ) ;

	// Get Advances Attributes
	GetE('txtAttId').value			= oImage.id ;
	GetE('cmbAttLangDir').value		= oImage.dir ;
	GetE('txtAttLangCode').value	= oImage.lang ;
	GetE('txtAttTitle').value		= oImage.title ;
	GetE('txtLongDesc').value		= oImage.longDesc ;

	if ( oEditor.FCKBrowserInfo.IsIE )
	{
		GetE('txtAttClasses').value = oImage.className || '' ;
		GetE('txtAttStyle').value = oImage.style.cssText ;
	}
	else
	{
		GetE('txtAttClasses').value = oImage.getAttribute('class',2) || '' ;
		GetE('txtAttStyle').value = oImage.getAttribute('style',2) ;
	}

	if (oLink)
	{
		var sLinkUrl = oLink.getAttribute('_fcksavedurl');
		if (sLinkUrl == null)
			sLinkUrl = oLink.getAttribute('href',2);

		GetE('txtLnkUrl').value		= sLinkUrl;
		GetE('cmbLnkTarget').value	= oLink.target;
	}
	UpdatePreview() ;
}
function Ok()
{
	if (GetE('txtUrl').value.length == 0)
	{
		dialog.SetSelectedTab('Info');
		GetE('txtUrl').focus();
		alert(FCKLang.DlgImgAlertUrl);
		return false ;
	}
	var FilePath = GetE('txtUrl').value;
	var str= new Array();
	str=FilePath.split("|");
	for (i=0;i<str.length ;i++)
	{
		oImage = FCK.InsertElement('img');
		oImage.src=str[i];
		var sLnkUrl =GetE('txtLnkUrl').value.Trim();
		if ( sLnkUrl.length == 0)
		{
			if (oLink)
				FCK.ExecuteNamedCommand('Unlink');
		}
		else
		{
			if (oLink)
				oLink.href = sLnkUrl;
			else
			{
				if (!bHasImage)
					oEditor.FCKSelection.SelectNode(oImage);
					oLink = oEditor.FCK.CreateLink(sLnkUrl)[0];
				if (!bHasImage)
				{
					oEditor.FCKSelection.SelectNode(oLink);
					oEditor.FCKSelection.Collapse(false);
				}
			}
			SetAttribute( oLink, '_fcksavedurl', sLnkUrl);
			SetAttribute( oLink, 'target', GetE('cmbLnkTarget').value);
		}
		//SetAttribute( oImage, "_fcksavedurl", GetE('txtUrl').value ) ;
		SetAttribute( oImage, "alt"   , GetE('txtAlt').value ) ;
		SetAttribute( oImage, "width" , GetE('txtWidth').value ) ;
		SetAttribute( oImage, "height", GetE('txtHeight').value ) ;
		SetAttribute( oImage, "vspace", GetE('txtVSpace').value ) ;
		SetAttribute( oImage, "hspace", GetE('txtHSpace').value ) ;
		SetAttribute( oImage, "border", GetE('txtBorder').value ) ;
		SetAttribute( oImage, "align" , GetE('cmbAlign').value ) ;
	
		SetAttribute( oImage, 'id', GetE('txtAttId').value ) ;
	
		SetAttribute( oImage, 'dir'		, GetE('cmbAttLangDir').value ) ;
		SetAttribute( oImage, 'lang'		, GetE('txtAttLangCode').value ) ;
		SetAttribute( oImage, 'title'	, GetE('txtAttTitle').value ) ;
		SetAttribute( oImage, 'longDesc'	, GetE('txtLongDesc').value ) ;
	
		if ( oEditor.FCKBrowserInfo.IsIE )
		{
			oImage.className = GetE('txtAttClasses').value ;
			oImage.style.cssText = GetE('txtAttStyle').value ;
		}
		else
		{
			SetAttribute( oImage, 'class'	, GetE('txtAttClasses').value ) ;
			SetAttribute( oImage, 'style', GetE('txtAttStyle').value ) ;
		}
	}
	oEditor.FCKUndo.SaveUndoStep();
	return true ;
}

function UpdateImage(e,skipId)
{
	e.src = GetE('txtUrl').value;
	SetAttribute( e, "_fcksavedurl", GetE('txtUrl').value ) ;
	SetAttribute( e, "alt"   , GetE('txtAlt').value ) ;
	SetAttribute( e, "width" , GetE('txtWidth').value ) ;
	SetAttribute( e, "height", GetE('txtHeight').value ) ;
	SetAttribute( e, "vspace", GetE('txtVSpace').value ) ;
	SetAttribute( e, "hspace", GetE('txtHSpace').value ) ;
	SetAttribute( e, "border", GetE('txtBorder').value ) ;
	SetAttribute( e, "align" , GetE('cmbAlign').value ) ;

	if ( ! skipId )
		SetAttribute( e, 'id', GetE('txtAttId').value ) ;

	SetAttribute( e, 'dir'		, GetE('cmbAttLangDir').value ) ;
	SetAttribute( e, 'lang'		, GetE('txtAttLangCode').value ) ;
	SetAttribute( e, 'title'	, GetE('txtAttTitle').value ) ;
	SetAttribute( e, 'longDesc'	, GetE('txtLongDesc').value ) ;

	if ( oEditor.FCKBrowserInfo.IsIE )
	{
		e.className = GetE('txtAttClasses').value ;
		e.style.cssText = GetE('txtAttStyle').value ;
	}
	else
	{
		SetAttribute( e, 'class'	, GetE('txtAttClasses').value ) ;
		SetAttribute( e, 'style', GetE('txtAttStyle').value ) ;
	}
}

var eImgPreview ;
var eImgPreviewLink ;

function SetPreviewElements( imageElement, linkElement )
{
	eImgPreview = imageElement ;
	eImgPreviewLink = linkElement ;

	UpdatePreview() ;
	UpdateOriginal() ;

	bPreviewInitialized = true ;
}

function UpdatePreview()
{
	if ( !eImgPreview || !eImgPreviewLink )
		return ;

	if ( GetE('txtUrl').value.length == 0 )
		eImgPreviewLink.style.display = 'none' ;
	else
	{
		UpdateImage( eImgPreview, true ) ;

		if ( GetE('txtLnkUrl').value.Trim().length > 0 )
			eImgPreviewLink.href = 'javascript:void(null);' ;
		else
			SetAttribute( eImgPreviewLink, 'href', '' ) ;

		eImgPreviewLink.style.display = '' ;
	}
}

var bLockRatio = true ;

function SwitchLock( lockButton )
{
	bLockRatio = !bLockRatio ;
	lockButton.className = bLockRatio ? 'BtnLocked' : 'BtnUnlocked' ;
	lockButton.title = bLockRatio ? 'Lock sizes' : 'Unlock sizes' ;

	if ( bLockRatio )
	{
		if ( GetE('txtWidth').value.length > 0 )
			OnSizeChanged( 'Width', GetE('txtWidth').value ) ;
		else
			OnSizeChanged( 'Height', GetE('txtHeight').value ) ;
	}
}

// Fired when the width or height input texts change
function OnSizeChanged( dimension, value )
{
	// Verifies if the aspect ration has to be maintained
	if ( oImageOriginal && bLockRatio )
	{
		var e = dimension == 'Width' ? GetE('txtHeight') : GetE('txtWidth') ;

		if ( value.length == 0 || isNaN( value ) )
		{
			e.value = '' ;
			return ;
		}

		if ( dimension == 'Width' )
			value = value == 0 ? 0 : Math.round( oImageOriginal.height * ( value  / oImageOriginal.width ) ) ;
		else
			value = value == 0 ? 0 : Math.round( oImageOriginal.width  * ( value / oImageOriginal.height ) ) ;

		if ( !isNaN( value ) )
			e.value = value ;
	}

	UpdatePreview() ;
}

// Fired when the Reset Size button is clicked
function ResetSizes()
{
	if ( ! oImageOriginal ) return ;
	if ( oEditor.FCKBrowserInfo.IsGecko && !oImageOriginal.complete )
	{
		setTimeout( ResetSizes, 50 ) ;
		return ;
	}

	GetE('txtWidth').value  = oImageOriginal.width ;
	GetE('txtHeight').value = oImageOriginal.height ;

	UpdatePreview() ;
}

function BrowseServer()
{
	dialog.SetSelectedTab('ImageBrowser');
}

function LnkBrowseServer()
{
	OpenServerBrowser(
		'Link',
		FCKConfig.LinkBrowserURL,
		FCKConfig.LinkBrowserWindowWidth,
		FCKConfig.LinkBrowserWindowHeight ) ;
}

function OpenServerBrowser( type, url, width, height )
{
	sActualBrowser = type ;
	OpenFileBrowser( url, width, height ) ;
}

var sActualBrowser ;

function SetUrl(url,width,height,alt)
{
	if (sActualBrowser == 'Link')
	{
		GetE('txtLnkUrl').value = url;
		UpdatePreview() ;
	}
	else
	{
		GetE('txtUrl').value = url ;
		GetE('txtWidth').value = width ? width : '' ;
		GetE('txtHeight').value = height ? height : '' ;

		if (alt)
			GetE('txtAlt').value = alt;

		UpdatePreview();
		UpdateOriginal(true) ;
	}
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

var oUploadAllowedExtRegex	= new RegExp( FCKConfig.ImageUploadAllowedExtensions, 'i' ) ;
var oUploadDeniedExtRegex	= new RegExp( FCKConfig.ImageUploadDeniedExtensions, 'i' ) ;

function CheckUpload()
{
	var sFile = GetE('txtUploadFile0').value;
	if (sFile.length == 0)
	{
		alert('\u8bf7\u9009\u62e9\u9700\u8981\u4e0a\u4f20\u7684\u6587\u4ef6\u3002');
		return false ;
	}

	if ((FCKConfig.ImageUploadAllowedExtensions.length > 0 && !oUploadAllowedExtRegex.test(sFile))||
		(FCKConfig.ImageUploadDeniedExtensions.length > 0 && oUploadDeniedExtRegex.test(sFile)))
	{
		OnUploadCompleted(202);
		return false ;
	}

	window.parent.Throbber.Show(100);
	GetE('divUpload').style.display ='none';

	return true ;
}
