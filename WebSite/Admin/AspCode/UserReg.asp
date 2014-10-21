<%
sub MemberRegister()
	If Request("action")="MemberRegister" Then
		memberNum=Request("userName")
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From [UserReg] where UserName='"&memberNum&"'"
		Rs.Open Sql,Conn,1,1
		if not Rs.eof and Rs.recordcount>0 then
		Response.Write("<script>window.alert('对不起，此用户名已经被注册!');</script>")
		else
			passWord=Request("passWord")
			RePassWord=Request("RePassWord")
			if Trim(passWord)=Trim(RePassWord) then
				if cstr(Session("Code"))=cstr(Request("checkCode")) then
					if IsOffer = true then
						Offer=Request("Offer")
					end if
					if Request("Sex")="男" then
						Sex="男"
					else
						Sex="女"
					end if
					Address=Request("Address")
					TelPhone=Request("TelPhone")
					CellPhone=Request("CellPhone")
					Set Rs=Server.CreateObject("Adodb.RecordSet")
					Sql="Select * From [UserReg]"
					Rs.Open Sql,Conn,1,3
					Rs.AddNew()
					if IsOffer = true then
					Rs("Offer")=Offer
					end if
					Rs("UserName")=memberNum
					Rs("UserPass")=MD5(passWord,32)
					Rs("RePassWord")=MD5(RePassWord,32)
					Rs("Sex")=Sex
					Rs("Address")=Address
					Rs("TelPhone")=TelPhone
					Rs("CellPhone")=CellPhone
					Rs("PostTime")=now()
					Rs.update()
					Rs.close
					Set Rs=Nothing
					Response.Write("<script>window.alert('注册成功!');</script>")
					Response.write("<script>window.location.href='UserReg.asp';</script>")
					memberNum=""
				else
					Response.Write("<script>window.alert('您输入的验证码不正确!');</script>")
				end if
			else
				Response.Write("<script>window.alert('密码与确认密码不一致,请重新填写信息!');</script>")
				Response.write("<script>window.location.href='UserReg.asp';</script>")
			end if
		end if
	End If
end sub
		
		sub accept()
	If Request("action")="accept" Then
		Response.write("<script>window.location.href='UserReg.asp';</script>")
	end if
end sub
Select Case Request("action")
Case "MemberRegister"
Call MemberRegister()
Case "accept"
Call accept()
End Select
%>