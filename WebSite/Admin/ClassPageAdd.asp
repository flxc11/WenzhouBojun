<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Page_Class")
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
   ID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	User_NavTitle=ReplaceBadChar(Trim(Request("User_NavTitle")))
	User_EnNavTtile=ReplaceBadChar(Trim(Request("User_EnNavTtile")))
	User_NavRemark=ReplaceBadChar(Trim(Request("User_NavRemark")))
	User_NavLock=ReplaceBadChar(Trim(Request("User_NavLock")))	
	
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select User_NavOrder From User_PageCategory Where User_NavParent="&ID&" Order By User_NavOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		User_NavOrder=Cstr(Trim(Rs("User_NavOrder")))+1
	Else
		User_NavOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	'获取导航条的深度值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select User_NavLevel From User_PageCategory Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		User_NavLevel=Cstr(Trim(Rs("User_NavLevel")))+1
	Else
		User_NavLevel=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From User_PageCategory"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("User_NavTitle")=User_NavTitle
	Rs("User_EnNavTtile")=User_EnNavTtile
	Rs("User_NavRemark")=User_NavRemark
	Rs("User_NavLock")=User_NavLock
	Rs("User_NavOrder")=User_NavOrder
	Rs("User_NavParent")=ID
	Rs("User_NavLevel")=User_NavLevel
	Rs("User_PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u5546\u54c1\u7c7b\u522b\u4fe1\u606f\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='ClassPage.asp?ID="&ID&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="ClassPage.asp">单页类别维护</a> >> 单页类别添加</td>
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
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#User_NavTitle").val()=="")
	{
		alert("\u7c7b\u522b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#User_NavTitle").focus();
		return false;
	}
	if ($("#User_EnNavTtile").val()=="")
	{
		alert("\u7c7b\u522b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#User_EnNavTtile").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="3">单页类别添加</th>
</tr>
<tr>
  <td width="25%" align="right" class="Right">类别名称：</td>
  <td width="44%">
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
    <div class="float_left_300txt">
      <input type="text" id="User_NavTitle" name="User_NavTitle" value="" class="Input300px"/>
      </div>
      <div class="float_left_110">*（必填）</div>
    <%end if%>
    <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
    <div class="float_left_300txt">
      <input type="text" id="User_EnNavTtile" name="User_EnNavTtile" value="" class="Input300px"/>
      </div>
      <div class="float_left_110">*（必填）</div>
    <%end if%>
    <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div class="float_left_300txt">
      <input type="text" id="User_NavTitle" name="User_NavTitle" value="" class="Input300px"/>
      </div>
    <div class="float_left_110">*（中文，必填）</div>
    <div class="float_left_300txt">
      <input type="text" id="User_EnNavTtile" name="User_EnNavTtile" value="" class="Input300px"/>
      </div>
    <div class="float_left_110"> *（英文，必填）</div>
    <%end if%>
  </td>
  <td width="31%">&nbsp;</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">类别说明：</td>
  <td colspan="2"><input type="text" id="User_NavRemark" name="User_NavRemark" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">类别状态：</td>
<td colspan="2"><input type="radio" id="User_NavLock" name="User_NavLock" value="0" checked="checked"/>已发布<input type="radio" id="User_NavLock" name="User_NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='ClassPage.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>