<%
'=================================================================
'章宵 2011-7-15 13:59:42
'=================================================================
'ASP分页类
'=================================================================
Const BTN_First="<font face=""webdings"">9</font>" '定义第一页按钮显示样式
Const BTN_Prev="<font face=""webdings"">3</font>" '定义前一页按钮显示样式
Const BTN_Next="<font face=""webdings"">4</font>" '定义下一页按钮显示样式
Const BTN_Last="<font face=""webdings"">:</font>" '定义最后一页按钮显示样式
Const APC_Align="Center"     '定义分页信息对齐方式
Const APC_Width="100%"     '定义分页信息框大小
Class PageClass
Private APC_PageCount,APC_Conn,APC_Rs,APC_SQL,APC_PageSize,APC_SUrl,INT_CurPage,INT_TotalPage,INT_TotalRecord,STR_Url
'=================================================================
'PageSize:设置每页显示数量
'=================================================================
Public Property Let PageSize(INT_PageSize)
If IsNumeric(INT_PageSize) Then
APC_PageSize=CLng(INT_PageSize)
Else
STR_Error=STR_Error & "PageSize(每页显示数量)的参数不正确！"
ShowError()
End If
End Property
Public Property Get PageSize
If APC_PageSize="" or (Not(IsNumeric(APC_PageSize))) Then
PageSize=10
Else
PageSize=APC_PageSize
End If
End Property
'=================================================================
'GetRS:返回分页后的记录集
'=================================================================
Public Property Get GetRs()
Set APC_Rs=Server.createobject("adodb.recordset")
APC_Rs.PageSize=PageSize
APC_Rs.Open APC_SQL,APC_Conn,1,1
If Not(APC_Rs.eof and APC_RS.BOF) Then
If INT_CurPage>APC_RS.PageCount Then
   INT_CurPage=APC_RS.PageCount
End If
APC_Rs.AbsolutePage=INT_CurPage
End If
Set GetRs=APC_RS
End Property
'================================================================
'GetConn:得到数据库连接
'================================================================ 
Public Property Let GetConn(OBJ_Conn)
Set APC_Conn=OBJ_Conn
End Property
'================================================================
'GetSQL:得到查询语句
'================================================================
Public Property Let GetSQL(STR_Sql)
APC_SQL=STR_Sql
End Property

'==================================================================
'Class_Initialize:初始化当前页的值
'================================================================== 
Private Sub Class_Initialize
APC_PageSize=10 '设定分页的默认值为10
'========================
'以下过程获取当前面的值
'========================
If Request("page")="" Then
INT_CurPage=1
ElseIf Not(IsNumeric(Request("page"))) Then
INT_CurPage=1
ElseIf CInt(Trim(Request("page")))<1 Then
INT_CurPage=1
Else
INT_CurPage=CInt(Trim(Request("page")))
End If
End Sub
'====================================================================
'ShowPage:创建分页导航条，有首页、前一页、下一页、末页、还有数字导航
'====================================================================
Public Function ShowPage()
Dim STR_Tmp
APC_SUrl = GetUrl()
INT_TotalRecord=APC_RS.RecordCount
If INT_TotalRecord<=0 Then
	response.Write("数据添加中")
	Exit Function
End If
If INT_TotalRecord="" then
     INT_TotalPage=1
Else
	'章宵 2011-7-15 16:05:32 算法有错误
	'If INT_TotalRecord mod PageSize =0 Then
	'   INT_TotalPage = CLng(INT_TotalRecord / APC_PageSize * -1)*-1
	'Else
	'   INT_TotalPage = CLng(INT_TotalRecord / APC_PageSize * -1)*-1+1
	'End If
	INT_TotalPage = APC_RS.pagecount
End If
If INT_CurPage>INT_TotalPage Then
INT_CurPage=INT_TotalPage
End If

'==================================================================
'显示分页信息，各个模块根据自己要求更改显求位置
'==================================================================
STR_Tmp=STR_Tmp&ShowFirstPrv
STR_Tmp=STR_Tmp&ShowNumBtn
STR_Tmp=STR_Tmp&ShowNextLast
STR_Tmp=STR_Tmp&ShowPageInfo
ShowPage = STR_Tmp
End Function
'====================================================================
'ShowFirstPrv:显示首页、前一页
'====================================================================
Private Function ShowFirstPrv()
Dim STR_Tmp,INT_PrvPage
If INT_CurPage=1 Then
STR_Tmp=BTN_First&" "&BTN_Prev
Else
INT_PrvPage=INT_CurPage-1
STR_Tmp="<a href="""&APC_SUrl & "1" & """>" & BTN_First&"</a> <a href=""" & APC_SUrl & CStr(INT_PrvPage) & """>" & BTN_Prev&"</a>"
End If
ShowFirstPrv=STR_Tmp
End Function
'====================================================================
'ShowNextLast:显示下一页、末页
'====================================================================
Private Function ShowNextLast()
Dim STR_Tmp,INT_Nextpage
If INT_CurPage>=INT_TotalPage Then
STR_Tmp=BTN_Next & " " & BTN_Last
Else
INT_NextPage=INT_CurPage+1
STR_Tmp="<a href=""" & APC_SUrl & CStr(INT_nextpage) & """>" & BTN_Next&"</a> <a href="""& APC_SUrl & CStr(INT_TotalPage) & """>" & BTN_Last&"</a>"
End If
ShowNextLast=STR_Tmp
End Function
'====================================================================
'ShowNumBtn:显示数字导航
'====================================================================
Private Function ShowNumBtn()
Dim i,STR_Tmp,num
if INT_TotalPage>10 then
   num=10
else
   num=INT_TotalPage
end if
if INT_TotalPage<10 or INT_CurPage<10 then
	For i=1 to num
		if i=INT_CurPage then
			STR_Tmp=STR_Tmp & "<b>"&i&"</b> "
		else
			STR_Tmp=STR_Tmp & "<a href=""" & APC_SUrl & CStr(i) & """>"&i&"</a> "
		end if
	Next
elseif INT_CurPage+5>INT_TotalPage then
	For i=INT_CurPage-5 to INT_TotalPage
		if i=INT_CurPage then
			STR_Tmp=STR_Tmp & "<b>"&i&"</b> "
		else
			STR_Tmp=STR_Tmp & "<a href=""" & APC_SUrl & CStr(i) & """>"&i&"</a> "
		end if
	Next
else
	For i=INT_CurPage-5 to INT_CurPage+5
		if i=INT_CurPage then
			STR_Tmp=STR_Tmp & "<b>"&i&"</b> "
		else
			STR_Tmp=STR_Tmp & "<a href=""" & APC_SUrl & CStr(i) & """>"&i&"</a> "
		end if
	Next
end if
ShowNumBtn=STR_Tmp
End Function
'====================================================================
'ShowPageInfo:分页信息,根据要求自行修改
'====================================================================
Private Function ShowPageInfo()
Dim STR_Tmp
STR_Tmp=" 页次:"&INT_CurPage&"/"&INT_TotalPage&"页 共"&INT_TotalRecord&"条记录 "&APC_PageSize&"条/页"
ShowPageInfo=STR_Tmp
End Function
'==================================================================
'GetURL:得到当前的URL，根据URL参数不同，获取不同的结果
'==================================================================
Private Function GetURL()
Dim strurl,STR_Url,i,j,search_str,result_url
search_str="page="
strurl=Request.ServerVariables("URL")
Strurl=split(strurl,"/")
i=UBound(strurl,1)
STR_Url=strurl(i)'得到当前页文件名
STR_params=Trim(Request.ServerVariables("QUERY_STRING"))
If STR_params="" Then
result_url=STR_Url & "?page="
Else
If InstrRev(STR_params,search_str)=0 Then
   result_url=STR_Url & "?" & STR_params &"&page="
Else
   j=InstrRev(STR_params,search_str)-2
   If j=-1 Then
    result_url=STR_Url & "?page="
   Else
    STR_params=Left(STR_params,j)
    result_url=STR_Url & "?" & STR_params &"&page="
   End If
End If
End If
GetURL=result_url
End Function
'====================================================================
' 设置 Terminate 事件。
'====================================================================
Private Sub Class_Terminate 
APC_RS.close
Set APC_RS=nothing
End Sub
'====================================================================
'ShowError:错误提示
'====================================================================
Private Sub ShowError()
	If STR_Error <> "" Then
		Response.Write("" & STR_Error & "")
		Response.End
	End If
End Sub
End class
%>