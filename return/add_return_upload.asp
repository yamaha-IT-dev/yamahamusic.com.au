<%@ Language=VBScript %>
<% 
option explicit
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="include/freeaspupload.asp" -->
<!--#include file="class/clsGRA.asp " -->
<!--#include file="class/clsUser.asp " -->
<%
call getGraID(session("add_model_no"),session("add_serial_no"))

Dim uploadsDirVar
uploadsDirVar = Server.MapPath("upload/" & session("new_gra_id") & "/")
  
function OutputForm()
%>
<table border="0" cellpadding="0" cellspacing="0" align="center" height="100%" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="content_column"><h1 align="center">New Goods Return (step 2 of 2)</h1>
      <h3><strike>1. Fill in the Return details</strike></h3>      
      <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="add_return_upload.asp" onSubmit="return validateFormOnSubmit(this);">
        <table width="100%" cellpadding="5" cellspacing="0" border="0">
          <tr>
            <td width="20%" align="right"><strong>Model no:</strong></td>
            <td width="80%"><%= session("new_model_no") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Serial no:</strong></td>
            <td><%= session("new_serial_no") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Invoice no:</strong></td>
            <td><%= session("new_invoice_no") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Purchased date:</strong></td>
            <td><%= session("new_date_purchased") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Claim no:</strong></td>
            <td><%= session("new_claim_no") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Order no:</strong></td>
            <td><%= session("new_replacement_order_no") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Reason:</strong></td>
            <td><% 
            Select Case	session("new_reason")
				case 1
					response.Write("1. Damaged in transit / DOA")
				case 2
					response.Write("2. Faulty display model")
				case 3
					response.Write("3. Faulty customer purchase")
				case 4
					response.Write("4. Faulty 3rd time")
				case 5
					response.Write("5. Yamaha sales manager nominated return")
				case else
					response.Write("-")
			end select			
			%></td>
          </tr>
          <tr>
            <td align="right"><strong>Fault:</strong></td>
            <td><%= session("new_fault") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Test performed:</strong></td>
            <td><%= session("new_test_performed") %></td>
          </tr>
          <tr>
            <td align="right"><strong>Accessories:</strong></td>
            <td><%
            if session("new_accessories") = 1 then
				response.Write("Yes")
			else
				response.Write("No")
			end if
            %></td>
          </tr>
          <tr>
            <td align="right"><strong>Packaging:</strong></td>
            <td><%
            if session("new_packaging") = 1 then
				response.Write("Yes")
			else
				response.Write("No")
			end if
            %></td>
          </tr>
          <tr><td colspan="2"><h3>2. Upload the receipt</h3></td></tr>
          <tr>
            <td align="right" bgcolor="#FFFF00"><img src="images/forward_arrow.gif" border="0" /> Upload the receipt<span class="mandatory">*</span>:</td>
            <td><input type="file" name="attach1" id="attach1" />
              <em>(Please keep it to a minimum size, only JPG/GIF/BMP/PNG is accepted)</em></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="submit" value="Submit" /></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
<%
end function

function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey, strFilename

    Set Upload = New FreeASPUpload
    Upload.Save(uploadsDirVar)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then Exit function

    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
		
    if (UBound(ks) <> -1) then		
        SaveFiles = "<B>Files uploaded:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
			strFilename = Upload.UploadedFiles(fileKey).FileName
        next
		
		dim strSQL
		
		call OpenDataBase()
		
		strSQL = "UPDATE yma_gra SET "
		strSQL = strSQL & " uploaded_filename = '" & Replace(Server.htmlencode(strFilename),"'","''") & "',"
		strSQL = strSQL & " status = '2',"
		strSQL = strSQL & " modified_by = '" & session("UsrUserID")& "',"
		strSQL = strSQL & " date_modified = getdate() "
		strSQL = strSQL & "		WHERE gra_id = " & session("new_gra_id")
		
		'response.Write sql
		on error resume next
		conn.Execute strSQL
		
		'On error Goto 0
		
		if err <> 0 then
			strMessageText = err.description
		else		
			response.Redirect("confirm.asp")
		end if 
		
		call CloseDataBase()
    end if
end function
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Yamaha Goods Return - Upload receipt</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script>
function validateUploadBox(fld) {
    var error = "";
 
    if (fld.value == "") {
        fld.style.background = 'Yellow'; 
        error = "- Please select a file to upload.\n"
    } else {
        fld.style.background = 'White';
    }
    return error;
}

function getExtension(filename) {
    var parts = filename.split('.');
    return parts[parts.length - 1];
}

function isImage(filename) {
    var ext = getExtension(filename);
    switch (ext.toLowerCase()) {
    case 'jpg':
    case 'gif':
    case 'bmp':
	case 'pdf':
    case 'png':
        //etc
        return true;
    }
    return false;
}

function isVideo(filename) {
    var ext = getExtension(filename);
    switch (ext.toLowerCase()) {
    case 'm4v':
    case 'avi':
    case 'mpg':
    case 'mp4':
        // etc
        return true;
    }
    return false;
}

function validateFiletype(fld){
	var error = "";

	if (isImage(fld.value)==false){
		fld.style.background = 'Yellow'; 
		error = "- Invalid filetype.\n"
	}
    return error;
 }

function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;

	reason += validateUploadBox(theForm.attach1);
	reason += validateFiletype(theForm.attach1);
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Update';
  		//theForm.submit();
		return true;
    }
}

</script>
</head>
<body>
<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    OutputForm()
else
    OutputForm()
    response.write SaveFiles()
end if
%>
</body>
</html>