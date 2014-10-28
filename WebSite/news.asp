<!--#include file="Config/conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%=SiteKeysTitle("首页")%>
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
				<%
					Set Rs=Server.CreateObject("Adodb.RecordSet")
					Sqla = "Select * From newsinfo Where ClassID=1 order by NewsOrder Desc"
					Rs.Open Sqla,Conn,1,1
					Page=ReplaceBadChar(Trim(Request("Page")))
					PageSize =5
					Rs.PageSize = PageSize
					Total=Rs.RecordCount
					PGNum=Rs.PageCount
					If GetSafeInt(Page) > PGNum Then Page=PGNum
					If PGNum>0 Then Rs.AbsolutePage=Page
					i=0
					Do While Not Rs.Eof And i<Rs.PageSize
				%>
				<dl>
					<dt><a href="shownews.asp?ID=<%=Rs("ID")%>" target="_blank" title="<%=Rs("NewsTitle")%>"><%=Rs("NewsTitle")%></a><span><%=GetPostTime(Rs("ID"),"newsinfo")%></span></dt>
					<dd><%=left(OnlySaveText(Rs("newscontent")),120)&"......"%></dd>
				</dl>
				<%
				i=i+1
				Rs.MoveNext
				Loop
				Rs.Close:Set Rs=Nothing
				%>
		        <div class="newspage"><%=GetPage1("Where 1=1 and ClassID=1","newsinfo",4,0)%></div>
			</div>
		</div>
		<div class="main-l">
			<!--#include file="left.asp" -->
		</div>
	</div>
	<!--#include file="bottom.asp" -->
</body>
</html>