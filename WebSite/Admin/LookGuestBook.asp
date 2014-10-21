<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"GuestBook")
ID=ReplaceBadChar(Trim(Request("ID")))
ParentID=ReplaceBadChar(Trim(Request("ParentID")))
Action=ReplaceBadChar(Trim(Request("Action")))

If Action="Save" Then
	GuestbookTitle=ReplaceBadChar(Trim(Request("GuestbookTitle")))
	UserName=ReplaceBadChar(Trim(Request("UserName")))
	LinkPhone=ReplaceBadChar(Trim(Request("LinkPhone")))
	Address=ReplaceBadChar(Trim(Request("Address")))
	Email=ReplaceBadChar(Trim(Request("Email")))
	HomePage=ReplaceBadChar(Trim(Request("HomePage")))
	ICQ=ReplaceBadChar(Trim(Request("ICQ")))
	GuestbookContent=Trim(Request("GuestbookContent"))
	Reply=Trim(Request("Reply"))
	PostTime=Trim(Request("PostTime"))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From GuestBook Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("GuestbookTitle")=GuestbookTitle
	Rs("UserName")=UserName
	Rs("LinkPhone")=LinkPhone
	Rs("Address")=Address
	Rs("Email")=Email
	Rs("HomePage")=HomePage
	Rs("ICQ")=ICQ
	Rs("GuestbookContent")=GuestbookContent
	Rs("Reply")=Reply
	Rs("NavLock")=1
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u4fe1\u606f\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='GuestBook.asp';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="LookGuestBook.asp">留言内容维护</a> >>查看留言内容</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="61" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60" height="83"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下所有内容均为只读。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
if ID<>"" then
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From GuestBook Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
else
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From GuestBook "
	Rs.Open Sql,Conn,1,1
end if
If Not (Rs.Eof Or Rs.Bof) Then
	GuestbookTitle=Rs("GuestbookTitle")
	UserName=Rs("UserName")
	LinkPhone=Rs("LinkPhone")
	Address=Rs("Address")
	Email=Rs("Email")
	HomePage=Rs("HomePage")
	ICQ=Rs("ICQ")
	GuestbookContent=Rs("GuestbookContent")
	Reply=Rs("Reply")
	PostTime=Rs("PostTime")
End If
Rs.Close
Set Rs=Nothing
%>
<form id="form1" name="form1" method="post" action="?Action=Save">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="ParentID" name="ParentID" value="<%=ParentID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
  <th class="Right" colspan="2">编辑说明页</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">留言主题：</td>
<td width="75%"><input type="text" id="GuestbookTitle" name="GuestbookTitle" value="<%=GuestbookTitle%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">姓名：</td>
  <td width="75%"><input type="text" id="UserName" name="UserName" value="<%=UserName%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">联系电话：</td>
  <td width="75%"><input type="text" id="LinkPhone" name="LinkPhone" value="<%=LinkPhone%>" readonly="readonly" class="Input300px"/></td>
</tr>
<!--<tr>
  <td class="Right" align="right" valign="top">地址：</td>
  <td width="75%"><input type="text" id="Address" name="Address" value="<%=Address%>" readonly="readonly" class="Input300px"/></td>
</tr>-->
<tr>
  <td class="Right" align="right" valign="top">邮箱：</td>
  <td width="75%"><input type="text" id="Email" name="Email" value="<%=Email%>" readonly="readonly" class="Input300px"/></td>
</tr>
<!--<tr>
  <td class="Right" align="right" valign="top">邮政编码：</td>
  <td width="75%"><input type="text" id="HomePage" name="HomePage" value="<%=HomePage%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">ICQ/OICQ：</td>
  <td width="75%"><input type="text" id="ICQ" name="ICQ" value="<%=ICQ%>" readonly="readonly" class="Input300px"/></td>
</tr>-->
<tr>
  <td class="Right" align="right" valign="top">留言内容：</td>
  <td width="75%"><input type="text" id="GuestbookContent" name="GuestbookContent" value="<%=GuestbookContent%>" readonly="readonly" class="Input300px" style=" height:150px; width:450px;"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">留言时间：</td>
  <td width="75%"><input type="text" id="PostTime" name="PostTime" value="<%=PostTime%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">管理员回复：</td>
  <td width="75%"><%=Editor("Reply",Reply)%><br /><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="提 交" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='GuestBook.asp?ID=<%=ParentID%>&Page=<%=Page%>'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>