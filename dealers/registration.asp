<% Option Explicit %>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsUserRegistration.asp " -->
<%
sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("action")) = "check" then
			session("usrEmail") = Lcase(Trim(Request("txtEmail")))
			call checkUsername(session("usrEmail"))
		end if
	end if
end sub

call main

dim strMessageText
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>User Registration Check</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
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
        theForm.action.value = 'check';
		
		return true;
    }
}
</script>
</head>
<body>
<p align="center"><a href="./"><img src="images/yamaha_logo_login.jpg" border="0" /></a></p>
<div class="container" style="background-color:white"> 
  <h2>User Registration</h2>
  <form action="" method="post" name="form_check" id="form_check" onsubmit="return validateFormOnSubmit(this)">
    <div class="form-group">
      <label for="txtEmail">Please enter your email<font color="red">*</font>:</label>
      <input type="email" class="form-control" name="txtEmail" id="txtEmail" placeholder="Email Address" maxlength="60" size="40" required />
    </div>
    <div class="form-group">
      <input type="hidden" name="action" />
      <input type="submit" name="submit" id="submit" class="btn btn-default" value="Check" />
    </div>
  </form>
  <p><font color="red"><%= strMessageText %></font></p>
  <p><img src="images/backward_arrow.gif" border="0" /> <a href="./">Back to Login</a></p>
</div>
</body>
</html>