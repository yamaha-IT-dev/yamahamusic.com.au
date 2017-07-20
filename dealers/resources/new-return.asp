<%
dim strSection
strSection = "returns"
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsUser.asp " -->
<!--#include file="class/clsGoodsReturn.asp " -->
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
<title>Goods Return</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../include/pikaday.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<script src="../../include/usableforms.js"></script>
<script src="../../include/generic_form_validations.js"></script>

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
	//reason += validateTermsConditions(theForm.chkTermsConditions); 

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
	call validateLogin
	call getUser(Session("yma_userid"))
		
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
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="return.asp">Return</a></li>
        <li class="active">New Goods Return</li>
      </ol>
      <form action="" method="post" name="form_add_return" id="form_add_return" onsubmit="return validateFormOnSubmit(this)">
        <h1>New Goods Return</h1>
        <font color="red"><%= strMessageText %></font>
        <table width="100%">
          <tr>
            <td valign="top" width="50%"><table cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Dealer Details</td>
                </tr>
                <tr>
                  <td colspan="2">Dealer name<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerName" name="txtDealerName" maxlength="50" size="60" value="<%= Session("user_storename") %>" required /></td>
                </tr>
                <tr>
                  <td width="50%">Contact name<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerContactName" name="txtDealerContactName" maxlength="40" size="35" value="<%= session("user_firstname") & " " & session("user_lastname") %>" required /></td>
                  <td width="50%">Phone no<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerPhone" name="txtDealerPhone" maxlength="12" size="15" value="<%= session("user_phone") %>" required /></td>
                </tr>
                <tr>
                  <td colspan="2">Email<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDealerEmail" name="txtDealerEmail" maxlength="60" size="60" value="<%= session("user_email") %>" required /></td>
                </tr>
              </table></td>
            <td valign="top" width="50%"><table cellpadding="5" cellspacing="0" class="form_box">
                <tr>
                  <td colspan="2" class="form_header">Stock Details</td>
                </tr>
                <tr>
                  <td width="50%">Item code<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtModelNo" name="txtModelNo" maxlength="25" size="35" value="<%= session("new_model_no") %>" required /></td>
                  <td width="50%">Qty<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtQty" name="txtQty" maxlength="2" size="3" value="<%= session("new_qty") %>" required /></td>
                </tr>
                <tr>
                  <td colspan="2">Serial no<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtSerialNo" name="txtSerialNo" maxlength="80" size="70" value="<%= session("new_serial_no") %>" required /></td>
                </tr>
                <tr>
                  <td>Original invoice no<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtInvoiceNo" name="txtInvoiceNo" maxlength="15" size="20" value="<%= session("new_invoice_no") %>" required /></td>
                  <td>Original invoice date<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtInvoiceDate" name="txtInvoiceDate" maxlength="10" size="10" value="<%= session("new_invoice_date") %>" required />
                    <em>DD/MM/YYYY</em></td>
                </tr>
                <tr>
                  <td colspan="2">Reason for return<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtReason" name="txtReason" maxlength="120" size="70" value="<%= session("new_reason") %>" required /></td>
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
                    <input type="text" id="txtCustomerName" name="txtCustomerName" maxlength="40" size="35" value="<%= session("new_customer_name") %>" required /></td>
                  <td>Date sold to customer<span class="mandatory">*</span>:<br />
                    <input type="text" id="txtDatePurchased" name="txtDatePurchased" maxlength="10" size="10" value="<%= session("new_date_purchased") %>" required />
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
                <tr><td colspan="2"><input type="checkbox" name="chkPhoto" id="chkPhoto" value="Yes" />
          <label for="chkPhoto">Upload Photo</label></td></tr>
              </table></td>
          </tr>
        </table>
        <input type="hidden" name="Action" />
        <input type="submit" name="submit" id="submit" value="Submit" />
      </form></td>
  </tr>
</table>
<script src="../../include/moment.js"></script> 
<script src="../../include/pikaday.js"></script> 
<script>	
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