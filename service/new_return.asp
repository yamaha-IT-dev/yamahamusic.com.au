<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Cache-control" content="no-store">
<title>Yamaha Connect - Goods Return</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="../include/stylesheet.css" type="text/css" />
<link rel="stylesheet" href="../../include/pikaday.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="../../include/javascript.js"></script>
<script type="text/javascript" src="../../include/usableforms.js"></script>
<script type="text/javascript" src="../../include/generic_form_validations.js"></script>

<script src="/loadModelNo.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
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
	
	//Dealer Details
	reason += validateEmptyField(theForm.txtDealerName,"Dealer name");
	reason += validateSpecialCharacters(theForm.txtDealerName,"Dealer name");
	
	reason += validateEmptyField(theForm.txtDealerContactName,"Contact name");
	reason += validateSpecialCharacters(theForm.txtDealerContactName,"Contact name");
	
	reason += validateEmptyField(theForm.txtDealerPhone,"Phone");
	reason += validateSpecialCharacters(theForm.txtDealerPhone,"Phone");
	
	reason += validateEmail(theForm.txtDealerEmail);
			
	//Product Details
	reason += validateEmptyField(theForm.txtModelNo,"Item code");
	reason += validateSpecialCharacters(theForm.txtModelNo,"Item code");
	
	reason += validateNumeric(theForm.txtQty,"Qty");
	
	reason += validateEmptyField(theForm.txtSerialNo,"Serial no");
	reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial no");
	
	reason += validateEmptyField(theForm.txtInvoiceNo,"Invoice no");
	reason += validateSpecialCharacters(theForm.txtInvoiceNo,"Invoice no");
	
	reason += validateDate(theForm.txtInvoiceDate,"Date invoice");
	
	reason += validateEmptyField(theForm.txtReason,"Reason");
	reason += validateSpecialCharacters(theForm.txtReason,"Reason");		
	
	if (theForm.cboType.value == 2) {
		reason += validateEmptyField(theForm.txtCustomerName,"Customer name");
		reason += validateSpecialCharacters(theForm.txtCustomerName,"Customer name");
		
		reason += validateDate(theForm.txtDatePurchased,"Date purchased");
	}
			
	if (theForm.cboServiced.value == 1) {
		reason += validateDate(theForm.txtDateServiced,"Date serviced");
			
		reason += validateEmptyField(theForm.txtServicedBy,"Serviced by");
		reason += validateSpecialCharacters(theForm.txtServicedBy,"Serviced by");
	}	
	
	// Terms and Conditions
	reason += validateTermsConditions(theForm.chkTermsConditions); 

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
				call addReturn
		end if
	end if
end sub

call main

dim strMessageText
%>
</head>
<body>
<table align="center" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="border_1">&nbsp;</td>
    <td class="border_2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" class="login_column"><form action="" method="post" name="form_add_return" id="form_add_return" onsubmit="return validateFormOnSubmit(this)">
        <p>Our online Goods Return process has been implemented to speed up your request and provide you with a better experience from Yamaha. Please fill in and submit the form below.  The form will be processed by Aaron Chen, Internal Sales Support. Any correspondence regarding a Goods Return Request, will be via <a href="mailto:mpd_returns@gmx.yamaha.com">mpd_returns@gmx.yamaha.com</a></p>
        <h1>New Goods Return</h1>
        <h2>Fill in the details</h2>        
        <font color="red"><%= strMessageText %></font>
        <table width="100%">
          <tr>
            <td valign="top" width="50%"><table cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Dealer Details</td>
                </tr>
                <tr>
                  <td colspan="2">Dealer name<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerName" name="txtDealerName" maxlength="50" size="60" value="<%= Session("user_storename") %>" /></td>
                </tr>
                <tr>
                  <td width="50%">Contact name<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerContactName" name="txtDealerContactName" maxlength="40" size="35" value="<%= session("user_firstname") & " " & session("user_lastname") %>" /></td>
                  <td width="50%">Phone no<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerPhone" name="txtDealerPhone" maxlength="12" size="15" value="<%= session("user_phone") %>" /></td>
                </tr>
                <tr>
                  <td colspan="2">Email<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerEmail" name="txtDealerEmail" maxlength="60" size="60" value="<%= session("user_email") %>" /></td>
                </tr>
              </table></td>
            <td valign="top" width="50%"><table cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Stock Details</td>
                </tr>
                <tr>
                  <td width="50%">Item code<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtModelNo" name="txtModelNo" maxlength="25" size="35" value="<%= session("new_model_no") %>" /></td>
                  <td width="50%">Qty<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtQty" name="txtQty" maxlength="2" size="3" value="<%= session("new_qty") %>" /></td>
                </tr>
                <tr>
                  <td colspan="2">Serial no<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtSerialNo" name="txtSerialNo" maxlength="80" size="70" value="<%= session("new_serial_no") %>" /></td>
                </tr>
                <tr>
                  <td>Original invoice no<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtInvoiceNo" name="txtInvoiceNo" maxlength="15" size="20" value="<%= session("new_invoice_no") %>" /></td>
                  <td>Original invoice date<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtInvoiceDate" name="txtInvoiceDate" maxlength="10" size="10" value="<%= session("new_invoice_date") %>" />
                    <em>DD/MM/YYYY</em></td>
                </tr>
                <tr>
                  <td colspan="2">Reason for return<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtReason" name="txtReason" maxlength="120" size="95" value="<%= session("new_reason") %>" /></td>
                </tr>
                <tr>
                  <td colspan="2">Type:<br />
                    <select name="cboType" id="cboType">                      
                      <option value="F" <% if session("new_type") = "F" then Response.Write " selected" end if%> rel="none">Floor stock</option>
                      <option value="C" <% if session("new_type") = "C" then Response.Write " selected" end if%> rel="customer">Customer replacement</option>
                    </select></td>
                </tr>
                <tr rel="customer">
                  <td>Please specify customer name<span class="mandatory">*</span>:
                    <input type="text" id="txtCustomerName" name="txtCustomerName" maxlength="40" size="35" value="<%= session("new_customer_name") %>" /></td>
                  <td>Date sold to customer<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDatePurchased" name="txtDatePurchased" maxlength="10" size="10" value="<%= session("new_date_purchased") %>" />
                    <em>DD/MM/YYYY</em></td>
                </tr>
                <tr>
                  <td colspan="2">Has the product been serviced?<br />
                    <select name="cboServiced" id="cboServiced">                      
                      <option value="0" <% if session("new_serviced") = "0" then Response.Write " selected" end if%> rel="none">No</option>
                      <option value="1" <% if session("new_serviced") = "1" then Response.Write " selected" end if%> rel="yes">Yes</option>
                    </select></td>
                </tr>
                <tr rel="yes">
                  <td>If so, please specify when<span class="mandatory">*</span>:
                    <input type="text" id="txtDateServiced" name="txtDateServiced" maxlength="10" size="10" value="<%= Server.HTMLEncode(session("new_date_serviced")) %>" />
                    <em>DD/MM/YYYY</em></td>
                  <td>Serviced by:<br />
                    <input type="text" id="txtServicedBy" name="txtServicedBy" maxlength="30" size="30" value="<%= session("new_serviced_by") %>" /></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td colspan="2" align="center"><input type="checkbox" name="chkTermsConditions" id="chkTermsConditions" />
              I have read the <a href="terms-conditions.asp" target="_blank">Terms &amp; Conditions</a> and I await approval for return.
              <br />
              <input type="checkbox" name="chkPhoto" id="chkPhoto" value="Yes" /> Upload Photo
              <p>
                <input type="hidden" name="Action" />
                <input type="submit" value="Submit Goods Return" />
              </p></td>
          </tr>
        </table>
      </form></td>
  </tr>
  <tr>
    <td class="border_3">&nbsp;</td>
    <td class="border_4">&nbsp;</td>
  </tr>
</table>
<script type="text/javascript" src="../../include/moment.js"></script> 
<script type="text/javascript" src="../../include/pikaday.js"></script> 
<script type="text/javascript">	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtInvoiceDate'),
        firstDay: 1,
        minDate: new Date('2003-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2003,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDatePurchased'),
        firstDay: 1,
        minDate: new Date('2003-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2003,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateServiced'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
		format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>