<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsPremiumCustomer.asp" -->
<!--#include file="class/clsDealer.asp" -->
<!--#include file="class/clsToken.asp" -->
<%
sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if Trim(Request("Action")) = "Register" then
			if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
				'response.write "SUBMITTING"
				call addPremiumCustomer
			end if	
		end if
	else
		call getDealerList
		call createToken
	end if	
end sub

dim strDealerList, strMessageText

call main
%>
<!doctype html>
<html>
<head>
<link rel="stylesheet" href="css/pikaday.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script>
$(function() {
	var availableTags = 
	["C1","C109BPE","C109BPM","C109BPW","C113","C113BM","C113BPE","C113TBPE","C113TBPW","C1LZPE","C1M","C1MPE","C1PEQ","C1XPE","C2","C2LPE","C2LSAW","C2LZPE","C2M","C2MPAW","C2MPE","C2MPM","C2XPE","C3","C3LPE","C3LZPE","C3M","C3MEP","C3MPE","C3PE","C3XPE","C3XPWH","C5","C5LPE","C5LZPE","C5M","C5MPE","C5XPE","C6","C6LPE","C6LZPE","C6M","C6MDE","C6MPE","C6XPE","C7","C7LPE","C7LZPE","C7M","C7MPE","C7XPE","CFIIISAPEFA","CFXPE","CX2PE","DC2","DC2M4PWH","DC3M","DC3M4","DC3MM4PE","DC3MM4PRO","DC5","DC5MK","DC5MM4PE","DC5MM4PRO","DC5XE3PRO","DC7MM4PE","DC7MM4PWH","DC7XE3PRO","DGB1KE3PE","DGC1","DGC1MM4","DGC1MM4PE","DGC2E3PE","DU1E3PE","GB1","GB1K","GB1KG","GB1KPAW","GB1KPE","GB1KPM","GB1KSPE","GBK1PE","GC1","GB1KG","GC1LZPE","GC1M","GC1MDE","GC1MPAW","GC1MPE","GC1MPWH","GC1PAW","GC1PE","GC1PWH","JU109","JU109-SILENTPE","JU109PE","JU109PM","JU109PW","JU109PWH","JX113","JX113CP","JX113SG2PE","JX113TPE","JX113T-SILENTPE","JX113TPE","S4BBPE","S6BB","S6BBPE","T121","T121PE","U1JPE","U1PEQ","U1PE","U1","U1-SILENT","U13","U1J","U1J-SILENTPE","U1JCP","U1JMPE","U1JPE","U1JPM","U1JPWHC","U1JSG2PE","U1PE","U1PEQ","U3","U3MPE","U3PE","U3PEQ","U3PEZ","UIJPE","UJPEQ","YU3PE","YU55","YUS1","YUS1PE","YUS1PDAW","YUS1PE","YUS1SHPE","YUS3","YUS3PE","YUS5","YUS5PE","YUS5PEQ","YUS5SHPE"];
	
	$( "#txtProduct" ).autocomplete({
		source: availableTags
	});
});
</script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateEmptyField(theForm.txtFirstName,"First Name");
	reason += validateSpecialCharacters(theForm.txtFirstName,"First Name");
	
	reason += validateEmptyField(theForm.txtLastName,"Last Name");
	reason += validateSpecialCharacters(theForm.txtLastName,"Last Name");
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	reason += validateSpecialCharacters(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	reason += validateSpecialCharacters(theForm.txtCity,"City");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	reason += validateSpecialCharacters(theForm.txtPostcode,"Postcode");
	
	reason += validateSpecialCharacters(theForm.txtPhone,"Phone");
	
	reason += validateEmail(theForm.txtEmail);
	
	reason += validateEmptyField(theForm.txtProduct,"Product");
	reason += validateSpecialCharacters(theForm.txtProduct,"Product");
	
	reason += validateDate(theForm.txtPurchaseDate,"Purchase Date");
	reason += validateSpecialCharacters(theForm.txtPurchaseDate,"Purchase Date");
	
	reason += validateDate(theForm.txtDeliveryDate,"Delivery Date");
	reason += validateSpecialCharacters(theForm.txtDeliveryDate,"Delivery Date");
		
	reason += validateEmptyField(theForm.txtSerialNo,"Serial No");
	reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial No");
	
	reason += validateEmptyField(theForm.cboDealer,"Dealer");
	
	// E5
	//reason += validateEmptyField(theForm.txtPreDelRegCertNo,"Pre Delivery RegCertNo");
	
	
	reason += validateCheckBox(theForm.chkTermsConditions,"Terms and Conditions");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Register';  
		
		return true;
    }
}
</script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="../js/html5shiv.js"></script>
  <script src="../js/respond.js"></script>
<![endif]--> 
<title>Yamaha Premium Piano Care Program</title>
</head>
<body>
<div class="container">
  <p><img src="../images/new_yamaha_logo.png" /></p>
  <h1 class="page-header">Premium Piano Care Registration</h1>
  <form method="post" role="form" onsubmit="return validateFormOnSubmit(this)">
    <div class="float_left">
      <div class="form-group">
        <label for="txtFirstName">First Name<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtFirstName" name="txtFirstName" placeholder="First name" maxlength="50" size="30" pattern=".{2,}" title="2 characters minimum" required>
      </div>
    </div>
    <div class="float_left">
      <div class="form-group">
        <label for="txtLastName">Surname<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtLastName" name="txtLastName" placeholder="Last name" maxlength="50" size="30" pattern=".{2,}" title="2 characters minimum" required>
      </div>
    </div>
    <div class="new_line">
      <div class="form-group">
        <label for="txtAddress">Address<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtAddress" name="txtAddress" placeholder="Address" maxlength="80" size="60" pattern=".{4,}" title="4 characters minimum" required>
      </div>
    </div>
    <div class="float_left">
      <div class="form-group">
        <label for="txtCity">Suburb<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtCity" name="txtCity" placeholder="City" maxlength="30" size="30" pattern=".{3,}" title="3 characters minimum" required>
      </div>
    </div>
    <div class="float_left">
      <div class="form-group">
        <label for="cboState">State:</label>
        <select name="cboState" id="cboState" class="form-control">
          <option value="VIC">VIC</option>
          <option value="NSW">NSW</option>
          <option value="ACT">ACT</option>
          <option value="QLD">QLD</option>
          <option value="NT">NT</option>
          <option value="WA">WA</option>
          <option value="SA">SA</option>
          <option value="TAS">TAS</option>
        </select>
      </div>
    </div>
    <div class="float_left">
      <div class="form-group">
        <label for="txtPostcode">Postcode<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtPostcode" name="txtPostcode" placeholder="Postcode" maxlength="4" size="5" pattern=".{4,}" title="4 digit minimum" required>
      </div>
    </div>
    <div class="new_line">
      <div class="form-group">
        <label for="txtPhone">Phone:</label>
        <input type="text" class="form-control" id="txtPhone" name="txtPhone" placeholder="Phone" maxlength="12" size="15" pattern=".{6,}" title="6 digit minimum" required>
      </div>
      <div class="form-group">
        <label for="txtEmail">Email<span class="mandatory">*</span>:</label>
        <input type="email" class="form-control" id="txtEmail" name="txtEmail" placeholder="Email" maxlength="60" size="60" pattern=".{6,}" title="6 characters minimum" required>
      </div>
      <div class="form-group">
        <label for="txtProduct">Purchased Piano<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtProduct" name="txtProduct" placeholder="Purchased Piano" maxlength="40" size="50" pattern=".{2,}" title="2 characters minimum" required>
      </div>
    </div>
    <div class="float_left">
      <div class="form-group">
        <label for="txtPurchaseDate">Purchase Date<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtPurchaseDate" name="txtPurchaseDate" placeholder="Purchase Date" maxlength="10" size="15" required>
      </div>
    </div>
    <div class="float_left">
      <div class="form-group">
        <label for="txtDeliveryDate">Delivery Date<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtDeliveryDate" name="txtDeliveryDate" placeholder="Delivery Date" maxlength="10" size="15" required>
      </div>
    </div>
    <div class="new_line">
      <div class="form-group">
        <label for="txtSerialNo">Serial No<span class="mandatory">*</span>:</label>
        <input type="text" class="form-control" id="txtSerialNo" name="txtSerialNo" placeholder="Serial No" maxlength="9" size="12" pattern=".{6,}" title="6 digit minimum" required>
        <em>The serial no is on the right hand side of the piano under the music rest, stamped into the iron frame. It is 7-digit long.<br>
        Otherwise it is written on the warranty booklet. <a href="images/img_serial-num-location.jpg" target="_blank">(How to find your serial no)</a></em>
      </div>
	  
	  <!-- E5 -->
	   <div class="form-group">
        <label for="txtPreDelRegCertNo">Pre-Delivery Certificate number:</label>
        <input type="text" class="form-control" id="txtPreDelRegCertNo" name="txtPreDelRegCertNo" placeholder="Pre-Delivery Certificate number" maxlength="7" size="12" pattern=".{7,}" title="6 digit minimum" required>
        <em>required for purchases made from July 15th 2017</em>
      </div>
	  
	  
      <div class="form-group">
        <label for="cboDealer">Dealer<span class="mandatory">*</span>:</label>
        <select id="cboDealer" name="cboDealer" class="form-control">
          <%= strDealerList %>
        </select>
      </div>
      <!--<div class="form-group">        
        <label for="chkCashBack">
        <input type="checkbox" name="chkCashBack" id="chkCashBack" value="1" /> Summer Factory Cashback promotion (Selected dealers only, proof of purchase required) I have read &amp; understood the <a href="../summercashback/terms/" target="_blank">Terms &amp; Conditions of the Factory Cashback promotion</a></label>
      </div>-->
      <div class="form-group">
        <label for="txtComments">Comments:</label>
        <input type="text" class="form-control" id="txtComments" name="txtComments" placeholder="Comments" maxlength="80" size="80">
      </div>
      <div class="form-group">        
        <label for="chkTermsConditions">
        <input type="checkbox" name="chkTermsConditions" id="chkTermsConditions" /> I have read &amp; understood the <a href="terms-conditions.html" target="_blank">Terms &amp; Conditions</a></label></div>
        <input type="hidden" name="Action" />
        <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
      <input type="submit" name="submit" id="submit" value="Register" />
    </div>
  </form>
  <%= strMessageText %>
</div>
<script type="text/javascript" src="js/moment.js"></script> 
<script type="text/javascript" src="js/pikaday.js"></script> 
<script type="text/javascript">	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtPurchaseDate'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDeliveryDate'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
		format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>