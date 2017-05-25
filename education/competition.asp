<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Warranty.asp" -->
<!--#include file="../src/classes/ProductEnquiry.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var COMPETITION_HOME = "competition_home";
var COMPETITION_TERMS = "competition_terms";
var COMPETITION_REGISTER = "competition_register";
var CUSTOMER_LOGIN = "customer_login";
var SAVE_REGISTRATION = "save_registration";
var COMPETITION_ENTER = "competition_enter";
var SAVE_ENTRY = "save_entry";
var COMPETITION_DONE = "competition_done";

// global variables & default values
var CONTROLLER = "competition.asp";
var action = COMPETITION_HOME;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}


// state machine
if (action == COMPETITION_HOME) {

	showCompetitionHome('', null);

} else if (action == COMPETITION_TERMS) {
 
	showCompetitionTerms();

} else if (action == CUSTOMER_LOGIN) {

	authenticateUser();

} else if (action == COMPETITION_REGISTER) {

	customerRegistration('', null);

} else if (action == SAVE_REGISTRATION) {

	saveCustomer();

} else if (action == COMPETITION_ENTER) {

	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		var strmsg = intmsg==2?"<span style=\"color:#003366;font-weight:bold;\">Thankyou, your registration has been saved successfully. Now you can enter the competition!</span>":"";
	}

	competitionEntry(strmsg, null);

} else if (action == SAVE_ENTRY) {

	saveEntry();

} else if (action == COMPETITION_DONE) {

	competitionThanks();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();





/*	*/
function showCompetitionHome(message, objPE) {

	var PE = null;
	var strTime = "";
	var strLocation = "";

	if (objPE) {
		PE = objPE;
	} else {
		PE = new ProductEnquiry();
	}

	if (PE._getProductEnquirySource().length > 0 && PE._getProductEnquirySource().indexOf("|") > 0) {
		var arrSource = PE._getProductEnquirySource().split("|");
		strTime = arrSource[0];
		strLocation = arrSource[1];
	}

	%><!--#include file="../src/html/ymecCompetitionHome.asp"--><%
}

/*	*/
function showCompetitionTerms() {

	%><!--#include file="../src/html/ymecCompetitionTerms.asp"--><%
}




/*
 *	
 */
function saveEntry() {

	var strmsg = new String();

	var PE = new ProductEnquiry();
		PE._setProductEnquiryType(new String(Request("type")));
		PE._setProductEnquiryName(cleanForSQL(new String(Request("name"))));
		PE._setProductEnquiryEmail(cleanForSQL(new String(Request("email"))));
		PE._setProductEnquiryPostcode(cleanForSQL(new String(Request("postcode"))));
		PE._setProductEnquirySource(cleanForSQL(new String(Request("time"))) + "|" + cleanForSQL(new String(Request("location"))));
		PE._setProductEnquiryComments(cleanForSQL(new String(Request("comments"))));

	var strvalid = validateProductEnquiry(PE);
	
	if (strvalid.length == 0) {

		var intID = PE._addProductEnquiry();

		endProcessPlus("action=" + COMPETITION_DONE);
	
	} else {
		strmsg = "Your Entry cannot be recorded at this time, check the error below and try again<br/>" + strvalid;
		showCompetitionHome(strmsg, PE);
	}
}





/*	*/
function competitionThanks() {

	%><!--#include file="../src/html/ymecCompetitionThanks.asp"--><%
}









/*
 *	
 */
function validateProductEnquiry(PE) {
	strErr = new String();

	var strTime = "";
	var strLocation = "";

	if (PE._getProductEnquirySource().length > 0 && PE._getProductEnquirySource().indexOf("|") > 0) {
		var arrSource = PE._getProductEnquirySource().split("|");
		strTime = new String(arrSource[0]);
		strLocation = new String(arrSource[1]);
	}

	if (PE._getProductEnquiryName().length == 0 || PE._getProductEnquiryName().indexOf("undefined") == 0) {
		strErr += " - You must provide your full name<br>";	
	}	
	if (PE._getProductEnquiryPostcode().length == 0 || PE._getProductEnquiryPostcode().indexOf("undefined") == 0) {
		strErr += " - You must provide a contact phone number<br>";	
	}	
	if (strTime.length == 0 || strTime.indexOf("undefined") == 0) {
		strErr += " - You must let us know what your class time is<br>";	
	}	
	if (strLocation.length == 0 || strLocation.indexOf("undefined") == 0) {
		strErr += " - You must tell us where you have your class<br>";	
	}	
	if (PE._getProductEnquiryComments().length == 0 || PE._getProductEnquiryComments().indexOf("undefined") == 0) {
		strErr += " - You must suggest a name for the newsletter if you want a chance to win!<br>";	
	}	

	
	return strErr;
}





%>


