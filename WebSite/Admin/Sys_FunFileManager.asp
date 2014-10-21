<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_FSO.asp"-->
<!--#include File="../Include/Class_System.asp"-->
<!--#include FILE="../Include/Class_UploadFun.asp"-->
<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
Element=Trim(Request("Element"))
ParentPath="/FunUploadFile/"
SubPath=Trim(Request("SubPath"))
If IsNumeric(SubPath)=False Then
	SubPath=""
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<base target="_self">
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript">
function GetValue(Str)
{
	if (navigator.appName=="Microsoft Internet Explorer")
	{
		window.dialogArguments.document.getElementById("<%=Element%>").value = Str; 
	}
	else
	{
		if(window.opener)window.opener.document.getElementById("<%=Element%>").value = Str;
	}
	top.window.close();
}
</script>
</head>
<body>
<%
If Request("Action")="Save" Then
Dim Request2
Set Request2=New Class_UploadFun
Request2.Charset="UTF-8"
Request2.Open()
Response.Write("<script>GetValue('"&Request2.SavePath&Request2.Form("Picture")&"')</script>")
Set Request2=nothing
End If
%>
<table width="585" border="0" cellspacing="0" cellpadding="0" align="center" style="border:solid 1px #c5cdd4;">
<tr style="background:url(Images/Info-List-Bg.gif);font-weight:bolder;height:32px; line-height:32px">
<td>&nbsp;文件上传</td>
<td style="text-align:right"><a href="#" onClick="top.window.close();" style="color:#000000; font-weight:normal">[关闭窗口]</a>&nbsp;</td>
</tr>
<tr>
<td width="200" align="center" valign="top" style="padding:5px">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:5px;">
      <tr>
        <td height="30" style="text-align:right">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><div id="PhotoUrl" style="width:200px;height:200px;border:solid 1px #c5cdd4;"></div></td>
          </tr>
          <tr>
            <td style="padding-top:5px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <form id="form1" name="form1" method="POST" action="?Action=Save&Element=<%=Element%>" enctype="multipart/form-data">
              <tr>
                <td><input type="file" name="Picture" style="width:200px;height:25px; line-height:25px; border:solid 1px #cccccc"></td>
              </tr>
              <tr>
                <td height="30" style="text-align:right"><input type="submit" name="submit" id="submit" value="上 传" style="background:url(Images/Buttom_Bg1.gif);width:72px; height:20px; border:0px; color:#395366"></td>
              </tr>
              </form>
            </table>
            </td>
          </tr>
        </table></td>
      </tr>
      </table></td>
  </tr>
</table></td>
<td rowspan="2" valign="top">
<div style="width:100%;height:280px;overflow:scroll;overflow-x:hidden;">
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td height="30">当前目录：<a href="?Element=<%=Element%>"><%=ParentPath%></a><%=SubPath%></td>
</tr>
</table>
<%=GetFolder(ParentPath&SubPath)%>
</div>
</td>
</tr>
<tr>
<td>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript">
$(document).ready(function() {
	$("input[type='file']").change(function() {
		var _FilePath = $("input[type='file']").val();
		if (_FilePath != "") {
			var reg = /(.*)+\.(jpg|bmp|gif|png|doc|asf)$/i;
			if (reg.test("."+_FilePath.split('.')[1])) {
				$("#PhotoUrl").css("background", "url(" + _FilePath + ")");
			}
			else {
				alert("格式不正确。");
			}
		}
	});
});
</script>
</body>
</html>