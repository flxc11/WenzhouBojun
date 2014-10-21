<!--#include File="CheckLogin.asp"-->
<!--#include File="Class_FSO.asp"-->
<!--#include File="Class_System.asp"-->
<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
FileType=Trim(Request("FileType"))
ParentPath="/UploadFile/"
SubPath=Trim(Request("SubPath"))
If IsNumeric(SubPath)=False Then
	SubPath=""
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="Style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
function GetValue(FilePath)
{
	parent.SetUrl(FilePath);
}
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #CCCCCC">&nbsp;当前目录：<a href="?FileType=<%=FileType%>"><%=ParentPath%></a><%=SubPath%></td>
</tr>
<tr>
<td align="center" valign="top" style="padding:5px"><%=GetFolder(ParentPath&SubPath)%></td>
</tr>
</table>
</body>
</html>