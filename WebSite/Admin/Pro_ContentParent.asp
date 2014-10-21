<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Pro_ContentListIn")
ID=ReplaceBadChar(Trim(Request("ID")))
FileName=ReplaceBadChar(Trim(Request("FileName")))
Action=ReplaceBadChar(Trim(Request("Action")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
ShowType=ReplaceBadChar(Trim(Request("ShowType")))
If Action="Save" Then
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)		
		If Cstr(NavParent)<>Cstr(AryID(i)) Then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From ShopInfo Where ID="&AryID(i)&""
		Rs.Open Sql,Conn,1,3
		Rs("ClassID")=ClassID
		Rs.Update
		Rs.Close
		Set Rs=Nothing
		End If
	Next
	Response.Write("<script>alert('\u5546\u54c1\u6240\u5c5e\u7236\u7c7b\u79fb\u52a8\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='"&FileName&".asp?ClassID="&ClassID&"&ShowType="&ShowType&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：商品管理 >> 更改商品所属父类别</td>
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
<input type="hidden" id="FileName" name="FileName" value="<%=FileName%>"/>
<input type="hidden" id="ShowType" name="ShowType" value="<%=ShowType%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="2">更改商品所属父类</th>
</tr>
<tr>
<td class="Right" width="25%" align="right">商品名称：</td>
<td width="75%" style="line-height:150%">
<%
AryID = Split(ID,",")
For i = LBound(AryID) To UBound(AryID)
	If IsNumeric(AryID(i))=True Then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select ShopName From ShopInfo Where ID="&AryID(i)&""
		Rs.Open Sql,Conn,1,1
		Response.Write(Rs("ShopName")&"&nbsp;&nbsp;")
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
<select id="ClassID" name="ClassID" style="width:200px;">
<%=GetSelect("ShopClass",0)%>
</select></td>
</tr>
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='<%=FileName%>.asp?ShowType=<%=ShowType%>'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>