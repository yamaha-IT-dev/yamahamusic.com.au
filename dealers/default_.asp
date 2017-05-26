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
    function setFocus()
    {
    document.forms[0].username.focus();
    }
 
    // We validate the for fields
    function validateForm()
    {    
        var strUsername = document.forms[0].username.value;
        var strPassword = document.forms[0].password.value;
        var blnSubmit = true;
        
        // We check if all the values are entered
        if (strUsername == ''){
            alert('Please enter a username to login');
            document.forms[0].username.focus();
            blnSubmit = false;            
        }
        
        if ((strPassword == '') && (blnSubmit == true)){
            alert('Please enter a password to login');
            document.forms[0].password.focus();
            blnSubmit = false;            
        }	
        
        if (blnSubmit == true){
            document.forms[0].action.value = 'login';            
            return true;            
            //document.forms[0].submit();
        } else {
        
            return false;
        }    
    }
</script>
</head>
<body>
<p align="center"><img src="images/yamaha_logo_login.jpg" border="0" /></p>
<div class="container" style="background-color:white">
  <h3>For Authorised Yamaha Music Australia Dealers Only</h3>
  <form name="login_form" id="login_form" method="post" action="default.asp" onsubmit="return validateForm()">
    <div class="form-group">
      <label for="username">Username (Email)<font color="red">*</font>:</label>
      <input type="email" class="form-control" name="username" id="username" placeholder="Email Address" maxlength="60" size="40" required />
    </div>
    <div class="form-group">
      <label for="password">Password<font color="red">*</font>:</label>
      <input type="password" class="form-control" name="password" id="password" placeholder="Password" maxlength="50" size="40" required />
    </div>
    <div class="form-group">
      <input type="hidden" name="action" />
      <input type="submit" name="submit" id="submit" class="btn btn-default" value="Login" />
    </div>
  </form>
  <p><a href="forget.asp">Forgot your login?</a></p>
  <font color="green"><%= strMessageText %></font> </div>
</body>
</html>