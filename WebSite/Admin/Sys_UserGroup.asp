<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"Sys_UserList")
UserName=ReplaceBadChar(Trim(Request("UserName")))
If UserName="" Then
Response.Write("<script>alert('\u53c2\u6570\u4f20\u9012\u9519\u8bef\uff0c\u8bf7\u8054\u7cfb\u7cfb\u7edf\u7ba1\u7406\u5458\u3002');window.location.href='Sys_UserList.asp';</script>")
Response.End()
End If
If Request("Action")="Save" Then
	Popedom=ReplaceBadChar(Trim(Request("CheckBox1")))
	Conn.Execute("Delete From AdminGroup Where UserName='"&UserName&"'")
	AryPopedom = Split(Popedom,",")
	For i = LBound(AryPopedom) To UBound(AryPopedom)
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From AdminGroup"
		Rs.Open Sql,Conn,1,3
		Rs.Addnew
		Rs("UserName")=UserName
		Rs("Popedom")=Trim(AryPopedom(i))
		Rs("PostTime")=Now()
		Rs.Update
		Rs.Close
		Set Rs=Nothing
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u8d26\u53f7\u6388\u6743\u64cd\u4f5c\u6210\u529f\uff0c\u786e\u5b9a\u540e\u8fd4\u56de\u7ba1\u7406\u5458\u5217\u8868\u9875\u9762\u3002');window.location.href='Sys_UserList.asp';</script>")
	Response.End()
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置： 管理员授权</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">请谨慎设置管理账号的操作权限，保存之后立即生效。<br>
注意：只有将项目打钩，该管理账号才对拥有该项目的操作权限。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<%

%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" name="form1" method="post" action="?Action=Save&UserName=<%=UserName%>">
<tr>
<th colspan="2">管理员授权</th>
</tr>
<tr>
<td class="Right" align="right">登录账号：</td>
<td><%=UserName%></td>
</tr>
<tr>
<td width="25%" rowspan="10" align="right" valign="top" class="Right">权限设置：<br>
</td>
<td width="75%">
<div><input name="CheckBox1" type="checkbox" id="CheckBox1" value="System"<%=ISPopedomCheck(UserName,"System")%>><b>系统维护</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_SiteInfo"<%=ISPopedomCheck(UserName,"Sys_SiteInfo")%>>站点基本信息维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_UserInfo"<%=ISPopedomCheck(UserName,"Sys_UserInfo")%>>管理员信息维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_ChangePass"<%=ISPopedomCheck(UserName,"Sys_ChangePass")%>>更改登录密码</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_CreateUser"<%=ISPopedomCheck(UserName,"Sys_CreateUser")%>>添加管理员</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_UserList"<%=ISPopedomCheck(UserName,"Sys_UserList")%>>管理员列表</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_MailInfo"<%=ISPopedomCheck(UserName,"Sys_MailInfo")%>>企业信箱维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_HostInfo"<%=ISPopedomCheck(UserName,"Sys_HostInfo")%>>空间使用报告</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_HostInfo"<%=ISPopedomCheck(UserName,"DateTable")%>>数据库管理</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_HostInfo"<%=ISPopedomCheck(UserName,"Log")%>>后台登入日志管理</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Sys_HostInfo"<%=ISPopedomCheck(UserName,"Site_Version")%>>站点中英文版本设置</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Navigation"<%=ISPopedomCheck(UserName,"Navigation")%>><b>内容管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Nav_Content"<%=ISPopedomCheck(UserName,"Nav_Content")%>>导航条内容维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Page_Class"<%=ISPopedomCheck(UserName,"Page_Class")%>>单页类别管理</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Nav_Explain"<%=ISPopedomCheck(UserName,"Nav_Explain")%>>
单页内容管理</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Nav_Picture"<%=ISPopedomCheck(UserName,"Nav_Picture")%>>
图片内容管理</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="FAQS"<%=ISPopedomCheck(UserName,"FAQS")%>>FAQ管理</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Product"<%=ISPopedomCheck(UserName,"Product")%>><b>商品管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_ContentAdd"<%=ISPopedomCheck(UserName,"Pro_ContentAdd")%>>添加商品</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_ContentListIn"<%=ISPopedomCheck(UserName,"Pro_ContentListIn")%>>上架商品维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_ContentListOut"<%=ISPopedomCheck(UserName,"Pro_ContentListOut")%>>下架商品维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_Class"<%=ISPopedomCheck(UserName,"Pro_Class")%>>商品类别维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_Comment"<%=ISPopedomCheck(UserName,"Pro_Comment")%>>商品评论维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_ChangeClass"<%=ISPopedomCheck(UserName,"Pro_ChangeClass")%>>商品转移</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Pro_OrderList"<%=ISPopedomCheck(UserName,"Pro_OrderList")%>>订单管理</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="News"<%=ISPopedomCheck(UserName,"News")%>><b>信息管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="News_ContentAdd"<%=ISPopedomCheck(UserName,"News_ContentAdd")%>>添加信息</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="News_List"<%=ISPopedomCheck(UserName,"News_List")%>>信息内容维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="News_Class"<%=ISPopedomCheck(UserName,"News_Class")%>>信息分类维护</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="News_Comment"<%=ISPopedomCheck(UserName,"News_Comment")%>>信息评论维护</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Member"<%=ISPopedomCheck(UserName,"Member")%>><b>会员管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Member_Add"<%=ISPopedomCheck(UserName,"Member_Add")%>>添加新会员</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Member_List"<%=ISPopedomCheck(UserName,"Member_List")%>>有效会员列表</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Member_ListLock"<%=ISPopedomCheck(UserName,"Member_ListLock")%>>锁定会员列表</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Advertisement"<%=ISPopedomCheck(UserName,"Advertisement")%>><b>广告管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="AD_Banner"<%=ISPopedomCheck(UserName,"AD_Banner")%>>横幅广告</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="AD_Picture"<%=ISPopedomCheck(UserName,"AD_Picture")%>>图片广告</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="AD_Fonts"<%=ISPopedomCheck(UserName,"AD_Fonts")%>>文字广告</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="AD_Pop"<%=ISPopedomCheck(UserName,"AD_Pop")%>>弹出广告</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="AD_Float"<%=ISPopedomCheck(UserName,"AD_Float")%>>浮动广告</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Survey"<%=ISPopedomCheck(UserName,"Survey")%>><b>调查管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Survey_Add"<%=ISPopedomCheck(UserName,"Survey_Add")%>>添加调查问卷</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Survey_List"<%=ISPopedomCheck(UserName,"Survey_List")%>>调查问卷列表</div>
</td>
</tr>
<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="OnLineJobs"<%=ISPopedomCheck(UserName,"OnLineJobs")%>><b>在线招聘</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="OnLineJobs"<%=ISPopedomCheck(UserName,"OnLineJobs")%>>添加职位</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="OnLineJobs"<%=ISPopedomCheck(UserName,"OnLineJobs")%>>职位管理</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="Job_Person"<%=ISPopedomCheck(UserName,"Job_Person")%>>人才列表</div>
</td>
</tr>

<tr>
<td>
<div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="GuestBook"<%=ISPopedomCheck(UserName,"GuestBook")%>><b>留言管理</b></div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="GuestBook_Filter"<%=ISPopedomCheck(UserName,"GuestBook_Filter")%>>过滤关键字设置</div>
<div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="GuestBook"<%=ISPopedomCheck(UserName,"GuestBook")%>>访客留言</div>
</td>
</tr>
<tr>
  <td>
    <div><input type="checkbox" id="CheckBox1" name="CheckBox1" value="FirendLinkManager"<%=ISPopedomCheck(UserName,"FirendLinkManager")%>><b>有情链接</b></div>
  <div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="FirendLinkManager"<%=ISPopedomCheck(UserName,"FirendLinkManager")%>>有情链接管理</div>
  <div class="float_left_25"><input type="checkbox" id="CheckBox1" name="CheckBox1" value="FirendLinkManager"<%=ISPopedomCheck(UserName,"FirendLinkManager")%>>有情链接添加</div>
    </td>
</tr>

<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td><input type="checkbox" name="chkSelectAll" onClick="doCheckAll(this)">全选</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='Sys_UserList.asp';"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</body>
</html>