<%@ Language=VBScript %>
<% 
dim strSection
'strSection = "returns"

Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="include/freeaspupload.asp" -->
<!--#include file="class/clsUser.asp " -->
<%
call validateLogin

Dim uploadsDirVar
uploadsDirVar = Server.MapPath("upload/" & Session("yma_userid") & "/")

function OutputForm()
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
    <tr>
        <td class="main_content"><h1>New Asset Upload</h1>
            <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="new-asset.asp" onsubmit="return validateFormOnSubmit(this);">
                <input type="hidden" class="form-control" id="txtID" name="txtID" value="<%= Trim(Request("id")) %>">
                <input type="hidden" class="form-control" id="txtType" name="txtType" value="<%= Trim(Request("type")) %>">
                <div class="form-group">
                    <label for="txtName">Asset Name<font color="red">*</font>:</label>
                    <input type="text" class="form-control" id="txtName" name="txtName" placeholder="Asset Name" maxlength="50" size="35">
                </div>
                <div class="form-group">
                    <label for="attach1">Upload File<font color="red">*</font>:</label>
                    <input type="file" name="attach1" id="attach1" class="form-control" />
                    <p class="help-block">(Please name the filename accordingly and keep it to a minimum size)</p>
                </div>
                <div class="form-group">
                    <input type="hidden" name="Action" />
                    <input type="submit" name="submit" id="submit" class="btn btn-default" value="Submit" />
                </div>
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
        dim strName
        dim intAssociateID
        dim intType

        strName         = Trim(Upload.Form("txtName"))
        intAssociateID  = Trim(Upload.Form("txtID"))
        intType         = Trim(Upload.Form("txtType"))

        SaveFiles = "<B>Files uploaded:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
            strFilename = Upload.UploadedFiles(fileKey).FileName
        next

        ' ---- ADDING INTO DATABASE BEGINS ------
        'strFilename = Upload.UploadedFiles.FileName
        dim strSQL

        call OpenDataBase()

        strSQL = "INSERT INTO tbl_asset (assetName, assetAssociateID, assetFilename, assetType, assetCreatedBy) VALUES ("
        strSQL = strSQL & "'" & Replace(strName,"'","''") & "',"
        strSQL = strSQL & "'" & intAssociateID & "',"
        strSQL = strSQL & "'" & Replace(strFilename,"'","''") & "',"
        strSQL = strSQL & "'" & intType & "',"
        strSQL = strSQL & "'" & Session("yma_userid") & "')"

        'response.Write strSQL
        on error resume next
        conn.Execute strSQL

        On error Goto 0

        if err <> 0 then
            strMessageText = err.description
        else
            Dim JMail
            Set JMail = CreateObject("JMail.Message")

            JMail.MailServerUserName = "yamahamusicau"
            JMail.MailServerPassWord = "str0ppy@16"
            JMail.From = "noreply@music.yamaha.com"
            JMail.Subject = "[Yamaha Connect] New Asset Upload"
            JMail.AddRecipient ("jaclyn.williams@music.yamaha.com")
            JMail.AddRecipient ("dion.durante@music.yamaha.com")
            'TODO Leaving my email here to ensure this is working.
            JMail.AddRecipientBCC ("victor.samson@music.yamaha.com")
            JMail.Body      = "G'day!" & vbCrLf _
                                & "" & vbCrLf _
                                & "A new asset has been uploaded by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
                                & "" & vbCrLf _
                                & "Name: " & strName & vbCrLf _
                                & "ID: " & intAssociateID & vbCrLf _
                                & "Filename: " & strFilename & vbCrLf _
                                & "" & vbCrLf _
                                & "This is an automated email. Please do not reply to this address."

            JMail.Send("smtp.sendgrid.net:25")

            Set JMail = Nothing

            Response.Redirect("../asset/")
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
<title>New Asset Upload</title>
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
        case 'mp4':
        case 'mp3':
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

function isDocument(filename) {
    var ext = getExtension(filename);

    switch (ext.toLowerCase()) {
        case 'doc':
        case 'docx':
        case 'xls':
        case 'xlsx':
        case 'ppt':
        case 'pptx':
        case 'pdf':
        case 'txt':
            // etc
            return true;
    }

    return false;
}

function validateFiletype(fld){
    var error = "";

    if (isImage(fld.value) == false && isVideo(fld.value) == false && isDocument(fld.value) == false) {
        fld.style.background = 'Yellow';
        error = "- Invalid filetype.\n"
    }

    return error;
}

function validateFormOnSubmit(theForm) {
    var reason = "";
    var blnSubmit = true;

    reason += validateEmptyField(theForm.txtName,"Name");
    reason += validateSpecialCharacters(theForm.txtName,"Name");

    reason += validateUploadBox(theForm.attach1);
    reason += validateFiletype(theForm.attach1);

    if (reason != "") {
        alert("Some fields need correction:\n" + reason);

        blnSubmit = false;
        return false;
    }

    if (blnSubmit == true) {
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