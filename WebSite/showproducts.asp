<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<%
	ID=ReplaceBadChar(Trim(Request("ID")))
	if ID="" or IsNumeric(ID)=false then
	twscript("参数错误")
	end if
	ClassID=GetClassID(ID,"shopinfo")
	ParentCID = GetParentClassID(ClassID,"shopclass")
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("产品中心")%>
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
				<span class="position">当前位置：<a href="index.asp">首页</a><%=GetNavPath("shopclass",ClassID)%></span>
				<span class="current"><%=GetSubNavName("ShopClass",GetClassID(ID,"shopinfo"))%></span>
			</h2>
			<div class="news bd">
				<div class="shownews">
					<%
						Set Rs=Server.CreateObject("Adodb.RecordSet")
						Sql = "Select * From shopInfo Where ID="&ID&""
						Rs.Open Sql,Conn,1,3
						if not (Rs.Eof or Rs.Bof) then
					%>
			          <h1 style="font-size:16px; line-height:40px; text-align:center;"><%=Rs("shopname")%></h1>
			          <p><%=Rs("shopContent")%></p>
			        <%
						end if
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