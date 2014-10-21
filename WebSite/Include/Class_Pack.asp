<%
'Set Pack = New EBDiy_Pack
'Pack.Path = Server.MapPath("test.ebd")   路径
'
''***************打包******************
''Pack.Pack server.MapPath("FindWork")  打包
'
''***************解包****************
'Pack.UnPack server.MapPath("sss") 解包
'
'Set Pack = Nothing
Class EBDiy_Pack
	Private m_Dom, m_Path, FSO, m_RootPath, s_Dom, Fod, Node, Fi, FilePath, Node_FName, Node_Value, FF, FolderPath
	Public Property Let Path(ByVal vData)
		m_Path = vData
	End Property
	
	Private Sub Class_Initialize()
		Set m_Dom = Server.CreateObject("Microsoft.XMLDOM") 
		Set s_Dom = Server.CreateObject("Microsoft.XMLDOM")
		Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	End Sub
	Private Sub Class_Terminate()
		Set m_Dom = Nothing
		Set s_Dom = Nothing
		Set FSO = Nothing
	End Sub
	
	Public Function GetFolders()
		Dim DocEle, Folders, i, ReturnStr
		ReturnStr = "["
		m_Dom.load m_Path
		Set DocEle = m_Dom.documentElement
		Set Folders = m_Dom.getElementsByTagName("folder")
		For i = 0 To Folders.length - 1
			ReturnStr = ReturnStr & "{id:" & i & ",name:'" & replace(Folders(i).Text,"\","\\") & "'},"
		Next
		ReturnStr = left(ReturnStr, Len(ReturnStr) - 1)
		ReturnStr = ReturnStr & "]"
		Set Folders = Nothing
		Set DocEle = Nothing
		GetFolders = ReturnStr
	End Function
	
	Public Function GetFiles()
		Dim DocEle, Files, i, ReturnStr, CHD
		ReturnStr = "["
		m_Dom.load m_Path
		Set DocEle = m_Dom.documentElement
		Set Files = m_Dom.getElementsByTagName("file")
		For i = 0 To Files.length - 1
			Set CHD = Files(i).childNodes
			ReturnStr = ReturnStr & "{id:" & i & ",name:'" & replace(CHD(0).Text,"\","\\") & "'},"
		Next
		ReturnStr = left(ReturnStr, Len(ReturnStr) - 1)
		ReturnStr = ReturnStr & "]"
		Set Files = Nothing
		Set DocEle = Nothing
		GetFiles = ReturnStr
	End Function
	Public Function Pack(ByVal vPath)
		If Not FSO.FolderExists(vPath) Then
			Response.Write("未找到打包路径" & vPath & "<br />")
			Pack = False
			Exit Function
		End If
		s_Dom.loadXML "<?xml version=""1.0"" ?> <root/>"
		s_Dom.documentElement.setAttribute "xmlns:dt", "urn:schemas-microsoft-com:datatypes"
		m_RootPath = vPath
		CompactFolder vPath
		s_Dom.Save m_Path
		Response.Write("恭喜，打包完毕。保存到" & m_Path & " <br />")
		Pack = True
	End Function
	
	Public Function CompactFolder(ByVal vPath)
		vPath = vPath & "\"
		Set Fod = FSO.GetFolder(vPath)
		Set Node = s_Dom.createElement("folder")
		Node.Text = Mid(vPath, Len(m_RootPath) + 1)
		s_Dom.documentElement.appendChild Node
		If Fod.Files.Count > 0 Then
		   For Each Fi In Fod.Files
			FilePath = vPath & Fi.Name
			Response.Write("正在打包文件 " & FilePath & "<br />")
			Response.Flush()
			Set Node = s_Dom.createElement("file")
		        
			Set Node_FName = s_Dom.createElement("path")
			Node_FName.Text = Mid(FilePath, Len(m_RootPath) + 1)
			Node.appendChild Node_FName
		        
			Set Node_Value = s_Dom.createElement("value")
			Node_Value.dataType = "bin.base64"
			Node_Value.nodeTypedValue = LoadFile(FilePath)
			Node.appendChild Node_Value
		        
			s_Dom.documentElement.appendChild Node
		   Next
		End If

		If Fod.SubFolders.Count > 0 Then
		   For Each FF In Fod.SubFolders
			FolderPath = vPath & FF.Name
			Call CompactFolder(FolderPath)
		   Next
		End If
	End Function

	Public Function UnPack(ByVal SavePath)
		If Not FSO.FolderExists(SavePath) Then CreateFolder(SavePath)
		Dim DocEle
		Dim Folders
		Dim Files
		Dim i
		Dim CHD
		m_Dom.load m_Path
		Set DocEle = m_Dom.documentElement
		Set Folders = m_Dom.getElementsByTagName("folder")
		For i = 0 To Folders.length - 1
		    Response.Write("正在创建目录 " & SavePath & Folders(i).Text & "<br />")
		    Response.Flush()
		    CreateFolder SavePath & Folders(i).Text
		Next
		Set Files = m_Dom.getElementsByTagName("file")
		For i = 0 To Files.length - 1
		    Set CHD = Files(i).childNodes
		    Response.Write("正在解包 " & CHD(0).Text & "<br />")
		    Response.Flush()
		    SaveFile SavePath & CHD(0).Text, CHD(1).nodeTypedValue
		Next
		Response.Write("恭喜，解包完成!" & vbCrLf & "成功解包到:" & SavePath & "<br />")
		UnPack = True
	End Function
	
	Public Function LoadFile(ByVal FileName)
		Dim Stream
		Set Stream = Server.CreateObject("ADODB.Stream")
		Stream.Type = 1
		Stream.Mode = 3
		Stream.Open
		Stream.LoadFromFile FileName
		LoadFile = Stream.Read
		Stream.Close
		Set Stream = Nothing
	End Function 
	
	Public Function SaveFile(ByVal FileName, ByVal FileData)
		On Error Resume Next
		Dim Stream
		Set Stream = Server.CreateObject("ADODB.Stream")
		Stream.Type = 1
		Stream.Mode = 3
		Stream.Open
		Stream.Write FileData
		Stream.SaveToFile FileName, 2
		Stream.Close
		Set Stream = Nothing
	End Function


	Public Function CreateFolder(ByVal FolderPath)
		Dim FolderArray
		Dim i
		Dim DiskName
		Dim Created
		FolderPath = Replace(FolderPath, "/", "\")
		If Mid(FolderPath, Len(FolderPath), 1) = "\" Then FolderPath = Mid(FolderPath, 1, Len(FolderPath) - 1)
		FolderArray = Split(FolderPath, "\")
		DiskName = FolderArray(0)
		Created = DiskName
		For i = 1 To UBound(FolderArray)
			Created = Created & "\" & FolderArray(i)
			If Not FSO.FolderExists(Created) Then FSO.CreateFolder Created
		Next
	End Function
End Class
 %>