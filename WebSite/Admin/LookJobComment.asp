<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
ID=ReplaceBadChar(Trim(Request("ID")))
ParentID=ReplaceBadChar(Trim(Request("ParentID")))

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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="LookJobComment.asp">人才管理内容</a> >>查看内容详情</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="61" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60" height="83"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下所有内容均为只读。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%

	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From JobComment Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	
If Not (Rs.Eof Or Rs.Bof) Then
	JobName=Rs("JobName")
	RealName=Rs("RealName")
	Sex=Rs("Sex")
	Birth=Rs("Birth")
	Marital=Rs("Marital")
	mingzu=Rs("mingzu")
	Origin=Rs("Origin")
	Hobbies=Rs("Hobbies")
	School=Rs("School")
	Profess=Rs("Profess")
	IDNum=Rs("IDNum")
	shengao=rs("shengao")
	Add=Rs("Add")
	Tel=Rs("Tel")
	Email=Rs("Email")
	Salary=Rs("Salary")
	SelfContent=Rs("SelfContent")
	zhengzhi=rs("zhengzhi")
	wenhua=rs("wenhua")
	PostTime=Rs("PostTime")
	waiyu=rs("waiyu")
	diannao=rs("diannao")
	jiaoyu=rs("jiaoyu")
	aihao=rs("aihao")
	qita=rs("qita")
	Rs("JobLock")=1
Rs.Update

End If
Rs.Close
Set Rs=Nothing
%>
<form id="form1" name="form1" method="post" action="?Action=Save">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="ParentID" name="ParentID" value="<%=ParentID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
  <th class="Right" colspan="4">内容详情</th>
</tr>
<tr>
  <td class="Right" align="right">岗位名称:</td>
  <td width="34%"><%=JobName%>&nbsp;</td>
  <td width="12%" align="right">&nbsp;</td>
  <td width="38%">&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">姓　　名：</td>
  <td class="Right"><%=RealName%>&nbsp;</td>
  <td class="Right" align="right">性　　别：</td>
  <td><%=Sex%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">出生日期：</td>
  <td class="Right"><%=Birth%>&nbsp;</td>
  <td class="Right" align="right">婚姻情况：</td>
  <td><%=Marital%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">民　　族：</td>
  <td class="Right"><%=mingzu%>&nbsp;</td>
  <td class="Right" align="right">身　　高：</td>
  <td><%=shengao%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">政治面貌：</td>
  <td class="Right"><%=zhengzhi%>&nbsp;</td>
  <td class="Right" align="right">文化程度：</td>
  <td><%=wenhua%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">籍　　贯：</td>
  <td class="Right"><%=Origin%>&nbsp;</td>
  <td class="Right" align="right">毕业时间：</td>
  <td class="Right"><%=Hobbies%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">毕业院校：</td>
  <td class="Right"><%=School%>&nbsp;</td>
  <td class="Right" align="right">所学专业：</td>
  <td class="Right"><%=Profess%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">邮政编码：</td>
  <td class="Right"><%=IDNum%>&nbsp;</td>
  <td class="Right" align="right">联系地址：</td>
  <td class="Right"><%=Add%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">联系电话：</td>
  <td class="Right"><%=Tel%>&nbsp;</td>
  <td class="Right" align="right">电子邮件：</td>
  <td class="Right"><%=Email%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">外语水平：</td>
  <td class="Right"><%=waiyu%>&nbsp;</td>
  <td class="Right" align="right">电脑水平：</td>
  <td class="Right"><%=diannao%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">期望月薪：</td>
  <td class="Right"><%=Salary%>&nbsp;</td>
  <td class="Right" align="right">应聘时间：</td>
  <td class="Right"><%=posttime%>&nbsp;</td>
</tr>
<tr>
  <td class="Right" align="right">个人简历：</td>
  <td colspan="3"><%=SelfContent%>&nbsp;</td>
  </tr>
  <tr>
  <td class="Right" align="right">教育和培训经历：</td>
  <td colspan="3"><%=jiaoyu%>&nbsp;</td>
  </tr>
   <tr>
  <td class="Right" align="right">爱好及特长：</td>
  <td colspan="3"><%=aihao%>&nbsp;</td>
  </tr>
     <tr>
  <td class="Right" align="right">其他备注：</td>
  <td colspan="3"><%=qita%>&nbsp;</td>
  </tr>
<tr>
  <td class="Right" width="16%" align="right">&nbsp;</td>
  <td colspan="3"><input type="button" value="返 回" class="Button" onClick="window.location.href='JobComment.asp?ID=<%=ParentID%>&Page=<%=Page%>'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>