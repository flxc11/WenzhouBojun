<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="Include/Class_MD5.asp" -->

<%
	if Request("action")="Reg" then
	UserName=ReplaceBadChar(Trim(Request("UserName")))
	UserPass=ReplaceBadChar(Trim(Request("UserPass")))
	UserPass = MD5(UserPass,32)
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From UserReg Where UserName='"&UserName&"' and UserPass='"&UserPass&"'"
		Rs.Open Sql,Conn,1,1
		if not (Rs.Eof or Rs.Bof) then
			Session("UserName")=UserName
			Response.Write("<script>alert('登录成功');top.window.location.href='member.asp';</script>")
		else
		Response.Write("<script>alert('登录失败，账号或密码错误');history.go(-1);</script>")
		Response.End()
		end if
		Rs.Close
		Set Rs=Nothing
%>
<% else %>

<% end if %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("会员登录")%>
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
				<span class="position">当前位置：首页 > 会员登录</span>
				<span class="current">会员登录</span>
			</h2>
			<div class="about bd">
				<div style="padding-top:36px;">
      <%
	  	if Session("UserName")="" then
	  %>
      <form name="form1" method="post" action="?action=Reg" onsubmit="return checkform()">
        <table width="304" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="75" height="50" align="right" bgcolor="#fff" class="fff">用户名：</td>
            <td width="229" align="left" bgcolor="#fff"><input type="text" name="UserName" id="UserName" class="loginipt" /></td>
          </tr>
          <tr>
            <td height="50" align="right" bgcolor="#fff" class="fff">密　码：</td>
            <td align="left" bgcolor="#fff"><input type="password" name="UserPass" id="UserPass" class="loginipt" /></td>
          </tr>
          <tr>
            <td align="right" bgcolor="#fff">&nbsp;</td>
            <td align="left" bgcolor="#fff"><input type="submit" name="button" id="button" value=" " style="width:73px; height:29px; border:none; background:url(images/btnsubmit.gif); cursor:pointer;" />　　<input type="reset" name="button2" id="button2" value=" " style="width:73px; height:29px; border:none; background:url(images/btnreset.gif); cursor:pointer;" /></td>
          </tr>
          <tr>
            <td align="right" bgcolor="#fff" height="60">&nbsp;</td>
            <td align="left" bgcolor="#fff" height="60">还没有账号？请马上<a href='reg.asp' style='color:red;'>注册</a></td>
          </tr>
        </table>
      </form>
      <%
	  	else
	  %>
        <table width="304" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="168" align="center" bgcolor="#fff" class="fff">欢迎 <font color="#FF0000"><%=Session("UserName")%></font> 回来，<a href="loginout.asp" class="reglink">退出</a></td>
          </tr>
        </table>
      <% end if %>
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