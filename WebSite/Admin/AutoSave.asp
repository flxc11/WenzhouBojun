<!--#include File="CheckLogin.asp"-->
<%
AutoSave_FileName="AutoSave_"&UserName&".txt"

IF IsEmpty(ReQuest.QueryString("Action")) Then
	SaveContent()
ElseIf Request.QueryString("Action")="AutoSave" then
	ExportAutoSaveJS()
End IF

Function BytesToBstr(body,Cset)
		On Error Resume Next
		Dim objstream
		Set objstream = Server.CreateObject("adodb.stream")
		objstream.Type = 1
		objstream.Mode =3
		objstream.Open
		objstream.Write body
		objstream.Position = 0
		objstream.Type = 2
		objstream.Charset = Cset
		BytesToBstr = objstream.ReadText 
		objstream.Close
		Set objstream = Nothing
End Function

Function SaveContent()
		On Error Resume Next
		Dim objStream
		Set objStream = Server.CreateObject("ADODB.Stream")
		With objStream
		.Type = 2
		.Mode = 3
		.Open
		.Charset = "utf-8"
		.Position = objStream.Size
		.WriteText=BytesToBstr(Request.BinaryRead(Request.TotalBytes),"UTF-8")
		.SaveToFile Server.MapPath("../Cache/"&AutoSave_FileName),2
		.Close
		End With
		Set objStream = NoThing
		If Err.Number=0 then
		Response.Write "<span style="""">&nbsp;"&formatdatetime(now,4)&":"&Right("0"&second(now),2)&"&nbsp;<a href=""../Cache/"&AutoSave_FileName&""" target=""_blank"" style=""text-decoration: none;"">查看</a>&nbsp;</span>"
		Else
		Response.Write "<span style="""">&nbsp;"&formatdatetime(now,4)&"错误&nbsp;"&Err.Number&Err.description&"</span>"
		End If
		Response.End
End Function

'*********************************************************
'输出自动保存脚本
'*********************************************************
Function ExportAutoSaveJS()
	Response.Clear
	Response.Write "  function init(){"
	Response.Write "init_fckeditor();return postForm.innerHTML;"
	Response.Write "  }"
	Response.Write "  function restore(obj){"
	Response.Write "init_fckeditor();postForm.innerHTML=obj;"
	Response.Write "  }"

	Response.Write "  var AutoSaveTime=60;"
	Response.Write "  var FileName=""../Cache/"&AutoSave_FileName&""";"
	Response.Write "  var postForm = null; "
	Response.Write "  var msg = null; "
	Response.Write "  function init_edit(){"
	Response.Write "  postForm = document.edit.txaContent;"
	Response.Write "  msg = document.getElementById(""msg"");"
	Response.Write "  }"

	Response.Write "  function init_fckeditor(){"
	Response.Write "  postForm =document.getElementById("""&Request.QueryString("FrameName")&"___Frame"").contentWindow.frames[0].document.getElementsByTagName('body')[0];"
	Response.Write "  msg = document.getElementById(""msg"");"
	Response.Write "  }"

	Response.Write "var ti=AutoSaveTime;"
	Response.Write "function savedraft()"
	Response.Write "{	 init();"
	Response.Write "	if (postForm!=null&&typeof(postForm)!=undefined){"
	Response.Write "		var url = ""AutoSave.asp"";"
	Response.Write "		var postStr = init();"
	Response.Write "		if (postStr){"
	Response.Write "		var ajax = getHTTPObject();"
	Response.Write "		ajax.open('POST', url, true); "
	Response.Write "		ajax.setRequestHeader(""Content-Type"",""application/x-www-form-urlencoded""); "
	Response.Write "		ajax.onreadystatechange = function(){if (ajax.readyState == 4 && ajax.status == 200) msg.innerHTML = ajax.responseText;};"
	Response.Write "		ajax.send(postStr);"
	Response.Write "		ti=-1000;"
	Response.Write "		}else{"
	Response.Write "		msg.innerHTML = ""无内容"";"
	Response.Write "		ti=-1000;}"
	Response.Write "	}else{msg.innerHTML = ""等待载入或窗体名填写错误"";ti=-1000;}"
	Response.Write "}"
	Response.Write "function restoredraft()"
	Response.Write "{ init();"
	Response.Write "if (window.confirm('你确定需要恢复吗？'))"
	Response.Write "{"
	Response.Write "	if (postForm!=null&&typeof(postForm)!=undefined){"
	Response.Write "		var url = FileName;"
	Response.Write "		var ajax = getHTTPObject();"
	Response.Write "		ajax.open(""GET"", url+'?random='+Math.random(), true); "
	Response.Write "		ajax.onreadystatechange = function() { "
	Response.Write "		if (ajax.readyState == 4 && ajax.status == 200) { "
	Response.Write "		restore(ajax.responseText);"
	Response.Write "		msg.innerHTML =""&nbsp;已恢复""; } } ;"
	Response.Write "		ajax.send(null); "
	Response.Write "		ti=-1000;"
	Response.Write "	}else{msg.innerHTML = ""等待载入或窗体名填写错误"";ti=-1000;}"
	Response.Write ""
	Response.Write "}"
	Response.Write "}"
	Response.Write "function Viewdraft()"
	Response.Write "{ "
	Response.Write "window.open(FileName,'','');"
	Response.Write "}"
	Response.Write "document.getElementById(""msg2"").innerHTML =""&nbsp;<a href='javascript:try{Viewdraft()}catch(e){};' style='cursor:hand;'>[查看]</a>&nbsp;<a href='javascript:try{restoredraft()}catch(e){};' style='cursor:hand;'>[恢复]</a>&nbsp;<a href='javascript:try{savedraft()}catch(e){};' style='cursor:hand;'>[保存]</a>"";"
	Response.Write "function timer() { "
	Response.Write "ti=ti-1;"
	Response.Write "var timemsg=document.getElementById(""timemsg"");timemsg.innerHTML = ti+""秒后自动保存"";"
	Response.Write "if (ti>=0){window.setTimeout(""timer()"", 1000);}else{if (ti<=-1000)"
	Response.Write "{ti=AutoSaveTime;timer();}else{timemsg.innerHTML = ""正在保存..."";savedraft"
	Response.Write "();ti=AutoSaveTime;timer();}} }"
	Response.Write "window.setTimeout(""timer()"", 0);"
	Response.Write "    function getHTTPObject() {"
	Response.Write "	var xmlhttprequest=false; "
	Response.Write "    try {"
	Response.Write "	  xmlhttprequest = new XMLHttpRequest();"
	Response.Write "	} catch (trymicrosoft) {"
	Response.Write "	  try {"
	Response.Write "		xmlhttprequest = new ActiveXObject(""Msxml2.XMLHTTP"");"
	Response.Write "	  } catch (othermicrosoft) {"
	Response.Write "		try {"
	Response.Write "		  xmlhttprequest = new ActiveXObject(""Microsoft.XMLHTTP"");"
	Response.Write "		} catch (failed) {"
	Response.Write "		  xmlhttprequest = false;"
	Response.Write "		}"
	Response.Write "	  }"
	Response.Write "	}"
	Response.Write "	return xmlhttprequest;"
	Response.Write "    }"
End Function
%>