<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_Upload.asp"-->
<%
Call ISPopedom(UserName,"Sys_SiteInfo")
If Request("Action")="Save" Then
on error resume next
 Server.ScriptTimeout = 9999999
 Dim Upload,successful,thisFile,allFiles,upPath,path
 set Upload=new AnUpLoad
 UpLoad.Charset="utf-8"
 Upload.openProcesser=true  '打开进度条显示
 Upload.SingleSize=512*1024*1024  '设置单个文件最大上传限制,按字节计；默认为不限制，本例为512M
 Upload.MaxSize=1024*1024*1024 '设置最大上传限制,按字节计；默认为不限制，本例为1G
 Upload.Exe="png"  '设置允许上传的扩展名
 Upload.GetData()
 if Upload.ErrorID>0 then
 	upload.setApp "faild",1,0 ,Upload.description
 else
 	if Upload.files(-1).count>0 then
		for each file in Upload.files(-1)
 	        upPath=request.querystring("path")
    		path=server.mappath(upPath)
    		set tempCls=Upload.files(file) 
            upload.setApp "saving",Upload.TotalSize,Upload.TotalSize,tempCls.FileName
    		successful=tempCls.SaveToFile(path,3)
    		set tempCls=nothing
		next
 	end if
 	upload.setApp "over",Upload.TotalSize,Upload.TotalSize,"提交完毕！"
	Response.Write("<script>alert('\u516c\u53f8\u6807\u5fd7\u56fe\u7247\u4fdd\u5b58\u64cd\u4f5c\u6210\u529f\u3002');</script>")
	Response.End()
 end if
 if err then upload.setApp "faild",1,0,err.description
 set Upload=nothing
 response.end
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/AjaxPlus.js"></script>
<script language="javascript" type="text/javascript" src="Common/AjaxUploader.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：<a href="Sys_SiteInfo.asp">站点基本信息维护</a> >> 更改公司标志图片</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">公司标志图片仅在后台登陆口、管理页面出现，你可以随意进行更换。<br>
注意：仅允许上传200*30像素、后缀为PNG的图片作为公司标志。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" method="post" action="Sys_ChangeLogo.asp?action=Save" enctype="multipart/form-data">
<tr>
<th colspan="3">更改公司标志图片</th>
</tr>
<tr>
<td width="25%" class="Right" align="right">公司标志图片：</td>
<td width="75%" colspan="2"><input type="file" id="file" name="file" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">图片上传进度：</td>
<td colspan="2"><span><div id="uploadContenter"></div></span>
</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="2"><input type="button" value="保 存" class="Button" onClick="Frm_Do();"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Sys_SiteInfo.asp'"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
<iframe style="display:none;" name="CNVPUploader"></iframe>
<script type="text/javascript">
var fileCount=1;
var AjaxUp=new AjaxProcesser("form1","uploadContenter");
AjaxUp.target="CNVPUploader";
AjaxUp.savePath="Images";
function Frm_Do()
{
	if ($("#file").val()=="")
	{
		alert("\u516c\u53f8\u6807\u5fd7\u56fe\u7247\u4e0d\u80fd\u4e3a\u7a7a\uff0c\u8bf7\u9009\u62e9\u540e\u91cd\u65b0\u8fdb\u884c\u672c\u64cd\u4f5c\u3002");
		$("#file").focus();
		return false;
	}
	else
	{
		AjaxUp.Do();
	}
}
</script>
</body>
</html>