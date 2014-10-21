<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Sys_ChangePass")
If Request("Action")="Save" Then
UserPass=Request("UserPass")
NewPass=Request("NewPass")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From Admin Where UserName='"&UserName&"'"
Rs.Open Sql,Conn,1,3
If (Rs("UserPass")=Md5(UserPass,32)) Then 
	Rs("UserPass")=Md5(NewPass,32)
	Rs.Update
	Response.Write("<script>alert('\u5bc6\u7801\u4fee\u6539\u64cd\u4f5c\u6210\u529f\uff0c\u8bf7\u7262\u8bb0\u65b0\u7684\u767b\u5f55\u5bc6\u7801\u3002');window.location.href='Sys_ChangePass.asp';</script>")
Else
	Response.Write("<script>alert('\u767b\u5f55\u5bc6\u7801\u4e0d\u6b63\u786e\uff0c\u8bf7\u68c0\u67e5\u767b\u5f55\u5bc6\u7801\u662f\u5426\u8f93\u5165\u6b63\u786e\u3002');window.history.back();</script>")
End If
Rs.Close
Set Rs=Nothing
Conn.Close
Set Conn=Nothing
Response.End()
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<style type="text/css">
.pwd-strength {width:180px;height:20px;line-height:20px}
.pwd-strength-box,.pwd-strength-box-low,.pwd-strength-box-med,.pwd-strength-box-hi{color: #464646;text-align: center;
width: 30%; float:left; border:solid 1px #CCCCCC}
.pwd-strength-box-low{color: #FF0000;background-color:#F00F00;color:#FFFFFF}
.pwd-strength-box-med{color: #FF0000;background-color: #CCCCCC;}
.pwd-strength-box-hi{color: #FF0000;background-color: #FF9900;}
</style>
<script language="javascript" type="text/javascript">
function checkPassword(pwd){
var objLow=document.getElementById("pwdLow");
var objMed=document.getElementById("pwdMed");
var objHi=document.getElementById("pwdHi");
objLow.className="pwd-strength-box";
objMed.className="pwd-strength-box";
objHi.className="pwd-strength-box";
if(pwd.length<6){
objLow.className="pwd-strength-box-low";
}else{
var p1= (pwd.search(/[a-zA-Z]/)!=-1) ? 1 : 0;
var p2= (pwd.search(/[0-9]/)!=-1) ? 1 : 0;
var p3= (pwd.search(/[^A-Za-z0-9_]/)!=-1) ? 1 : 0;
var pa=p1+p2+p3;
if(pa==1){
objLow.className="pwd-strength-box-low";
}else if(pa==2){
objMed.className="pwd-strength-box-med";
}else if(pa==3){
objHi.className="pwd-strength-box-hi";
}
}
}
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：更改登录密码</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">在这里你可以修改系统登录密码，保存之后立即生效。<br>
建议：密码设置强度越高越好，并请牢记新的登录密码。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#UserPass").val()=="")
	{
		alert("\u5f53\u524d\u767b\u5f55\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#UserPass").focus();
		return false;
	}
	if ($("#NewPass").val()=="")
	{
		alert("\u65b0\u7684\u767b\u5f55\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NewPass").focus();
		return false;
	}
	if ($("#NewPass1").val()=="")
	{
		alert("\u8bf7\u518d\u6b21\u8f93\u5165\u65b0\u7684\u767b\u5f55\u5bc6\u7801\u3002");
		$("#NewPass1").focus();
		return false;
	}
	if ($("#NewPass").val()!=$("#NewPass1").val())
	{
		alert("\u4e24\u6b21\u5bc6\u7801\u8f93\u5165\u4e0d\u4e00\u81f4\u3002");
		$("NewPass1").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?action=Save" onSubmit="return CheckForm();">
<tr>
<th colspan="2">更改登录密码</th>
</tr>
<tr>
<td class="Right" align="right">当前登录账号：</td>
<td><%=UserName%></td>
</tr>
<tr>
<td width="25%" class="Right" align="right">当前登陆密码：</td>
<td width="75%"><input type="password" id="UserPass" name="UserPass" class="Input300px" maxlength="20"></td>
</tr>
<tr>
<td class="Right" align="right">新的登录密码：</td>
<td><input type="password" id="NewPass" name="NewPass" class="Input300px" maxlength="20" onKeyUp="checkPassword(this.value);"></td>
</tr>
<tr>
<td class="Right" align="right">密码强度(越高越好)：</td>
<td>
<div class="pwd-strength FCK__ShowTableBorders">
<div class="pwd-strength-box" id="pwdLow">低</div>
<div class="pwd-strength-box" id="pwdMed">等</div>
<div class="pwd-strength-box" id="pwdHi">高</div>
</div>
</td>
</tr>
<tr>
<td class="Right" align="right">重复新的登录密码：</td>
<td><input type="password" id="NewPass1" name="NewPass1" class="Input300px" maxlength="20"></td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Sys_ChangePass')"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</body>
</html>