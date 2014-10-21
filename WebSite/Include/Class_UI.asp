<!--#include file="Class_APC.asp" -->
<%
'**********************************************************************************************************
'章宵 2011-8-2 17:33:43
'函数用途：调用指定字段
'table		表名
'fieldName	字段名
'ID			ID
'**********************************************************************************************************
Function GetColumnName(table,fieldName,ID)
	SQLSTR = "Select "&fieldName&" From "&Table&" Where ID="&ID&""
	GetColumnName=Conn.Execute(SQLSTR)(0)
End Function
'**********************************************************************************************************
'章宵 2011-8-5 17:12:29
'函数用途		获取单页完整路径
'table		表名
'ID			ID
'ToUrl		跳转页面
'**********************************************************************************************************
Function GetPageNavPath(ID,ToUrl)
	Set Rs=Conn.Execute("Select ID,User_NavTitle,User_NavParent From User_PageCategory Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > <a href="""&ToUrl&"?classid="&base64Encode(Rs("ID"))&""">" & Rs("User_NavTitle") &"</a>"
		Str=GetPageNavPath(Rs("User_NavParent"),ToUrl) & Str
	End if
	GetPageNavPath=Str
End Function
'**********************************************************************************************************
'章宵 2011-8-5 17:12:29
'函数用途		获取产品完整路径
'table		表名
'ID			ID
'ToUrl		跳转页面
'**********************************************************************************************************
Function GetProNavPath(ID,ToUrl)
	Set Rs=Conn.Execute("Select ID,NavTitle,NavParent From ShopClass Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > <a href="""&ToUrl&"?classid="&base64Encode(Rs("ID"))&""">" & Rs("NavTitle") &"</a>"
		Str=GetProNavPath(Rs("NavParent"),ToUrl) & Str
	End if
	GetProNavPath=Str
End Function
'**********************************************************************************************************
'章宵 2011-8-5 17:12:29
'函数用途		获取新闻完整路径
'table		表名
'ID			ID
'ToUrl		跳转页面
'**********************************************************************************************************
Function GetNewsNavPath(ID,ToUrl)
	Set Rs=Conn.Execute("Select ID,NavTitle,NavParent From NewsClass Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > <a href="""&ToUrl&"?classid="&base64Encode(Rs("ID"))&""">" & Rs("NavTitle") &"</a>"
		Str=GetNewsNavPath(Rs("NavParent"),ToUrl) & Str
	End if
	GetNewsNavPath=Str
End Function
'**********************************************************************************************************
'章宵 2011-7-16 15:17:05
'函数用途：获取类别列表
'modelName		模块名称
'parentID		父ID
'CurrentID		当前ID
'topNum			前多少条
'Url			跳转页面名
'**********************************************************************************************************
Function GetClass(modelName,parentID,CurrentID,topNum,Url)
	Dim strSQL
	strSQL = "Select "
	if topNum<>0 then
		strSQL = strSQL&" top "&topNum
	end if
	select case modelName 
		case "news"
			strSQL = strSQL&" * From [NewsClass] Where NavParent="&parentID&" order by NavOrder asc"
		case "pro"
		 	strSQL = strSQL&" * From [ShopClass] Where NavParent="&parentID&" order by NavOrder asc"
		case "page"
		 	strSQL = strSQL&" * From [User_PageCategory] Where User_NavParent="&parentID&" order by User_NavOrder asc"
	end select
	Set Rs=Conn.Execute(strSQL)
	while Not (Rs.Eof Or Rs.Bof) 
		if modelName = "page" then			
			GetClass = GetClass&"<li><a href="""&Url&".asp?classid="&base64Encode(rs("ID"))&""""			
			if cint(rs("ID")) = cint(CurrentID) then
				GetClass = GetClass&"class='hover'"
			end if
			GetClass = GetClass&">"&rs("User_NavTitle")&"</a></li>"
		else
			GetClass = GetClass&"<li><a href="""&Url&".asp?classid="&base64Encode(rs("ID"))&""""
			if cint(rs("ID")) = cint(CurrentID) then
				GetClass = GetClass&"class='hover'"
			end if
			GetClass = GetClass&">"&rs("NavTitle")&"</a></li>"
		end if
		
		rs.movenext
	wend
	rs.close
	set rs = nothing
End Function
'======================================================产品模块=====================================================================
'*****************************************************
'章宵 2011-8-2 17:50:46
'函数用途：调用新闻列表
'tplName	模板名称，字符串，可字符串为空
'ClassID	模板名称，数字，可字符串为空
'TopNum		前多少条
'*****************************************************
Function GetTopPros(tplName,ClassID,TopNum,ToUrl)
		'如果有参数参入的话，就按照参数读取
		rClassID = ReplaceBadChar(base64Decode(Trim(Request("ClassID"))))
		if rClassID<>"" and IsNumeric(rClassID)=true   then
			ClassID = rClassID
		end if
		
		'定义模板路径
		Dim tplPath
		tplPath = GetTplPath(tplName,"Product")
		'读取模板
		tplContent = LoadTpl(tplPath)
		'定义正则规则
		Dim RegExpResult
		Set RegEx = New RegExp 
		RegEx.Pattern = "<!--for-->([\s\S]*?)<!--/for-->" 
		RegEx.IgnoreCase = True  
		RegEx.Global = True
		RegEx.MultiLine = True
		'包含for的html块
	 	set	forTpl = RegEx.Execute(tplContent)(0)
		'不包含for的html块
		loopTpl = forTpl.SubMatches(0)
		
		'定义载入数据后的内容及SQL语句
		Dim loopContent,sqlStr
		sqlStr = "Select * From [ShopInfo] where 1=1 "
		if ClassID<>0 and IsNumeric(ClassID)=true   then
			sqlStr = sqlStr&" and classid in ("&ClassID&AllChildClass(ClassID,"ShopClass")&")"
		end if
		sqlStr = sqlStr& " Order By ShopOrder Desc"
		
		'读取数据		
		'读取数据
		Set Rs=Conn.Execute(sqlStr)
		while Not (Rs.Eof Or Rs.Bof) 
			Url=rs("id")&","&rs("classid")
			itemC = loopTpl
			for j=0 to rs.fields.count-1			
				if isnull(rs(rs.fields(j).name)) = false then
					itemC = replace(itemC,"{#"&rs.fields(j).name&"}",rs(rs.fields(j).name))
				else
					itemC = replace(itemC,"{#"&rs.fields(j).name&"}","")
				end if	
			next
			itemC = replace(itemC,"{#NewsUrl}",ToUrl&".asp?Url="&base64Encode(Url))
			itemC = replace(itemC,"{#PostDate}",Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2))
			loopContent = loopContent&itemC
			i=i+1
			rs.movenext
		wend
		rs.close
		set rs = nothing
		GetTopPros = RegEx.Replace(tplContent,loopContent)
End Function
'*****************************************************
'章宵 2011-7-15 15:23:18
'函数用途：调用产品列表
'tplName	模板名称，字符串，可字符串为空
'ClassID	模板名称，数字，可字符串为空
'pSize		每页记录数，数字
'*****************************************************
Function iProduct(tplName,ClassID,pSize,ToUrl)
		'如果有参数参入的话，就按照参数读取
		rClassID = base64Decode(ReplaceBadChar(Trim(Request("ClassID"))))

		if ClassID="" then
			ClassID = rClassID
		end if
		
		'定义模板路径
		Dim tplPath
		tplPath = GetTplPath(tplName,"Product")		
		'读取模板
		tplContent = LoadTpl(tplPath)
		'定义正则规则
		Dim RegExpResult
		Set RegEx = New RegExp 
		RegEx.Pattern = "<!--for-->([\s\S]*?)<!--/for-->" 
		RegEx.IgnoreCase = True  
		RegEx.Global = True
		RegEx.MultiLine = True
		'包含for的html块
	 	set	forTpl = RegEx.Execute(tplContent)(0)
		'不包含for的html块
		loopTpl = forTpl.SubMatches(0)
		
		'定义载入数据后的内容及SQL语句
		Dim loopContent,sqlStr
		sqlStr = "Select * From [ShopInfo] where 1=1 "
		if ClassID<>0 and IsNumeric(ClassID)=true   then
			sqlStr = sqlStr&" and classid in ("&ClassID&AllChildClass(ClassID,"ShopClass")&")"
		end if
		'章宵 2011-7-16
		sqlStr = sqlStr& " Order By ShopOrder desc,ID desc"
		'response.Write(sqlStr&"||"&ClassID)
		'读取数据		
		Set MyPage=New PageClass
		MyPage.GetConn=conn
		MyPage.GetSql=sqlStr
		MyPage.PageSize=pSize
		set Rs=MyPage.GetRs()		
		for i=1 to MyPage.PageSize
			if not rs.eof then
				Url=rs("id")&","&rs("classid")
				itemC = loopTpl
				for j=0 to rs.fields.count-1
					if isnull(rs(rs.fields(j).name)) = false then
						itemC = replace(itemC,"{#"&rs.fields(j).name&"}",rs(rs.fields(j).name))
					else
						itemC = replace(itemC,"{#"&rs.fields(j).name&"}","")
					end if					
				next	
				itemC = replace(itemC,"{#NewsUrl}",ToUrl&".asp?Url="&base64Encode(Url))
				itemC = replace(itemC,"{#PostDate}",Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2))
				loopContent = loopContent&itemC
				rs.movenext
			end if
		next
				
		Dim Paper
		Paper =  MyPage.ShowPage()
		iProduct = RegEx.Replace(tplContent,loopContent)
		iProduct = Replace(iProduct,"{#Paper}","<div class='pager'><div id='myPageSize' class='myPageStyle1' >"&Paper&"</div></div>")
End Function
'*****************************************************
'章宵 2011-7-12
'函数用途：调用产品详情
'tplName	模板名称，字符串，可字符串为空
'*****************************************************
Function iProductShow(tplName)
	Dim tplUrl
	tplUrl = GetTplPath(tplName,"ProductShow")
	URL=ReplaceBadChar(Trim(Request("URL")))
	if request("URL")<>"" then
		URL=base64Decode(URL)
		A=split(URL,",")
		if UBound(A)=1 then
			ID=A(0)
			ClassID=A(1)
		else
			response.Write("<script>alert('参数错误');history.back()</script>")
			response.end()
		end if
	end if
	if ID<>"" and IsNumeric(ID)=true   then
	Dim Rs
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From [ShopInfo] where id="&ID&""
	Rs.Open Sql,Conn,1,3
	If Not (Rs.Eof Or Rs.Bof) Then		
		Rs("ShopClick")=Rs("ShopClick")+1
		Rs.Update
		tplContent = LoadTpl(tplUrl)		
		tplContent = DbTag(Rs,tplContent)		
		Rs.Close
		Set Rs=Nothing
		response.Write(tplContent)
	Else
		Response.Write("<script>alert('Parameter error, determined BACK!');history.back();</script>")
		Response.End()
	End If    
	end if
End Function
'======================================================新闻模块=====================================================================
'*****************************************************
'章宵 2011-8-2 17:50:46
'函数用途：调用单页新闻
'tplName	模板名称，字符串，可字符串为空
'ClassID	模板名称，数字，可字符串为空
'*****************************************************
Function GetOneNews(tplName,ClassID)
	'如果有参数参入的话，就按照参数读取
	rClassID = ReplaceBadChar(base64Decode(Trim(Request("ClassID"))))
	if ClassID="" or IsNumeric(ClassID)=false then
		ClassID = rClassID
	end if
	
	if ClassID = "" then
		GetOneNews = ""
	end if
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select top 1 * From [NewsInfo] where NewsIndex = 1 and ClassID="&ClassID&" order by NewsOrder desc"
	Rs.Open Sql,Conn,1,3
	If Not (Rs.Eof Or Rs.Bof) Then		
		Rs("NewsClick")=Rs("NewsClick")+1
		Rs.Update
		'定义模板路径
		Dim tplPath
		tplPath = GetTplPath(tplName,"News")		
		'读取模板
		tplContent = LoadTpl(tplPath)	
		tplContent = DbTag(Rs,tplContent)		
		Rs.Close
		Set Rs=Nothing
		response.Write(tplContent)
	End If    
end Function
'*****************************************************
'章宵 2011-8-2 17:50:46
'函数用途：调用新闻列表
'tplName	模板名称，字符串，可字符串为空
'ClassID	模板名称，数字，可字符串为空
'TopNum		前多少条
'*****************************************************
Function GetTopNews(tplName,ClassID,TopNum,ToUrl,Where)
		'如果有参数参入的话，就按照参数读取
		rClassID = ReplaceBadChar(base64Decode(Trim(Request("ClassID"))))
		if rClassID<>"" and IsNumeric(rClassID)=true   then
			ClassID = rClassID
		end if
		
		'定义模板路径
		Dim tplPath
		tplPath = GetTplPath(tplName,"News")		
		'读取模板
		tplContent = LoadTpl(tplPath)
		'定义正则规则
		Dim RegExpResult
		Set RegEx = New RegExp 
		RegEx.Pattern = "<!--for-->([\s\S]*?)<!--/for-->" 
		RegEx.IgnoreCase = True  
		RegEx.Global = True
		RegEx.MultiLine = True
		'包含for的html块
	 	set	forTpl = RegEx.Execute(tplContent)(0)
		'不包含for的html块
		loopTpl = forTpl.SubMatches(0)
		
		'定义载入数据后的内容及SQL语句
		Dim loopContent,sqlStr
		sqlStr = "select "
		if topNum<>0 then
			sqlStr = sqlStr&" top "&TopNum
		end if
		sqlStr = sqlStr&" * From [NewsInfo] where 1=1 "
		if ClassID<>"" and IsNumeric(ClassID)=true   then
			sqlStr = sqlStr&" and classid in ("&ClassID&AllChildClass(ClassID,"NewsClass")&")"
		end if
		if Where<>"" then
			sqlStr = sqlStr&" "&Where
		end if
		sqlStr = sqlStr& " Order By NewsOrder Desc"
'		response.Write sqlStr
'		response.End
		'读取数据		
		'读取数据
		Set Rs=Conn.Execute(sqlStr)
		while Not (Rs.Eof Or Rs.Bof) 
			Url=rs("id")&","&rs("classid")
			itemC = loopTpl
			for j=0 to rs.fields.count-1			
				if isnull(rs(rs.fields(j).name)) = false then
					itemC = replace(itemC,"{#"&rs.fields(j).name&"}",rs(rs.fields(j).name))
				else
					itemC = replace(itemC,"{#"&rs.fields(j).name&"}","")
				end if	
			next	
			itemC = replace(itemC,"{#NewsContentNoHtml}",ClearHtml(rs("NewsContent")))
			itemC = replace(itemC,"{#EnNewsContentNoHtml}",ClearHtml(rs("EnNewsContent")))
			itemC = replace(itemC,"{#NewsUrl}",ToUrl&".asp?Url="&base64Encode(Url))
			itemC = replace(itemC,"{#PostDate}",Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2))
			loopContent = loopContent&itemC
			rs.movenext
		wend
		rs.close
		set rs = nothing
		GetTopNews = RegEx.Replace(tplContent,loopContent)
End Function
'*****************************************************
'章宵 2011-7-12
'函数用途：调用新闻列表
'tplName	模板名称，字符串，可字符串为空
'ClassID	模板名称，数字，可字符串为空
'pSize		每页记录数，数字
'*****************************************************
Function iNews(tplName,ClassID,pSize,ToUrl)
		'如果有参数参入的话，就按照参数读取
		rClassID = ReplaceBadChar(base64Decode(Trim(Request("ClassID"))))
		if rClassID<>"" and IsNumeric(rClassID)=true   then
			ClassID = rClassID
		end if
		
		'定义模板路径
		Dim tplPath
		tplPath = GetTplPath(tplName,"News")		
		'读取模板
		tplContent = LoadTpl(tplPath)
		'定义正则规则
		Dim RegExpResult
		Set RegEx = New RegExp 
		RegEx.Pattern = "<!--for-->([\s\S]*?)<!--/for-->" 
		RegEx.IgnoreCase = True  
		RegEx.Global = True
		RegEx.MultiLine = True
		'包含for的html块
	 	set	forTpl = RegEx.Execute(tplContent)(0)
		'不包含for的html块
		loopTpl = forTpl.SubMatches(0)
		
		'定义载入数据后的内容及SQL语句
		Dim loopContent,sqlStr
		sqlStr = "Select * From [NewsInfo] where 1=1 "
		if ClassID<>"" and IsNumeric(ClassID)=true   then
			sqlStr = sqlStr&" and classid in ("&ClassID&AllChildClass(ClassID,"NewsClass")&")"
		end if
		sqlStr = sqlStr& " Order By PostTime desc,ID desc"
		
		'读取数据		
		Set MyPage=New PageClass
		MyPage.GetConn=conn
		MyPage.GetSql=sqlStr
		MyPage.PageSize=pSize
		set Rs=MyPage.GetRs()		
		for i=1 to MyPage.PageSize
			if not rs.eof then
				Url=rs("id")&","&rs("classid")
				itemC = loopTpl
				for j=0 to rs.fields.count-1			
					if isnull(rs(rs.fields(j).name)) = false then
						itemC = replace(itemC,"{#"&rs.fields(j).name&"}",rs(rs.fields(j).name))
					else
						itemC = replace(itemC,"{#"&rs.fields(j).name&"}","")
					end if	
				next	
				itemC = replace(itemC,"{#NewsContentNoHtml}",ClearHtml(rs("NewsContent")))
				itemC = replace(itemC,"{#NewsUrl}",ToUrl&".asp?Url="&base64Encode(Url))
				itemC = replace(itemC,"{#PostDate}",Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2))
				loopContent = loopContent&itemC
				rs.movenext
			end if
		next
				
		Dim Paper
		Paper =  MyPage.ShowPage()
		iNews = RegEx.Replace(tplContent,loopContent)
		iNews = Replace(iNews,"{#Paper}","<div class='pager'><div id='myPageSize' class='myPageStyle1' >"&Paper&"</div></div>")
End Function
'*****************************************************
'章宵 2011-7-12
'函数用途：调用新闻详情
'tplName	模板名称，字符串，可字符串为空
'*****************************************************
Function iNewsShow(tplName)
	Dim tplUrl
	tplUrl = GetTplPath(tplName,"NewsShow")
	URL=ReplaceBadChar(Trim(Request("URL")))
	if request("URL")<>"" then
		URL=base64Decode(URL)
		A=split(URL,",")
		if UBound(A)=1 then
			ID=A(0)
			ClassID=A(1)
		else
			iNewsShow = ""
		end if
	end if
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From [NewsInfo] where id="&ID&""
	Rs.Open Sql,Conn,1,3
	If Not (Rs.Eof Or Rs.Bof) Then		
		Rs("NewsClick")=Rs("NewsClick")+1
		Rs.Update
		tplContent = LoadTpl(tplUrl)		
		tplContent = DbTag(Rs,tplContent)		
		Rs.Close
		Set Rs=Nothing
		response.Write(tplContent)
	Else
		Response.Write("<script>alert('Parameter error, determined BACK!');history.back();</script>")
		Response.End()
	End If    
End Function
'======================================================模板通用函数=====================================================================
'*****************************************************
'利用AdoDb.Stream对象来读取UTF-8格式的文本文件
'章宵 2011-7-8
'*****************************************************
Function LoadTpl (FileUrl)
	set fso=server.CreateObject("scripting.Filesystemobject")
	if fso.FileExists(server.MapPath(FileUrl)) then
		dim str
		set stm=server.CreateObject("adodb.stream")
		stm.Type=2 '以本模式读取
		stm.mode=3 
		stm.charset="utf-8"
		stm.open
		stm.loadfromfile server.MapPath(FileUrl)
		str=stm.readtext
		stm.Close
		set stm=nothing
		LoadTpl=str
	else
		response.Write(server.MapPath(FileUrl)&"模板文件不存在")
		response.End()
	end if	    
End Function
'*****************************************************
'替换标签
'章宵 2011-7-8
'*****************************************************
Function DbTag(rsX,tplContent)
	Dim rs 
	set rs = rsX
	for j=0 to rs.fields.count-1	
		if isnull(rs(rs.fields(j).name)) =false then 
			tplContent = replace(tplContent,"{#"&rs.fields(j).name&"}",rs(rs.fields(j).name))
		else
			tplContent = replace(tplContent,"{#"&rs.fields(j).name&"}","")
		end if
	next
	DbTag = tplContent
End Function
'*****************************************************
'获取模板路径
'章宵 2011-7-9
'*****************************************************
Function GetTplPath(tplName,defaultName)
	if tplName = "" then
		tplUrl = "iTemplate/"&defaultName&".html"
	else
		tplUrl =  "iTemplate/"&tplName&".html"
	end if 
	GetTplPath = tplUrl
End Function


'/* 函数名称：Zxj_ReplaceHtml ClearHtml 
'/* 函数语言：VBScript Language 
'/* 作 用：清除文件HTML格式函数 
'/* 传递参数：Content (注：需要进行清除的内容) 
'/* 函数说明：正则匹配(正则表达式)模式进行数据匹配替换

Function ClearHtml(Content) 
Content=Zxj_ReplaceHtml("&#[^>]*;","", Content) 
Content=Zxj_ReplaceHtml("</?marquee[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?object[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?param[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?embed[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?table[^>]*>","", Content) 
Content=Zxj_ReplaceHtml(" ","",Content) 
Content=Zxj_ReplaceHtml("</?tr[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?th[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?p[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?a[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?img[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?tbody[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?li[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?span[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?div[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?th[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?td[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?script[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("(javascript|jscript|vbscript|vbs):", "",Content) 
Content=Zxj_ReplaceHtml("on(mouse|exit|error|click|key)", "",Content) 
Content=Zxj_ReplaceHtml("< \\?xml[^>]*>", "",Content) 
Content=Zxj_ReplaceHtml("<\/?[a-z]+:[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?font[^>]*>","", Content) 
Content=Zxj_ReplaceHtml("</?b[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?u[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?i[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?strong[^>]*>","",Content) 
ClearHtml=Content 
End Function

Function Zxj_ReplaceHtml(patrn, strng,content) 
IF IsNull(content) Then 
content="" 
End IF 
Set regEx = New RegExp ' 建立正则表达式。 
regEx.Pattern = patrn ' 设置模式。 
regEx.IgnoreCase = true ' 设置忽略字符大小写。 
regEx.Global = True ' 设置全局可用性。 
Zxj_ReplaceHtml=regEx.Replace(content,strng) ' 执行正则匹配 
End Function 
%>