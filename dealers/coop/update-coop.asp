<%
dim strSection
strSection = "coop"
%>
<!--#include file="../../include/connection.asp" -->
<!--#include file="../class/clsCoop.asp" -->
<!--#include file="../class/clsUser.asp" -->
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
<title>Update Co-op</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../include/pikaday.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script src="../../include/usableforms.js"></script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
		
	reason += validateEmptyField(theForm.txtName,"Project name");
	reason += validateSpecialCharacters(theForm.txtName,"Project name");
	
	reason += validateEmptyField(theForm.txtBudget,"Budget");
	reason += validateSpecialCharacters(theForm.txtBudget,"Budget");
	
	reason += validateNumeric(theForm.txtPercentage,"Percentage");
	
	// MEDIA
	
	reason += validateEmptyField(theForm.txtOutlet,"Outlet");
	reason += validateSpecialCharacters(theForm.txtOutlet,"Outlet");
	
	reason += validateEmptyField(theForm.txtAdSize,"Ad Size");
	reason += validateSpecialCharacters(theForm.txtAdSize,"Ad Size");
	
	reason += validateNumeric(theForm.txtNoPlacement,"No of Placement");
	
	reason += validateDate(theForm.txtDatePlacement,"Date Placement");
	
	reason += validateDate(theForm.txtArtworkDeadline,"Artwork Deadline");
	
	// SIGNAGE
	
	reason += validateEmptyField(theForm.txtSignagePlacement,"Signage Placement");
	reason += validateSpecialCharacters(theForm.txtSignagePlacement,"Signage Placement");
	
	reason += validateEmptyField(theForm.txtSignageDescription,"Signage Description");
	reason += validateSpecialCharacters(theForm.txtSignageDescription,"Signage Description");
	
	reason += validateDate(theForm.txtDateInstallation,"Date Installation");
		
	// PROMO MATERIAL	
		
	reason += validateEmptyField(theForm.txtMaterialDescription,"Material Description");
	reason += validateSpecialCharacters(theForm.txtMaterialDescription,"Material Description");
	
	reason += validateEmptyField(theForm.txtMaterialSize,"Material Size");
	reason += validateSpecialCharacters(theForm.txtMaterialSize,"Material Size");
	
	reason += validateNumeric(theForm.txtMaterialNoPage,"Material No of Pages");
	
	reason += validateNumeric(theForm.txtMaterialQty,"Material Qty");
	
	reason += validateEmptyField(theForm.txtMaterialDistribute,"Material Distribute");
	reason += validateSpecialCharacters(theForm.txtMaterialDistribute,"Material Distribute");
	
	reason += validateDate(theForm.txtMaterialDeadline,"Material Deadline");
	
	// EVENT
	
	reason += validateEmptyField(theForm.txtEventOutline,"Event Outline");
	reason += validateSpecialCharacters(theForm.txtEventOutline,"Event Outline");
	
	reason += validateEmptyField(theForm.txtVenue,"Venue");
	reason += validateSpecialCharacters(theForm.txtVenue,"Venue");
	
	reason += validateDate(theForm.txtEventDate,"Event Date");
	
	reason += validateNumeric(theForm.txtNoAttendee,"No Attendee");
	
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.action.value = 'update';
  		theForm.submit();
		
		return true;
    }
}
</script>
</head>
<body>
<!--#include file="../include/header_new.asp " -->
<%
sub main
	call validateLogin
	
	dim intID
	intID = Server.URLEncode(Request("id"))
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		Dim coopName, coopBudget, coopExclusive, coopPercentage, coopStockAvailability, coopAdvertising, coopSignage, coopPromotionalMaterial, coopEvent, coopOutlet, coopAdSize, coopNoPlacement, coopDatePlacement, coopMediaSupplier, coopMediaArtwork, coopArtworkDeadline, coopSignagePlacement, coopSignageDescription, coopSignageSupplier, coopSignageArtwork, coopDateInstallation, coopMaterialDescription, coopMaterialSize, coopMaterialNoPage, coopMaterialQty, coopMaterialDistribute, coopMaterialSupplier, coopMaterialArtwork, coopMaterialDeadline, coopEventOutline, coopVenue, coopEventDate, coopNoAttendee, coopMarketingSupport, coopYamahaArtist
		
		coopName 			= Server.HTMLEncode(Trim(Request(txtName))) 
		coopBudget			= Server.HTMLEncode(Trim(Request(txtBudget))) 
		coopExclusive		= Server.HTMLEncode(Trim(Request(cboExclusive))) 
		coopPercentage		= Server.HTMLEncode(Trim(Request(txtPercentage))) 
		coopStockAvailability = Server.HTMLEncode(Trim(Request(cboStockAvailability))) 
		coopAdvertising  	= Server.HTMLEncode(Trim(Request(txtAdvertising))) 
		coopSignage      	= Server.HTMLEncode(Trim(Request(txtSignage))) 
		coopPromotionalMaterial = Server.HTMLEncode(Trim(Request(txtPromotionalMaterial))) 
		coopEvent			= Server.HTMLEncode(Trim(Request(cboEvent))) 
		coopOutlet 			= Server.HTMLEncode(Trim(Request(cboOutlet))) 
		coopAdSize			= Server.HTMLEncode(Trim(Request(txtAdSize))) 
		coopNoPlacement 	= Server.HTMLEncode(Trim(Request(txtNoPlacement))) 
		coopDatePlacement	= Server.HTMLEncode(Trim(Request(txtDatePlacement))) 
		coopMediaSupplier	= Server.HTMLEncode(Trim(Request(cboMediaSupplier))) 
		coopMediaArtwork	= Server.HTMLEncode(Trim(Request(cboMediaArtwork))) 
		coopArtworkDeadline = Server.HTMLEncode(Trim(Request(txtArtworkDeadline))) 
		coopSignagePlacement = Server.HTMLEncode(Trim(Request(txtSignagePlacement))) 
		coopSignageDescription = Server.HTMLEncode(Trim(Request(txtSignageDescription))) 
		coopSignageSupplier	= Server.HTMLEncode(Trim(Request(cboSignageSupplier))) 
		coopSignageArtwork	= Server.HTMLEncode(Trim(Request(cboSignageArtwork))) 
		coopDateInstallation = Server.HTMLEncode(Trim(Request(txtDateInstallation))) 
		coopMaterialDescription = Server.HTMLEncode(Trim(Request(txtMaterialDescription))) 
		coopMaterialSize	= Server.HTMLEncode(Trim(Request(txtMaterialSize))) 
		coopMaterialNoPage	= Server.HTMLEncode(Trim(Request(txtMaterialNoPage))) 
		coopMaterialQty		= Server.HTMLEncode(Trim(Request(txtMaterialQty))) 
		coopMaterialDistribute = Server.HTMLEncode(Trim(Request(txtMaterialDistribute))) 
		coopMaterialSupplier = Server.HTMLEncode(Trim(Request(cboMaterialSupplier))) 
		coopMaterialArtwork	= Server.HTMLEncode(Trim(Request(cboMaterialArtwork))) 
		coopMaterialDeadline = Server.HTMLEncode(Trim(Request(txtMaterialDeadline))) 
		coopEventOutline	= Server.HTMLEncode(Trim(Request(txtEventOutline))) 
		coopVenue			= Server.HTMLEncode(Trim(Request(txtVenue))) 
		coopEventDate		= Server.HTMLEncode(Trim(Request(txtEventDate))) 
		coopNoAttendee		= Server.HTMLEncode(Trim(Request(txtNoAttendee))) 
		coopMarketingSupport = Server.HTMLEncode(Trim(Request(cboMarketingSupport))) 
		coopYamahaArtist	= Server.HTMLEncode(Trim(Request(cboYamahaArtist))) 
	
		if trim(request("action")) = "update" then
			call updateCoopRequest(coopName, coopBudget, coopExclusive, coopPercentage, coopStockAvailability, coopAdvertising, coopSignage, coopPromotionalMaterial, coopEvent, coopOutlet, coopAdSize, coopNoPlacement, coopDatePlacement, coopMediaSupplier, coopMediaArtwork, coopArtworkDeadline, coopSignagePlacement, coopSignageDescription, coopSignageSupplier, coopSignageArtwork, coopDateInstallation, coopMaterialDescription, coopMaterialSize, coopMaterialNoPage, coopMaterialQty, coopMaterialDistribute, coopMaterialSupplier, coopMaterialArtwork, coopMaterialDeadline, coopEventOutline, coopVenue, coopEventDate, coopNoAttendee, coopMarketingSupport, coopYamahaArtist)
		end if
	end if	
	
	if isNumeric(intID) then
		call getCoop(intID,Session("yma_userid"))
	else
		Response.Redirect("error.html")
	end if
end sub

call main
%>
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Co-op</a></li>
        <li class="active">Update Co-op</li>
      </ol>
      <h1>Update Co-op</h1>
      <form method="post" name="form_add_coop" id="form_add_coop" onsubmit="return validateFormOnSubmit(this)">
        <table border="0" cellpadding="5" cellspacing="0" class="main_form_table">
          <tr>
            <td width="30%">Project name<span class="mandatory">*</span>:</td>
            <td width="70%"><input type="text" id="txtName" name="txtName" maxlength="80" size="80" value="<%= session("coopName") %>" required /></td>
          </tr>
          <tr>
            <td>Budget<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtBudget" name="txtBudget" maxlength="80" size="80" value="<%= session("coopBudget") %>" required /></td>
          </tr>
          <tr>
            <td colspan="2">Is it an exclusive promotion/initiative of the brands that Yamaha distributes?</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><select name="cboExclusive" id="cboExclusive">
                <option <% if session("coopExclusive") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopExclusive") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td colspan="2">If other brands are involved, what percentage is Yamaha's product representation?</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="text" id="txtPercentage" name="txtPercentage" maxlength="3" size="4" value="<%= session("coopPercentage") %>" required />
              %</td>
          </tr>
          <tr>
            <td colspan="2">Do you have stock in-store to support this request? The stock must be available in-store to support this marketing initiative for the duration of the promotion.</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><p>
                <select name="cboStockAvailability" id="cboStockAvailability">
                  <option <% if session("coopStockAvailability") = "0" then Response.Write " selected" end if %> value="0">No</option>
                  <option <% if session("coopStockAvailability") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
                </select>
              </p>
              <p><em>Please note, if you do not have satisfactory stock levels, your request will not be approved.</em></p></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Marketing Activity</td>
          </tr>
          <tr>
            <td>Advertising:</td>
            <td><input type="text" id="txtAdvertising" name="txtAdvertising" maxlength="80" size="80" value="<%= session("coopAdvertising") %>" required /></td>
          </tr>
          <tr>
            <td>Signage:</td>
            <td><input type="text" id="txtSignage" name="txtSignage" maxlength="80" size="80" value="<%= session("coopSignage") %>" required /></td>
          </tr>
          <tr>
            <td>Promotional materials:</td>
            <td><input type="text" id="txtPromotionalMaterial" name="txtPromotionalMaterial" maxlength="80" size="80" value="<%= session("coopPromotionalMaterial") %>" required /></td>
          </tr>
          <tr>
            <td>Event:</td>
            <td><select name="cboEvent" id="cboEvent">
                <option <% if session("coopEvent") = "Clinic" then Response.Write " selected" end if %> value="Clinic">Clinic</option>
                <option <% if session("coopEvent") = "Consumer Show" then Response.Write " selected" end if %> value="Consumer Show">Consumer Show</option>
                <option <% if session("coopEvent") = "Sale" then Response.Write " selected" end if %> value="Sale">Sale</option>
                <option <% if session("coopEvent") = "Sponsorship" then Response.Write " selected" end if %> value="Sponsorship">Sponsorship</option>
                <option <% if session("coopEvent") = "Training" then Response.Write " selected" end if %> value="Training">Training</option>
                <option <% if session("coopEvent") = "Other" then Response.Write " selected" end if %> value="Other">Other</option>
              </select></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Media Artwork / Placement for Advertising</td>
          </tr>
          <tr>
            <td>Outlet<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtOutlet" name="txtOutlet" maxlength="80" size="80" value="<%= session("coopOutlet") %>" required /></td>
          </tr>
          <tr>
            <td>Size of advertisement<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtAdSize" name="txtAdSize" maxlength="80" size="80" value="<%= session("coopAdSize") %>" required /></td>
          </tr>
          <tr>
            <td>No of placements<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtNoPlacement" name="txtNoPlacement" maxlength="3" size="3" value="<%= session("coopNoPlacement") %>" required /></td>
          </tr>
          <tr>
            <td>Date of Placement<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtDatePlacement" id="txtDatePlacement" maxlength="10" size="10" value="<%= session("coopDatePlacement") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Yamaha to source media rates?</td>
            <td><select name="cboMediaSupplier" id="cboMediaSupplier">
                <option <% if session("coopMediaSupplier") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopMediaSupplier") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Yamaha to complete artwork?</td>
            <td><select name="cboMediaArtwork" id="cboMediaArtwork">
                <option <% if session("coopMediaArtwork") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopMediaArtwork") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Artwork Deadline<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtArtworkDeadline" id="txtArtworkDeadline" maxlength="10" size="10" value="<%= session("coopArtworkDeadline") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Signage</td>
          </tr>
          <tr>
            <td>Placement<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtSignagePlacement" name="txtSignagePlacement" maxlength="80" size="80" value="<%= session("coopSignagePlacement") %>" required /></td>
          </tr>
          <tr>
            <td>Description<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtSignageDescription" name="txtSignageDescription" maxlength="80" size="80" value="<%= session("coopSignageDescription") %>" required /></td>
          </tr>
          <tr>
            <td>Yamaha to source supplier?</td>
            <td><select name="cboSignageSupplier" id="cboSignageSupplier">
                <option <% if session("coopSignageSupplier") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopSignageSupplier") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Yamaha to complete artwork?</td>
            <td><select name="cboSignageArtwork" id="cboSignageArtwork">
                <option <% if session("coopSignageArtwork") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopSignageArtwork") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Date of Installation<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtDateInstallation" id="txtDateInstallation" maxlength="10" size="10" value="<%= session("coopDateInstallation") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Promotional Materials</td>
          </tr>
          <tr>
            <td>Description<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtMaterialDescription" name="txtMaterialDescription" maxlength="80" size="80" value="<%= session("coopMaterialDescription") %>" required /></td>
          </tr>
          <tr>
            <td>Size<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtMaterialSize" name="txtMaterialSize" maxlength="80" size="80" value="<%= session("coopMaterialSize") %>" required /></td>
          </tr>
          <tr>
            <td>No of pages<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtMaterialNoPage" name="txtMaterialNoPage" maxlength="4" size="4" value="<%= session("coopMaterialNoPage") %>" required /></td>
          </tr>
          <tr>
            <td>Qty<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtMaterialQty" name="txtMaterialQty" maxlength="4" size="4" value="<%= session("coopMaterialQty") %>" required /></td>
          </tr>
          <tr>
            <td>How will the promotional items be distributed?<span class="mandatory">*</span></td>
            <td><input type="text" id="txtMaterialDistribute" name="txtMaterialDistribute" maxlength="80" size="80" value="<%= session("coopMaterialDistribute") %>" required /></td>
          </tr>
          <tr>
            <td>Yamaha to source supplier?</td>
            <td><select name="cboMaterialSupplier" id="cboMaterialSupplier">
                <option <% if session("coopMaterialSupplier") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopMaterialSupplier") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Yamaha to complete artwork?</td>
            <td><select name="cboMaterialArtwork" id="cboMaterialArtwork">
                <option <% if session("coopMaterialArtwork") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopMaterialArtwork") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Promotional Material Deadline<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtMaterialDeadline" id="txtMaterialDeadline" maxlength="10" size="10" value="<%= session("coopMaterialDeadline") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Event</td>
          </tr>
          <tr>
            <td>Outline<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtEventOutline" name="txtEventOutline" maxlength="80" size="80" value="<%= session("coopEventOutline") %>" required /></td>
          </tr>
          <tr>
            <td>Venue<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtVenue" name="txtVenue" maxlength="80" size="80" value="<%= session("coopVenue") %>" required /></td>
          </tr>
          <tr>
            <td>Date<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtEventDate" id="txtEventDate" maxlength="10" size="10" value="<%= session("coopEventDate") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Expected no of attendees<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtNoAttendee" name="txtNoAttendee" maxlength="4" size="4" value="<%= session("coopNoAttendee") %>" required /></td>
          </tr>
          <tr>
            <td>Need marketing support from Yamaha?</td>
            <td><select name="cboMarketingSupport" id="cboMarketingSupport">
                <option <% if session("coopMarketingSupport") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopMarketingSupport") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Need Yamaha representative / artist?</td>
            <td><select name="cboYamahaArtist" id="cboYamahaArtist">
                <option <% if session("coopYamahaArtist") = "0" then Response.Write " selected" end if %> value="0">No</option>
                <option <% if session("coopYamahaArtist") = "1" then Response.Write " selected" end if %> value="1">Yes</option>
              </select></td>
          </tr>
        </table>
        <br>
        <div class="form-group">
          <input type="hidden" name="action" />
          <input type="submit" name="submit" id="submit" value="Update" />
        </div>
        <span class="mandatory">*</span> <em>Mandatory</em>
      </form></td>
  </tr>
</table>
<script src="../../include/moment.js"></script> 
<script src="../../include/pikaday.js"></script> 
<script>
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDatePlacement'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtArtworkDeadline'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateInstallation'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtMaterialDeadline'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtEventDate'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>