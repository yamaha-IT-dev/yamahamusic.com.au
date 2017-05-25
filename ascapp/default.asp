<!--#include file="../include/connection.asp " -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Music Australia - Service Centre Survey</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script language="JavaScript" type="text/javascript">
function validateFormOnSubmit(theForm) {
	var reason 		= "";
	var blnSubmit 	= true;
	
	//1. General
	reason += validateEmptyField(theForm.txtTradingName,"Trading name");
	reason += validateSpecialCharacters(theForm.txtTradingName,"Trading name");
	
	reason += validateEmptyField(theForm.txtABN,"ABN");
	reason += validateSpecialCharacters(theForm.txtABN,"ABN");
	
	reason += validateEmptyField(theForm.cboBusinessOwnership,"Business ownership");
	
	reason += validateEmptyField(theForm.txtPhone,"Phone");
	reason += validateSpecialCharacters(theForm.txtPhone,"Phone");
	
	reason += validateEmptyField(theForm.txtFax,"Fax");
	reason += validateSpecialCharacters(theForm.txtFax,"Fax");
	
	reason += validateEmail(theForm.txtEmail);
	reason += validateEmptyField(theForm.txtAddress,"Address");
	
	reason += validateEmptyField(theForm.txtCity,"City");
	reason += validateSpecialCharacters(theForm.txtCity,"City");
	
	reason += validateEmptyField(theForm.cboState,"State");
	reason += validateNumeric(theForm.txtPostcode,"Postcode");
	reason += validateEmptyField(theForm.txtWebsite,"Website");
	
	reason += validateEmptyField(theForm.txtOpeningHours,"Opening hours");
	reason += validateSpecialCharacters(theForm.txtOpeningHours,"Opening hours");
	
	reason += validateEmptyField(theForm.cboApproved,"Approved service centre");
	
	reason += validateEmptyField(theForm.txtUnderWarranty,"Under warranty repairs");
	reason += validateSpecialCharacters(theForm.txtUnderWarranty,"Under warranty repairs");
	
	reason += validateEmptyField(theForm.txtOutsideWarranty,"Outside warranty repairs");
	reason += validateSpecialCharacters(theForm.txtOutsideWarranty,"Outside warranty repairs");
	
	//2. Organisation	
	reason += validateEmptyField(theForm.txtOwnersName,"General Manager / Owners name");
	reason += validateSpecialCharacters(theForm.txtOwnersName,"General Manager / Owners name");
	
	reason += validateEmptyField(theForm.txtServiceManagerName,"Service Manager name");
	reason += validateSpecialCharacters(theForm.txtServiceManagerName,"Service Manager name");
	
	reason += validateEmptyField(theForm.txtTechnicalStaff,"Technical staff");
	reason += validateSpecialCharacters(theForm.txtTechnicalStaff,"Technical staff");
	
	reason += validateEmptyField(theForm.txtAdminStaff,"Admin staff");
	reason += validateSpecialCharacters(theForm.txtAdminStaff,"Admin staff");
	
	reason += validateEmptyField(theForm.txtFieldStaff,"Field staff");
	reason += validateSpecialCharacters(theForm.txtFieldStaff,"Field staff");
	
	reason += validateEmptyField(theForm.cboSecuritySystem,"Security system");
		
	//3. Insurances
	reason += validateEmptyField(theForm.cboFireTheftInsurance,"Fire and theft insurance");
	reason += validateEmptyField(theForm.cboWorkcoverInsurance,"Workcover insurance");
	reason += validateEmptyField(theForm.cboPublicLiability,"Public liability");
	
	//4. General
	reason += validateEmptyField(theForm.txtPremisesSize,"Premises size");
	reason += validateSpecialCharacters(theForm.txtPremisesSize,"Premises size");
	
	reason += validateEmptyField(theForm.txtWorkshopSize,"Workshop size");
	reason += validateSpecialCharacters(theForm.txtWorkshopSize,"Workshop size");
	
	reason += validateEmptyField(theForm.txtNoRepairs,"No repairs");
	reason += validateSpecialCharacters(theForm.txtNoRepairs,"No repairs");
	
	reason += validateEmptyField(theForm.cboOHS,"Occupational Health and Safety");
	
	//5. IT
	reason += validateEmptyField(theForm.cboSoftware,"Software package");
	reason += validateEmptyField(theForm.cboInternet,"Internet access");
	//reason += validateEmptyField(theForm.chkHomepage,"Info Homepage");
	reason += validateEmptyField(theForm.cboManual,"View your service manual");
	
	//6. Training
	reason += validateEmptyField(theForm.txtSeminar,"Past seminar");
	reason += validateSpecialCharacters(theForm.txtSeminar,"Past seminar");
	
	reason += validateEmptyField(theForm.cboTraining,"Future training");
	
	//7. Products
	//reason += validateEmptyField(theForm.chkProducts,"Products");
	reason += validateEmptyField(theForm.cboExperience,"Technical experience");
	
	//8. Services
	//reason += validateEmptyField(theForm.chkServices,"Services");
	reason += validateEmptyField(theForm.cboRepairs,"Level of repairs");	
	
	//9. Reporting
	reason += validateEmptyField(theForm.cboPricing,"Published pricing");
	
	reason += validateEmptyField(theForm.txtQuoteRates,"Quote rates");
	reason += validateSpecialCharacters(theForm.txtQuoteRates,"Quote rates");
	
	reason += validateEmptyField(theForm.txtLabourRates,"Labour rates");
	reason += validateSpecialCharacters(theForm.txtLabourRates,"Labour rates");
	
	reason += validateEmptyField(theForm.txtFieldRates,"Field rates");
	reason += validateSpecialCharacters(theForm.txtFieldRates,"Field rates");
	
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
	dim strSQL
	
	Dim strTradingName
	Dim strCompanyName
	Dim strABN
	Dim strBusinessOwnership
	Dim strPhone
	Dim strFax
	Dim strEmail
	Dim strAddress
	Dim strCity
	Dim strState
	Dim strPostcode
	Dim strWebsite
	Dim strOpeningHours
	Dim intApproved
	Dim strApprovedOther
	Dim strUnderWarranty
	Dim strOutsideWarranty
	Dim strOwnersName
	Dim strServiceManagerName
	Dim strTechnicalStaff
	Dim strAdminStaff
	Dim strFieldStaff
	Dim intSecuritySystem
	Dim intFireTheftInsurance
	Dim intWorkcoverInsurance
	Dim intPublicLiability
	Dim strPremisesSize
	Dim strWorkshopSize
	Dim strNoRepairs
	Dim intOHS
	Dim intSoftware
	Dim strSoftware
	Dim intInternet
	Dim strHomepage
	Dim strManual
	Dim strSeminar
	Dim intTraining
	Dim strProducts
	Dim strExperience
	Dim strServices
	Dim strRepairs
	Dim strStaff
	Dim intPricing
	Dim strQuoteRates
	Dim strLabourRates
	Dim strFieldRates
			
	strTradingName 		= Replace(Request.Form("txtTradingName"),"'","''")
	strCompanyName 		= Replace(Request.Form("txtCompanyName"),"'","''")
	strABN 				= Replace(Request.Form("txtABN"),"'","''")
	strBusinessOwnership = Request.Form("cboBusinessOwnership")
	strPhone 			= Replace(Request.Form("txtPhone"),"'","''")
	strFax 				= Replace(Request.Form("txtFax"),"'","''")
	strEmail 			= Request.Form("txtEmail")
	strAddress 			= Replace(Request.Form("txtAddress"),"'","''")
	strCity 			= Replace(Request.Form("txtCity"),"'","''")
	strState 			= Request.Form("cboState")
	strPostcode 		= Request.Form("txtPostcode")
	strWebsite 			= Request.Form("txtWebsite")
	strOpeningHours 	= Replace(Request.Form("txtOpeningHours"),"'","''")
	intApproved 		= Request.Form("cboApproved")
	strApprovedOther 	= Replace(Request.Form("txtApprovedOther"),"'","''")
	strUnderWarranty 	= Replace(Request.Form("txtUnderWarranty"),"'","''")
	strOutsideWarranty 	= Replace(Request.Form("txtOutsideWarranty"),"'","''")
	strOwnersName 		= Replace(Request.Form("txtOwnersName"),"'","''")
	strServiceManagerName = Replace(Request.Form("txtServiceManagerName"),"'","''")
	strTechnicalStaff 	= Replace(Request.Form("txtTechnicalStaff"),"'","''")
	strAdminStaff 		= Replace(Request.Form("txtAdminStaff"),"'","''")
	strFieldStaff 		= Replace(Request.Form("txtFieldStaff"),"'","''")
	intSecuritySystem 	= Request.Form("cboSecuritySystem")
	intFireTheftInsurance = Request.Form("cboFireTheftInsurance")
	intWorkcoverInsurance = Request.Form("cboWorkcoverInsurance")
	intPublicLiability 	= Request.Form("cboPublicLiability")
	strPremisesSize 	= Replace(Request.Form("txtPremisesSize"),"'","''")
	strWorkshopSize 	= Replace(Request.Form("txtWorkshopSize"),"'","''")
	strNoRepairs 		= Replace(Request.Form("txtNoRepairs"),"'","''")
	intOHS 				= Request.Form("cboOHS")
	intSoftware 		= Request.Form("cboSoftware")
	strSoftware 		= Replace(Request.Form("txtSoftware"),"'","''")
	intInternet 		= Request.Form("cboInternet")
	strHomepage 		= Request.Form("chkHomepage")
	strManual 			= Request.Form("cboManual")
	strSeminar 			= Replace(Request.Form("txtSeminar"),"'","''")
	intTraining 		= Request.Form("cboTraining")
	strProducts 		= Request.Form("chkProducts")
	strExperience 		= Request.Form("cboExperience")
	strServices 		= Request.Form("chkServices")
	strRepairs 			= Request.Form("cboRepairs")
	strStaff 			= Replace(Request.Form("txtStaff"),"'","''")
	intPricing 			= Request.Form("cboPricing")
	strQuoteRates 		= Replace(Request.Form("txtQuoteRates"),"'","''")
	strLabourRates 		= Replace(Request.Form("txtLabourRates"),"'","''")
	strFieldRates 		= Replace(Request.Form("txtFieldRates"),"'","''")
	
	call OpenDataBase()
		
	strSQL = "INSERT INTO yma_service_survey ("
	strSQL = strSQL & " trading_name ,"
	strSQL = strSQL & " company_name ,"
	strSQL = strSQL & " abn ,"
	strSQL = strSQL & " business_ownership ,"
	strSQL = strSQL & " phone ,"
	strSQL = strSQL & " fax ,"
	strSQL = strSQL & " email ,"
	strSQL = strSQL & " address ,"
	strSQL = strSQL & " city ,"
	strSQL = strSQL & " state ,"
	strSQL = strSQL & " postcode ,"
	strSQL = strSQL & " website ,"
	strSQL = strSQL & " opening_hours ,"
	strSQL = strSQL & " approved_service_centre ,"
	strSQL = strSQL & " approved_service_centre_other ,"
	strSQL = strSQL & " repairs_under_warranty ,"
	strSQL = strSQL & " repairs_outside_warranty ,"
	strSQL = strSQL & " owner_name ,"
	strSQL = strSQL & " service_manager_name ,"
	strSQL = strSQL & " technical_staff ,"
	strSQL = strSQL & " admin_staff ,"
	strSQL = strSQL & " field_staff ,"
	strSQL = strSQL & " security_system ,"
	strSQL = strSQL & " fire_insurance ,"
	strSQL = strSQL & " workcover_insurance ,"
	strSQL = strSQL & " public_liability_insurance ,"
	strSQL = strSQL & " premises_size ,"
	strSQL = strSQL & " workshop_size ,"
	strSQL = strSQL & " max_repairs ,"
	strSQL = strSQL & " ohs ,"
	strSQL = strSQL & " software_package ,"
	strSQL = strSQL & " software_package_name ,"
	strSQL = strSQL & " internet ,"
	strSQL = strSQL & " info_homepage ,"
	strSQL = strSQL & " view_manuals ,"
	strSQL = strSQL & " past_seminars ,"
	strSQL = strSQL & " attend_future_training ,"
	strSQL = strSQL & " products ,"
	strSQL = strSQL & " technical_experience ,"
	strSQL = strSQL & " added_services ,"
	strSQL = strSQL & " repairs_level ,"
	strSQL = strSQL & " staff_details ,"
	strSQL = strSQL & " published_pricing ,"
	strSQL = strSQL & " quote_rates ,"
	strSQL = strSQL & " labour_rates ,"
	strSQL = strSQL & " field_rates "
	strSQL = strSQL & ") VALUES ( "
	strSQL = strSQL & "'" & Server.HTMLEncode(strTradingName) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strCompanyName) & "',"
	strSQL = strSQL & "'" & strABN & "',"
	strSQL = strSQL & "'" & strBusinessOwnership & "',"
	strSQL = strSQL & "'" & strPhone & "',"
	strSQL = strSQL & "'" & strFax & "',"
	strSQL = strSQL & "'" & strEmail & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strAddress) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strCity) & "',"
	strSQL = strSQL & "'" & strState & "',"
	strSQL = strSQL & "'" & strPostcode & "',"
	strSQL = strSQL & "'" & strWebsite & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strOpeningHours) & "',"
	strSQL = strSQL & "'" & intApproved & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strApprovedOther) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strUnderWarranty) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strOutsideWarranty) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strOwnersName) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strServiceManagerName) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strTechnicalStaff) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strAdminStaff) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strFieldStaff) & "',"
	strSQL = strSQL & "'" & intSecuritySystem & "',"
	strSQL = strSQL & "'" & intFireTheftInsurance & "',"
	strSQL = strSQL & "'" & intWorkcoverInsurance & "',"
	strSQL = strSQL & "'" & intPublicLiability & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strPremisesSize) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strWorkshopSize) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strNoRepairs) & "',"
	strSQL = strSQL & "'" & intOHS & "',"
	strSQL = strSQL & "'" & intSoftware & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strSoftware) & "',"
	strSQL = strSQL & "'" & intInternet & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strHomepage) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strManual) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strSeminar) & "',"
	strSQL = strSQL & "'" & intTraining & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strProducts) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strExperience) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strServices) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strRepairs) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strStaff) & "',"
	strSQL = strSQL & "'" & intPricing & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strQuoteRates) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strLabourRates) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(strFieldRates) & "'"
	strSQL = strSQL & ")"
	
	response.Write strSQL	
	  
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
<h1>Yamaha Service Centre Survey</h1>
<form action="" method="post" name="form_survey" id="form_survey" onsubmit="return validateFormOnSubmit(this)">
  <h2>1. General</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="30%">1.1. Trading name:</td>
      <td width="70%"><input type="text" id="txtTradingName" name="txtTradingName" maxlength="50" size="60" /></td>
    </tr>
    <tr>
      <td>1.2. Company name:</td>
      <td><input type="text" id="txtCompanyName" name="txtCompanyName" maxlength="50" size="60" />
        (if different from above)</td>
    </tr>
    <tr>
      <td>1.3. ABN:</td>
      <td><input type="text" id="txtABN" name="txtABN" maxlength="20" size="30" /></td>
    </tr>
    <tr>
      <td>1.4. Business ownership:</td>
      <td><select name="cboBusinessOwnership">
          <option value="">...</option>
          <option value="Sole Trader">Sole Trader</option>
          <option value="Partnership">Partnership</option>
          <option value="Trust">Trust</option>
          <option value="Company">Company</option>
        </select></td>
    </tr>
    <tr>
      <td>1.5. Main telephone:</td>
      <td><input type="text" id="txtPhone" name="txtPhone" maxlength="12" size="15" /></td>
    </tr>
    <tr>
      <td>1.6. Main fax:</td>
      <td><input type="text" id="txtFax" name="txtFax" maxlength="12" size="15" /></td>
    </tr>
    <tr>
      <td>1.7. Main email:</td>
      <td><input type="text" id="txtEmail" name="txtEmail" maxlength="50" size="60" /></td>
    </tr>
    <tr>
      <td>1.8. Address:</td>
      <td><input type="text" id="txtAddress" name="txtAddress" maxlength="50" size="60" /></td>
    </tr>
    <tr>
      <td>1.9. City:</td>
      <td><input type="text" id="txtCity" name="txtCity" maxlength="40" size="50" /></td>
    </tr>
    <tr>
      <td>1.10. State:</td>
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
      <td>1.11. Postcode:</td>
      <td><input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="5" /></td>
    </tr>
    <tr>
      <td>1.12. Website:</td>
      <td><input type="text" id="txtWebsite" name="txtWebsite" maxlength="30" size="40" /></td>
    </tr>
    <tr>
      <td>1.13. Opening hours:</td>
      <td><input type="text" id="txtOpeningHours" name="txtOpeningHours" maxlength="20" size="30" /></td>
    </tr>
    <tr>
      <td colspan="2">1.14. Are you an approved service centre for Yamaha?
        <select name="cboApproved">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select>
        </td>
    </tr>
    <tr>
      <td align="right">If no, please specify:</td>
      <td><input type="text" id="txtApprovedOther" name="txtApprovedOther" maxlength="20" size="30" /></td>
    </tr>
    <tr>
      <td colspan="2">1.15. How many Yamaha product repairs per month does your company complete?</td>
    </tr>
    <tr>
      <td align="right">Under warranty:</td>
      <td><input type="text" id="txtUnderWarranty" name="txtUnderWarranty" maxlength="3" size="6" /></td>
    </tr>
    <tr>
      <td align="right">Outside warranty:</td>
      <td><input type="text" id="txtOutsideWarranty" name="txtOutsideWarranty" maxlength="3" size="6" /></td>
    </tr>
  </table>
  <h2>2. Organisation</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="30%">2.1. General Manager / Owner's name:</td>
      <td width="70%"><input type="text" id="txtOwnersName" name="txtOwnersName" maxlength="50" size="60" /></td>
    </tr>
    <tr>
      <td>2.2. Service Manager's name:</td>
      <td><input type="text" id="txtServiceManagerName" name="txtServiceManagerName" maxlength="50" size="60" /></td>
    </tr>
    <tr>
      <td>2.3. How many do you employ?</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td align="right">Technical staff</td>
      <td><input type="text" id="txtTechnicalStaff" name="txtTechnicalStaff" maxlength="3" size="6" /></td>
    </tr>
    <tr>
      <td align="right">Admin staff</td>
      <td><input type="text" id="txtAdminStaff" name="txtAdminStaff" maxlength="3" size="6" /></td>
    </tr>
    <tr>
      <td align="right">Field technical</td>
      <td><input type="text" id="txtFieldStaff" name="txtFieldStaff" maxlength="3" size="6" /></td>
    </tr>
    <tr>
      <td colspan="2">2.4. Is your premises protected by a monitored Security System?
        <select name="cboSecuritySystem">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
  </table>
  <h2>3. Insurances</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="100%" colspan="2">3.1. Do you hold current insurance for fire &amp; theft?
        <select name="cboFireTheftInsurance">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">3.2. Do you hold a current workcover insurances certificate for your state?
        <select name="cboWorkcoverInsurance">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">3.3. Do you hold public liability insurance?
        <select name="cboPublicLiability">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
  </table>
  <h2>4. General</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="40%">4.1. What size is your premise in square meters?</td>
      <td width="60%"><input type="text" id="txtPremisesSize" name="txtPremisesSize" maxlength="6" size="10" />
        m<sup>2</sup></td>
    </tr>
    <tr>
      <td>4.2. What size is your workshop in square meters?</td>
      <td><input type="text" id="txtWorkshopSize" name="txtWorkshopSize" maxlength="6" size="10" />
        m<sup>2</sup></td>
    </tr>
    <tr>
      <td>4.3. Maximum no of repairs per month:</td>
      <td><input type="text" id="txtNoRepairs" name="txtNoRepairs" maxlength="3" size="6" /></td>
    </tr>
    <tr>
      <td colspan="2">4.4. Does your business comply with Occupational Health &amp; Safety regulations?
        <select name="cboOHS">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
  </table>
  <h2>5. IT</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td colspan="2">5.1. Do you use a software package to manage &amp; track your repairs?
        <select name="cboSoftware">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">If yes, please specify:
        <input type="text" id="txtSoftware" name="txtSoftware" maxlength="20" size="30" /></td>
    </tr>
    <tr>
      <td colspan="2">5.2. Do you have internet access?
        <select name="cboInternet">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">5.3. What kind of information can be gathered from your company homepage?</td>
    </tr>
    <tr>
      <td width="10%" align="right">&nbsp;</td>
      <td width="90%"><input type="checkbox" name="chkHomepage" value="Status queries" />
        Status queries about repairs</td>
    </tr>
    <tr>
      <td align="right">&nbsp;</td>
      <td><input type="checkbox" name="chkHomepage" value="Internet shop" />
        Internet shop</td>
    </tr>
    <tr>
      <td align="right">&nbsp;</td>
      <td><input type="checkbox" name="chkHomepage" value="Other" />
        Other</td>
    </tr>
    <tr>
      <td colspan="2">5.4. How do you view service manuals?
        <select name="cboManual">
          <option value="">...</option>
          <option value="Hardcopy">Hardcopy</option>
          <option value="Electronically">Electronically</option>
        </select></td>
    </tr>
  </table>
  <h2>6. Training / Education</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td width="100%" colspan="2">6.1. How many manufacturer's technical seminars has your company attended within the last 5 years?
        <input type="text" id="txtSeminar" name="txtSeminar" maxlength="3" size="6" /></td>
    </tr>
    <tr>
      <td colspan="2">6.2. Would you / technical staff be willing to attend Yamaha technical training courses once per year?
        <select name="cboTraining">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
  </table>
  <h2>7. Product</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td colspan="4">7.1. Which products do you service?</td>
    </tr>
    <tr>
      <td width="10%">&nbsp;</td>
      <td width="30%"><input type="checkbox" name="chkProducts" value="AV" />
        Audio Visual</td>
      <td width="30%"><input type="checkbox" name="chkProducts" value="Pianos" />
        Pianos</td>
      <td width="30%"><input type="checkbox" name="chkProducts" value="Guitars" />
        Guitars</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkProducts" value="CA" />
        Commercial Audio</td>
      <td><input type="checkbox" name="chkProducts" value="DP" />
        Digital Pianos</td>
      <td><input type="checkbox" name="chkProducts" value="Keyboards" />
        Keyboards</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkProducts" value="Digital Music" />
        Digital Music Instruments</td>
      <td><input type="checkbox" name="chkProducts" value="Percussion" />
        Percussion</td>
      <td><input type="checkbox" name="chkProducts" value="Paiste" />
        Paiste</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkProducts" value="Steinberg" />
        Steinberg</td>
      <td><input type="checkbox" name="chkProducts" value="Disklavier" />
        Disklavier</td>
      <td><input type="checkbox" name="chkProducts" value="VOX" />
        VOX</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkProducts" value="BO" />
        Band &amp; Orchestral</td>
      <td><input type="checkbox" name="chkProducts" value="Elect Drums" />
        Electronic Drums</td>
      <td><input type="checkbox" name="chkProducts" value="Mixing PA" />
        Mixing Desks &amp; PA Systems</td>
    </tr>
    <tr>
      <td colspan="4">7.2. How would you assess your technical experience?
        <select name="cboExperience">
          <option value="">...</option>
          <option value="1">1+ year</option>
          <option value="3">3+ years</option>
          <option value="5">5+ years</option>
          <option value="7">7+ years</option>
          <option value="10">10+ years</option>
          <option value="15">15+ years</option>
        </select></td>
    </tr>
  </table>
  <h2>8. Services</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td colspan="2">8.1. Which additional value added services does your company offer?</td>
    </tr>
    <tr>
      <td width="10%">&nbsp;</td>
      <td width="90%"><input type="checkbox" name="chkServices" value="Pickup delivery">
        Pickup up, delivery</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkServices" value="Field service">
        Field service</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="checkbox" name="chkServices" value="Installation">
        Installation</td>
    </tr>
    <tr>
      <td colspan="2">8.2. Up to which level are you able to conduct repairs?
        <select name="cboRepairs" id="cboRepairs">
          <option value="">...</option>
          <option value="Circuit Board Only">Circuit Board Only</option>
          <option value="Component Level">Component Level</option>
        </select></td>
    </tr>
  </table>
  <h2>9. Reporting</h2>
  <table border="0" cellspacing="0" cellpadding="5" class="main_form_table">
    <tr>
      <td colspan="2">9.1. Please name all your staff and their email addresses utilising the Yamaha YSISS System</td>
    </tr>
    <tr>
      <td width="10%">&nbsp;</td>
      <td width="90%"><input type="text" id="txtStaff" name="txtStaff" maxlength="150" size="110" /></td>
    </tr>
    <tr>
      <td colspan="2">9.2. Do you have published pricing for service?
        <select name="cboPricing">
          <option value="">...</option>
          <option value="1">Yes</option>
          <option value="0">No</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2">9.3. What are your publicly rates for quotation, labour per hour, field service?</td>
    </tr>
    <tr>
      <td align="right">Quote</td>
      <td>$
        <input type="text" id="txtQuoteRates" name="txtQuoteRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Labour</td>
      <td>$
        <input type="text" id="txtLabourRates" name="txtLabourRates" maxlength="6" size="8" /></td>
    </tr>
    <tr>
      <td align="right">Field</td>
      <td>$
        <input type="text" id="txtFieldRates" name="txtFieldRates" maxlength="6" size="8" /></td>
    </tr>
  </table>
  <p>
    <input type="hidden" name="Action" />
    <input type="submit" value="Submit" />
  </p>
</form>
</body>
</html>