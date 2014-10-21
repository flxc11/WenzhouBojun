var _Location = '';
var ThisURL = document.location.href;
function NewsPage(){
	var Reocrd = parseInt(JCms_Reocrd);
	var PageCount = parseInt(JCms_PageCount);
	var PageSize = parseInt(JCms_PageSize);
	var PageNo = parseInt(JCms_PageNo);
	var NewsPageStr = "<div class='JcmsNewsPage' id='JcmsNewsPage'>";
	var StartCount = (PageNo + 5) > PageCount ? PageCount - 9 : PageNo - 1;	
	var EndCount = PageNo < 5 ? 10 : PageNo + 5;	
	if (StartCount < 1) 
		StartCount = 1;
    if (PageCount < EndCount) 
		EndCount = PageCount;
	var TempUrl = ThisURL.split('/');	
	for (var i = 0; i < TempUrl.length - 1; i++) {
		_Location += TempUrl[i]+ '/';
	}
	NewsPageStr += "<em>共"+Reocrd+"条记录 共"+PageCount+"页</em>";
	NewsPageStr += PageNo > 1 ? "<a href='"+_Location+"Index_1.aspx' class='page_index'>首页</a><a href='"+_Location+"Index_" + (PageNo - 1) + ".aspx' class='page_index'>上一页</a>":"<em>首页</em>";
	for (var i = StartCount; i <= EndCount; i++)
    {
		NewsPageStr += PageNo == i ? "<span class='num'>"+i+"</span>":"<a href='"+_Location+"Index_"+i+".aspx' class='num amn'>"+i+"</a>";
	}
	NewsPageStr += PageNo != PageCount ? "<a href='"+_Location+"Index_"+(PageNo+1)+".aspx' class='page_index'>下一页</a><a href='"+_Location+"Index_"+(PageCount)+".aspx' class='page_index'>末页</a>":"<em>末页</em>";
	//NewsPageStr += "<input id='NewsPage-Btn' type='button' class='btn amn' value='GO' />";
	//NewsPageStr += "<input id='NewsPage-Num' type='text' class='txt' maxlength='2' onkeydown='if(event.keyCode==13)NewsPagesPost();' />";
	//NewsPageStr += "<div class='clear6'></div>";
	document.write(NewsPageStr+"</div>");
	$("#JcmsNewsPage .btn").click(function(){NewsPagesPost();})
}
function NewsPagesPost(){	
	var PostPageNo = parseInt($("#JcmsNewsPage .txt").val());	
	if(isNaN(PostPageNo)) return false;
	PostPageNo = PostPageNo > parseInt(JCms_PageCount) ? parseInt(JCms_PageCount): PostPageNo;
	PostPageNo = PostPageNo < 1 ? 1:PostPageNo;
	window.location.href = _Location+"Index_"+PostPageNo+".aspx";	
}

function NewsSearchPage(){
	var Reocrd = parseInt(JCms_Reocrd);
	var PageCount = parseInt(JCms_PageCount);
	var PageSize = parseInt(JCms_PageSize);
	var PageNo = parseInt(JCms_PageNo);
	var NewsPageStr = "<div class='JcmsNewsPage' id='JcmsNewsPage'>";
	var StartCount = (PageNo + 5) > PageCount ? PageCount - 9 : PageNo - 1;
	var EndCount = PageNo < 5 ? 10 : PageNo + 5;
	if (StartCount < 1)
		StartCount = 1;
    if (PageCount < EndCount)
		EndCount = PageCount;
	ThisURL = ThisURL.indexOf('?')!= -1 ? ThisURL.substr(0,ThisURL.indexOf('?')):ThisURL;
	NewsPage += "共有"+Reocrd+"条记录 共"+PageCount+"页";
	NewsPageStr += PageNo > 1 ? "<a href='"+ThisURL+"?PageNo=1&Keyword="+JCms_Keyword+"&ColumnID="+JCms_ColumnID+"' class='prev amn png'></a>":"<span class='prev png'></span>";
	for (var i = StartCount; i <= EndCount; i++)
    {
		NewsPageStr += PageNo == i ? "<span class='num'>"+i+"</span>":"<a href='"+ThisURL+"?PageNo="+i+"&Keyword="+JCms_Keyword+"&ColumnID="+JCms_ColumnID+"' class='num amn'>"+i+"</a>";
	}
	NewsPageStr += PageNo != PageCount ? "<a href='"+ThisURL+"?PageNo="+(PageNo+1)+"&Keyword="+JCms_Keyword+"&ColumnID="+JCms_ColumnID+"' class='next amn png'></a>":"<span class='next png'></span>";
	NewsPageStr += "<input id='NewsPage-Btn' type='button' class='btn amn' value='GO' />";
	NewsPageStr += "<input id='NewsPage-Num' type='text' class='txt' maxlength='2' onkeydown='if(event.keyCode==13)NewsPageSearchPost();' />";
	NewsPageStr += "<div class='clear6'></div>";
	document.write(NewsPageStr+"</div>");
	$("#JcmsNewsPage .btn").click(function(){NewsPageSearchPost();})
}
function NewsPageSearchPost(){	
	var PostPageNo = parseInt($("#JcmsNewsPage .txt").val());	
	if(isNaN(PostPageNo)) return false;
	PostPageNo = PostPageNo > parseInt(JCms_PageCount) ? parseInt(JCms_PageCount): PostPageNo;
	PostPageNo = PostPageNo < 1 ? 1:PostPageNo;
	window.location.href = ThisURL+"?PageNo="+PostPageNo+"&Keyword="+JCms_Keyword+"&ColumnID="+JCms_ColumnID;	
}