<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsUser.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="../js/html5shiv.js"></script>
  <script src="../js/respond.js"></script>
<![endif]-->
<title>Yamaha User Registration</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap-goal.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="../css/strength.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../js/strength.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script>
$(document).ready(function ($) {
     $('#txtPassword').strength();
});
</script>
<script>
function validateTermsConditions(fld) {
    var error = "";
 	if (!fld.checked) {   
        fld.style.background = 'Yellow'; 
        error = "- You must accept our Terms and Conditions.\n"
    } else {
        fld.style.background = 'White';
    }
    return error;  
}

function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	//reason += validateEmail(theForm.txtUsername);	
	
	reason += validateEmptyField(theForm.txtPassword,"Password");
	
	reason += validateEmptyField(theForm.txtFirstname,"Firstname");
	reason += validateSpecialCharacters(theForm.txtFirstname,"Firstname");
	
	reason += validateEmptyField(theForm.txtLastname,"Lastname");
	reason += validateSpecialCharacters(theForm.txtLastname,"Lastname");
	
	reason += validateEmptyField(theForm.txtStore,"Store Name");
	reason += validateSpecialCharacters(theForm.txtStore,"Store Name");
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	reason += validateSpecialCharacters(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");		
	
	reason += validateNumeric(theForm.txtPhone,"Phone No");		
	
	reason += validateTermsConditions(theForm.chkTermsConditions); 

  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Add';		
		return true;
    }
}
</script>
<%
sub main
	if len(session("usrEmail")) > 1 then
		if Request.ServerVariables("REQUEST_METHOD") = "POST" then
			if trim(request("Action")) = "Add" then
				dim strUsername, strPassword, strFirstname, strLastname, strStore, strAddress, strCity, strState, strPostcode, strPhone
							
				'strUsername  	= Trim(Request("txtUsername"))
				strPassword  	= Trim(Request("txtPassword"))
				strFirstname	= Replace(Trim(Request.Form("txtFirstname")),"'","''")
				strLastname		= Replace(Trim(Request.Form("txtLastname")),"'","''")
				strStore 		= Replace(Trim(Request.Form("txtStore")),"'","''")
				strAddress		= Replace(Trim(Request.Form("txtAddress")),"'","''")
				strCity 		= Replace(Trim(Request.Form("txtCity")),"'","''")
				strState 		= Trim(Request.Form("cboState"))
				strPostcode 	= Trim(Request.Form("txtPostcode"))
				strPhone 		= Replace(Trim(Request.Form("txtPhone")),"'","''")			
				
				call registerUser(session("usrEmail"), strPassword, strFirstname, strLastname, strStore, strAddress, strCity, strState, strPostcode, strPhone)
			end if
		end if
	else
		Response.Redirect("registration.asp")
	end if
end sub

call main

dim strMessageText
%>
</head>
<body>
<a href="./"><img src="images/yamaha.jpg" border="0" /></a>
<h1>User Registration</h1>
<font color="red"><%= strMessageText %></font>
<form action="" method="post" name="form_registration" id="form_registration" onsubmit="return validateFormOnSubmit(this)">
  <div class="form-group">
    <label>Username: </label>
    <%= session("usrEmail") %>
  </div>
  <div class="form-group">
    <label for="txtPassword">Password<font color="red">*</font>:</label>
    <input type="password" class="form-control" name="txtPassword" id="txtPassword" placeholder="Password" maxlength="20" pattern=".{6,20}" required title="6 to 20 characters" />
  </div>
  <h2 class="page-header">Your Details</h2>
  <div class="form-group">
    <label for="txtFirstname">First Name<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtFirstname" id="txtFirstname" placeholder="First Name" maxlength="30" required />
  </div>
  <div class="form-group">
    <label for="txtLastname">Last Name<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtLastname" id="txtLastname" placeholder="Last Name" maxlength="30" required />
  </div>
  <div class="form-group">
    <label for="txtStore">Store Name<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtStore" id="txtStore" placeholder="Store" maxlength="30" required />
  </div>
  <div class="form-group">
    <label for="txtAddress">Address (Location for the goods to be collected from)<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtAddress" id="txtAddress" placeholder="Address (Location for the goods to be collected from)" maxlength="60" size="50" required />
  </div>
  <div class="form-group">
    <label for="txtCity">City<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtCity" id="txtCity" placeholder="City" maxlength="20" size="20" required />
  </div>
  <div class="form-group">
    <label for="cboState">State:</label>
    <select name="cboState" id="cboState" class="form-control">
      <option value="VIC">VIC</option>
      <option value="NSW">NSW</option>
      <option value="ACT">ACT</option>
      <option value="QLD">QLD</option>
      <option value="NT">NT</option>
      <option value="WA">WA</option>
      <option value="SA">SA</option>
      <option value="TAS">TAS</option>
    </select>
  </div>
  <div class="form-group">
    <label for="txtPostcode">Postcode<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtPostcode" id="txtPostcode" placeholder="Postcode" maxlength="4" size="5" required />
  </div>
  
  <div class="form-group">
    <label for="txtPhone">Phone<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtPhone" id="txtPhone" placeholder="Phone" maxlength="12" size="12" required />
  </div>
  <div class="checkbox">
      <label>      
      <input type="checkbox" id="chkTermsConditions" name="chkTermsConditions" value="1" />
      I am authorised to act on behalf on the store named on this form and I have read the <a href="terms.html" target="_blank">Terms &amp; Conditions</a>.</label></div>
  <div class="form-group">
    <input type="hidden" name="Action" />
    <input type="submit" name="submit" id="submit" class="btn btn-default" value="Register" />
  </div>
</form>
<p><img src="images/backward_arrow.gif" border="0" /> <a href="./">Back to Login</a></p>
</body>
</html>