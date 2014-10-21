<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Nav_Explain")
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If ClassID="" Then
   ClassID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=ReplaceBadChar(Trim(Request("NavTitle")))
	NavRemark=Trim(Request("NavRemark"))
	PicAddress=Trim(Request("PicAddress"))
	UpLoadAddress=Trim(Request("UpLoadAddress"))
	NavContent=Trim(Request("NavContent"))
	EnNavContent=Trim(Request("EnNavContent"))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))
	EnNavTitle=Trim(Request("EnNavTitle"))
	
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavOrder From SiteExplain Order By NavOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavOrder=Cstr(Trim(Rs("NavOrder")))+1
	Else
		NavOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SiteExplain"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("ClassID")=ClassID
	Rs("NavTitle")=NavTitle
	Rs("NavRemark")=NavRemark
	Rs("PicAddress")=PicAddress
	Rs("UpLoadAddress")=UpLoadAddress
	Rs("NavContent")=NavContent
	Rs("EnNavContent")=EnNavContent
	Rs("NavOrder")=NavOrder
	Rs("NavLock")=NavLock
	Rs("EnNavTitle")=EnNavTitle
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u8bf4\u660e\u9875\u4fe1\u606f\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Nav_Explain.asp?ID="&ID&"';</script>")
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
	$("#ClassID").val("<%=Request("ClassID")%>");
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Nav_Explain.asp">单页内容维护</a> >> 添加单页内容</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下带星号(*)的均不能为空，请准确真实的填写相关信息。<br />
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
		alert("\u5185\u5bb9\u6807\u9898\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		$("#NavTitle").focus();
		return false;
	}
	if($("#EnNavTitle").val()=="")
	{
		alert("\u5185\u5bb9\u6807\u9898\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		$("#EnNavTitle").focus();
		return false;
	}
	if($("#ClassID").val()==0)
	{
		alert("\u8bf7\u9009\u62e9\u680f\u76ee\u0021");
		$("#ClassID").focus();
		return false;
	}
	if($("#UpLoadAddress").val()!=""&&$("#UpLoadAddress").val().indexOf(".txt")<=0)
	{
		alert("\u4e0a\u4f20\u7684\u5730\u5740\u4e0d\u6b63\u786e\uff0c\u8bf7\u91cd\u65b0\u4e0a\u4f20\u0021");
		$("#UpLoadAddress").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td class="Right" colspan="4" align="left"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Nav_Explain.asp'"></td>
</tr>
<tr>
<th class="Right" colspan="4">添加单页内容</th>
</tr>
<tr>
<td class="Right" width="13%" align="right">内容标题：</td>
<td width="46%" class="Right">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
<div class="float_left_300txt"><input type="text" id="NavTitle" name="NavTitle" value="" class="Input300px"/></div>
<div class="float_left_90">*必填</div>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
<div class="float_left_300txt"><input type="text" id="EnNavTitle" name="EnNavTitle" value="" class="Input300px"/></div>
<div class="float_left_90">*必填</div>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
<div class="float_left_300txt"><input type="text" id="NavTitle" name="NavTitle" value="" class="Input300px"/></div>
<div class="float_left_90">*必填</div>
<div class="float_left_300txt"><input type="text" id="EnNavTitle" name="EnNavTitle" value="" class="Input300px"/></div>
<div class="float_left_90">*必填</div>
<%end if%>
</td>
<td width="6%" align="right" class="Right">类别：</td>
<td width="35%">
 <select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">|--请选择类别</option>
  <%=GetPageSelect("User_PageCategory",0)%>
  </select>
</td>
</tr>
<tr>
<td class="Right" width="13%" align="right">说明：</td>
<td colspan="3"><input type="text" id="NavRemark" name="NavRemark" value="" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right">上传图片：</td>
  <td align="left" valign="middle" class="Right">
  <div class="float_left_300txt"><input type="text" id="PicAddress" name="PicAddress" readonly="readonly" class="Input300px" style="background-color:#F5F5F5;" /></div>
  <div class="float_left_60">980*480</div></td>
  <td colspan="2"><input type="button" id="Pic_btn" value="浏览图片" class="Button" onclick="OpenImageBrowser('PicAddress');"/></td>
  </tr>
  <!--
<tr>
  <td class="Right" align="right">上传：</td>
  <td colspan="3"><input type="text" id="UpLoadAddress" name="UpLoadAddress" value="" readonly="readonly" class="Input300px" style="width:500px; background-color:#F5F5F5;"/>
     <a href="javascript:OpenImageBrowser('UpLoadAddress');">浏览</a>...&nbsp;┊&nbsp;<a href="#" onclick="document.getElementById('UpLoadAddress').value=''">清空</a>&nbsp;(注意：字数超过2500个请用文本文档上传)</td>
</tr>-->
<tr>
<td class="Right" width="13%" align="right" valign="top">单页内容：</td>
<td colspan="3">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
  <%=Editor2("NavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
  <%=Editor2("EnNavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&EnFrameName=EnNavContent"></script>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
  <div class="float_left_90">中文描述</div>
  <%=Editor2("NavContent","")%>
  <div class="float_left_90">英文描述</div>
  <%=Editor2("EnNavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&EnFrameName=EnNavContent&FrameName=NavContent"></script>
  <%end if%>
</td>
</tr>
<tr>
<td class="Right" width="13%" align="right">状态：</td>
<td colspan="3"><input type="radio" id="NavLock" name="NavLock" value="0" checked="checked"/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="13%" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Nav_Explain.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>