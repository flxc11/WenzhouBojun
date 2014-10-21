<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Pro_Comment")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
FileName=ReplaceBadChar(Trim(Request("FileName")))
CommentLock=ReplaceBadChar(Trim(Request("CommentLock")))
Select Case Action
Case "UnPublic"
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
	If IsNumeric(AryID(i))=True Then
		Conn.Execute("Update NewsComment Set CommentLock=1 Where ID="&AryID(i)&"")
	End If
	Next
	If FileName="" Then
		Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	Else
		Response.Redirect(FileName&".asp?CommentLock="&CommentLock&"&Page="&Request("Page")&"")
	End If
	Response.End()
Case "InPublic"
	Conn.Execute("Update NewsComment Set CommentLock=0 Where ID="&ID&"")
	Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	Response.End()
Case "Delete"
	Page=ReplaceBadChar(Trim(Request("Page")))
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
		If IsNumeric(AryID(i))=True Then
			Conn.Execute("Delete From NewsComment Where ID="&AryID(i)&"")
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u5220\u9664\u64cd\u4f5c\u6210\u529f\uff0c\u786e\u5b9a\u540e\u8fd4\u56de\u5546\u54c1\u8bc4\u8bba\u5217\u8868\u9875\u9762\u3002');window.location.href='?Page="&Page&"&CommentLock="&CommentLock&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:70%">当前位置：<a href="News_Comment.asp">信息评论管理</a></td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:30%; text-align:right"><a href="News_Comment.asp">全部评论</a>┊<a href="?CommentLock=0"<%If CommentLock="0" Then Response.Write(" style=""color:red""")%>>还未审核</a>┊<a href="?CommentLock=1"<%If CommentLock="1" Then Response.Write(" style=""color:red""")%>>已经审核</a>&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下为访客对信息内容的评论信息列表，默认所有评论均不显示。<br>
注意：您可以进行审核、删除等操作，保存之后立即生效。</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<th width="5%" class="Right"><input type="checkbox" name="chkSelectAll" onClick="doCheckAll(this)"></th>
<th width="25%" class="Right">信息标题</th>
<th width="60%" class="Right">评论内容</th>
<th width="10%">评论状态</th>
</tr>
<%
If CommentLock<>"" Then
	StrSql=" And CommentLock="&CommentLock&" "
End If
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From NewsComment Where 1=1 "&StrSql&" Order By ID Desc"
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
<td class="Right"><a href="News_ContentEdit.asp?ID=<%=Rs("NewsID")%>&FileName=Pro_Comment"><%=GetNewsName(Rs("NewsID"))%></a></td>
<td class="Right" style="line-height:150%"><%=Rs("CommentContent")%>&nbsp;</td>
<td><%
If Rs("CommentLock")="0" Then
Response.Write("<a href=""?Action=UnPublic&ID="&Rs("ID")&""">还未审核</a>")
Else
Response.Write("<a href=""?Action=InPublic&ID="&Rs("ID")&""">已经审核</a>")
End If
%></td>
</tr>
<%
i=i+1
Rs.MoveNext
Loop
%>
<tr>
<th colspan="2" style="font-weight:normal">操作：<a href="javascript:ToPublic();" style="font-weight:normal">审核</a>&nbsp;┊&nbsp;<a href="javascript:Delete();" style="font-weight:normal">删除</a></th>
<th style="font-weight:normal;text-align:right">共<%=Rs.PageCount%>页&nbsp;第<%=Page%>页&nbsp;<%=PageSize%>条/页&nbsp;共<%=Total%>条&nbsp;
<%if Page=1 then%>
首 页&nbsp;上一页&nbsp;
<%Else%>
<a href="?Page=1&CommentLock=<%=CommentLock%>">首 页</a>&nbsp;<a href="?Page=<%=Page-1%>&CommentLock=<%=CommentLock%>">上一页</a>&nbsp;
<%End If%>
<%If Rs.PageCount-Page<1 Then%>下一页&nbsp;尾 页&nbsp;
<%Else%><a href="?Page=<%=Page+1%>&CommentLock=<%=CommentLock%>">下一页</a>&nbsp;<a href="?Page=<%=Rs.PageCount%>&CommentLock=<%=CommentLock%>">尾 页</a>&nbsp;
<%End If%>
</th>
<th>
<select style="FONT-SIZE: 9pt; FONT-FAMILY: 宋体;width:90%;" onChange="location=this.options[this.selectedIndex].value" name="Menu_1"> 
<%For Pagei=1 To Rs.PageCount%>
<%if Cint(Pagei)=Cint(Page) Then%>
<option value="?Page=<%=Pagei%>&CommentLock=<%=CommentLock%>" selected="selected">第<%=Pagei%>页</option>
<%Else%>
<option value="?Page=<%=Pagei%>&CommentLock=<%=CommentLock%>">第<%=Pagei%>页</option>
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
function ToPublic()
{
	var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u5b9a\u5c06\u9009\u4e2d\u7684\u8bc4\u8bba\u8bbe\u7f6e\u6210\u5ba1\u6838\u72b6\u6001\u5417\uff1f')) {
        window.location.href = '?Action=UnPublic&CommentLock=<%=CommentLock%>&Page=<%=Page%>&FileName=Pro_Comment&ID='+l;
    }
}
function Delete() {
    var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u8ba4\u8981\u5c06\u9009\u4e2d\u7684\u5546\u54c1\u8bc4\u8bba\u4fe1\u606f\u5417\uff1f')) {
        window.location.href = '?Action=Delete&ID='+l+'&Page=<%=Page%>&CommentLock=<%=CommentLock%>';
    }
}
</script>
</body>
</html>