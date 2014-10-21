<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"OnLineJobs")
Action=ReplaceBadChar(Trim(Request("Action")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If ClassID="" Then
	ClassID="0"
End If
If Action="Save" Then
	Jobs=ReplaceBadChar(Trim(Request("Jobs")))
	EnJobs=Trim(Request("EnJobs"))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	TitleRequest=Trim(Request("TitleRequest"))
	EnTitleRequest=Trim(Request("EnTitleRequest"))
	JobNumber=Request("JobNumber")
	RDepart=Trim(Request("RDepart"))
	EnRDepart=Trim(Request("EnRDepart"))
	Gender=ReplaceBadChar(Trim(Request("Gender")))
	EnGender=ReplaceBadChar(Trim(Request("EnGender")))
	Experience=Trim(Request("Experience"))
	EnExperience=Trim(Request("EnExperience"))
	Education=ReplaceBadChar(Trim(Request("Education")))
	EnEducation=ReplaceBadChar(Trim(Request("EnEducation")))
	Age=Trim(Request("Age"))
	Profession=ReplaceBadChar(Trim(Request("Profession")))
	EnProfession=ReplaceBadChar(Trim(Request("EnProfession")))
	WorkAreas=ReplaceBadChar(Trim(Request("WorkAreas")))
	EnWorkAreas=ReplaceBadChar(Trim(Request("EnWorkAreas")))
	EffectiveLimit=Trim(Request("EffectiveLimit"))
	EnEffectiveLimit=ReplaceBadChar(Trim(Request("EnEffectiveLimit")))
	ContactName=ReplaceBadChar(Trim(Request("ContactName")))
	Phone=ReplaceBadChar(Trim(Request("Phone")))
	Fax=Trim(Request("Fax"))
	Email=Trim(Request("Email"))
	Address=ReplaceBadChar(Trim(Request("Address")))
	EnAddress=Trim(Request("EnAddress"))
	RAT=Trim(Request("RAT"))
	EnRAT=ReplaceBadChar(Trim(Request("EnRAT")))
	PostTime=Trim(Request("PostTime"))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From JobInfo where ID="&session("ID")
	Rs.Open Sql,Conn,1,3
	Rs("Jobs")=Jobs
	Rs("EnJobs")=EnJobs
	Rs("ClassID")=ClassID
	Rs("TitleRequest")=TitleRequest
	Rs("EnTitleRequest")=EnTitleRequest
	Rs("JobNumber")=JobNumber
	Rs("RDepart")=RDepart
	Rs("EnRDepart")=EnRDepart
	Rs("Gender")=Gender
	Rs("EnGender")=EnGender
	Rs("Experience")=Experience
	Rs("EnExperience")=EnExperience
	Rs("Education")=Education
	Rs("EnEducation")=EnEducation
	Rs("Age")=Age
	Rs("Profession")=Profession
	Rs("EnProfession")=EnProfession
	Rs("WorkAreas")=WorkAreas
	Rs("EnWorkAreas")=EnWorkAreas
	Rs("EffectiveLimit")=EffectiveLimit
	Rs("EnEffectiveLimit")=EnEffectiveLimit
	Rs("ContactName")=ContactName
	Rs("Phone")=Phone
	Rs("Fax")=Fax
	Rs("Email")=Email
	Rs("Address")=Address
	Rs("EnAddress")=EnAddress
	Rs("RAT")=RAT
	Rs("EnRAT")=EnRAT
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	session("ID")=""
	Response.Write("<script>alert('\u4fe1\u606f\u5185\u5bb9\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Job_List.asp';</script>")
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
	$("#ClassID").val("<%=ClassID%>");
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：招聘管理 >> 职位修改</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.招聘内容你可以设置会员阅读权限，仅网站注册会员方能阅读该信息。<br />
2.管理员可对招聘内容的每一项进行筛选，确定是否启用。（在系统维护里操作）<br/>
    注意：不想对外发布的信息你可以设置成锁定状态。
  </td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
	session("ID")=Request("ID")
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From JobInfo where ID="&session("ID")
	Rs.Open Sql,Conn,1,3
	Jobs=Rs("Jobs")
	EnJobs=Rs("EnJobs")
	ClassID=Rs("ClassID")
	TitleRequest=Rs("TitleRequest")
	EnTitleRequest=Rs("EnTitleRequest")
	JobNumber=Rs("JobNumber")
	RDepart=Rs("RDepart")
	EnRDepart=Rs("EnRDepart")
	Gender=Rs("Gender")
	EnGender=Rs("EnGender")
	Experience=Rs("Experience")
	EnExperience=Rs("EnExperience")
	Education=Rs("Education")
	EnEducation=Rs("EnEducation")
	Age=Rs("Age")
	Profession=Rs("Profession")
	EnProfession=Rs("EnProfession")
	WorkAreas=Rs("WorkAreas")
	EnWorkAreas=Rs("EnWorkAreas")
	EffectiveLimit=Rs("EffectiveLimit")
	EnEffectiveLimit=Rs("EnEffectiveLimit")
	ContactName=Rs("ContactName")
	Phone=Rs("Phone")
	Fax=Rs("Fax")
	Email=Rs("Email")
	Address=Rs("Address")
	EnAddress=Rs("EnAddress")
	RAT=Rs("RAT")
	EnRAT=Rs("EnRAT")
	Rs.Close
	Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#Jobs").val()=="")
	{
		alert("\u4fe1\u606f\u6807\u9898\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#Jobs").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Job_List.asp'"></td>
</tr>
<tr>
<th colspan="4">职位修改</th>
</tr>
<tr>
<td width="11%" align="right" class="Right">职位名称：</td>
<td width="35%" class="Right">
  <div class="float_left_210txt">
	<input type="text" id="Jobs" name="Jobs" value="<%=Jobs%>" class="Input200px"/>
  </div>
  <div class="float_left_25">*（必填）</div></td>
<td width="11%" align="right" class="Right">招聘类别：</td>
<td width="43%"><select id="ClassID" name="ClassID" style="width:200px;">

<%=GetSelect("JobClass",0)%>
</select></td>
</tr>
<tr>
<td class="Right" align="right">招聘人数：</td>
<td class="Right"><input type="text" id="JobNumber" name="JobNumber" value="<%=JobNumber%>" class="Input200px"/>
人 </td>
<td align="right" class="Right">性别要求：</td>
<td><select id="Gender" name="Gender" style="width:200px;">
  <option value="不限">不限</option>
  <option value="男">男</option>
  <option value="女">女</option>
</select></td>
</tr>
<tr>
  <td class="Right" align="right">工作经验：</td>
  <td class="Right">
  <div class="float_left_210txt">
	<input type="text" id="Experience" name="Experience" value="<%=Experience%>" class="Input200px"/>
  </div>  </td>
  <td align="right" class="Right">学历要求：</td>
  <td>
  <div class="float_left_210txt">
	<input type="text" id="Education" name="Education" value="<%=Education%>" class="Input200px"/>
  </div>  </td>
</tr>
<tr>
  <td class="Right" align="right"> 年龄要求：</td>
  <td class="Right"><input type="text" id="Age" name="Age" value="<%=Age%>" class="Input200px"/></td>
  <td align="right" class="Right">专业要求：</td>
  <td>
  <div class="float_left_210txt">
	<input type="text" id="Profession" name="Profession" value="<%=Profession%>" class="Input200px"/>
  </div>  </td>
</tr>
<tr>
  <td class="Right" align="right">工作地区：</td>
  <td class="Right">
  <div class="float_left_210txt">
	<input type="text" id="WorkAreas" name="WorkAreas" value="<%=WorkAreas%>" class="Input200px"/>
  </div>  </td>
  <td align="right" class="Right">待遇：</td>
  <td><input type="text" id="EffectiveLimit" name="EffectiveLimit" value="<%=EffectiveLimit%>" class="Input200px"/></td>
</tr>
<tr>
  <td class="Right" align="right">要求与待遇：</td>
  <td colspan="3" class="Right">
  <div class="float_left">
  <%=Editor2("RAT",RAT)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=RAT"></script>
  </div>  </td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input name="button" type="button" class="Button" onclick="window.location.href='Job_List.asp'" value="返 回" /></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>