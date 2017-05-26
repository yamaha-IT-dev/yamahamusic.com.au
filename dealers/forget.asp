<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsLogin.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Forgot Your Login?</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;

  	reason += validateEmail(theForm.txtEmail);
  
  	if (reason != "") {
    	alert(reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.action.value = 'submit';
		
		return true;
    }
}
</script>
</head>
<%
sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("action")) = "submit" then
			dim strEmail			
			strEmail  = Server.HTMLEncode(Trim(Request("txtEmail")))
	
			call retrievePassword(strEmail)
		end if
	end if
end sub

call main

dim strMessageText
%>
<body>
<p align="center"><a href="./"><img src="images/yamaha_logo_login.jpg" border="0" /></a></p>
<div class="container" style="background-color:white">
  <h1>Forgot your login?</h1>
  <form action="" method="post" name="form_forgot_password" id="form_forgot_password" onsubmit="return validateFormOnSubmit(this)">
    <div class="form-group">
      <label for="txtEmail">Please enter your email<span class="mandatory">*</span>:</label>
      <input type="email" class="form-control" id="txtEmail" name="txtEmail" maxlength="50" size="60" placeholder="Email" required />
    </div>
    <div class="form-group">
      <input type="hidden" name="action" />
      <input type="submit" name="submit" id="submit" value="Submit" />
    </div>
  </form>
  <p><img src="images/backward_arrow.gif" border="0" /> <a href="./">Back to the login</a></p>
  <p><%= strMessageText %></p>
</div>
</body>
</html>