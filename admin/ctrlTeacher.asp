<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Teacher.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_TEACHERS = "list_teachers";
var ADD_TEACHER = "add_teacher";
var EDIT_TEACHER = "edit_teacher";
var SAVE_TEACHER = "save_teacher";
var DELETE_TEACHER = "delete_teacher";

// global variables & default values
var CONTROLLER = "ctrlTeacher.asp";
var action = LIST_TEACHERS;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}


// state machine
if (action == LIST_TEACHERS) {

	listTeachers();

} else if (action == ADD_TEACHER) {

	createTeacher();

} else if (action == EDIT_TEACHER) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Teacher Details Saved":""
	}
	editTeacher(strmsg, null, null);

} else if (action == SAVE_TEACHER) {

	saveTeacher();

} else if (action == DELETE_TEACHER) {

	removeTeacher();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();

/*
 *	
 */
function listTeachers() {

	var T = new Teacher();

	var rsAllTeachers = T._getAllTeachersAsRS();
	var rsAllUnassigned = T._getAllTeachersNotAssigned();

	%><!--#include file="../src/html/admin/teacherList.asp"--><%
}


/*
 *	
 */
function createTeacher() {

	var message = new String();
	

	var U = new User();
	var C = new Customer();
	var T = new Teacher();

	var intUserID = new Number(Request("userid"));

	var U = new User();
	if (!isNaN(intUserID)) {
		U._loadUser(intUserID);
		C._loadCustomer(U._getUserCustomerID());
		T._setTeacherEmail(C._getCustomerEmail());
	}

	%><!--#include file="../src/html/admin/teacherEdit.asp"--><%
}


/*
 *	
 */
function editTeacher(message, objT) {

	var intTeacherID = new Number(Request("teacherid"));

	var T = null;
	var U = new User();
	var C = new Customer();

	if (objT) {
		T = objT;
	} else {
		T = new Teacher();
		if (!isNaN(intTeacherID)) {
			T._loadTeacher(intTeacherID);
			U._loadUser(T._getTeacherUserID());
			C._loadCustomer(U._getUserCustomerID());
		}
	}

	%><!--#include file="../src/html/admin/teacherEdit.asp"--><%
}


/*
 *	
 */
function saveTeacher() {

	var strmsg = new String();
	var intTeacherID = new Number(Request("teacherid"));
	var intUserID = new Number(Request("userid"));
	
	var C = new Customer();
	var U = new User();

	if (!isNaN(intUserID)) {
		U._loadUser(intUserID);
		C._loadCustomer(U._getUserCustomerID());
	}

	var T = new Teacher();
		if (!isNaN(intTeacherID)) {
			T._loadTeacher(intTeacherID);
		}
		T._setTeacherUserID(intUserID);
		T._setTeacherCode(new String(Request("code")));
		T._setTeacherState(new String(Request("state")));
		T._setTeacherRegion(new String(Request("region")));
		T._setTeacherEmail(new String(Request("email")));
		T._setTeacherCoordinator(new Number(Request("coordinator"))==1?1:0);

	var strvalid = validateTeacher(T);
	
	if (strvalid.length == 0) {

		if (T._getTeacherID() > 0) 
		{
			T._saveTeacher();	
		} 
		else 
		{
			var intTeacherID = T._addTeacher();
		}
		endProcessPlus("action=" + EDIT_TEACHER + "&teacherid=" + intTeacherID + "&intmsg=1");
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editTeacher(strmsg, T);
	}
}





/*
 *	
 */
function removeTeacher() {

	var intTeacherID = new Number(Request("teacherid"));
	var T = new Teacher();
	
	if (!isNaN(intTeacherID)) {

		T._setTeacherID(intTeacherID);
		T._deleteTeacher();
	}

	endProcess();
}


/*
 *	
 */
function validateTeacher(T) {
	strErr = new String();


	return strErr;
}






%>


