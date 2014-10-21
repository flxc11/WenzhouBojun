<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Member_List")
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
If Request("Action")="Save" Then
UserPass=ReplaceBadChar(Trim(Request("UserPass")))
RealName=ReplaceBadChar(Trim(Request("RealName")))
Birthday=Trim(Request("Birthday"))
CompanyName=ReplaceBadChar(Trim(Request("CompanyName")))
TelPhone=ReplaceBadChar(Trim(Request("TelPhone")))
Address=ReplaceBadChar(Trim(Request("Address")))
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From UserReg Where ID="&ID&""
Rs.Open Sql,Conn,1,3
If Not (Rs.Eof Or Rs.Bof) Then
	If UserPass<>"" Then
	Rs("UserPass")=MD5(UserPass,32)
	End If
	Rs("RealName")=RealName
	Rs("Birthday")=Birthday
	Rs("CompanyName")=CompanyName
	Rs("TelPhone")=TelPhone
	Rs("Address")=Address
Rs.Update
Response.Write("<script>alert('\u4f1a\u5458\u8d26\u53f7\u4fe1\u606f\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Member_List.asp?Page="&Page&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：<a href="Member_list.asp">会员列表</a> >> 编辑会员</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下各项信息请准确真实的填写，保存之后立即生效。<br>
注意：管理员可对会员账号进行锁定操作。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From UserReg Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Eof Or Rs.Bof) Then
	UserName=Rs("UserName")
	Birthday=Rs("Birthday")
	RealName=Rs("RealName")
	CompanyName=Rs("CompanyName")
	TelPhone=Rs("TelPhone")
	Address=Rs("Address")
End If
Rs.Close
Set Rs=Nothing
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" name="form1" method="post" action="?action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>">
<input type="hidden" id="Page" name="Page" value="<%=Page%>">
<tr>
<th colspan="2">编辑会员</th>
</tr>
<tr>
<td class="Right" align="right">登录账号名称：</td>
<td><input type="text" id="UserName" name="UserName" value="<%=UserName%>" class="Input300px" readonly></td>
</tr>
<tr>
<td width="25%" class="Right" align="right">您的登录密码：</td>
<td width="75%"><input type="password" id="UserPass" name="UserPass" class="Input300px"></td>
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
<td class="Right" align="right">您的出生日期：</td>
<td>
<div style="float:left;width:140px;height:30px;line-height:30px; padding-top:3px;"><input type="text" id="Birthday" name="Birthday" value="<%=FormatTime(Birthday,2)%>" class="Input300px" style="width:140px"></div>
<div style="float:left; padding-top:8px;width:25px"><img src="Images/Calender.gif" align="absmiddle" onClick="showcalendar(event, $('Birthday'));" onFocus="showcalendar(event, $('Birthday'));if($('Birthday').value=='0000-00-00')$('Birthday').value=''"></div>
<div style="float:left">日期格式为2009-01-01</div></td>
</tr>
<tr>
<td class="Right" align="right">您的真实姓名：</td>
<td><input type="text" id="RealName" name="RealName" value="<%=RealName%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">您的公司名称：</td>
<td><input type="text" id="CompanyName" name="CompanyName" value="<%=CompanyName%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">您的联系电话：</td>
<td><input type="text" id="Telphone" name="Telphone" value="<%=TelPhone%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">您的联系地址：</td>
<td><input type="text" id="Address" name="Address" value="<%=Address%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="history.back();"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript" src="Common/PopCalender.js"></script>
</body>
</html>