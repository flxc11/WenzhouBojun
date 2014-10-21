<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"FirendLinkManager")
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
   ID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	LinkTitleOrPic=Trim(Request("LinkTitleOrPic"))
	LinkAddress=Trim(Request("LinkAddress"))
	NavContent=Trim(Request("NavContent"))
	EnNavContent=Trim(Request("EnNavContent"))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))	
	
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavOrder From FirendLink Where NavParent="&ID&" Order By NavOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavOrder=Cstr(Trim(Rs("NavOrder")))+1
	Else
		NavOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	'获取导航条的深度值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavLevel From FirendLink Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavLevel=Cstr(Trim(Rs("NavLevel")))+1
	Else
		NavLevel=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FirendLink"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("LinkTitleOrPic")=LinkTitleOrPic
	Rs("LinkAddress")=LinkAddress
	Rs("NavContent")=NavContent
	Rs("EnNavContent")=EnNavContent
	Rs("NavLock")=NavLock
	Rs("NavOrder")=NavOrder
	Rs("NavParent")=ID
	Rs("NavLevel")=NavLevel
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u6709\u60c5\u94fe\u63a5\u6dfb\u52a0\u6210\u529f\u0021');window.location.href='FirendLinkAdd.asp?ID="&ID&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Nav_Explain.asp">单页内容维护</a> >> 添加单页内容</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.以下带星号(*)的均不能为空，请准确真实的填写相关信息。<br />
  2.在“在链接标题或链接图片”文本框中可点&quot;浏览...&quot;图片链接，也可文字链接。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#NavContent").val()=="")
	{
		alert("\u94fe\u63a5\u6807\u9898\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		$("#NavContent").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td class="Right" colspan="2" align="left"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='FirendLink.asp'"></td>
</tr>
<tr>
<th class="Right" colspan="2">添加单页内容</th>
</tr>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
<tr>
  <td class="Right" width="25%" align="right">链接中文名称：</td>
  <td width="75%"><input type="text" id="NavContent" name="NavContent" value="" class="Input300px"/>
  </td>
</tr>
<%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
<tr>
  <td class="Right" width="25%" align="right">链接英文名称：</td>
  <td width="75%"><input type="text" id="EnNavContent" name="EnNavContent" value="" class="Input300px"/>
  </td>
</tr>
<%end if%>
<tr>
<td class="Right" width="25%" align="right">链接图片：</td>
<td width="75%"><input type="text" id="LinkTitleOrPic" name="LinkTitleOrPic" value="" class="Input300px"/>&nbsp;*<a href="javascript:OpenImageBrowser('LinkTitleOrPic');">&nbsp;浏览...</a>88*30</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">链接地址：</td>
  <td width="75%"><input type="text" id="LinkAddress" name="LinkAddress" value="http://" class="Input300px"/>
  链接地址以http://开头</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">状态：</td>
  <td width="75%"><input type="radio" id="NavLock" name="NavLock" value="0" checked="checked"/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='FirendLink.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>