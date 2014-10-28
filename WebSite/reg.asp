<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="Include/Class_MD5.asp" -->
<%
Rem 判断验证码输入是否正确的函数
Function ValidCode(pSN,k,c)
	Dim s,i
	s = Session(pSN)
	k = ";"&k&":"
	ValidCode = False
	i = InStr(s,k)
	If i > 0 Then
		If InStr(s,k&c&";") > 0 Then ValidCode = True
		Session(pSN) = Left(s,i) & Right(s,Len(s)-InStr(i+1,s,";"))
	End If
End Function

Dim codeKey
codeKey = Int(Timer()*10)
%>

<%
	If Request("Action")="Reg" Then
		If ValidCode("CSName",Request.Form("codeKey"),Request.Form("code")) Then
			UserName=ReplaceBadChar(Trim(Request("UserName")))
			UserPass=ReplaceBadChar(Trim(Request("UserPass")))
			TelPhone=ReplaceBadChar(Trim(Request("TelPhone")))
			Address=ReplaceBadChar(Trim(Request("Address")))
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select * From UserReg Where UserName='"&UserName&"'"
			Rs.Open Sql,Conn,1,3
			If Not (Rs.Eof Or Rs.Bof) Then
			Response.Write("<script>alert('\u8be5\u8d26\u53f7\u5df2\u5b58\u5728\uff0c\u8bf7\u66f4\u6362\u65b0\u7684\u8d26\u53f7\u518d\u8fdb\u884c\u672c\u64cd\u4f5c\u3002');window.history.back();</script>")
			Else
			Rs.Addnew
			Rs("UserName")=UserName
			Rs("UserPass")=MD5(UserPass,32)
			Rs("TelPhone")=TelPhone
			Rs("Address")=Address
			Rs("flg")=false
			Rs("PostTime")=Now()
			Rs.Update
			Response.Write("<script>alert('注册成功，请重新登录！');window.location.href='login.asp';</script>")
			End If
			Rs.Update
			Rs.Close
			Set Rs=Nothing
			Conn.Close
			Set Conn=Nothing
			Response.End()
		else
			Response.Write("<script>alert('输入的验证码错误!'); history.go(-1);</script>")
			Response.end()
		end if
	End If
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("会员注册")%>
	<link rel="stylesheet" href="css/style.css">
	<script src="js/jquery191min.js"></script>
	<script src="js/sea.js"></script>
	<script src="js/config.js"></script>
</head>
<body>
	<!--#include file="top.asp" -->
	<div class="main clearfix">
		<div class="main-r">
			<h2 class="main-r-h2">
				<span class="position">当前位置：首页 > 会员注册</span>
				<span class="current">会员注册</span>
			</h2>
			<div class="about bd">
				<div style="padding-top:36px;">
        <form name="form1" method="post" action="?action=Reg" onsubmit="return checkform()">
        <table width="326" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="90" bgcolor="#fff">&nbsp;</td>
            <td width="236" bgcolor="#fff">&nbsp;</td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">用 户 名：</td>
            <td align="left" bgcolor="#fff"><input type="text" name="UserName" id="UserName" class="loginipt" /><span style="color:red;">*</span></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">设置密码：</td>
            <td align="left" bgcolor="#fff"><input type="password" name="UserPass" id="UserPass" class="loginipt" /><span style="color:red;">*</span></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">确认密码：</td>
            <td align="left" bgcolor="#fff"><input type="password" name="Checkpass" id="Checkpass" class="loginipt" /><span style="color:red;">*</span></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">手机号码：</td>
            <td align="left" bgcolor="#fff"><input type="text" name="TelPhone" id="TelPhone" class="loginipt" /><span style="color:red;">*</span></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">联系地址：</td>
            <td align="left" bgcolor="#fff"><input type="text" name="Address" id="Address" class="loginipt" /></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">验 证 码：</td>
            <td align="left" bgcolor="#fff"><input type="hidden" name="codeKey" value="<%=codeKey%>"><input name="code" type="text" class="reginipt" id="code" /><img src="DvCode.asp?k=<%=codeKey%>&" onclick="this.src+=parseInt(Math.random()*10)" alt="看不清楚？点击换一张" style="cursor:pointer;"></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff">&nbsp;</td>
            <td align="left" bgcolor="#fff"><input type="submit" name="button" id="button" value=" " style="width:73px; height:29px; border:none; background:url(images/btnreg.gif); cursor:pointer;" />　　<input type="reset" name="button2" id="button2" value=" " style="width:73px; height:29px; border:none; background:url(images/btnreset.gif); cursor:pointer;" /></td>
          </tr>
          <tr>
            <td align="right" bgcolor="#fff">&nbsp;</td>
            <td align="left" bgcolor="#fff">&nbsp;</td>
          </tr>
        </table>
        </form>
        <script type="text/jscript">
          function checkform()
		  {
			  if ($("#UserName").val()=="")
				{
					alert("用户名不能为空");
					$("#UserName").focus();
					return false;
				}
				if ($("#UserPass").val()=="")
				{
					alert("密码不能为空");
					$("#UserPass").focus();
					return false;
				}
				if ($("#UserPass").val()!=$("#Checkpass").val())
				{
					alert("两次输入的密码不对，请重试");
					$("#Checkpass").focus();
					return false;
				}
				if ($("#TelPhone").val()=="")
				{
					alert("手机号码不能为空");
					$("#TelPhone").focus();
					return false;
				}
				if ($("#code").val()=="")
				{
					alert("验证码不能为空");
					$("#code").focus();
					return false;
				}
				return true;
			  }
        </script>
      </div>
			</div>
		</div>
		<div class="main-l">
			<!--#include file="left.asp" -->
		</div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
</html>