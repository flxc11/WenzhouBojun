<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"News_Class")
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ParentID=ReplaceBadChar(Trim(Request("ParentID")))
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=ReplaceBadChar(Trim(Request("NavTitle")))
	EnNavTitle=ReplaceBadChar(Trim(Request("EnNavTitle")))
	NavRemark=ReplaceBadChar(Trim(Request("NavRemark")))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))
	NavContent=Trim(Request("NavContent"))
	NavSPic=Trim(Request("NavSPic"))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From NewsClass Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("NavTitle")=NavTitle
	Rs("EnNavTitle")=EnNavTitle
	Rs("NavRemark")=NavRemark
	Rs("NavLock")=NavLock
	Rs("NavContent")=NavContent
	Rs("NavSPic")=NavSPic
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u7c7b\u522b\u540d\u79f0\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='News_Class.asp?ID="&ParentID&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="News_Class.asp">信息分类维护</a> >> 编辑信息分类</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下带星号(*)的均不能为空，请准确真实的填写相关信息。<br>
注意：您可以进行添加、修改、删除等操作，保存之后立即生效。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#NavTitle").val()=="")
	{
		alert("\u7c7b\u522b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NavTitle").focus();
		return false;
	}
	if ($("#EnNavTitle").val()=="")
	{
		alert("\u7c7b\u522b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#EnNavTitle").focus();
		return false;
	}
	return true;	
}
</script>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From NewsClass Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Eof Or Rs.Bof) Then
	NavTitle=Rs("NavTitle")
	EnNavTitle=Rs("EnNavTitle")
	NavRemark=Rs("NavRemark")
	NavLock=Rs("NavLock")
	ParentID=rs("NavParent")
	NavContent=rs("NavContent")
	NavSPic=rs("NavSPic")
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
<th class="Right" colspan="3">编辑信息分类</th>
</tr>
<tr>
  <td width="27%" align="right" class="Right">类别名称：</td>
  <td width="43%">
   <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
  <div class="float_left_300txt">
    <input type="text" id="NavTitle" name="NavTitle" value="<%=NavTitle%>" class="Input300px"/>
  </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
  <div class="float_left_300txt">
    <input type="text" id="EnNavTitle" name="EnNavTitle" value="<%=EnNavTitle%>" class="Input300px"/>
    </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div class="float_left_300txt">
      <input type="text" id="NavTitle" name="NavTitle" value="<%=NavTitle%>" class="Input300px"/>
      </div>
    <div class="float_left_110">*中文名称，必填</div>
    <div class=" float_left_300txt">
      <input type="text" id="EnNavTitle" name="EnNavTitle" value="<%=EnNavTitle%>" class="Input300px"/>
      </div>
    <div class="float_left_110">*英文名称，必填</div>
  <%end if%>
  </td>
  <td width="30%">&nbsp;</td>
</tr>
<tr>
  <td class="Right" width="27%" align="right">类别说明：</td>
  <td colspan="2"><input type="text" id="NavRemark" name="NavRemark" value="<%=NavRemark%>" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right">类别图片：</td>
  <td colspan="2" class="Right"><input type="text" id="NavSPic" name="NavSPic" readonly="readonly" value="<%=NavSPic%>" class="Input200px" style="background-color:#F5F5F5;"/> 
    <a href="javascript:OpenImageBrowser('NavSPic');">浏览...</a>300*308</td>
  </tr>
<tr>
<td class="Right" align="right" valign="top">类别内容：</td>
<td colspan="3">
<%=Editor2("NavContent",NavContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span>
</td>
</tr>
<tr>
<td class="Right" width="27%" align="right">类别状态：</td>
<td colspan="2"><input type="radio" id="NavLock" name="NavLock" value="0"<%If NavLock="0" Then Response.Write(" checked=""checked""")%>/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"<%If NavLock="1" Then Response.Write(" checked=""checked""")%>/>未发布</td>
</tr>
<tr>
<td class="Right" width="27%" align="right">&nbsp;</td>
<td colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='News_Class.asp?ID=<%=ParentID%>'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>