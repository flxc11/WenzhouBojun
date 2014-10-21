<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Nav_Content")
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
   ID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=ReplaceBadChar(Trim(Request("NavTitle")))
	NavURL=ReplaceBadChar(Trim(Request("NavURL")))
	NavTarget=ReplaceBadChar(Trim(Request("NavTarget")))
	NavRemark=ReplaceBadChar(Trim(Request("NavRemark")))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))	
	
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavOrder From SiteNav Where NavParent="&ID&" Order By NavOrder Desc"
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
	Sql="Select NavLevel From SiteNav Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavLevel=Cstr(Trim(Rs("NavLevel")))+1
	Else
		NavLevel=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteNav"
	Rs.Open Sql,Conn,1,3
	'If Not (Rs.Eof Or Rs.Bof) Then
		'NavOrder=Conn.Execute("Select Max(NavOrder+1) From SiteNav Where NavParent="&ID&"")(0)
		'Set Rs1=Conn.Execute("Select Max(NavOrder+1) As NavOrder From SiteNav Where NavParent="&ID&"")
		'If Not (Rs1.Eof Or Rs1.Bof) Then
		'NavOrder=Rs1("NavOrder")
		'Else
		'NavOrder=1
		'End If
		'NavLevel=Conn.Execute("Select Max(NavLevel+1) From SiteNav Where ID="&ID&"")(0)
		'Response.Write(NavOrder)
		'Response.End()
	'Else
		'NavOrder=1
		'NavLevel=1
	'End If
	Rs.AddNew
	Rs("NavTitle")=NavTitle
	Rs("NavURL")=NavURL
	Rs("NavTarget")=NavTarget
	Rs("NavRemark")=NavRemark
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
	Response.Write("<script>alert('\u5bfc\u822a\u6761\u4fe1\u606f\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Nav_Content.asp?ID="&ID&"';</script>")
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
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Nav_Content.asp">导航条内容维护</a> >> 添加导航条</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下所有项目均不能为空，请准确真实的填写相关信息。<br>
注意：导航条信息可以为一个外部链接的地址。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#NavTitle").val()=="")
	{
		alert("\u5bfc\u822a\u6761\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NavTitle").focus();
		return false;
	}
	if ($("#NavURL").val()=="")
	{
		alert("\u5bfc\u822a\u6761\u94fe\u63a5\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NavURL").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="2">添加导航条</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">导航条名称：</td>
<td width="75%"><input type="text" id="NavTitle" name="NavTitle" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">导航条链接地址：</td>
<td width="75%"><input type="text" id="NavURL" name="NavURL" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">导航条说明：</td>
<td width="75%"><input type="text" id="NavRemark" name="NavRemark" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">导航条打开方式：</td>
<td width="75%">
<select id="NavTarget" name="NavTarget" style="width:120px">
<option value="">原窗口</option>
<option value="_blank">新窗口</option>
</select>
</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">导航条状态：</td>
<td width="75%"><input type="radio" id="NavLock" name="NavLock" value="0" checked="checked"/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Nav_Content.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>