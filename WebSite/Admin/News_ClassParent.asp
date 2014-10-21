<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"News_Class")
ID=ReplaceBadChar(Trim(Request("ID")))
NavParent=ReplaceBadChar(Trim(Request("NavParent")))
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
		'获取导航条排序值
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select NavOrder From NewsClass Where NavParent="&NavParent&" Order By NavOrder Desc"
		Rs.Open Sql,Conn,1,1
		If Not (Rs.Eof Or Rs.Bof) Then
			NavOrder=Cstr(Trim(Rs("NavOrder")))+1
		Else
			NavOrder=1
		End If
		Rs.Close
		Set Rs=Nothing
		'获取导航条深度值
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select NavLevel From NewsClass Where ID="&NavParent&""
		Rs.Open Sql,Conn,1,1
		If Not (Rs.Eof Or Rs.Bof) Then
			NavLevel=Rs("NavLevel")+1
		Else
			NavLevel=1
		End If
		Rs.Close
		Set Rs=Nothing
		
		If Cstr(NavParent)<>Cstr(AryID(i)) Then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From NewsClass Where ID="&AryID(i)&""
		Rs.Open Sql,Conn,1,3
		Rs("NavParent")=NavParent
		Rs("NavOrder")=NavOrder
		Rs("NavLevel")=NavLevel
		Rs.Update
		Rs.Close
		Set Rs=Nothing
		End If
	Next
	Response.Write("<script>alert('\u7c7b\u522b\u79fb\u52a8\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='News_Class.asp?ID="&NavParent&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="News_Class.asp">信息分类维护</a> >> 更改类别所属父类别</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">您可以调整以下导航条的所属父类别，保存之后立即生效。<br>
注意：调整类别之后将直接影响其子类别展示顺序。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post" action="?Action=Save">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th class="Right" colspan="2">更改导航条所属父类别</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">导航条名称：</td>
<td width="75%">
<%
AryID = Split(ID,",")
For i = LBound(AryID) To UBound(AryID)
	If IsNumeric(AryID(i))=True Then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select NavTitle From NewsClass Where ID="&AryID(i)&""
		Rs.Open Sql,Conn,1,1
		Response.Write(Rs("NavTitle")&",")
		Rs.Close
		Set Rs=Nothing
	End If
Next
%>
</td>
</tr>
<tr>
<td class="Right" width="25%" align="right">新的父类别：</td>
<td width="75%">
<select id="NavParent" name="NavParent" style="width:200px;">
<option value="0">|--父类别</option>
<%=GetSelect("NewsClass",0)%>
</select></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='News_Class.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>