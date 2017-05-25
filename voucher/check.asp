<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsVoucher.asp" -->
<%
sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if Trim(Request("action")) = "check" then
			dim intID				
			intID = Trim(Request.Form("txtID"))
			call checkVoucher(intID)
		end if
	end if
end sub

call main

dim intVoucherRedeemed
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
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateNumeric(theForm.txtID,"ID");
	reason += validateSpecialCharacters(theForm.txtID,"ID");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.action.value = 'check';  
		
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
<title>Voucher Check</title>
</head>
<body>
<div class="container">
  <p><img src="images/logo_yamaha.jpg" /></p>
  <h1>Yamaha Tuning Voucher Check</h1>
  <form action="" method="post" name="form_check" id="form_check" onsubmit="return validateFormOnSubmit(this)">
    <div class="form-group">
      <label for="txtEmail">Voucher ID<font color="red">*</font>:</label>
      <input type="text" class="form-control" name="txtID" id="txtID" placeholder="Voucher ID" maxlength="4" size="4" required />
    </div>
    <div class="form-group">
      <input type="hidden" name="action" />
      <input type="submit" name="submit" id="submit" class="btn btn-default" value="Check" />
    </div>
  </form>
  <% if not isnull(intVoucherRedeemed) then %>
	  <% if intVoucherRedeemed = "1" then %>
      <h3 style="color:red">This voucher has been redeemed</h3>
      <% end if %>
      <% if intVoucherRedeemed = "0" then %>
      <h3 style="color:green">This voucher is valid</h3>
	  <% end if %>
  <% end if %>
</div>
</body>
</html>