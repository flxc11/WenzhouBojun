
<%
'*****************************************************
'过滤空格，首页调用的时候
'*****************************************************
Function FilterHTML(str)
    Dim re
    Set re=new RegExp
    re.IgnoreCase =True
    re.Global=True
    re.Pattern="<(.[^>]*)>"
    str=re.Replace(str,"")    
    set re=Nothing
    Dim l,t,c,i
    l=Len(str)
    t=0
    For i=1 to l
        c=Abs(Asc(Mid(str,i,1)))
        If c>255 Then
            t=t+2
        Else
            t=t+1
        End If
        cutStr=str
    Next
    cutStr=Replace(cutStr,chr(10),"")
    cutStr=Replace(cutStr,chr(13),"")
    cutStr=Replace(cutStr," ","")
    cutStr=Replace(cutStr,"　","")
    cutStr=Replace(cutStr,"&nbsp;","")
	cutStr=Replace(cutStr,"&mdash;","-")
    FilterHTML= cutStr
End Function
'*****************************************************
'转换特殊字符，用于动画文本
'*****************************************************
function FCKCheck(str)
   str=replace(str,"<p>","")
   str=replace(str,"</p>","")
   str=replace(str,"&ldquo;","“")
   str=replace(str,"&rdquo;","”")
   str=replace(str,"&mdash;","-")
   str=replace(str,"<br />","")
   str=replace(str,"<br>","")
   str=replace(str,"&bull;","•")   
   str=replace(str,"&hellip;","…")   
   str=replace(str,"&nbsp;"," ")
   str=replace(str,"&middot;","·")
   str=replace(str,"&times;","x")  
   FCKCheck=str
end function
'*****************************************************
'获取用户的真实IP地址
'*****************************************************
Function GetUserIP()
    Dim StrIPAddr
    If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
        StrIPAddr = Request.ServerVariables("REMOTE_ADDR")
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then
        StrIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1)
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then
        StrIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)
    Else
        StrIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
    End If
    GetUserIP = Trim(Mid(strIPAddr, 1, 30))
End Function
'*****************************************************
'过滤非法的SQL字符
'*****************************************************
Function ReplaceBadChar(strChar)
    If strChar = "" Or IsNull(strChar) Then
        ReplaceBadChar = ""
        Exit Function
    End If
    Dim strBadChar, arrBadChar, tempChar, i
    strBadChar = "+,',--,%,^,?,(,),<,>,[,],{,},/,\,;,:," & Chr(34) & "," & Chr(0) & ""
    arrBadChar = Split(strBadChar, ",")
    tempChar = strChar
    For i = 0 To UBound(arrBadChar)
        tempChar = Replace(tempChar, arrBadChar(i), "")
    Next
    tempChar = Replace(tempChar, "@@", "@")
    ReplaceBadChar = tempChar
End Function
'*****************************************************
'过滤所有HTML代码
'*****************************************************
Function RemoveHTML(ContentStr)
 Dim ClsTempLoseStr,regEx
 ClsTempLoseStr = Cstr(ContentStr)
 Set regEx = New RegExp
 regEx.Pattern = "<\/*[^<>]*>"
 regEx.IgnoreCase = True
 regEx.Global = True
 ClsTempLoseStr = regEx.Replace(ClsTempLoseStr,"")
 LoseHtml = ClsTempLoseStr
End function
'*****************************************************
'生成固定长度的随机值
'*****************************************************
Function Random(Length)
    Dim strSeed, seedLength, pos, Str, i
    strSeed = "abcdefghijklmnopqrstuvwxyz1234567890"
    seedLength = Len(strSeed)
    Str = ""
    Randomize
    For i = 1 To Length
        Str = Str + Mid(strSeed, Int(seedLength * Rnd) + 1, 1)
    Next
    Random = Str
End Function
'*****************************************************
'判断该账号是否具有操作权限
'*****************************************************
Function ISPopedomCheck(UserName,Popedom)
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From AdminGroup Where UserName='"&UserName&"' And Popedom='"&Popedom&"'"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		ISPopedomCheck=" checked"
	Else
		ISPopedomCheck=""
	End If
	Rs.Close
	Set Rs=Nothing
End Function
'*****************************************************
'判断登录账号是否系统账号
'*****************************************************
Function ISAdmin(UserName)
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From Admin Where UserName='"&UserName&"'"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
	     If Rs("ISAdmin")="999" Then
		 	ISAdmin=True
		 Else
		 	ISAdmin=False
		 End If
	Else
		ISAdmin=False
	End If
	Rs.Close
	Set Rs=Nothing
End Function
'*****************************************************
'判断该账号是否具有操作权限
'*****************************************************
Function ISPopedom(UserName,Popedom)
	If ISAdmin(UserName)=False Then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From AdminGroup Where UserName='"&UserName&"' And Popedom='"&Popedom&"'"
		Rs.Open Sql,Conn,1,1
		If Rs.Eof Or Rs.Bof Then
			Response.Write("<html xmlns=""http://www.w3.org/1999/xhtml"">")&chr(13)
			Response.Write("<head>")&chr(13)
			Response.Write("<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />")&chr(13)
			Response.Write("<title>"&SiteName&"</title>")&chr(13)
			Response.Write("<link href=""Style/Main.css"" rel=""stylesheet"" type=""text/css"" />")&chr(13)
			Response.Write("<body style=""padding:20px;background:url(Images/CNVP_Banner.jpg) bottom right no-repeat"">")&chr(13)
			Response.Write("<table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"">")&chr(13)
			Response.Write("<tr>")&chr(13)
			Response.Write("<td style=""font-size:14px;font-weight:bolder;color:#F00F00;height:35px;"">出错拉！可能您的账号并不具备对当前模块的管理权限！</td>")&chr(13)
			Response.Write("</tr>")&chr(13)
			Response.Write("<tr>")&chr(13)
			Response.Write("<td style=""color:#808080"">如果您有任何疑问欢迎致电捷点科技客服部进行咨询。<br/>客服热线：0577-86665050 86665522<br/>客服邮箱：Service@Cnvp.Com.Cn")&chr(13)
			Response.Write("</td>")&chr(13)
			Response.Write("</tr>")&chr(13)
			Response.Write("</body>")&chr(13)
			Response.Write("</html>")
			Response.End()
		End If
		Rs.Close
		Set Rs=Nothing
	End If
End Function
'*****************************************************
'获取文件夹容量
'*****************************************************
Function GetFolderSize(Path)
	Set FSO=Server.CreateObject("Scripting.FileSystemObject")
	If FSO.FolderExists(Server.MapPath(Path)) Then
		Set Folder = FSO.GetFolder(Server.MapPath(Path))
		GetFolderSize=Folder.size/1024/1024
	Else
	End If
	Set FSO=Nothing
	Set Folder=Nothing
End Function
'##################导航条函数开始########################
'*****************************************************
'根据当前ID值返回完整路径（例：首页 > 国内新闻 > 浙江新闻）
'*****************************************************
Function GetAllChild(Table,ID)
	Dim Rs
    Set Rs=Conn.ExeCute("Select Id From "&Table&" Where NavParent="&ID&" Order By NavOrder Asc")
    While Not Rs.Eof
	    If GetAllChild="" Then
		GetAllChild=","&GetAllChild&Rs("Id")
		Else
		GetAllChild=GetAllChild & "," & Rs("Id")
		End If
        GetAllChild=GetAllChild & GetAllChild(Table,Rs("Id"))
        Rs.MoveNext
    Wend
    Rs.Close
    Set Rs=Nothing
End Function
'##################获取所有子类别########################
'*****************************************************
'根据当前ID获取所有子类别
'*****************************************************
Function GetPageAllChild(Table,ID)
	Dim Rs
    Set Rs=Conn.ExeCute("Select Id From "&Table&" Where User_NavParent="&ID&" Order By User_NavOrder Asc")
    While Not Rs.Eof
	    If GetPageAllChild="" Then
		GetPageAllChild=","&GetPageAllChild&Rs("Id")
		Else
		GetPageAllChild=GetPageAllChild & "," & Rs("Id")
		End If
        GetPageAllChild=GetPageAllChild & GetPageAllChild(Table,Rs("Id"))
        Rs.MoveNext
    Wend
    Rs.Close
    Set Rs=Nothing
End Function
'*****************************************************
'根据当前ID值返回完整路径（例：首页 > 国内新闻 > 浙江新闻）
'*****************************************************
Function GetNavPath(Table,ID)
	Set Rs=Conn.Execute("Select ID,NavTitle,NavParent From "&Table&" Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > <a href=""?ID="&Rs("ID")&""">" & Rs("NavTitle") &"</a>"
		Str=GetNavPath(Table,Rs("NavParent")) & Str
	End if
	GetNavPath=Str
End Function
'*****************************************************
'根据当前ID值返回单页类别的完整路径（例：首页 > 国内新闻 > 浙江新闻）
'*****************************************************
Function GetPageNavPath(Table,ID)
	Set Rs=Conn.Execute("Select ID,User_NavTitle,User_NavParent From "&Table&" Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > <a href=""?ClassID="&Rs("ID")&""">" & Rs("User_NavTitle") &"</a>"
		Str=GetPageNavPath(Table,Rs("User_NavParent")) & Str
	End if
	GetPageNavPath=Str
End Function

'*****************************************************
'根据当前ID值返回完整路径（例：首页 > 国内新闻 > 浙江新闻）
'*****************************************************
Function GetNavPath2(Table,ID)
	Set Rs=Conn.Execute("Select ID,GuestbookTitle,NavParent From "&Table&" Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " >> <a href=""?ID="&Rs("ID")&""">" & Rs("NavTitle") &"</a>"
		Str=GetNavPath(Table,Rs("NavParent")) & Str
	End if
	GetNavPath2=Str
End Function


'***************无连接路经***********************
Function GetNavnews2(Table,ID)
	Set Rs=Conn.Execute("Select ID,NavTitle,NavParent From "&Table&" Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > " & Rs("NavTitle") &""
		Str=GetNavnews2(Table,Rs("NavParent")) & Str
	End if
	GetNavnews2=Str
End Function

Function GetNavnewsen2(Table,ID)
	Set Rs=Conn.Execute("Select ID,EnNavTitle,NavParent From "&Table&" Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > " & Rs("EnNavTitle") &""
		Str=GetNavnewsen2(Table,Rs("NavParent")) & Str
	End if
	GetNavnewsen2=Str
End Function

'***************无连接路经***********************

Function GetPageNavPath3(Table,ID)
	Set Rs=Conn.Execute("Select ID,User_NavTitle,User_NavParent From "&Table&" Where ID="&ID&"")
	If Not (Rs.Eof Or Rs.Bof) Then
		Str= " > " & Rs("User_NavTitle") 
		Str=GetPageNavPath3(Table,Rs("User_NavParent")) & Str
	End if
	GetPageNavPath3=Str
End Function
'********************************
'*****************************************************
'获取当前子类别的数量
'*****************************************************
Function GetSubNavCount(Table,NavParent)
	GetSubNavCount=Conn.Execute("Select Count(ID) From "&Table&" Where NavParent="&NavParent&"")(0)
End Function
'*****************************************************
'获取单页当前子类别的数量
'*****************************************************
Function GetPageSubNavCount(Table,NavParent)
	GetPageSubNavCount=Conn.Execute("Select Count(ID) From "&Table&" Where User_NavParent="&NavParent&"")(0)
End Function

'*****************************************************
'获取当前类别的名称
'*****************************************************

Function GetPageNavName(Table,classid)
	GetPageNavName=Conn.Execute("Select User_NavTitle From "&Table&" Where ID="&classid&" order by User_NavOrder desc")(0)
End Function


Function GetPageenNavName(Table,classid)
	GetPageenNavName=Conn.Execute("Select User_EnNavTtile From "&Table&" Where ID="&classid&"")(0)
End Function


Function GetproNavName(classid,title)
	Set Rsx=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From [dnt_attachments] where pid="&classid&""
Rsx.Open Sql,Connx,1,1
If Not (Rsx.Eof Or Rsx.Bof) Then
GetproNavName=Rsx(title)
End If
Rsx.Close
Set Rsx=Nothing
End Function

'*****************************************************
'获取当前NavParent
'*****************************************************

Function GetPageNavParent(Table,classid)
	GetPageNavParent=Conn.Execute("Select NavParent From "&Table&" Where id="&classid&"")(0)
End Function
'*****************************************************
'获取当前SQL论坛内值
'*****************************************************
Function GetPagesqlzhi(Table,classid,title)
	if classid="" then
	GetPagesqlzhi=""
	else
	GetPagesqlzhi=Connx.Execute("Select "&title&" From "&Table&" Where uid="&classid&"")(0)
	end if
End Function

'*****************************************************
'获取当前类别的名称
'*****************************************************


Function GetSubNavName(Table,ClassID)
	Set Rs_Nav=Conn.Execute("Select NavTitle From "&Table&" Where ID="&ClassID&"")
	If Not (Rs_Nav.Eof OR Rs_Nav.Bof) Then
		GetSubNavName=Rs_Nav("NavTitle")
	End If
	Rs_Nav.Close
	Set Rs_Nav=Nothing
End Function



Function GetSubNavName3(Table,ClassID)
	Set Rs_Nav=Conn.Execute("Select NavTitle From "&Table&" Where ClassID='"&ClassID&"'")
	If Not (Rs_Nav.Eof OR Rs_Nav.Bof) Then
		GetSubNavName3=Rs_Nav("NavTitle")
	End If
	Rs_Nav.Close
	Set Rs_Nav=Nothing
End Function
'*****************************************************
'获取当前类别的名称
'*****************************************************
Function GetSubNavName2(Table,ClassID)
	Set Rs_Nav=Conn.Execute("Select EnNavTitle From "&Table&" Where ID="&ClassID&"")
	If Not (Rs_Nav.Eof OR Rs_Nav.Bof) Then
		GetSubNavName2=Rs_Nav("EnNavTitle")
	End If
	Rs_Nav.Close
	Set Rs_Nav=Nothing
End Function

'返回导航条的列表模式
'*****************************************************
Function GetSelect(Table,NavParent)
	Dim Rs
	Set Rs=Conn.Execute("Select ID,NavTitle,EnNavTitle,NavParent,NavLevel From "&Table&" Where NavLock=0 And NavParent="&NavParent&" Order By NavOrder Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("ID")&">")
		Response.Write(Prefix(Rs("NavLevel")))
		Response.Write(Rs("NavTitle"))
		Response.Write("</option>")& vbCrLf
		Call GetSelect(Table,Rs("ID"))
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function
'返回导航条的列表模式
'*****************************************************
Function GetSelect32(Table,NavParent,tst)
	Dim Rs
	Set Rs=Conn.Execute("Select ID,NavTitle,NavParent,NavLevel From "&Table&" Where NavLock=0 And NavParent="&NavParent&" Order By NavOrder Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("ID") )
		if Cstr(tst)=Cstr(Rs("ID")) then
		response.Write(" selected")
		end if
		response.Write(">")
		Response.Write(Prefix(Rs("NavLevel")))
		Response.Write(Rs("NavTitle"))
		Response.Write("</option>")& vbCrLf
		Call GetSelect32(Table,Rs("ID"),tst)
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function

'返回单页导航条的列表模式
'*****************************************************
Function GetPageSelect(Table,NavParent)
	Dim Rs
	Set Rs=Conn.Execute("Select * From "&Table&" Where User_NavLock=0 And User_NavParent="&NavParent&" Order By User_NavOrder Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("ID")&">")
		Response.Write(Prefix(Rs("User_NavLevel")))
		Response.Write(Rs("User_NavTitle"))
		Response.Write("</option>")& vbCrLf
		Call GetPageSelect(Table,Rs("ID"))
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function

'返回单页导航条的列表模式
'*****************************************************
Function GetPageSelect2(Table,NavParent)
	Dim Rs
	Set Rs=Conn.Execute("Select * From "&Table&" Where User_NavLock=0 And User_NavParent="&NavParent&" Order By User_NavOrder Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("ID")&">")
		Response.Write(Prefix(Rs("User_NavLevel")))
		Response.Write(Rs("User_EnNavTtile"))
		Response.Write("</option>")& vbCrLf
		Call GetPageSelect(Table,Rs("ID"))
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function

'返回导航条的列表模式(类别)
'*****************************************************
Function GetSelect2(Table,NavParent)
	Dim Rs
	Set Rs=Conn.Execute("Select ID,EnNavTitle,NavParent,NavLevel From "&Table&" Where NavLock=0 And NavParent="&NavParent&" Order By NavOrder Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("ID")&">")
		Response.Write(Prefix(Rs("NavLevel")))
		Response.Write(Rs("EnNavTitle"))
		Response.Write("</option>")& vbCrLf
		Call GetSelect2(Table,Rs("ID"))
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function
'返回用户创建表
'*****************************************************
Function GetSelect3()
	set Rs = Conn.openSchema(20)
	Rs.movefirst
	Do Until Rs.EOF
	if Rs("TABLE_TYPE")="TABLE" and left(Trim(Rs("Table_Name")),5)="User_" then
		Response.Write("<option value="&Rs("Table_Name")&">")
		Response.Write(Rs("Table_Name"))
		Response.Write("</option>")& vbCrLf
	end if
	Rs.movenext
	Loop
End Function
'返回友情链接标题名称
'*****************************************************
Function GetSelect4(Table,sqlWhere,OrderBy,Title)
	Dim Rs
	Set Rs=Conn.Execute("Select * From "&Table&" "&sqlWhere&" Order By "&OrderBy&" Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("LinkAddress")&">")
		Response.Write(Rs(Title))
		Response.Write("</option>")& vbCrLf
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function

'返回列表模式
'*****************************************************
Function GetSelect5(Table,OrderBy,Title)
	Dim Rs
	Set Rs=Conn.Execute("Select * From "&Table&" Order By "&OrderBy&" Asc")
	If Not Rs.Eof Then
	Do While Not Rs.Eof
		Response.Write("<option value="&Rs("ID")&">")
		Response.Write(Rs(Title))
		Response.Write("</option>")& vbCrLf
	Rs.MoveNext
	If Rs.Eof Then Exit Do '防止造成死循环
	Loop
	End If
End Function

'*****************************************************
'输出自定义格式固定空格
'*****************************************************
Function Prefix(NavLevel)
	Dim i
	Dim Str
	Str=""
	for i=1 to NavLevel
	Str=Str&"|--"
	next
	Prefix=Str
End Function
'##################导航条函数结束#######################
'*****************************************************
' 创建一个FCK编辑器
'*****************************************************
Function Editor(ByVal InputName,ByVal InputValue)	
	sBasePath = LCase(Request.ServerVariables("PATH_INFO"))
	sBasePath = Left(sBasePath, InStrRev(sBasePath, "/admin" ))
	Set oFCKeditor = New FCKeditor
	oFCKeditor.BasePath = sBasePath&"Editor/"
	oFCKeditor.ToolbarSet="CNVPCMS"
	oFCKeditor.Config("SkinPath") = sBasePath&"Editor/editor/skins/silver/"
	oFCKeditor.Config("AutoDetectLanguage") = False
	oFCKeditor.Config("DefaultLanguage") = "zh-cn"
	oFCKeditor.Value = InputValue
	oFCKeditor.height="350"
	Editor=oFCKeditor.Create(InputName)
End Function
'*****************************************************
' 创建一个FCK编辑器
'*****************************************************
Function Editor2(ByVal InputName,ByVal InputValue)	
	sBasePath = LCase(Request.ServerVariables("PATH_INFO"))
	sBasePath = Left(sBasePath, InStrRev(sBasePath, "/admin" ))
	Set oFCKeditor = New FCKeditor
	oFCKeditor.BasePath = sBasePath&"Editor/"
	oFCKeditor.ToolbarSet="CNVPCMS"
	oFCKeditor.Config("SkinPath") = sBasePath&"Editor/editor/skins/silver/"
	oFCKeditor.Config("AutoDetectLanguage") = False
	oFCKeditor.Config("DefaultLanguage") = "zh-cn"
	oFCKeditor.Value = InputValue
	oFCKeditor.height="300"
	Editor2=oFCKeditor.Create(InputName)
End Function
'*****************************************************
' 根据序号获取商品名称
'*****************************************************
Function GetShopName(ID)
	Set Rs_Shop=Conn.Execute("Select ShopName From ShopInfo Where ID="&ID&"")
	If Not (Rs_Shop.Eof Or Rs_Shop.Bof) Then
		GetShopName=Rs_Shop("ShopName")
	Else
		GetShopName="商品名称不存在或已被删除"
	End If
	Rs_Shop.Close
	Set Rs_Shop=Nothing
End Function
'*****************************************************
' 根据序号获取新闻名称
'*****************************************************
Function GetNewsName(ID)
	Set Rs_News=Conn.Execute("Select NewsTitle From NewsInfo Where ID="&ID&"")
	If Not (Rs_News.Eof Or Rs_News.Bof) Then
		GetNewsName=Rs_News("NewsTitle")
	Else
		GetNewsName="信息不存在或已被删除"
	End If
	Rs_News.Close
	Set Rs_News=Nothing
End Function
'*****************************************************
' 格式化日期时间参数
'*****************************************************
Public Function FormatTime(s_Time, n_Flag)
	If IsDate(s_Time) = False Then Exit Function
	Dim y, m, d, h, mi, s, w
	' 增加客户端时区同步功能
	' 全站显示时间时必须调用此方法，否则无法正确显示时区
	TimeZone=8
	s_Time = DateAdd("h", TimeZone - 8, s_Time)
	FormatTime = ""
	y = CStr(Year(s_Time))
	m = CStr(Month(s_Time))
	If Len(m) = 1 Then m = "0" & m
	d = CStr(Day(s_Time))
	If Len(d) = 1 Then d = "0" & d
	h = CStr(Hour(s_Time))
	If Len(h) = 1 Then h = "0" & h
	mi = CStr(Minute(s_Time))
	If Len(mi) = 1 Then mi = "0" & mi
	s = CStr(Second(s_Time))
	If Len(s) = 1 Then s = "0" & s
	
	w = Weekday(s_Time)
	Select Case w
		Case 1 w = "星期日"
		Case 2 w = "星期一"
		Case 3 w = "星期二"
		Case 4 w = "星期三"
		Case 5 w = "星期四"
		Case 6 w = "星期五"
		Case 7 w = "星期六"
	End Select
	
	Select Case n_Flag
		Case 1 ' yyyy-mm-dd hh:mm:ss
			FormatTime = y & "-" & m & "-" & d & " " & h & ":" & mi & ":" & s
		Case 2 ' yyyy-mm-dd
			FormatTime = y & "-" & m & "-" & d
		Case 3 ' hh:mm:ss
			FormatTime = h & ":" & mi & ":" & s
		Case 4 ' yyyy年mm月dd日
			FormatTime = y & "年" & m & "月" & d & "日"
		Case 5 ' yyyymmddhhmmss
			FormatTime = y & m & d & h & mi & s
		Case 6 ' yyyy年mm月dd日 hh时mm分ss秒
			FormatTime = y & "年" & m & "月" & d & "日" & " " & h & "时" & mi & "分" & s & "秒"
		Case 7 ' mm-dd
			FormatTime = m & "-" & d
		Case 8 ' yyyy年mm月dd日 星期w
			FormatTime = y & "年" & m & "月" & d & "日" & " " & w
	End Select
End Function
'*****************************************************
' 获取地址栏参数
'*****************************************************
Function GetURL(FileID)
	Dim url_host,url_string
	url_string=""
	url_host=request.ServerVariables("script_name")
	If Request.QueryString<>"" Then
		Dim Get_Query
		For Each Get_Query In Request.QueryString
			if LCase(Get_Query)<>FileID And LCase(Get_Query)<>"submit" then
				if url_string="" then
					url_string=Get_Query&"="&Server.URLEncode(Request.QueryString(Get_Query))
				else
					url_string=url_string&"&"&Get_Query&"="&Server.URLEncode(Request.QueryString(Get_Query))
				end if
			end if
		Next
	End If
	If Request.Form<>"" Then
		Dim Post_Query
		For Each Post_Query In Request.Form
			if LCase(Post_Query)<>FileID And LCase(Get_Query)<>"submit" then
				if url_string="" then
					url_string=Post_Query&"="&Server.URLEncode(Request.Form(Post_Query))
				else
					url_string=url_string&"&"&Post_Query&"="&Server.URLEncode(Request.Form(Post_Query))
				end if
			end if
		Next
	End If
	if 	url_string="" then
		GetURL=url_host&"?"&FileID&"="
	else
		GetURL=url_host&"?"&url_string&"&"&FileID&"="
	end if
End Function

'**************************************************
'函数名：ConvertDate
'作  用：获取上传时间,格式（年-月-日）
'参  数：ID------当前ID
'返回值：2008-08-08
'**************************************************
Function ConvertDate(DateStr)
Dim Str
Str=""&Right(Year(DateStr),4)&"-"&Right("0"&Month(DateStr),2)&"-"&Right("0"&Day(DateStr),2)&""
ConvertDate=Str
End Function

'**************************************************
'函数名：GetPostTime
'作  用：获取上传时间,格式（年-月-日）
'参  数：ID------当前ID
'返回值：2008-08-08
'**************************************************
Function GetPostTime(ID,TableName)
Dim Rs,Str
Set Rs=Conn.Execute("Select PostTime From "&TableName&" Where ID="&ID)
Str=""&Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2)&""
Rs.Close
Set Rs=Nothing
GetPostTime=Str
End Function

'**************************************************
'函数名：GetPostTime1
'作  用：获取上传时间，格式（[年-月-日]）
'参  数：ID------当前ID
'返回值：2008-08-08
'**************************************************
Function GetPostTime1(ID,TableName)
Dim Rs,Str
Set Rs=Conn.Execute("Select PostTime From "&TableName&" Where ID="&ID)
Str="["&Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2)&"]"
Rs.Close
Set Rs=Nothing
GetPostTime1=Str
End Function

'**************************************************
'函数名：GetPostTime2
'作  用：获取上传时间，格式（年.月.日）
'参  数：ID------当前ID
'返回值：2008-08-08
'**************************************************
Function GetPostTime2(ID,TableName)
Dim Rs,Str
Set Rs=Conn.Execute("Select PostTime From "&TableName&" Where ID="&ID)
Str=""&Right(Year(Rs("PostTime")),4)&"."&Right("0"&Month(Rs("PostTime")),2)&"."&Right("0"&Day(Rs("PostTime")),2)&""
Rs.Close
Set Rs=Nothing
GetPostTime2=Str
End Function

'**************************************************
'函数名：GetNews1
'作  用：获取新闻,三列(图标、标题、时间)，td背景有鼠标经过变色
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1(Strsql,TableName,PageSize,url,length,CAndE,TWidth,TitleWidth)
Dim Rs,Str

Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1

Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr onMouseOver=this.bgColor='#F1F1F1' onMouseOut=this.bgColor=''>")
		Response.Write("<td width='30' height='26' align='center'>")
		Response.Write("<img src=images/point3.jpg>")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleWidth&"' align=left class='NewsTile'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr onMouseOver=this.bgColor='#EDEEF0' onMouseOut=this.bgColor=''>")
			Response.Write("<td width='20' height='26' align='center' class='NewsEast_208_b'>")
			Response.Write("<img src=images/point3.jpg>")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleWidth&"' align=left class='NewsTile'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("<td width=90 align=center class='NewsDate'>")
	Response.Write(GetPostTime1(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_1
'作  用：获取新闻,三列（图标、标题、时间）,td背景无鼠标经过变色
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1_1(Strsql,TableName,PageSize,url,length,CAndE,TWidth,IcoClumnWidth,TitleClumnWidth,DateClumnWidth)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='24' align='center' class='case_line'>")
		Response.Write("<img src=images/point.jpg>")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='case_line case_f'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&IcoClumnWidth&"' height='24' align='center' class='case_line'>")
			Response.Write("<img src=images/point.jpg>")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='case_line case_f'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("<td width='"&DateClumnWidth&"' align='center' class='case_line'>")
	Response.Write(GetPostTime2(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_1_1
'作  用：获取新闻,三列（图标、标题、时间）,td背景无鼠标经过变色
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1_1_1(Strsql,TableName,PageSize,url,length,CAndE,TWidth,IcoClumnWidth,TitleClumnWidth,DateClumnWidth)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select top 20 * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='36' align='center' class='case_line'>")
		Response.Write("<img src=images/point3.jpg>")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='case_line case_f'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&IcoClumnWidth&"' height='36' align='center' class='case_line'>")
			Response.Write("<img src=images/point3.jpg>")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='case_line case_f'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("<td width='"&DateClumnWidth&"' align='center' class='case_line'>")
	Response.Write(GetPostTime2(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_1_2
'作  用：获取新闻,三列（图标、标题、时间）,td背景无鼠标经过变色。当字数超过2500时，通过文本文档来显示。
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1_1_2(Strsql,TableName,PageSize,url,length,CAndE,TWidth,IcoClumnWidth,TitleClumnWidth,DateClumnWidth)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='36' align='center' class='case_line'>")
		Response.Write("<img src=images/point3.jpg>")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='case_line case_f'>")
		if len(Trim(Rs("UpLoadAddress")))>0 and (instr(Trim(Rs("UpLoadAddress")),".txt")>0 or instr(Trim(Rs("UpLoadAddress")),".doc")>0) then
			Response.Write("<a href='"&Rs("UpLoadAddress")&"' target='_blank' >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		else
			Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target='_blank' >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&IcoClumnWidth&"' height='36' align='center' class='case_line'>")
			Response.Write("<img src=images/point3.jpg>")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='case_line case_f'>")
			if len(Trim(Rs("UpLoadAddress")))>0 and (instr(Trim(Rs("UpLoadAddress")),".txt")>0 or instr(Trim(Rs("UpLoadAddress")),".doc")>0) then
				Response.Write("<a href='"&Rs("UpLoadAddress")&"' target='_blank' >")
				if len(Str)>length Then
				Response.Write(Left(Str,length)&"...")
				else
				Response.Write(Str)
				End if
			else
				Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target='_blank' >")
				if len(Str)>length Then
				Response.Write(Left(Str,length)&"...")
				else
				Response.Write(Str)
				End if
			end if
		end if
	end if
	Response.Write("</a>&nbsp;</td>")
	Response.Write("<td width='"&DateClumnWidth&"' align='center' class='case_line'>")
	Response.Write(GetPostTime2(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_2
'作  用：获取新闻,三列（图标、标题、时间）,td背景无鼠标经过变色
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1_2(Strsql,TableName,PageSize,url,length,CAndE,TWidth,IcoClumnWidth,TitleClumnWidth,DateClumnWidth,LeftPic)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='26' align='center' class='new_bb'>")
		Response.Write("<img src=images/"&LeftPic&">")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='new_bb'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&IcoClumnWidth&"' height='26' align='center' class='news_b'>")
			Response.Write("<img src=images/"&LeftPic&">")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='new_bb'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("<td width='"&DateClumnWidth&"' align='center' class='new_bb date_f'>")
	Response.Write(GetPostTime(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_3
'作  用：获取新闻,三列（图标、标题、时间）,td背景无鼠标经过变色
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1_3(Strsql,TableName,PageSize,url,length,CAndE,TWidth,IcoClumnWidth,TitleClumnWidth,DateClumnWidth,LeftPic)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='22' align='center' class='news'>")
		Response.Write("<img src=images/"&LeftPic&">")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='news'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&IcoClumnWidth&"' height='22' align='center' class='news'>")
			Response.Write("<img src=images/"&LeftPic&">")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='news'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("<td width='"&DateClumnWidth&"' align='center' class='date_f news'>")
	Response.Write(GetPostTime(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_4
'作  用：获取新闻,三列(图标、标题,图标带logo 、图标)
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews1_4(Strsql,TableName,PageSize,url,length,CAndE,TWidth,LogoPicWidth,TitleWidth,PicColumnWidth,RightPic)
Dim Rs,Str

Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By NewsOrder asc"
Rs.Open Sql,Conn,1,1

Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&LogoPicWidth&"' align='left' class='Announcement'>")
		Response.Write("<img src='"&Rs("NewsSPic")&"' height='11' width='16'/>&nbsp;")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleWidth&"' align='left' class='Announcement'>")
		'Response.Write("<a title="&Rs("NewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&LogoPicWidth&"' align='left' class='Announcement'>")
			Response.Write("<img src='"&Rs("NewsSPic")&"' height='11' width='16'/>&nbsp;")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleWidth&"' align='left' class='Announcement'>")
			'Response.Write("<a title="&Rs("EnNewsTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</td>")
	Response.Write("<td width='"&PicColumnWidth&"' height='23' align='center'>")
		Response.Write("<img src=images/"&RightPic&">")
		Response.Write("</td>")
	Response.Write("</tr>")
	
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews1_5
'作  用：获取新闻列表,三列(图标、标题、时间)
'参  数：url指显示某条详细信息的页面地址
'返回值：字符串
'**************************************************
Function GetNews1_5(SqlWhere,TableName,PageSize,url,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".float_left{ float:left; height:36px; border-bottom:1px dashed #B2B2B2; text-align:left; vertical-align:middle; line-height:36px;}")
Response.Write(".pagelist_l{ background:url(../../../../Admin/images/point3.jpg) no-repeat 0px 12px; width:3%;}")
Response.Write(".pagelist_m{ width:85%;}")
Response.Write(".pagelist_r{ width:10%; text-align:center;}")
Response.Write("</style>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from ["&TableName&"] "&SqlWhere
Rs.open Sql,Conn,1,1
i=0
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
Response.Write("<div><ul>")
Do While not Rs.eof and i<PageSize
Response.Write("<li class='float_left pagelist_l'>&nbsp;</li>")
if instr(Trim(url),".asp")>0 then
Response.Write("<li class='float_left pagelist_m'><a href='"&url&"?ID="&Rs("ID")&"&ClassID="&Rs("ClassID")&"' target='_blank'>")
if CAndE = 0 then
Response.Write(SubString(Trim(Rs("NewsTitle")),30))
else
	if CAndE = 1 then
		Response.Write(SubString(Trim(Rs("EnNewsTitle")),30))
	end if
end if
Response.Write("</a></li>")
else
Response.Write("<li class='float_left pagelist_m'>")
if CAndE = 0 then
Response.Write(SubString(Trim(Rs("NewsTitle")),30))
else
	if CAndE = 1 then
		Response.Write(SubString(Trim(Rs("EnNewsTitle")),30))
	end if
end if
Response.Write("</li>")
end if
Response.Write("<li class='float_left pagelist_r'>"&ConvertDate(Rs("PostTime"))&"</li>")
i=i+1
Rs.MoveNext
Loop
Response.Write("</ul></div>")
Rs.close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNew2
'作  用：获取新闻,两列（标题、时间）
'参  数：ID------当前ID
'返回值：字符串
'**************************************************
Function GetNews2(Strsql,TableName,PageSize,url,length)
Dim Rs,Str

Response.Write("<table width='500' border='0' cellspacing='0' cellpadding='0' class='m_t_10'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1

Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
If Not Rs.Eof Then
i=0
Do While Not Rs.Eof And i<Rs.PageSize							
Str=Rs("Title")
Response.Write("<tr>")
Response.Write("<td width=450 height='23' align=left class='right_impornew_f'>")
Response.Write("<a title="&Rs("Title")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
if len(Str)>length Then
Response.Write(Left(Str,length)&"...")
else
Response.Write(Str)
End if
Response.Write("</a></td>")
Response.Write("<td width='50' align='center'>")
Response.Write(Rs("PostTime"))
Response.Write("</td>")
Response.Write("</tr>")

i=i+1
Rs.MoveNext
If Rs.Eof Then Exit Do
Loop
End If
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews2_1
'作  用：获取新闻,两列(图标、标题)
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews2_1(Strsql,TableName,PageSize,url,length,CAndE,TWidth,PicColumnWidth,TitleWidth,LeftPic)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By NewsOrder asc,PostTime Desc"
Rs.Open Sql,Conn,1,1

Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&PicColumnWidth&"' height='25' align='center' class='news'>")
		Response.Write("<img src=images/"&LeftPic&">")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleWidth&"' align='left' class='news'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href='"&url&"?ID="&Rs("ID")&"&ClassID="&Rs("ClassID")&"' target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&PicColumnWidth&"' height='25' align='center' class='news'>")
			Response.Write("<img src=images/"&LeftPic&">")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleWidth&"' align='left' class='news'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href='"&url&"?ID="&Rs("ID")&"&ClassID="&Rs("ClassID")&"' target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("</tr>")
	
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews2_1_1
'作  用：获取新闻,两列(图标、标题)
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews2_1_1(Strsql,TableName,PageSize,url,length,CAndE,TWidth,PicColumnWidth,TitleWidth,LeftPic)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1

Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("NewsTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&PicColumnWidth&"' height='26' align='center' class='new_b'>")
		Response.Write("<img src=images/"&LeftPic&">")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleWidth&"' align='left' class='new_b'>")
		Response.Write("<a title="&Rs("NewsTitle")&" href='"&url&"?ID="&Rs("ID")&"&ClassID="&Rs("ClassID")&"' target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnNewsTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&PicColumnWidth&"' height='26' align='center' class='new_b'>")
			Response.Write("<img src=images/"&LeftPic&">")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleWidth&"' align='left' class='new_b'>")
			Response.Write("<a title="&Rs("EnNewsTitle")&" href='"&url&"?ID="&Rs("ID")&"&ClassID="&Rs("ClassID")&"' target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("</tr>")
	
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNews2_2
'作  用：获取新闻,两列(图标、标题,图标带logo)
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNews2_2(Strsql,TableName,PageSize,url,length,CAndE,TWidth,PicColumnWidth,TitleWidth)
Dim Rs,Str

Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str=Rs("Title")
		Response.Write("<tr>")
		Response.Write("<td width='"&PicColumnWidth&"' height='23' align='center'>")
		Response.Write("<img src=images/New_point.jpg>")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleWidth&"' align='left' class='Announcement'>")
		Response.Write("<img src='"&Rs("pic")&"' height='14' width<='70'/>&nbsp;")
		Response.Write("<a title="&Rs("Title")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnTitle")
			Response.Write("<tr>")
			Response.Write("<td width='"&PicColumnWidth&"' height='23' align='center'>")
			Response.Write("<img src=images/New_point.jpg>")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleWidth&"' align='left' class='Announcement'>")
			Response.Write("<a title="&Rs("EnTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("</tr>")
	
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetSafeInt
'作  用：获得正确数字参数
'参  数：mun------数字
'返回值：字符串
'**************************************************
Function GetSafeInt(mun)
    if not IsNumeric(trim(mun)) then
		mun=1
	else
		mun=clng(trim(mun))
	end if
	if mun<1 then mun=1
	GetSafeInt=mun
	
End Function

'**************************************************
'函数名：GetPage0
'作  用：获取分页,无类别ID返回
'参  数：ID------当前ID,CAndE 0表示中文，1表示英文
'返回值：字符串
'**************************************************
Function GetPage0(Strsql,TableName,PageSize,CAndE)
Dim Rs,Str
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By ID Desc"
Rs.Open Sql,Conn,1,1
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
if CAndE=1 then
	Response.Write("<table width='100%' border='0' align='left' cellpadding='0' cellspacing='0'")
	Response.Write(">")
	Response.Write("<tr>")
	Response.Write("<td align='center'>")
	If Total=0 then
	Response.Write("No Page!")
	Else
	Response.Write("Total&nbsp;") 
	Response.Write(Total) 
	Response.Write("&nbsp;News")
	Response.Write("&nbsp;&nbsp;")
	Response.Write("Article")
	Response.Write(Page)
	Response.Write("/")
	Response.Write(Rs.PageCount)
	Response.Write("Page")
	Response.Write("&nbsp;&nbsp;")
	Response.Write(PageSize)
	Response.Write("Article/page")
	Response.Write("&nbsp;&nbsp;")
	if Page=1 then
	Response.Write("[Home]&nbsp;[Previous]")
	Else
	Response.Write("[<a href=?Page=1>Home</a>]&nbsp;[<a href=?Page=")
	Response.Write(Page-1)
	Response.Write(">Previous</a>]")
	End If
	If Rs.PageCount-Page<1 Then
	Response.Write("[Next]&nbsp;[Last]")
	Else
	Response.Write("[<a href=?Page=")
	Response.Write(Page+1)
	Response.Write(">Next</a>]&nbsp;[<a href=?Page=")
	Response.Write(Rs.PageCount)
	Response.Write(">Last</a>]")
	End If
	Response.Write("<select style=""FONT-SIZE: 9pt; FONT-FAMILY: 宋体"" onChange=""location=this.options[this.selectedIndex].value"" size=""1"" name=""Menu_1"">")
	For Pagei=1 To Rs.PageCount
	if Cint(Pagei)=Cint(Page) Then
	Response.Write("<option value=?Page=")
	Response.Write(Pagei)
	Response.Write(" selected=selected>")
	Response.Write(Pagei)
	Response.Write("</option>")
	Else
	Response.Write("<option value=?Page=")
	Response.Write(Pagei)
	Response.Write(">")
	Response.Write(Pagei)
	Response.Write("</option>")
	End If
	Next
	Response.Write("</select>")
	End If
	Response.Write("</td></tr></table>")
else
	if CAndE =0 then
		Response.Write("<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'")
		Response.Write(">")
		Response.Write("<tr>")
		Response.Write("<td align='center'>")
		If Total=0 then
		Response.Write("暂无分页")
		Else
		Response.Write("共") 
		Response.Write(Total) 
		Response.Write("条记录")
		Response.Write("&nbsp;&nbsp;")
		Response.Write("第")
		Response.Write(Page)
		Response.Write("/")
		Response.Write(Rs.PageCount)
		Response.Write("页")
		Response.Write("&nbsp;&nbsp;")
		Response.Write(PageSize)
		Response.Write("条/页")
		'Response.Write("&nbsp;&nbsp;")
		if Page=1 then
		Response.Write("【首页】【上一页】")
		Else
		Response.Write("【<a href=?Page=1>首页</a>】【<a href=?Page=")
		Response.Write(Page-1)
		Response.Write(">上一页</a>】")
		End If
		If Rs.PageCount-Page<1 Then
		Response.Write("【下一页】【末页】")
		Else
		Response.Write("【<a href=?Page=")
		Response.Write(Page+1)
		Response.Write(">下一页</a>】【<a href=?Page=")
		Response.Write(Rs.PageCount)
		Response.Write(">末页</a>】")
		End If
		Response.Write("<select style=""FONT-SIZE: 9pt; FONT-FAMILY: 宋体"" onChange=""location=this.options[this.selectedIndex].value"" size=""1"" name=""Menu_1"">")
		For Pagei=1 To Rs.PageCount
		if Cint(Pagei)=Cint(Page) Then
		Response.Write("<option value=?Page=")
		Response.Write(Pagei)
		Response.Write(" selected=selected>")
		Response.Write(Pagei)
		Response.Write("</option>")
		Else
		Response.Write("<option value=?Page=")
		Response.Write(Pagei)
		Response.Write(">")
		Response.Write(Pagei)
		Response.Write("</option>")
		End If
		Next
		Response.Write("</select>")
		End If
		Response.Write("</td></tr></table>")
	end if
end if
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetPage1
'作  用：获取分页,有返回类别ID
'参  数：ID------当前ID,CAndE 0表示中文，1表示英文
'返回值：字符串
'**************************************************
Function GetPage1(Strsql,TableName,PageSize,CAndE)
Dim Rs,Str

Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By ID Desc"
Rs.Open Sql,Conn,1,1
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
if CAndE=1 then
	Response.Write("<table width='100%' border='0' align='left' cellpadding='0' cellspacing='0'")
	Response.Write(">")
	Response.Write("<tr>")
	Response.Write("<td align='center'>")
	If Total=0 then
	Response.Write("No Page!")
	Else
	Response.Write("Total&nbsp;") 
	Response.Write(Total) 
	Response.Write("&nbsp;News")
	Response.Write("&nbsp;&nbsp;")
	Response.Write("Article")
	Response.Write(Page)
	Response.Write("/")
	Response.Write(Rs.PageCount)
	Response.Write("Page")
	Response.Write("&nbsp;&nbsp;")
	Response.Write(PageSize)
	Response.Write("Article/page")
	Response.Write("&nbsp;&nbsp;")
	if Page=1 then
	Response.Write("[Home]&nbsp;[Previous]")
	Else
	Response.Write("[<a href=?Page=1&ClassID="&Request("ClassID")&">Home</a>]&nbsp;[<a href=?Page=")
	Response.Write(Page-1)
	Response.Write("&ClassID="&Request("ClassID")&">Previous</a>]")
	End If
	If Rs.PageCount-Page<1 Then
	Response.Write("[Next]&nbsp;[Last]")
	Else
	Response.Write("[<a href=?Page=")
	Response.Write(Page+1)
	Response.Write("&ClassID="&Request("ClassID")&">Next</a>]&nbsp;[<a href=?Page=")
	Response.Write(Rs.PageCount)
	Response.Write("&ClassID"&Request("ClassID")&">Last</a>]")
	End If
	Response.Write("<select style=""FONT-SIZE: 9pt; FONT-FAMILY: 宋体"" onChange=""location=this.options[this.selectedIndex].value"" size=""1"" name=""Menu_1"">")
	For Pagei=1 To Rs.PageCount
	if Cint(Pagei)=Cint(Page) Then
	Response.Write("<option value=?Page=")
	Response.Write(Pagei)
	Response.Write("&ClassID="&Request("ClassID")&" selected=selected>")
	Response.Write(Pagei)
	Response.Write("</option>")
	Else
	Response.Write("<option value=?Page=")
	Response.Write(Pagei)
	Response.Write("&ClassID="&Request("ClassID")&">")
	Response.Write(Pagei)
	Response.Write("</option>")
	End If
	Next
	Response.Write("</select>")
	End If
	Response.Write("</td></tr></table>")
else
	if CAndE =0 then
		Response.Write("<table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'")
		Response.Write(">")
		Response.Write("<tr>")
		Response.Write("<td align='center'>")
		If Total=0 then
		Response.Write("暂无分页")
		Else
		Response.Write("共") 
		Response.Write(Total) 
		Response.Write("条记录")
		Response.Write("&nbsp;&nbsp;")
		Response.Write("第")
		Response.Write(Page)
		Response.Write("/")
		Response.Write(Rs.PageCount)
		Response.Write("页")
		Response.Write("&nbsp;&nbsp;")
		Response.Write(PageSize)
		Response.Write("条/页")
		'Response.Write("&nbsp;&nbsp;")
		if Page=1 then
		Response.Write("【首页】【上一页】")
		Else
		Response.Write("【<a href=?Page=1&ClassID="&Request("ClassID")&">首页</a>】【<a href=?Page=")
		Response.Write(Page-1)
		Response.Write("&ClassID="&Request("ClassID")&">上一页</a>】")
		End If
		If Rs.PageCount-Page<1 Then
		Response.Write("【下一页】【末页】")
		Else
		Response.Write("【<a href=?Page=")
		Response.Write(Page+1)
		Response.Write("&ClassID="&Request("ClassID")&">下一页</a>】【<a href=?Page=")
		Response.Write(Rs.PageCount)
		Response.Write("&ClassID="&Request("ClassID")&">末页</a>】")
		End If
		Response.Write("<select style=""FONT-SIZE: 9pt; FONT-FAMILY: 宋体"" onChange=""location=this.options[this.selectedIndex].value"" size=""1"" name=""Menu_1"">")
		For Pagei=1 To Rs.PageCount
		if Cint(Pagei)=Cint(Page) Then
		Response.Write("<option value=?Page=")
		Response.Write(Pagei)
		Response.Write("&ClassID="&Request("ClassID")&" selected=selected>")
		Response.Write(Pagei)
		Response.Write("</option>")
		Else
		Response.Write("<option value=?Page=")
		Response.Write(Pagei)
		Response.Write("&ClassID="&Request("ClassID")&">")
		Response.Write(Pagei)
		Response.Write("</option>")
		End If
		Next
		Response.Write("</select>")
		End If
		Response.Write("</td></tr></table>")
	end if
end if
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetNewContent1
'作  用：获取新闻内容
'参  数：CAndE---------0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetNewContent1(CAndE,From,TWidth,TableName)
if CAndE = 0 then
	Response.Write("<table width='"&TWidth&"' border='0' align='center' cellpadding='0' cellspacing='0' style='margin-bottom:20px;'>")
	ID=Request("ID")
	If ID="" Or IsNumeric(ID)=false Then
		twScript("参数错误!")
	Else
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From "&TableName&" Where ID="&ID&""
		Rs.Open Sql,Conn,1,3
		If Not (Rs.Eof Or Rs.Bof) Then
			Rs("NewsClick")=Rs("NewsClick")+1
			Rs.update
			Response.Write("<tr>")
			Response.Write("<td height='30' align='center' style='font-size:16px; font-weight:bold;'>")
			if not Rs.eof then
				Response.Write(Rs("NewsTitle"))
			end if
			Response.Write("</td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td height='40' align='center'><font color='#706F6E'>发布日期：")
			Response.Write(GetPostTime1(ID,""&TableName&""))
			Response.Write("&nbsp;共阅：["&Rs("NewsClick")&"]&nbsp;次&nbsp;&nbsp;来源：")
			Response.Write(From)
			Response.Write("</font></td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td height='30' align='left' style='padding-bottom:10px; padding-left:10px;'>")
			if not Rs.eof then
				Response.Write(Rs("NewsContent"))
			else
				Response.write("暂无内容!")
			end if
		Response.Write("</td>")
		Response.Write("</tr>")
		Else
			Response.Write("<script>alert('参数错误!');history.go(-1);</script>")
			Response.End()
		End If
	Rs.Close
	Set Rs=Nothing
	End If
	Response.Write("</table>")
else
	if CAndE = 1 then
		Response.Write("<table width='"&TWidth&"' border='0' align='center' cellpadding='0' cellspacing='0' style='margin-bottom:20px;'>")
		ID=Request("ID")
		If ID="" Or IsNumeric(ID)=false Then
			Response.Write("<script>alert('Parameter error!');history.go(-1);</script>")
			Response.End()
		Else
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select * From "&TableName&" Where ID="&ID&""
			Rs.Open Sql,Conn,1,3
			If Not (Rs.Eof Or Rs.Bof) Then
				Rs("NewsClick")=Rs("NewsClick")+1
				Rs.update
				Response.Write("<tr>")
				Response.Write("<td height='30' align='center' style='font-size:16px; font-weight:bold;'>")
				if not Rs.eof then
					Response.Write(Rs("EnNewsTitle"))
				end if
				Response.Write("</td>")
				Response.Write("</tr>")
				Response.Write("<tr>")
				Response.Write("<td height='40' align='center'><font color='#706F6E'>Date&nbsp;:&nbsp;")
				Response.Write(GetPostTime1(ID,""&TableName&""))
				Response.Write("Total read&nbsp;:&nbsp;["&Rs("NewsClick")&"]Times Source&nbsp;:&nbsp;")
				Response.Write(From)
				Response.Write("</font></td>")
				Response.Write("</tr>")
				Response.Write("<tr>")
				Response.Write("<td height='30' align='left' style='padding-bottom:10px; padding-left:10px;'>")
				if not Rs.eof then
					Response.Write(Rs("EnNewsContent"))
				else
					Response.write("No contents")
				end if
			Response.Write("</td>")
			Response.Write("</tr>")
			Else
				Response.Write("<script>alert('Parameter error!');history.go(-1);</script>")
				Response.End()
			End If
		Rs.Close
		Set Rs=Nothing
		End If
		Response.Write("</table>")
	end if
end if
End Function

'**************************************************
'函数名：GetPageContent
'作  用：获取新闻形式的单页内容
'参  数：CAndE---------0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetPageContent(CAndE,From,TWidth,TableName)
if CAndE = 0 then
	Response.Write("<table width='"&TWidth&"' border='0' align='center' cellpadding='0' cellspacing='0' style='margin-bottom:20px;'>")
	ID=Request("ID")
	If ID="" Or IsNumeric(ID)=false Then
		twScript("参数错误!")
	Else
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From "&TableName&" Where ID="&ID&""
		Rs.Open Sql,Conn,1,3
		If Not (Rs.Eof Or Rs.Bof) Then
			Rs("NavClick")=Rs("NavClick")+1
			Rs.update
			Response.Write("<tr>")
			Response.Write("<td height='30' align='center' style='font-size:16px; font-weight:bold;'>")
			if not Rs.eof then
				Response.Write(Rs("NavTitle"))
			end if
			Response.Write("</td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td height='40' align='center'><font color='#706F6E'>发布日期：")
			Response.Write(GetPostTime1(ID,""&TableName&""))
			Response.Write("&nbsp;共阅：["&Rs("NavClick")&"]&nbsp;次&nbsp;&nbsp;来源：")
			Response.Write(From)
			Response.Write("</font></td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td height='30' align='left' style='padding-bottom:10px; padding-left:10px;'>")
			if not Rs.eof then
				Response.Write(Rs("NavContent"))
			else
				Response.write("暂无内容!")
			end if
		Response.Write("</td>")
		Response.Write("</tr>")
		Else
			Response.Write("<script>alert('参数错误!');history.go(-1);</script>")
			Response.End()
		End If
	Rs.Close
	Set Rs=Nothing
	End If
	Response.Write("</table>")
else
	if CAndE = 1 then
		Response.Write("<table width='"&TWidth&"' border='0' align='center' cellpadding='0' cellspacing='0' style='margin-bottom:20px;'>")
		ID=Request("ID")
		If ID="" Or IsNumeric(ID)=false Then
			twScript("Parameter error!")
		Else
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select * From "&TableName&" Where ID="&ID&""
			Rs.Open Sql,Conn,1,3
			If Not (Rs.Eof Or Rs.Bof) Then
				Rs("NavClick")=Rs("NavClick")+1
				Rs.update
				Response.Write("<tr>")
				Response.Write("<td height='30' align='center' style='font-size:16px; font-weight:bold;'>")
				if not Rs.eof then
					Response.Write(Rs("EnNavTitle"))
				end if
				Response.Write("</td>")
				Response.Write("</tr>")
				Response.Write("<tr>")
				Response.Write("<td height='40' align='center'><font color='#706F6E'>Date&nbsp;:&nbsp;")
				Response.Write(GetPostTime1(ID,""&TableName&""))
				Response.Write("Total read&nbsp;:&nbsp;["&Rs("NavClick")&"]Times Source&nbsp;:&nbsp;")
				Response.Write(From)
				Response.Write("</font></td>")
				Response.Write("</tr>")
				Response.Write("<tr>")
				Response.Write("<td height='30' align='left' style='padding-bottom:10px; padding-left:10px;'>")
				if not Rs.eof then
					Response.Write(Rs("EnNavContent"))
				else
					Response.write("No contents")
				end if
			Response.Write("</td>")
			Response.Write("</tr>")
			Else
				Response.Write("<script>alert('Parameter error!');history.go(-1);</script>")
				Response.End()
			End If
		Rs.Close
		Set Rs=Nothing
		End If
		Response.Write("</table>")
	end if
end if
End Function

'**************************************************
'函数名：GetPageContent1
'作  用：获取简介形式的单页内容
'参  数：FieldName------字段名
'返回值：字符串
'**************************************************
Function GetPageContent1(TableName,ClassID,FieldName)
Set Rs=Server.CreateObject("Adodb.RecordSet")
				Sql="Select * From ["&TableName&"] Where ClassID='"&ClassID&"' Order By NavOrder Asc"
				Rs.Open Sql,Conn,1,1
				if not Rs.eof then
					if Trim(Rs("UpLoadAddress"))<>"" then
						Response.Write(FSOFileRead(Rs("UpLoadAddress")))
					else
						Response.Write(Rs(FieldName))
					end if
				end if
				Rs.close
				Set Rs=Nothing
End Function
'**************************************************
'函数名：GetPageContent1
'作  用：获取简介形式的单页内容
'参  数：FieldName------字段名
'返回值：字符串
'**************************************************
Function GetPageContent2(TableName,ID,FieldName)
Set Rs=Server.CreateObject("Adodb.RecordSet")
				Sql="Select * From ["&TableName&"] Where ID="&ID&" Order By NavOrder Asc"
				Rs.Open Sql,Conn,1,1
				if not Rs.eof then
					Response.Write(Rs(FieldName))
				end if
				Rs.close
				Set Rs=Nothing
End Function

'**************************************************
'函数名：AllChildClass
'作  用：获取当前类别ID下面全部ID值
'参  数：Root------当前的类别ID值
'		 TableName-----所要操作的数据库表
'返回值：1,2,3,4格式
'**************************************************
Function AllChildClass(Root,TableName)
    Dim Rs
    Set Rs=Conn.ExeCute("Select Id From "&TableName&" Where NavParent="&Root)
    While Not Rs.Eof
	    If AllChildClass="" Then
		AllChildClass=","&AllChildClass&Rs("Id")
		Else
		AllChildClass=AllChildClass & "," & Rs("Id")
		End If
        AllChildClass=AllChildClass & AllChildClass(Rs("Id"),TableName)
        Rs.MoveNext
    Wend
    Rs.Close
    Set Rs=Nothing
End Function

'**************************************************
'函数名：GetFAQ
'作  用：获取FAQ
'参  数：ID------当前ID
'返回值：字符串
'**************************************************
Function GetFAQ(Strsql,TableName,url,length)
Dim Rs,Str
Response.Write("<table width='515' border='0' cellspacing='0' cellpadding='0' class='m_t_10'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select top 10 * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
i=0
Page=Request("Page")                                                                    
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
If Not Rs.Eof Then
Do While Not Rs.Eof						
Str=Rs("NavTitle")
Response.Write("<tr>")
Response.Write("<td width='15' height='20' align='center' Class='index_pgra_left'>")
Response.Write((i+1)&".")
Response.Write("</td>")
Response.Write("<td width=500 align=left class='right_impornew_f'>")
Response.Write("<a title="&Rs("NavTitle")&" href="&url&"#FAQ"&i+1&" target=_parent >")
if len(Str)>length Then
Response.Write(Left(Str,length)&"...")
else
Response.Write(Str)
End if
Response.Write("</a></td>")
Response.Write("</tr>")

i=i+1
Rs.MoveNext
If Rs.Eof Then Exit Do
Loop
End If
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'函数名：QQonline
'作  用：QQ在线状态检测
'参  数：qq ------qq号码
'Dim QQ:QQ=qq号码
'Dim flag:flag="online[0]=0;" 'QQ在线显示标志
'if  QQonline(QQ)=flag then
'response.write "<Script>window.alert('QQ在线！')<!--/Script-->"
'end If
'==================================================
  Function QQonline(qq)
  Server.ScriptTimeout = 99999
  HttpUrl="http://webpresence.qq.com/getonline?Type=1&" & qq &":" 
  QQonline=GetHttpPage(HttpUrl)
  End Function


'函数名：GetHttpPage
'作  用：获取网页源码
'参  数：HttpUrl ------网页地址
'==================================================
Function GetHttpPage(HttpUrl)
   If IsNull(HttpUrl)=True Or Len(HttpUrl)<18 Or HttpUrl="$False$" Then
      GetHttpPage="$False$"
      Exit Function
   End If
   Dim Http
   Set Http=server.createobject("MSXML2.XMLHTTP")
   Http.open "GET",HttpUrl,False
   Http.Send()
   If Http.Readystate<>4 then
      Set Http=Nothing 
      GetHttpPage="$False$"
      Exit function
   End if
   GetHTTPPage=bytesToBSTR(Http.responseBody,"GB2312")
   Set Http=Nothing
   If Err.number<>0 then
      Err.Clear
   End If
End Function

'==================================================
'函数名：BytesToBstr
'作  用：将获取的源码转换为中文
'参  数：Body ------要转换的变量
'参  数：Cset ------要转换的类型
'==================================================
Function BytesToBstr(Body,Cset)
   Dim Objstream
   Set Objstream = Server.CreateObject("adodb.stream")
   objstream.Type = 1
   objstream.Mode =3
   objstream.Open
   objstream.Write body
   objstream.Position = 0
   objstream.Type = 2
   objstream.Charset = Cset
   BytesToBstr = objstream.ReadText 
   objstream.Close
   set objstream = nothing
End Function

'**************************************************
'函数名：Jobs_List1
'作  用：获取招聘信息列表
'参  数：CAndE,0表示中文，1表示英文
'返回值：字符串
'**************************************************
Function Jobs_List1(StrWhere,TableName,PageSize,url,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".Job_top_bg{ background:url(../Admin/Images/Job_top_bg.jpg) repeat-x left bottom;}")
Response.Write(".b_b{ border:1px solid #D3D3D3;}")
Response.Write(".top_b{ border-top:1px solid #D3D3D3;}")		
Response.Write(".left_b{ border-left:1px solid #D3D3D3;}")	
Response.Write(".bottom_b{ border-bottom:1px solid #D3D3D3;}")		
Response.Write(".right_b{ border-right:1px solid #D3D3D3;}")	
Response.Write(".Job_top_f{ font-family:'宋体'; font-size:12px; font-weight:bold;}")
Response.Write(".input1 { background:url(../Admin/Images/btn_xh_1.jpg) no-repeat center; width:88px; height:22px; border:0px;}")
Response.Write(".input2 { background:url(../Admin/Images/btn_xh_2.gif) no-repeat center;width:88px; height:22px; cursor:pointer; border:0px;}")
Response.Write("</style>")	
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from ["&TableName&"] "&StrWhere&" order by ID desc"
Rs.open Sql,Conn,1,1
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
j=0
if CAndE = 0 then
	Response.Write("<table width='660' border='0' cellspacing='0' cellpadding='0'>")  
	Response.Write("<tr>")
	Response.Write("<td align='center' valign='middle' height='37' width='46' class='Job_top_bg b_b Job_top_f'>序号</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='170' class='Job_top_bg top_b bottom_b Job_top_f'>职位名称</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='234' class='Job_top_bg b_b Job_top_f'>招聘部门</td>") 
	Response.Write("<td align='center' valign='middle' height='37' width='100' class='Job_top_bg bottom_b top_b Job_top_f'>发布日期</td>")
	Response.Write(" <td align='center' valign='middle' height='37' width='110' class='Job_top_bg b_b Job_top_f'>详细要求</td>")           
	Response.Write("</tr>")
	Response.Write("<tr>")
	Response.Write("<td colspan='5' height='36'>")           
	Response.Write("<table width='660' height='36' border='0' cellspacing='0' cellpadding='0'>")
	if not (Rs.eof or Rs.bof) and Rs.Recordcount>0 then
	Do While not Rs.eof and i<Rs.PageSize
	i=i+1
	if i mod 2 = 0 then
	Response.Write("<tr bgcolor='#F7F7F7'>")
	Response.Write("<td align='center' valign='middle' height='37' width='46' class='left_b bottom_b'>"&i&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='170' class='left_b bottom_b'>")
	Response.Write(Rs("Jobs"))
	Response.Write("&nbsp;</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='234' class='left_b bottom_b'>")
	Response.Write(Rs("RDepart")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='100' class='left_b bottom_b'>"&ConvertDate(Rs("PostTime"))&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='110' class='left_b bottom_b right_b'>")
	Response.Write("<input name=button type=button class=input1 id=button onmouseover=""this.className='input2'"" onmouseout=""this.className='input1'"" value='' onClick=""window.location.href='"&url&"?ID="&Rs("ID")&"'"" />")
	Response.Write("</td>")
	Response.Write("</tr>")
	else
	Response.Write("<tr>")
	Response.Write("<td align='center' valign='middle' height='37' width='46' class='left_b bottom_b'>"&i&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='170' class='left_b bottom_b'>")
	Response.Write(Rs("Jobs")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='234' class='left_b bottom_b'>")
	Response.Write(Rs("RDepart")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='100' class='left_b bottom_b'>"&ConvertDate(Rs("PostTime"))&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='110' class='left_b bottom_b right_b'>")
	Response.Write("<input name=button type=button class=input1 id=button onmouseover=""this.className='input2'"" onmouseout=""this.className='input1'"" value='' onClick=""window.location.href='"&url&"?ID="&Rs("ID")&"'"" />")
	Response.Write("</td>")
	Response.Write("</tr>")
	end if
	j=j+1
	Rs.MoveNext
	if i>PageSize then
	i=0
	end if
	Loop
	else
	Response.Write("<tr>")
	Response.Write("<td></td>")
	Response.Write("</tr>")
	end if
	Rs.close
	Set Rs=Nothing
else
	Response.Write("<table width='660' border='0' cellspacing='0' cellpadding='0'>")  
	Response.Write("<tr>")
	Response.Write("<td align='center' valign='middle' height='37' width='46' class='Job_top_bg b_b Job_top_f'>Number</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='170' class='Job_top_bg top_b bottom_b Job_top_f'>Job Title</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='234' class='Job_top_bg b_b Job_top_f'>Department</td>") 
	Response.Write("<td align='center' valign='middle' height='37' width='100' class='Job_top_bg bottom_b top_b Job_top_f'>Date</td>")
	Response.Write(" <td align='center' valign='middle' height='37' width='110' class='Job_top_bg b_b Job_top_f'>Detailed</td>")           
	Response.Write("</tr>")
	Response.Write("<tr>")
	Response.Write("<td colspan='5' height='36'>")           
	Response.Write("<table width='660' height='36' border='0' cellspacing='0' cellpadding='0'>")
	if not (Rs.eof or Rs.bof) and Rs.Recordcount>0 then
	Do While not Rs.eof and i<Rs.PageSize
	i=i+1
	if i mod 2 = 0 then
	Response.Write("<tr bgcolor='#F7F7F7'>")
	Response.Write("<td align='center' valign='middle' height='37' width='46' class='left_b bottom_b'>"&i&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='170' class='left_b bottom_b'>")
	Response.Write(Rs("EnJobs")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='234' class='left_b bottom_b'>")
	Response.Write(Rs("EnRDepart")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='100' class='left_b bottom_b'>"&ConvertDate(Rs("PostTime"))&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='110' class='left_b bottom_b right_b'>")
	Response.Write("<input name=button type=button class=input1 id=button onmouseover=""this.className='input2'"" onmouseout=""this.className='input1'"" value='' onClick=""window.location.href='"&url&"?ID="&Rs("ID")&"'"" />")
	Response.Write("</td>")
	Response.Write("</tr>")
	else
	Response.Write("<tr>")
	Response.Write("<td align='center' valign='middle' height='37' width='46' class='left_b bottom_b'>"&i&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='170' class='left_b bottom_b'>")
	Response.Write(Rs("EnJobs")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='234' class='left_b bottom_b'>")
	Response.Write(Rs("EnRDepart")&"&nbsp;")
	Response.Write("</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='100' class='left_b bottom_b'>"&ConvertDate(Rs("PostTime"))&"</td>")
	Response.Write("<td align='center' valign='middle' height='37' width='110' class='left_b bottom_b right_b'>")
	Response.Write("<input name=button type=button class=input1 id=button onmouseover=""this.className='input2'"" onmouseout=""this.className='input1'"" value='' onClick=""window.location.href='"&url&"?ID="&Rs("ID")&"'"" />")
	Response.Write("</td>")
	Response.Write("</tr>")
	end if
	j=j+1
	Rs.MoveNext
	if i>PageSize then
	i=0
	end if
	Loop
	else
	Response.Write("<tr>")
	Response.Write("<td></td>")
	Response.Write("</tr>")
	end if
	Rs.close
	Set Rs=Nothing
end if
Response.Write("</table>")
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td colspan='5' align='center' valign='middle' height='40' class='left_b bottom_b right_b'>")
Call GetPage0(StrWhere,TableName,PageSize,CAndE)
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
End Function

'**************************************************
'函数名：Jobs_List2
'作  用：招聘列表,三列（图标、职位、人数）
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function Jobs_List2(Strsql,TableName,PageSize,url,length,CAndE,TWidth,IcoClumnWidth,TitleClumnWidth,NumClumnWidth,LeftPic)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	if CAndE=0 then							
		Str="职位："&Rs("Jobs")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='27' align='center' class='news_b'>")
		Response.Write("<img src=images/"&LeftPic&">")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='news_b'>")
		Response.Write("<a title="&Rs("Jobs")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	else
		if CAndE=1 then
			Str=Rs("EnJobs")
			Response.Write("<tr>")
			Response.Write("<td width='"&IcoClumnWidth&"' height='27' align='center' class='news_b'>")
			Response.Write("<img src=images/"&LeftPic&">")
			Response.Write("</td>")
			Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='news_b'>")
			Response.Write("<a title="&Rs("EnJobs")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
			if len(Str)>length Then
			Response.Write(Left(Str,length)&"...")
			else
			Response.Write(Str)
			End if
		end if
	end if
	Response.Write("</a></td>")
	Response.Write("<td width='"&NumClumnWidth&"' align='center' class='date news_b'>")
	Response.Write("招聘人数："&Rs("JobNumber"))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：JobsDetailsShow
'作  用：获取招聘详细信息
'参  数：CAndE,0表示中文，1表示英文
'返回值：字符串
'**************************************************
Function JobsDetailsShow(ID,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".Job_top_bg2{ background:url(../Admin/Images/Job_top_bg2.jpg) repeat-x left bottom;}")
Response.Write(".Job_top_bg3{ background:url(../Admin/Images/Job_top_bg3.jpg) repeat-x left bottom;}")
Response.Write(".top_b{ border-top:1px solid #D5D3D4;}")
Response.Write(".left_b{ border-left:1px solid #D5D3D4;}")
Response.Write(".bottom_b{ border-bottom:1px solid #D5D3D4;}")
Response.Write(".right_b{ border-right:1px solid #D5D3D4;}")
Response.Write(".b_b{ border:1px solid #D5D3D4;}")
Response.Write(".JD_f{ font-family:'宋体'; font-size:12px; line-height:24px; color:#6F6F6F;}")
Response.Write(".l_cat_name{ padding-right:14px; text-align:right; vertical-align:middle;}")
Response.Write(".padding_l{ padding-left:2px;}")
Response.Write(".input1 { background:url(../Admin/Images/btn_fh_1.jpg) no-repeat center; width:88px; height:22px; border:0px;}")
Response.Write(".input2 { background:url(../Admin/Images/btn_fh_2.gif) no-repeat center;width:88px; height:22px; cursor:pointer; border:0px;}")
Response.Write(".top_f{ font-size:14px; color:#FF0000; font-weight:bold; padding-left:5px;}")
Response.Write("</style>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from [JobInfo] where ID="&ID
Rs.open Sql,Conn,1,1
if not Rs.eof then
Set Rs2=Server.CreateObject("Adodb.Recordset")
Sql2="select NavTitle,EnNavTitle from [JobClass] where ID="&Rs("ClassID")
Rs2.open Sql2,Conn,1,1
Response.Write("<table width='660' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td height='33' colspan='2' align='left' class='Job_top_bg2 b_b JD_f'><font class='top_f'>")
if CAndE = 0 then
	if len(Trim("Jobs"))>0 then
		Response.Write(Rs("Jobs"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim("EnJobs"))>0 then
		Response.Write(Rs("EnJobs"))
	else
		Response.Write("&nbsp;")
	end if
end if
if CAndE=0 then
	Response.Write("</font>&nbsp;职位的详细信息</td>")
else
	Response.Write("</font>&nbsp;Job details</td>")
end if
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td height='260' colspan='2'>")
Response.Write("<table width='660' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td colspan='2'>")
Response.Write("<table width='660' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
if CAndE =0 then
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>招聘类别：</td>")
else
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>Job Category：</td>")
end if
Response.Write("<td width='178' align='left' valign='middle' class='left_b bottom_b padding_l JD_f'>")
if CAndE =0 then
	if not Rs2.eof and len(Rs2("NavTitle"))>0 then
		Response.Write(Rs2("NavTitle"))
	else
		Response.Write("&nbsp;")
	end if
else
	if not Rs2.eof and len(Rs2("EnNavTitle"))>0 then
		Response.Write(Rs2("EnNavTitle"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
if CAndE = 0 then
	Response.Write("<td width='100' class='left_b bottom_b l_cat_name JD_f'>职称要求：</td>")
else
	Response.Write("<td width='100' class='left_b bottom_b l_cat_name JD_f'>Title request：</td>")
end if
Response.Write("<td width='250' align='left' valign='middle' class='left_b bottom_b right_b	padding_l JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("TitleRequest")))>0 then
		Response.Write(Rs("TitleRequest"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnTitleRequest")))>0 then
		Response.Write(Rs("EnTitleRequest"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr bgcolor='#F7F7F7'>")
if CAndE = 0 then
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>招聘人数：</td>")
else
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>Number：</td>")
end if
Response.Write("<td align='left' valign='middle' class='left_b bottom_b padding_l JD_f'>")
if len(Trim(Rs("JobNumber")))>0 then
	Response.Write(Rs("JobNumber"))
else
	Response.Write("&nbsp;")
end if
Response.Write("</td>")
if CAndE = 0 then
	Response.Write("<td class='left_b bottom_b l_cat_name JD_f'>招聘部门：</td>")
else
	Response.Write("<td class='left_b bottom_b l_cat_name JD_f'>Department：</td>")
end if
Response.Write("<td align='left' valign='middle' class='left_b bottom_b right_b padding_l JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("RDepart")))>0 then
		Response.Write(Rs("RDepart"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnRDepart")))>0 then
		Response.Write(Rs("EnRDepart"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
if CAndE = 0 then
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>性别要求：</td>")
else
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>Gender：</td>")
end if
Response.Write("<td align='left' valign='middle' class='left_b bottom_b padding_l JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("Gender")))>0 then
		Response.Write(Rs("Gender"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnGender")))>0 then
		Response.Write(Rs("EnGender"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
if CAndE =0 then
	Response.Write("<td class='left_b bottom_b l_cat_name JD_f'>工作经验：</td>")
else
	Response.Write("<td class='left_b bottom_b l_cat_name JD_f'>Experience：</td>")
end if
Response.Write("<td align='left' valign='middle' class='left_b bottom_b right_b padding_l JD_f'>")
if CAndE =0 then
	if len(Trim(Rs("Experience")))>0 then
		Response.Write(Rs("Experience"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnExperience")))>0 then
		Response.Write(Rs("EnExperience"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr bgcolor='#F7F7F7'>")
if CAndE =0 then
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>学历要求：</td>")
else
	Response.Write("<td height='28' width='100' class='l_cat_name left_b bottom_b JD_f'>Academic：</td>")
end if
Response.Write("<td align='left' valign='middle' class='left_b bottom_b padding_l JD_f'>")
if CAndE =0 then
	if len(Trim(Rs("Education")))>0 then
		Response.Write(Rs("Education"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnEducation")))>0 then
		Response.Write(Rs("EnEducation"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
if CAndE=0 then
	Response.Write("<td class='left_b bottom_b l_cat_name JD_f'>工龄要求：</td>")
else
	Response.Write("<td class='left_b bottom_b l_cat_name JD_f'>Seniority：</td>")
end if
Response.Write("<td align='left' valign='middle' class='left_b bottom_b right_b padding_l JD_f'>")
if len(Trim(Rs("Age")))>0 then
	Response.Write(Rs("Age"))
else
	Response.Write("&nbsp;")
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
if CAndE=0 then
	Response.Write("<td height='28' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>所学专业：</td>")
else
	Response.Write("<td height='28' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>Profession：</td>")
end if
Response.Write("<td height='28' width='544' align='left' valign='middle' class='padding_l left_b bottom_b right_b JD_f'>")
if CAndE=0 then
	if len(Trim(Rs("Profession")))>0 then
		Response.Write(Rs("Profession"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnProfession")))>0 then
		Response.Write(Rs("EnProfession"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr bgcolor='#F7F7F7'>")
if CAndE = 0 then
	Response.Write("<td height='28' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>工作地区：</td>")
else
	Response.Write("<td height='28' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>WorkAreas：</td>")
end if
Response.Write("<td height='28' width='544' align='left' valign='middle' class='padding_l left_b bottom_b right_b JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("WorkAreas")))>0 then
		Response.Write(Rs("WorkAreas"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnWorkAreas")))>0 then
		Response.Write(Rs("EnWorkAreas"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
if CAndE = 0 then
	Response.Write("<td height='28' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>有效期限：</td>")
else
	Response.Write("<td height='28' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>Validity：</td>")
end if
Response.Write("<td height='28' width='544' align='left' valign='middle' class='padding_l left_b bottom_b right_b JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("EffectiveLimit")))>0 then
		Response.Write(Rs("EffectiveLimit"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnEffectiveLimit")))>0 then
		Response.Write(Rs("EnEffectiveLimit"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr bgcolor='#F7F7F7'>")
if CAndE = 0 then
	Response.Write("<td height='64' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>要求与待遇：</td>")
else
	Response.Write("<td height='64' width='99' align='right' valign='middle' class='l_cat_name left_b bottom_b JD_f'>Requirements and treatment：</td>")
end if
Response.Write("<td height='64' width='544' align='left' valign='top' class='padding_l left_b right_b bottom_b JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("RAT")))>0 then
		Response.Write(Rs("RAT"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnRAT")))>0 then
		Response.Write(Rs("EnRAT"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
if CAndE = 0 then
Response.Write("<td height='32' colspan='3' align='left' class='Job_top_bg3 left_b right_b bottom_b top_f'>职位应聘联系方式</td>")
else
Response.Write("<td height='32' colspan='3' align='left' class='Job_top_bg3 left_b right_b bottom_b top_f'>Job Apply Contact</td>")
end if
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td height='56' colspan='2'><table width='660' height='56' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
if CAndE = 0 then
Response.Write("<td height='28' width='99' class='l_cat_name left_b bottom_b JD_f'>联系人姓名：</td>")
else
Response.Write("<td height='28' width='99' class='l_cat_name left_b bottom_b JD_f'>Contact Name：</td>")
end if
Response.Write("<td align='left' valign='middle' width='178' class='left_b bottom_b padding_l JD_f'>")
if len(Trim(Rs("ContactName")))>0 then
	Response.Write(Rs("ContactName"))
else
	Response.Write("&nbsp;")
end if
Response.Write("</td>")
if CAndE = 0 then
Response.Write("<td width='100' class='l_cat_name left_b bottom_b JD_f'>联系电话：</td>")
else
Response.Write("<td width='100' class='l_cat_name left_b bottom_b JD_f'>Telephone：</td>")
end if
Response.Write("<td width='250' align='left' valign='middle' class='left_b bottom_b right_b padding_l JD_f'>")
if len(Trim(Rs("Phone")))>0 then
	Response.Write(Rs("Phone"))
else
	Response.Write("&nbsp;")
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr bgcolor='#F7F7F7'>")
if CAndE = 0 then
Response.Write("<td height='28' width='99' class='l_cat_name left_b bottom_b JD_f'>单位传真：</td>")
else
Response.Write("<td height='28' width='99' class='l_cat_name left_b bottom_b JD_f'>Fax：</td>")
end if
Response.Write("<td align='left' valign='middle' width='178' class='left_b bottom_b padding_l JD_f'>")
if len(Trim(Rs("Fax")))>0 then
	Response.Write(Rs("Fax"))
else
	Response.Write("&nbsp;")
end if
Response.Write("</td>")
if CAndE = 0 then
Response.Write("<td width='100' class='l_cat_name left_b bottom_b JD_f'>电子邮箱：</td>")
else
Response.Write("<td width='100' class='l_cat_name left_b bottom_b JD_f'>Email：</td>")
end if
Response.Write("<td width='250' align='left' valign='middle' class='left_b bottom_b right_b padding_l JD_f'>")
if len(Trim(Rs("Email")))>0 then
	Response.Write(Rs("Email"))
else
	Response.Write("&nbsp;")
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
if CAndE = 0 then
Response.Write("<td width='99' height='28' class='l_cat_name left_b bottom_b JD_f'>通信地址：</td>")
else
Response.Write("<td width='99' height='28' class='l_cat_name left_b bottom_b JD_f'>Address：</td>")
end if
Response.Write("<td width='544' align='left' valign='middle' class='left_b bottom_b right_b padding_l JD_f'>")
if CAndE = 0 then
	if len(Trim(Rs("Address")))>0 then
		Response.Write(Rs("Address"))
	else
		Response.Write("&nbsp;")
	end if
else
	if len(Trim(Rs("EnAddress")))>0 then
		Response.Write(Rs("EnAddress"))
	else
		Response.Write("&nbsp;")
	end if
end if
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td colspan='2' height='45' align='right'>")
Response.Write("<input name=button type=button class=input1 id=button onmouseover=""this.className='input2'"" onmouseout=""this.className='input1'"" value='' onClick=""window.location.href='JavaScript:history.go(-1)'"" />")
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
else
	Response.Write("暂无内容")
end if
Rs.close
Set Rs=Nothing
Rs2.close
Set Rs2=Nothing
End Function

'**************************************************
'函数名：FirendLink1
'作  用：获取友情链接信息
'参  数：
'返回值：字符串/链接地址
'**************************************************
Function FirendLink1(Rows,Columns,PicWidth,PicHeight)
Response.Write("<table border='0' align='left' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from [FirendLink] order by NavOrder asc"
Rs.open Sql,Conn,1,1
i=0
Do While not Rs.eof
	Response.Write("<tr>")
	Do While not Rs.eof
		Response.Write("<td width='80' style='padding:5px 8px;'>")
		if instr(Trim(Rs("LinkTitleOrPic")),"UploadFile")>0 then
			Response.Write("<a href="""&Rs("LinkAddress")&""" target=""_blank""><img src="""&Rs("LinkTitleOrPic")&""" width="""&PicWidth&""" height="""&PicHeight&""" style='padding:1px; border:1px solid #8C8C8C;'/></a>")
		else
			Response.Write("<font style=""font-weight:bold;line-height:26px;"">&middot;</font>&nbsp;<a href="""&Rs("LinkAddress")&""" target=""_blank"">"&Rs("LinkTitleOrPic")&"</a>")
		end if
		Response.Write("</td>")
		Rs.MoveNext
		i=i+1
		if i mod Columns = 0 then
			Exit Do
		end if
	Loop
	Response.Write("</tr>")
	if i mod Rows*Columns = 0 then
		Exit Do
	end if
Loop
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
End Function

'**************************************************
'函数名：FirendLink2
'作  用：获取友情链接信息,两列(图片大小88*31)
'参  数：
'返回值：字符串/链接地址
'**************************************************
Function FirendLink2()
Response.Write("<style type='text/css'>")
Response.Write(".float_lll{ float:left; width:50%; padding:4px 0px; text-align:center; vertical-align:middle; line-height:31px;}")
Response.Write("</style>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from [FirendLink] order by NavOrder asc"
Rs.open Sql,Conn,1,1
Response.Write("<div><ul>")
Do While not Rs.eof
Response.Write("<li class='float_lll'>")
if instr(Trim(Rs("LinkAddress")),"http://")>0 then
Response.Write("<a href='"&Rs("LinkAddress")&"' target='_blank'><img src='"&Rs("LinkTitleOrPic")&"' alt='' width='88' height='31' style='border:1px solid #8C8C8C; padding:1px;' /></a>")
else
Response.Write("<img src='"&Rs("LinkTitleOrPic")&"' alt='' width='88' height='31' />")
end if
Response.Write("</li>")
Rs.MoveNext
Response.Write("<li class='float_lll'>")
if instr(Trim(Rs("LinkAddress")),"http://")>0 then
Response.Write("<a href='"&Rs("LinkAddress")&"' target='_blank'><img src='"&Rs("LinkTitleOrPic")&"' alt='' width='88' height='31' style='border:1px solid #8C8C8C; padding:1px;' /></a>")
else
Response.Write("<img src='"&Rs("LinkTitleOrPic")&"' alt='' width='88' height='31' />")
end if
Response.Write("</li>")
Rs.MoveNext
Loop
Response.Write("</ul></div>")
Rs.close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetGuestbookList1
'作  用：获取留言列表,三列（图标、标题、时间）,td背景无鼠标经过变色
'参  数：ID------当前ID,CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function GetGuestbookList1(Strsql,TableName,PageSize,url,length,TWidth,IcoClumnWidth,TitleClumnWidth,DateClumnWidth,LeftPic)
Dim Rs,Str
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' align='center' cellpadding='0'>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By PostTime Desc,ID Desc"
Rs.Open Sql,Conn,1,1
Page=Request("Page")                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount           
PGNum=Rs.PageCount               
If Page="" Or Clng(Page)<1 Then Page=1               
If Clng(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
i=0
if Not Rs.Eof or not Rs.bof then
	Do While i<Rs.PageSize
	Str=Rs("GuestbookTitle")
		Response.Write("<tr>")
		Response.Write("<td width='"&IcoClumnWidth&"' height='24' align='center' class='new_b news'>")
		Response.Write("<img src=images/"&LeftPic&">")
		Response.Write("</td>")
		Response.Write("<td width='"&TitleClumnWidth&"' align='left' class='new_b news'>")
		Response.Write("<a title="&Rs("GuestbookTitle")&" href="&url&"?ID="&Rs("ID")&" target=_blank >")
		if len(Str)>length Then
		Response.Write(Left(Str,length)&"...")
		else
		Response.Write(Str)
		End if
	Response.Write("</a></td>")
	Response.Write("<td width='"&DateClumnWidth&"' align='center' class='news new_b'>")
	Response.Write(GetPostTime(Rs("ID"),""&TableName&""))
	Response.Write("</td></tr>")
	i=i+1
	Rs.MoveNext
	If Rs.Eof Then Exit Do
	Loop
else
Response.Write("<tr><td align='center'>")
if CAndE = 0 then
	Response.Write("暂无内容")
else
	if CAndE = 1 then
		Response.Write("No Content")
	end if
end if
Response.Write("</td></tr>")
end if
Response.Write("</table>")
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：AddGuestbook
'作  用：添加留言信息
'参  数：CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function AddGuestbook(url,CAndE)
Response.Write("<style type='text/css'>")
Response.Write("#ConMan,#ProName,#ProNumber,#Address,#Phone,#Email,#GuestbookTitle,#Tel,#CompanyName,#Website,#ICQ,#Fax{ width:380px; height:20px; border:1px solid #DCDBDB; margin-left:5px; background:url(../images/txt_bg.jpg) repeat-x left top; line-height:20px;}")
Response.Write("#Content{ width:380px; height:150px; border:1px solid #DCDBDB; margin-left:5px;background:url(../images/txt_bg.jpg) repeat-x left top;}")
Response.Write("#UserName{ width:150px; height:20px; border:1px solid #DCDBDB; margin-left:5px;background:url(../images/txt_bg.jpg) repeat-x left top;}")
Response.Write("#ProName2,#ProName22,#ProName23,#ProName24,#ProName25,#ProName26,#ProName27,#ProName28{ width:200px; height:20px; border:1px solid #DCDBDB; margin-left:5px; background:url(../images/txt_bg.jpg) repeat-x left top; line-height:20px;}")
Response.Write("#ProNumber2,#ProNumber23,#ProNumber22,#ProNumber24,#ProNumber25,#ProNumber26,#ProNumber27,#ProNumber28{ width:100px; height:20px; border:1px solid #DCDBDB; margin-left:5px; background:url(../images/txt_bg.jpg) repeat-x left top; line-height:20px;}")
Response.Write(".STYLE1{ color:#F00; text-align:left;}")
Response.Write("</style>")
Response.Write("<script language='javascript'>")
Response.Write("function CheckGB(){")
Response.Write("if (document.form11.GuestbookTitle.value.length==0)")
Response.Write("{")
Response.Write("window.alert('\u7559\u8a00\u4e3b\u9898\u4e0d\u80fd\u4e3a\u7a7a\u0021');")
Response.Write("document.form11.GuestbookTitle.focus();")
Response.Write("return false;")
Response.Write("}")
Response.Write("if (document.form11.UserName.value.length==0)")
Response.Write("{")
Response.Write("window.alert('\u59d3\u540d\u4e0d\u80fd\u4e3a\u7a7a\u0021');")
Response.Write("document.form11.UserName.focus();")
Response.Write("return false;")
Response.Write("}")
Response.Write("if (document.form11.Tel.value.length==0)")
Response.Write("{")
Response.Write("window.alert('\u7535\u8bdd\u53f7\u7801\u4e0d\u80fd\u4e3a\u7a7a\u0021');")
Response.Write("document.form11.Tel.focus();")
Response.Write("return false;")
Response.Write("}else{")
Response.Write("if(!checkphone(document.form11.Tel.value)){")
Response.Write("window.alert('\u60a8\u8f93\u5165\u7684\u5185\u5bb9\u4e3a\u975e\u6570\u5b57\u6216\u7535\u8bdd\u53f7\u7801\u4e0d\u6b63\u786e\u0021');")
Response.Write("document.form11.Tel.focus();")
Response.Write("return false;}}")
Response.Write("if (document.form11.Address.value.length==0){")
Response.Write("window.alert('\u8054\u7cfb\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a\u0021');")
Response.Write("document.form11.Address.focus();return false;}")
Response.Write("if (( document.form11.Email.value.length<5 )||(document.form11.Email.value.indexOf('@')==-1)||(document.form11.Email.value.indexOf('.')==-1 ))")
Response.Write("{window.alert('\u8bf7\u8f93\u5165\u6b63\u786e\u7684\u0045\u002d\u004d\u0061\u0069\u006c\u0021\u0021'); ")
Response.Write("document.form11.Email.focus();return false;}")
Response.Write("if (document.form11.Email.value.length==0){")
Response.Write("window.alert('\u0045\u002d\u004d\u0061\u0069\u006c\u4e0d\u80fd\u4e3a\u7a7a\u0021');")
Response.Write("document.form11.Email.focus();return false;}if (document.form11.Content.value.length==0){")
Response.Write("window.alert('\u7559\u8a00\u5185\u5bb9\u4e0d\u80fd\u4e3a\u7a7a\u0021');")
Response.Write("document.form11.Content.focus();return false;}return true;}")
Response.Write("function checkphone(tel){")
'在JavaScript中，正则表达式只能使用"/"开头和结束，不能使用双引号
Response.Write("var Expression=/(\d{3}-)(\d{8})$|(\d{4}-)(\d{7})$|(\d{4}-)(\d{8})$|(\d{11})$|(\d{8})$|(\d{7})$/;")
Response.Write("var objExp=new RegExp(Expression);if(objExp.test(tel)==true){return true;}else{return false;}}</script>")
Response.Write("<form name='form11' id='form11' method='post' action='?action=Message' target='_self' onsubmit='return CheckGB()'>")
Response.Write("<table width='600' border='0' align='center' cellpadding='0' cellspacing='0'>")
Response.Write("<tr><td width='70' height='15' align='right' valign='middle'>&nbsp;</td>")
if CAndE = 0 then
	Response.Write("<td width='400' style='color:#C32027;font-weight:bold;'></td><td><a href='"&url&"'>查看留言</a></td>")
	Response.Write("</tr><tr><td height='15' align='right' valign='middle'>留言主题：</td>")
	Response.Write("<td width='400'><input type='text' name='GuestbookTitle' id='GuestbookTitle' /></td><td class='STYLE1'>*必填</td>")
	Response.Write("</tr><tr><td width='70' height='30' align='right' valign='middle'>姓名：</td>")
	Response.Write("<td width='400' align='left' style=' padding-left:5px;'><input type='text' name='UserName' id='UserName' />&nbsp;")
	Response.Write("<input type='radio' name='Sex' id='radio' value='先生' checked='checked' />先生")
	Response.Write("<input type='radio' name='Sex' id='Sex' value='女士' />女士</td><td class='STYLE1'>*必填</td>")
	Response.Write("</tr><tr><td width='70' height='30' align='right' valign='middle'>联系电话：</td>")
	Response.Write("<td width='400'><input type='text' name='Tel' id='Tel' /></td><td class='STYLE1'>*必填</td></tr><tr>")
	Response.Write("<td width='70' height='30' align='right' valign='middle'>单位名称：</td>")
	Response.Write("<td width='400'><input type='text' name='CompanyName' id='CompanyName' /></td><td>&nbsp;</td></tr><tr>")
	Response.Write("<td width='70' height='30' align='right' valign='middle'>地址：</td>")
	Response.Write("<td width='400'><input type='text' name='Address' id='Address' /></td><td class='STYLE1'>*必填</td></tr><tr>")
	Response.Write("<td width='70' height='30' align='right' valign='middle'>邮箱：</td>")
	Response.Write("<td width='400'><input type='text' name='Email' id='Email' /></td><td class='STYLE1'>*必填</td></tr><tr>")
	Response.Write("<td width='70' height='30' align='right' valign='middle'>主页：</td>")
	Response.Write("<td width='400'><input type='text' name='Website' id='Website' /></td><td>&nbsp;</td></tr><tr>")
	Response.Write("<td width='70' height='30' align='right' valign='middle'>ICQ/OICQ：</td>")
	Response.Write("<td width='400'><input type='text' name='ICQ' id='ICQ' /></td><td>&nbsp;</td></tr><tr>")
	Response.Write("<td width='70' height='30' align='right' valign='top'>留言内容：</td>")
	Response.Write("<td width='400' height='160'><textarea name='Content' id='Content' /></textarea></td>")
	Response.Write("<td align='left' valign='top'><span class='STYLE1'>*必填</span></td></tr><tr><td height='30'>&nbsp;</td>")
else
	if CAndE = 1 then
		Response.Write("<td width='400'>&nbsp;</td><td><a href='"&url&"'>View Message</a></td>")
		Response.Write("</tr><tr><td height='15' align='right' valign='middle'>Message Topic：</td>")
		Response.Write("<td width='400'><input type='text' name='GuestbookTitle' id='GuestbookTitle' /></td><td class='STYLE1'>*Required</td>")
		Response.Write("</tr><tr><td width='70' height='30' align='right' valign='middle'>Name：</td>")
		Response.Write("<td width='400' align='left' style='padding-left:5px;'><input type='text' name='UserName' id='UserName' />&nbsp;")
		Response.Write("<input type='radio' name='Sex' id='radio' value='先生' checked='checked' />Mr.")
		Response.Write("<input type='radio' name='Sex' id='Sex' value='女士' />Lady</td><td class='STYLE1'>*Required</td>")
		Response.Write("</tr><tr><td width='70' height='30' align='right' valign='middle'>Phone：</td>")
		Response.Write("<td width='400'><input type='text' name='Tel' id='Tel' /></td><td class='STYLE1'>*Required</td></tr><tr>")
		Response.Write("<td width='70' height='30' align='right' valign='middle'>CompanyName：</td>")
		Response.Write("<td width='400'><input type='text' name='CompanyName' id='CompanyName' /></td><td>&nbsp;</td></tr><tr>")
		Response.Write("<td width='70' height='30' align='right' valign='middle'>Address：</td>")
		Response.Write("<td width='400'><input type='text' name='Address' id='Address' /></td><td class='STYLE1'>*Required</td></tr><tr>")
		Response.Write("<td width='70' height='30' align='right' valign='middle'>E-Mail：</td>")
		Response.Write("<td width='400'><input type='text' name='Email' id='Email' /></td><td class='STYLE1'>*Required</td></tr><tr>")
		Response.Write("<td width='70' height='30' align='right' valign='middle'>Home：</td>")
		Response.Write("<td width='400'><input type='text' name='Website' id='Website' /></td><td>&nbsp;</td></tr><tr>")
		Response.Write("<td width='70' height='30' align='right' valign='middle'>ICQ/OICQ：</td>")
		Response.Write("<td width='400'><input type='text' name='ICQ' id='ICQ' /></td><td>&nbsp;</td></tr><tr>")
		Response.Write("<td width='70' height='30' align='right' valign='top'>Message：</td>")
		Response.Write("<td width='400' height='160'><textarea name='Content' id='Content' /></textarea></td>")
		Response.Write("<td align='left' valign='top'><span class='STYLE1'>*Required</span></td></tr><tr><td height='30'>&nbsp;</td>")
	end if
end if
Response.Write("<td height='30' align='left' valign='middle'><table width='260' height='30' border='0' align='left' cellpadding='0' cellspacing='0'>")
Response.Write("<tr><td width='130' align='center' style='padding-left:5px;'><input name='submit' type='submit' style='border:0px solid; background:url(../Admin/images/Guestbook_btn.jpg) no-repeat;cursor:hand; height:20px; width:118px;' value=''/></td>")
Response.Write("<td width='130' align='center'><input name='reset' type='reset' style='border:0px solid; background:url(../Admin/images/GbReset_btn.jpg) no-repeat;cursor:hand; height:20px; width:118px;' value=''/></td>")
Response.Write("</tr></table></td><td height='30'>&nbsp;</td></tr></table></form>")
select case Request("action")
	case "Message"
	call Message()
end select
End Function
sub Message()
if Request("action")="Message" then
	GuestbookTitle=Trim(Request("GuestbookTitle"))
	UserName=Trim(Request("UserName"))
	if Request("Sex")="先生" then
		Sex="先生"
	else
		Sex="女士"
	end if
	Tel=Trim(Request("Tel"))
	CompanyName=Trim(Request("CompanyName"))
	Address=Trim(Request("Address"))
	Email=Trim(Request("Email"))
	Website=Trim(Request("Website"))
	ICQ=Trim(Request("ICQ"))
	Content=ReplaceBadChar(Trim(Request("Content")))
	if Trim(Request("GuestbookType"))="true" then
		GuestbookType=true
	else
		GuestbookType=false
	end if
	Set Rs=Server.CreateObject("Adodb.Recordset")
	Sql="select * from [GuestBook]"
	Rs.open Sql,Conn,1,3
	Rs.AddNew()
	Rs("GuestbookTitle")=GuestbookTitle
	Rs("UserName")=UserName
	Rs("Sex")=Sex
	Rs("LinkPhone")=Tel
	Rs("CompanyName")=CompanyName
	Rs("Address")=Address
	Rs("Email")=Email
	Rs("HomePage")=Website
	Rs("ICQ")=ICQ
	Rs("GuestbookContent")=Content
	Rs("GuestbookType")=GuestbookType
	Rs("NavOrder")=NavOrder
	Rs("NavParent")=0
	Rs("NavLevel")=0
	Rs("PostTime")=Now()
	Rs.UpDate()
	Rs.close
	Set Rs=Nothing
	if CAndE = 0 then
		Response.Write("<script>alert('感谢您的留言！');location.href='Message.asp';</script>")
	else
		if CAndE = 1 then
			Response.Write("<script>alert('Thank you for your message！');location.href='Message.asp';</script>")
		end if
	end if
	Response.End()
end if
end sub

'**************************************************
'函数名：LookGuestbook1
'作  用：获取留言信息,留言信息全部展开
'参  数：CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function LookGuestbook1(StrWhere,PageSize,url,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".b_t_c{ border-top:1px solid #D8DAD9;}")
Response.Write(".b_r_c{ border-right:1px solid #D8DAD9;}")
Response.Write(".b_b_c{ border-bottom:1px solid #D8DAD9;}")
Response.Write(".b_l_c{ border-left:1px solid #D8DAD9;}")
Response.Write(".bg_c{ background-color:#F4F4F4;}")
Response.Write(".bbb{ line-height:10px;}")
Response.Write(".content_bg{ background-color:#ffffff;}")
Response.Write(".b_distance{ padding:20px 5px 50px 5px;}")
Response.Write(".b_ddd_c{ border-bottom:1px dashed #C6C6C6;}")
Response.Write(".gb_pic{ background:url(Admin/Images/gb_pic.jpg) no-repeat 10px center;}")
Response.Write(".ffff{ font-family:'宋体'; font-size:12px; line-height:24px; color:#333333;}")
Response.Write(".fff2{ padding-left:25px; text-align:left;}")
Response.Write(".lgb_fb_pic{ background:url(Admin/Images/lgb_fb_pic.jpg) no-repeat 560px 12px;background-color:#F4F4F4; text-align:right; padding-right:26px;}")
Response.Write("</style>")
Response.Write("<table width='660' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td class='b_t_c b_r_c b_l_c lgb_fb_pic' height='41'><a href='"&url&"'>发表留言</a></td>")
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td align='center' class='b_r_c b_l_c bg_c'>")
Response.Write("<table width='640' border='0' cellspacing='0' cellpadding='0' class='content_bg'>")
Response.Write("<tr>")
Response.Write("<td align='center' class='b_distance'>")
Response.Write("<table border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from [GuestBook] "&StrWhere&" order by ID desc"
Rs.open Sql,Conn,1,1
i=0
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
Do While not Rs.eof and i<PageSize
Response.Write("<tr><td>")
Response.Write("<table width='630' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td align='right' class='b_ddd_c gb_pic ffff'>")
Response.Write("<table width='605' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td align='left' width='405'>"&Rs("GuestbookTitle")&"</td>")
Response.Write("<td align='right' width='200'><font style='color:#156EC8;'>"&Rs("UserName")&"</font>&nbsp;|&nbsp;<font style='color:#6CAA3A;'>"&Rs("PostTime")&"</font></td>")
Response.Write("</tr>")
Response.Write("</table></td>")
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td class='ffff fff2'>"&Rs("GuestbookContent")&"</td>")
Response.Write("</tr>")
if len(Trim(Rs("Reply")))>0 then
	Response.Write("<tr>")
	if CAndE=0 then
		Response.Write("<td class='ffff fff2'><font style='color:#FB0000;'>管理员回333复：</font></td>")
	else
		if CAndE=1 then
			Response.Write("<td class='ffff fff2'><font style='color:#FB0000;'>Administrator Reply：</font></td>")
		end if
	end if
	Response.Write("</tr>")
	Response.Write("<tr>")
	Response.Write("<td class='b_b_c ffff fff2'>"&Rs("Reply")&"</td>")
	Response.Write("</tr>")
end if
Response.Write("</table>")
Response.Write("</td></tr>")
Rs.MoveNext
i=i+1
Loop
Response.Write("<td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("</td></tr>")
Response.Write("<tr>")
Response.Write("<td height='40' align='center'>")
Call GetPage0(StrWhere,"GuestBook",PageSize,CAndE)
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("</td></tr>")
Response.Write("<tr>")
Response.Write("<td class='b_b_c b_r_c b_l_c bg_c bbb'>&nbsp;</td>")
Response.Write("</tr>")
Response.Write("</table>")
End Function

'**************************************************
'函数名：LookGuestbook2
'作  用：获取留言信息,带有缩放效果
'参  数：CAndE:0表示中文,1表示英文
'返回值：字符串
'**************************************************
Function LookGuestbook2(StrWhere,PageSize,url,TWidth,CAndE)
Response.Write("<script type='text/javascript' src='Control/jquery.min.js'></script>")
Response.Write("<style type='text/css'>")
Response.Write(".t_border{ border-top:1px solid #D9D9D9;}")
Response.Write(".r_border{ border-right:1px solid #D9D9D9;}")
Response.Write(".b_border{ border-bottom:1px solid #D9D9D9;}")
Response.Write(".l_border{ border-left:1px solid #D9D9D9;}")
Response.Write(".mm_b{ border-bottom:1px solid #D8DAD9;}")
Response.Write(".top_bg2{ background-color:#F4F4F4;}")
Response.Write(".m_bg{ background-color:#ffffff;}")
Response.Write(".b_bbb{ line-height:10px;}")
Response.Write(".b_line{ border-bottom:1px dashed #C1C1C1;}")
Response.Write(".top_r{ padding-right:28px;}")
Response.Write(".m_space{ padding:15px 0px;}")
Response.Write(".lgb_fb_pic{ background:url(../../../../Admin/Images/lgb_fb_pic.jpg) no-repeat center;}")
Response.Write(".gb_pic{ background:url(../../../../Admin/Images/gb_pic.jpg) no-repeat right center;}")
Response.Write("</style>")
Response.Write("<table width='"&TWidth&"' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr><td height='42' align='right' valign='middle' class='top_bg2 top_r t_border l_border r_border'>")
Response.Write("<table width='75' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr><td width='18' align='center' valign='middle' class='lgb_fb_pic'>&nbsp;</td>")
Response.Write("<td width='57' align='center' valign='middle'><a href='"&url&"'>")
if CAndE = 0 then
Response.Write("发表留言")
else
	if CAndE = 1 then
	Response.Write("Message")
	end if
end if
Response.Write("</a></td></tr></table></td></tr>")
Response.Write("<tr><td align='center' valign='top' class='top_bg2 l_border r_border'>")
Response.Write("<table border='0' width='"&TWidth-20&"' align='center' cellpadding='0' cellspacing='0'><tr><td align='center' valign='top' class='m_bg m_space'>")

Response.Write("<table border='0' align='center' cellpadding='0' cellspacing='0'>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from [GuestBook] "&StrWhere&" order by PostTime desc"
Rs.open Sql,Conn,1,1
i=0
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page
Do While not Rs.eof and i<PageSize
Response.Write("<script type='text/javascript'>$(document).ready(function(){")
Response.Write("$(""a.sg"&i&""").click(function(event){")
Response.Write("event.preventDefault();")
Response.Write("$(""div.sg"&i&".in"").removeClass(""in"");")
Response.Write("$(""div.in"").hide(""slow"");")
Response.Write("$(""div.sg"&i&""").slideToggle(""slow"");")
Response.Write("$(""div.sg"&i&""").addClass(""in"");")
Response.Write("});});</script>")
Response.Write("<tr><td width='17' height='24' align='right' valign='middle' class='b_line gb_pic'>&nbsp;</td>")
Response.Write("<td width='347' height='24' align='left' valign='middle' class='b_line' style='padding-left:5px;'>")
Response.Write("<div><li><a href='#' class='sg"&i&"'><font style='color:#7D7E7E;'>"&Rs("GuestbookTitle")&"</font></a></li></div>")
Response.Write("</td><td width='181' align='right' valign='middle' class='b_line' style='padding-left:5px; padding-right:8px; color:#156EC8;'>"&Rs("UserName")&"</td>")
Response.Write("<td width='1' height='24' align='center' valign='middle' class='b_line'><img src='Admin/Images/split.jpg' /></td>")
Response.Write("<td width='73' height='24' align='center' valign='middle' class='b_line' style='color:#6CAA3A;'>"&ConvertDate(Rs("PostTime"))&"</td>")
Response.Write("</tr><tr><td align='left' valign='middle' colspan='5'>")
Response.Write("<div class='sg"&i&"' style='display:none; list-style:none;'>")
Response.Write("<li style='padding:8px 10px 8px 22px; color:#333333;'>"&Rs("GuestbookContent")&"</li>")
if len(Trim(Rs("Reply")))>0 then
Response.Write("<li style='padding-left:22px; color:#FB0000;'>")
if CAndE = 0 then
Response.Write("管理员回复：&nbsp;&nbsp;&nbsp;&nbsp;回复人:")
else
	if CAndE = 1 then
	Response.Write("Administrator Reply：&nbsp;&nbsp;&nbsp;&nbsp;Reply man:")
	end if
end if
Response.Write("<font style='color:#333333;'>"&Rs("VerifyPeople")&"</font>")
Response.Write("</li>")
Response.Write("<li class='mm_b' style='padding:8px 10px 8px 22px; color:#333333;'>"&Rs("Reply")&"</li>")
end if
Response.Write("</div></td></tr>")
Rs.MoveNext
i=i+1
Loop
Rs.close
Set Rs=Nothing
Response.Write("</table></td></tr><tr><td height='30' align='center' valign='middle' class='m_bg'>")
Call GetPage0(StrWhere,"GuestBook",PageSize,CAndE)

Response.Write("</td></tr></table>")
Response.Write("</td></tr>")
Response.Write("<tr><td class='top_bg2 b_bbb l_border b_border r_border'>&nbsp;</td></tr>")
Response.Write("</table>")
End Function

'**************************************************
'函数名：IsValidEmail
'作  用：Email检测
'返回值：bool值
'**************************************************
function IsValidEmail(email)
dim names, name, i, c
IsValidEmail = true
names = Split(email, "@")
if UBound(names) <> 1 then
    IsValidEmail = false
    exit function
end if
for each name in names
    if Len(name) <= 0 then
      IsValidEmail = false
      exit function
    end if
    for i = 1 to Len(name)
      c = Lcase(Mid(name, i, 1))
      if InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 and not IsNumeric(c) then
        IsValidEmail = false
        exit function
      end if
    next
    if Left(name, 1) = "." or Right(name, 1) = "." then
       IsValidEmail = false
       exit function
    end if
next
if InStr(names(1), ".") <= 0 then
    IsValidEmail = false
    exit function
end if
i = Len(names(1)) - InStrRev(names(1), ".")
if i <> 2 and i <> 3 then
    IsValidEmail = false
    exit function
end if
if InStr(email, "..") > 0 then
    IsValidEmail = false
end if
end function

'**************************************************
'函数名：SiteKeysTitle
'作  用：获取站点关键字，标题
'参  数：PageName,页面名称
'返回值：字符串
'**************************************************
Function SiteKeysTitle(PageName)
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select top 1 * From SiteInfo"
Rs.Open Sql,Conn,1,1
if not (Rs.eof or Rs.bof) then
	if len(Trim(Rs("SiyeKeys")))>0 then
		Response.Write("<meta name=""keywords"" content="""&Rs("SiyeKeys")&""" />")
	end if
	if len(Trim(Rs("SiteDes")))>0 then
		Response.Write("<meta name=""description"" content="""&Rs("SiteDes")&""" />")
	end if
	if len(Trim(Rs("SiteName")))>0 then
		Response.Write("<title>"&Rs("SiteName")&" - "&PageName&"</title>")
	else
		Response.Write("<title>"&PageName&"</title>")
	end if
else
	Response.Write("<title>"&PageName&"</title>")
end if
Rs.close
Set Rs=Nothing
End Function

'**************************************************
'函数名：DigitPages1
'作  用：数字翻页，带图片
'参  数：
'返回值：字符串
'**************************************************
Function DigitPages1(SqlWhere,TableName)
Response.Write("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td><table cellspacing='0' cellpadding='0' width='100%' align='center' border='0'>")
page_count=1
if Request("page")="" then
page=1
else
page=cint(Request("page"))
End if
set rs=Server.CreateObject("ADODB.RecordSet")
sql_88="SELECT * FROM "&TableName&" "&SqlWhere&" order by ShopOrder asc"
rs.Open sql_88,conn,1,3
totalcount=rs.RecordCount
totalpage=int(totalcount/page_count+(page_count-1)/page_count)
if page>totalpage then page=totalpage
if rs.EOF then
	Response.Write("<tr>")
	Response.Write("<td height='30' align='center' valign='bottom'><font color='#FF0000'>暂无图片</font></td>")
	Response.Write("</tr>")
else
    for i = 1 to (page-1)*page_count
      rs.MoveNext
    Next
    if page<totalpage then
      psize=page_count
    else
      psize=totalcount-(page-1)*page_count
    End if
    for i = 1 to psize
		Response.Write("<tr>")
		Response.Write("<td height='30' align='center' valign='middle'>")
		Response.Write("<table border='0' cellspacing='0' cellpadding='0'>")
		Response.Write("<tr>")
		Response.Write("<td align='center' valign='middle'>")
		Response.Write("<a href='?Page="&Page-1&"'><img src='images/arr_l.gif'/></a>")
    	Response.Write("</td>")
        Response.Write("<td align='center' valign='middle'><font><img src='"&Rs("ShopBPic")&"' border='0'/></font></td>")
        Response.Write("<td align='center' valign='middle'>")
		Response.Write("<a href='?Page="&Page+1&"'><img src='images/arr_r.gif' /></a>")
        Response.Write("</td>")
        Response.Write("<tr>")
        Response.Write("</table></td>")
		Response.Write("</tr>")
    	rs.MoveNext
    Next
End If
rs.Close
Response.Write("</table></td>")
Response.Write("</tr>")
Response.Write("<tr>")
Response.Write("<td align='center' valign='middle'>")
Response.Write("页次：" & page & "/" & totalpage & "　每页<font color='#ff0000'>" & page_count & "</font>　记录数<font color='#ff0000'>"&totalcount & "</font>　")
if page>1 then
	Response.Write("<a href='?Page=1' title='第一页'><font face='Webdings'>9</font></a>　<a href='?page=" & page-1 & "' title='上一页'><font face='Webdings'>3</font></a>&nbsp;")
else
    Response.Write("<font face='Webdings'>9</font>&nbsp;<font face='Webdings'>3</font>&nbsp;")
end if
if totalpage<6 then
    bpage=1
	epage=totalpage
else 
	if page<3 then
		bpage=1
		epage=5
	else 
		if page>totalpage-2 then
			bpage=totalpage-4
			epage=totalpage
		else
			bpage=page-2
			epage=page+2
		end if
	end if
end if
for i=bpage to epage
if i=page then
	Response.Write("[" & i & "]&nbsp;")
else
	Response.Write("<a href='?page=" & i & "'>[" & i & "]</a>&nbsp;")
end if
next
if page<totalpage then
Response.Write("<a href='?page=" & page+1 & "' title='下一页'><font face='Webdings'>4</font></a>　<a href='?page=" & totalpage & "' title='最后页'><font face='Webdings'>:</font></a>")
else
	Response.Write("<font face='Webdings'>4</font>　<font face='Webdings'>:</font>")
end if
Response.Write("　<select name='selectpage' onchange='javascript:window.location.href=this.options[this.selectedIndex].value'>")
for i=1 to totalpage
	Response.Write("<option value='?page=" & i & "'")
	if i=page then Response.Write(" selected")
	Response.Write(">第" & i & "页</option>")
next
Response.Write("</select>")
Response.Write("</td>")
Response.Write("</tr>")
Response.Write("</table>")
End Function

'************************************************** 
'函数名：UserRegister 
'作 用：向文本文件写入内容
'参 数：IsOffer是否供应商,true表示供应商，否则为false
'参数：CAndE；0表示中文，1表示英文
'返回值：文件内容 
'************************************************** 
Function UserRegister(IsOffer,CAndE)
	if CAndE = 0 then
		Response.Write("<script type=""text/javascript"" src=""Admin/Common/UserReg.js""></script>")
	else
		if CAndE = 1 then
			Response.Write("<script type=""text/javascript"" src=""../Admin/Common/UserReg.js""></script>")
		end if
	end if
	Response.Write("<style type='text/css'><!--")
	Response.Write(".STYLE1 {color: #FF0000;font-family:'宋体'; font-size:12px; line-height:24px;}")
	Response.Write(".td_font{font-family:'宋体'; font-size:12px; line-height:24px; color:#7d7e7e;}")
	Response.Write(".loginbtn{border:0px solid; background:url(../Admin/images/MemberReg_02.jpg) no-repeat;cursor:pointer; height:24px; width:58px;}")
	Response.Write(".ReSet{border:0px solid; background:url(../Admin/images/MemberReg_03.jpg) no-repeat;cursor:pointer; height:24px; width:58px;}")
	Response.Write("#memberNum,#userName,#passWord,#Address,#TelPhone,#CellPhone,#Sex,#Offer,#RePassWord{ width:310px; height:25px; border:1px solid #B2C4EC; line-height:25px;}")
	Response.Write("#Code{ height:25px; border:1px solid #B2C4EC; line-height:25px; width:60px;}")
	Response.Write("--></style>")
	Response.Write("<form name='form1' id='from1' method='post' action='?action=MemberRegister' target='_self' onsubmit='return fun("""&IsOffer&""")'>")
	Response.Write("<table width='620' border='0' cellspacing='0' cellpadding='0'>")
	if IsOffer = true then
		if CAndE = 0 then
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>供应商：</td>")
			Response.Write("<td width='301' height='35' align='left' valign='middle'><input type='text' name='Offer' id='Offer' value='"&Request("Offer")&"'/></td>")
			Response.Write("<td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr>")
		else
		if CAndE = 1 then
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>Supplier：</td>")
			Response.Write("<td width='301' height='35' align='left' valign='middle'><input type='text' name='Offer' id='Offer' value='"&Request("Offer")&"'/></td>")
			Response.Write("<td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr>")
		end if
		end if
	end if
	if CAndE = 0 then
		Response.Write("<tr>")
		Response.Write("<td width='116' height='35' align='right' class='td_font'>用户名：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='userName' id='userName' value='"&Request("memberNum")&"'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr><tr>")
		Response.Write("<td width='116' height='35' align='right' class='td_font'>密&nbsp;&nbsp;码：</td><td width='301' height='35' align='left' valign='middle'><input type='password' name='passWord' id='passWord' /></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填,密码长度应在6至20位之间</span></td></tr>")
		Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>确认密码：</td><td width='301' height='35' align='left' valign='middle'><input type='password' name='RePassWord' id='RePassWord'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr>")
		Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>性别：</td><td width='301' height='35' align='left' valign='middle'><input type='radio' name='sex' id='sex' value='男' checked='checked' width='12' height='12'/>男&nbsp;&nbsp;&nbsp;&nbsp;<input type='radio' name='sex' id='sex' value='女' width='20' height='20'/>女</td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr>")
		Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>详细地址：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='Address' id='Address' value='"&Request("Address")&"'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr>")
		Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>联系电话：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='TelPhone' id='TelPhone' value='"&Request("TelPhone")&"'/></td><td width='203' height='35' align='left' valign='middle'>&nbsp;</td></tr>")
		Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>手机：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='CellPhone' id='CellPhone' value='"&Request("CellPhone")&"'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr>")
		Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>验证码：</td><td width='301' height='35' align='left' valign='middle'>")
		Response.Write("<table width='200' border='0' cellspacing='0' cellpadding='0'><tr><td width='70'><input type='text' name='Code' id='Code'/></td><td><img src=""/Admin/code.asp"" alt=""验证码"" onclick=""this.src=this.src+'?'+Math.random();"" style='CURSOR:pointer;'></td></tr></table>")
		Response.Write("</td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*必填</span></td></tr>")
	else
		if CAndE = 1 then
			Response.Write("<tr>")
			Response.Write("<td width='116' height='35' align='right' class='td_font'>UserName：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='userName' id='userName' value='"&Request("memberNum")&"'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr><tr>")
			Response.Write("<td width='116' height='35' align='right' class='td_font'>PassWord：</td><td width='301' height='35' align='left' valign='middle'><input type='password' name='passWord' id='passWord' /></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required,Password length should be between 6-20</span></td></tr>")
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>RePassWord：</td><td width='301' height='35' align='left' valign='middle'><input type='password' name='RePassWord' id='RePassWord'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr>")
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>Gender：</td><td width='301' height='35' align='left' valign='middle'><input type='radio' name='sex' id='sex' value='男' checked='checked' width='12' height='12'/>male&nbsp;&nbsp;&nbsp;&nbsp;<input type='radio' name='sex' id='sex' value='女' width='20' height='20'/>Female</td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr>")
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>Full address：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='Address' id='Address' value='"&Request("Address")&"'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr>")
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>Telephone：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='TelPhone' id='TelPhone' value='"&Request("TelPhone")&"'/></td><td width='203' height='35' align='left' valign='middle'>&nbsp;</td></tr>")
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>Mobile：</td><td width='301' height='35' align='left' valign='middle'><input type='text' name='CellPhone' id='CellPhone' value='"&Request("CellPhone")&"'/></td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr>")
			Response.Write("<tr><td width='116' height='35' align='right' class='td_font'>CheckCode：</td><td width='301' height='35' align='left' valign='middle'>")
			Response.Write("<table width='200' border='0' cellspacing='0' cellpadding='0'><tr><td width='70'><input type='text' name='Code' id='Code'/></td><td><img src=""../Admin/code.asp"" alt=""CheckCode"" onclick=""this.src=this.src+'?'+Math.random();"" style='CURSOR:pointer;'></td></tr></table>")
			Response.Write("</td><td width='203' height='35' align='left' valign='middle'><span class='STYLE1'>*Required</span></td></tr>")
		end if
	end if
    Response.Write("<tr><td height='30' colspan='3' align='left' valign='middle' style='padding-top:10px;'><table width='500' height='30' border='0' cellpadding='0' cellspacing='0'><tr><td align='right' valign='middle' style='padding-right:5px;'><input name='submit' type='submit' class='loginbtn' value=''/></td><td align='left' valign='middle' style='padding-left:5px;'><input name='submit' type='reset' class='ReSet' value=''/></td></tr></table></td></tr></table>")
Response.Write("</form>")
End Function

'**************************************************
'函数名：PictruePages
'作  用：图片上一张、下一张,带图片的说明内容。
'参  数：Captions,true表示有图片说明，false表示无图片说明
'返回值：字符串
'**************************************************
Function PictruePages(Strsql,TableName,Captions)
Dim Rs,Str
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By ID desc"
Rs.Open Sql,Conn,1,1
Response.Write("<table width='100%' border='0' align='left' valign='top' cellpadding='0' cellspacing='0'")
Response.Write(">")
Response.Write("<tr><td align='left' valign='top' style=' padding:0px 10px 0px 50px;'>")
If rs.eof or len(Trim(Rs("NavPicture")))=0 then
Response.Write("<font color='#FF0000'>暂无图片</font>")
Else
	Response.Write("<img src='"&Rs("NavPicture")&"' width='148' height='182' style='float:left; padding-right:12px; padding-bottom:12px;'/>")
End if
Response.Write("</td><td align='left' valign='top' style='font-size:14px; padding-right:40px;'>")
if Captions = "true" then
	if len(Trim(Rs("NavContent")))>0 then
		Response.Write(Rs("NavContent"))
	else
		Response.Write("暂无图片说明")
	end if
end if
Response.Write("</td></tr></table>")
Rs.MoveNext
Rs.Close
Set Rs=Nothing
End Function

'**************************************************
'函数名：PictruePages2
'作  用：图片上一张、下一张,带图片的说明内容。
'参  数：Captions,true表示有图片说明，false表示无图片说明
'返回值：字符串
'**************************************************
Function PictruePages2(Strsql,TableName,Captions,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".t_f_bg{ background:url(../../../../../Admin/images/t_p_f.jpg) no-repeat 15px; center; padding-left:30px; text-align:left;}")
Response.Write("</style>")
Dim Rs,Str
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From "&TableName&" "&Strsql&" Order By ID desc"
Rs.Open Sql,Conn,1,1
Response.Write("<table width='100%' border='0' align='left' valign='top' cellpadding='0' cellspacing='0'")
Response.Write(">")
Response.Write("<tr><td align='left' valign='top' style=' padding:0px 10px 0px 50px;'>")
If rs.eof or len(Trim(Rs("NavPicture")))=0 then
if CAndE = 0 then
Response.Write("<font color='#FF0000'>暂无图片</font>")
else
	if CAndE = 1 then
		Response.Write("<font color='#FF0000'>No Photo</font>")
	end if
end if
Else
Response.Write("<table width='172' height='224' border='0' cellspacing='0' cellpadding='0'><tr>")
Response.Write("<td height='200' align='center' valign='middle' bgColor='#F6F6F6' style='border-left:1px solid #E2E2E2;border-right:1px solid #E2E2E2;border-top:1px solid #E2E2E2;'><img src='"&Rs("NavPicture")&"' width='150' height='190' style=' border:1px solid #DEDEDE;' /></td>")
Response.Write("</tr><tr><td height='24' class='t_f_bg' style='border-left:1px solid #E2E2E2;border-right:1px solid #E2E2E2;border-bottom:1px solid #E2E2E2;background-color:#f6f6f6;'>")
if CAndE = 0 then
Response.Write(Rs("NavTitle"))
else
	if CAndE = 1 then
	Response.Write(SubString(Rs("EnNavTitle"),10))
	end if
end if
Response.Write("</td>")
Response.Write("</tr></table>")
End if
Response.Write("</td><td align='left' valign='top' style='font-size:14px; padding-right:40px;'>")
if Captions = "true" then
	if CAndE = 0 then
		if len(Trim(Rs("NavContent")))>0 then
			Response.Write(Rs("NavContent"))
		else
			Response.Write("暂无图片说明")
		end if
	else
		if CAndE = 1 then
			if len(Trim(Rs("EnNavContent")))>0 then
				Response.Write(Rs("EnNavContent"))
			else
				Response.Write("No caption")
			end if
		end if
	end if
end if
Response.Write("</td></tr></table>")
Rs.MoveNext
Rs.Close
Set Rs=Nothing
End Function

'************************************************** 
'函数名：PicSwitch1 
'作 用：图片切换，右下角没有显示图片张数
'参 数：
'返回值： 
'************************************************** 
Function PicSwitch1(SqlWhere,TableName,PicWidth,PicHeight,url)
Set Rs2=Server.CreateObject("Adodb.Recordset")
Sql2="select * from ["&TableName&"]  "&SqlWhere&"  order by NavOrder asc"
Rs2.open Sql2,Conn,1,1
if not Rs2.eof then
j=(Rs2.Recordcount-2)
Response.Write("<script type='text/javascript' src='../Control/jquery.min.js'></script>")
Response.Write("<script type='text/javascript' src='../../Admin/Common/PicSwitch.js'></script>")
Response.Write("<script type='text/javascript'>")
Response.Write("function auto(){")
Response.Write("_c = _c >")
Response.Write(j)
Response.Write("? 0 : _c + 1;")
Response.Write("change(_c);}")
Response.Write("</script>")
Response.Write("<div id='pic'>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from ["&TableName&"]  "&SqlWhere&"  order by NavOrder asc"
Rs.open Sql,Conn,1,1
i=0
Do While Not Rs.Eof And i <j+2
if len(Trim(url))>0 then
if len(Trim(Rs("TeamID")))>0 then
Response.Write("<a href="""&url&"?ID="&Rs("TeamID")&""" target='_blank'>")
end if
end if
Response.Write("<img  alt='' src='"&Rs("NavPicture")&"' width='"&PicWidth&"' height='"&PicHeight&"'>")
if len(Trim(url))>0 then
if len(Trim(Rs("TeamID")))>0 then
Response.Write("</a>")
end if
end if
i=i+1
Rs.MoveNext
Loop
Rs.Close
Set Rs=Nothing
Response.Write("</div>")
end if
Rs2.Close
Set Rs2=Nothing
End Function

'************************************************** 
'函数名：PicSwitch2 
'作 用：图片切换，右下角只显示图片张数
'参 数：
'返回值： 
'************************************************** 
Function PicSwitch2(SqlWhere,TableName,PicWidth,PicHeight)
Response.Write("<table width='"&PicWidth&"' height='"&PicHeight&"' border='0' cellpadding='0' cellspacing='0'>")
Response.Write("<td>")
Response.Write("<script type=""text/javascript"">")
'flash尺寸
Response.Write("var focus_width="&PicWidth&";")
Response.Write("var focus_height="&PicHeight&";")
Response.Write("var swf_height = focus_height;")
Response.Write("var imgUrl=new Array();")
Set Rs=Server.CreateObject("Adodb.Recordset")
  Sql="select * from ["&TableName&"] "&SqlWhere&" order by NavOrder asc"
Rs.open Sql,Conn,1,1
i=1
Do while Not Rs.Eof
Response.Write("imgUrl["&i&"]="""&Rs("NavPicture")&""";")
i=i+1
Rs.MoveNext
Loop
Rs.Close
Set Rs=Nothing
'可编辑内容结束
Response.Write("var pics="""";")
Response.Write("for(var i=1; i<imgUrl.length; i++){pics=pics+(""|""+imgUrl[i]);}")
Response.Write("pics=pics.substring(1);")
Response.Write("document.write('<object classid=""clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"" codebase=""http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"" width=""'+ focus_width +'"" height=""'+ swf_height +'"">')")
Response.Write("document.write('<param name=""allowScriptAccess"" value=""sameDomain""><param name=""movie"" value=""Flash/focus2.swf""><param name=""quality"" value=""high""><param name=""bgcolor"" value=""#ffffff"">')")
Response.Write("document.write('<param name=""menu"" value=""false""><param name=wmode value=""opaque"">')")
Response.Write("document.write('<param name=""FlashVars"" value=""pics='+pics+'&borderwidth='+focus_width+'&borderheight='+focus_height+'"">')")
Response.Write("document.write('</object>')</script>")
Response.Write("<object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"" width=""1"" height=""1"" title=""1"">")
Response.Write("<param name=""movie"" value=""Flash/focus2.swf"" />")
Response.Write("<param name=""quality"" value=""high"" />")
Response.Write("<embed src=""Flash/focus2.swf"" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash"" width=""1"" height=""1""></embed>")
Response.Write("</object>")
Response.Write("</td></tr></table>")
End Function

'************************************************** 
'函数名：FSOFileRead 
'作 用：向文本文件写入内容
'参 数：blnAppend ----为true表示追加，否则为false 
'返回值：文件内容 
'************************************************** 
Sub Write2File(strContent)
whichfile=server.mappath("/Admin/Common/Filter.txt")
Set fso = CreateObject("Scripting.FileSystemObject")
Set MyFile = fso.CreateTextFile(whichfile,True)
MyFile.WriteLine(strContent)
MyFile.close
set fso=nothing
End Sub


'************************************************** 
'函数名：FSOFileRead 
'作 用：使用FSO读取文件内容的函数 
'参 数：filename ----文件名称 
'返回值：文件内容 
'************************************************** 
function FSOFileRead(filePath) 
Dim objFSO,objCountFile,FiletempData 
Set objFSO = Server.CreateObject("Scripting.FileSystemObject") 
Set objCountFile = objFSO.OpenTextFile(Server.MapPath(filePath),1,True) 
FSOFileRead = objCountFile.ReadAll
objCountFile.Close 
Set objCountFile=Nothing 
Set objFSO = Nothing 
End Function

'************************************************** 
'函数名：FSOlinedit 
'作 用：使用FSO读取文件某一行的函数 
'参 数：filename ----文件名称 
' lineNum ----行数 
'返回值：文件该行内容 
'************************************************** 
function FSOlinedit(filename,lineNum) 
if linenum < 1 then exit function 
dim fso,f,temparray,tempcnt 
set fso = server.CreateObject("scripting.filesystemobject") 
if not fso.fileExists(server.mappath(filename)) then exit function 
set f = fso.opentextfile(server.mappath(filename),1) 
if not f.AtEndofStream then 
tempcnt = f.readall 
f.close 
set f = nothing 
temparray = split(tempcnt,chr(13)&chr(10)) 
if lineNum>ubound(temparray)+1 then 
exit function 
else 
FSOlinedit = temparray(lineNum-1) 
end if 
end if 
end function

'************************************************** 
'函数名：FSOlinewrite 
'作 用：使用FSO写文件某一行的函数 
'参 数：filename ----文件名称 
' lineNum ----行数 
' Linecontent ----内容 
'返回值：无 
'************************************************** 
function FSOlinewrite(filename,lineNum,Linecontent) 
if linenum < 1 then exit function 
dim fso,f,temparray,tempCnt 
set fso = server.CreateObject("scripting.filesystemobject") 
if not fso.fileExists(server.mappath(filename)) then exit function 
set f = fso.opentextfile(server.mappath(filename),1) 
if not f.AtEndofStream then 
tempcnt = f.readall 
f.close 
temparray = split(tempcnt,chr(13)&chr(10)) 
if lineNum>ubound(temparray)+1 then 
exit function 
else 
temparray(lineNum-1) = lineContent 
end if 
tempcnt = join(temparray,chr(13)&chr(10)) 
set f = fso.createtextfile(server.mappath(filename),true) 
f.write tempcnt 
end if 
f.close 
set f = nothing 
end function

Function ReportFileStatus(filespec) 
Dim fso, msg
Set fso = CreateObject("Scripting.FileSystemObject")
If (fso.FileExists(filespec)) Then
    msg = filespec & " 存在。"
Else
    msg = filespec & " 不存在。"
End If
ReportFileStatus = msg
End Function

'************************************************** 
'函数名：OnlySaveText 
'作 用：只过滤字符串,保存纯文本 
'参 数：strContent 字符串内容 
'返回值：过虑后的字符串 
'章宵 2011-7-8 16:37:50 修正空值传入产生的问题
'************************************************** 
Function OnlySaveText(strContent)
if	strContent <>"" then
dim re
Set re=new RegExp
re.IgnoreCase =true
re.Global=True
re.Pattern="(\<.[^\<]*\>)"
strContent=re.replace(strContent," ")
re.Pattern="(\<\/[^\<]*\>)"
strContent=re.replace(strContent," ")
strContent=replace(strContent,"&nbsp;","")
OnlySaveText=strContent
set re=nothing
end if
End Function

'************************************************** 
'函数名：GetClassName 
'作 用：获取类别（目前只适用二级）例:图标 类别名
'参 数：
'返回值：类别名
'************************************************** 
Function GetClassName(ParentID,TableName,LeftPic,LineHeight,CAndE)
Response.Write("<script type='text/javascript' src='Control/jquery.min.js'></script>")
Response.Write("<style type='text/css'>")
Response.Write(".l_ico{ width:12px; float:left; background:url(../../../../../../images/"&LeftPic&") no-repeat center; line-height:"&LineHeight&";}")
Response.Write(".r_title{ list-style-type:none; text-align:left; text-decoration:none; line-height:"&LineHeight&";}")
Response.Write("</style>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From ["&TableName&"] where NavParent="&ParentID&" Order By NavOrder asc"
Rs.Open Sql,Conn,1,1
i=0
Do While not Rs.eof
Set Rs2=Server.CreateObject("Adodb.RecordSet")
Sql2 = "Select * From ["&TableName&"] where NavParent In ("&Rs("ID")&") Order By ID asc"
Rs2.Open Sql2,Conn,1,1
Response.Write("<script type='text/javascript'>$(document).ready(function(){")
Response.Write("$(""a.sg"&i&""").click(function(event){")
Response.Write("event.preventDefault();")
Response.Write("$(""div.sg"&i&".in"").removeClass(""in"");")
Response.Write("$(""div.in"").hide(""slow"");")
Response.Write("$(""div.sg"&i&""").slideToggle(""slow"");")
Response.Write("$(""div.sg"&i&""").addClass(""in"");")
Response.Write("});});</script>")
Response.Write("<div><div style='width:100%;'><ul><li class='l_ico'>&nbsp;</li>")
if Rs2.Recordcount>0 then
if CAndE = 0 then
Response.Write("<li class='r_title'> <a href='#' class='sg"&i&"'>"&Rs("NavTitle")&"</a> </li>")
else
Response.Write("<li class='r_title'> <a href='#' class='sg"&i&"'>"&Rs("EnNavTitle")&"</a> </li>")
end if
else
if CAndE = 0 then
Response.Write("<li class='r_title'> <a href='Products.asp?ClassID="&Rs("ID")&"'>"&Rs("NavTitle")&"</a> </li>")
else
Response.Write("<li class='r_title'> <a href='Products.asp?ClassID="&Rs("ID")&"'>"&Rs("EnNavTitle")&"</a> </li>")
end if
end if
Response.Write("</ul></div>")
Do While not Rs2.eof
Response.Write("<div class='sg"&i&"' style='display:none; padding-left:12px;'><ul><li class='l_ico'>&nbsp;</li>")
if CAndE = 0 then
Response.Write("<li class='r_title'> <a href='Products.asp?ClassID="&Rs2("ID")&"'>"&Rs2("NavTitle")&"</a> </li></ul></div>")
else
Response.Write("<li class='r_title'> <a href='Products.asp?ClassID="&Rs2("ID")&"'>"&Rs2("NavTitle")&"</a> </li></ul></div>")
end if
Rs2.MoveNext
Loop
Response.Write("</div>")
i=i+1
Rs.MoveNext
Loop
Rs.close
Set Rs=Nothing
Rs2.close
Set Rs2=Nothing
End Function

'**************************************************
'函数名：DelJpgFile
'作  用：根据图片路径删除UploadFiel文件中的内容
'参  数：ID------选中的ID
'参  数：Path------要删除文件的路径
'返回值：模板文件内容
'**************************************************
Function DelJpgFile(Path)
Dim objFSO '声明一个名称为 objFSO 的变量以存放对象实例 
Set objFSO = Server.CreateObject("Scripting.FileSystemObject") 
If Path<>"" Then
	If objFSO.FileExists(Server.MapPath(Path)) Then
	objFSO.DeleteFile Server.MapPath(Path),True
	End If
End if
Set objFSO = Nothing '释放 FileSystemObject 对象实例内存空间
End Function

'**************************************************
'函数名：MoveShowBPic
'作  用：鼠标移至图片上显示大图
'参  数：SqlWhere----sql条件字符串
'参  数：TableName----数据表名
'参  数：url单击图片链接地址
'参  数：CAndE-------0表示中文,1表示英文
'参  数：Rows--------图片行数
'参  数：Columns-----数据列数
'返回值：字符串
'**************************************************
Function MoveShowBPic(SqlWhere,TableName,url,CAndE,Rows,Columns)
Response.Write("<style type='text/css'>")
Response.Write(".trans_msg{	filter:alpha(opacity=100,enabled=1) revealTrans(duration=.2,transition=1) blendtrans(duration=.2);}")
Response.Write("</style>")
Response.Write("<table border='0' cellspacing='0' cellpadding='0'><tr><td>")
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From " & TableName & SqlWhere &" order by ShopOrder asc"
Rs.Open Sql,Conn,1,1
i=0
'编辑区域开始
Do While not Rs.eof
Response.Write("<tr>")
Do While not Rs.eof
Response.Write("<td style='padding:0px 8px;'>")
Response.Write("<table width='120' height='110' border='0' cellspacing='0' cellpadding='0'>")
Response.Write("<tr>")
Response.Write("<td><a href='"&url&"?ID="&Rs("ID")&"' target='_blank'><img src="""&Rs("ShopBPic")&""" width='120' height='110' onmouseover=""toolTip('<img src="&Rs("ShopBPic")&" />')"" onmouseout=""toolTip()""/></a></td>")
Response.Write("</tr>")
Response.Write("<tr>")
if CAndE = 0 then
Response.Write("<td align='center' valign='middle' height='30'>"&Rs("ShopName")&"</td>")
else
Response.Write("<td align='center' valign='middle' height='30'>"&Rs("EnShopName")&"</td>")
end if
Response.Write("</tr>")
Response.Write("</table>")
Response.Write("</td>")
Rs.MoveNext
i=i+1
if i mod Columns = 0 then
Exit Do
end if
Loop
Response.Write("</tr>")
if i mod Rows*Columns =0 then
Exit Do
end if
Loop
'编辑区域结束
Rs.close
Set Rs=Nothing
Response.Write("</td></tr></table>")
Response.Write("<script type='text/javascript' src='Control/MouseMoveShowBigPic.js'></script>")
End Function

'**************************************************
'函数名：SubString
'作  用：截取指定长度的字符串
'返回值：字符串
'**************************************************
Function SubString(str,length)
FilterStr=str
if len(Trim(FilterStr))>length then
SubString=left(Trim(FilterStr),length)&"..."
else
SubString=FilterStr
end if
End Function

'**************************************************
'函数名：GetPageName
'作  用：获取页面名称
'返回值：字符串
'**************************************************
Function GetPageName(ClassID)
if ClassID="1" then
GetPageName="TeacherStyle"
end if
if ClassID="3" or ClassID="5" then
GetPageName="About"
end if
if ClassID="4" then
GetPageName="Honors"
end if
if ClassID="9" then
GetPageName="Business"
end if
End Function

'**************************************************
'函数名：GetPageList
'作  用：获取单页列表,三列(图片、标题、时间)
'返回值：字符串
'**************************************************
Function GetPageList(SqlWhere,TableName,PageSize,url,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".float_left{ float:left; height:36px; border-bottom:1px dashed #B2B2B2; text-align:left; vertical-align:middle; line-height:36px;}")
Response.Write(".pagelist_l{ background:url(../../../../Admin/images/point3.jpg) no-repeat 0px 12px; width:3%;}")
Response.Write(".pagelist_m{ width:85%;}")
Response.Write(".pagelist_r{ width:10%; text-align:center;}")
Response.Write("</style>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from ["&TableName&"] "&SqlWhere
Rs.open Sql,Conn,1,1
i=0
Page=ReplaceBadChar(Trim(Request("Page")))                                                       
Rs.PageSize = PageSize               
Total=Rs.RecordCount               
PGNum=Rs.PageCount               
If Page="" Or IsNumeric(Page)=false Then Page=1               
If GetSafeInt(Page) > PGNum Then Page=PGNum               
If PGNum>0 Then Rs.AbsolutePage=Page 
Response.Write("<div><ul>")
Do While not Rs.eof and i<PageSize
Response.Write("<li class='float_left pagelist_l'>&nbsp;</li>")
if instr(Trim(url),".asp")>0 then
Response.Write("<li class='float_left pagelist_m'><a href='"&url&"?ID="&Rs("ID")&"&ClassID="&Rs("ClassID")&"' target='_blank'>")
if CAndE = 0 then
Response.Write(SubString(Trim(Rs("NavTitle")),30))
else
	if CAndE = 1 then
		Response.Write(SubString(Trim(Rs("EnNavTitle")),60))
	end if
end if
Response.Write("</a></li>")
else
Response.Write("<li class='float_left pagelist_m'>")
if CAndE = 0 then
Response.Write(SubString(Trim(Rs("NavTitle")),30))
else
	if CAndE = 1 then
		Response.Write(SubString(Trim(Rs("EnNavTitle")),60))
	end if
end if
Response.Write("</li>")
end if
Response.Write("<li class='float_left pagelist_r'>"&ConvertDate(Rs("PostTime"))&"</li>")
i=i+1
Rs.MoveNext
Loop
Response.Write("</ul></div>")
Rs.close
Set Rs=Nothing
End Function

'**************************************************
'函数名：GetPageList2
'作  用：获取单页列表,一列（序号、标题）
'返回值：字符串
'**************************************************
Function GetPageList2(SqlWhere,TableName,CAndE)
Response.Write("<style type='text/css'>")
Response.Write(".list_f ,.list_f a.list_f a:link,.list_f a:visited{background:url(../../../../../Admin/images/bus_list_bg.jpg) repeat-x left center; border:1px solid #E0E0E0; height:27px;text-align:left; vertical-align:middle; line-height:27px; padding:0px 0px 0px 10px; margin:6px 0px; list-style-type:none;}")
Response.Write(".list_f a:hover{}")
Response.Write("</style>")
Response.Write("<div><ul>")
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select * from ["&TableName&"] "&SqlWhere&" order by NavOrder asc"
Rs.open Sql,Conn,1,1
i=0
if not Rs.eof then
Do While not Rs.eof
i=i+1
Response.Write("<li class='list_f'>")
if CAndE = 0 then
Response.Write("<font style='font-weight:bold; color:#C0121A;'>"&i&"、</font>"&Rs("NavTitle")&"；")
else
	if CAndE = 1 then
	Response.Write("<font style='font-weight:bold; color:#C0121A;'>"&i&"、</font>"&Rs("EnNavTitle")&"；")
	end if
end if
Response.Write("</li>")
Rs.MoveNext
Loop
end if
Rs.close
Set Rs=Nothing
Response.Write("</ul></div>")
End Function

'**************************************************
'函数名：GetHomeAbout
'作  用：获取首页简介（文字围绕图片）
'返回值：字符串
'**************************************************
Function GetHomeAbout(SqlWhere,TableName,picWidth,picHeight,length,CAndE)
Set Rs=Server.CreateObject("Adodb.Recordset")
Sql="select top 1 * from ["&TableName&"] "&SqlWhere&""
Rs.open Sql,Conn,1,1
if not Rs.eof then
Response.Write("<img src='"&Rs("PicAddress")&"' width='"&picWidth&"' height='"&picHeight&"' style='border:1px solid #CED4DE; padding:2px; float:left; margin:0px 5px 0px 0px;' />")
if CAndE =0 then
Response.Write(SubString(OnlySaveText(Trim(Rs("NavContent"))),length))
end if
if CAndE = 1 then
Response.Write(SubString(OnlySaveText(Trim(Rs("EnNavContent"))),length))
end if
end if
Rs.close
Set Rs=Nothing
End Function
%>


<%
Function Getindextxt(classid)
response.Write("<table width=""305"" border=""0"" cellspacing=""0"" cellpadding=""0"">")
                   Set Rs=Server.CreateObject("Adodb.RecordSet")
                            Sql="Select top 8 * From [NewsInfo] where classid="&classid&"   Order By NewsOrder desc, PostTime desc"
                            Rs.Open Sql,Conn,1,1
							 i=1
                            Do While Not Rs.Eof
response.Write(" <tr><td width=""239"" height=""28"" class=""index_td8 index_td9""><a href=""News_show.asp?id="&rs("id")&"&classid="&rs("classid")&"""  title="""&rs("NewsTitle")&""" target=""_blank""  >")

If Len(Rs("NewsTitle"))>17 Then
Response.Write(Left(Rs("NewsTitle"),17)&"...")
Else
Response.Write(Rs("NewsTitle"))
End if
response.Write("</a></td>")
 response.Write(" <td width=""66"" align=""center"" class=""index_td9"" style=""color:#cab47e"">"&Right(Year(Rs("PostTime")),4)&"-"&Right("0"&Month(Rs("PostTime")),2)&"-"&Right("0"&Day(Rs("PostTime")),2)&"</td></tr>")
            
                           i=i+1
						    Rs.MoveNext
                            Loop
                            Rs.Close
                            Set Rs=Nothing
                           
response.Write("</table>")
        end Function        

%>

<%
Function Getindexsqltxt(classid)
response.Write("<table width=""305"" border=""0"" cellspacing=""0"" cellpadding=""0"">")
                   Set Rs=Server.CreateObject("Adodb.RecordSet")
                            Sql="Select top 8 * From [dnt_posts1] where fid="&classid&"  and  layer=0   Order By  postdatetime desc"
                            Rs.Open Sql,Connx,1,1
							 i=1
                            Do While Not Rs.Eof
response.Write(" <tr><td width=""239"" height=""28"" class=""index_td8 index_td9""><a href=""/bbs/showtopic-"&rs("tid")&".aspx""  title="""&rs("title")&""" target=""_blank""  >")

If Len(Rs("title"))>17 Then
Response.Write(Left(Rs("title"),17)&"...")
Else
Response.Write(Rs("title"))
End if
response.Write("</a></td>")
 response.Write(" <td width=""66"" align=""center"" class=""index_td9"" style=""color:#cab47e"">"&Right(Year(Rs("postdatetime")),4)&"-"&Right("0"&Month(Rs("postdatetime")),2)&"-"&Right("0"&Day(Rs("postdatetime")),2)&"</td></tr>")
            
                           i=i+1
						    Rs.MoveNext
                            Loop
                            Rs.Close
                            Set Rs=Nothing
                           
response.Write("</table>")
        end Function        

%>


<%
   '****************URL密码
     const BASE_64_MAP_INIT = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
     dim newline
     dim Base64EncMap(63)
     dim Base64DecMap(127)
     '初始化函数
     PUBLIC SUB initCodecs()
          ' 初始化变量
          newline = "<P>" & chr(13) & chr(10)
          dim max, idx
             max = len(BASE_64_MAP_INIT)
          for idx = 0 to max - 1
               Base64EncMap(idx) = mid(BASE_64_MAP_INIT, idx + 1, 1)
          next
          for idx = 0 to max - 1
               Base64DecMap(ASC(Base64EncMap(idx))) = idx
          next
     END SUB
     'Base64加密函数
     PUBLIC FUNCTION base64Encode(plain)
          if len(plain) = 0 then
               base64Encode = ""
               exit function
          end if
          dim ret, ndx, by3, first, second, third
          by3 = (len(plain) \ 3) * 3
          ndx = 1
          do while ndx <= by3
               first  = asc(mid(plain, ndx+0, 1))
               second = asc(mid(plain, ndx+1, 1))
               third  = asc(mid(plain, ndx+2, 1))
               ret = ret & Base64EncMap(  (first \ 4) AND 63 )
               ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) )
               ret = ret & Base64EncMap( ((second * 4) AND 60) + ((third \ 64) AND 3 ) )
               ret = ret & Base64EncMap( third AND 63)
               ndx = ndx + 3
          loop
          if by3 < len(plain) then
               first  = asc(mid(plain, ndx+0, 1))
               ret = ret & Base64EncMap(  (first \ 4) AND 63 )
               if (len(plain) MOD 3 ) = 2 then
                    second = asc(mid(plain, ndx+1, 1))
                    ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) )
                    ret = ret & Base64EncMap( ((second * 4) AND 60) )
               else
                    ret = ret & Base64EncMap( (first * 16) AND 48)
                    ret = ret '& "="
               end if
               ret = ret '& "="
          end if
          base64Encode = ret
     END FUNCTION
     'Base64解密函数
     PUBLIC FUNCTION base64Decode(scrambled)
          if len(scrambled) = 0 then
               base64Decode = ""
               exit function
          end if
          dim realLen
          realLen = len(scrambled)
          do while mid(scrambled, realLen, 1) = "="
               realLen = realLen - 1
          loop
          dim ret, ndx, by4, first, second, third, fourth
          ret = ""
          by4 = (realLen \ 4) * 4
          ndx = 1
          do while ndx <= by4
               first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1)))
               second = Base64DecMap(asc(mid(scrambled, ndx+1, 1)))
               third  = Base64DecMap(asc(mid(scrambled, ndx+2, 1)))
               fourth = Base64DecMap(asc(mid(scrambled, ndx+3, 1)))
               ret = ret & chr( ((first * 4) AND 255) +   ((second \ 16) AND 3))
               ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15))
               ret = ret & chr( ((third * 64) AND 255) +  (fourth AND 63))
               ndx = ndx + 4
          loop
          if ndx < realLen then
               first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1)))
               second = Base64DecMap(asc(mid(scrambled, ndx+1, 1)))
               ret = ret & chr( ((first * 4) AND 255) +   ((second \ 16) AND 3))
               if realLen MOD 4 = 3 then
                    third = Base64DecMap(asc(mid(scrambled,ndx+2,1)))
                    ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15))
               end if
          end if
          base64Decode = ret
     END FUNCTION
' 初始化
     call initCodecs
' 测试代码
'    dim inp, encode
'    inp = "1234567890"
'    encode = base64Encode(inp)
'    response.write "加密前为:" & inp & newline
'    response.write "加密后为:" & encode & newline
'    response.write "解密后为:" & base64Decode(encode) & newline

Function GetNewsTitle(ID,length)
	Set Rsts=Conn.Execute("Select NewsTitle From NewsInfo Where ID="&ID&"")
		If Len(Rsts("NewsTitle"))>length Then
		Str=Left(Rsts("NewsTitle"),length)&"..."
		Else
		Str=Rsts("NewsTitle")
		End If
		GetNewsTitle=Str
	Rsts.Close
	Set Rsts=Nothing
End Function

'**************************************************
'函数名：GteClassID
'作  用：获取当前类别ID
'参  数：ID------当前ID
'返回值：2
'**************************************************
Function GetClassID(ID,TablaName)
Dim Rsaa,Str,TName
TName = TablaName
Set Rsaa=Conn.Execute("Select ClassID From "&TName&" Where ID="&ID)
Str=Rsaa("ClassID")
Rsaa.Close
Set Rsaa=Nothing
GetClassID=Str
End Function

'**************************************************
'函数名：GetParentClassID
'作  用：获取当前类别的父集ClassID
'参  数：ClassID------当前ClassID
'返回值：2
'**************************************************
Function GetParentClassID(ClassID,TablaName)
Dim Rsaa,Str,TName
TName = TablaName
Set Rsaa=Conn.Execute("Select * From "&TName&" Where ID="&ClassID)
if(Rsaa("NavParent")<>0) then
Str=Rsaa("NavParent")
else
Str=ClassID
end if
Rsaa.Close
Set Rsaa=Nothing
GetParentClassID=Str
End Function

'清除所有回车，包括 \r\n  \r  \n
'****************************************
Function CleanEnter(strng)
Dim regEx ' 建立变量。
Set regEx = new RegExp ' 建立正则表达式。
regEx.Pattern = "\r\n|\r|\n" ' 设置模式。
regEx.Global=True
regEx.IgnoreCase = True ' 设置是否区分大小写。
CleanEnter = regEx.replace(strng, "") ' 执行搜索。
End Function 



%>
