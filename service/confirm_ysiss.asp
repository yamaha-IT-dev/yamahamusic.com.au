<% strSection = "profile" %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsYsissLogin.asp " -->
<!--#include file="class/clsToken.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="include/AntiFixation.asp " -->
<% AntiFixationVerify("default.asp") %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Cache-control" content="no-store">
<title>Update your detials</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script type="text/javascript">
function validateProfile(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateEmptyField(theForm.txtFirstname,"First name");	
	reason += validateSpecialCharacters(theForm.txtFirstname,"First name");
	
	reason += validateEmptyField(theForm.txtLastname,"Last name");
	reason += validateSpecialCharacters(theForm.txtLastname,"Last name");
	
	reason += validateEmptyField(theForm.txtMobile,"Mobile no");
	reason += validateSpecialCharacters(theForm.txtMobile,"Mobile no");
	
	reason += validateEmail(theForm.txtEmail);
	
	reason += validateEmptyField(theForm.txtCompany,"Company name");
	reason += validateSpecialCharacters(theForm.txtCompany,"Company name");		

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
	call UTL_validateLogin	
	call validateYsissLogin
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Update" then
			dim strFirstname, strLastname, strMobile, strEmail, strCompany
					
			strFirstname= Replace(Request.Form("txtFirstname"),"'","''")
			strLastname	= Replace(Request.Form("txtLastname"),"'","''")						
			strMobile 	= Replace(Request.Form("txtMobile"),"'","''")
			strEmail 	= Request.Form("txtEmail")
			strCompany 	= Replace(Request.Form("txtCompany"),"'","''")
		
			call updateYsiss(session("yssID"), strFirstname, strLastname, strMobile, strEmail, strCompany)
		end if
	end if
	
	call getYsissDetails(session("yssID"))
end sub

call main

dim strMessageText
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent">
    <h1>Update your details</h1>
      <form action="" method="post" name="form_update_user" id="form_update_user" onsubmit="return validateProfile(this)">
        <table border="0" cellpadding="5" cellspacing="0" class="form_box">
          <tr>
            <td width="50%"><strong>First name</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtFirstname" id="txtFirstname" maxlength="25" size="25" value="<%= session("ysissFirstname") %>" required /></td>
            <td width="50%" colspan="2"><strong>Last name</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtLastname" id="txtLastname" maxlength="25" size="25" value="<%= session("ysissLastname") %>" required /></td>
          </tr>          
          <tr>
            <td><strong>Mobile</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtMobile" id="txtMobile" maxlength="12" size="15" value="<%= session("ysissMobile") %>" required /></td>
            <td></td>
          </tr>
          <tr>
            <td colspan="2"><strong>Email</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtEmail" id="txtEmail" maxlength="80" size="60" value="<%= session("ysissEmail") %>" required /></td>
          </tr>
          <tr>
            <td colspan="2"><strong>Company</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtCompany" id="txtCompany" maxlength="80" size="60" value="<%= session("ysissCompany") %>" required /></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><br /><input type="hidden" name="Action" />
              <input type="submit" value="Update" /></td>
          </tr>
        </table>
    </form>
	<p><span class="mandatory">* Required field</span></p>
	<%= strMessageText %></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>