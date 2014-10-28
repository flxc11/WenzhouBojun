<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<%
	ClassID = ReplaceBadChar(Trim(Request("ClassID")))
	if ClassID="" or IsNumeric(ClassID)=false then
		ClassID=2
	end if
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
				<span class="current"><%=GetSubNavName("shopClass",ClassID)%></span>
			</h2>
			<div class="pro clearfix">
				<ul>
					<%
						Set Rs=Server.CreateObject("Adodb.RecordSet")
						Sql = "Select * From ShopInfo Where ClassID In ("&ClassID&GetAllChild("ShopClass",ClassID)&") order by ShopOrder desc"
						Rs.Open Sql,Conn,1,1
						Dim Page
						Page=Request("Page")                            
						PageSize = 12                                    
						Rs.PageSize = PageSize               
						Total=Rs.RecordCount               
						PGNum=Rs.PageCount               
						If Page="" Or clng(Page)<1 Then Page=1               
						If Clng(Page) > PGNum Then Page=PGNum               
						If PGNum>0 Then Rs.AbsolutePage=Page                         
						i=0
						Do While Not Rs.Eof And i<Rs.PageSize
					%>
                    <li><a href="showproducts.asp?ID=<%=Rs("ID")%>&ClassID=<%=Rs("ClassID")%>" title="<%=Rs("ShopName")%>" target="_blank"><img src="<%=Rs("ShopSPic")%>" alt=""/><span><%=GetShopTitle(Rs("ID"),20)%></span><span>价格：<%=Rs("ShopSPrice")%> 元</span></a></li>
                    <%
						i=i+1
						Rs.MoveNext
						Loop
					%>
                </ul>
                <div class="NewsPage"><%=GetPage1("Where ClassID in ("&ClassID&GetAllChild("ShopClass",ClassID)&")","shopinfo",12,0)%></div>
				</ul>
			</div>
		</div>
		<div class="main-l">
			<!--#include file="left.asp" -->
		</div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
</html>