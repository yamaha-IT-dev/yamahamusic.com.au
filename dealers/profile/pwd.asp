<%
dim strSection
strSection = "profile"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsUser.asp" -->
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
<title>Change Password</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../include/pikaday.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;	
	
	//reason += validateEmail(theForm.txtUsername);
	reason += validateEmptyField(theForm.txtPassword,"Password");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Update';		
		return true;
    }
}
</script>
<%
sub main
	call validateLogin
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Update" then
			dim strPassword				
			strPassword	= Trim(Request.Form("txtPassword"))
	
			call updateUserProfile(Session("yma_userid"),strPassword)
		end if
	end if
		
	call getUserProfile(Session("yma_userid"))
end sub

call main

dim strMessageText
%>
</head>
<body>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Profile</a></li>
        <li class="active">Change password</li>
      </ol>
      <h1>Change Password</h1>
      <h3>Username: <u><%= session("usrUsername") %></u></h3>
      <form action="" method="post" name="form_update_user" id="form_update_user" onsubmit="return validateFormOnSubmit(this)">
        <div class="form-group">
          <label for="txtPassword">New Password<span class="mandatory">*</span>:</label>
          <input type="password" pattern=".{6,}" class="form-control" name="txtPassword" id="txtPassword" maxlength="30" size="30" required title="6 characters minimum" />
        </div>
        <div class="form-group">
          <input type="hidden" name="Action" />
          <input type="submit" name="submit" id="submit" value="Change password" />
        </div>
      </form>
      <%= strMessageText %>
      <hr>
      <p><strong>Registered:</strong> <%= FormatDateTime(session("usrDateCreated"),1) %></p>
      <p><strong>Last Login:</strong> <%= FormatDateTime(session("usrDateLastLogin"),1) %></p>
      <p><strong>Login Count:</strong> <%= session("usrLoginCount") %></p></td>
  </tr>
</table>
</body>
</html>