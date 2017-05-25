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
<!--#include file="../include/connection.asp " -->
<!--#include file="include/freeaspupload.asp" -->
<!--#include file="class/clsPremiumCustomer.asp " -->
<%
Dim uploadsDirVar

if session("new_id") <> "" then
	uploadsDirVar = Server.MapPath("upload/" & session("new_id") & "/")
else
	response.redirect("./")
end if 

function OutputForm()
%>
<div class="container">
  <p><img src="images/promo-banner.jpg" class="img-responsive" /></p>
  <h2 class="page-header">Your details:</h1>
  <div class="form-group">
    <label>Full Name:</label>
    <%= session("firstname") & " " & session("lastname") %></div>
  <div class="form-group">
    <label>Address:</label>
    <%= session("address") & ", " & session("city") & " " & session("state") & " " & session("postcode") %></div>
  <div class="form-group">
    <label>Phone:</label>
    <%= session("phone") %></div>
  <div class="form-group">
    <label>Email:</label>
    <%= session("email") %></div>
  <div class="form-group">
    <label>Purchased Piano:</label>
    <%= session("product") %></div>
  <div class="form-group">
    <label>Purchase Date:</label>
    <%= session("purchase_date") %></div>
  <div class="form-group">
    <label>Delivery Date:</label>
    <%= session("delivery_date") %></div>
  <h3 class="page-header">Upload your receipt:</h3>
  <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="upload.asp" onsubmit="return validateFormOnSubmit(this);">
    <div class="form-group">
      <input type="file" name="attach1" id="attach1" class="form-control" />
    </div>
    <p><em>Please keep it to a minimum size, only JPG/GIF/BMP/PNG is preferred</em></p>
    <p>If you are unable to upload proof of purchase, please close this window and email it to <a href="mailto:promotions@gmx.yamaha.com">promotions@gmx.yamaha.com</a>. Your registration for Premium Care piano tunings has already been successfully received.</p>
    <p>
      <input type="submit" name="submit" id="submit" value="Submit" />
    </p>
  </form>
  <p><a href="promo-terms-conditions.html" target="_blank">Terms &amp; Conditions</a></p>
</div>
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
		
		strSQL = "UPDATE yma_premium_care SET "
		strSQL = strSQL & " receipt = '" & Replace(Server.HTMLEncode(strFilename),"'","''") & "' "		
		strSQL = strSQL & "		WHERE premiumcare_id = " & session("new_id")
		
		'response.Write sql
		on error resume next
		conn.Execute strSQL
		
		'On error Goto 0
		
		if err <> 0 then
			strMessageText = err.description
		else
			call clearNewGraSessions	
			response.Redirect("thank-you.html")
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
<title>Yamaha Premium Piano Care Program - VIC Cash Back Promotion</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../include/generic_form_validations.js"></script>
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