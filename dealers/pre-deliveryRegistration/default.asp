<!--#include file="../../include/connection.asp" -->
<!--#include file="class/clsPreDeliveryReg.asp" -->
<!--#include file="class/clsDealer.asp" -->

<%
sub main
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		response.write "TEST "			
		if Trim(Request("Action")) = "Register" then
		response.write "TEST 2"			
			if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
				response.write "SUBMITTING"			
				call addDealerPreDeliveryReg
			else
				response.write  Trim(Session("user_token")) & " AND " & Trim(Request.Form("UserToken")) 
			end if	
		end if
	else
		call getDealerList
		call getYASAList
		
	end if	
end sub

dim strDealerList, strMessageText,strYASAListList

call main
%>
<!doctype html>
<html>
<head>
<!--
<link rel="stylesheet" href="css/pikaday.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>

-->
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script>


function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateEmptyField(theForm.cboDealer,"Dealer");
	reason += validateEmptyField(theForm.txtModelNo,"Piano Model No");
	
	reason += validateEmptyField(theForm.txtSerialNo,"Serial No");
	reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial No");
	
	reason += validateEmptyField(theForm.txtPreDeliveryCertNo,"Pre Delivery Cert No");
	reason += validateSpecialCharacters(theForm.txtPreDeliveryCertNo,"Pre Delivery Cert No");
	
	reason += validateEmptyField(theForm.cboYASANo,"YASA Name");
	
	
	reason += validateCheckBox(theForm.chkTermsConditions,"Terms and Conditions");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);    	
		blnSubmit = false;
		
		$('#statusMsgBox').addClass("alert alert-danger");
		$('#statusMsgBox').append("<strong>Danger!</strong> Indicates a dangerous or potentially negative action.");
		return false;
  	}

	if (blnSubmit == true){
		$('#statusMsgBox').addClass("alert-success"); 
		$('#statusMsgBox').append("<strong>Successful </strong> Saved");
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
<title>Yamaha Piano Dealer Pre-Delivery Program</title>
</head>
<body>

<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
     <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Piano Dealer Pre-Delivery Registration</li>
      </ol>
   </td>
  </tr>
  <tr>
	<td>
		<div class="container">
		  <p><img src="../images/logoYamaha.jpg" /></p>
		  <h1 class="page-header">Piano Dealer Pre-Delivery Registration</h1>
		  <form method="post" role="form" onsubmit="return validateFormOnSubmit(this)">
				<div class="form-group">
					<label for="cboDealer">Dealer<span class="mandatory">*</span>:</label>
					<select id="cboDealer" name="cboDealer" class="form-control">
					  <%= strDealerList %>
					</select>
			   </div>
			   <div class="new_line">
				   <div class="form-group">
						<label for="txtModelNo">Piano Model Number<span class="mandatory">*</span>:</label>
						<input type="text" class="form-control" value="1111123"  id="txtModelNo" name="txtModelNo" placeholder="Piano ModelNo" maxlength="80" size="60" pattern=".{4,}" title="4 characters minimum" required>
				   </div>
			   </div>
			   <div class="new_line">
				   <div class="form-group">
						<label for="txtSerialNo">Serial No<span class="mandatory">*</span>:</label>
						<input type="text" class="form-control" id="txtSerialNo" name="txtSerialNo" placeholder="Serial No" maxlength="9" value="1111123" size="12" pattern=".{6,}" title="6 digit minimum" required>
						<em>The serial no is on the right hand side of the piano under the music rest, stamped into the iron frame. It is 7-digit long.<br>
						Otherwise it is written on the warranty booklet. <a href="images/img_serial-num-location.jpg" target="_blank">(How to find your serial no)</a></em>
					</div>
			   </div>

			   
				<div class="new_line">
				  <div class="form-group">
					<label for="txtSerialNo">Pre-Delivery certificate number<span class="mandatory">*</span>:</label>        
					<input type="text" class="form-control" value="1111123"  id="txtPreDeliveryCertNo" name="txtPreDeliveryCertNo" placeholder="Pre-Delivery certificate number" maxlength="6" size="15" pattern=".{6,}" title="6 digit minimum" required>
				  </div>
				</div>
				<div class="new_line">
				   <div class="form-group">
						<label for="cboYASANo">YASA name<span class="mandatory">*</span>:</label>        
						 <select id="cboYASANo" name="cboYASANo" class="form-control">
							  <%= strYASAListList %>
						</select>
					</div>
			   </div>
				  
				
				<div class="new_line">
				     <div class="form-group">
						<label for="chkTermsConditions">
						<input type="checkbox" name="chkTermsConditions" id="chkTermsConditions" /> I have read &amp; understood the <a href="terms-conditions.html" target="_blank">Terms &amp; Conditions</a></label>
						<input type="hidden" name="Action" />        
						
					</div>
					<input type="submit" name="submit" id="submit" value="Register" />
			    </div>
				
				</form>			
			</div>
				
		  
		  <%= strMessageText %>
		</div>
	</td>
	</tr>
</table>

<div id='statusMsgBox'>
  
</div>
</body>
</html>