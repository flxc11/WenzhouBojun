<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="checklogin.asp" -->
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("公司简介")%>
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
				<span class="position">当前位置：首页 > 会员中心 > 订单信息</span>
				<span class="current">订单信息</span>
			</h2>
			<div class="about bd">
				<table width="700" border="0" cellspacing="1" cellpadding="1" bgcolor="#999">
				  <tbody>
				    <tr>
				      <td width="30" height="30" align="center" bgcolor="#FFFFFF">&nbsp;</td>
				      <td width="100" align="center" bgcolor="#FFFFFF">订购人</td>
				      <td width="347" align="center" bgcolor="#FFFFFF">订购内容</td>
				      <td width="100" align="center" bgcolor="#FFFFFF">总价</td>
				      <td width="110" align="center" bgcolor="#FFFFFF">订购时间</td>
				    </tr>
				    <%
						Set Rs=Server.CreateObject("Adodb.RecordSet")
						Sql = "Select * From [order] Where UserID='"&UserID&"' order by posttime desc"
						Rs.Open Sql,Conn,1,1
						Dim Page
						Page=Request("Page")
						PageSize = 10
						Rs.PageSize = PageSize
						Total=Rs.RecordCount
						PGNum=Rs.PageCount
						If Page="" Or clng(Page)<1 Then Page=1
						If Clng(Page) > PGNum Then Page=PGNum
						If PGNum>0 Then Rs.AbsolutePage=Page
						i=0
						Do While Not Rs.Eof And i<Rs.PageSize
					%>
				    <tr>
				      <td height="30" align="center" bgcolor="#FFFFFF"><%=i+1%></td>
				      <td align="center" bgcolor="#FFFFFF"><%=Session("UserName")%></td>
				      <td align="left" bgcolor="#FFFFFF" class="pl10">
				      	<%
				      		ProI = Split(Rs("ProID"),",")
				      		ProN = Split(Rs("ProNum"),",")
				      		For k = LBound(ProI) To UBound(ProI)
				      			Set Rsq = Server.CreateObject("Adodb.RecordSet")
				      			Sqlq = "select * from shopinfo where ID="&ProI(k)&""
				      			Rsq.Open Sqlq,Conn,1,1
				      			if not (Rsq.eof or Rsq.bof) Then
				      				Response.write "产品："&Rsq("shopname")&"&nbsp;数量："&ProN(k)&"<br>"
				      			end if
				      		Next
				      	%>
				      </td>
				      <td align="center" bgcolor="#FFFFFF"><%=Rs("ICQ")%></td>
				      <td align="center" bgcolor="#FFFFFF"><%=GetPostTime(Rs("ID"),"[order]")%></td>
				    </tr>
				    <%
						i=i+1
						Rs.MoveNext
						Loop
					%>
				  </tbody>
				</table>
				<div class="NewsPage"><%=GetPage1("Where UserID='"&UserID&"'","[order]",10,0)%></div>
			</div>
		</div>
		<div class="main-l">
			<!--#include file="memleft.asp" -->
		</div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
</html>