<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Warranty.asp" -->
<!--#include file="../src/classes/Lead.asp" -->
<!--#include file="../src/classes/Student.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_CUSTOMER = "list_customer";
var NEW_CUSTOMER = "new_customer";
var EDIT_CUSTOMER = "edit_customer";
var SAVE_CUSTOMER = "save_customer";
var DELETE_CUSTOMER = "delete_customer";
var CUSTOMER_REPORT = "customer_report";
var CUSTOMER_REPORT_BIKE = "customer_report_bike";

// global variables & default values
var CONTROLLER = "ctrlCustomer.asp";
var action = LIST_CUSTOMER;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}




// state machine
if (action == LIST_CUSTOMER) {

	listCustomer();

} else if (action == NEW_CUSTOMER) {

	newCustomer();

} else if (action == EDIT_CUSTOMER) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Customer Saved":""
	}
	editCustomer(strmsg, null);

} else if (action == SAVE_CUSTOMER) {

	saveCustomer();

} else if (action == DELETE_CUSTOMER) {

	removeCustomer();

} else if (action == CUSTOMER_REPORT) {

	customerReportHome();

} else if (action == CUSTOMER_REPORT_BIKE) {

	customerReportWinABike();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *	
 */
function listCustomer() {

	var C = new Customer();
	%><!--#include file="../src/html/admin/customerList.asp"--><%
}


/*
 *	
 */
function newCustomer() {

	var message = new String();
	var C = new Customer();

	var S = new Student();
	var rsStudents = null;
	var L = new Lead();

	%><!--#include file="../src/html/admin/customerEdit.asp"--><%
}



/*
 *	
 */
function editCustomer(message, objC) {

	var intCustomerID = new Number(Request("customerid"));

	var C = null;

	if (objC) {
		C = objC;
	} else {
		C = new Customer();
		if (!isNaN(intCustomerID)) {
			C._loadCustomer(intCustomerID);
		}
	}
	var S = new Student();
	var rsStudents = null;
		rsStudents = S._getAllStudentsByCustomer(intCustomerID);
	var L = new Lead()
		L._loadLeadByCustomerID(intCustomerID);

	%><!--#include file="../src/html/admin/customerEdit.asp"--><%
}


/*
 *	
 */
function saveCustomer() {

	var strmsg = new String();
	var intCustomerID = new Number(Request("customerid"));

	var C = new Customer();
		if (!isNaN(intCustomerID)) {
			C._loadCustomer(intCustomerID);
		}
		C._setCustomerTitle(new String(Request("title")));
		C._setCustomerFirstname(cleanForSQL(new String(Request("firstname"))));
		C._setCustomerLastname(cleanForSQL(new String(Request("lastname"))));
		C._setCustomerAddress(cleanForSQL(new String(Request("address"))));
		C._setCustomerCity(cleanForSQL(new String(Request("city"))));
		C._setCustomerState(cleanForSQL(new String(Request("state"))));
		C._setCustomerCountry(cleanForSQL(new String(Request("country"))));
		C._setCustomerPostcode(new String(Request("postcode")));
		C._setCustomerEmail(cleanForSQL(new String(Request("email"))));
		C._setCustomerPassword(new String(Request("password")));
		C._setCustomerOptinnews(new Number(Request("optinnews"))==1?1:0);
		C._setCustomerOptinproduct(new Number(Request("optinproduct"))==1?1:0);
		C._setCustomerOptinyaypc(new Number(Request("optinyaypc"))==1?1:0);
		C._setCustomerDateofbirth(GBLMakeDate(Request("dobDay"),Request("dobMonth"),Request("dobYear"), null, null, null));

	var strvalid = validateCustomer(C);
	
	if (strvalid.length == 0) {

		if (C._getCustomerID() > 0) {
			C._saveCustomer();	
		} else {
			var intCustomerID = C._addCustomer();
		}
		endProcessPlus("action=" + EDIT_CUSTOMER + "&customerid=" + intCustomerID + "&intmsg=1");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editCustomer(strmsg, C);
	}
}



/*
 *	
 */
function removeCustomer() {

	var intCustomerID = new Number(Request("customerid"));
	var C = new Customer();
	
	if (!isNaN(intCustomerID)) {
		C._setCustomerID(intCustomerID);
		C._deleteCustomer();
	}

	endProcess();
}


/*
 *	
 */
function validateCustomer(C) {
	strErr = new String();
	if (C._getCustomerFirstname().length == 0 || C._getCustomerFirstname().indexOf("undefined") == 0) {
		strErr += " - You must provide the users firstname<br>";	
	}	
	if (C._getCustomerLastname().length == 0 || C._getCustomerLastname().indexOf("undefined") == 0) {
		strErr += " - You must provide the users surname<br>";	
	}	
	if (C._getCustomerEmail().length == 0 || C._getCustomerEmail().indexOf("undefined") == 0) {
		strErr += " - You must provide the users email address<br>";	
	} else {
		var checkemail = new String(Request("checkemail"));
		if (checkemail.indexOf("undefined") == 0 || C._getCustomerEmail().indexOf(checkemail) == -1 || checkemail.length == 0) {
			if (C._emailExistsAlready() > 0) {
				strErr += " - The email address you have entered is already in use. Duplicate email addresses aren't allowed.<br>";
			}
		}
	}	
	if (C._getCustomerEmail().indexOf("@") < 1) {
		strErr += " - Please check the email address entered; it must be in the form name@domain.com<br>";	
	}	
	if (new Number(Request("dobDay")) == 0 || new Number(Request("dobMonth")) == 0 || new Number(Request("dobYear")) == 0) {
		strErr += " - Please check your date of birth - you must fill in all the fields<br>";	
	}	
	if (!GBLValidateDate(new Number(Request("dobYear")), new Number(Request("dobMonth")), new Number(Request("dobDay")))) {
		strErr += " - Please check your date of birth - your date isn't right<br>";	
	}	
	
	return strErr;
}


/*
 *	
 */
function customerReportHome() {

	%><!--#include file="../src/html/admin/customerReport.asp"--><%
}


/*
 *	
 */
 function customerReportWinABike() {

	var strSQL = "SELECT yma_customer.state, yma_warranty.modelnumber, count(yma_warranty.id) as 'sold' " +
				 "FROM yma_warranty " +
				 "INNER JOIN yma_customer ON yma_customer.id = yma_warranty.customerid " +
				 "WHERE warrantytypeid = 4 " +
				 "GROUP BY yma_warranty.modelnumber, yma_customer.state " +
				 "ORDER BY yma_customer.state ASC, 'sold' DESC, yma_warranty.modelnumber ASC";

	var C = new Customer();
	var rsAllCustomers = C._getCustomersByQuery(strSQL);
	%><!--#include file="../src/html/admin/customerReportWinABike.asp"--><%

	
}








%>


