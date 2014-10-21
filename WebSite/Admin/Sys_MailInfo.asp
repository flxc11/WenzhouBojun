<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_FSO.asp"-->
<!--#include File="../Include/Class_EMail.asp"-->
<%
Call ISPopedom(UserName,"Sys_MailInfo")
Action=ReplaceBadChar(Trim(Request("Action")))
SmtpServer=ReplaceBadChar(Trim(Request("SmtpServer")))
SmtpFormMail=ReplaceBadChar(Trim(Request("SmtpFormMail")))
SmtpUserName=ReplaceBadChar(Trim(Request("SmtpUserName")))
SmtpUserPass=ReplaceBadChar(Trim(Request("SmtpUserPass")))
If Action="Save" Then
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteInfo"
	Rs.Open Sql,Conn,1,3
	Rs("SmtpServer")=SmtpServer
	Rs("SmtpFormMail")=SmtpFormMail
	Rs("SmtpUserName")=SmtpUserName
	Rs("SmtpUserPass")=SmtpUserPass
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	
	Set Mail_FSO=New Class_FSO
	Content=Mail_FSO.GetFileText(Server.MapPath("Template/MailSetting.htm"))
	Call SendMail(SmtpFormMail,"企业信箱设置操作成功。",Content)
	Response.Write("<script>alert('\u4f01\u4e1a\u4fe1\u7bb1\u7ef4\u62a4\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Sys_MailInfo.asp';</script>")
	Response.End()
Rs.Close
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
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：企业信箱维护</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">请正确设置企业信箱的相关属性，保存之后立即生效。<br>
注意：需要在线订单邮件发送功能必须设置该属性。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From SiteInfo"
Rs.Open Sql,Conn,1,1
if not Rs.eof then
	SmtpServer=Rs("SMTPServer")
	SmtpFormMail=Rs("SmtpFormMail")
	SmtpUserName=Rs("SmtpUserName")
	SmtpUserPass=Rs("SmtpUserPass")
end if
Rs.Close
Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#SmtpServer").val()=="")
	{
		alert("\u0053\u004d\u0054\u0050\u90ae\u4ef6\u670d\u52a1\u5668\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#SmtpServer").focus();
		return false;
	}
	if ($("#SmtpFormMail").val()=="")
	{
		alert("\u53d1\u4fe1\u4eba\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#SmtpFormMail").focus();
		return false;
	}
	if ($("#SmtpUserName").val()=="")
	{
		alert("\u90ae\u4ef6\u767b\u5f55\u8d26\u53f7\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#SmtpUserName").focus();
		return false;
	}
	if ($("#SmtpUserPass").val()=="")
	{
		alert("\u90ae\u4ef6\u767b\u5f55\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#SmtpUserPass").focus();
		return false;
	}
	return true;
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<tr>
<th colspan="2">企业邮箱维护</th>
</tr>
<tr>
<td width="25%" align="right" class="Right">SMTP邮件服务器地址：</td>
<td width="75%"><input type="text" id="SmtpServer" name="SmtpServer" value="<%=SmtpServer%>" class="Input300px" /></td>
</tr>
<tr>
<td align="right" class="Right">发送人的邮件地址：</td>
<td><input type="text" id="SmtpFormMail" name="SmtpFormMail" value="<%=SmtpFormMail%>" class="Input300px"></td>
</tr>
<tr>
<td align="right" class="Right">邮件登录账号：</td>
<td><input type="text" id="SmtpUserName" name="SmtpUserName" value="<%=SmtpUserName%>" class="Input300px"></td>
</tr>
<tr>
<td align="right" class="Right">邮件登录密码：</td>
<td><input type="password" id="SmtpUserPass" name="SmtpUserPass" value="<%=SmtpUserPass%>" class="Input300px"></td>
</tr>
<tr>
<td align="right" class="Right">&nbsp;</td>
<td><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Sys_MailInfo')"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</body>
</html>