<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"FunctionClassEdit")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
If Action="Save" Then
	FClassName=Trim(Request("FClassName"))
	ClassNameDes=Trim(Request("ClassNameDes"))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FunctionClass Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("FClassName")=FClassName
	Rs("ClassNameDes")=ClassNameDes
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u51fd\u6570\u5206\u7c7b\u4fe1\u606f\u7f16\u8f91\u64cd\u4f5c\u6210\u529f\u0021');window.location.href='FunctionClass.asp?ClassID="&ClassID&"&Edit=ename&Page="&Page&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：后台函数管理 >> 函数分类编辑</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top"><p>以下为函数分类编辑。</p>
  <p>注意：编辑完成后保存即刻生效。</p></td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From FunctionClass Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	FClassName=Rs("FClassName")
	ClassNameDes=Rs("ClassNameDes")
End If
Rs.Close
Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#FClassName").val()=="")
	{
		alert("\u5546\u54c1\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#FClassName").focus();
		return false;
	}
	return true;
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="Keyword" name="Keyword" value="<%=Request("FClassName")%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="2" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="2">函数分类编辑</th>
</tr>
<tr>
  <td class="Right" align="right" width="10%">函数分类名称：</td>
  <td width="90%" class="Right"><input type="text" id="FClassName" name="FClassName" value="<%=FClassName%>" class="Input200px" style="width:370px;"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">函数描述：</td>
  <td>
    <%=Editor2("ClassNameDes",ClassNameDes)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=ClassNameDes"></script>
    </td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>