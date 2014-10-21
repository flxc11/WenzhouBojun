<!--#Include File="Conn.asp"-->
<%
Session.CodePage = 65001
Response.Charset = "UTF-8"

Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From SiteInfo"
Rs.Open Sql,Conn,1,1
if not (Rs.eof and Rs.bof) then
SiteName=Rs("SiteName")
SiyeKeys=Rs("SiyeKeys")
enSiteName=Rs("enSiteName")
enSiyeKeys=Rs("enSiyeKeys")
SiteDes=Rs("SiteDes")
SiteLogo=Rs("SiteLogo")
SiteICP=Rs("SiteICP")
SiteCopy=Rs("SiteCopy")
Support=rs("Support")
gonggao=rs("gonggao")
SiteAuthor=Rs("SiteAuthor")
SMTPServer=Rs("SMTPServer")
SmtpFormMail=Rs("SmtpFormMail")
SMTPUserName=Rs("SMTPUserName")
SMTPUserPass=Rs("SMTPUserPass")
end if
Rs.Close
Set Rs=Nothing
%>


<%
'----函数说明----
'调用单页
'----参数说明----
'ClassID:栏目ID
'language:语言类型（en-英文;cn-中文）
Function Readpage(ClassID,language)
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From [SiteExplain] where ClassID='"&ClassID&"'"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		if language = "en" then
			Readpage=Rs("enNavContent")
		elseif language = "cn" then
			Readpage=Rs("NavContent")
		end if
	else
		Readpage = "资料整理中..."
	End If
	Rs.Close
	Set Rs=Nothing
end Function
'----函数说明----
'调用单页
'----参数说明----
'ClassID:栏目ID
'language:语言类型（en-英文;cn-中文）
Function GetSingle(ClassID,language)
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From [SiteExplain] where ClassID='"&ClassID&"'"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		if language = "en" then
			Readpage=Rs("enNavContent")
		elseif language = "cn" then
			Readpage=Rs("NavContent")
		end if
	else
		Readpage = "资料整理中..."
	End If
	Rs.Close
	Set Rs=Nothing
end Function
%>



