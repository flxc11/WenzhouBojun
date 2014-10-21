<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"FAQS")
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ParentID=ReplaceBadChar(Trim(Request("ParentID")))
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=ReplaceBadChar(Trim(Request("NavTitle")))
	NavRemark=ReplaceBadChar(Trim(Request("NavRemark")))
	NavContent=Trim(Request("NavContent"))
	EnNavContent=Trim(Request("EnNavContent"))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FAQS Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("NavTitle")=NavTitle
	Rs("NavRemark")=NavRemark
	Rs("NavContent")=NavContent
	Rs("EnNavContent")=EnNavContent
	Rs("NavLock")=NavLock
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u8bf4\u660e\u9875\u4fe1\u606f\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='FAQ.asp?Page="&Page&"&ID="&ParentID&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="FAQ.asp">FAQ内容维护</a> >> FAQ编辑</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下带星号(*)的均不能为空，请准确真实的填写相关信息。<br>
注意：说明页内容可以为图片、动画、文字等任意格式（单击下拉可对内容进行相应的操作）。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#NavTitle").val()=="")
	{
		alert("\u8bf4\u660e\u9875\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NavTitle").focus();
		return false;
	}
	return true;	
}
</script>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From FAQS Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Eof Or Rs.Bof) Then
	NavTitle=Rs("NavTitle")
	NavRemark=Rs("NavRemark")
	NavContent=Rs("NavContent")
	EnNavContent=Rs("EnNavContent")
	NavLock=Rs("NavLock")
End If
Rs.Close
Set Rs=Nothing
%>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="ParentID" name="ParentID" value="<%=ParentID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td class="Right" align="right" valign="middle" style="padding-right:20px;" colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='FAQ.asp?ID=<%=ParentID%>&Page=<%=Page%>'"></td>
</tr>
<tr>
<th class="Right" colspan="2">FAQ编辑</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">FAQ标题：</td>
<td width="75%"><input type="text" id="NavTitle" name="NavTitle" value="<%=NavTitle%>" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">FAQ说明：</td>
<td width="75%"><input type="text" id="NavRemark" name="NavRemark" value="<%=NavRemark%>" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right" valign="top">FAQ内容：</td>
<td width="75%">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
  <div class="float_left">
  <%=Editor2("NavContent",NavContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script>
  </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
  <div class="float_left">
  <%=Editor2("EnNavContent",EnNavContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&EnFrameName=EnNavContent"></script>
  </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
  <div class="float_left" align="center">中文描述</div>
  <div class="float_left">
  <%=Editor2("NavContent",NavContent)%>
  </div>
  <div class="float_left" align="center">英文描述</div>
  <div class="float_left">
  <%=Editor2("EnNavContent",EnNavContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&EnFrameName=EnNavContent&FrameName=NavContent"></script>
  </div>
  <%end if%>
</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">状态：</td>
<td width="75%"><input type="radio" id="NavLock" name="NavLock" value="0"<%If NavLock="0" Then Response.Write(" checked=""checked""")%>/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"<%If NavLock="1" Then Response.Write(" checked=""checked""")%>/>未发布</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='FAQ.asp?ID=<%=ParentID%>&Page=<%=Page%>'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>