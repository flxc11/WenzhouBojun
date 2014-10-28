<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="Include/Class_MD5.asp" -->
<!--#include file="checklogin.asp" -->
<%
	Set Rs2=Server.CreateObject("adodb.recordset")
	sql2 = "select * from UserReg where UserName='"&Session("UserName")&"'"
	Rs2.open Sql2,Conn,1,1
	if not Rs2.eof or Rs2.Bof then
	UserID = Rs2("ID")
	UserName = Rs2("UserName")
	TelPhone = Rs2("TelPhone")
	Address = Rs2("Address")
	end if
	Rs2.Close:Set Rs2=Nothing
%>
<%
	If Request("Action")="Edit" Then
		UserID=ReplaceBadChar(Trim(Request("UserID")))
		UserName=ReplaceBadChar(Trim(Request("UserName")))
		if ReplaceBadChar(Trim(Request("UserPass"))) <> "" then
			UserPass=ReplaceBadChar(Trim(Request("UserPass")))
		end if
		TelPhone=ReplaceBadChar(Trim(Request("TelPhone")))
		Address=ReplaceBadChar(Trim(Request("Address")))
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From UserReg Where ID="&UserID&""
		Rs.Open Sql,Conn,1,3
		Rs("UserName")=UserName
		If ReplaceBadChar(Trim(Request("UserPass"))) <> "" then
		Rs("UserPass")=MD5(UserPass,32)
		end if
		Rs("TelPhone")=TelPhone
		Rs("Address")=Address
		Rs.Update
		Response.Write("<script>alert('修改成功！');window.location.href='memberinfo.asp';</script>")
		Rs.Update
		Rs.Close
		Set Rs=Nothing
		Response.End()
	End If
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("会员信息")%>
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
				<span class="position">当前位置：首页 > 会员中心 > 会员信息</span>
				<span class="current">会员信息</span>
			</h2>
			<div class="about bd">
				<form name="form1" method="post" action="?action=Edit" onsubmit="return checkform()">
        <table width="326" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="90" bgcolor="#fff">&nbsp;<input type="hidden" name="UserID" value="<%=UserID%>"></td>
            <td width="236" bgcolor="#fff">&nbsp;</td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">用 户 名：</td>
            <td align="left" bgcolor="#fff"><input type="text" name="UserName" id="UserName" class="loginipt" value="<%=UserName%>" readonly="readonly" /></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">设置密码：</td>
            <td align="left" bgcolor="#fff"><input type="password" name="UserPass" id="UserPass" class="loginipt" value="" /></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">确认密码：</td>
            <td align="left" bgcolor="#fff"><input type="password" name="Checkpass" id="Checkpass" class="loginipt" /></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">手机号码：</td>
            <td align="left" bgcolor="#fff"><input type="text" name="TelPhone" id="TelPhone" class="loginipt" value="<%=TelPhone%>" /><span style="color:red;">*</span></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff" class="fff">联系地址：</td>
            <td align="left" bgcolor="#fff"><input type="text" name="Address" id="Address" class="loginipt" value="<%=Address%>" /></td>
          </tr>
          <tr>
            <td height="36" align="right" bgcolor="#fff">&nbsp;</td>
            <td align="left" bgcolor="#fff"><input type="submit" value="提交" style="width: 60px;height: 24px;cursor: pointer;"></td>
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
					if ($("#UserPass").val()!="")
					{
						if ($("#UserPass").val()!=$("#Checkpass").val()) {
							alert("两次输入的密码不对，请重试");
							$("#Checkpass").focus();
							return false;
						};
					}
					if ($("#TelPhone").val()=="")
					{
						alert("手机号码不能为空");
						$("#TelPhone").focus();
						return false;
					}
					return true;
				  }
	        </script>
			</div>
		</div>
		<div class="main-l">
			<!--#include file="memleft.asp" -->
		</div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
</html>