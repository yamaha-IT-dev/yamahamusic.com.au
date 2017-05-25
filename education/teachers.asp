<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Category.asp" -->
<!--#include file="../src/classes/Resource.asp" -->
<!--#include file="../src/classes/Discussion.asp" -->
<!--#include file="../src/classes/Topic.asp" -->
<!--#include file="../src/classes/Profile.asp" -->
<!--#include file="../src/classes/Teacher.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var TEACHER_HOME = "teacher_home";
var TEACHER_LOGIN = "teacher_login";
var TEACHER_LOGOUT = "teacher_logout";
var LIST_ITEMS = "list_items";
var VIEW_ITEM = "view_item";

// global variables & default values
var CONTROLLER = "teachers.asp";
var action = TEACHER_HOME;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}


// state machine
if (action == TEACHER_HOME) {

	showTeacherHome('', null);

} else if (action == TEACHER_LOGIN) {

	authenticateUser();

} else if (action == TEACHER_LOGOUT) {

	Session("yma_userid") = null;
	Session("yma_customerid") = null;
	endProcess();

} else if (action == LIST_ITEMS) {

	if (!Session("yma_userid") > 0) {
		Response.Redirect(CONTROLLER);
	}
	showItemsByCategory();

} else if (action == VIEW_ITEM) {

	showTeacherItem();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *	
 */
function showTeacherHome(message, objU) {

	var U = null;
	var intUserID = Session("yma_userid");

	if (objU) {
		U = objU;
	} else {
		if (!isNaN(intUserID) && intUserID != 0) {
			var U = new User();
				U._loadUser(intUserID);
			
			/* 
				Check for rights to access this area.
			*/
			if (U._getUserUsertypeID() && U._getUserUsertypeID() != GBL_USERTYPE_TEACHER && U._getUserUsertypeID() != GBL_USERTYPE_ADMIN) {
				Response.Redirect("/notpermitted.asp");			
			}

		} else {
			var U = new User();
		}		
	}

	%><!--#include file="../src/html/teacherHome.asp"--><%
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
		showTeacherHome(strmsg, U);
	}

}


/*
 *	
 */
function showTeacherItem() {

	%><!--#include file="../src/html/teacherItem.asp"--><%
}



/*
 *	
 */
function showItemsByCategory() {

	var intCategoryID = parseInt(Request("categoryid"));
	var C = new Category();
	var R = new Resource();
	var rsAllResources = R._getAllResourcesByCategory(intCategoryID, true);

	%><!--#include file="../src/html/teacherItems.asp"--><%
}

%>


