<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#Include File="../Config/FunConn.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"EditFunction")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=Trim(Request("ID"))
Page=ReplaceBadChar(Trim(Request("Page")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If Action="Save" Then
	FunctionName=Trim(Request("FunctionName"))
	EffectPic=Trim(Request("EffectPic"))
	FunDescription=Trim(Request("FunDescription"))

	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select EffectPic From FunctionInfo Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	if not Rs.eof then
	if instr(Trim(Rs("EffectPic")),"FunUploadFile")>0 then
	DelJpgFile(Rs("EffectPic"))
	end if
	end if
	Rs.close
	Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From FunctionInfo Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("FunctionName")=FunctionName
	Rs("EffectPic")=EffectPic
	Rs("ClassID")=ClassID
	Rs("FunDescription")=FunDescription
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	
	Content=Trim(Request("runcode_txt"))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ExampleInfo Where FunID="&ID&""
	Rs.Open Sql,FunConn,1,1
	if not Rs.eof then
		Set Rs2=Server.CreateObject("Adodb.RecordSet")
		Sql2="Select * From ExampleInfo Where FunID="&ID&""
		Rs2.Open Sql2,FunConn,1,3
		Rs2("FunID")=ID
		Rs2("Content")=Content
		Rs2.Update
		Rs2.close
		Set Rs2=Nothing
	else
		Set Rs2=Server.CreateObject("Adodb.RecordSet")
		Sql2="Select * From ExampleInfo"
		Rs2.Open Sql2,FunConn,1,3
		Rs2.AddNew
		Rs2("FunID")=ID
		Rs2("Content")=Content
		Rs2.Update
		Rs2.close
		Set Rs2=Nothing
	end if
	Rs.close
	Set Rs=Nothing
	FunConn.close
	Set FunConn=Nothing
	
	Response.Write("<script>alert('\u51fd\u6570\u5206\u7c7b\u4fe1\u606f\u7f16\u8f91\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='FunctionList.asp?ClassID="&ClassID&"&Edit=ename&Page="&Page&"';</script>")
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
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：后台函数管理 >> 函数说明编辑</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top"><p>以下为函数说明编辑。</p>
  <p>注意：编辑完成后保存即刻生效。</p></td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From FunctionInfo Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	ClassID=Rs("ClassID")
	FunctionName=Rs("FunctionName")
	EffectPic=Rs("EffectPic")
	FunDescription=Rs("FunDescription")
End If
Rs.Close
Set Rs=Nothing
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From ExampleInfo Where FunID="&ID&""
Rs.Open Sql,FunConn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	Content=Rs("Content")
End If
Rs.Close
Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#ShopName").val()=="")
	{
		alert("\u5546\u54c1\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#ShopName").focus();
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
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
});
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="FileName" name="FileName" value="<%=FileName%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="4">函数说明编辑</th>
</tr>
<tr>
<td class="Right" align="right" width="9%">函数名称：</td>
<td width="43%" class="Right"><input type="text" id="FunctionName" name="FunctionName" value="<%=FunctionName%>" class="Input200px" style="width:370px;"/></td>
<td class="Right" width="8%" align="right">函数分类：</td>
<td width="40%">
<select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">|--请选择函数分类</option>
  <%=GetSelect5("FunctionClass","FunOrder","FClassName")%>
  </select>
</td>
</tr>
<tr>
  <td class="Right" align="right">函数效果图：</td>
  <td colspan="3" class="Right"><input type="text" id="EffectPic" name="EffectPic" value="<%=EffectPic%>" class="Input200px" style="width:370px;"/>  <a href="javascript:OpenFunImageBrowser('EffectPic');">浏览...</a></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">函数描述：</td>
  <td colspan="3">
    <%=Editor2("FunDescription",FunDescription)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=FunDescription"></script>
    </td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">代码演示：  </td>
  <td colspan="3"><textarea id="runcode_txt" name="runcode_txt" value="" style="width:600px; height:100px;"><%=Content%></textarea></td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="运 行" class="Button" onclick="runCode(runcode_txt);"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>