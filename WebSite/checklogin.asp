<%
	if Session("UserName")="" then
		Response.Redirect("/login.asp")
		Response.end
	end if
%>