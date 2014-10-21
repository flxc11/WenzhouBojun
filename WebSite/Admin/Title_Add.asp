<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Site_Title")
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	STitle=Trim(Request("STitle"))
	SitePage=Trim(Request("SitePage"))
	KeyWords=Trim(Request("KeyWords"))
	PageRemark=Trim(Request("PageRemark"))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))	
	
	'获取排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select SiteOrder From TitleInfo"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		SiteOrder=Cstr(Trim(Rs("SiteOrder")))+1
	Else
		SiteOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From TitleInfo"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("STitle")=STitle
	Rs("KeyWords")=KeyWords
	Rs("SitePage")=SitePage
	Rs("PageRemark")=PageRemark
	Rs("SiteOrder")=SiteOrder
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u9875\u9762\u6807\u9898\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Title_List.asp';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：站点标题管理>> 添加页面标题</td>
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
	if ($("#STitle").val()=="")
	{
		alert("\u6807\u9898\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#STitle").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
  <tr>
<th colspan="2">添加页面标题</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">标题名称：</td>
<td width="75%"><input type="text" id="STitle" name="STitle" value="" class="Input300px" style="width:500px;"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">关键字(KeyWords)：</td>
<td width="75%"><input type="text" id="KeyWords" name="KeyWords" value="" class="Input300px" style="width:500px;"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">页面：</td>
<td width="75%"><input type="text" id="SitePage" name="SitePage" value="" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">页面说明：</td>
  <td width="75%"><input type="text" id="PageRemark" name="PageRemark" value="" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">&nbsp;</td>
  <td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Title_List.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>