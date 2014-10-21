<% 
'*************************** 
'名称：fso操作类
'这个类主要的功能： 
'1,创建删除文件夹 
'2,获取某个文件夹里的文件夹名称和个数 
'3,获取某个文件夹里的文件名称和个数 
'4,检查某个文件夹是否存在 
'5,检查某个文件是否存在 
'6,删除文件 
'7,读取某个文件的内容 
'7,创建一个文件，并把内容写到这个文件里面 
'
'功能就分两个，一个是文件操作，一个是文件夹操作。 
'*************************** 
Class Class_FSO 
    Private fso'//对象 
    Public fsoObj'//公共接口对象 

    '//初始化,构造函数 
    Private Sub Class_Initialize 
        Set fso=CreateObject("Scripting.FileSystemObject") 
        Set FsoObj=fso 
    End Sub 
    '//结束，释构函数 
    Private Sub Class_Terminate 
        Set fso=Nothing 
        Set fsoObj=Nothing 
    End Sub 


    '====================文件操作开始========================= 
    Function IsFileExists(ByVal FileDir) 
    '判断文件是否存在，存在则返回True,否则返回False 
    '参数FileDir为文件的绝对路径 
        If fso.FileExists(FileDir) Then 
            IsFileExists=True 
        Else 
            IsFileExists=False 
        End If 
    End Function 
    Function GetFileText(ByVal FileDir) 
    '读取文件内容，存在则返回文件的内容，否则返回False 
    '参数FileDir为文件的绝对路径 
        If IsFileExists(FileDir) Then 
            Dim F 
            Set F=fso.OpenTextFile(FileDir) 
            GetFileText=F.ReadAll 
            Set F=Nothing 
        Else 
            GetFileText=False 
        End If 
    End Function 
    Function CreateFile(ByVal FileDir,ByVal FileContent) 
    '创建一个文件并写入内容 
    '操作成功返回True,否则返回False 
        If IsFileExists(FileDir) Then 
            CreateFile=False 
            Exit Function 
        Else 
            Dim F 
            Set F=fso.CreateTextFile(FileDir) 
            F.Write FileContent 
            CreateFile=True 
            F.Close 
        End If 
    End Function 
    Function DelFile(ByVal FileDir) 
        '删除一个文件，成功返回True，否则返回False 
        '参数FileDir为文件的绝对路径 
        If IsFileExists(FileDir) Then 
            fso.DeleteFile(FileDir) 
            DelFile=True 
        Else 
            DelFile=False 
        End If 
    End Function 
	
Public Function getFileInfo(FileName)
    Dim File, FileInfo(10)
    If IsFileExists(FileName) Then
        Set File = fso.GetFile(FileName)
        FileInfo(0)=File.Size
        If FileInfo(0)>1024 Then
          FileInfo(0)=Round(FileInfo(0) / 1024,2)
        If FileInfo(0) > 1024 Then
          FileInfo(0)=Round(FileInfo(0) / 1024,2)
          FileInfo(0)= FileInfo(0) & " MB"
        Else
         FileInfo(0)= FileInfo(0) & " KB"
        End If
        Else
          FileInfo(0)= FileInfo(0) & " Byte"
        End If
        FileInfo(1) = LCase(Right(FileName, 4))
        FileInfo(2) = File.DateCreated
        FileInfo(3) = File.Type
        FileInfo(4) = File.DateLastModified
        FileInfo(5) = File.Path
        FileInfo(6) = "" 'File.ShortPath 部分服务器不支持
        FileInfo(7) = File.Name
        FileInfo(8) = "" 'File.ShortName 部分服务器不支持
        FileInfo(9) = fso.getExtensionName(FileName)
        FileInfo(10) = File.DateLastModified
    End If
    getFileInfo = FileInfo
End Function

Public Function getFileIcons(Str)
    Dim FileIcon
	Str = Split(Str, " ")(0)
	If Lcase(Str) = "jpeg" Then Str = "jpg"
	If Str = "层叠样式表文档" Then Str = "css"
	If Lcase(Str) = "jscript" Then Str = "js"
If FileExist("images/file/"&Str&".gif") Then FileIcon = Str Else FileIcon = "unknow"
    getFileIcons = "<img border=""0"" src=""images/file/"&FileIcon&".gif"" style=""margin:4px 3px -3px 0px""/>"
End Function
    '====================文件操作结束========================= 

    '====================文件夹操作开始======================== 
    Function IsFolderExists(ByVal FolderDir) 
    '判断文件夹是否存在，存在则返回True,否则返回False 
    '参数FolderDir为文件的绝对路径 
        If fso.FolderExists(FolderDir) Then 
            IsFolderExists=True 
        Else 
            IsFolderExists=False 
        End If 
    End Function 
    Sub CreateFolderA(ByVal ParentFolderDir,ByVal NewFoldeName) 
    '//在某个特定的文件夹里创建一个文件夹 
    '//ParentFolderDir为父文件夹的绝对路径，NewFolderName为要新建的文件夹名称 
        If IsFolderExists(ParentFolderDir&"\"&NewFoldeName) Then Exit Sub 
        Dim F,F1 
        Set F=fso.GetFolder(ParentFolderDir) 
        Set F1=F.SubFolders 
        F1.Add(NewFoldeName) 
        Set F=Nothing 
        Set F1=Nothing 
    End Sub 
    Sub CreateFolderB(ByVal NewFolderDir) 
    '//创建一个新文件夹 
        '//参数NewFolderDir为要创建的文件夹绝对路径 
        If IsFolderExists(NewFolderDir) Then Exit Sub 
        fso.CreateFolder(NewFolderDir) 
    End Sub 
    Sub DeleteAFolder(ByVal NewFolderDir) 
    '//删除一个新文件夹 
    '//参数NewFolderDir为要创建的文件夹绝对路径 
        If IsFolderExists(NewFolderDir)=False Then 
            Exit Sub 
        Else 
            fso.DeleteFolder (NewFolderDir) 
        End If 
    End Sub
	Function Folder_List(ByVal FolderDir) 
        If IsFolderExists(FolderDir) =False Then 
            FolderItem="当前文件夹目录不存在。" 
            Exit Function 
        End If 
        Dim FolderObj,FolderList,F 
        Set FolderObj=fso.GetFolder(FolderDir) 
        Set FolderList=FolderObj.SubFolders
        For Each F In FolderList 
            Folder_List=Folder_List&"<div style=""width:200px;float:left""><img src=""Images/Folder.gif"" width=""22"" height=""19"">"&F.Name&"<div>"
        Next
		Folder_List=Folder_List&"共有"&FolderObj.SubFolders.Count&"个文件夹" 
        Set FolderList=Nothing 
        Set FolderObj=Nothing 
    End Function 
    Function FolderItem(ByVal FolderDir) 
    '//文件夹里的文件夹集合 
    '//FolderDir 为文件夹绝对路径 
        If IsFolderExists(FolderDir) =False Then 
            FolderItem=False 
            Exit Function 
        End If 
        Dim FolderObj,FolderList,F 
        Set FolderObj=fso.GetFolder(FolderDir) 
        Set FolderList=FolderObj.SubFolders 
        FolderItem=FolderObj.SubFolders.Count'//文件夹总数 
        For Each F In FolderList 
            FolderItem=FolderItem&"|"&F.Name 
        Next 
        Set FolderList=Nothing 
        Set FolderObj=Nothing 
    End Function 

    Function FileItem(ByVal FolderDir) 
    '//文件夹里的文件集合 
    '//FolderDir 为文件夹绝对路径 
        If IsFolderExists(FolderDir) =False Then 
            FileItem=False 
            Exit Function 
        End If 
        Dim FileObj,FileerList,F,FileList 
        Set FileObj=fso.GetFolder(FolderDir) 
        Set FileList=FileObj.Files 
        FileItem=FileObj.Files.Count'//文件总数 
        For Each F In FileList 
            FileItem=FileItem&"|"&F.Name 
        Next 
        Set FileList=Nothing 
        Set FileObj=Nothing 
    End Function 
'====================文件夹操作结束======================== 
End Class 
%>