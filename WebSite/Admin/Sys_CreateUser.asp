<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Sys_CreateUser")
If Request("Action")="Save" Then
UserName=ReplaceBadChar(Trim(Request("UserName")))
UserPass=ReplaceBadChar(Trim(Request("UserPass")))
Birthday=ReplaceBadChar(Trim(Request("Birthday")))
Question=ReplaceBadChar(Trim(Request("Question")))
Answer=ReplaceBadChar(Trim(Request("Answer")))
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From Admin Where UserName='"&UserName&"'"
Rs.Open Sql,Conn,1,3
If Not (Rs.Eof Or Rs.Bof) Then
Response.Write("<script>alert('\u8be5\u767b\u5f55\u8d26\u53f7\u5df2\u5b58\u5728\uff0c\u8bf7\u66f4\u6362\u65b0\u7684\u767b\u5f55\u8d26\u53f7\u518d\u8fdb\u884c\u672c\u64cd\u4f5c\u3002');window.history.back();</script>")
Else
Rs.Addnew
Rs("UserName")=UserName
Rs("UserPass")=MD5(UserPass,32)
if len(Trim(Birthday))>0 then
Rs("Birthday")=Birthday
end if
Rs("Question")=Question
Rs("Answer")=Answer
Rs("ISAdmin")=0
Rs.Update
Response.Write("<script>alert('\u7ba1\u7406\u5458\u521b\u5efa\u64cd\u4f5c\u6210\u529f\uff0c\u8bf7\u8fdb\u884c\u64cd\u4f5c\u6743\u9650\u8bbe\u7f6e\u3002');window.location.href='Sys_UserGroup.asp?UserName="&UserName&"';</script>")
End If
Rs.Update
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
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
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
<script>
//这段脚本如果你的页面里有，就可以去掉它们了
//欢迎访问我的网站queyang.com
var ie =navigator.appName=="Microsoft Internet Explorer"?true:false;
function $(objID){
	return document.getElementById(objID);
}
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：添加新管理员</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下各项信息请准确真实的填写，保存之后立即生效。<br>
注意：创建管理账号之后，您需要进行操作权限的设置。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" name="form1" method="post" action="?action=Save">
<tr>
<th colspan="2">添加新管理员</th>
</tr>
<tr>
<td class="Right" align="right">登录账号名称：</td>
<td><input type="text" id="UserName" name="UserName" class="Input300px"></td>
</tr>
<tr>
<td width="25%" class="Right" align="right">您的登录密码：</td>
<td width="75%"><input type="password" id="UserPass" name="UserPass" class="Input300px" onKeyUp="checkPassword(this.value);"></td>
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
<!--<tr>
<td class="Right" align="right">您的出生日期：</td>
<td>
<div style="float:left;width:140px;height:30px;line-height:30px; padding-top:3px;"><input type="text" id="Birthday" name="Birthday" class="Input300px" style="width:140px" readonly></div>
<div style="float:left; padding-top:8px;width:25px"><img src="Images/Calender.gif" align="absmiddle" onClick="showcalendar(event, $('Birthday'));" onFocus="showcalendar(event, $('Birthday'));if($('Birthday').value=='0000-00-00')$('Birthday').value=''"></div>
<div style="float:left">日期格式为2009-01-01</div></td>
</tr>-->
<tr>
<td width="25%" class="Right" align="right">密码取回问题：</td>
<td width="75%"><input type="text" id="Question" name="Question" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">密码取回答案：</td>
<td><input type="text" id="Answer" name="Answer" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Sys_CreateUser')"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript" src="Common/PopCalender.js"></script>
</body>
</html>