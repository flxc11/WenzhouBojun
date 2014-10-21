<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
Session.CodePage = 65001
Response.Charset = "UTF-8"
UserName=Request.Cookies("CNVP_CMS2")("UserName")
'UserName=Request.Cookies("UserName")
If UserName="" Then
Response.Redirect("Admin_Login.asp")
Response.End()
End If
%>