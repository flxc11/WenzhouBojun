<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->

<%
Call ISPopedom(UserName,"Site_Version")
If Request("Action")="Save" Then
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From SiteVersion order by ID asc"
Rs.Open Sql,Conn,1,1
if not (Rs.eof and Rs.bof) and Rs.RecordCount>0 then
	VersionNo=Request("SiteVersion")
	Set Rs2=Server.CreateObject("Adodb.RecordSet")
	Sql2="Select * From SiteVersion where ID="&Rs("ID")
	Rs2.Open Sql2,Conn,1,3
	Rs2("VersionNo")=VersionNo
	Rs2.UpDate
	Rs2.close
	Set Rs2=Nothing
else
	VersionNo=Request("SiteVersion")
	Set Rs2=Server.CreateObject("Adodb.RecordSet")
	Sql2="Select * From SiteVersion"
	Rs2.Open Sql2,Conn,1,3
	Rs2.AddNew
	Rs2("VersionNo")=VersionNo
	Rs2.UpDate
	Rs2.close
	Set Rs2=Nothing
end if
Rs.Close
Set Rs=Nothing
Conn.Close
Set Conn=Nothing
Response.Write("<script>alert('\u7ad9\u70b9\u4e2d\u82f1\u6587\u7248\u672c\u8bbe\u7f6e\u6210\u529f\u3002');window.location.href='Site_Version.asp';</script>")
Response.End()
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
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
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：站点中英文版本设置</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.以下所谓的版式本设置只是对后台添加数据时有中英文的区别。<br/>2.在设置完成后保存立即生效。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<%
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteVersion"
	Rs.Open Sql,Conn,1,1
	Response.Cookies("CNVP_CMS2")("SiteVersion")=Rs("VersionNo")
	Rs.close
	Set Rs=Nothing
	Conn.close
	Set Conn=Nothing
%>
<form id="form1" name="form1" method="post" action="?action=Save">
<tr>
<th colspan="2">站点中英文版本设置(只对添加内容区别)</th>
</tr>
<tr>
<td width="25%" align="right" class="Right">中文版：</td>
<td width="75%">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
<input type="radio" name="SiteVersion" id="SiteVersion" value="Chiness" checked="checked" />中文版（Chiness）
<%else%>
<input type="radio" name="SiteVersion" id="SiteVersion" value="Chiness"/>中文版（Chiness）
<%end if%>
</td>
</tr>
<tr>
  <td align="right" class="Right">英文版：</td>
  <td width="75%">
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
  <input type="radio" name="SiteVersion" id="SiteVersion2" value="English" checked="checked"/>英文版（English）
  <%else%>
  <input type="radio" name="SiteVersion" id="SiteVersion2" value="English" />英文版（English）
  <%end if%>
  </td>
</tr>
<tr>
  <td class="Right" align="right">中英文版：</td>
  <td>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
  <input type="radio" name="SiteVersion" id="SiteVersion" value="CAndE" checked="checked"/>中英文版（Chiness And English）
  <%else%>
  <input type="radio" name="SiteVersion" id="SiteVersion" value="CAndE"/>中英文版（Chiness And English）
  <%end if%>
  </td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Site_Version')"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript" src="Common/PopCalender.js"></script>
</body>
</html>