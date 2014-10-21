<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Pro_OrderEdit")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If Action="Save" Then
	Subject=Trim(Request("Subject"))
	UName=Trim(Request("UName"))
	Email=Trim(Request("Email"))
	Company=Trim(Request("Company"))
	Phone=Trim(Request("Phone"))
	Fax=Trim(Request("Fax"))
	Message=Trim(Request("Message"))
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ShopOrder Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("Subject")=Subject
	Rs("UName")=UName
	Rs("Email")=Email
	Rs("Company")=Company
	Rs("Phone")=Phone
	Rs("Fax")=Fax
	Rs("Message")=Message
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u8ba2\u5355\u5df2\u6210\u529f\u5904\u7406\u3002');window.location.href='Pro_OrderList.asp';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：订单管理 >> 订单查看</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">
注意：不想对外发布的信息你可以设置成锁定状态。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From ShopOrder Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	Subject=Rs("Subject")
	UName=Rs("UName")
	Email=Rs("Email")
	Company=Rs("Company")
	Phone=Rs("Phone")
	Fax=Rs("Fax")
	Message=Rs("Message")
	PostTime=Rs("PostTime")
End If
Rs.Close
Set Rs=Nothing
%>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="right" valign="middle" style="padding-right:20px;"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="4">编辑信息</th>
</tr>
<tr>
  <td width="15%" align="right" class="Right">Subject：</td>
  <td width="35%" class="Right"><input type="text" id="Subject" name="Subject" value="<%=Subject%>" class="Input200px"/></td>
  <td width="15%" align="right" class="Right">下单人姓名：</td>
  <td width="35%"><span class="Right">
    <input type="text" id="UName" name="UName" value="<%=UName%>" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">Email：</td>
  <td class="Right"><input type="text" id="Email" name="Email" value="<%=Email%>" class="Input200px"/></td>
  <td class="Right" align="right">单位名称：</td>
  <td><input type="text" id="Company" name="Company" value="<%=Company%>" class="Input200px"/></td>
</tr>
<tr>
  <td class="Right" align="right">联系电话：</td>
  <td class="Right"><input type="text" id="Phone" name="Phone" value="<%=Phone%>" class="Input200px"/></td>
  <td class="Right" align="right">传真：</td>
  <td><input type="text" id="Fax" name="Fax" value="<%=Fax%>" class="Input200px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">信息内容：</td>
  <td colspan="3"><%=Editor2("Message",Message)%>
  </td>
</tr>
<tr>
<td class="Right" align="right">留言内容：</td>
<td class="Right"><input type="radio" id="NewsVisit" name="NewsVisit" value="0" checked="checked"<%If NewsVisit="0" Then Response.Write(" checked=""checked""")%>/>所有人群<input type="radio" id="NewsVisit" name="NewsVisit" value="1"<%If NewsVisit="1" Then Response.Write(" checked=""checked""")%>/>网站会员</td>
<td class="Right" align="right">信息状态：</td>
<td><input type="radio" id="NewsLock" name="NewsLock" value="0" checked="checked"<%If NewsLock="0" Then Response.Write(" checked=""checked""")%>/>解锁状态<input type="radio" id="NewsLock" name="NewsLock" value="1"<%If NewsLock="1" Then Response.Write(" checked=""checked""")%>/>锁定状态</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>