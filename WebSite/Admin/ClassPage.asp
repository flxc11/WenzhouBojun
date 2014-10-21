<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Page_Class")
Action=ReplaceBadChar(Trim(Request("Action")))
User_NavParent=ReplaceBadChar(Trim(Request("User_NavParent")))
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
	ID="0"
End If
Select Case Action
Case "Up"
	MinOrder=Conn.Execute("Select Min(User_NavOrder) From User_PageCategory Where User_NavParent="&User_NavParent&"")(0)
	If MinOrder="" Then MinOrder="1"
	User_NavOrder=ReplaceBadChar(Trim(Request("User_NavOrder")))
	If Cstr(User_NavOrder)=Cstr(MinOrder) Then
		Response.Write("<script>alert('\u8be5\u7c7b\u522b\u5df2\u7ecf\u5904\u4e8e\u6700\u5934\u90e8\u4e86\uff0c\u65e0\u6cd5\u8fdb\u884c\u987a\u5e8f\u7684\u8c03\u6574\u3002');history.back();</script>")
	Else
		Conn.Execute("Update User_PageCategory Set User_NavOrder="&User_NavOrder&" Where User_NavOrder="&User_NavOrder-1&" And User_NavParent="&User_NavParent&"")
		Conn.Execute("Update User_PageCategory Set User_NavOrder="&User_NavOrder-1&" Where ID="&ID&"")
		Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	End If
	Conn.Close
	Set Conn=Nothing
	Response.End()
Case "Down"
	MaxOrder=Conn.Execute("Select Max(User_NavOrder) From User_PageCategory Where User_NavParent="&User_NavParent&"")(0)
	User_NavOrder=ReplaceBadChar(Trim(Request("User_NavOrder")))
	If Cstr(User_NavOrder)=Cstr(MaxOrder) Then
		Response.Write("<script>alert('\u8be5\u7c7b\u522b\u5df2\u7ecf\u5904\u4e8e\u6700\u5e95\u90e8\u4e86\uff0c\u65e0\u6cd5\u8fdb\u884c\u987a\u5e8f\u7684\u8c03\u6574\u3002');history.back();</script>")
	Else
		Conn.Execute("Update User_PageCategory Set User_NavOrder="&User_NavOrder&" Where User_NavOrder="&User_NavOrder+1&" And User_NavParent="&User_NavParent&"")
		Conn.Execute("Update User_PageCategory Set User_NavOrder="&User_NavOrder+1&" Where ID="&ID&"")
		Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	End If
	Conn.Close
	Set Conn=Nothing
	Response.End()
Case "UnPublic"
	Conn.Execute("Update User_PageCategory Set User_NavLock=1 Where ID="&ID&"")
	Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	Response.End()
Case "InPublic"
	Conn.Execute("Update User_PageCategory Set User_NavLock=0 Where ID="&ID&"")
	Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	Response.End()
Case "Delete"
	Page=ReplaceBadChar(Trim(Request("Page")))
	ParentID=ReplaceBadChar(Trim(Request("ParentID")))
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
		If IsNumeric(AryID(i))=True Then
			Conn.Execute("Delete From User_PageCategory Where ID In ("&AryID(i)&GetPageAllChild("User_PageCategory",AryID(i))&")")
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u5220\u9664\u64cd\u4f5c\u6210\u529f\uff0c\u786e\u5b9a\u540e\u8fd4\u56de\u7c7b\u522b\u5217\u8868\u9875\u9762\u3002');window.location.href='?Page="&Page&"&ID="&ParentID&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="ClassPage.asp">单页类别维护</a><%=GetPageNavPath("User_PageCategory",ID)%></td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right"><a href="ClassPageAdd.asp?ID=<%=ID%>">添加类别</a>&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.以下为单页类别的信息列表;<br />
  2.单击&quot;[+]&quot;可添加当前级别的类别;<br />
  3.单击&quot;(数字)&quot;可添加该类别的下一子类别;
  <br />
  4.可对类别进行子父类别间的&quot;转移&quot;、&quot;编辑&quot;、&quot;删除&quot;、&quot;排序&quot;等;<br>
注意：您可以进行添加、修改、删除等操作，保存之后立即生效。</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<th width="4%" class="Right">ID</th>
<th width="4%" class="Right"><input type="checkbox" name="chkSelectAll" onclick="doCheckAll(this)" /></th>
<th width="22%" class="Right">类别名称<a href="ClassPageAdd.asp?ID=<%=ID%>">[+]</a></th>
<th width="40%" class="Right">类别说明</th>
<th width="10%" class="Right">排序</th>
<th width="6%" class="Right">状态</th>
<th width="8%"><span class="Right">
  管理操作</span></th>
</tr>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From User_PageCategory Where User_NavParent="&ID&" Order By User_NavOrder Asc"
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
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
<td class="Right"><%=Rs("ID")%></td>
<td class="Right"><input type="checkbox" name="ID" value="<%=Rs("ID")%>" /></td>
<td class="Right"><a href="?ID=<%=Rs("ID")%>">
  <%
	if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" or Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then
		Response.Write(Rs("User_NavTitle"))
	end if
	if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then
		Response.Write(Rs("User_EnNavTtile"))
	end if
%>
</a><a href="?ID=<%=Rs("ID")%>">(<%=GetPageSubNavCount("User_PageCategory",Rs("ID"))%>)</a></td>
<td class="Right"><%=Rs("User_NavRemark")%>&nbsp;</td>
<td class="Right"><a href="?Action=Up&ID=<%=Rs("ID")%>&User_NavOrder=<%=Rs("User_NavOrder")%>&User_NavParent=<%=Rs("User_NavParent")%>">上移</a>┊<a href="?Action=Down&ID=<%=Rs("ID")%>&User_NavOrder=<%=Rs("User_NavOrder")%>&User_NavParent=<%=Rs("User_NavParent")%>">下移</a></td>
<td class="Right">
  <%
If Rs("User_NavLock")="0" Then
Response.Write("<a href=""?Action=UnPublic&ID="&Rs("ID")&""">已发布</a>")
Else
Response.Write("<a href=""?Action=InPublic&ID="&Rs("ID")&""" style=""color:red"">未发布</a>")
End If
%></td>
<td><span class="Right"><a href="ClassPageEdit.asp?ID=<%=Rs("ID")%>&amp;Page=<%=Page%>&amp;ParentID=<%=ID%>">编辑</a>┊<a href="?Action=Delete&amp;ID=<%=Rs("ID")%>&amp;Page=<%=Page%>&amp;ParentID=<%=ID%>" onclick="if(!confirm('\u786e\u8ba4\u8981\u5c06\u8be5\u5546\u54c1\u7c7b\u522b\u5220\u9664\u5417\uff1f')) return false;">删除</a></span></td>
</tr>
<%
i=i+1
Rs.MoveNext
Loop
%>
<tr>
<th colspan="3" style="font-weight:normal">操作：<a href="javascript:ChangeParent();" style="font-weight:normal">转移</a></th>
<th colspan="3" style="font-weight:normal;text-align:right"><a href="javascript:Delete();" style="font-weight:normal">删除</a>&nbsp;┊&nbsp;共<%=Rs.PageCount%>页&nbsp;第<%=Page%>页&nbsp;<%=PageSize%>条/页&nbsp;共<%=Total%>条&nbsp;
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
    if (confirm('\u786e\u5b9a\u8981\u66f4\u6539\u9009\u4e2d\u7684\u7c7b\u522b\u7684\u6240\u5c5e\u7236\u7c7b\u522b\u5417\uff1f')) {
        window.location.href = 'ClassPageParent.asp?ID='+l;
    }
}
function Delete() {
    var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u8ba4\u8981\u5c06\u9009\u4e2d\u7684\u7c7b\u522b\u5220\u9664\u5417\uff1f')) {
        window.location.href = '?Action=Delete&ID='+l+'&Page=<%=Page%>&ParentID=<%=ID%>';
    }
}
</script>
</body>
</html>