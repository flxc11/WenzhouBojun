<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Call ISPopedom(UserName,"Sys_HostInfo")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：空间使用报告</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下为从站点根目录计算的文件夹列表，并显示该文件夹实际占用的空间大小。<br>
注意：为系统安全起见，本页面不提供删除文件功能。如果您需要清理文件，请使用FTP软件进行删除操作。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th width="20%" class="Right">项目内容</th>
<th width="80%" class="Right">占用空间大小</th>
</tr>
<tr>
<td class="Right">系统程序文件</td>
<td>
<%
HostSize=Fix(GetFolderSize("../Admin")*100+0.5)/100
%>
<div style="float:left;width:500px;height:15px;background:url(Images/Loading_Bg.gif);border:1px solid #426a98;">
<div style="margin:0px;padding:0px;">
<div style="position:absolute;text-align:center;height:13px;line-height:13px;width:500px;color:#FFFFFF; margin:0px;padding:0px;font-size:9px;"><%If HostSize<1 Then Response.Write("0")%><%=HostSize%>MB/100MB(<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%)</div>
<div style="background:url(images/loading_bg2.gif);width:<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%;height:13px;line-height:13px;"></div>
</div>
</div>
</td>
</tr>
<tr>
<td class="Right">数据库文件</td>
<td>
<%
HostSize=Fix(GetFolderSize("../DataBase")*100+0.5)/100
%>
<div style="float:left;width:500px;height:15px;background:url(Images/Loading_Bg.gif);border:1px solid #426a98;">
<div style="margin:0px;padding:0px;">
<div style="position:absolute;text-align:center;height:13px;line-height:13px;width:500px;color:#FFFFFF; margin:0px;padding:0px;font-size:9px;"><%If HostSize<1 Then Response.Write("0")%><%=HostSize%>MB/100MB(<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%)</div>
<div style="background:url(images/loading_bg2.gif);width:<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%;height:13px;line-height:13px;"></div>
</div>
</div>
</td>
</tr>
<tr>
<td class="Right">图片上传文件</td>
<td>
<%
HostSize=Fix(GetFolderSize("../UploadFile")*100+0.5)/100
%>
<div style="float:left;width:500px;height:15px;background:url(Images/Loading_Bg.gif);border:1px solid #426a98;">
<div style="margin:0px;padding:0px;">
<div style="position:absolute;text-align:center;height:13px;line-height:13px;width:500px;color:#FFFFFF; margin:0px;padding:0px;font-size:9px;"><%If HostSize<1 Then Response.Write("0")%><%=HostSize%>MB/100MB(<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%)</div>
<div style="background:url(images/loading_bg2.gif);width:<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%;height:13px;line-height:13px;"></div>
</div>
</div>
</td>
</tr>
<tr>
<td class="Right">网站占用总空间</td>
<td>
<%
HostSize=Fix(GetFolderSize("/")*100+0.5)/100
%>
<div style="float:left;width:500px;height:15px;background:url(Images/Loading_Bg.gif);border:1px solid #426a98;">
<div style="margin:0px;padding:0px;">
<div style="position:absolute;text-align:center;height:13px;line-height:13px;width:500px;color:#FFFFFF; margin:0px;padding:0px;font-size:9px;"><%If HostSize<1 Then Response.Write("0")%><%=HostSize%>MB/100MB(<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%)</div>
<div style="background:url(images/loading_bg2.gif);width:<%If HostSize<1 Then Response.Write("0")%><%=HostSize%>%;height:13px;line-height:13px;"></div>
</div>
</div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>