<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"News_ContentAdd")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If Action="Save" Then
	NewsTitle=ReplaceBadChar(Trim(Request("NewsTitle")))
	EnNewsTitle=ReplaceBadChar(Trim(Request("EnNewsTitle")))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	NewsSPic=Trim(Request("NewsSPic"))
	NewsBPic=Trim(Request("NewsBPic"))
	UpLoadAddress=Trim(Request("UpLoadAddress"))
	NewsAuthor=ReplaceBadChar(Trim(Request("NewsAuthor")))
	Keywords=ReplaceBadChar(Trim(Request("Keywords")))
	NewsContent=Trim(Request("NewsContent"))
	EnNewsContent=Trim(Request("EnNewsContent"))
	NewsLock=ReplaceBadChar(Trim(Request("NewsLock")))	
	NewsVisit=ReplaceBadChar(Trim(Request("NewsVisit")))
		danwei=Trim(Request("danwei"))
	chengshi=ReplaceBadChar(Trim(Request("chengshi")))
	add=ReplaceBadChar(Trim(Request("add")))
	xcsj=Trim(Request("xcsj"))
	piaojia=ReplaceBadChar(Trim(Request("piaojia")))
	PostTime=Trim(Request("PostTime"))
	If PostTime="" Or IsDate(PostTime)=false Then
		PostTime=Now()
	End If
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From NewsInfo Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("NewsTitle")=NewsTitle
	Rs("EnNewsTitle")=EnNewsTitle
	Rs("ClassID")=ClassID
	Rs("NewsSPic")=NewsSPic
	Rs("NewsBPic")=NewsBPic
	Rs("UpLoadAddress")=UpLoadAddress
	Rs("NewsAuthor")=NewsAuthor
	Rs("Keywords")=Keywords
	Rs("NewsContent")=NewsContent
	Rs("EnNewsContent")=EnNewsContent
		Rs("danwei")=danwei
	Rs("chengshi")=chengshi
	Rs("add")=add
	Rs("xcsj")=xcsj
	Rs("piaojia")=piaojia
	Rs("NewsLock")=0
	Rs("NewsVisit")=0
	Rs("PostTime")=PostTime
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u4fe1\u606f\u7f16\u8f91\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='News_List.asp?ClassID="&ClassID&"&Page="&Page&"';</script>")
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
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：信息管理 >> 编辑信息</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">信息内容你可以设置会员阅读权限，仅网站注册会员方能阅读该信息，以下带星号（*）的为必填项。<br>
注意：不想对外发布的信息你可以设置成锁定状态。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From NewsInfo Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	ClassID=Rs("ClassID")
	NewsTitle=Rs("NewsTitle")
	EnNewsTitle=Rs("EnNewsTitle")
	NewsSPic=Rs("NewsSPic")
	NewsBPic=Rs("NewsBPic")
	UpLoadAddress=Rs("UpLoadAddress")
	NewsAuthor=Rs("NewsAuthor")
	Keywords=Rs("Keywords")
	PostTime=Rs("PostTime")
	NewsContent=Rs("NewsContent")
	EnNewsContent=Rs("EnNewsContent")
	NewsLock=Rs("NewsLock")
	NewsVisit=Rs("NewsVisit")
	danwei=Rs("danwei")
	chengshi=Rs("chengshi")
	add=Rs("add")
	xcsj=Rs("xcsj")
	piaojia=Rs("piaojia")
End If
Rs.Close
Set Rs=Nothing
%>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#EnNewsTitle").val()=="")
	{
		alert("\u4fe1\u606f\u6807\u9898\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#EnNewsTitle").focus();
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="4">编辑信息</th>
</tr>
<tr>
  <td width="15%" align="right" class="Right">信息标题：</td>
  <td width="35%" class="Right">
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" or Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div>中文<div class="float_left_210txt">
    <input type="text" id="NewsTitle" name="NewsTitle" value="<%=NewsTitle%>" class="Input200px"/>
    </div></div>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
    <div>英文
    <div class="float_left_210txt">
    <input type="text" id="enNewsTitle" name="enNewsTitle" value="<%=enNewsTitle%>" class="Input200px"/>
    </div></div>
<%end if%>
  
  


</td>
  <td width="15%" align="right" class="Right">信息类别：</td>
  <td width="35%">
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" or Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div class="float_left_210">
      <select id="ClassID" name="ClassID" style="width:200px;">
        <option value="0">|--请选择栏目</option>
        <%=GetSelect("NewsClass",0)%>
      </select>
    </div>
    <%end if%>
    <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
    <div class="float_left_210">
  <select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">|--请选择栏目</option>
  <%=GetSelect2("NewsClass",0)%>
  </select>
   </div>
    <%end if%>    </td>
</tr>
<tr>
  <td class="Right" align="right">信息小图：</td>
  <td class="Right"><input type="text" id="NewsSPic" name="NewsSPic" readonly="readonly" value="<%=NewsSPic%>" class="Input200px" style="background-color:#F5F5F5;"/> 
  <a href="javascript:OpenImageBrowser('NewsSPic');">浏览...</a> 170*120</td>
  <td class="Right" align="right">信息大图：</td>
  <td><input type="text" id="NewsBPic" name="NewsBPic" readonly="readonly" value="<%=NewsBPic%>" class="Input200px" style="background-color:#F5F5F5;"/> <a href="javascript:OpenImageBrowser('NewsBPic');">浏览...</a></td>
</tr>
<tr>
<td class="Right" align="right">发布人：</td>
<td class="Right"><input type="text" id="NewsAuthor" name="NewsAuthor" value="<%=NewsAuthor%>" class="Input200px"/></td>
<td colspan="2" align="left" class="Right"><div class="float_left_60">发布时间：</div>
  <div class="float_left_210"><input type="text" id="PostTime" name="PostTime" value="<%=PostTime%>" class="Input200px"/></div><div style="float:left; padding-top:8px;width:25px"><img src="Images/Calender.gif" align="absmiddle" onClick="showcalendar(event, $('PostTime'));" onFocus="showcalendar(event, $('PostTime'));if($('PostTime').value=='0000-00-00')$('PostTime').value=''"></div>
<div style="float:left">日期格式为2009-01-01</div></td>
</tr>

<!--<tr>
<td class="Right" align="right">3D链接：</td>
<td class="Right"><input type="text" id="danwei" name="danwei" value="<%=danwei%>" class="Input200px"/></td>
<td align="right" valign="middle" class="Right">&nbsp;</td>
<td align="left" valign="middle" class="Right">&nbsp;</td>
</tr>

<tr>
<td class="Right" align="right">演出地点：</td>
<td class="Right"><input type="text" id="add" name="add" value="<%=add%>" class="Input200px"/></td>
<td align="right" valign="middle" class="Right">演出时间：</td>
<td align="left" valign="middle" class="Right"><input type="text" id="xcsj" name="xcsj" value="<%=xcsj%>" class="Input200px"/></td>
</tr>

<tr>
<td class="Right" align="right">演出票价：</td>
<td class="Right"><input type="text" id="piaojia" name="piaojia" value="<%=piaojia%>" class="Input200px"/></td>
<td align="right" valign="middle" class="Right"></td>
<td align="left" valign="middle" class="Right"></td>
</tr>
<tr>
<td class="Right" align="right">关 键 字：</td>
<td colspan="2" class="Right"><input type="text" id="Keywords" name="Keywords" value="<%=Keywords%>" class="Input200px" style="width:370px"/></td>
<td>多个关键字请用“|”（竖线）隔开</td>
</tr>
<tr>
  <td class="Right" align="right">上传：</td>
  <td colspan="3" class="Right"><input type="text" id="UpLoadAddress" name="UpLoadAddress" readonly="readonly" value="<%=UpLoadAddress%>" class="Input300px" style="width:500px; background-color:#F5F5F5;"/>    <a href="javascript:OpenImageBrowser('UpLoadAddress');">浏览</a>...(注意：上传下载文件)</td>
  </tr>-->
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" or Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
<tr>
<td class="Right" align="right" valign="top">信息内容：</td>
<td colspan="3">
<%=Editor2("NewsContent",NewsContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span>
</td>
</tr>
<%end if%>
<%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
<tr>
<td class="Right" align="right" valign="top">信息内容(英文)：</td>
<td colspan="3">
<%=Editor2("enNewsContent",enNewsContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span>
</td>
</tr>
<%end if%>
<!--<tr>
<td class="Right" align="right">浏览人群：</td>
<td class="Right"><input type="radio" id="NewsVisit" name="NewsVisit" value="0" checked="checked"<%If NewsVisit="0" Then Response.Write(" checked=""checked""")%>/>所有人群<input type="radio" id="NewsVisit" name="NewsVisit" value="1"<%If NewsVisit="1" Then Response.Write(" checked=""checked""")%>/>网站会员</td>
<td class="Right" align="right">信息状态：</td>
<td><input type="radio" id="NewsLock" name="NewsLock" value="0" checked="checked"<%If NewsLock="0" Then Response.Write(" checked=""checked""")%>/>解锁状态<input type="radio" id="NewsLock" name="NewsLock" value="1"<%If NewsLock="1" Then Response.Write(" checked=""checked""")%>/>锁定状态</td>
</tr>-->
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>