<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Pro_ContentListOut")
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If ClassID="" Then ClassID=0
ShowType=ReplaceBadChar(Trim(Request("ShowType")))
If ShowType="" Then ShowType=0
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Pro_ContentListOut.asp">商品管理</a> >> <a href="Pro_ContentListOut.asp">下架商品</a> >> 查找商品</td>
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
<form id="form1" name="form1" method="post" action="Pro_ContentListOut.asp?ClassID=<%=ClassID%>&ShowType=<%=ShowType%>">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="2">下架商品查找</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">商品名称：</td>
<td width="75%" style="line-height:150%"><input type="text" id="ShopName" name="ShopName" value="" class="Input200px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">商品类别：</td>
<td width="75%">
<select id="ClassID" name="ClassID" style="width:200px;">
<option value="0">所有类别</option>
<%=GetSelect("ShopClass",0)%>
</select></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="查 找" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Pro_ContentListOut.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>