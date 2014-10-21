<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"GuestBook")
Action=ReplaceBadChar(Trim(Request("Action")))
NavParent=ReplaceBadChar(Trim(Request("NavParent")))
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
	ID="0"
End If
Select Case Action
Case "UnPublic"
	Conn.Execute("Update booking Set flg=0 Where ID="&ID&"")
	Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	Response.End()
Case "InPublic"
	Conn.Execute("Update booking Set flg=1 Where ID="&ID&"")
	Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	Response.End()
Case "Delete"
	Page=ReplaceBadChar(Trim(Request("Page")))
	ParentID=ReplaceBadChar(Trim(Request("ParentID")))
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
		If IsNumeric(AryID(i))=True Then
			Conn.Execute("Delete From GuestBook Where ID In ("&AryID(i)&GetAllChild("GuestBook",AryID(i))&")")
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u5220\u9664\u64cd\u4f5c\u6210\u529f\uff0c\u786e\u5b9a\u540e\u8fd4\u56de\u8bf4\u660e\u9875\u5217\u8868\u9875\u9762\u3002');window.location.href='?Page="&Page&"&ID="&ParentID&"';</script>")
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
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="GuestBook.asp">留言内容维护</a></td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right"></td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下为系统所有留言内容的信息列表。<br>
注意：您可以进行查看、删除等操作，提交之后立即生效。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<th width="4%" class="Right">ID</th>
<th width="20%" class="Right">姓名</th>
<th width="20%" class="Right">证件号码</th>
<th width="20%" class="Right">手机号码</th>
<th width="20%" class="Right">提交时间</th>
<th width="16%" class="Right">是否处理</th>
</tr>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From Booking Order By PostTime desc"
Rs.Open Sql,Conn,1,1
Dim Page
Page=Request("Page")                            
PageSize = 10                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If len(cstr(Trim(Page)))<=0 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page                         
i=0
Do While Not Rs.Eof And i<Rs.PageSize
%>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
<td class="Right"><%=Rs("ID")%></td>
<td class="Right">
  <a href="LookGuestBook.asp?ID=<%=Rs("ID")%>&Page=<%=Page%>&ParentID=<%=ID%>">
  <%=rs("UserName")%>
</a>
</td>
<td class="Right">
  <%=rs("IDNumber")%></td>
<td class="Right">
  <%=rs("Phone")%></td>
<td class="Right"><%=rs("PostTime")%></td>
<td class="Right">
  <%
If Rs("Flg")="True" Then
Response.Write("<a href=""?Action=UnPublic&ID="&Rs("ID")&""">已处理</a>")
Else
Response.Write("<a href=""?Action=InPublic&ID="&Rs("ID")&""" style=""color:red"">未处理</a>")
End If
%>
</td>
</tr>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right">&nbsp;</td>
  <td colspan="5" class="Right">房间类型：<strong><%=rs("RoomType")%></strong> |房间数：<strong><%=rs("RoomNum")%></strong> | 成人数：<strong><strong><%=rs("AdultNum")%></strong></strong> | 儿童数：<strong><%=rs("AdultNum")%></strong></td>
  </tr>
<%
i=i+1
Rs.MoveNext
Loop
%>

</table>
<table border="0" cellpadding="0" cellspacing="0" class="Form">
<tr>
<th colspan="2" style="font-weight:normal">操作：<a href="javascript:ChangeParent();" style="font-weight:normal">转移</a>&nbsp;┊&nbsp;<a href="javascript:Delete();" style="font-weight:normal">删除</a></th>
<th colspan="5" align="right" style="font-weight:normal" width="100">共<%=Rs.PageCount%>页&nbsp;第<%=Page%>页&nbsp;<%=PageSize%>条/页&nbsp;共<%=Total%>条&nbsp;
  <%if Page=1 then%>
  首 页&nbsp;上一页&nbsp;
  <%Else%>
  <a href="?Page=1">首 页</a>&nbsp;<a href="?Page=<%=Page-1%>">上一页</a>&nbsp;
  <%End If%>
  <%If Rs.PageCount-Page<1 Then%>下一页&nbsp;尾 页&nbsp;
  <%Else%><a href="?Page=<%=Page+1%>">下一页</a>&nbsp;<a href="?Page=<%=Rs.PageCount%>">尾 页</a>&nbsp;
  <%End If%></th>
<th width="80">
  <select style="FONT-SIZE: 9pt; FONT-FAMILY: 宋体;width:90%;" onChange="location=this.options[this.selectedIndex].value" name="Menu_1"> 
  <%For Pagei=1 To Rs.PageCount%>
  <%if Cint(Pagei)=Cint(Page) Then%>
  <option value="?Page=<%=Pagei%>" selected="selected">第<%=Pagei%>页</option>
  <%Else%>
  <option value="?Page=<%=Pagei%>">第<%=Pagei%>页</option>
  <%End If%>
  <%Next%>
</select></th>
</tr>
</table>
</form>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript">
function ChangeParent()
{
	var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u5b9a\u8981\u66f4\u6539\u9009\u4e2d\u7684\u8bf4\u660e\u9875\u7684\u6240\u5c5e\u7236\u7c7b\u522b\u5417\uff1f')) {
        window.location.href = 'Nav_ExplainParent.asp?ID=' + l;
    }
}
function Delete() {
    var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u8ba4\u8981\u5c06\u9009\u4e2d\u7684\u8bf4\u660e\u9875\u5220\u9664\u5417\uff1f')) {
        window.location.href = '?Action=Delete&ID='+l+'&Page=<%=Page%>&ParentID=<%=ID%>';
    }
}
</script>
</body>
</html>