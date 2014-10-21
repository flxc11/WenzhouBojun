<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Sys_SiteInfo")
If Request("Action")="Save" Then
SiteName=ReplaceBadChar(Trim(Request("SiteName")))
SiyeKeys=ReplaceBadChar(Trim(Request("SiyeKeys")))
enSiteName=ReplaceBadChar(Trim(Request("enSiteName")))
enSiyeKeys=ReplaceBadChar(Trim(Request("enSiyeKeys")))
SiteDes=ReplaceBadChar(Trim(Request("SiteDes")))
SiteICP=ReplaceBadChar(Trim(Request("SiteICP")))
SiteCopy=ReplaceBadChar(Trim(Request("SiteCopy")))
SiteAuthor=ReplaceBadChar(Trim(Request("SiteAuthor")))
Support=Trim(Request("Support"))
gonggao=Trim(Request("gonggao"))
Set Rs2=Server.CreateObject("Adodb.RecordSet")
Sql2="select * from SiteInfo"
Rs2.Open Sql2,Conn,1,1
if Rs2.Recordcount>0 then
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteInfo where ID=(select top 1 ID from SiteInfo order by ID asc)"
	Rs.Open Sql,Conn,1,3
	Rs("SiteName")=SiteName
	Rs("SiyeKeys")=SiyeKeys
	Rs("enSiteName")=enSiteName
	Rs("enSiyeKeys")=enSiyeKeys
	Rs("SiteDes")=SiteDes
	Rs("SiteICP")=SiteICP
	Rs("SiteCopy")=SiteCopy
	Rs("SiteAuthor")=SiteAuthor
	Rs("Support")=Support
	Rs("gonggao")=gonggao
else
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteInfo"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("SiteName")=SiteName
	Rs("SiyeKeys")=SiyeKeys
	Rs("enSiteName")=enSiteName
	Rs("enSiyeKeys")=enSiyeKeys
	Rs("SiteDes")=SiteDes
	Rs("SiteICP")=SiteICP
	Rs("SiteCopy")=SiteCopy
	Rs("SiteAuthor")=SiteAuthor
	Rs("Support")=Support
	Rs("gonggao")=gonggao
end if
Rs.Update
Rs.Close
Set Rs=Nothing
Rs2.Close
Set Rs2=Nothing
Conn.Close
Set Conn=Nothing
Response.Write("<script>alert('\u7ad9\u70b9\u57fa\u672c\u4fe1\u606f\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Sys_SiteInfo.asp';</script>")
Response.End()
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function CheckForm()
{
	if($("#SiteName").val()==""||document.forme1.SiteName.length==0||window.all["SiteName"].value=="")
	{
		alert("\u8bf7\u8f93\u5165\u7ad9\u70b9\u540d\u79f0\u6216\u6807\u9898\u0021");
		$("#SiteName").focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：站点基本信息维护</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">在这里你可以设置网站的基本信息，保存之后立即生效。<br>
注意：请谨慎操作，保存操作之后所有数据均不可恢复。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<%
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteInfo"
	Rs.Open Sql,Conn,1,1
	if not Rs.eof then
	SiteName=Rs("SiteName")
	SiyeKeys=Rs("SiyeKeys")
	enSiteName=Rs("enSiteName")
	enSiyeKeys=Rs("enSiyeKeys")
	SiteDes=Rs("SiteDes")
	SiteICP=Rs("SiteICP")
	SiteCopy=Rs("SiteCopy")
	SiteAuthor=Rs("SiteAuthor")
	Support=Rs("Support")
	gonggao=Rs("gonggao")
	end if
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
%>

<form id="form1" name="form1" method="post" action="?action=Save" onSubmit="return CheckForm();">
<tr>
<th colspan="3">站点基本信息维护</th>
</tr>
<!--<tr>
<td class="Right" align="right">公司标志图片(200*30px)：</td>
<td width="20%">
	if len(SiteLogo)>0 then
		Response.Write("<img src='"&SiteLogo&"' width='200' height='30'>")
	else
		Response.Write("<img src='images/logo.png' width='200' height='30'>")
	end if
</td>
<td width="50%"><input type="button" value="更换图片" class="Button" onClick="window.location.href='Sys_ChangeLogo.asp'"></td>-->
<!--</tr>-->
<tr>
<td width="25%" class="Right" align="right">站点名称|标题(SiteName)：</td>
<td width="75%" colspan="2"><input type="text" id="SiteName" name="SiteName" value="<%=SiteName%>" class="Input300px" style="width:500px;">
（每个词之间请用“|”分开）</td>
</tr>
<tr>
<td width="25%" class="Right" align="right">站点名称英文标题(SiteName)：</td>
<td width="75%" colspan="2"><input type="text" id="enSiteName" name="enSiteName" value="<%=enSiteName%>" class="Input300px" style="width:500px;">
（每个词之间请用"|"分开）</td>
</tr>
<tr>
<td class="Right" align="right">站点关键字(SiyeKeys)：</td>
<td colspan="2"><input type="text" id="SiyeKeys" name="SiyeKeys" value="<%=SiyeKeys%>" class="Input300px" style="width:500px;">
  （每个词之间请用“|”分开）</td>
</tr>
<tr>
<td class="Right" align="right">站点英文关键字(SiyeKeys)：</td>
<td colspan="2"><input type="text" id="enSiyeKeys" name="enSiyeKeys" value="<%=enSiyeKeys%>" class="Input300px" style="width:500px;">
  （每个词之间请用"|"分开）</td>
</tr>
<tr>
  <td class="Right" align="right">站点描述(SiteDes)：</td>
  <td colspan="2"><textarea id="SiteDes" name="SiteDes" value="" style="width:500px; height:100px;"><%=SiteDes%></textarea></td>
</tr>
<tr>
  <td class="Right" align="right">作者(SiteAuthor)：</td>
  <td colspan="2"><input type="text" id="SiteAuthor" name="SiteAuthor" value="<%=SiteAuthor%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">ICP备案编号(SiteICP)：</td>
<td colspan="2"><input type="text" id="SiteICP" name="SiteICP" value="<%=SiteICP%>" class="Input300px"></td>
</tr>
<tr>
  <td class="Right" align="right">技术支持：</td>
  <td colspan="2"><input type="text" id="Support" name="Support" value="<%=Support%>" class="Input300px">
    （链接地址，请以http://开头）</td>
</tr>
<!--<tr>
  <td class="Right" align="right">公告：</td>
  <td colspan="2"><textarea id="gonggao" name="gonggao" value="" style="width:500px; height:100px;"><%=gonggao%></textarea></td>
</tr>-->

<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Sys_SiteInfo')"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</body>
</html>