<% strSection = "jobs"
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsJob.asp" -->
<!--#include file="class/clsList.asp" -->
<!--#include file="class/clsToken.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<% AntiFixationVerify("default.asp") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Cache-control" content="no-store">
<title>New Repair Job - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<link rel="stylesheet" href="../include/pikaday.css" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type="text/javascript" src="../include/generic_form_validations.js"></script>

<script src="/loadModelNo.js" type="text/javascript"></script>

<script type="text/javascript">
function validateTermsConditions(fld) {
    var error = "";
 	if (!fld.checked) {
        fld.style.background = 'Yellow';
        error = "- You must accept our Terms and Conditions.\n"
    } else {
        fld.style.background = 'White';
    }
    return error;
}

function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;

	// CUSTOMER DETAILS

	reason += validateEmptyField(theForm.txtFirstName,"First name");
	reason += validateSpecialCharacters(theForm.txtFirstName,"First name");

	reason += validateEmptyField(theForm.txtLastName,"Last name");
	reason += validateSpecialCharacters(theForm.txtLastName,"Last name");

	reason += validateSpecialCharacters(theForm.txtMobile,"Mobile");
		
	reason += validateSpecialCharacters(theForm.txtPhone,"Phone");

	reason += validateEmptyField(theForm.txtAddress,"Address");
	reason += validateSpecialCharacters(theForm.txtAddress,"Address");

	reason += validateEmptyField(theForm.txtCity,"City");
	reason += validateSpecialCharacters(theForm.txtCity,"City");

	reason += validateEmptyField(theForm.cboState,"State");

	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	reason += validateSpecialCharacters(theForm.txtPostcode,"Postcode");

	if (theForm.txtEmail.value != "") {
		reason += validateEmail(theForm.txtEmail,"Email");
		reason += validateSpecialCharacters(theForm.txtEmail,"Email");
	}	

	// JOB DETAILS

	reason += validateEmptyField(theForm.txtJobNo,"Job no");
	reason += validateSpecialCharacters(theForm.txtJobNo,"Job no");

	reason += validateEmptyField(theForm.cboWarrantyCode,"Category");

	reason += validateEmptyField(theForm.txtModelNo,"Model no");
	reason += validateSpecialCharacters(theForm.txtModelNo,"Model no");

	reason += validateEmptyField(theForm.txtSerialNo,"Serial no");
	reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial no");

	reason += validateEmptyField(theForm.txtDealer,"Dealer name");
	reason += validateSpecialCharacters(theForm.txtDealer,"Dealer name");

	reason += validateEmptyField(theForm.txtInvoiceNo,"Invoice no");
	reason += validateSpecialCharacters(theForm.txtInvoiceNo,"Invoice no");

	reason += validateDate(theForm.txtDatePurchased,"Date purchased");
	reason += validateSpecialCharacters(theForm.txtDatePurchased,"Date purchased");

	reason += validateEmptyField(theForm.txtFault,"Fault");
	reason += validateSpecialCharacters(theForm.txtFault,"Fault");
	
	reason += validateSpecialCharacters(theForm.txtAccessories,"Accessories");
	
	reason += validateSpecialCharacters(theForm.txtComments,"Comments");

  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Add';
		return true;
    }
}
</script>
<%
sub main	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Add" then
			if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
				call addJob
			else
				response.Redirect("default.asp?logout=y")
			end if
		else
			call getWarrantyCodeList
		end if
	else
		call UTL_validateLogin
		call getUserDetails(Session("UsrUserID"))
		call getStateList
		call getWarrantyCodeList
		call getJobStatusList
		call createToken
	end if
end sub

call main

dim strMessageText, strStateList, strWarrantyCodeList, strJobStatusList
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent">
    <font color="red"><%= strMessageText %></font>
      <form action="" method="post" name="form_add_job" id="form_add_job" onsubmit="return validateFormOnSubmit(this)">
        <table border="0" cellpadding="5" cellspacing="5" class="form_box_nowidth">
          <tr>
            <td colspan="2" align="center"><h1>New Repair Job</h1></td>
          </tr>
          <tr>
            <td valign="top"><table border="0" cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Customer Contact Details</td>
                </tr>
                <tr>
                  <td><strong>First name</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtFirstName" name="txtFirstName" maxlength="25" size="25" /></td>
                  <td><strong>Last name</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtLastName" name="txtLastName" maxlength="25" size="25" /></td>
                </tr>
                <tr>
                  <td><strong>Mobile phone</strong> <br />
                    <input type="text" id="txtMobile" name="txtMobile" maxlength="12" size="15" /></td>
                  <td><strong>Phone no</strong><br />
                    <input type="text" id="txtPhone" name="txtPhone" maxlength="12" size="15" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Address</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtAddress" name="txtAddress" maxlength="50" size="50" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>City</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtCity" name="txtCity" maxlength="30" size="30" /></td>
                </tr>
                <tr>
                  <td width="50%"><strong>State</strong> <span class="mandatory">*</span><br />
                    <select name="cboState">
                      <%= strStateList %>
                    </select></td>
                  <td width="50%"><strong>Postcode</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="5" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Email</strong><br />
                    <input type="text" id="txtEmail" name="txtEmail" maxlength="50" size="50" /></td>
                </tr>
              </table><p><span class="mandatory">* Required field</span></p></td>
            <td><table border="0" cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Repair Job Details</td>
                </tr>
                <tr>
                  <td width="50%"><strong>Job no</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtJobNo" name="txtJobNo" maxlength="7" size="10" /></td>
                  <td width="50%"><strong>Warranty job?</strong><br />
                    <select name="cboWarranty">
                      <option value="1">Yes</option>
                      <option value="0">No</option>
                    </select></td>
                </tr>
                <tr>
                  <td><strong>Category</strong> <span class="mandatory">*</span><br />
                    <select name="cboWarrantyCode">
                      <%= strWarrantyCodeList %>
                    </select></td>
                  <td><strong>Model no</strong> <span class="mandatory">*</span> <em>(No space and "-")</em><br />
                    <input type="text" id="txtModelNo" name="txtModelNo" maxlength="25" size="30" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Serial no (E.g. 21X123456XX)</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtSerialNo" name="txtSerialNo" maxlength="15" size="20" placeholder="E.g. 21X123456XX" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Dealer name</strong> <em>(Purchased from)</em> <span class="mandatory">*</span><br />
                    <input type="text" id="txtDealer" name="txtDealer" placeholder="Max 30 chars" maxlength="30" size="35" /></td>
                </tr>
                <tr>
                  <td valign="top"><strong>Invoice / Receipt no</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtInvoiceNo" name="txtInvoiceNo" maxlength="15" size="20" /></td>
                  <td><strong>Date purchased</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtDatePurchased" name="txtDatePurchased" placeholder="dd/mm/yyyy" maxlength="10" size="10" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Fault reported</strong> <span class="mandatory">*</span><br />
                    <input type="text" id="txtFault" name="txtFault" placeholder="Max 30 chars" maxlength="30" size="35" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Accessories</strong> <br />
                    <input type="text" id="txtAccessories" name="txtAccessories" placeholder="Max 30 chars" maxlength="30" size="35" /></td>
                </tr>
                <tr>
                  <td colspan="2"><strong>Comments / Condition</strong> <br />
                    <input type="text" id="txtComments" name="txtComments" placeholder="Max 30 chars" maxlength="30" size="35" /></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td colspan="2" align="center"><br />
              <input type="hidden" name="Action" />
              <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
              <input type="submit" value="Submit Repair Job" /></td>
          </tr>
        </table>
      </form></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
<script type="text/javascript" src="../include/moment.js"></script> 
<script type="text/javascript" src="../include/pikaday.js"></script> 
<script type="text/javascript">	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDatePurchased'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
		format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>