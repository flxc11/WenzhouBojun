<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Sys_UserList")
Action=ReplaceBadChar(Trim(Request("Action")))
UserID=ReplaceBadChar(Trim(Request("UserID")))
Select Case Action
Case "Reset"
	AryUserID = Split(UserID,",")
	For i = LBound(AryUserID) To UBound(AryUserID)
		If IsNumeric(AryUserID(i))=True Then
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select * From Admin Where ID="&AryUserID(i)&""
			Rs.Open Sql,Conn,1,3
			Rs("UserPass")=Md5("123456",32)
			Rs.Update
			Rs.Close
			Set Rs=Nothing
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u606d\u559c\uff0c\u6210\u529f\u5c06\u9009\u4e2d\u7684\u7ba1\u7406\u8d26\u53f7\u5bc6\u7801\u91cd\u7f6e\u6210\u0031\u0032\u0033\u0034\u0035\u0036\u3002');window.location.href='Sys_UserList.asp';</script>")
	Response.End()
Case "Delete"
	AryUserID = Split(UserID,",")
	For i = LBound(AryUserID) To UBound(AryUserID)
		If IsNumeric(AryUserID(i))=True Then
			AdminName=Conn.Execute("Select UserName From Admin Where ID="&AryUserID(i)&"")(0)
			Conn.Execute("Delete From Admin Where ID="&AryUserID(i)&"")
			Conn.Execute("Delete From AdminGroup Where UserName='"&AdminName&"'")
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u606d\u559c\uff0c\u6210\u529f\u5220\u9664\u4e86\u9009\u4e2d\u7684\u7ba1\u7406\u8d26\u53f7\u3002');window.location.href='Sys_UserList.asp';</script>")
	Response.End()
End Select
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script language="javascript" type="text/javascript">
function Reset()
{
	var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u5b9a\u8981\u5bf9\u9009\u4e2d\u7684\u7ba1\u7406\u8d26\u53f7\u91cd\u7f6e\u5bc6\u7801\u5417\uff1f\u9ed8\u8ba4\u7ba1\u7406\u5bc6\u7801\uff1a\u0031\u0032\u0033\u0034\u0035\u0036')) {
        window.location.href = 'Sys_UserList.asp?Action=Reset&UserID=' + l;
    }
}
function Delete() {
    var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u8ba4\u8981\u5c06\u9009\u4e2d\u7684\u7ba1\u7406\u8d26\u53f7\u5220\u9664\u5417\uff1f')) {
        window.location.href = 'Sys_UserList.asp?Action=Delete&UserID=' + l;
    }
}
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：分类页内容维护</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下为能够登录系统后台的所有管理员信息列表。<br>
注意：您可以进行密码重置、操作权限设置等操作，保存之后立即生效。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<form id="form1" name="form1" method="post">
<tr>
<th width="5%" class="Right"><input type="checkbox" name="chkSelectAll" onClick="doCheckAll(this)"></th>
<th width="15%" class="Right">登录账号</th>
<th width="15%" class="Right">出生年月</th>
<th width="25%" class="Right">密码取回问题</th>
<th width="30%" class="Right">密码取回答案</th>
<th width="10%">管理操作</th>
</tr>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From Admin Where ISAdmin=0 Order By ID Desc"
Rs.Open Sql,Conn,1,1
Dim Page
Page=Request("Page")                            
PageSize = 10                                           
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page                         
i=0
Do While Not Rs.Eof And i<Rs.PageSize
%>
<tr>
<td class="Right"><input type="checkbox" name="ID" value="<%=Rs("ID")%>"></td>
<td class="Right"><%=Rs("UserName")%></td>
<td class="Right"><%=Year(Rs("Birthday"))%>-<%=Month(Rs("Birthday"))%>-<%=Day(Rs("Birthday"))%></td>
<td class="Right"><%=Rs("Question")%></td>
<td class="Right"><%=Rs("Answer")%></td>
<td><a href="Sys_UserList.asp?Action=Reset&UserID=<%=Rs("ID")%>" onclick="if(!confirm('\u786e\u8ba4\u8981\u5bf9\u8be5\u7ba1\u7406\u8d26\u53f7\u8fdb\u884c\u5bc6\u7801\u91cd\u7f6e\u7684\u64cd\u4f5c\u5417\uff1f\u9ed8\u8ba4\u5bc6\u7801\uff1a\u0031\u0032\u0033\u0034\u0035\u0036')) return false;">重置</a>&nbsp;┊&nbsp;<a href="Sys_UserGroup.asp?UserName=<%=Rs("UserName")%>">授权</a></td>
</tr>
<%
i=i+1
Rs.MoveNext
Loop
%>
<tr>
<th colspan="3" style="font-weight:normal">操作：<a href="javascript:Reset();" style="font-weight:normal">重置</a>&nbsp;┊&nbsp;<a href="javascript:Delete();" style="font-weight:normal">删除</a></th>
<th colspan="2" style="font-weight:normal;text-align:right">共<%=Rs.PageCount%>页&nbsp;第<%=Page%>页&nbsp;<%=PageSize%>条/页&nbsp;共<%=Total%>条&nbsp;
<%if Page=1 then%>
首 页&nbsp;上一页&nbsp;
<%Else%>
<a href="?Page=1">首 页</a>&nbsp;<a href="?Page=<%=Page-1%>">上一页</a>&nbsp;
<%End If%>
<%If Rs.PageCount-Page<1 Then%>下一页&nbsp;尾 页&nbsp;
<%Else%><a href="?Page=<%=Page+1%>">下一页</a>&nbsp;<a href="?Page=<%=Rs.PageCount%>">尾 页</a>&nbsp;
<%End If%>
</th>
<th>
<select style="FONT-SIZE: 9pt; FONT-FAMILY: 宋体;width:90%;" onChange="location=this.options[this.selectedIndex].value" name="Menu_1"> 
<%For Pagei=1 To Rs.PageCount%>
<%if Cint(Pagei)=Cint(Page) Then%>
<option value="?Page=<%=Pagei%>" selected="selected">第<%=Pagei%>页</option>
<%Else%>
<option value="?Page=<%=Pagei%>">第<%=Pagei%>页</option>
<%End If%>
<%Next%>
</select>
</th>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>