<%Option Explicit%>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsPassword.asp" -->
<!--#INCLUDE FILE = "../owasp/Token.asp" -->
<%
sub main	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Retrieve" then
			strEmail = Trim(Request.Form("txtEmail"))			
			if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
				call retrievePassword(strEmail)
			else
				response.Redirect("default.asp?logout=y")
			end if
		end if
	else
		call createToken
	end if
end sub

dim strMessageText
dim strEmail

call main
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Goods Return Authority - Forgot Password</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script language="JavaScript" type="text/javascript">
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
        theForm.Action.value = 'Retrieve';
		
		return true;
    }
}
</script>
</head>
<body>
<img src="images/main-banner.jpg" border="0" />
<div style="padding:10px 10px 10px 10px">
<h2>Forgot your password?</h2>
<h3>Please enter your email:</h3>
<form action="" method="post" name="form_forgot_password" id="form_forgot_password" onsubmit="return validateFormOnSubmit(this)">
  <input type="text" id="txtEmail" name="txtEmail" maxlength="60" size="65" class="green_border" />
  <p>
    <input type="hidden" name="Action" />
    <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
    <input type="submit" value="Submit" />
  </p>
</form>
<p><font color="green"><%= strMessageText %></font></p>
<p><img src="images/backward_arrow.gif" width="6" height="12" border="0" /> <a href="default.asp">Back to Login Screen</a></p>
</div>
</body>
</html>