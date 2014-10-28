<div class="column">
	<h2>产品中心</h2>
	<ul>
		<%
            Set Rs=Server.CreateObject("Adodb.RecordSet")
            Sqla = "Select * From shopclass Where navparent=2 order by id"
            Rs.Open Sqla,Conn,1,1
            i=0
            Do While Not Rs.Eof And i<24
        %>
		<li <% if cstr(Rs("ID"))=cstr(ClassID) then %> class="hover" <%end if%>><a href="product.asp?ClassID=<%=Rs("ID")%>"><%=Rs("navtitle")%></a></li>
		<%
            i=i+1
            Rs.MoveNext
            loop
            Rs.Close:Set Rs=Nothing
        %>
	</ul>
</div>