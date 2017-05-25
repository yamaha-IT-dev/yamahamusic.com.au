<% Option Explicit %>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsUser.asp " -->
<%
sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Add" then
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
<link rel="stylesheet" href="../bootstrap/css/bootstrap-goal.css">
<link rel="stylesheet" href="css/style.css">
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
        theForm.Action.value = 'Add';
		
		return true;
    }
}
</script>
</head>
<body>
<a href="./"><img src="images/yamaha.jpg" border="0" /></a>
<h2>User Registration</h2>
<form action="" method="post" name="form_check" id="form_check" onsubmit="return validateFormOnSubmit(this)">
  <div class="form-group">
    <label for="txtEmail">Please enter your email<font color="red">*</font>:</label>
    <input type="text" class="form-control" name="txtEmail" id="txtEmail" placeholder="Email Address" maxlength="60" size="40" />
  </div>
  <div class="form-group">
    <input type="hidden" name="Action" />
    <input type="submit" name="submit" id="submit" class="btn btn-default" value="Check" />
  </div>
</form>
<p><font color="red"><%= strMessageText %></font></p>
<p><img src="images/backward_arrow.gif" border="0" /> <a href="./">Back to Login</a></p>
</body>
</html>