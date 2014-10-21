<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"DateTable")
TableName=Trim(Request("TableName"))
Binding=Trim(Request("Binding"))
dim Action
Action=ReplaceBadChar(Trim(Request("Action")))
Select Case Action
Case "Save"
	Set Rs2=Server.CreateObject("Adodb.Recordset")
	Sql2="select * from [TableInfo] where TableName='"&TableName&"'"
	Rs2.open Sql2,Conn,1,1
	if Rs2.Recordcount>0 then
		Set Rs=Server.CreateObject("Adodb.Recordset")
		Sql="select * from [TableInfo] where TableName='"&TableName&"'"
		Rs.open Sql,Conn,1,3
		Rs("TableName")=TableName
		Rs("ClassID")=Binding
		Rs.UpDate
	else
		Set Rs=Server.CreateObject("Adodb.Recordset")
		Sql="select * from [TableInfo]"
		Rs.open Sql,Conn,1,3
		Rs.AddNew
		Rs("TableName")=TableName
		Rs("ClassID")=Binding
		Rs.UpDate
	end if
	Rs.close
	Set Rs=Nothing
	Rs2.close
	Set Rs2=Nothing
	Response.Write("<script>alert('\u8868"&TableName&"\u5df2\u6307\u5b9a\u6210\u529f\u0021');window.location.href='DateTable_Binding.asp';</script>")
	Response.End()
End Select
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：数据表编辑</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.数据表与对应的栏目进行绑定。  </td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#TableName").val()==0)
	{
		alert("\u8bf7\u9009\u62e9\u8981\u7ed1\u5b9a\u7684\u8868\u0021");
		$("#TableName").focus();
		return false;
	}
	return true;	
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
  <form id="form1" name="form1" method="post" action="?action=Save" onSubmit="return CheckForm();">
<tr>
<th colspan="2">数据表绑定</th>
</tr>
<tr>
<td class="Right" align="right">表名：</td>
<td><select id="TableName" name="TableName" style="width:200px;">
  <option value="0">请选择表名</option>
  <%=GetSelect3()%>
</select></td>
</tr>
<tr>
  <td width="25%" class="Right" align="right">绑定栏目：</td>
  <td width="75%"><select id="Binding" name="Binding" style="width:200px;">
  	<option value="0">请选择</option>
    <option value="1">单页类别管理</option>
  </select></td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td><input type="submit" value="保 存" class="Button">&nbsp;<input type="button" value="返 回" class="Button" onClick="window.location.href='DateTable.asp'"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</body>
</html>