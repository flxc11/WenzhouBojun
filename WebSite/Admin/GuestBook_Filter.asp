<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->

<%
Call ISPopedom(UserName,"GuestBook_Filter")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：访客留言关键字过滤</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.<span class="Right">不文明字符过滤</span>指一些脏话、粗话、骂人等的一字词；<br/>
2.<span class="Right">JS脚本过滤指过滤类似于：&lt;script&gt;&lt;/script&gt;的一般的脚本语言；<br>
3.
特殊字符过滤</span>指浏览器上出现的html、asp、head等其它会影响网站正常运行的字符；</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<%
	'Set Rs=Server.CreateObject("Adodb.RecordSet")
'	Sql="Select * From SiteVersion"
'	Rs.Open Sql,Conn,1,1
'	Rs.close
'	Set Rs=Nothing
'	Conn.close
'	Set Conn=Nothing
%>
<form id="form1" name="form1" method="post" action="?action=Save">
<tr>
<th colspan="2"><span style="border-bottom:solid 1px #dde4e9;height:30px">访客留言关键字过滤</span></th>
</tr>
<tr>
<td width="25%" align="right" class="Right">不文明字符过滤：</td>
<td width="75%">&nbsp;</td>
</tr>
<tr>
  <td align="right" class="Right">JS脚本过滤：</td>
  <td width="75%">&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">特殊字符过滤：</td>
  <td>&nbsp;</td>
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