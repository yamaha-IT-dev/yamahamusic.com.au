<!doctype html>
<html>
<head>
<link rel="stylesheet" href="../include/pikaday.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="include/simple.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script>
$(function() {
    var availableTags;

    $.get("../productsAll.txt", function(data, status) {
        if ("success" == status) {
            availableTags = data.split(",")
        };
        $("#txtModelNo").autocomplete({
            source: availableTags
        });
    });


    $.get("getServiceCentres.asp", function(data, status) {
        if ("success" == status) {
            availableTags = data.split(",")
        };
        $("#txtServiceCentre").autocomplete({
            source: availableTags
        });
    });
	
});
</script>
<script>
function validateRating(fld,errormsg) {
    var error = "";
	
    if ((fld[0].checked == false) && (fld[1].checked == false) && (fld[2].checked == false) && (fld[3].checked == false)) {
       error = "- " + errormsg + " is empty.\n"
    } 
    return error;
}

function validateYesNo(fld,errormsg) {
    var error = "";
	
    if ((fld[0].checked == false) && (fld[1].checked == false)) {
       error = "- " + errormsg + " is empty.\n"
    } 
    return error;
}

function validateSatisfaction(fld,errormsg) {
    var error = "";
	
    if ((fld[0].checked == false) && (fld[1].checked == false) && (fld[2].checked == false)) {
       error = "- " + errormsg + " is empty.\n"
    } 
    return error;
}

function validateFormOnSubmit(theForm) {
	var reason 		= "";
	var blnSubmit 	= true;
	
	reason += validateEmptyField(theForm.txtName,"Name");
	reason += validateSpecialCharacters(theForm.txtName,"Name");
	
	reason += validateEmail(theForm.txtEmail);
	
	reason += validateEmptyField(theForm.txtServiceCentre,"Service Centre");
	reason += validateSpecialCharacters(theForm.txtServiceCentre,"Service Centre");
	
	reason += validateEmptyField(theForm.txtModelNo,"Model No");
	reason += validateSpecialCharacters(theForm.txtModelNo,"Model No");
	
	reason += validateEmptyField(theForm.cboFind,"Find us");
	
	if (theForm.cboFind.value == "0")
	{
		reason += validateEmptyField(theForm.txtFindOther,"Other");
		reason += validateSpecialCharacters(theForm.txtFindOther,"Other");
	}
	
	reason += validateRating(theForm.radLocation,"Location"); //2
	
	reason += validateRating(theForm.radAppearance,"Appearance"); //3
	
	reason += validateRating(theForm.radAttitude,"Attitude"); //4
	
	reason += validateRating(theForm.radKnowledge,"Knowledge"); //5
	
	reason += validateDate(theForm.txtDateRepair,"Date Repair"); //6
	reason += validateSpecialCharacters(theForm.txtDateRepair,"Date Repair");
	
	reason += validateDate(theForm.txtDateCompleted,"Date Completed"); //7
	reason += validateSpecialCharacters(theForm.txtDateCompleted,"Date Completed");
	
	reason += validateRating(theForm.radSpeed,"Speed");	//8
	
	reason += validateYesNo(theForm.radFixed,"Fixed"); //9
	
	reason += validateSatisfaction(theForm.radSatisfaction,"Satisfaction");	 //10
	
	reason += validateYesNo(theForm.radCharged,"Charged"); //11
	
	if (theForm.radCharged[0].checked == 1)
	{
		reason += validateNumeric(theForm.txtCost,"Repair Cost");
		reason += validateSpecialCharacters(theForm.txtCost,"Repair Cost");
	}
	
	reason += validateRating(theForm.radService,"Overall Service");	 //12	
	
	reason += validateEmptyField(theForm.txtComments,"Comments");
	reason += validateSpecialCharacters(theForm.txtComments,"Comments");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Submit';
		
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
<title>Yamaha Customer Quality Survey</title>
</head>
<body>
<!--#include file="../include/connection.asp " --> 
<!--#include file="class/clsSurvey.asp" --> 
<!--#include file="class/clsToken.asp" -->
<%
sub submitSurvey
	dim strSQL
	
	Session("customer_name") 	= Replace(Trim(Request.Form("txtName")),"'","''")
	Session("customer_email") 	= Trim(Request.Form("txtEmail"))
	Session("service_centre") 	= Replace(Trim(Request.Form("txtServiceCentre")),"'","''")
	Session("model_no") 		= Replace(Trim(Request.Form("txtModelNo")),"'","''")	
	Session("find") 			= Trim(Request.Form("cboFind"))
	Session("find_other") 		= Replace(Trim(Request.Form("txtFindOther")),"'","''")
	Session("service") 			= Trim(Request.Form("radService"))
	Session("fixed") 			= Trim(Request.Form("radFixed"))
	Session("location") 		= Trim(Request.Form("radLocation"))
	Session("appearance") 		= Trim(Request.Form("radAppearance"))
	Session("attitude") 		= Trim(Request.Form("radAttitude"))
	Session("knowledge") 		= Trim(Request.Form("radKnowledge"))
	Session("date_repair") 		= Trim(Request.Form("txtDateRepair"))
	Session("date_completed") 	= Trim(Request.Form("txtDateCompleted"))
	Session("speed") 			= Trim(Request.Form("radSpeed"))
	Session("satisfaction") 	= Trim(Request.Form("radSatisfaction"))
	Session("charged") 			= Trim(Request.Form("radCharged"))
	Session("cost") 			= Trim(Request.Form("txtCost"))
	Session("comments") 		= Replace(Trim(Request.Form("txtComments")),"'","''")		
	
	call OpenDataBase()
		
	strSQL = "INSERT INTO tbl_survey ("
	strSQL = strSQL & "emailed,"
	strSQL = strSQL & "customer_name,"
	strSQL = strSQL & "customer_email,"
	strSQL = strSQL & "service_centre,"
	strSQL = strSQL & "customer_product,"
	strSQL = strSQL & "find,"
	strSQL = strSQL & "find_other,"
	strSQL = strSQL & "service,"
	strSQL = strSQL & "fixed,"
	strSQL = strSQL & "location,"
	strSQL = strSQL & "appearance,"
	strSQL = strSQL & "attitude,"
	strSQL = strSQL & "knowledge,"
	strSQL = strSQL & "date_repair,"
	strSQL = strSQL & "date_completed,"
	strSQL = strSQL & "speed,"
	strSQL = strSQL & "satisfaction,"
	strSQL = strSQL & "charged,"
	strSQL = strSQL & "cost,"
	strSQL = strSQL & "comments,"
	strSQL = strSQL & "ip_address"
	strSQL = strSQL & ") VALUES (0,"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("customer_name")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("customer_email")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("service_centre")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("model_no")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("find")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("find_other")) & "',"	
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("service")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("fixed")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("location")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("appearance")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("attitude")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("knowledge")) & "',"
	strSQL = strSQL & "Convert(datetime,'" & Server.HTMLEncode(Session("date_repair")) & "',103),"
	strSQL = strSQL & "Convert(datetime,'" & Server.HTMLEncode(Session("date_completed")) & "',103),"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("speed")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("satisfaction")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("charged")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("cost")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Session("comments")) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Request.ServerVariables("remote_addr")) & "')"
	
	'response.Write strSQL
	
	on error resume next
	conn.Execute strSQL
	
	if err <> 0 then
		strMessageText = err.description
	else
		Response.Redirect("thank-you.html")
	end if	

	call CloseDataBase()
end sub

sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Submit" then
			if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
				call submitSurvey
			else
				response.Redirect("error.html")
			end if
		end if
	else	    		
		call createToken
	end if
end sub

call main
%>
<p><img src="images/yamaha_logo.jpg" /></p>
<h2>Customer Quality Survey</h2>
<p>In order for us to serve you better in the future, please take a few moments to complete this survey.</p>
<p>By completing this survey you will be entered into this month's prize draw, where you could win a Yamaha audio product.</p>
<p>Prizes are drawn on the first of day of the month. Should you be our lucky winner, you will be contacted using this email address.</p>
<p><font color="red"><%= strMessageText %></font></p>
<h3>Your Details</h3>
<form action="" method="post" name="form_survey" id="form_survey" onsubmit="return validateFormOnSubmit(this)">
  <div class="form-group">
    <label for="txtName">Full Name<font color="red">*</font>:</label>
    <input type="text" class="form-control" id="txtName" name="txtName" placeholder="Full Name" maxlength="30" size="30">
  </div>  
  <div class="form-group">
    <label for="txtEmail">Email<font color="red">*</font>:</label>
    <input type="text" class="form-control" id="txtEmail" name="txtEmail" placeholder="Email" maxlength="60" size="50">
  </div>
  <div class="form-group">
    <label for="txtServiceCentre">Service Centre<font color="red">*</font>:</label>
    <input type="text" class="form-control" id="txtServiceCentre" name="txtServiceCentre" placeholder="Service Centre" maxlength="30" size="30">
  </div>
  <div class="form-group">
    <label for="txtModelNo">Serviced Yamaha Product<font color="red">*</font>:</label>
    <input type="text" class="form-control" id="txtModelNo" name="txtModelNo" placeholder="Model No" maxlength="30" size="30">
  </div>
  <h3>Please rate the service centre</h3>
  <div class="form-group">
    <label for="cboFind">1. How did you learn of the service center?</label>
    <select class="form-control" id="cboFind" name="cboFind">
      <option value="" rel="none">...</option>
      <option value="1" rel="none">Contacting Yamaha</option>
      <option value="2" rel="none">Yamaha Website</option>
      <option value="3" rel="none">Yamaha Dealer / Retailer</option>
      <option value="4" rel="none">Internet Search</option>
      <option value="5" rel="none">Yellow Pages</option>
      <option value="0" rel="other">Other</option>
    </select>
  </div>
  <div class="form-group">
    <label for="txtFindOther"><em>If <u>other</u>, please specify:</em></label>
    <input type="text" class="form-control" id="txtFindOther" name="txtFindOther" maxlength="30" size="20" />
  </div>
  <div class="form-group">
    <label for="radLocation">2. Location? (Was the service centre clearly identified and easy to find?)</label>
    <br>
    <input type="radio" name="radLocation" id="radLocation" value="4" />
    Excellent<br>
    <input type="radio" name="radLocation" id="radLocation" value="3" />
    Good<br>
    <input type="radio" name="radLocation" id="radLocation" value="2" />
    Fair<br>
    <input type="radio" name="radLocation" id="radLocation" value="1" />
    Poor </div>
  <div class="form-group">
    <label for="radAppearance">3. Appearance? (Was the service centre well presented with a reception / book in area?)</label>
    <br>
    <input type="radio" name="radAppearance" id="radAppearance" value="4" />
    Excellent<br>
    <input type="radio" name="radAppearance" id="radAppearance" value="3" />
    Good<br>
    <input type="radio" name="radAppearance" id="radAppearance" value="2" />
    Fair<br>
    <input type="radio" name="radAppearance" id="radAppearance" value="1" />
    Poor </div>
  <div class="form-group">
    <label for="radAttitude">4. Attitude? (Were the staff information &amp; helpful?)</label>
    <br>
    <input type="radio" name="radAttitude" id="radAttitude" value="4" />
    Excellent<br>
    <input type="radio" name="radAttitude" id="radAttitude" value="3" />
    Good<br>
    <input type="radio" name="radAttitude" id="radAttitude" value="2" />
    Fair<br>
    <input type="radio" name="radAttitude" id="radAttitude" value="1" />
    Poor </div>
  <div class="form-group">
    <label for="radKnowledge">5. Knowledge? (Did the staff understand your issue and provide relevant information including how long the repair would take?)</label>
    <br>
    <input type="radio" name="radKnowledge" id="radKnowledge" value="4" />
    Excellent<br>
    <input type="radio" name="radKnowledge" id="radKnowledge" value="3" />
    Good<br>
    <input type="radio" name="radKnowledge" id="radKnowledge" value="2" />
    Fair<br>
    <input type="radio" name="radKnowledge" id="radKnowledge" value="1" />
    Poor<br>
  </div>
  <div class="form-group">
    <label for="txtDateRepair">6. What date did you first place it with the service center?</label>
    <input type="text" class="form-control" id="txtDateRepair" name="txtDateRepair" maxlength="10" size="15" placeholder="dd/mm/yyyy" />
  </div>
  <div class="form-group">
    <label for="txtDateCompleted">7. What date was your product repaired?</label>
    <input type="text" class="form-control" id="txtDateCompleted" name="txtDateCompleted" maxlength="10" size="15" placeholder="dd/mm/yyyy" />
  </div>
  <div class="form-group">
    <label for="radSpeed">8. Please rate how quickly your repair was completed:</label>
    <br>
    <input type="radio" name="radSpeed" id="radSpeed" value="4" />
    Excellent<br>
    <input type="radio" name="radSpeed" id="radSpeed" value="3" />
    Good<br>
    <input type="radio" name="radSpeed" id="radSpeed" value="2" />
    Fair<br>
    <input type="radio" name="radSpeed" id="radSpeed" value="1" />
    Poor </div>
  <div class="form-group">
    <label for="radFixed">9. Was your product working correctly after repair was complete?</label>
    <br>
    <input type="radio" name="radFixed" id="radFixed" value="1" />
    Yes<br>
    <input type="radio" name="radFixed" id="radFixed" value="0" />
    No </div>
  <div class="form-group">
    <label for="radSatisfaction">10. Satisfaction since repair?</label>
    <br>
    <input type="radio" name="radSatisfaction" id="radSatisfaction" value="3" />
    Satisfied<br>
    <input type="radio" name="radSatisfaction" id="radSatisfaction" value="2" />
    Same Problem<br>
    <input type="radio" name="radSatisfaction" id="radSatisfaction" value="1" />
    Different Problem </div>
  <div class="form-group">
    <label for="radCharged">11. Were you charged for the repair?</label>
    <br>
    <input type="radio" name="radCharged" id="radCharged" value="1" />
    Yes<br>
    <input type="radio" name="radCharged" id="radCharged" value="0" />
    No </div>
  <div class="form-group">
    <label for="txtCost"><em>If <u>yes</u>, how much were you charged?</em></label>
    <input type="text" class="form-control" id="txtCost" name="txtCost" maxlength="6" size="6" placeholder="0" />
  </div>
  <div class="form-group">
    <label for="radService">12. How would you rate the overall service you received?</label>
    <br>
    <input type="radio" name="radService" id="radService" value="4" />
    Excellent<br>
    <input type="radio" name="radService" id="radService" value="3" />
    Good<br>
    <input type="radio" name="radService" id="radService" value="2" />
    Fair<br>
    <input type="radio" name="radService" id="radService" value="1" />
    Poor </div>
  <div class="form-group">
    <label for="txtComments">Comments:</label>
    <input type="text" class="form-control" id="txtComments" name="txtComments" maxlength="90" size="80" />
  </div>
  <input type="hidden" name="Action" />
  <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
  <input type="submit" name="submit" id="submit" value="Submit" />
</form>
<h3>Note</h3>
<p>Only one prize draw entry per repair, Yamaha may at its discretion change, cancel or modify this prize draw at anytime without notice. Yamaha reserve the right to make all decisions in relation to the draw, all decisions are final and no correspondence will be entered into.</p>
<p><a href="http://au.yamaha.com/en/privacy_policy/" target="_blank">Privacy Policy</a></p>
<script type="text/javascript" src="../include/moment.js"></script> 
<script type="text/javascript" src="../include/pikaday.js"></script> 
<script type="text/javascript">	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateRepair'),
        firstDay: 1,
        minDate: new Date('2014-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateCompleted'),
        firstDay: 1,
        minDate: new Date('2014-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });		
</script>
</body>
</html>