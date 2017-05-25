<!--#include file="../include/connection.asp " -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Piano Service Agent Application</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script language="javascript" type="text/javascript">
function validateFormOnSubmit(theForm) {
	var reason 		= "";
	var blnSubmit 	= true;
	
	//1. General
	reason += validateEmptyField(theForm.txtFirstname,"First name");
	reason += validateSpecialCharacters(theForm.txtFirstname,"First name");
	
	reason += validateEmptyField(theForm.txtLastname,"Last name");
	reason += validateSpecialCharacters(theForm.txtLastname,"Last name");
	
	reason += validateEmptyField(theForm.txtCompanyName,"Company");
	reason += validateSpecialCharacters(theForm.txtCompanyName,"Company");
	
	reason += validateSpecialCharacters(theForm.txtTradingName,"Trading name");
	
	reason += validateEmptyField(theForm.txtABN,"ABN");
	reason += validateSpecialCharacters(theForm.txtABN,"ABN");
	
	reason += validateEmptyField(theForm.txtPhone,"Phone");
	reason += validateSpecialCharacters(theForm.txtPhone,"Phone");
	
	reason += validateEmail(theForm.txtEmail);
	
	reason += validateEmptyField(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	reason += validateSpecialCharacters(theForm.txtCity,"City");
	
	reason += validateEmptyField(theForm.cboState,"State");
	
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	
	reason += validateSpecialCharacters(theForm.txtYTnumber,"YT number");
	
	reason += validateSpecialCharacters(theForm.txtPartnership,"Partnership");
	
	//2. Organisation	
	reason += validateEmptyField(theForm.cboWorkshop,"Own a workshop");	
	if (theForm.cboWorkshop.value == "1") {
		reason += validateEmptyField(theForm.txtWorkshopSize,"Workshop size");
	}	
	reason += validateSpecialCharacters(theForm.txtWorkshopSize,"Workshop size");
		
	reason += validateSpecialCharacters(theForm.txtWorkshopWork,"Work carried out in workshop");
	
	reason += validateEmptyField(theForm.cboEmployStaff,"Employ staff");	
	if (theForm.cboEmployStaff.value == "1") {
		reason += validateEmptyField(theForm.txtEmployStaffCapacity,"Staff capacity");
	}
	reason += validateSpecialCharacters(theForm.txtEmployStaffCapacity,"Staff capacity");
	
	reason += validateEmptyField(theForm.cboSecuritySystem,"Security system");
	
	reason += validateEmptyField(theForm.cboOtherPianoAgent,"Other manufacturer agent");
	if (theForm.cboOtherPianoAgent.value == "1") {
		reason += validateEmptyField(theForm.txtOtherPianoAgentInfo,"Other manufacturer agent info");
	}	
	reason += validateSpecialCharacters(theForm.txtOtherPianoAgentInfo,"Other manufacturer agent info");
	
	reason += validateEmptyField(theForm.cboAffiliation,"Affiliation");
	if (theForm.cboAffiliation.value == "1") {
		reason += validateEmptyField(theForm.txtAffiliationInfo,"Affiliation info");
	}
	reason += validateSpecialCharacters(theForm.txtAffiliationInfo,"Affiliation info");
	
	//3. Insurances
	reason += validateEmptyField(theForm.cboFireTheftInsurance,"Fire and theft insurance");
	reason += validateEmptyField(theForm.cboWorkcoverInsurance,"Workcover insurance");
	reason += validateEmptyField(theForm.cboPublicLiabilityInsurance,"Public liability insurance");	
	
	//4. Training
	reason += validateEmptyField(theForm.cboYamahaTraining,"Yamaha training");
	
	reason += validateEmptyField(theForm.cboOtherTraining,"Other training");
	
	reason += validateSpecialCharacters(theForm.txtOtherTrainingInfo,"Other training info");
		
	reason += validateEmptyField(theForm.cboAPTTA,"APPTA member");
	
	reason += validateEmptyField(theForm.cboPTTG,"PTTG member");
		
	reason += validateEmptyField(theForm.cboFutureYamahaTraining,"Future Yamaha training");
		
	reason += validateEmptyField(theForm.txtDuration,"Duration as a piano tuner/technician");
	reason += validateSpecialCharacters(theForm.txtDuration,"Duration as a piano tuner/technician");	
	
	//5. Services	
	reason += validateSpecialCharacters(theForm.txtServicesOther,"Other services");	
	
	reason += validateEmptyField(theForm.txtQualification,"Qualifications");
	reason += validateSpecialCharacters(theForm.txtQualification,"Qualifications");
	
	//6. Reporting
	reason += validateEmptyField(theForm.cboPublishedPricing,"Published pricing");
	
	reason += validateEmptyField(theForm.txtStandardRates,"Standard tuning rates");
	reason += validateSpecialCharacters(theForm.txtStandardRates,"Standard tuning rates");
	
	reason += validateEmptyField(theForm.txtHourlyRates,"Hourly rates");
	reason += validateSpecialCharacters(theForm.txtHourlyRates,"Hourly rates");
	
	reason += validateEmptyField(theForm.txtUprightRates,"Setup & tune of Upright piano rates");
	reason += validateSpecialCharacters(theForm.txtUprightRates,"Setup & tune of Upright piano rates");
	
	reason += validateEmptyField(theForm.txtGrandPianoRates,"Setup & tune of Grand Piano rates");
	reason += validateSpecialCharacters(theForm.txtGrandPianoRates,"Setup & tune of Grand Piano rates");
	
	reason += validateEmptyField(theForm.txtFullRates,"Full regulation rates");
	reason += validateSpecialCharacters(theForm.txtFullRates,"Full regulation rates");
	
	reason += validateEmptyField(theForm.txtVoicingRates,"Voicing rates");
	reason += validateSpecialCharacters(theForm.txtVoicingRates,"Voicing rates");	
	
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
sub addSurvey
	Dim strSQL	
	
	Dim strFirstname 
	Dim strLastname 
	Dim strCompanyName
	Dim strTradingName
	Dim strABN 
	Dim strMobile 
	Dim strPhone 
	Dim strFax 
	Dim strEmail 
	Dim strAddress 
	Dim strCity 
	Dim strState 
	Dim strPostcode
	Dim strWebsite 
	Dim strYTnumber 
	Dim strPartnership 
	Dim strWorkshop 
	Dim strWorkshopSize 
	Dim strWorkshopWork 
	Dim strEmployStaff 
	Dim strEmployStaffCapacity 
	Dim strSecuritySystem 
	Dim strOtherPianoAgent 
	Dim strOtherPianoAgentInfo 
	Dim strAffiliation 
	Dim strAffiliationInfo 
	Dim strFireTheftInsurance 
	Dim strWorkcoverInsurance 
	Dim strPublicLiabilityInsurance
	Dim strYamahaTraining
	Dim strOtherTraining 
	Dim strOtherTrainingInfo 
	Dim strAPTTA 
	Dim strPTTG 
	Dim strFutureYamahaTraining 
	Dim strDuration 
	Dim strServices 
	Dim strServicesOther 
	Dim strQualification 
	Dim strStaffInfo 
	Dim strPublishedPricing 
	Dim strStandardRates
	Dim strHourlyRates
	Dim strUprightRates 
	Dim strGrandPianoRates 
	Dim strFullRates
	Dim strVoicingRates
	
	strFirstname 			= Replace(Request.Form("txtFirstname"),"'","''")
	strLastname 			= Replace(Request.Form("txtLastname"),"'","''")
	strCompanyName 			= Replace(Request.Form("txtCompanyName"),"'","''")
	strTradingName 			= Replace(Request.Form("txtTradingName"),"'","''")
	strABN 					= Replace(Request.Form("txtABN"),"'","''")
	strMobile 				= Replace(Request.Form("txtMobile"),"'","''")
	strPhone 				= Replace(Request.Form("txtPhone"),"'","''")
	strFax 					= Replace(Request.Form("txtFax"),"'","''")
	strEmail 				= Replace(Request.Form("txtEmail"),"'","''")
	strAddress 				= Replace(Request.Form("txtAddress"),"'","''")
	strCity 				= Replace(Request.Form("txtCity"),"'","''")
	strState 				= Request.Form("cboState")
	strPostcode 			= Request.Form("txtPostcode")
	strWebsite 				= Replace(Request.Form("txtWebsite"),"'","''")
	strYTnumber 			= Replace(Request.Form("txtYTnumber"),"'","''")
	strPartnership 			= Replace(Request.Form("txtPartnership"),"'","''")
	strWorkshop 			= Request.Form("cboWorkshop")
	strWorkshopSize 		= Replace(Request.Form("txtWorkshopSize"),"'","''")
	strWorkshopWork 		= Replace(Request.Form("txtWorkshopWork"),"'","''")
	strEmployStaff 			= Request.Form("cboEmployStaff")
	strEmployStaffCapacity 	= Replace(Request.Form("txtEmployStaffCapacity"),"'","''")
	strSecuritySystem 		= Request.Form("cboSecuritySystem")
	strOtherPianoAgent 		= Request.Form("cboOtherPianoAgent")
	strOtherPianoAgentInfo 	= Replace(Request.Form("txtOtherPianoAgentInfo"),"'","''")
	strAffiliation 			= Request.Form("cboAffiliation")
	strAffiliationInfo 		= Replace(Request.Form("txtAffiliationInfo"),"'","''")
	strFireTheftInsurance 		= Request.Form("cboFireTheftInsurance")
	strWorkcoverInsurance 		= Request.Form("cboWorkcoverInsurance")
	strPublicLiabilityInsurance = Request.Form("cboPublicLiabilityInsurance")
	strYamahaTraining 		= Request.Form("cboYamahaTraining")
	strOtherTraining 		= Request.Form("cboOtherTraining")
	strOtherTrainingInfo 	= Replace(Request.Form("txtOtherTrainingInfo"),"'","''")
	strAPTTA 				= Request.Form("cboAPTTA")
	strPTTG 				= Request.Form("cboPTTG")
	strFutureYamahaTraining = Request.Form("cboFutureYamahaTraining")
	strDuration 			= Replace(Request.Form("txtDuration"),"'","''")
	strServices 			= Request.Form("chkServices")
	strServicesOther 		= Replace(Request.Form("txtServicesOther"),"'","''")
	strQualification 		= Replace(Request.Form("txtQualification"),"'","''")
	strStaffInfo 			= Replace(Request.Form("txtStaffInfo"),"'","''")
	strPublishedPricing 	= Request.Form("cboPublishedPricing")
	strStandardRates 		= Replace(Request.Form("txtStandardRates"),"'","''")
	strHourlyRates 			= Replace(Request.Form("txtHourlyRates"),"'","''")
	strUprightRates 		= Replace(Request.Form("txtUprightRates"),"'","''")
	strGrandPianoRates 		= Replace(Request.Form("txtGrandPianoRates"),"'","''")
	strFullRates 			= Replace(Request.Form("txtFullRates"),"'","''")
	strVoicingRates 		= Replace(Request.Form("txtVoicingRates"),"'","''")
	
	call OpenDataBase()
		
	strSQL = "INSERT INTO yma_piano_survey ("	
	strSQL = strSQL & " firstname," 
	strSQL = strSQL & " lastname," 
	strSQL = strSQL & " company_name,"
	strSQL = strSQL & " trading_name,"
	strSQL = strSQL & " abn," 
	strSQL = strSQL & " mobile," 
	strSQL = strSQL & " phone," 
	strSQL = strSQL & " fax," 
	strSQL = strSQL & " email," 
	strSQL = strSQL & " address," 
	strSQL = strSQL & " city," 
	strSQL = strSQL & " state," 
	strSQL = strSQL & " postcode,"
	strSQL = strSQL & " website," 
	strSQL = strSQL & " yt_number," 
	strSQL = strSQL & " partnership," 
	strSQL = strSQL & " workshop," 
	strSQL = strSQL & " workshop_size," 
	strSQL = strSQL & " workshop_work," 
	strSQL = strSQL & " employ_staff," 
	strSQL = strSQL & " employ_staff_capacity," 
	strSQL = strSQL & " security_system," 
	strSQL = strSQL & " other_piano_agent," 
	strSQL = strSQL & " other_piano_agent_info," 
	strSQL = strSQL & " affiliation," 
	strSQL = strSQL & " affiliation_info," 
	strSQL = strSQL & " fire_theft_insurance," 
	strSQL = strSQL & " workcover_insurance," 
	strSQL = strSQL & " public_liability_insurance,"
	strSQL = strSQL & " yamaha_training," 
	strSQL = strSQL & " other_training," 
	strSQL = strSQL & " other_training_info," 
	strSQL = strSQL & " aptta_member," 
	strSQL = strSQL & " pttg_member," 
	strSQL = strSQL & " future_yamaha_training," 
	strSQL = strSQL & " duration," 
	strSQL = strSQL & " services," 
	strSQL = strSQL & " services_other," 
	strSQL = strSQL & " qualification," 
	strSQL = strSQL & " staff_info," 
	strSQL = strSQL & " published_pricing," 
	strSQL = strSQL & " standard_rates,"
	strSQL = strSQL & " hourly_rates,"
	strSQL = strSQL & " upright_rates," 
	strSQL = strSQL & " grand_piano_rates," 
	strSQL = strSQL & " full_rates,"
	strSQL = strSQL & " voicing_rates"
	strSQL = strSQL & ") VALUES ( "	
	strSQL = strSQL & "'" & Server.HTMLEncode(strFirstname) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strLastname) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strCompanyName) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strTradingName) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strABN) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strMobile) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strPhone) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strFax) & "'," 
	strSQL = strSQL & "'" & strEmail & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strAddress) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strCity) & "'," 
	strSQL = strSQL & "'" & strState & "'," 
	strSQL = strSQL & "'" & strPostcode & "',"
	strSQL = strSQL & "'" & strWebsite & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strYTnumber) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strPartnership) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strWorkshop) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strWorkshopSize) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strWorkshopWork) & "'," 
	strSQL = strSQL & "'" & strEmployStaff & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strEmployStaffCapacity) & "'," 
	strSQL = strSQL & "'" & strSecuritySystem & "'," 
	strSQL = strSQL & "'" & strOtherPianoAgent & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strOtherPianoAgentInfo) & "'," 
	strSQL = strSQL & "'" & strAffiliation & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strAffiliationInfo) & "'," 
	strSQL = strSQL & "'" & strFireTheftInsurance & "'," 
	strSQL = strSQL & "'" & strWorkcoverInsurance & "'," 
	strSQL = strSQL & "'" & strPublicLiabilityInsurance & "',"
	strSQL = strSQL & "'" & strYamahaTraining & "'," 
	strSQL = strSQL & "'" & strOtherTraining & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strOtherTrainingInfo) & "'," 
	strSQL = strSQL & "'" & strAPTTA & "'," 
	strSQL = strSQL & "'" & strPTTG & "'," 
	strSQL = strSQL & "'" & strFutureYamahaTraining & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strDuration) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strServices) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strServicesOther) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strQualification) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strStaffInfo) & "'," 
	strSQL = strSQL & "'" & strPublishedPricing & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strStandardRates) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strHourlyRates) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strUprightRates) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strGrandPianoRates) & "'," 
	strSQL = strSQL & "'" & Server.HTMLEncode(strFullRates) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strVoicingRates) & "'"
	strSQL = strSQL & ")"
	
	'response.Write strSQL	
	  
	on error resume next
	conn.Execute strSQL
	
	On error Goto 0
	
	if err <> 0 then
		strMessageText = err.description
	else		
		Response.Redirect("thank-you.asp")
	end if
	
	call CloseDataBase()
end sub

sub main
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if Trim(Request("Action")) = "Add" then
			call addSurvey
		end if
	end if
end sub

call main
%>
</head>
<body>
<p><img src="images/yamaha_logo.jpg" /></p>
<h1>Piano Service Agent Application</h1>
<form action="" method="post" name="form_survey" id="form_survey" onsubmit="return validateFormOnSubmit(this)">
  <h2>1. General</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="30%">1.1. First name<span class="mandatory">*</span>:</td>
      <td width="70%"><input type="text" id="txtFirstname" name="txtFirstname" maxlength="30" size="50" /></td>
    </tr>
    <tr>
      <td>1.2. Last name<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtLastname" name="txtLastname" maxlength="50" size="50" /></td>
    </tr>
    <tr>
      <td>1.3. Company name<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtCompanyName" name="txtCompanyName" maxlength="80" size="80" /></td>
    </tr>
    <tr>
      <td>1.4. Trading name:</td>
      <td><input type="text" id="txtTradingName" name="txtTradingName" maxlength="80" size="80" /></td>
    </tr>
    <tr>
      <td>1.5. ABN<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtABN" name="txtABN" maxlength="20" size="30" /></td>
    </tr>
    <tr>
      <td>1.6. Mobile phone:</td>
      <td><input type="text" id="txtMobile" name="txtMobile" maxlength="12" size="15" /></td>
    </tr>
    <tr>
      <td>1.7. Phone (Landline)<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtPhone" name="txtPhone" maxlength="12" size="15" /></td>
    </tr>
    <tr>
      <td>1.8. Fax:</td>
      <td><input type="text" id="txtFax" name="txtFax" maxlength="12" size="15" /></td>
    </tr>
    <tr>
      <td>1.9. Email:</td>
      <td><input type="text" id="txtEmail" name="txtEmail" maxlength="60" size="60" /></td>
    </tr>
    <tr>
      <td>1.10. Address<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtAddress" name="txtAddress" maxlength="60" size="60" /></td>
    </tr>
    <tr>
      <td>1.11. City<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtCity" name="txtCity" maxlength="40" size="50" /></td>
    </tr>
    <tr>
      <td>1.12. State<span class="mandatory">*</span>:</td>
      <td><select name="cboState">
          <option value="">...</option>
          <option value="VIC">VIC</option>
          <option value="NSW">NSW</option>
          <option value="ACT">ACT</option>
          <option value="QLD">QLD</option>
          <option value="NT">NT</option>
          <option value="WA">WA</option>
          <option value="SA">SA</option>
          <option value="TAS">TAS</option>
        </select></td>
    </tr>
    <tr>
      <td>1.13. Postcode<span class="mandatory">*</span>:</td>
      <td><input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="5" /></td>
    </tr>
    <tr>
      <td>1.14. Website:</td>
      <td>http://
        <input type="text" id="txtWebsite" name="txtWebsite" maxlength="60" size="60" /></td>
    </tr>
    <tr>
      <td>1.15. YT Number (if applicable):</td>
      <td><input type="text" id="txtYTnumber" name="txtYTnumber" maxlength="30" size="30" /></td>
    </tr>
    <tr>
      <td>1.16. Any partnership / associates? </td>
      <td><input type="text" id="txtPartnership" name="txtPartnership" maxlength="80" size="80" /></td>
    </tr>
  </table>
  <h2>2. Organisation</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="30%">2.1. Do you possess a workshop?<span class="mandatory">*</span></td>
      <td width="70%"><select name="cboWorkshop">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td align="right">If so, size of workshop:</td>
      <td><input type="text" id="txtWorkshopSize" name="txtWorkshopSize" maxlength="6" size="10" />
        m<sup>2</sup></td>
    </tr>
    <tr>
      <td colspan="2">2.2. Type of work carried out in workshop:</td>
    </tr>
    <tr>
      <td colspan="2" align="right"><input type="text" id="txtWorkshopWork" name="txtWorkshopWork" maxlength="200" size="120" /></td>
    </tr>
    <tr>
      <td>2.3. Do you employ any staff?<span class="mandatory">*</span></td>
      <td><select name="cboEmployStaff">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td align="right">If so, in what capacity?</td>
      <td><input type="text" id="txtEmployStaffCapacity" name="txtEmployStaffCapacity" maxlength="80" size="80" /></td>
    </tr>
    <tr>
      <td colspan="2">2.4. Are your premises protected by a monitored Security System?<span class="mandatory">*</span>
        <select name="cboSecuritySystem">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">2.5. Do you sell pianos or act as an agent for any piano manufacturer?<span class="mandatory">*</span>
        <select name="cboOtherPianoAgent">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td align="right">If so, please provide details:</td>
      <td><input type="text" id="txtOtherPianoAgentInfo" name="txtOtherPianoAgentInfo" maxlength="80" size="80" /></td>
    </tr>
    <tr>
      <td colspan="2">2.6. Are you affiliated with, or do you perform regular work for any piano dealers (Yamaha or otherwise)?
        <select name="cboAffiliation">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td align="right">If so, please provide details:</td>
      <td><input type="text" id="txtAffiliationInfo" name="txtAffiliationInfo" maxlength="80" size="80" /></td>
    </tr>
  </table>
  <h2>3. Insurances</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="60%">3.1. Do you hold current insurance for fire &amp; theft at your premises?<span class="mandatory">*</span></td>
      <td width="40%" colspan="2"><select name="cboFireTheftInsurance">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td>3.2. Do you hold a current workcover insurances certificate for your state?<span class="mandatory">*</span></td>
      <td colspan="2"><select name="cboWorkcoverInsurance">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td>3.3. Do you hold public liability insurance?<span class="mandatory">*</span></td>
      <td colspan="2"><select name="cboPublicLiabilityInsurance">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
  </table>
  <h2>4. Training / Education / Networking</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="65%">4.1. Have you completed any training provided by Yamaha?<span class="mandatory">*</span></td>
      <td width="35%"><select name="cboYamahaTraining">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td>4.2. Have you completed any training provided by any other piano manufacturer?<span class="mandatory">*</span></td>
      <td><select name="cboOtherTraining">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">4.3. Please provide details of any other training you have undergone, including training completed in Australia and overseas either through an institution or privately.</td>
    </tr>
    <tr>
      <td colspan="2" align="right"><input type="text" id="txtOtherTrainingInfo" name="txtOtherTrainingInfo" maxlength="200" size="120" /></td>
    </tr>
    <tr>
      <td>4.4. Are you a member of the Australasian Piano Tuners and Technicians Association?<span class="mandatory">*</span></td>
      <td><select name="cboAPTTA">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td>4.5. Are you a member of the Piano Tuners &amp; Technicians Guild?<span class="mandatory">*</span></td>
      <td><select name="cboPTTG">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td>4.6. Would you be willing to attend Yamaha technical training in the future?<span class="mandatory">*</span></td>
      <td><select name="cboFutureYamahaTraining">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td>4.7. How long have you been acting as a piano tuner/technician?<span class="mandatory">*</span></td>
      <td><input type="text" id="txtDuration" name="txtDuration" maxlength="30" size="30" /></td>
    </tr>
  </table>
  <h2>5. Services</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td colspan="4">5.1. Which of the following services do you offer?</td>
    </tr>
    <tr>
      <td width="10%">&nbsp;</td>
      <td width="30%"><input type="checkbox" name="chkServices" value="Tuning" />
        Tuning</td>
      <td width="30%"><input type="checkbox" name="chkServices" value="Polishing" />
        Polishing</td>
      <td width="30%"><input type="checkbox" name="chkServices" value="Humidifier installation" />
        Humidifier installation</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkServices" value="Voicing" />
        Voicing</td>
      <td><input type="checkbox" name="chkServices" value="Rebuilding" />
        Rebuilding</td>
      <td><input type="checkbox" name="chkServices" value="Piano freight" />
        Piano freight</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkServices" value="Regulation" />
        Regulation</td>
      <td><input type="checkbox" name="chkServices" value="Disklavier servicing" />
        Disklavier servicing</td>
      <td><input type="checkbox" name="chkServices" value="Piano storage" />
        Piano storage</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkServices" value="Repairs" />
        Repairs</td>
      <td><input type="checkbox" name="chkServices" value="Silent system servicing" />
        Silent system servicing</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkServices" value="Cabinet repairs" />
        Cabinet repairs</td>
      <td><input type="checkbox" name="chkServices" value="Digital piano servicing" />
        Digital piano servicing</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td align="right">Others:</td>
      <td colspan="3"><input type="text" id="txtServicesOther" name="txtServicesOther" maxlength="80" size="80" /></td>
    </tr>
    <tr>
      <td colspan="4">5.3. What qualifications do you hold in these areas?<span class="mandatory">*</span></td>
    </tr>
    <tr>
      <td colspan="4" align="right"><input type="text" id="txtQualification" name="txtQualification" maxlength="200" size="120" /></td>
    </tr>
  </table>
  <h2>6. Reporting</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td colspan="2">6.1. Please name all staff and their email addresses who will use the Yamaha YSISS System</td>
    </tr>
    <tr>
      <td colspan="2" align="right"><input type="text" id="txtStaffInfo" name="txtStaffInfo" maxlength="200" size="125" /></td>
    </tr>
    <tr>
      <td colspan="2">6.2. Do you have published pricing for service?<span class="mandatory">*</span>
        <select name="cboPublishedPricing">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">6.3. What are your publicly quoted rates for the following services?<span class="mandatory">*</span></td>
    </tr>
    <tr>
      <td width="30%" align="right">Standard tuning:</td>
      <td width="70%">$
        <input type="text" id="txtStandardRates" name="txtStandardRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Hourly rates:</td>
      <td>$
        <input type="text" id="txtHourlyRates" name="txtHourlyRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Set up &amp; tune of new upright piano:</td>
      <td>$
        <input type="text" id="txtUprightRates" name="txtUprightRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Set up &amp; tune of new grand piano:</td>
      <td>$
        <input type="text" id="txtGrandPianoRates" name="txtGrandPianoRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Full regulation:</td>
      <td>$
        <input type="text" id="txtFullRates" name="txtFullRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Voicing:</td>
      <td>$
        <input type="text" id="txtVoicingRates" name="txtVoicingRates" maxlength="6" size="8" /></td>
    </tr>
  </table>
  <p>
    <input type="hidden" name="Action" />
    <input type="submit" value="Submit" />
  </p>
</form>
<p align="center">Please note that the answers to the following questions are for information purposes only and Yamaha Music Australia will not share this information with the public without your consent.</p>
<p align="center">&copy; 2013 <a href="http://au.yamaha.com/" target="_blank">Yamaha Music Australia</a> Pty. Ltd. | <a href="http://au.yamaha.com/en/privacy_policy/" target="_blank">Privacy Policy</a></p>
</body>
</html>