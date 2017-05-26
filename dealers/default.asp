<%Option Explicit%>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsLogin.asp " -->
<%
session.lcid = 2057

Sub Main()
    if(request("logout")="y")then
        Session.Abandon
		response.Redirect("./")
    end if

    call SetSessionVariables(False)
    
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("action")) = "login" then
			call SetSessionVariables(True)
			if testUserLogin then
			end if
		end if
	end if
end sub

call Main

dim strMessageText
%>
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
<title>Yamaha Connect</title>
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

  	reason += validateEmail(theForm.username);
	
	reason += validateEmptyField(theForm.password,"Password");
  
  	if (reason != "") {
    	alert(reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.action.value = 'login';
		
		return true;
    }
}   
</script>
</head>
<body>
<p align="center"><img src="images/yamaha_logo_login.jpg" border="0" class="img-responsive" /></p>
<div class="container" style="background-color:white">
  <h3>For Authorised <u>Musical Instrument Product</u> Dealers Only</h3>
  <form action="" name="login_form" id="login_form" method="post" onsubmit="return validateFormOnSubmit(this)">
    <div class="form-group">
      <label for="username">Username (Email)<font color="red">*</font>:</label>
      <input type="email" class="form-control" name="username" id="username" placeholder="Email Address" maxlength="60" size="40" autocomplete="off" required />
    </div>
    <div class="form-group">
      <label for="password">Password<font color="red">*</font>:</label>
      <input type="password" class="form-control" name="password" id="password" placeholder="Password" maxlength="50" size="40" autocomplete="off" required />
    </div>
    <div class="form-group">
      <input type="hidden" name="action" />
      <input type="submit" name="submit" id="submit" class="btn btn-default" value="Login" />
    </div>
  </form>
  <p><a href="register/">New user?</a></p>
  <p><a href="forget.asp">Forgotten password?</a></p>
  <font color="green"><%= strMessageText %></font> </div>
</body>
</html>