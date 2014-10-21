<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"FAQS")
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
   ID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=Trim(Request("NavTitle"))
	NavRemark=ReplaceBadChar(Trim(Request("NavRemark")))
	NavContent=Trim(Request("NavContent"))
	EnNavContent=Trim(Request("EnNavContent"))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))	
	
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavOrder From FAQS Where NavParent="&ID&" Order By NavOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavOrder=Cstr(Trim(Rs("NavOrder")))+1
	Else
		NavOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	'获取导航条的深度值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavLevel From FAQS Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavLevel=Cstr(Trim(Rs("NavLevel")))+1
	Else
		NavLevel=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FAQS"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("NavTitle")=NavTitle
	Rs("NavRemark")=NavRemark
	Rs("NavContent")=NavContent
	Rs("EnNavContent")=EnNavContent
	Rs("NavLock")=NavLock
	Rs("NavOrder")=NavOrder
	Rs("NavParent")=ID
	Rs("NavLevel")=NavLevel
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u8bf4\u660e\u9875\u4fe1\u606f\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='FAQ_Add.asp?ID="&ID&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Nav_Explain.asp">说明页内容维护</a> >> 添加说明页</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下所有项目均不能为空，请准确真实的填写相关信息。<br>
注意：说明页内容可以为图片、动画、文字等任意格式。</td>
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
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th class="Right" colspan="2">FAQ添加</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">FAQ标题：</td>
<td width="75%"><input type="text" id="NavTitle" name="NavTitle" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">FAQ说明：</td>
<td width="75%"><input type="text" id="NavRemark" name="NavRemark" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right" valign="top">FAQ内容：</td>
<td width="75%">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
  <div class="float_left">
  <%=Editor2("NavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script>
  </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
  <div class="float_left">
  <%=Editor2("EnNavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&EnFrameName=EnNavContent"></script>
  </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
  <div class="float_left" align="center">中文描述</div>
  <div class="float_left">
  <%=Editor2("NavContent","")%>
  </div>
  <div class="float_left" align="center">英文描述</div>
  <div class="float_left">
  <%=Editor2("EnNavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&EnFrameName=EnNavContent&FrameName=NavContent"></script>
  </div>
  <%end if%>
</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">状态：</td>
<td width="75%"><input type="radio" id="NavLock" name="NavLock" value="0" checked="checked"/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='FAQ.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>