<% Option Explicit %>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsLogin.asp " -->
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
<title>Forgotten Password</title>
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../css/pure-min.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../include/generic_form_validations.js"></script>
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
<body>
<p align="center"><img src="../images/yamaha_logo_login.jpg" border="0" /></p>
<div class="container" style="background-color:white">
  <ol class="breadcrumb">
    <li><a href="../">Login</a></li>
    <li class="active">Forgotten Password</li>
  </ol>
  <h2>Forgotten Password</h2>
  <form action="" method="post" name="form_check" id="form_check" onsubmit="return validateFormOnSubmit(this)">
    <div class="form-group">
      <label for="txtEmail">Please enter your email<font color="red">*</font>:</label>
      <input type="email" class="form-control" name="txtEmail" id="txtEmail" placeholder="Email Address" maxlength="60" size="40" required />
    </div>
    <div class="form-group">
      <input type="hidden" name="Action" />
      <input type="submit" name="submit" id="submit" class="btn btn-default" value="Submit" />
    </div>
  </form>
  <%= strMessageText %>
</div>
</body>
</html>