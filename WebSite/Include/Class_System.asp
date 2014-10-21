<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
Function GetFolder(Path)
Set Fso=Server.Createobject("Scripting.FileSystemObject")
dim CurFolder,folderPath,responseStr
CurFolder=trim(Path)
CurFolder=replace(CurFolder,"\","/")
If Left(CurFolder,1)<>"/" then
	Response.Write "&nbsp;&nbsp;找不到该文件目录。"
Else
	Dim i:i=0
	Dim j:j=0
	FolderPath= VRootDir & CurFolder
	FolderPath=Replace(FolderPath,"//","/")
	If Fso.Folderexists(Server.mappath(FolderPath)) Then
		Set Folder=Fso.Getfolder(Server.Mappath(FolderPath))

		If SubPath="" Then
		Response.Write("<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">")
		Response.Write("<tr>")
		
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Rs.CursorLocation = 1 
		Rs.CursorType = 1
		Rs.Fields.Append "FileName",200,255
		Rs.Fields.Append "FileDate",200,255
		Rs.open
		If Err.number <> 0 Then
			Response.Write(Err.Description)
			Response.End()
		End if
		For Each ChildFolder in Folder.Subfolders
			Rs.AddNew 
			Rs.Fields("FileName") = ChildFolder.Name 
			Rs.Fields("FileDate") = ChildFolder.DateLastModified
			Rs.Update 
		Next
		Rs.Sort = "FileName Desc"
		If Not (Rs.Eof Or Rs.Bof) Then
			Rs.MoveFirst
		End If
		Do While Not Rs.EOF
			i=i+1
			Response.Write("<td height=""30""><a href=""Sys_FileManager.asp?Element="&Element&"&SubPath="&Rs("FileName")&"""><img src=""Images/Filetype/folder.gif"" align=""absmiddle"" style=""border:0px"">&nbsp;"&Rs("FileName")&"</a></td>")
			If i Mod 4=0 Then
				Response.Write("</tr><tr>")
			End if
		Rs.MoveNext
		Loop
		Rs.close
		Set Rs=Nothing
		Response.Write("</tr>")
		Response.Write("<Table>")
		End If
		Response.Write("<div style=""width:350px;height:1px; line-height:1px;border-bottom:solid 1px #c5cdd4""></div>")	
		Response.Write("<table width=""98%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">")
		Response.Write("<tr>")
		If Right(Path,1)<>"/" Then
			Path=Path&"/"
		End If
		
		Set Rs = Server.CreateObject("ADODB.Recordset")
		Rs.CursorLocation = 1 
		Rs.CursorType = 1
		Rs.Fields.Append "FileName",200,255
		Rs.Fields.Append "FileDate",200,255
		Rs.open
		If Err.number <> 0 Then
			Response.Write(Err.Description)
			Response.End()
		End if
		
		For Each Item In Folder.Files
		TemFile=LCase(right(item.Name,3))
		If TemFile="jpg" Or  TemFile="gif" Or TemFile="jpeg" Or TemFile="png" Or TemFile="bmp" Then
		Rs.AddNew 
		Rs.Fields("FileName") = item.Name 
		Rs.Fields("FileDate") = item.dateLastModified
		Rs.Update
		End If 
		Next 
		Rs.Sort = "FileDate Desc" 
		If Not (Rs.Eof Or Rs.Bof) Then
			Rs.MoveFirst
		End If
		
		Do While Not Rs.EOF
			j=j+1
			Response.Write("<td height=""30"" style=""table-layout: fixed;WORD-BREAK: break-all; WORD-WRAP: break-word"" valign=""top"" align=""center""><a href=""javascript:GetValue('"&Path&Rs("filename")&"')""><img src="""&Path&"/"&Rs("filename")&""" align=""absmiddle"" width=""150"" height=""150"" style=""border:solid 1px #CCCCCC;""><br/>"&Rs("filename")&"</a></td>")
			If j Mod 2=0 Then
				Response.Write("</tr><tr>")
			End if
		Rs.MoveNext
		Loop
		Rs.close
		Set Rs=Nothing
		
		If j=0 Then
		Response.Write "该文件目录下不存在任何文件。"
		End If
		Response.Write("</tr>")
		Response.Write("<Table>")
	Else
		Response.Write("&nbsp;&nbsp;找不到该文件目录。")
	End If
End If
End Function
%>