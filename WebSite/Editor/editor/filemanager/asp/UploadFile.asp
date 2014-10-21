<%Server.ScriptTimeOut=5000%>
<!--#include File="CheckLogin.asp"-->
<!--#include File="Class_Upload.asp"-->
<%
Dim Request2
Set Request2=New Class_Upload
Request2.Charset="UTF-8"
Request2.Open()
IntCount=0
For IntTemp=1 to Ubound(Request2.FileItem)
	If FileName="" Then
	FileName=Request2.SavePath&Request2.Form(Request2.FileItem(IntTemp))
	Else
	FileName=FileName&"|"&Request2.SavePath&Request2.Form(Request2.FileItem(IntTemp))
	End If
Next
Response.Write "<script type=""text/javascript"">"
Response.Write "window.parent.OnUploadCompleted(0,'"&FileName&"','','');"
Response.Write "</script>"
Set Request2=nothing
%>