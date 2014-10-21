<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"FunctionClassAdd")
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	FClassName=Trim(Request("FClassName"))
	ClassNameDes=Trim(Request("ClassNameDes"))
	
	'获取排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select top 1 FunOrder From FunctionClass Order By FunOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		FunOrder=Cstr(Trim(Rs("FunOrder")))+1
	Else
		FunOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FunctionClass"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("FClassName")=FClassName
	Rs("FunOrder")=FunOrder
	Rs("ClassNameDes")=ClassNameDes
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u51fd\u6570\u5206\u7c7b\u6dfb\u52a0\u6210\u529f\u0021');window.location.href='FunctionClassAdd.asp';</script>")
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
<script type="text/javascript">
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：后台函数管理 >> 添加函数分类</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.添加函数分类时请填写分类名称及说明；</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#FClassName").val()=="")
	{
		alert("\u8bf7\u586b\u5199\u51fd\u6570\u5206\u7c7b\u540d\u79f0\uff01");
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('AddFunction')"></td>
</tr>
<tr>
<th colspan="2">添加函数说明</th>
</tr>
<tr>
  <td width="10%" align="right" class="Right">函数分类名称：</td>
  <td class="Right"><input type="text" id="FClassName" name="FClassName" value="" class="Input200px" style="width:370px;"/></td>
</tr>
<tr>
  <td align="right" class="Right">分类说明：</td>
  <td align="left" valign="top">
    <%=Editor2("ClassNameDes","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span>
    <script src="AutoSave.asp?Action=AutoSave&amp;FrameName=ClassNameDes"></script></td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Pro_ContentAdd')"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>