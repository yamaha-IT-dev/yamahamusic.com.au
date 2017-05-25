<% response.cookies("current_URL_cookie_gra") = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Querystring %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsUser.asp " -->
<% strSection = "class" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha AVENTAGE Giveaway - Update your details</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script language="JavaScript" type="text/javascript">
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateEmptyField(theForm.txtStore,"Store Name");
	reason += validateSpecialCharacters(theForm.txtStore,"Store Name");
	
	//reason += validateEmptyField(theForm.txtBranch,"Branch Name");
	reason += validateSpecialCharacters(theForm.txtBranch,"Branch Name");
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	
	reason += validateEmptyField(theForm.txtFirstname,"Firstname");	
	reason += validateSpecialCharacters(theForm.txtFirstname,"Firstname");
	
	reason += validateEmptyField(theForm.txtLastname,"Lastname");
	reason += validateSpecialCharacters(theForm.txtLastname,"Lastname");
	
	reason += validateEmptyField(theForm.txtPhone,"Phone No");
	
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
	
	call getUserDetails(session("UsrUserID"))
	
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
			strBranch		= Replace(Request.Form("txtBranch"),"'","''")
			strAddress		= Replace(Request.Form("txtAddress"),"'","''")
			strCity 		= Replace(Request.Form("txtCity"),"'","''")
			strState 		= Request.Form("cboState")
			strPostcode 	= Request.Form("txtPostcode")
			strPhone 		= Replace(Request.Form("txtPhone"),"'","''")
			strPassword 	= Request.Form("txtPassword")
		
			call updateUser(session("UsrUserID"),strFirstname,strLastname,strStore,strDealerCode,strBranch,strAddress,strCity,strState,strPostcode,strPhone,strPassword)
			call getUserDetails(session("UsrUserID"))
		end if
	end if
end sub

call main

dim strMessageText
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" height="100%" class="main_content_table">
<!-- #include file="include/header.asp" -->
  <tr>
    <td class="content_column">
      <form action="" method="post" name="form_update_user" id="form_update_user" onsubmit="return validateFormOnSubmit(this)">
        <table border="0" width="100%" cellpadding="4" cellspacing="0">
          <tr>
            <td colspan="2" align="left"><font color="green"><%= strMessageText %></font>
              <h2 align="center">Update your details</h2></td>
          </tr>
          <tr>
            <td colspan="2"><h3>1. Store Details:</h3></td>
          </tr>
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="90%"><table width="100%" border="0" cellspacing="4" cellpadding="0">
                <tr>
                  <td width="20%">Store Name<span class="mandatory">*</span>:</td>
                  <td width="80%"><input type="text" name="txtStore" id="txtStore" maxlength="40" size="45" value="<%= session("usr_storename") %>" /></td>
                </tr>
                <tr>
                  <td>Dealer Code:</td>
                  <td><input type="text" name="txtDealerCode" id="txtDealerCode" maxlength="20" size="25" value="<%= session("usr_dealer_code") %>" /></td>
                </tr>
                <tr>
                  <td>Branch:</td>
                  <td><input type="text" name="txtBranch" id="txtBranch" maxlength="30" size="35" value="<%= session("usr_branch") %>" /></td>
                </tr>
                <tr>
                  <td>Address<span class="mandatory">*</span>:</td>
                  <td><input type="text" id="txtAddress" name="txtAddress" maxlength="60" size="65" value="<%= session("usr_address") %>" placeholder="Location for the goods to be collected from" /></td>
                </tr>
                <tr>
                  <td>City<span class="mandatory">*</span>:</td>
                  <td><input type="text" id="txtCity" name="txtCity" maxlength="30" size="35" value="<%= session("usr_city") %>" /></td>
                </tr>
                <tr>
                  <td>State:</td>
                  <td><select name="cboState">
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
                </tr>
                <tr>
                  <td>Postcode<span class="mandatory">*</span>:</td>
                  <td><input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="8" value="<%= session("usr_postcode") %>" /></td>
                </tr>
                <tr>
                  <td>Your Firstname<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtFirstname" id="txtFirstname" maxlength="30" size="35" value="<%= session("usr_firstname") %>" /></td>
                </tr>
                <tr>
                  <td>Your Lastname<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtLastname" id="txtLastname" maxlength="30" size="35" value="<%= session("usr_lastname") %>" /></td>
                </tr>
                <tr>
                  <td>Phone No<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtPhone" id="txtPhone" maxlength="20" size="25" value="<%= session("usr_phone") %>" /></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td colspan="3"><h3>2. Login Details:</h3></td>
          </tr>
          <tr>
            <td width="5%">&nbsp;</td>
            <td width="95%"><table width="100%" border="0" cellspacing="4" cellpadding="0">
                <tr>
                  <td width="20%">Username:</td>
                  <td width="80%"><input type="text" name="txtUsername" id="txtUsername" maxlength="50" size="65" value="<%= session("usr_username") %>" disabled="disabled" /></td>
                </tr>
                <tr>
                  <td>Password<span class="mandatory">*</span>:</td>
                  <td><input type="password" name="txtPassword" id="txtPassword" maxlength="50" size="65" value="<%= session("usr_password") %>" /></td>
                </tr>
              </table></td>
          </tr>          
          <tr>
            <td>&nbsp;</td>
            <td><p>
                <input type="hidden" name="Action" />
                <input type="submit" value="Update" />
              </p></td>
          </tr>
          <tr>
            <td colspan="2"><p><img src="images/backward_arrow.gif" width="6" height="12" border="0" /> <a href="home.asp">Back to Home</a></p></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
</body>
</html>