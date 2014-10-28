<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<%
	if Session("UserName")="" then
	Response.Write("<script>alert('请先登录在进行预订！');top.window.location.href='login.asp';</script>")
	Response.end
	end if
%>
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
	If Request("Action")="submit" Then
		If ValidCode("CSName",Request.Form("codeKey"),Request.Form("code")) Then
			UserID=ReplaceBadChar(Trim(Request("UserID")))
			AllPrice=ReplaceBadChar(Trim(Request("AllPrice")))
			TelPhone=ReplaceBadChar(Trim(Request("TelPhone")))
			Address=ReplaceBadChar(Trim(Request("Address")))
			ProID = Request("pro-check")
			ProNum = Request("num-list")
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select * From [Order]"
			Rs.Open Sql,Conn,1,3
			Rs.Addnew
			Rs("UserID")=UserID
			Rs("ICQ")=AllPrice
			Rs("TelPhone")=TelPhone
			Rs("Address")=Address
			Rs("ProID")=ProID
			Rs("ProNum")=ProNum
			Rs("PostTime")=Now()
			Rs.Update
			Response.Write("<script>alert('订购成功！');window.location.href='member.asp';</script>")
			Rs.Update
			Rs.Close
			Set Rs=Nothing
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
	<%=SiteKeysTitle("在线订购")%>
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
				<span class="position">当前位置：首页 > 在线订购</span>
				<span class="current">在线订购</span>
			</h2>
			<div class="about bd">
				<form action="?action=submit" method="post" onsubmit="return checkform()">
				<div>
					<h1 style="font-size: 16px; font-weight: bold;">订购须知：请勾选您需要的产品并在后面文本框中输入需要的数量！</h1>
				</div>
				<%
					Set Rs=Server.CreateObject("adodb.recordset")
					sql = "select * from shopclass where navparent=2 order by id"
					Rs.open Sql,Conn,1,1
					do while not Rs.Eof
				%>
					<div class="class-title"><%=Rs("NavTitle")%></div>
					<table width="600" border="0" cellspacing="1" cellpadding="1"  bgcolor="#ccc" align="center">
					  <tbody>
					    <tr>
					      <td width="30" align="center" bgcolor="#FFFFFF" height="30">&nbsp;</td>
					      <td width="306" align="center" bgcolor="#FFFFFF">产品名称</td>
					      <td width="100" align="center" bgcolor="#FFFFFF">价格</td>
					      <td width="154" align="center" bgcolor="#FFFFFF">数量</td>
					    </tr>
					    <%
					    	Set Rs1=Server.CreateObject("adodb.recordset")
							sql1 = "select * from shopinfo where classid="&Rs("ID")&" order by ShopOrder desc"
							Rs1.open Sql1,Conn,1,1
							do while not Rs1.Eof
					    %>
					    <tr>
					      <td align="center" bgcolor="#FFFFFF" height="30"><input type="checkbox" name="pro-check" value="<%=Rs1("id")%>"></td>
					      <td align="left" bgcolor="#FFFFFF" class="pl10"><%=Rs1("shopname")%></td>
					      <td align="center" bgcolor="#FFFFFF"><%=Rs1("shopsprice")%></td>
					      <td align="center" bgcolor="#FFFFFF"><input type="text" name="pro-num" style="width: 50px;text-align: center;" readonly="readonly"></td>
					    </tr>
					    <%
							Rs1.MoveNext
							loop
							Rs1.Close:Set Rs1=Nothing
						%>
					  </tbody>
					</table>
				<%
					Rs.MoveNext
					loop
					Rs.Close:Set Rs=Nothing
				%>
				<div class="class-title">&nbsp;</div>
				<div class="class-title">订购人信息</div>
				<%
					Set Rs2=Server.CreateObject("adodb.recordset")
					sql2 = "select * from UserReg where UserName='"&Session("UserName")&"'"
					Rs2.open Sql2,Conn,1,1
					if not Rs2.eof or Rs2.Bof then
				%>
				
				<input type="hidden" name="UserID" value="<%=Rs2("ID")%>">
				<table width="326" border="0" align="center" cellpadding="0" cellspacing="0">
		          <tr>
		            <td height="36" align="right" bgcolor="#fff" class="fff">总价：</td>
		            <td align="left" bgcolor="#fff"><input type="text" name="AllPrice" id="AllPrice" value="" class="loginipt" readonly="readonly" /></td>
		          </tr>
		          <tr>
		            <td height="36" align="right" bgcolor="#fff" class="fff">用 户 名：</td>
		            <td align="left" bgcolor="#fff"><input type="text" name="UserName" id="UserName" value="<%=Rs2("UserName")%>" class="loginipt" /><span style="color:red;">*</span></td>
		          </tr>
		          <tr>
		            <td height="36" align="right" bgcolor="#fff" class="fff">手机号码：</td>
		            <td align="left" bgcolor="#fff"><input type="text" name="TelPhone" id="TelPhone" class="loginipt" value="<%=Rs2("TelPhone")%>" /><span style="color:red;">*</span></td>
		          </tr>
		          <tr>
		            <td height="36" align="right" bgcolor="#fff" class="fff">联系地址：</td>
		            <td align="left" bgcolor="#fff"><input type="text" name="Address" id="Address" class="loginipt" value="<%=Rs2("Address")%>" /></td>
		          </tr>
		          <tr>
		            <td height="36" align="right" bgcolor="#fff" class="fff">验 证 码：</td>
		            <td align="left" bgcolor="#fff"><input type="hidden" name="codeKey" value="<%=codeKey%>"><input name="code" type="text" class="reginipt" id="code" /><img src="DvCode.asp?k=<%=codeKey%>" onclick="this.src+=parseInt(Math.random()*10)" alt="看不清楚？点击换一张" style="cursor:pointer;"></td>
		          </tr>
		          <tr>
		            <td align="right" bgcolor="#fff">&nbsp;</td>
		            <td align="left" bgcolor="#fff"><input type="submit" value="提交" style="width: 60px;height: 24px;cursor: pointer;"></td>
		          </tr>
		        </table>
				<input type="hidden" name="num-list" id="num-list">
		        <%
		        	end if
		        	Rs2.Close:Set Rs2=Nothing
		        %>
			</div>
			</form>
		</div>
		<div class="main-l">
			<!--#include file="left.asp" -->
		</div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
<script type="text/jscript">
$(function(){
	var allpri = 0;
	$("input[name='pro-check'][type=checkbox]")
	.on("click",function(){
		if ($(this).is(":checked")) {
			$(this).parent().next().next().next().find("input").removeAttr("readOnly");
			$(this).parent().next().next().next().find("input").val(1);
			checkprice();
		} else {
			checkprice();
			$(this).parent().next().next().next().find("input").val('');
		};
	});
	$("input[type='text'][name='pro-num']").on("change", function(){
		checkprice()
	})
	
})
function checkprice() {
	allpri = 0;
	$("input[name='pro-check'][type=checkbox]:checked").each(function(i,v){
		var _pri = Number($(v).parent().next().next().html());
		var _num = Number($(v).parent().next().next().next().find("input").val())
		allpri += Number(_pri*_num);
		
	})
	$("#AllPrice").val(allpri);
}
function checkform()
	{
	if ($("input[type='checkbox']:checked").length <1)
	{
		alert("请勾选您需要的产品并在后面文本框中输入需要的数量！");
		return false;
	} else {
		var _pronum = '';
		$("input[type='checkbox']:checked").each(function(i,v) {
			_pronum += $(this).parent().next().next().next().find("input").val() + ",";
		})
		$("#num-list").val(_pronum);
	}
	if ($("#UserName").val()=="")
	{
		alert("用户名不能为空");
		$("#UserName").focus();
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
</html>