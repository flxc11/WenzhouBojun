<div class="footer">
	<div class="footer-1">
		<div>
			<%
                Set Rs=Server.CreateObject("Adodb.RecordSet")
                Sqla = "Select top 10 * From shopclass Where navparent=2 order by id"
                Rs.Open Sqla,Conn,1,1
                i=0
                Do While Not Rs.Eof And i<24
            %>
			<a href="product.asp"><%=Rs("NavTitle")%></a> | 
			<%
                i=i+1
                Rs.MoveNext
                loop
                Rs.Close:Set Rs=Nothing
            %>
		</div>
	</div>
	<div class="footer-2">
		<div>
			<a href="index.asp">首页</a>   |   <a href="company.asp">公司简介</a>   |   <a href="product.asp">产品中心</a>   |   <a href="news.asp">新闻资讯</a>   |   <a href="order.asp">在线订购</a>   |   <a href="message.asp">留言中心</a>   |   <a href="contact.asp">联系我们</a><br>
			Copyright © Wenzhou Bojun E-Commerce Co.,Ltd. All Rights Reserved
		</div>
	</div>
</div>