function GetAllChecked() {
    var retstr = "";
    var tb = document.getElementById("GridView1");
    var j = 0;
    for (var i = 0; i < tb.rows.length; i++) {
        var objtr = tb.rows[i];
        if (objtr.cells.length < 1)
            continue;
		for (var l=0;l<objtr.cells.length;l++)
		{
			var objtd = objtr.cells[l];
			for (var k = 0; k < objtd.childNodes.length; k++) {
				var objnd = objtd.childNodes[k];
				if (objnd.type == "checkbox") {
					if (objnd.checked) {
						if (j > 0)
							retstr += ",";
						retstr += objnd.value;
						j++;
					}
					break;
				}
			}
		}
    }
    return retstr;
}
function doCheckAll(obj) {
    var form = obj.form;
    for (var i = 0; i < form.elements.length; i++) {
        var e = form.elements[i];
        e.checked = obj.checked;
    }
}
function OpenImageBrowser(Element)
{
	if (navigator.appName=="Microsoft Internet Explorer")
	{
		window.showModalDialog("Sys_FileManager.asp?Element="+Element,window,"dialogWidth:600px;dialogHeight:330px;center:yes")
	}
	else
	{
		window.open("Sys_FileManager.asp?Element="+Element,"","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=600,height=330;center=yes");
	}
}
function OpenFunImageBrowser(Element)
{
	if (navigator.appName=="Microsoft Internet Explorer")
	{
		window.showModalDialog("Sys_FunFileManager.asp?Element="+Element,window,"dialogWidth:600px;dialogHeight:330px;center:yes")
	}
	else
	{
		window.open("Sys_FunFileManager.asp?Element="+Element,"","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=600,height=330;center=yes");
	}
}
/*function FCKeditor_OnComplete(editorInstance)
{
	editorInstance.Events.AttachEvent('OnBlur',FCKeditor_OnBlur);
	editorInstance.Events.AttachEvent('OnFocus',FCKeditor_OnFocus);
}
function FCKeditor_OnBlur(editorInstance)
{
	editorInstance.ToolbarSet.Collapse();
}
function FCKeditor_OnFocus(editorInstance)
{
	editorInstance.ToolbarSet.Expand();
}*/

function OpenScript(url,width,height)
{
  var win = window.open(url,"SelectToSort",'width=' + width + ',height=' + height + ',resizable=no,scrollbars=yes,menubar=no,status=yes,directories=no' );
}


function num_1()
{
		var num_1=document.getElementById("number").value;
		var num_1_str=document.getElementById("number_str");
		var str;
		str="<table align='center' border='0' cellspacing='0' cellpadding='0'>";
		for(var i=0;i<num_1;i++)
		{
			str=str+"<tr><td class='cell_center tdright tdbottom tdleft' width='154' height='30'>";
			str=str+"<input name='name"+(parseInt(i)+1)+"' type='text' id='name"+(parseInt(i)+1)+"' value='' style='width:154px; height:20px; line-height:20px;'/></td><td class='cell_center tdright tdbottom' width='246'><input name='value"+(parseInt(i)+1)+"' type='text' id='value"+(parseInt(i)+1)+"' value='' style='width:246px; height:20px; line-height:20px;' /></td>";
			str=str+"</tr>";
		}
		str=str+"</table>";
		num_1_str.innerHTML=str;
}

function num_1_1()
{
	var num_1=document.getElementById("number").value;
	var num_1_str=document.getElementById("number_str");
	var str,number;
	str="<table align='center' border='0' cellspacing='0' cellpadding='0'>";
	str=str+"<tr><td class='cell_center tdright tdbottom tdleft' width='154' height='30'>";
	str=str+"<input name='name"+(parseInt(number)+1)+"' type='text' id='name"+(parseInt(number)+1)+"' value='' style='width:154px; height:20px; line-height:20px;'/></td><td class='cell_center tdright tdbottom' width='246'><input name='value"+(parseInt(number)+1)+"' type='text' id='value"+(parseInt(number)+1)+"' value='' style='width:246px; height:20px; line-height:20px;' /></td>";
	str=str+"</tr>";
	str=str+"</table>";
	num_1_str.innerHTML=num_1_str.innerHTML+str;
	document.getElementById("number").value=(parseInt(number)+1);
}
function runCode(obj) {
        var winname = window.open('', "_blank", '');
        winname.document.open('text/html', 'replace');
	winname.opener = null // 防止代码对论谈页面修改
        winname.document.write(obj.value);
        winname.document.close();
}
function saveCode(obj) {
        var winname = window.open('', '_blank', 'top=10000');
        winname.document.open('text/html', 'replace');
        winname.document.write(obj.value);
        winname.document.execCommand('saveas','','code.htm');
        winname.close();
}

function copycode(obj) {
	if(is_ie && obj.style.display != 'none') {
		var rng = document.body.createTextRange();
		rng.moveToElementText(obj);
		rng.scrollIntoView();
		rng.select();
		rng.execCommand("Copy");
		rng.collapse(false);
	}
}