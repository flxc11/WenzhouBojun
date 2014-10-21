<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"DateTable")
Action=ReplaceBadChar(Trim(Request("Action")))
ShowType=ReplaceBadChar(Trim(Request("ShowType")))
If ShowType="" Then 
	ShowType=0
end if
Action=ReplaceBadChar(Trim(Request("Action")))
TName=Request("TName")
Select Case Action
Case "Delete"
	sqlStr="Drop table ["&TName&"]"
	Conn.Execute(sqlStr)
	Response.Write("<script>alert('\u7528\u6237\u8868\u5220\u9664\u6210\u529f\u0021');window.location.href='DateTable.asp';</script>")
	Response.End()
Case "DeleteData"
	Table="[FAQS],[FirendLink],[GuestBook],[JobClass],[JobInfo],[LoginLogInfo],[NewsClass],[NewsInfo],[ShopAttribute],[ShopClass],[ShopInfo],[ShopOrder],[SiteAds],[SiteExplain],[SiteInfo],[SitePicture],[User_PageCategory]"
	AryTable=Split(Table,",")
	for i=LBound(AryTable) to UBound(AryTable)
		Conn.Execute("Delete from "&AryTable(i))
	Next
	Response.Write("<script>alert('\u8868\u8bb0\u5f55\u5220\u9664\u6210\u529f\u0021');window.location.href='DateTable.asp';</script>")
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
<script language="javascript" type="text/javascript">
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
	$("#ClassID").change(function(){
		window.location.href='?ClassID='+$("#ClassID").val()+'&ShowType=<%=ShowType%>&ShopName=<%=Server.URLEncode(ShopName)%>';
	});
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Pro_ContentListIn.asp">数据库管理</a></td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="75%" valign="top"><p>1.以下为用户对数据表进行创建。</p>
  <p>2.用户可对系统已存在数据表外进行增加、删除、修改等操作。<br />
    3.带有“Del”标志的可批量删除表记录。
    <br>
    注意：您可以切换显示布局模式。</p></td>
<td width="15%" valign="bottom" style="text-align:right">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td>选择布局：</td>
<td><a href="<%=GetURL("showtype")%>0">
<%
If showtype=0 Then
PageSize=10
Response.Write("<img src=""Images/List_02.gif"" width=""18"" height=""15"" border=""0""/>")
Else
Response.Write("<img src=""Images/List_01.gif"" width=""18"" height=""15"" border=""0""/>")
End If
%>
</a></td>
<td><a href="<%=GetURL("showtype")%>1">
<%
If showtype=1 Then
PageSize=60
Response.Write("<img src=""Images/Image_02.gif"" width=""18"" height=""15"" border=""0""/>")
Else
Response.Write("<img src=""Images/Image_01.gif"" width=""18"" height=""15"" border=""0""/>")
End If
%>
</a></td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
set Rs = Conn.openSchema(20)                      
i=1
Select Case ShowType
Case 0
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<td colspan="6">
<form name="form1" method="post" action="?act=create">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td width="10%" align="center" valign="middle">数据表名称：</td>
    <td width="30%" valign="middle"><input type="text" id="tablename" name="tablename" value="" class="Input200px" style="width:280px;"/></td>
    <td width="10%" align="left" valign="middle"><input type="submit" value="创建新表" class="Button"></td>
    <td width="50%" align="left">
	注意：创建表时表名最好为英名名称。	</td>
  </tr>
</table>
</form></td>
</tr>
<tr>
<th width="124" class="Right">序号</th>
<th colspan="2" class="Right">数据表</th>
<th width="457" class="Right">绑定栏目</th>
<th width="115" class="Right">删除表数据(DEL)</th>
<th width="91" class="Right">操作</th>
</tr>
<%
	Do While Not Rs.Eof
	if Trim(Rs("TABLE_TYPE"))="TABLE" and Trim(Rs("Table_Name"))<>"TableInfo" then
%>
<tr>
<td class="Right"><%=i%></td>
<td colspan="2" class="Right">
<%
	Response.Write("<a href='DateTable_Edit.asp?tablename="&Rs("Table_Name")&"'>"&Rs("Table_Name")&"</a>")
	i=i+1
%></td>
<td class="Right">
<%
	if left(Trim(Rs("Table_Name")),5)="User_" then
		Response.Write("<a href='DateTable_Binding.asp?tablename="&Rs("Table_Name")&"'>绑定</a>")
	else
		Response.Write("&nbsp;")
	end if
%>
</td>
<td class="Right">
<%
if Trim(Rs("Table_Name"))="FAQS" or Trim(Rs("Table_Name"))="FirendLink" or Trim(Rs("Table_Name"))="GuestBook" or Trim(Rs("Table_Name"))="JobClass" or Trim(Rs("Table_Name"))="JobInfo" or Trim(Rs("Table_Name"))="LoginLogInfo" or Trim(Rs("Table_Name"))="NewsClass" or Trim(Rs("Table_Name"))="NewsInfo" or Trim(Rs("Table_Name"))="ShopAttribute" or Trim(Rs("Table_Name"))="ShopClass" or Trim(Rs("Table_Name"))="ShopInfo" or Trim(Rs("Table_Name"))="ShopOrder" or Trim(Rs("Table_Name"))="SiteAds" or Trim(Rs("Table_Name"))="SiteExplain" or Trim(Rs("Table_Name"))="SiteInfo" or Trim(Rs("Table_Name"))="SitePicture" or Trim(Rs("Table_Name"))="User_PageCategory" then
	Response.Write("<font style='color:#ff0000;'>Del</font>")
else
	Response.Write("&nbsp;")
end if
%>
</td>
<td colspan="2" class="Right">
  <%
	if left(Trim(Rs("Table_Name")),5)="User_" and Trim(Rs("Table_Name"))<>"User_PageCategory" then
		Response.Write("<a href='DateTable.asp?Action=Delete &TName="&Rs("Table_Name")&"'onclick='if(!confirm('\u786e\u8ba4\u8981\u5220\u9664\u8be5\u7528\u6237\u8868\u5417\uff1f')) return false;'>删除</a>")
	else
		Response.Write("&nbsp;")
	end if
%>
</td>
</tr>
<%
	end if
	Rs.MoveNext
	Loop
%>
<tr>
  <th colspan="7" style="font-weight:normal">
<script type="text/javascript">
function DeleteData()
{
    if (confirm('\u786e\u8ba4\u8981\u5220\u9664\u8868\u8bb0\u5f55\u5417\u003f'))
	{
        window.location.href = '?Action=DeleteData';
    }
}
</script>
  <form name="form1" method="post" action="?act=create">
  <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="10%" align="center" valign="middle">数据表名称：</td>
      <td width="30%" valign="middle"><input type="text" id="tablename" name="tablename" value="" class="Input200px" style="width:280px;"/></td>
      <td width="10%" align="left" valign="middle"><input type="submit" value="创建新表" class="Button"></td>
      <td width="50%" align="left">
        注意：创建表时表名最好为英名名称。
        <%
		dim act,tablename
		act=Trim(request.QueryString("act"))
		tablename=Trim(Request.Form("tablename"))
		if(act="create") then
			conn.execute("Create table User_"&tablename&"(ID AUTOINCREMENT(1,1),primary key(ID))")
			Response.Redirect("DateTable.asp")
		end if
	%>	</td>
      </tr>
    <tr>
      <td colspan="4" align="left" valign="middle">操作：<a href="javascript:DeleteData();" style="font-weight:normal">删除表记录</a>&nbsp;</td>
      </tr>
  </table>
  </form></th>
</tr>
</table>
<%Case 1%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td style="padding:5px 0px">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="GridView1">
<tr>
<td style="border:0px;">
<%
set Rs = Conn.openSchema(20)
Rs.movefirst
Do Until Rs.EOF
if Rs("TABLE_TYPE")="TABLE" and Trim(Rs("Table_Name"))<>"TableInfo" then
	Response.Write("<div style=""font-family:Verdana,'宋体';float:left;width:200px;height:80px; text-align:center; font-size:13px;""><a href=""DateTable_Edit.asp?tablename="&Rs("table_name")&"""><img src=""images/table.gif"" border=""0""><br />"&Rs("TABLE_NAME")&"</a></div>")
end if
Rs.movenext
Loop
%></td>
</tr>
</table></td>
</tr>
<tr>
<th style="font-weight:normal">&nbsp;</th>
</tr>
</table>
<%End Select%>
</td>
</tr>
</table>
</body>
</html>