<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Pro_ContentAdd")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
FileName=ReplaceBadChar(Trim(Request("FileName")))
ShowType=ReplaceBadChar(Trim(Request("ShowType")))
If Action="Save" Then
	ShopName=ReplaceBadChar(Trim(Request("ShopName")))
	EnShopName=Trim(Request("EnShopName"))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	ShopSPic=Request("ShopSPic")
	ShopBPic=Trim(Request("ShopBPic"))
	ShopSerial=ReplaceBadChar(Trim(Request("ShopSerial")))
	ShopFactory=ReplaceBadChar(Trim(Request("ShopFactory")))
	ShopSpec=ReplaceBadChar(Trim(Request("ShopSpec")))
	ShopModel=ReplaceBadChar(Trim(Request("ShopModel")))
	ShopMPrice=ReplaceBadChar(Trim(Request("ShopMPrice")))
	ShopSPrice=ReplaceBadChar(Trim(Request("ShopSPrice")))
	ShopContent=Trim(Request("ShopContent"))
	EnShopContent=Trim(Request("EnShopContent"))
	ShopLock=ReplaceBadChar(Trim(Request("ShopLock")))	
	ShopVisit=ReplaceBadChar(Trim(Request("ShopVisit")))
	
	ShopPara=Request("ShopPara")
	ShopFeature=Trim(Request("ShopFeature"))
	ShopIntro=Trim(Request("ShopIntro"))
	ShopKnow=Trim(Request("ShopKnow"))
	ShopInter=Trim(Request("ShopInter"))

	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ShopInfo Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("ShopName")=ShopName
	Rs("EnShopName")=EnShopName
	Rs("ClassID")=ClassID
	Rs("ShopSPic")=ShopSPic
	Rs("ShopBPic")=ShopBPic
	Rs("ShopSerial")=ShopSerial
	Rs("ShopFactory")=ShopFactory
	Rs("ShopSpec")=ShopSpec
	Rs("ShopModel")=ShopModel
	Rs("ShopMPrice")=ShopMPrice
	Rs("ShopSPrice")=ShopSPrice
	Rs("ShopContent")=ShopContent
	Rs("EnShopContent")=EnShopContent
	
	Rs("ShopPara")=ShopPara
	Rs("ShopFeature")=ShopFeature
	Rs("ShopIntro")=ShopIntro
	Rs("ShopKnow")=ShopKnow
	Rs("ShopInter")=ShopInter
	
	Rs("ShopLock")=0
	Rs("ShopVisit")=0
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	if len(Trim(Request.Cookies("CNVP_CMS2")("attributeValue2")))>0 then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From ShopAttribute where ProID="&ID
		Rs.Open Sql,Conn,1,3
		Aryfieldname=Split(Trim(Request.Cookies("CNVP_CMS2")("fieldname2")),",")
		AryValue=Split(Trim(Request.Cookies("CNVP_CMS2")("attributeValue2")),",")
		For i = LBound(AryValue) To UBound(AryValue)
			if Request(AryValue(i))<>"" then
				Rs(Aryfieldname(i))=Request(AryValue(i))
			else
				Rs(Aryfieldname(i))=0
			end if
		Next
		Rs.Update
		Rs.Close
		Set Rs=Nothing
	end if
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u5546\u54c1\u4fe1\u606f\u7f16\u8f91\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='"&FileName&".asp?ClassID="&ClassID&"&Edit=ename&Page="&Page&"&ShowType="&ShowType&"&ShopName="&Request("Keyword")&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：商品管理 >> 编辑商品</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下所有项目均不能为空，请准确真实的填写相关信息。<br>
注意：不想对外发布的商品可以设置成下架状态。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From ShopInfo Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	ClassID=Rs("ClassID")
	ShopName=Rs("ShopName")
	EnShopName=Rs("EnShopName")
	ShopSPic=Rs("ShopSPic")
	ShopBPic=Rs("ShopBPic")
	ShopSerial=Rs("ShopSerial")
	ShopFactory=Rs("ShopFactory")
	ShopSpec=Rs("ShopSpec")
	ShopModel=Rs("ShopModel")
	ShopMPrice=Rs("ShopMPrice")
	ShopSPrice=Rs("ShopSPrice")
	ShopContent=Rs("ShopContent")
	EnShopContent=Rs("EnShopContent")
	ShopLock=Rs("ShopLock")
	ShopVisit=Rs("ShopVisit")
	
	ShopPara=Rs("ShopPara")
	ShopFeature=Rs("ShopFeature")
	ShopIntro=Rs("ShopIntro")
	ShopKnow=Rs("ShopKnow")
	ShopInter=Rs("ShopInter")
	
End If
Rs.Close
Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
});
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
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="FileName" name="FileName" value="<%=FileName%>"/>
<input type="hidden" id="ShowType" name="ShowType" value="<%=ShowType%>"/>
<input type="hidden" id="Keyword" name="Keyword" value="<%=Request("ShopName")%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="4">编辑商品</th>
</tr>
<tr>
<td class="Right" align="right" width="10%">商品名称：</td>
<td class="Right">
 <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
  <div class="float_left_210txt">
  <input type="text" id="ShopName" name="ShopName" value="<%=ShopName%>" class="Input200px"/>
  </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
    <div class="float_left_210txt">
    <input type="text" id="EnShopName" name="EnShopName" value="<%=EnShopName%>" class="Input200px"/>
    </div>
   <%end if%>
    <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div class="float_left_210txt">
      <input type="text" id="ShopName" name="ShopName" value="<%=ShopName%>" class="Input200px"/>
    </div>
    <div class="float_left_90">（中文名称）</div>
    <div class="float_left_210txt">
    <input type="text" id="EnShopName" name="EnShopName" value="<%=EnShopName%>" class="Input200px"/>
    </div>
    <div class="float_left_90">（英文名称）</div>
   <%end if%>
</td>
<td class="Right" width="9%" align="right">商品类别：</td>
<td width="43%">
 <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" or Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div class="float_left_210">
  <select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">|--请选择栏目</option>
  <%=GetSelect("ShopClass",0)%>
  </select>
   </div>
    <%end if%>
    <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
    <div class="float_left_210">
  <select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">|--请选择栏目</option>
  <%=GetSelect2("ShopClass",0)%>
  </select>
   </div>
    <%end if%>
</td>
</tr>
<tr>
  <td class="Right" align="right">图片：</td>
  <td colspan="3" class="Right"><div class="float_left_250txt"><input type="text" id="ShopSPic" name="ShopSPic" value="<%=ShopSPic%>" class="Input200px"/> 
    <a href="javascript:OpenImageBrowser('ShopSPic');">浏览...</a></div>
    <div class="picsize_left_90">221*296</div></td>
</tr>
<tr>
  <td class="Right" align="right">参数：</td>
  <td colspan="3" class="Right">
    <textarea name="ShopPara" id="ShopPara" cols="45" rows="5"><%=ShopPara%></textarea></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">详细内容：</td>
  <td colspan="3">
    <%=Editor2("ShopContent",ShopContent)%>
    </td>
</tr>
<!--<tr>
<td class="Right" align="right">浏览人群：</td>
<td colspan="2" class="Right"><input type="radio" id="ShopVisit" name="ShopVisit" value="0"<%If ShopVisit="0" Then Response.Write(" checked=""checked""")%>/>所有人群<input type="radio" id="ShopVisit" name="ShopVisit" value="1"<%If ShopVisit="1" Then Response.Write(" checked=""checked""")%>/>网站会员</td>
<td class="Right" align="right">商品状态：</td>
<td><input type="radio" id="ShopLock" name="ShopLock" value="0" checked="checked"<%If ShopLock="0" Then Response.Write(" checked=""checked""")%>/>商品上架<input type="radio" id="ShopLock" name="ShopLock" value="1"<%If ShopLock="1" Then Response.Write(" checked=""checked""")%>/>商品下架</td>
</tr>-->
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>