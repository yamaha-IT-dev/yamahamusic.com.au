<%Option Explicit%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsYsissLogin.asp " -->
<!--#include file="class/clsToken.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<% AntiFixationVerify("default.asp") %>
<%
session.lcid = 2057

Sub Main()
	call UTL_validateLogin
    call setYsissSessionVariables(False)
    
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("action")) = "succeed" then		
			'Response.Write("<h1>Logging in....</h1>")
			call setYsissSessionVariables(True)
			if ysissLogin then
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
<meta http-equiv="Cache-control" content="no-store">
<title>Yamaha Technician Registration and Accreditation Program</title>
<link rel="stylesheet" href="include/stylesheet.css">
<script src="../include/generic_form_validations.js"></script>
<script>
function validateYsissLogin(theForm) {
	var reason = "";
	var blnSubmit = true;

  	reason += validateEmptyField(theForm.ysissUsername);
	
	reason += validateEmptyField(theForm.ysissPassword,"Password");
  
  	if (reason != "") {
    	alert(reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
		//alert("LOGIN");
        theForm.action.value = 'succeed';
		
		return true;
    }
}   
</script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent"><h1>Yamaha Technician Registration and Accreditation Program</h1>
      <form name="loginForm" id="loginForm" method="post" action="" onsubmit="return validateYsissLogin(this)">
        <table width="400" border="0" cellpadding="5" cellspacing="0">
          <tr>
            <td align="right">YSISS Username:</td>
            <td><input name="ysissUsername" maxlength="60" style="width:250px;" placeholder="E.g. johns ysissex" autocomplete="off" required /></td>
          </tr>
          <tr>
            <td align="right">YSISS Password:</td>
            <td><input name="ysissPassword" type="password" maxlength="60" style="width:250px;" autocomplete="off" required /></td>
          </tr>
          <tr>
            <td></td>
            <td><input type="hidden" name="action" />
            	<input type="hidden" name="CMD" value="LOGIN">
              <input type="submit" value="Verify" /></td>
          </tr>
        </table>
      </form>
      <p><font color="red"><%= strMessageText %></font></p>
      </td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>