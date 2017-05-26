<%@ Language=VBScript %>
<% 
dim strSection
strSection = "returns"

Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../include/freeaspupload.asp" -->
<!--#include file="../class/clsGoodsReturn.asp " -->
<!--#include file="../class/clsUser.asp " -->
<%
call validateLogin

call getGraID(session("yma_userid"),session("new_model_no"),session("new_invoice_no"))

Dim uploadsDirVar
uploadsDirVar = Server.MapPath("upload/" & session("new_gra_id") & "/")
  
function OutputForm()
%>

<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><h1>New Goods Return (step 2)</h1>
      <h3><strike>1. Fill in the Goods Return details</strike></h3>
      <h2>2. Upload the photo (Optional)</h2>
      <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="new-return-upload.asp" onsubmit="return validateFormOnSubmit(this);">
        <table width="100%">
          <tr>
            <td valign="top" width="50%"><table cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Dealer Details</td>
                </tr>
                <tr>
                  <td colspan="2">Dealer name:<br />
                    <u><%= session("new_dealer_name") %></u></td>
                </tr>
                <tr>
                  <td width="50%">Contact name:<br />
                    <u><%= session("new_dealer_contact_name") %></u></td>
                  <td width="50%">Phone no:<br />
                    <u><%= session("new_dealer_phone") %></u></td>
                </tr>
                <tr>
                  <td colspan="2">Email:<br />
                    <u><%= session("user_email") %></u></td>
                </tr>
              </table></td>
            <td valign="top" width="50%"><table cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Stock Details</td>
                </tr>
                <tr>
                  <td width="50%">Item code:<br />
                    <u><%= session("new_model_no") %></u></td>
                  <td width="50%">Qty:<br />
                    <u><%= session("new_qty") %></u></td>
                </tr>
                <tr>
                  <td colspan="2">Serial no:<br />
                    <u><%= session("new_serial_no") %></u></td>
                </tr>
                <tr>
                  <td>Original invoice no:<br />
                    <u><%= session("new_invoice_no") %></u></td>
                  <td>Original invoice date:<br />
                    <u><%= session("new_invoice_date") %></u></td>
                </tr>
                <tr>
                  <td colspan="2">Reason for return:<br />
                    <u><%= session("new_reason") %></u></td>
                </tr>
                <tr>
                  <td colspan="2">Type:<br />
                    <u><%= session("new_type") %></u></td>
                </tr>
                <% if session("new_type") = "C" then %>
                <tr>
                  <td>Customer name :
                    <u><%= session("new_customer_name") %></u></td>
                  <td>Date purchased:<br />
                    <u><%= session("new_date_purchased") %></u></td>
                </tr>
                <% end if %>
                <tr>
                  <td colspan="2">
                    <% if session("new_serviced") = 1 then %>
                    	Yes, the product has been serviced on <u><%= session("new_date_serviced") %></u> by <u><%= session("new_serviced_by") %></u>.
                    <% else %>    
                        No, the product has <u>not<u> been serviced.
                    <% end if %>
                    </td>
                </tr>                
              </table></td>
          </tr>
        </table>
        <h3>2. Upload photo</h3>
        Upload the photo:
        <input type="file" name="attach1" id="attach1" />
        <em>(Please keep it to a minimum size, only JPG/GIF/BMP/PNG is accepted)</em>
        <p>          
          <input type="submit" name="submit" id="submit" value="Submit" />
        </p>
      </form>      
      </td>
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
		
		strSQL = "UPDATE tbl_gra_mpd SET "
		strSQL = strSQL & " gra_uploaded_filename = '" & Replace(Server.htmlencode(strFilename),"'","''") & "',"
		strSQL = strSQL & " gra_status = '2' "
		strSQL = strSQL & "		WHERE gra_id = " & session("new_gra_id")
		
		'response.Write sql
		on error resume next
		conn.Execute strSQL
		
		'On error Goto 0
		
		if err <> 0 then
			strMessageText = err.description
		else
			call clearNewGraSessions	
			response.Redirect("return.asp")
		end if 
		
		call CloseDataBase()
    end if
end function
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="../../js/html5shiv.js"></script>
  <script src="../../js/respond.js"></script>
<![endif]-->
<title>Goods Return Upload Photo</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../include/pikaday.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
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