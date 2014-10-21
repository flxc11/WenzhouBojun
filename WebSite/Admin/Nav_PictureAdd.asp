<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Nav_Picture")
ClassID=Trim(Request("ClassID"))
If ClassID="" Then
   ClassID=0
End If
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
   ID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=ReplaceBadChar(Trim(Request("NavTitle")))
	EnNavTitle=Trim(Request("EnNavTitle"))
	NavRemark=ReplaceBadChar(Trim(Request("NavRemark")))
	NavPicture=Trim(Request("NavPicture"))
	NavContent=Trim(Request("NavContent"))
	NavLock=Trim(Request("NavLock"))
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavOrder From SitePicture Order By NavOrder Desc"
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
	Sql="Select NavLevel From SitePicture Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavLevel=Cstr(Trim(Rs("NavLevel")))+1
	Else
		NavLevel=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SitePicture"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("NavTitle")=NavTitle
	Rs("EnNavTitle")=EnNavTitle
	Rs("NavRemark")=NavRemark
	Rs("NavPicture")=NavPicture
	Rs("NavLock")=NavLock
	Rs("NavContent")=NavContent
	Rs("NavOrder")=NavOrder
	Rs("NavParent")=ID
	Rs("NavLevel")=NavLevel
	Rs("ClassID")=ClassID
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u56fe\u7247\u5185\u5bb9\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Nav_PictureAdd.asp?ID="&ID&"';</script>")
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
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Nav_Picture.asp">图片内容维护</a> >> 添加图片内容</td>
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
	if ($("#NavTitle").val()==""||$("#EnNavTitle").val()=="")
	{
		alert("\u56fe\u7247\u5185\u5bb9\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NavTitle").focus();
		return false;
	}
	if($("#ClassID").val()==0)
	{
		alert("\u8bf7\u9009\u62e9\u680f\u76ee\u0021");
		$("#ClassID").focus();
		return false;
	}
	if($("#NavPicture").val()=="")
	{
		alert("\u8bf7\u9009\u62e9\u4e0a\u4f20\u56fe\u7247\uff01");
		$("#Pic_btn").focus();
		return false;
	}
	return true;
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onsubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Nav_Picture.asp'"></td>
</tr>
<tr>
<th colspan="4">添加图片内容</th>
</tr>
<tr>
<td class="Right" width="15%" align="right">图片内容名称：</td>
<td class="Right"><div class="float_left_300txt">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
<div class="float_left_210txt"><input type="text" id="NavTitle" name="NavTitle" value="" class="Input200px"/></div>
<div class="float_left_90">*(必填)</div>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
<div class="float_left_210txt"><input type="text" id="EnNavTitle" name="EnNavTitle" value="" class="Input200px"/></div><div class="float_left_90">*(必填)</div>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
<div class="float_left_210txt"><input type="text" id="NavTitle" name="NavTitle" value="" class="Input200px"/></div><div class="float_left_90">*(必填)</div>
<div class="float_left_210txt"><input type="text" id="EnNavTitle" name="EnNavTitle" value="" class="Input200px"/></div><div class="float_left_90">*(必填)</div>
<%end if%>
</td>
<%if Request.Cookies("CNVP_CMS2")("ClassPage")="true" then%>
<td width="5%" align="right" class="Right">类别：</td>
<td width="37%">
<select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">请选择栏目</option>
  <%=GetPageSelect("User_PageCategory",0)%>
  </select>
</td>
<%end if%>
</tr>
<tr>
<td class="Right" width="15%" align="right">图片内容说明：</td>
<td colspan="3" class="Right"><input type="text" id="NavRemark" name="NavRemark" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="15%" align="right">上传图片：</td>
<td width="43%" class="Right"><div class="float_left_300txt"><input type="text" id="NavPicture" name="NavPicture" readonly="readonly" class="Input300px"></div><div class="float_left_25">*(必填)</div></td>
<td colspan="2"><input type="button" id="Pic_btn" value="浏览图片" class="Button" onclick="OpenImageBrowser('NavPicture');"/></td>
</tr>
<tr>
<td class="Right" width="15%" align="right" valign="top">图片详细内容：</td>
<td colspan="3">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
<%=Editor2("NavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
<%=Editor2("EnNavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=EnNavContent"></script>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
<div class="float_left_90">中文描述</div>
<%=Editor2("NavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script><br/>
<div class="float_left_90">英文描述</div>
<%=Editor2("EnNavContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=EnNavContent"></script>
<%end if%>
</td>
</tr>
<tr>
<td class="Right" width="15%" align="right">导航条状态：</td>
<td colspan="3"><input type="radio" id="NavLock" name="NavLock" value="0" checked="checked"/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="15%" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.history.go(-1)"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>