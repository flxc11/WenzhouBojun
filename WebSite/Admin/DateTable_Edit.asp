<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"DateTable")
dim i,tablename
tablename=trim(request.QueryString("tablename"))
if(len(tablename)<1) then
	response.write "<script language='JavaScript'>alert('数据表参数错误！');" & "history.back()" & "</script>"
	response.End()
end If
dim Action,rsCheckAdd,rs,sql
Action=ReplaceBadChar(Trim(Request("Action")))
Select Case Action
Case "Save"
fieldname=trim(request.Form("fieldname"))
	if(len(fieldname)<1) then
 		response.write "<script language='JavaScript'>alert('请输入字段名！');" & "history.back()" & "</script>"
 		response.End()
	end if
	fieldtype=trim(request.Form("fieldtype"))
	if(len(fieldtype)<1) then
 		response.write "<script language='JavaScript'>alert('请选择字段类型！');" & "history.back()" & "</script>"
 		response.End()
	end if
	
	if tablename="ShopAttribute" then
		if fieldtype="varchar" then
			charlen=Cint(request.Form("varchar_len"))
			addsql="alter table "&tablename&" add "&fieldname&" "&fieldtype&" ("&charlen&") null"
		else
			addsql="alter table "&tablename&" add "&fieldname&" "&fieldtype
		end if
	else
		if fieldtype="varchar" then
			charlen=Cint(request.Form("varchar_len"))
			addsql="alter table "&tablename&" add User_"&fieldname&" "&fieldtype&" ("&charlen&") null"
		else
			addsql="alter table "&tablename&" add User_"&fieldname&" "&fieldtype
		end if
	end if
	conn.execute(addsql)
	Response.Write "<script language=javascript>alert('数据表 "&tablename&" 新字段 "&fieldname&" 添加成功！');window.location.href='"&request.servervariables("http_referer")&"';</script>"
Case "Delete"
FiledName=Request("FiledName")
sqlStr="Alter Table ["&tablename&"] Drop Column "&FiledName&""
	Conn.Execute(sqlStr)
	Response.Write("<script>alert('\u5b57\u6bb5\u5220\u9664\u6210\u529f\u0021');window.location.href='DateTable_Edit.asp?tablename="&tablename&"';</script>")
	Response.End()
End Select
set rs=server.createobject("adodb.recordset")
rs.open "select top 1 * from "&tablename,conn,3,1
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：数据表编辑</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.字段名称最好为英文字母。
  <br>
  2.字段长度必须为数字，如：50,100<br>
  3.用户可对除系统已有数据表的已有字段外其它所有字段进行添加、删除等操作。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#fieldname").val()=="")
	{
		alert("\u5b57\u6bb5\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		$("#fieldname").focus();
		return false;
	}
	return true;	
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<td colspan="3"><input type="submit" value="保 存" class="Button">&nbsp; <input type="button" value="返回上一页" class="Button" onClick="window.location.href='DateTable.asp'"></td>
</tr>
<tr>
<th width="16%" class="Right">字段名</th>
<th width="60%" class="Right">字段属性</th>
<th width="24%" class="Right">操作</th>
</tr>
<%For i=0 To rs.fields.count-1%>
<tr>
<td class="Right"><span class="forumRow" style="padding-left: 8px"><%=rs(i).name%></span></td>
<td class="Right">
<%
if rs.fields(i).type="3" then
	response.write "长整型"
if rs.fields(i).Attributes="16" then response.write " 自动编号字段"
elseif rs.fields(i).type="202" then
	response.write "文本："
	response.write "长度"&rs.fields(i).DefinedSize
elseif rs.fields(i).type="2" then
	response.write "整形"
elseif rs.fields(i).type="11" then
	response.write "是/否"
elseif rs.fields(i).type="135" Or rs.fields(i).type="7" then
	response.write "日期/时间"
elseif rs.fields(i).type="203" then
	response.write "备注"
elseif rs.fields(i).type="6" then
	response.write "货币"
elseif rs.fields(i).type="205" then
	response.write "OLE 对象"
else
	response.write "未知"&rs.fields(i).type
end if
%>
</td>
<td colspan="2" class="Right">
<%
	if tablename="ShopAttribute" then
		if Trim(rs(i).name)<>"ID" and Trim(rs(i).name)<>"ProID" then
			Response.Write("<a href='DateTable_Edit.asp?Action=Delete&FiledName="&rs(i).name&"&tablename="&tablename&"'onclick='if(!confirm('\u786e\u8ba4\u8981\u5220\u9664\u8be5\u5b57\u6bb5\u5417\uff1f')) return false;'>删除</a>")
		else
			Response.Write("&nbsp;")
		end if
	else
		if left(Trim(rs(i).name),5)="User_" then
			Response.Write("<a href='DateTable_Edit.asp?Action=Delete&FiledName="&rs(i).name&"&tablename="&tablename&"'onclick='if(!confirm('\u786e\u8ba4\u8981\u5220\u9664\u8be5\u5b57\u6bb5\u5417\uff1f')) return false;'>删除</a>")
		else
			Response.Write("&nbsp;")
		end if
	end if
%>
</td>
</tr>
<%
Next
rs.close
set rs=nothing
%>
<tr>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" name="form1" method="post" action="DateTable_Edit.asp?action=Save&tablename=<%=tablename%>" onSubmit="return CheckForm();">
<tr>
<th colspan="2">添加新字段</th>
</tr>
<tr>
<td class="Right" align="right">字段名称：</td>
<td><input type="text" id="fieldname" name="fieldname" class="Input300px" maxlength="20">
  (字段名称最好为英文字母)</td>
</tr>
<tr>
<td width="25%" class="Right" align="right">字段类型：</td>
<td width="75%">
<select id="fieldtype" name="fieldtype"  style="width:200px;">
    <option value="int">长整型</option>
          <option value="smallint">整型</option>
          <option value="varchar">文本</option>
          <option value="datetime">日期/时间</option>
          <option value="memo">备注</option>
          <option value="money">货币</option>
          <option value="bit">是/否</option>
  </select></td>
</tr>
<tr>
  <td class="Right" align="right">字段长度：</td>
  <td width="75%"><input type="text" id="varchar_len" name="varchar_len" class="Input300px" maxlength="20">
    （字段长度必须为数字，如：50,100）</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td><input type="submit" value="保 存" class="Button">&nbsp;<input type="button" value="返回上一页" class="Button" onClick="window.location.href='DateTable.asp'"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</body>
</html>