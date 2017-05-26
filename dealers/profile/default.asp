<%
dim strSection
strSection = "profile"
%>
<!--#include file="../../include/connection.asp " -->
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
<title>Profile</title>
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
	
	reason += validateEmptyField(theForm.txtStorename,"Store name");
	reason += validateSpecialCharacters(theForm.txtStorename,"Store name");
	
	reason += validateEmptyField(theForm.txtFirstname,"First name");
	reason += validateSpecialCharacters(theForm.txtFirstname,"First name");
	
	reason += validateEmptyField(theForm.txtLastname,"Last name");
	reason += validateSpecialCharacters(theForm.txtLastname,"Last name");
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	reason += validateSpecialCharacters(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	reason += validateSpecialCharacters(theForm.txtCity,"City");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	
	reason += validateEmptyField(theForm.txtPhone,"Phone");
	reason += validateSpecialCharacters(theForm.txtPhone,"Phone");
	
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
	
	dim strFirstname, strLastname, strAddress, strCity, strState, intPostcode, strPhone, strStorename, strDealerCode
				
	strFirstname 	= Replace(Request.Form("txtFirstname"),"'","''")
	strLastname	 	= Replace(Request.Form("txtLastname"),"'","''")
	strAddress	 	= Replace(Request.Form("txtAddress"),"'","''")
	strCity	 		= Replace(Request.Form("txtCity"),"'","''")
	strStorename	= Replace(Request.Form("txtStorename"),"'","''")
	strState 		= Request.Form("cboState")
	intPostcode 	= Request.Form("txtPostcode")
	strPhone		= Replace(Request.Form("txtPhone"),"'","''")	
		
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Update" then
			call updateUser(Session("yma_userid"), strFirstname, strLastname, strAddress, strCity, strState, intPostcode, strPhone, strStorename)								
		end if
	end if
		
	call getUser(Session("yma_userid"))	
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
        <li class="active">Profile</li>
      </ol>
      <h1>Profile</h1>
      <h3>Username: <u><%= session("usrUsername") %></u> (<a href="pwd.asp">Change password</a>)</h3>
      <form action="" method="post" name="form_update_user" id="form_update_user" onsubmit="return validateFormOnSubmit(this)">
        <div class="form-group">
          <label for="txtStorename">Store name<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtStorename" id="txtStorename" maxlength="30" size="30" value="<%= session("user_storename") %>" required />
        </div>
        <div class="form-group">
          <label for="txtFirstname">First name<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtFirstname" id="txtFirstname" maxlength="30" size="30" value="<%= session("user_firstname") %>" required />
        </div>
        <div class="form-group">
          <label for="txtLastname">Last name<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtLastname" id="txtLastname" maxlength="30" size="30" value="<%= session("user_lastname") %>" required />
        </div>
        <div class="form-group">
          <label for="txtAddress">Address<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtAddress" id="txtAddress" maxlength="50" size="50" value="<%= session("user_address") %>" required />
        </div>
        <div class="form-group">
          <label for="cboState">State<span class="mandatory">*</span>:</label>
          <select name="cboState" id="cboState" class="form-control">
            <option <% if session("user_state") = "VIC" then Response.Write " selected" end if%> value="VIC">VIC</option>
            <option <% if session("user_state") = "NSW" then Response.Write " selected" end if%> value="NSW">NSW</option>
            <option <% if session("user_state") = "ACT" then Response.Write " selected" end if%> value="ACT">ACT</option>
            <option <% if session("user_state") = "QLD" then Response.Write " selected" end if%> value="QLD">QLD</option>
            <option <% if session("user_state") = "NT" then Response.Write " selected" end if%> value="NT">NT</option>
            <option <% if session("user_state") = "WA" then Response.Write " selected" end if%> value="WA">WA</option>
            <option <% if session("user_state") = "SA" then Response.Write " selected" end if%> value="SA">SA</option>
            <option <% if session("user_state") = "TAS" then Response.Write " selected" end if%> value="TAS">TAS</option>
          </select>
        </div>
        <div class="form-group">
          <label for="txtCity">City<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtCity" id="txtCity" maxlength="30" size="30" value="<%= session("user_city") %>" required />
        </div>
        <div class="form-group">
          <label for="txtPostcode">Postcode<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtPostcode" id="txtPostcode" maxlength="4" size="5" value="<%= session("user_postcode") %>" required />
        </div>
        <div class="form-group">
          <label for="txtPhone">Phone<span class="mandatory">*</span>:</label>
          <input type="text" class="form-control" name="txtPhone" id="txtPhone" maxlength="12" size="15" value="<%= session("user_phone") %>" required />
        </div>
        <div class="form-group">
          <input type="hidden" name="Action" />
          <input type="submit" name="submit" id="submit" value="Update" />
        </div>
      </form>
      <%= strMessageText %>
      <hr>
      <p><strong>Registered:</strong> <%= FormatDateTime(session("user_datecreated"),1) %></p></td>
  </tr>
</table>
</body>
</html>