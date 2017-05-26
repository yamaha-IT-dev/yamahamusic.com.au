<%@LANGUAGE="JScript"%>
<!--#include file="../../src/global.asp" -->
<!--#include file="../../src/utility.asp" -->
<!--#include file="../../src/classes/User.asp" -->
<!--#include file="../../src/classes/Customer.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var SHOW_LOGIN_FORM = "show_login_form";
var VALIDATE_USER = "validate_user";
var SHOW_USER_HOME = "show_user_home";
var USER_LOGOUT = "user_logout";

// global variables & default values
var CONTROLLER = "default.asp";
var action = SHOW_LOGIN_FORM;

// check if user logged in
if (Session("yma_userid")) {	
	action = SHOW_USER_HOME;
}

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {	
	action = Request(ACTION);
}

// state machine
if (action == SHOW_LOGIN_FORM) {

	showLoginForm(new String(''), null);

} else if (action == VALIDATE_USER) {	

	authenticateUser('');

} else if (action == SHOW_USER_HOME) {

	showUserHome();

} else if (action == USER_LOGOUT) {

	Session("yma_userid") = null;
	endProcess();

} else {

	// TODO Eroor page	
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();



/* 
 *
 */
function showLoginForm(message, obj) {

	var intUserID = Session("yma_userid");
	var U = null;

	if (obj) {
		U = obj;
	} else {
		U = new User();
	}
	%><!--#include file="../src/html/adminLogin.asp"--><%
}

/*  
 *	
 */ 
function authenticateUser() {

	var strmsg = new String();

	var U = new User();
		U._setUserUsername(cleanForSQL(new String(Request("username"))));
		U._setUserPassword(cleanForSQL(new String(Request("password"))));

	var userid = U._authenticateUser();

	if (userid > 0) {
		// timeout in four hours
		Session.Timeout = 240; 
		Session("yma_userid") = userid;
		U._loadUser(userid);
		Session("yma_customerid") = U._getUserCustomerID();
		endProcess();
	} else {
		strmsg = "Your login failed, please check your details and try again."
		showLoginForm(strmsg, U);
	}

}


/* 
 *
 */
function showUserHome() {

	var intUserID = Session("yma_userid");

	if (!isNaN(intUserID)) {
		var U = new User();
			U._loadUser(intUserID);
	} else {
		endProcess();
	}
	%><!--#include file="../src/html/adminHome.asp"--><%
}




/*
 *
 */
function endProcess() {
	if (GBL_CONN && GBL_CONN.state == 1) {
		GBL_CONN.close();
		GBL_CONN = null;
	}
	Response.Redirect(CONTROLLER);
}

/*
 *	
 */
function endProcessPlus(qstring) {
	if (GBL_CONN && GBL_CONN.state == 1) {
		GBL_CONN.close();
		GBL_CONN = null;
	}
	Response.Redirect(CONTROLLER + "?" + qstring);
}





%>
