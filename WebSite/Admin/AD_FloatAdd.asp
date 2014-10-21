<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Ad_Float")
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	AdsName=ReplaceBadChar(Trim(Request("AdsName")))
	AdsRemark=ReplaceBadChar(Trim(Request("AdsRemark")))
	AdsCType=ReplaceBadChar(Trim(Request("AdsCType")))
	AdsSwfUrl=Trim(Request("AdsSwfUrl"))
	AdsPicUrl=Trim(Request("AdsPicUrl"))
	AdsPicLink=Trim(Request("AdsPicLink"))
	AdsTarget=ReplaceBadChar(Trim(Request("AdsTarget")))
	AdsLock=ReplaceBadChar(Trim(Request("AdsLock")))
	PostTime=Trim(Request("PostTime"))
	If PostTime="" Or IsDate(PostTime)=false Then
		PostTime=Now()
	End If
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select AdsOrder From SiteAds Where AdsType='Float' Order By AdsOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		AdsOrder=Cstr(Trim(Rs("AdsOrder")))+1
	Else
		AdsOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteAds"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("AdsType")="Float"
	Rs("AdsName")=AdsName
	Rs("AdsRemark")=AdsRemark
	Rs("AdsCType")=AdsCType
	Rs("AdsSwfUrl")=AdsSwfUrl
	Rs("AdsPicUrl")=AdsPicUrl
	Rs("AdsPicLink")=AdsPicLink
	Rs("AdsTarget")=AdsTarget
	Rs("AdsLock")=AdsLock
	Rs("AdsOrder")=AdsOrder
	Rs("PostTime")=PostTime
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u6d6e\u52a8\u5e7f\u544a\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='AD_Float.asp';</script>")
	Response.End()
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：浮动广告 >> 添加广告</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">信息内容你可以设置会员阅读权限，仅网站注册会员方能阅读该信息。<br>
注意：不想对外发布的信息你可以设置成锁定状态。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#AdsName").val()=="")
	{
		alert("\u5e7f\u544a\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#AdsName").focus();
		return false;
	}
	return true;	
}
function CheckType()
{
	var n=$("input[@type=radio][@checked]").val();
	if (n==0)
	{
		document.getElementById("Pic1").style.display="";
		document.getElementById("Pic2").style.display="";
		document.getElementById("Pic3").style.display="";
		document.getElementById("Swf").style.display="none";
	}
	else
	{
		document.getElementById("Pic1").style.display="none";
		document.getElementById("Pic2").style.display="none";
		document.getElementById("Pic3").style.display="none";
		document.getElementById("Swf").style.display="";
	}
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="3">添加广告</th>
</tr>
<tr>
<td class="Right" align="right" width="25%">广告名称：</td>
<td width="75%" colspan="2"><input type="text" id="AdsName" name="AdsName" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" align="right">广告说明：</td>
<td colspan="2"><input type="text" id="AdsRemark" name="AdsRemark" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" align="right">广告类型：</td>
<td colspan="2"><input type="radio" id="AdsCType" name="AdsCType" value="0" onclick="CheckType();" checked="checked"/>图片格式<input type="radio" id="AdsCType" name="AdsCType" value="1" onclick="CheckType();"/>动画格式</td>
</tr>
<tr id="Swf" style="display:none">
<td class="Right" width="25%" align="right">动画地址：</td>
<td width="38%"><input type="text" id="AdsSwfUrl" name="AdsSwfUrl" class="Input300px"></td>
<td width="37%"><input type="button" value="浏览动画" class="Button" onclick="OpenImageBrowser('AdsSwfUrl');"/></td>
</tr>
<tr id="Pic1">
<td class="Right" width="25%" align="right">图片地址：</td>
<td width="38%"><input type="text" id="AdsPicUrl" name="AdsPicUrl" class="Input300px"></td>
<td width="37%"><input type="button" value="浏览图片" class="Button" onclick="OpenImageBrowser('AdsPicUrl');"/></td>
</tr>
<tr id="Pic2">
<td class="Right" align="right">链接地址：</td>
<td colspan="2"><input type="text" id="AdsPicLink" name="AdsPicLink" value="" class="Input300px"/></td>
</tr>
<tr id="Pic3">
<td class="Right" align="right">打开方式：</td>
<td colspan="2">
<select id="AdsTarget" name="AdsTarget" style="width:120px">
<option value="">原窗口</option>
<option value="_blank">新窗口</option>
</select>
</td>
</tr>
</div>
<tr>
<td class="Right" align="right">发布状态：</td>
<td colspan="2"><input type="radio" id="AdsLock" name="AdsLock" value="0" checked="checked"/>已发布<input type="radio" id="AdsLock" name="AdsLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='AD_Float.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>