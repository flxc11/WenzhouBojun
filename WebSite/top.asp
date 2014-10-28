<div class="header">
	<div class="in-header">
		<div class="add">
			<%
				if Session("UserName")="" then
			%>
				<span class="fav"><a href="login.asp">会员登录</a> / <a href="reg.asp">注册会员</a></span>
			<%else%>
				<%
					Set Rs2=Server.CreateObject("adodb.recordset")
					sql2 = "select * from UserReg where UserName='"&Session("UserName")&"'"
					Rs2.open Sql2,Conn,1,1
					if not (Rs2.eof or Rs2.Bof) then
					UserID = Rs2("ID")
					end if
					Rs2.Close:Set Rs2=Nothing
				%>
				<span class="fav"><a href="member.asp">会员中心</a> / <a href="loginout.asp">退出登录</a></span>
			<%
				end if
			%>
			
			<span class="tel">86-577-88888888</span>
		</div>
		<div class="logo"><img src="images/imglogo.jpg" alt=""></div>
	</div>
</div>
<div class="banner">
	<div class="in-banner">
		<div class="nav">
			<ul>
				<li><a href="index.asp">首页</a></li>
				<li><a href="product.asp">产品中心</a></li>
				<li><a href="company.asp">公司简介</a></li>
				<li><a href="news.asp">新闻资讯</a></li>
				<li><a href="order.asp">在线订购</a></li>
				<li><a href="message.asp">留言中心</a></li>
				<li><a href="contact.asp">联系我们</a></li>
			</ul>
			<div class="search">
				<form action="search.asp" method="post">
					<input type="submit" value=" " class="ipt-submit">
					<input type="text" name="keyword" id="keyword" class="ipt-keyword">
				</form>
			</div>
		</div>
		<div class="ban JC1">
	        <div class="mycarousel Public-JC">
	            <ul>
	            	<%
                        Set Rs=Server.CreateObject("Adodb.RecordSet")
                        Sqla = "Select top 5 * From shopinfo Where ClassID =1 order by shopOrder Desc"
                        Rs.Open Sqla,Conn,1,1
                        i=0
                        Do While Not Rs.Eof And i<5
                    %>
                    <li><img src="<%=Rs("shopspic")%>" alt="" /></li>
                    <%
						i=i+1
						Rs.MoveNext
						Loop
					%>
	            </ul>
	            <div class="pagination"></div>
	            <div class="loading"></div>
	        </div>
	    </div>
	</div>
</div>