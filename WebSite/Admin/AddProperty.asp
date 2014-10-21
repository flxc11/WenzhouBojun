<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<title>自定义商品属性</title>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if (document.all["number"].value=="")
	{
		alert("\u8bf7\u8f93\u5165\u5b57\u6bb5\u5c5e\u6027\u4e2a\u6570\u6216\u589e\u52a0\u4e00\u4e2a\u0021");
		return false;
	}
	else if(isNaN(document.all["number"].value)==true)
	{
		alert("\u60a8\u8f93\u5165\u7684\u4e2a\u6570\u4e3a\u975e\u6570\u5b57\uff0c\u8bf7\u8f93\u5165\u6b63\u786e\u7684\u503c\u0021");
		return false;
	}
	return true;
}
</script>
</head>
<body>
<%
	Action=ReplaceBadChar(Trim(Request("Action")))
	If Action="Save" Then
	tablename="ShopInfo"
	set rs=server.createobject("adodb.recordset")
	rs.open "select top 1 * from "&tablename,conn,3,1
	if rs.fields.count>0 then
		dim j
		j=0
		For i=0 To rs.fields.count-1
			if left(Trim(rs(i).name),5)="User_" then
				j=j+1
			end if
		Next
		if j>0 then
			  number=Trim(Request("number"))
			  For i=1 to cint(number)
				  If Request.Form("name"&i)<>"" and  Request.Form("value"&i)<>"" Then
					  If  attributeName="" then
						  attributeName=Request.Form("name"&i)
						  attributeValue=Request.Form("value"&i)
					  Else
						  attributeName=attributeName&"§§§"&Request.Form("name"&i)
						  attributeValue=attributeValue&"§§§"&Request.Form("value"&i)
					  End if
				  End If
			  Next
			  Set Rs=Server.CreateObject("Adodb.RecordSet")
			  Sql="Select * From ShopInfo"
			  Rs.Open Sql,Conn,1,3
			  Rs.AddNew
			  rs("User_attributeName")=attributeName
			  rs("User_attributeValue")=attributeValue
			  Rs.UpDate
			  Rs.close
			  Set Rs=Nothing
			  Conn.close
			  Set Conn=Nothing
		else
			Response.Write("<script>alert('\u6570\u636e\u8868\u4e2d\u6ca1\u6709\u989d\u5916\u7684\u5b57\u6bb5\uff0c\u8bf7\u5728\u0022\u6570\u636e\u5e93\u7ba1\u7406\u0022\u4ea7\u54c1\u8868\u4e2d\u521b\u5efa\u5b57\u6bb5\u0021');window.location.href='AddProperty.asp';</script>")
			Response.End()
		end if
	end if
	End If
%>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<table width="400" height="30" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50" align="right" class="tdtop tdright tdbottom tdleft">个数：</td>
    <td width="70" align="center" class="tdtop tdright tdbottom"><input type="text" id="number" name="number" value="" style="width:50px; height:20px; line-height:20px;"/></td>
    
    <td width="90" align="center" class="tdtop tdright tdbottom"><input type="button" value="设 置" class="Button2" onclick="num_1()"></td>
    <td width="89" align="center" class="tdtop tdright tdbottom"><input type="button" value="增加一个" class="Button2" onclick="num_1_1()"></td>
    <td width="101" align="center" class="tdtop tdright tdbottom"><input type="submit" value="保 存" class="Button2"></td>
  </tr>
</table>
<table width="400" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="2" style="line-height:10px; height:10px;">&nbsp;</td>
  </tr>
  <tr>
    <td class="cell_title btdtop btdright btdbottom btdleft" width="150">属性名称</td>
    <td class="cell_title btdtop btdbottom btdright" width="250">属性值</td>
  </tr>
  <tr>
  	<td colspan="2">
  <span id="number_str">
  <%For i=0 to (Num_1-1)%>
  <table align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="cell_center tdright tdbottom tdleft" width="154" height="30">
      <input type="text" id="name<%=i+1%>" name="name<%=i+1%>" value=""  style="width:154px; height:20px; line-height:20px;"/></td>
    <td class="cell_center tdright tdbottom" width="246">
      <input type="text" id="value<%=i+1%>" name="value<%=i+1%>" value="" style="width:246px; height:20px; line-height:20px;"/></td>
  </tr>
  </table>
  <%Next%>
  </span>
  	</td>
	</tr>
  <tr>
   <td colspan="2" height="30"><table width="400" height="30" align="center" border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td width="200" align="center"><input type="submit" value="保 存" class="Button2"></td>
       <td width="200" align="center"><input type="button" value="关闭窗口" class="Button2"></td>
     </tr>
   </table>
   </td>
  </tr>
</table>
</form>
</body>
</html>
