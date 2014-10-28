<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("新闻资讯")%>
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
				<span class="position">当前位置：首页 > 新闻资讯</span>
				<span class="current">新闻资讯</span>
			</h2>
			<div class="news bd">
				<div class="shownews">
					<%
			ID=ReplaceBadChar(Trim(Request("ID")))
			if ID="" or IsNumeric(ID)=false then
			twScript("参数错误")
			end if
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql = "Select * From NewsInfo Where ID="&ID&""
			Rs.Open Sql,Conn,1,3
			if not (Rs.Eof or Rs.Bof) then
			Rs("NewsClick") = Rs("NewsClick")+1
		%>
          <h1 style="font-size:16px; line-height:40px; text-align:center;"><%=Rs("NewsTitle")%></h1>
          <span style="display:block; text-align:center;">作者：<%=Rs("NewsAuthor")%> 发表时间：<%=GetPostTime(ID,"newsinfo")%> 点击数：<%=Rs("NewsClick")%></span>
          <p><%=Rs("NewsContent")%></p>
        <%
			end if
			Rs.Update
			Rs.Close:Set Rs=Nothing
		%>
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