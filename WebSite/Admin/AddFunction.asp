<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#Include File="../Config/FunConn.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Function")
Action=ReplaceBadChar(Trim(Request("Action")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If ClassID="" Then
	ClassID="0"
End If
If Action="Save" Then
	FunctionName=Trim(Request("FunctionName"))
	EffectPic=Trim(Request("EffectPic"))
	FunDescription=Trim(Request("FunDescription"))
	runcode_txt=Trim(Request("runcode_txt"))
	
	'获取排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select top 1 FunOrder From FunctionInfo Order By FunOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		FunOrder=Cstr(Trim(Rs("FunOrder")))+1
	Else
		FunOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FunctionInfo"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("FunctionName")=FunctionName
	Rs("FunOrder")=FunOrder
	Rs("FunDescription")=FunDescription
	Rs("EffectPic")=EffectPic
	Rs("PostTime")=Now()
	Rs("ClassID")=ClassID
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select top 1 * From FunctionInfo order by ID desc"
	Rs.Open Sql,Conn,1,1
	if not Rs.eof then
	FunID=Rs("ID")
	else
	FunID=1
	end if
	Rs.close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ExampleInfo"
	Rs.Open Sql,FunConn,1,3
	Rs.AddNew
	Rs("FunID")=cint(FunID)
	Rs("Content")=runcode_txt
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	FunConn.Close
	Set FunConn=Nothing
	Response.Write("<script>alert('\u51fd\u6570\u8bf4\u660e\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u0021');window.location.href='AddFunction.asp';</script>")
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
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：后台函数管理 >> 添加函数说明</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">1.添加函数说明时请填写相应的函数作用（功能）参数的说明；</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#FunctionName").val()=="")
	{
		alert("\u8bf7\u586b\u5199\u51fd\u6570\u540d\u79f0\u0021");
		return false;
	}
	if ($("#ClassID").val()==0)
	{
		alert("\u8bf7\u9009\u62e9\u680f\u76ee\u0021");
		$("#ClassID").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('AddFunction')"></td>
</tr>
<tr>
<th colspan="4">添加函数说明</th>
</tr>
<tr>
  <td width="10%" align="right" class="Right">函数名称：</td>
  <td class="Right"><input type="text" id="FunctionName" name="FunctionName" value="" class="Input200px" style="width:370px;"/></td>
  <td width="10%" align="right" class="Right">函数分类：</td>
  <td width="39%"><select id="ClassID" name="ClassID" style="width:200px;">
    <option value="0">|--请选择函数分类</option>
    <%=GetSelect5("FunctionClass","FunOrder","FClassName")%>
  </select></td>
</tr>
<tr>
  <td class="Right" align="right">函数效果图：</td>
  <td colspan="3" class="Right"><input type="text" id="EffectPic" name="EffectPic" value="" class="Input200px" style="width:370px;"/> <a href="javascript:OpenFunImageBrowser('EffectPic');">浏览...</a></td>
</tr>
<tr>
  <td align="right" class="Right">函数描述：</td>
  <td colspan="3" align="left" valign="top">
    <%=Editor2("FunDescription","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span>
    <script src="AutoSave.asp?Action=AutoSave&amp;FrameName=FunDescription"></script></td>
</tr>
<tr>
  <td align="right" class="Right">代码演示：</td>
  <td colspan="3" align="left" valign="top"><textarea id="runcode_txt" name="runcode_txt" value="" style="width:600px; height:100px;"><%=Content%></textarea></td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Pro_ContentAdd')"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>