function fun(IsOffer)
{
		if(IsOffer=="True")
		{
			if (document.from1.Offer.value.length==0)
			{
			window.alert("\u4f9b\u5e94\u5546\u4e0d\u80fd\u4e3a\u7a7a\u0021");
			document.form1.Offer.focus();
			return false;
			}
		}
		
		if (document.from1.userName.value.length==0)
		{
		window.alert("\u7528\u6237\u540d\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.userName.focus();
		return false;
		}
		
		if (document.from1.passWord.value.length==0)
		{
		window.alert("\u5e10\u53f7\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.passWord.focus();
		return false;
		}
		else
		{
			if(document.from1.passWord.value.length<6||document.from1.passWord.value.length>20)
			{
				window.alert("\u5bc6\u7801\u957f\u5ea6\u5e94\u5728\u0036\u81f3\u0032\u0030\u4f4d\u4e4b\u95f4\u0021");
				document.form1.passWord.focus();
				return false
			}
		}
		
		if (document.from1.RePassWord.value.length==0)
		{
		window.alert("\u786e\u8ba4\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.RePassWord.focus();
		return false;
		}
		
		if (document.from1.Sex.value.length==0)
		{
		window.alert("\u6027\u522b\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.Sex.focus();
		return false;
		}
		
		if (document.from1.Address.value.length==0)
		{
		window.alert("\u8be6\u7ec6\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.Address.focus();
		return false;
		}
		
		if (document.from1.CellPhone.value.length==0)
		{
		window.alert("\u624b\u673a\u53f7\u7801\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.CellPhone.focus();
		return false;
		}
		
		if (document.from1.Code.value.length==0)
		{
		window.alert("\u9a8c\u8bc1\u7801\u4e0d\u80fd\u4e3a\u7a7a\u0021");
		document.form1.Code.focus();
		return false;
		}
		
		return true;
		}