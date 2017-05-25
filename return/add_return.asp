<% response.cookies("current_URL_cookie_gra") = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Querystring %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="../include/FRM_build_form.asp " -->
<!--#include file="../include/functions.asp " -->
<!--#include file="class/clsGRA.asp " -->
<!--#include file="class/clsUser.asp " -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Goods Return Authority - New Goods Return</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<link rel="stylesheet" href="../include/pikaday.css" type="text/css" />
<script type="text/javascript" src="../include/usableforms.js"></script>
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
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
	
	reason += validateEmptyField(theForm.txtModelNo,"Model No");
	reason += validateSpecialCharacters(theForm.txtModelNo,"Model No");
	reason += validateEmptyField(theForm.txtSerialNo,"Serial No");
	reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial No");
	reason += validateEmptyField(theForm.txtInvoiceNo,"Invoice No");
	reason += validateSpecialCharacters(theForm.txtInvoiceNo,"Invoice No");
	reason += validateDate(theForm.txtInvoiceDate,"Invoice Date");
	reason += validateEmptyField(theForm.txtClaimNo,"Claim No");
	reason += validateSpecialCharacters(theForm.txtClaimNo,"Claim No");
	reason += validateEmptyField(theForm.txtQty,"No of Carton(s)");
	reason += validateSpecialCharacters(theForm.txtQty,"No of Carton(s)");
	reason += validateEmptyField(theForm.cboReason,"Reason");
	reason += validateEmptyField(theForm.txtFault,"Nature of fault");
	reason += validateEmptyField(theForm.txtTests,"Tests performed to verify fault");
	reason += validateEmptyField(theForm.cboAccessories,"Accessories complete");
	reason += validateEmptyField(theForm.cboPackaging,"Boxes");
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
	call UTL_validateLogin
	call getUserDetails(Session("UsrUserID"))
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Add" then
			call setAddGraSessions
			call checkSerialNo
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
    <td valign="top"><form action="" method="post" name="form_add_return" id="form_add_return" onsubmit="return validateFormOnSubmit(this)">
        <table border="0" width="100%" cellpadding="4" cellspacing="0">
          <tr>
            <td colspan="3" align="left"><font color="red"><%= strMessageText %></font>
              <h1 align="center">New Goods Return (step 1 of 2)</h1>              
              <h3 align="center"><u>1. Fill in the Return details</u></h3>
              <h3 align="center">2. Upload your receipt</h3></td>
          </tr>
          <tr>
            <td colspan="3"><h3>1. Product details:</h3></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><table width="100%" border="0" cellspacing="4" cellpadding="0">
                <tr>
                  <td width="20%">Model no<span class="mandatory">*</span>:</td>
                  <td width="80%"><input type="text" name="txtModelNo" id="txtModelNo" maxlength="30" size="35" value="<%= session("add_model_no") %>" /></td>
                </tr>
                <tr>
                  <td>Serial no<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtSerialNo" id="txtSerialNo" maxlength="30" size="35" value="<%= session("add_serial_no") %>" /></td>
                </tr>
                <tr>
                  <td>Yamaha invoice no<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtInvoiceNo" id="txtInvoiceNo" maxlength="30" size="35" value="<%= session("add_invoice_no") %>" /></td>
                </tr>
                <tr>
                  <td>Invoice date<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtInvoiceDate" id="txtInvoiceDate" maxlength="10" size="20" value="<%= session("add_date_purchased") %>"  />
                    <em>DD/MM/YYYY</em></td>
                </tr>
                <tr>
                  <td>Claim no<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtClaimNo" id="txtClaimNo" maxlength="30" size="35" value="<%= session("add_claim_no") %>" /></td>
                </tr>
				<tr>
                  <td>No of Carton(s)<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtQty" id="txtQty" maxlength="30" size="35" value="<%= session("add_qty") %>" /></td>
                </tr>
                <tr>
                  <td>Replacement order no:</td>
                  <td><input type="text" name="txtOrderNo" id="txtOrderNo" maxlength="30" size="35" value="<%= session("add_order_no") %>" /></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td colspan="3"><h3>2. Reason for return<span class="mandatory">*</span>:
                <select name="cboReason">
                  <option value="">...</option>
                  <option <% if session("add_reason") = "1" then Response.Write " selected" end if %> value="1">1. Damaged In Transit / Dead On Arrival (Under 2 weeks old)</option>
                  <option <% if session("add_reason") = "2" then Response.Write " selected" end if %> value="2">2. Faulty - Display Model (Under 2 weeks old)</option>
                  <option <% if session("add_reason") = "3" then Response.Write " selected" end if %> value="3">3. Faulty - Customer Purchase (Under 2 months old)</option>
                  <option <% if session("add_reason") = "4" then Response.Write " selected" end if %> value="4">4. Faulty - 3rd Time (2 verified services by Authorised Yamaha Service Agent and within warranty period)</option>
                  <option <% if session("add_reason") = "5" then Response.Write " selected" end if %> value="5">5. Yamaha Sales Manager Nominates Return</option>
                </select>
              </h3></td>
          </tr>
          <tr>
            <td colspan="3">Customer purchased date:
              <input type="text" name="txtDatePurchased" id="txtDatePurchased" maxlength="10" size="20" value="<%= session("xxx") %>"  />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="3"><h3>3. Describe nature of fault<span class="mandatory">*</span>:</h3></td>
          </tr>
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="90%" colspan="2"><textarea name="txtFault" id="txtFault" cols="90" rows="3" onkeydown="limitText(this.form.txtFault,this.form.countdown,300);" 
onkeyup="limitText(this.form.txtFault,this.form.countdown,300);"><%= session("add_fault") %></textarea>
              <em>Max: 300 characters</em></td>
          </tr>
          <tr>
            <td colspan="3"><h3>4. Detailed Description of Tests Performed to verify fault<span class="mandatory">*</span>:</h3></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><textarea name="txtTests" id="txtTests" cols="90" rows="3" onkeydown="limitText(this.form.txtTests,this.form.countdown,300);" 
onkeyup="limitText(this.form.txtTests,this.form.countdown,300);"><%= session("add_tests") %></textarea>
              <em>Max: 300 characters</em></td>
          </tr>
          <tr>
            <td colspan="3"><h3>5. Have you ensured that all accessories are complete?<span class="mandatory">*</span>
                <select name="cboAccessories">
                  <option value="">...</option>
                  <option <% if session("add_accessories") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
                  <option <% if session("add_accessories") = "0" then Response.Write " selected" end if %> value="0">No</option>
                </select>
              </h3></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><em><strong>Please note that missing accessories will be charged as below:</strong></em></td>
            <td><em><strong>Replacement cost (inc. GST)</strong></em></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Instruction Manual</td>
            <td>$15.00</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Remote Control</td>
            <td>$27.50</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Cables &amp; Interconnects</td>
            <td>$5.50</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ AM &amp; FM Antenna</td>
            <td>$5.50</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ YPAO / Intellibeam microphone</td>
            <td>$22.00</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Admin fee</td>
            <td>$15.00</td>
          </tr>
          <tr>
            <td colspan="3"><h3>6. Please select one to indicate the following has been checked<span class="mandatory">*</span>:
                <select name="cboPackaging">
                  <option value="">...</option>
                  <option <% if session("add_packaging") = "1" then Response.Write " selected" end if %> value="1">Original / suitable carton(s)</option>
                  <option <% if session("add_packaging") = "2" then Response.Write " selected" end if %> value="2">Original / suitable protective packaging</option>
                  <option <% if session("add_packaging") = "3" then Response.Write " selected" end if %> value="3">Once packed ensure cartons are properly sealed</option>
                </select>
              </h3></td>
          </tr>
          <tr>
            <td colspan="3" bgcolor="#CCCCCC"><input type="checkbox" name="chkTermsConditions" id="chkTermsConditions" />
              I am authorised to act on behalf on the store named on this form and I have read the <a href="terms-conditions.asp" target="_blank">Terms &amp; Conditions</a>.</td>
          </tr>
          <tr>
            <td colspan="3"><p align="center">
                <input type="hidden" name="Action" />
                <input type="submit" value="Submit" />
                <input type="reset" value="Reset">
              </p>
              <p><img src="images/backward_arrow.gif" width="6" height="12" border="0" /> <a href="home.asp">Back to Home</a></p></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
<script type="text/javascript" src="../include/moment.js"></script> 
<script type="text/javascript" src="../include/pikaday.js"></script> 
<script type="text/javascript">	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtInvoiceDate'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
		format: 'DD/MM/YYYY'
    });
	
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