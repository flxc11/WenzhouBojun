<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Log")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Select Case Action
Case "Delete"
	Page=ReplaceBadChar(Trim(Request("Page")))
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
		If IsNumeric(AryID(i))=True Then
			Conn.Execute("Delete From LoginLogInfo Where ID="&AryID(i)&"")
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u5220\u9664\u64cd\u4f5c\u6210\u529f\uff0c\u786e\u5b9a\u540e\u8fd4\u56de\u5217\u8868\u9875\u9762\u3002');window.location.href='?Page="&Page&"&ClassID="&ClassID&"';</script>")
	Response.End()
End Select
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="News_List.asp">后台登录日志维护</a></td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下为后台用户登入的信息状态。</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<th width="5%" class="Right">序号</th>
<th width="12%" class="Right">用户</th>
<th width="9%" class="Right">权限</th>
<th width="13%" class="Right">登录IP</th>
<th width="37%" class="Right">浏览器</th>
<th width="14%" class="Right">创建时间</th>
<th width="3%" class="Right"><input type="checkbox" name="chkSelectAll" onclick="doCheckAll(this)" /></th>
<th width="7%">操作</th>
</tr>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From LoginLogInfo Order By PostTime Desc"
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
<tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
<td class="Right"><%=i%></td>
<td class="Right">
<%
if len(Trim(Rs("UserName")))>0 then
	Response.Write(Rs("UserName"))
else
	Response.Write("&nbsp;")
end if
%>
</td>
<td class="Right">
<%
if len(Trim(Rs("Permissions")))>0 then
	Response.Write(Rs("Permissions"))
else
	Response.Write("&nbsp;")
end if
%>
</td>
<td class="Right">
<%
if len(Trim(Rs("LoginIP")))>0 then
	Response.Write(Rs("LoginIP"))
else
	Response.Write("&nbsp;")
end if
%>
</td>
<td class="Right">
<%
if len(Trim(Rs("Browser")))>0 then
	if len(Trim(Rs("Browser")))>55 then
		Response.Write(left(Rs("Browser"),55)&"...")
	else
		Response.Write(Rs("Browser"))
	end if
else
	Response.Write("&nbsp;")
end if
%>
</td>
<td class="Right">
<%
if len(Trim(Rs("PostTime")))>0 then
	Response.Write(Rs("PostTime"))
else
	Response.Write("&nbsp;")
end if
%>
</td>
<td class="Right"><input type="checkbox" name="ID" value="<%=Rs("ID")%>" /></td>
<td><a href="?Action=Delete&ID=<%=Rs("ID")%>&Page=<%=Page%>" onclick="if(!confirm('\u786e\u8ba4\u8981\u5c06\u8be5\u4fe1\u606f\u5220\u9664\u5417\uff1f')) return false;">删除</a></td>
</tr>
<%
i=i+1
Rs.MoveNext
Loop
%>
<tr>
<th colspan="2" style="font-weight:normal">操作：<a href="javascript:Delete();" style="font-weight:normal">删除</a></th>
<th colspan="5" style="font-weight:normal;text-align:right">共<%=Rs.PageCount%>页&nbsp;第<%=Page%>页&nbsp;<%=PageSize%>条/页&nbsp;共<%=Total%>条&nbsp;
<%if Page=1 then%>
首 页&nbsp;上一页&nbsp;
<%Else%>
<a href="?Page=1&ClassID=<%=ClassID%>&UserName=<%=Server.URLEncode(UserName)%>">首 页</a>&nbsp;<a href="?Page=<%=Page-1%>&ClassID=<%=ClassID%>&UserName=<%=Server.URLEncode(UserName)%>">上一页</a>&nbsp;
<%End If%>
<%If Rs.PageCount-Page<1 Then%>下一页&nbsp;尾 页&nbsp;
<%Else%><a href="?Page=<%=Page+1%>&ClassID=<%=ClassID%>&UserName=<%=Server.URLEncode(UserName)%>">下一页</a>&nbsp;<a href="?Page=<%=Rs.PageCount%>&ClassID=<%=ClassID%>&UserName=<%=Server.URLEncode(UserName)%>">尾 页</a>&nbsp;
<%End If%>
</th>
<th>
<select style="FONT-SIZE: 9pt; FONT-FAMILY: 宋体;width:90%;" onChange="location=this.options[this.selectedIndex].value" name="Menu_1"> 
<%For Pagei=1 To Rs.PageCount%>
<%if Cint(Pagei)=Cint(Page) Then%>
<option value="?Page=<%=Pagei%>&ClassID=<%=ClassID%>&UserName=<%=Server.URLEncode(UserName)%>" selected="selected">第<%=Pagei%>页</option>
<%Else%>
<option value="?Page=<%=Pagei%>&ClassID=<%=ClassID%>&UserName=<%=Server.URLEncode(UserName)%>">第<%=Pagei%>页</option>
<%End If%>
<%Next%>
</select>
</th>
</tr>
</table>
</form>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript">
function Delete() {
    var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u8ba4\u8981\u5c06\u9009\u4e2d\u7684\u4fe1\u606f\u5220\u9664\u5417\uff1f')) {
        window.location.href = '?Action=Delete&ID='+l+'&Page=<%=Page%>&ClassID=<%=ClassID%>';
    }
}
</script>
</body>
</html>