<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Pro_ChangeClass")
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	OldClassID=ReplaceBadChar(Trim(Request("OldClassID")))
    ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	Conn.Execute("Update ShopInfo Set ClassID="&ClassID&" Where ClassID In ("&OldClassID&")")
	Response.Write("<script>alert('\u5546\u54c1\u7c7b\u522b\u8f6c\u79fb\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Pro_ChangeClass.asp';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Pro_ContentListIn.asp">商品管理</a> >> 商品转移</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">您可以调整以下导航条的所属父类别，保存之后立即生效。<br>
注意：调整类别之后将直接影响其子类别展示顺序。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post" action="?Action=Save">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th class="Right" colspan="2">商品转移</th>
</tr>
<tr>
<td class="Right" width="25%" align="right" valign="top">商品类别：</td>
<td width="75%">
<select id="OldClassID" name="OldClassID" style="width:200px;height:180px" multiple="multiple">
<%=GetSelect2("ShopClass",0)%>
</select>
</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">新的类别：</td>
<td width="75%">
<select id="ClassID" name="ClassID" style="width:200px;">
<%=GetSelect2("ShopClass",0)%>
</select></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Pro_ChangeClass')"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>