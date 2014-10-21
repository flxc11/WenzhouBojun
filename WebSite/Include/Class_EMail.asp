<%
Function SendMail(ToMail,Subject,MailBody)
	Const cdoSendUsingMethod="http://schemas.microsoft.com/cdo/configuration/sendusing" 
	Const cdoSendUsingPort=2 
	Const cdoSMTPServer="http://schemas.microsoft.com/cdo/configuration/smtpserver" 
	Const cdoSMTPServerPort="http://schemas.microsoft.com/cdo/configuration/smtpserverport" 
	Const cdoSMTPConnectionTimeout="http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
	Const cdoSMTPAuthenticate="http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
	Const cdoBasic=1 
	Const cdoSendUserName="http://schemas.microsoft.com/cdo/configuration/sendusername" 
	Const cdoSendPassword="http://schemas.microsoft.com/cdo/configuration/sendpassword" 
	
	Dim objConfig
	Dim objMessage
	Dim Fields 
	
	Set objConfig = Server.CreateObject("CDO.Configuration") 
	Set Fields = objConfig.Fields 
	
	With Fields 
	.Item(cdoSendUsingMethod) = cdoSendUsingPort 
	.Item(cdoSMTPServer) = SMTPServer 
	.Item(cdoSMTPServerPort) = 25 
	.Item(cdoSMTPConnectionTimeout) = 10 
	.Item(cdoSMTPAuthenticate) = cdoBasic 
	.Item(cdoSendUserName) = SMTPUserName
	.Item(cdoSendPassword) = SMTPUserPass 
	.Update 
	End With 
	
	Set objMessage = Server.CreateObject("CDO.Message") 
	Set objMessage.Configuration = objConfig 
	
	With objMessage 
	.To = ToMail
	.From = SmtpFormMail
	.Subject = Subject
	.HTMLBody = MailBody
	'.TextBody = MailBody 
	
	.Send 
	End With 
	
	Set Fields = Nothing 
	Set objMessage = Nothing 
	Set objConfig = Nothing
End Function
Function SendJMail(ToMail,Subject,MailBody)
	Set Msg=Server.CreateObject("Jmail.Message") 
	Msg.Silent=true 
	Msg.Logging = true 
	Msg.Charset = "gb2312" 
	Msg.MailServerUserName = SMTPUserName'输入smtp服务器验证登陆名 
	Msg.MailServerPassword = SMTPUserPass'输入smtp服务器验证密码 
	Msg.From = SmtpFormMail'发件人 
	Msg.FromName = SmtpFormMail'发件人姓名 
	Msg.AddRecipient ToMail'收件人  
	Msg.Subject = Subject'主题 
	Msg.Body = MailBody'正文 
	Msg.Priority = 1'设定邮件优先级1为紧急，3为正常，5为缓慢。
	Msg.Send (SMTPServer)'邮件服务器 
	Set Msg = Nothing
End Function
%>