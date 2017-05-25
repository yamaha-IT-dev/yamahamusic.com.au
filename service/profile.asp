<% strSection = "profile" %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsUser.asp " -->
<!--#include file="include/AntiFixation.asp " -->
<% AntiFixationVerify("default.asp") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Cache-control" content="no-store">
<title>Update your profile - Yamaha Service Centre Portal</title>
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
	
	reason += validateEmptyField(theForm.txtPhone,"Phone no");
	reason += validateSpecialCharacters(theForm.txtPhone,"Phone no");
	
	reason += validateEmptyField(theForm.txtStore,"Company name");
	reason += validateSpecialCharacters(theForm.txtStore,"Company name");
	
	reason += validateEmptyField(theForm.txtDealerCode,"Service centre code");
	reason += validateSpecialCharacters(theForm.txtDealerCode,"Service centre code");
	
	reason += validateEmptyField(theForm.txtVendorCode,"Vendor code");
	reason += validateSpecialCharacters(theForm.txtVendorCode,"Vendor code");
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	reason += validateSpecialCharacters(theForm.txtAddress,"Address");
		
	reason += validateEmptyField(theForm.txtCity,"City");
	reason += validateSpecialCharacters(theForm.txtCity,"City");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	
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
	call UTL_validateLogin	
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Update" then
			dim strFirstname
			dim strLastname
			dim strStore
			dim strDealerCode
			dim strBranch
			dim strAddress
			dim strCity
			dim strState
			dim strPostcode
			dim strPhone
			dim strPassword
					
			strFirstname	= Replace(Request.Form("txtFirstname"),"'","''")
			strLastname		= Replace(Request.Form("txtLastname"),"'","''")
			strStore 		= Replace(Request.Form("txtStore"),"'","''")
			strDealerCode	= Replace(Request.Form("txtDealerCode"),"'","''")
			strBranch		= Replace(Request.Form("txtVendorCode"),"'","''")
			strAddress		= Replace(Request.Form("txtAddress"),"'","''")
			strCity 		= Replace(Request.Form("txtCity"),"'","''")
			strState 		= Request.Form("cboState")
			strPostcode 	= Request.Form("txtPostcode")
			strPhone 		= Replace(Request.Form("txtPhone"),"'","''")
			strPassword 	= Request.Form("txtPassword")
		
			call updateUser(session("UsrUserID"),strFirstname,strLastname,strStore,strDealerCode,strBranch,strAddress,strCity,strState,strPostcode,strPhone,strPassword)			
		end if
	end if
	
	call getUserDetails(session("UsrUserID"))
end sub

call main

dim strMessageText
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent"><h1>Update your profile</h1>
      <form action="" method="post" name="form_update_user" id="form_update_user" onsubmit="return validateProfile(this)">
        <table border="0" cellpadding="5" cellspacing="0" class="form_box">
          <tr>
            <td colspan="3" class="form_header">Your Details</td>
          </tr>
          <tr>
            <td><strong>First name</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtFirstname" id="txtFirstname" maxlength="25" size="25" value="<%= session("usr_firstname") %>" /></td>
            <td colspan="2"><strong>Last name</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtLastname" id="txtLastname" maxlength="25" size="25" value="<%= session("usr_lastname") %>" /></td>
          </tr>
          <tr>
            <td><strong>Phone no</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtPhone" id="txtPhone" maxlength="12" size="15" value="<%= session("usr_phone") %>" /></td>
            <td colspan="2"><strong>Company name</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtStore" id="txtStore" maxlength="25" size="25" value="<%= session("usr_storename") %>" /></td>
          </tr>
          <tr>
            <td><strong>Service centre code</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtDealerCode" id="txtDealerCode" maxlength="20" size="25" value="<%= session("usr_dealer_code") %>" /></td>
            <td colspan="2"><strong>Vendor code</strong> <span class="mandatory">*</span><br />
              <input type="text" name="txtVendorCode" id="txtVendorCode" maxlength="25" size="25" value="<%= session("usr_vendor_code") %>" /></td>
          </tr>
          <tr>
            <td colspan="3"><strong>Address</strong> <span class="mandatory">*</span><br />
              <input type="text" id="txtAddress" name="txtAddress" maxlength="50" size="50" value="<%= session("usr_address") %>" /></td>
          </tr>
          <tr>
            <td width="50%"><strong>City</strong> <span class="mandatory">*</span><br />
              <input type="text" id="txtCity" name="txtCity" maxlength="25" size="25" value="<%= session("usr_city") %>" /></td>
            <td width="20%"><strong>State</strong><br />
              <select name="cboState">
                <option <% if session("usr_state") = "VIC" then Response.Write " selected" end if%> value="VIC">VIC</option>
                <option <% if session("usr_state") = "NSW" then Response.Write " selected" end if%> value="NSW">NSW</option>
                <option <% if session("usr_state") = "ACT" then Response.Write " selected" end if%> value="ACT">ACT</option>
                <option <% if session("usr_state") = "QLD" then Response.Write " selected" end if%> value="QLD">QLD</option>
                <option <% if session("usr_state") = "NT" then Response.Write " selected" end if%> value="NT">NT</option>
                <option <% if session("usr_state") = "WA" then Response.Write " selected" end if%> value="WA">WA</option>
                <option <% if session("usr_state") = "SA" then Response.Write " selected" end if%> value="SA">SA</option>
                <option <% if session("usr_state") = "TAS" then Response.Write " selected" end if%> value="TAS">TAS</option>
                <option <% if session("usr_state") = "Other" then Response.Write " selected" end if%> value="Other">Other</option>
              </select></td>
            <td width="30%"><strong>Postcode</strong> <span class="mandatory">*</span><br />
              <input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="8" value="<%= session("usr_postcode") %>" /></td>
          </tr>
          <tr>
            <td colspan="3"><strong>Username</strong><br />
              <u><%= session("usr_username") %></u></td>
          </tr>
          <tr>
            <td colspan="3"><strong>Password</strong> <span class="mandatory">*</span><br />
              <input type="password" name="txtPassword" id="txtPassword" maxlength="50" size="50" value="<%= session("usr_password") %>" /></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><br /><input type="hidden" name="Action" />
              <input type="submit" value="Update Profile" /></td>
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