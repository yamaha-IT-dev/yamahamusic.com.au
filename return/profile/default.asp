<!--#include file="../../include/connection.asp " -->
<!--#include file="../../owasp/Token.asp" -->
<!--#include file="../class/clsUser.asp " -->
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
<title>Update Profile</title>
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../css/style.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateEmptyField(theForm.txtFirstname,"First name");	
	reason += validateSpecialCharacters(theForm.txtFirstname,"First name");
	
	reason += validateEmptyField(theForm.txtLastname,"Last name");
	reason += validateSpecialCharacters(theForm.txtLastname,"Last name");
	
	reason += validateEmptyField(theForm.txtStore,"Store Name");
	reason += validateSpecialCharacters(theForm.txtStore,"Store Name");
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	
	reason += validateEmptyField(theForm.txtPhone,"Phone No");

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
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Update" then
			strFirstname	= Replace(Trim(Request.Form("txtFirstname")),"'","''")
			strLastname		= Replace(Trim(Request.Form("txtLastname")),"'","''")
			strStore 		= Replace(Trim(Request.Form("txtStore")),"'","''")		
			strAddress		= Replace(Trim(Request.Form("txtAddress")),"'","''")
			strCity 		= Replace(Trim(Request.Form("txtCity")),"'","''")
			strState 		= Trim(Request.Form("cboState"))
			strPostcode 	= Trim(Request.Form("txtPostcode"))
			strPhone 		= Replace(Trim(Request.Form("txtPhone")),"'","''")
			
			if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
				call updateUserProfile(session("UsrUserID"),strFirstname,strLastname,strStore,strAddress,strCity,strState,strPostcode,strPhone)
				call getUserDetails(session("UsrUserID"))
			else
				Response.Redirect("./?logout=y")
			end if
		end if
	else
		call UTL_validateLogin
		call getUserDetails(session("UsrUserID"))
		call createToken
	end if
end sub

call main

dim strMessageText, strFirstname, strLastname, strStore, strAddress, strCity, strState, strPostcode, strPhone
%>
</head>
<body>
<div class="container"> 
  <!-- #include file="../include/header-new.asp" -->   
  <h2>Profile</h2>   
  <h4>Username: <u><%= session("usr_username") %></u> (<a href="../pwd/">Change password</a>)</h4>
  <form action="" method="post" name="form_update_user" id="form_update_user" onsubmit="return validateFormOnSubmit(this)">
    <div class="form-group">
      <label for="txtFirstname">First name<font color="red">*</font>:</label>
      <input type="text" class="form-control" name="txtFirstname" id="txtFirstname" maxlength="30" size="30" value="<%= Server.HTMLencode(session("usr_firstname") & "") %>" placeholder="First name" pattern=".{2,}" required title="2 characters minimum" />
    </div>
    <div class="form-group">
      <label for="txtLastname">Last name<font color="red">*</font>:</label>
      <input type="text" class="form-control" name="txtLastname" id="txtLastname" maxlength="30" size="30" value="<%= Server.HTMLencode(session("usr_lastname") & "") %>" placeholder="Last name" pattern=".{2,}" required title="2 characters minimum" />
    </div>
    <div class="form-group">
      <label for="txtStore">Store name<font color="red">*</font>:</label>
      <input type="text" class="form-control" name="txtStore" id="txtStore" maxlength="40" size="40" value="<%= Server.HTMLencode(session("usr_storename") & "") %>" placeholder="Store name" pattern=".{2,}" required title="2 characters minimum" />
    </div>
    <div class="form-group">
      <label for="txtAddress">Address<font color="red">*</font>:</label>
      <input type="text" class="form-control" id="txtAddress" name="txtAddress" maxlength="60" size="40" value="<%= Server.HTMLencode(session("usr_address") & "") %>" placeholder="Address" pattern=".{4,}" required title="4 characters minimum" />
    </div>
    <div class="form-group">
      <label for="txtCity">City<font color="red">*</font>:</label>
      <input type="text" class="form-control" id="txtCity" name="txtCity" maxlength="30" size="30" value="<%= Server.HTMLencode(session("usr_city") & "") %>" placeholder="City" pattern=".{3,}" required title="3 characters minimum" />
    </div>
    <div class="form-group">
      <label for="cboState">State<font color="red">*</font>:</label>
      <select class="form-control" name="cboState" id="cboState">
        <option <% if session("usr_state") = "VIC" then Response.Write " selected" end if%> value="VIC">VIC</option>
        <option <% if session("usr_state") = "NSW" then Response.Write " selected" end if%> value="NSW">NSW</option>
        <option <% if session("usr_state") = "ACT" then Response.Write " selected" end if%> value="ACT">ACT</option>
        <option <% if session("usr_state") = "QLD" then Response.Write " selected" end if%> value="QLD">QLD</option>
        <option <% if session("usr_state") = "NT" then Response.Write " selected" end if%> value="NT">NT</option>
        <option <% if session("usr_state") = "WA" then Response.Write " selected" end if%> value="WA">WA</option>
        <option <% if session("usr_state") = "SA" then Response.Write " selected" end if%> value="SA">SA</option>
        <option <% if session("usr_state") = "TAS" then Response.Write " selected" end if%> value="TAS">TAS</option>
        <option <% if session("usr_state") = "Other" then Response.Write " selected" end if%> value="Other">Other</option>
      </select>
    </div>
    <div class="form-group">
      <label for="txtPostcode">Postcode<font color="red">*</font>:</label>
      <input type="text" class="form-control" id="txtPostcode" name="txtPostcode" maxlength="4" size="4" value="<%= Server.HTMLencode(session("usr_postcode") & "") %>" placeholder="Postcode" pattern=".{4,}" required title="4 digit minimum" />
    </div>
    <div class="form-group">
      <label for="txtPhone">Phone<font color="red">*</font>:</label>
      <input type="text" class="form-control" name="txtPhone" id="txtPhone" maxlength="12" size="12" value="<%= Server.HTMLencode(session("usr_phone") & "") %>" placeholder="Phone" pattern=".{8,}" required title="8 digit minimum" />
    </div>
    <div class="form-group">
      <input type="hidden" name="Action" />
      <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
      <input type="submit" name="submit" id="submit" class="btn btn-default" value="Update" />
    </div>
  </form>
  <%= strMessageText %>  
</div>
</body>
</html>