<%
dim strSection
strSection = "contact"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsEnquiry.asp " -->
<!--#include file="../class/clsUser.asp " -->
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
<title>Contact Us</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	  	
	reason += validateEmptyField(theForm.cboCategory,"Category");
		
	reason += validateEmptyField(theForm.txtEnquiry,"Enquiry");
	reason += validateSpecialCharacters(theForm.txtEnquiry,"Enquiry");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Add';
  		theForm.submit();
		
		return true;
    }
}
</script>
</head>
<body>
<%
sub main
	call validateLogin
		
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		Dim enqCategory, enqEnquiry

		enqCategory 	= Server.HTMLEncode(Trim(Request("cboCategory")))		
		enqEnquiry 		= Server.HTMLEncode(Trim(Request("txtEnquiry")))
			
		if Trim(Request("Action")) = "Add" then
			call addEnquiry(enqCategory, enqEnquiry, session("yma_userid"))
		end if
	end if
end sub

call main

dim strMessageText
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content">
    <ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Contact Us</li>
      </ol>
    <h1>Contact Us</h1>
      <h2 style="color:green"><%= strMessageText %></h2>
      <form method="post" name="form_request" id="form_request" onsubmit="return validateFormOnSubmit(this)">
        <div class="form-group">
          <label for="cboCategory">Category<span class="mandatory">*</span>:</label>
          <select name="cboCategory" id="cboCategory" class="form-control" required>
            <option value="" rel="none">...</option>
            <option value="1" rel="none">Invoice</option>
            <option value="2" rel="none">Back Order</option>
            <option value="0" rel="none">Other</option>
          </select>
        </div>
        <div class="form-group">
          <label for="txtEnquiry">Enquiry<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" id="txtEnquiry" name="txtEnquiry" maxlength="250" size="120" required />
        </div>
        <div class="form-group">
          <input type="hidden" name="Action" />
          <input type="submit" name="submit" id="submit" value="Submit" />
        </div>
      </form>
      <h2>Phone orders / Stock enquires / Account enquiries</h2>
      <h3>Ph: 1800 331 130<br>
        Fax: (03) 9696 4579</h3>
      </td>
  </tr>
</table>
</body>
</html>