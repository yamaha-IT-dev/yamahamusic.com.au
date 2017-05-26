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
<title>New Coop</title>
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
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.action.value = 'add';
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
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("action")) = "add" then			
			call addCoop
		end if
	end if	
end sub

call main
%>
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Co-op</a></li>
        <li class="active">New Co-op</li>
      </ol>
      <h1>New Co-op</h1>
      <form method="post" name="form_add_coop" id="form_add_coop" onsubmit="return validateFormOnSubmit(this)">
        <table border="0" cellpadding="5" cellspacing="0" class="main_form_table">
          <tr>
            <td width="30%">Project name<span class="mandatory">*</span>:</td>
            <td width="70%"><input type="text" id="txtName" name="txtName" maxlength="80" size="80" required /></td>
          </tr>
          <tr>
            <td>Budget<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtBudget" name="txtBudget" maxlength="200" size="100" required /></td>
          </tr>
          <tr>
            <td colspan="2">Is it an exclusive promotion/initiative of the brands that Yamaha distributes?</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><select name="cboExclusive" id="cboExclusive">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td colspan="2">If other brands are involved, what % is Yamaha's product representation?</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><select name="cboPercentage" id="cboPercentage">
                <option value="0">0</option>
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="30">30</option>
                <option value="40">40</option>
                <option value="50">50</option>
                <option value="60">60</option>
                <option value="70">70</option>
                <option value="80">80</option>
                <option value="90">90</option>
                <option value="100">100</option>
              </select>
              %</td>
          </tr>
          <tr>
            <td colspan="2">Do you have stock in-store to support this request? The stock must be available in-store to support this marketing initiative for the duration of the promotion.</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><select name="cboStockAvailability" id="cboStockAvailability">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
              <em>Please note, if you do not have satisfactory stock levels, your request will not be approved.</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Marketing Activity</td>
          </tr>
          <tr>
            <td valign="top">Advertising:</td>
            <td><input type="checkbox" name="chkAdvertising" id="chkAdvertising" value="Print">
              Print<br>
              <input type="checkbox" name="chkAdvertising" id="chkAdvertising" value="Radio">
              Radio<br>
              <input type="checkbox" name="chkAdvertising" id="chkAdvertising" value="TV">
              TV<br>
              <input type="checkbox" name="chkAdvertising" id="chkAdvertising" value="Cinema">
              Cinema<br>
              <input type="checkbox" name="chkAdvertising" id="chkAdvertising" value="Online">
              Online<br>
              <input type="checkbox" name="chkAdvertising" id="chkAdvertising" value="Adwords">
              Google Adwords </td>
          </tr>
          <tr>
            <td valign="top">Signage:</td>
            <td><input type="checkbox" name="chkSignage" id="chkSignage" value="Outdoor">
              Outdoor<br>
              <input type="checkbox" name="chkSignage" id="chkSignage" value="Indoor">
              Indoor<br>
              <input type="checkbox" name="chkSignage" id="chkSignage" value="Front Window">
              Front Window </td>
          </tr>
          <tr>
            <td valign="top">Promotional materials:</td>
            <td><input type="checkbox" name="chkPromotionalMaterial" id="chkPromotionalMaterial" value="Direct Mail">
              Direct Mail<br>
              <input type="checkbox" name="chkPromotionalMaterial" id="chkPromotionalMaterial" value="Catalogues">
              Catalogues<br>
              <input type="checkbox" name="chkPromotionalMaterial" id="chkPromotionalMaterial" value="Flyers">
              Flyers<br>
              <input type="checkbox" name="chkPromotionalMaterial" id="chkPromotionalMaterial" value="Posters">
              Posters<br>
              <input type="checkbox" name="chkPromotionalMaterial" id="chkPromotionalMaterial" value="Merchandise">
              Merchandise<br>
              <input type="checkbox" name="chkPromotionalMaterial" id="chkPromotionalMaterial" value="Tshirts">
              Tshirts</td>
          </tr>
          <tr>
            <td>Event:</td>
            <td><select name="cboEvent" id="cboEvent">
                <option value="Clinic">Clinic</option>
                <option value="Consumer Show">Consumer Show</option>
                <option value="Sale">Sale</option>
                <option value="Sponsorship">Sponsorship</option>
                <option value="Training">Training</option>
                <option value="Other">Other</option>
              </select></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Media Artwork / Placement for Advertising</td>
          </tr>
          <tr>
            <td>Outlet:</td>
            <td><input type="text" id="txtOutlet" name="txtOutlet" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>Size of advertisement:</td>
            <td><input type="text" id="txtAdSize" name="txtAdSize" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>No of placements:</td>
            <td><input type="text" id="txtNoPlacement" name="txtNoPlacement" maxlength="3" size="3"  /></td>
          </tr>
          <tr>
            <td>Date of Placement:</td>
            <td><input type="text" name="txtDatePlacement" id="txtDatePlacement" maxlength="10" size="10"  />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Yamaha to source media rates?</td>
            <td><select name="cboMediaSupplier" id="cboMediaSupplier">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Yamaha to complete artwork?</td>
            <td><select name="cboMediaArtwork" id="cboMediaArtwork">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Artwork Deadline:</td>
            <td><input type="text" name="txtArtworkDeadline" id="txtArtworkDeadline" maxlength="10" size="10"  />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Signage</td>
          </tr>
          <tr>
            <td>Placement:</td>
            <td><input type="text" id="txtSignagePlacement" name="txtSignagePlacement" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>Description:</td>
            <td><input type="text" id="txtSignageDescription" name="txtSignageDescription" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>Yamaha to source supplier?</td>
            <td><select name="cboSignageSupplier" id="cboSignageSupplier">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Yamaha to complete artwork?</td>
            <td><select name="cboSignageArtwork" id="cboSignageArtwork">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Date of Installation:</td>
            <td><input type="text" name="txtDateInstallation" id="txtDateInstallation" maxlength="10" size="10"  />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Promotional Materials</td>
          </tr>
          <tr>
            <td>Description:</td>
            <td><input type="text" id="txtMaterialDescription" name="txtMaterialDescription" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>Size:</td>
            <td><input type="text" id="txtMaterialSize" name="txtMaterialSize" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>No of pages:</td>
            <td><input type="text" id="txtMaterialNoPage" name="txtMaterialNoPage" maxlength="4" size="4"  /></td>
          </tr>
          <tr>
            <td>Qty:</td>
            <td><input type="text" id="txtMaterialQty" name="txtMaterialQty" maxlength="4" size="4"  /></td>
          </tr>
          <tr>
            <td>Distribution plan:</td>
            <td><input type="text" id="txtMaterialDistribute" name="txtMaterialDistribute" maxlength="80" size="80" placeholder="How will the promotional items be distributed?"  /></td>
          </tr>
          <tr>
            <td>Yamaha to source supplier?</td>
            <td><select name="cboMaterialSupplier" id="cboMaterialSupplier">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Yamaha to complete artwork?</td>
            <td><select name="cboMaterialArtwork" id="cboMaterialArtwork">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Promotional Material Deadline:</td>
            <td><input type="text" name="txtMaterialDeadline" id="txtMaterialDeadline" maxlength="10" size="10"  />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Event</td>
          </tr>
          <tr>
            <td>Outline:</td>
            <td><input type="text" id="txtEventOutline" name="txtEventOutline" maxlength="80" size="80" placeholder="Why do you want to hold this event?"  /></td>
          </tr>
          <tr>
            <td>Venue:</td>
            <td><input type="text" id="txtVenue" name="txtVenue" maxlength="80" size="80"  /></td>
          </tr>
          <tr>
            <td>Date:</td>
            <td><input type="text" name="txtEventDate" id="txtEventDate" maxlength="10" size="10"  />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Expected no of attendees:</td>
            <td><input type="text" id="txtNoAttendee" name="txtNoAttendee" maxlength="4" size="4"  /></td>
          </tr>
          <tr>
            <td>Marketing support from Yamaha?</td>
            <td><select name="cboMarketingSupport" id="cboMarketingSupport">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Need any Yamaha representative / artist?</td>
            <td><select name="cboYamahaArtist" id="cboYamahaArtist">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select></td>
          </tr>
        </table>
        <br>
        <div class="form-group">
          <input type="hidden" name="action" />
          <input type="submit" name="submit" id="submit" value="Submit" />
        </div>
        <p><span class="mandatory">*</span><em>Mandatory</em></p>
        <p>Please note that you are able to upload files after submitting this form by clicking <button type="button" class="btn btn-primary">UPLOAD FILE &raquo;</button></p>
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