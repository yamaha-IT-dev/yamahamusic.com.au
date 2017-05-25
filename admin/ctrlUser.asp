<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/UserType.asp" -->
<!--#include file="../src/classes/Profile.asp" -->
<!--#include file="../src/classes/Service.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_USERS = "list_users";
var LIST_DEALERS = "list_dealers";
var CREATE_USER = "create_user";
var EDIT_USER = "edit_user";
var SAVE_USER = "save_user";
var DELETE_USER = "delete_user";
var PROMOTE_CUSTOMER = "promote_customer";

// global variables & default values
var CONTROLLER = "ctrlUser.asp";
var action = LIST_USERS;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}

// state machine
if (action == LIST_USERS) {

	listUsers();

} else if (action == LIST_DEALERS) {

	listDealers();

} else if (action == CREATE_USER) {

	createUser();

} else if (action == EDIT_USER) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"User Details Saved":""
	}
	editUser(strmsg, null, null);

} else if (action == SAVE_USER) {

	saveUser();

} else if (action == DELETE_USER) {

	removeUser();

} else if (action == PROMOTE_CUSTOMER) {

	promoteCustomer();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

//GBL_CONN.close();

/*
 *	
 */
function listUsers() {

	var U = new User();
	var C = new Customer();

	var intUserTypeID = new Number(Request("usertypeid"));
	if (isNaN(intUserTypeID)) {
		intUserTypeID = 0;
	}

	var rsAllUsers = U._getAllUsers(intUserTypeID);
	var rsAllUserTypes = U._getAllUserTypes();
	%><!--#include file="../src/html/admin/userList.asp"--><%
}

/*
 *	
 */
function listDealers() {

	var U = new User();
	var C = new Customer();

	var rsAllDealers = U._getAllDealers();

	%><!--#include file="../src/html/admin/dealerList.asp"--><%
}


/*
 *	
 */
function createUser() {

	var message = new String();
	var U = new User();
	var C = new Customer();

	%><!--#include file="../src/html/admin/userEdit.asp"--><%
}


/*
 *	
 */
function promoteCustomer() {

	var message = new String();
	var U = new User();

	var intCustomerID = new Number(Request("customerid"));
	var C = new Customer();
	if (!isNaN(intCustomerID)) {
		C._loadCustomer(intCustomerID);
	}

	%><!--#include file="../src/html/admin/userEdit.asp"--><%
}

/*
 *	
 */
function editUser(message, objU, objC) {

	var intUserID = new Number(Request("userid"));

	var U = null;

	if (objU) {
		U = objU;
	} else {
		U = new User();
		if (!isNaN(intUserID)) {
			U._loadUser(intUserID);
		}
	}

	if (objC) {
		C = objC;
	} else {
		C = new Customer();
		if (!isNaN(intUserID)) {
			C._loadCustomer(U._getUserCustomerID());
		}
	}

	%><!--#include file="../src/html/admin/userEdit.asp"--><%
}


/*
 *	
 */
function saveUser() {

	var strmsg = new String();
	var intUserID = new Number(Request("userid"));
	var intCustomerID = new Number(Request("customerid"));

	var U = new User();
		if (!isNaN(intUserID)) {
			U._loadUser(intUserID);
		}
		U._setUserUsername(new String(Request("username")));
		U._setUserPassword(new String(Request("password")));
		U._setUserUsertypeID(new Number(Request("usertypeid")));
		U._setUserStatus(new String(Request("status")));

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
		C._setCustomerDateofbirth(GBLMakeDate(Request("dobDay"),Request("dobMonth"),Request("dobYear"), null, null, null));

	var strvaliduser = validateUser(U);
	var strvalidcustomer = validateCustomer(C);
	
	if (strvaliduser.length == 0 && strvalidcustomer == 0) {

		if (C._getCustomerID() > 0) {
			C._saveCustomer();	
		} else {
			var intCustomerID = C._addCustomer();
		}
		if (U._getUserID() > 0) {
			U._saveUser();

			if (U._getUserUsertypeID() == 6) {
				// user belongs to a service centre
				var intServiceCentreID = new Number(Request("servicecentreid"));
				if (intServiceCentreID > 0) {
					U._removeUserFromServiceCentre(intUserID);
					U._addUserToServiceCentre(intUserID, intServiceCentreID);
				}
			}

		} else {
			U._setUserCustomerID(intCustomerID);
			var intUserID = U._addUser();
		}
		endProcessPlus("action=" + EDIT_USER + "&userid=" + intUserID + "&intmsg=1");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvaliduser + strvalidcustomer;
		editUser(strmsg, U, C);
	}
}

/*
 *	
 */
function removeUser() {

	var intUserID = new Number(Request("userid"));
	var U = new User();
	var C = new Customer();
	
	if (!isNaN(intUserID)) {
		U._loadUser(intUserID);
		C._setCustomerID(U._getUserCustomerID());

		C._deleteCustomer();
		U._deleteUser();
	}

	endProcess();
}


/*
 *	
 */
function validateUser(U) {
	strErr = new String();
	if (U._getUserUsername().length == 0 || U._getUserUsername().indexOf("undefined") == 0) {
		strErr += " - You must enter a valid username<br>";	
	} else {
		var checkusername = new String(Request("checkusername"));
		if (checkusername.indexOf("undefined") == 0 || U._getUserUsername().indexOf(checkusername) == -1 || checkusername.length == 0) {
			if (U._usernameExistsAlready() > 0) {
				strErr += " - The username you have chosen already exists. Please think of something else.<br>";
			}
		}
	}	
	if (U._getUserPassword().length < 6 || U._getUserPassword().indexOf("undefined") == 0) {
		strErr += " - You must enter a valid password, no less than 6 characters<br>";	
	}
	return strErr;
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
	
	return strErr;
}




%>


