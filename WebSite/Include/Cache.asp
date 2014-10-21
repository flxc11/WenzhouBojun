<%
Dim ebdiy_Version, ebdiy_UpdateTime
Dim Web_Title, Web_BaseURL, Web_Keyword, Web_Description, Web_Logo, Web_Bannner, Web_State, Web_CloseInfo, Web_Mii, Web_LangPack, Web_CopyRight, Web_License, Web_Tel, Web_Email, Web_QQ, Web_Adress, Web_Contact, Web_DefaultTemplate, Web_NavList, Web_MartList, Web_OrderList, Web_Audit, Web_PostFile

ebdiy_Version = "1.0.0.637"
ebdiy_UpdateTime = "2009-07-20"

'******************************************************
' 全局缓存变量
' ebdiy.com
' 2009-06-23
'******************************************************	

'******************************************************
' 站点基本状态
'******************************************************	
Function Control_Config(ByVal Action)
  Dim Rs, SQL, ConfigArray
  If Not IsArray(Application(CookieName & "_Config")) Or Action = 2 Then
	  SQL = "Select Top 1 Web_Title, Web_BaseURL, Web_Keyword, Web_Descrition, Web_Logo, Web_Bannner, Web_State, Web_CloseInfo, Web_Mii, Web_LangPack, Web_CopyRight, Web_License, Web_Tel, Web_Email, Web_QQ, Web_Adress, Web_Contact, Web_DefaultTemplate, Web_NavList, Web_MartList, Web_OrderList, Web_Audit, Web_PostFile From ebdiy_Config"
	  Set Rs = Conn.Rs(SQL, 1, 1)
	  If Rs.Bof Or Rs.Eof Then
		  Redim ConfigArray(0, 0)
	  Else
		  ConfigArray = Rs.GetRows()
	  End If
	  Application.Lock()
	  Application(CookieName & "_Config") = ConfigArray
	  Application.UnLock()
  Else
	  ConfigArray = Application(CookieName & "_Config")
  End If
  
  If Action <> 2 Then
	  If Ubound(ConfigArray, 1) = 0 Then
		  Control_Config = ""
		  Exit Function
	  Else
		  Web_Title = ConfigArray(0, 0) ' 网站标题
		  Web_BaseURL = ConfigArray(1, 0) '网站基址
		  Web_Keyword = ConfigArray(2, 0) '整站关键字
		  Web_Description = ConfigArray(3, 0) '整站描述
		  Web_Logo = ConfigArray(4, 0) '网站LOGO
		  Web_Bannner = ConfigArray(5, 0) '网站BANNER
		  Web_State = ConfigArray(6, 0) '网站开关
		  Web_CloseInfo = ConfigArray(7, 0) '关闭原因
		  Web_Mii = ConfigArray(8, 0) '备案号
		  Web_LangPack = ConfigArray(9, 0) '语言包
		  Web_CopyRight = ConfigArray(10, 0) '版权
		  Web_License = ConfigArray(11, 0) '营业执照
		  Web_Tel = ConfigArray(12, 0) '电话
		  Web_Email = ConfigArray(13, 0) '邮箱
		  Web_QQ = ConfigArray(14, 0) 'QQ
		  Web_Adress = ConfigArray(15, 0) '地址
		  Web_Contact = ConfigArray(16, 0) '联系人
		  Web_DefaultTemplate = ConfigArray(17, 0) '默认模板
		  Web_NavList = ConfigArray(18, 0) '导航类型
		  Web_MartList = ConfigArray(19, 0) '是否开启购物车
		  Web_OrderList = ConfigArray(20, 0) '是否开启订单
		  Web_Audit = ConfigArray(21, 0) '是否开启留言评论的审核
		  Web_PostFile = ConfigArray(22, 0) '整站模式,动态还是静态 0为动态 1为静态
	  End If
  End If
End Function

'******************************************************
' 新闻列表缓存
'******************************************************	
Function Control_News(ByVal Action)
	Dim Rs, SQL, NewsArray
	If Not IsArray(Application(CookieName & "_News")) Or Action = 2 Then
		SQL = "Select News_ID,News_Title,News_Author,News_ClassID,News_Content From ebdiy_News Where News_Deleted=False Order By News_PostDate DESC"
		Set Rs = Conn.Rs(SQL, 1, 1)
		If Rs.Bof Or Rs.Eof Then
			ReDim NewsArray(0, 0)
		Else
			NewsArray = Rs.GetRows()
		End If
		Application.Lock()
	  	Application(CookieName & "_News") = NewsArray
	  	Application.UnLock()
	Else
		NewsArray = Application(CookieName & "_News")
	End If
	
	Control_News = NewsArray
	
End Function

'******************************************************
' 产品列表缓存
'******************************************************	
Function Control_Product(ByVal Action)
	Dim Rs, SQL, ProductArray
	If Not IsArray(Application(CookieName & "_Products")) Or Action = 2 Then
		SQL = "Select Product_ID,Product_Name,Product_ClassID,Product_Content,Product_Actor From ebdiy_Product Where Product_Deleted=False Order By Product_PostDate DESC"
		Set Rs = Conn.Rs(SQL, 1, 1)
		If Rs.Bof Or Rs.Eof Then
			ReDim ProductArray(0, 0)
		Else
			ProductArray = Rs.GetRows()
		End If
		Application.Lock()
	  	Application(CookieName & "_Products") = ProductArray
	  	Application.UnLock()
	Else
		ProductArray = Application(CookieName & "_Products")
	End If
	
	Control_Product = ProductArray
	
End Function

'******************************************************
' 单页图文列表缓存
'******************************************************	
Function Control_PageInfo(ByVal Action)
	Dim Rs, SQL, PageInfoArray
	If Not IsArray(Application(CookieName & "_PageInfo")) Or Action = 2 Then
		SQL = "Select Page_ID,Page_Title,Page_StaticTag,Page_IsIndex,Page_Display,Page_Content,Page_ClassID From ebdiy_PageInfo Where Page_Display=True Order By Page_Order ASC"
		Set Rs = Conn.Rs(SQL, 1, 1)
		If Rs.Bof Or Rs.Eof Then
			ReDim PageInfoArray(0, 0)
		Else
			PageInfoArray = Rs.GetRows()
		End If
		Application.Lock()
	  	Application(CookieName & "_PageInfo") = PageInfoArray
	  	Application.UnLock()
	Else
		PageInfoArray = Application(CookieName & "_PageInfo")
	End If
	
	Control_PageInfo = PageInfoArray
	
End Function

'******************************************************
' 展示列表缓存
'******************************************************	
Function Control_ShowCase(ByVal Action)
	Dim Rs, SQL, ShowCaseArray
	If Not IsArray(Application(CookieName & "_ShowCase")) Or Action = 2 Then
		SQL = "Select Case_ID,Case_Title,Case_Img,Case_Link,Case_Info From ebdiy_ShowCase Order By Case_ID DESC"
		Set Rs = Conn.Rs(SQL, 1, 1)
		If Rs.Bof Or Rs.Eof Then
			ReDim ShowCaseArray(0, 0)
		Else
			ShowCaseArray = Rs.GetRows()
		End If
		Application.Lock()
	  	Application(CookieName & "_ShowCase") = ShowCaseArray
	  	Application.UnLock()
	Else
		ShowCaseArray = Application(CookieName & "_ShowCase")
	End If
	
	Control_ShowCase = ShowCaseArray
	
End Function
%>