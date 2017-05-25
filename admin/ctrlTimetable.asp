<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->

<!--#include file="../src/classes/Timetable.asp" -->
<!--#include file="../src/classes/EdCourse.asp" -->
<!--#include file="../src/classes/EdCentre.asp" -->

<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_TIMETABLES = "list_timetables";
var ADD_TIMETABLE = "add_timetable";
var EDIT_TIMETABLE = "edit_timetable";
var SAVE_TIMETABLE = "save_timetable";
var DELETE_TIMETABLE = "delete_timetable";

// global variables & default values
var CONTROLLER = "ctrlTimetable.asp";
var action = LIST_TIMETABLES;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}


// state machine
if (action == LIST_TIMETABLES || action == EDIT_TIMETABLE) {

	listTimetables();

} else if (action == SAVE_TIMETABLE) {

	saveTimetable();

} else if (action == DELETE_TIMETABLE) {

	removeTimetable();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();

/*
 *	
 */
function listTimetables() {

	//Response.Write(GBL_CONN);

	var intTimetableID = new Number(Request("timetableid"));

	var intTerm = !isNaN(parseInt(Request("term")))?parseInt(Request("term")):null;
	var intCourseID = !isNaN(parseInt(Request("courseid")))?parseInt(Request("courseid")):null;
	var intCentreID = !isNaN(parseInt(Request("centreid")))?parseInt(Request("centreid")):null;
	var intDay = !isNaN(parseInt(Request("day")))?parseInt(Request("day")):null;
	var strState = new String(Request("state")).indexOf("undefined")!=0?new String(Request("state")):"";

	var radioform = false;

	var EDCourse = new EdCourse();
	var rsCourses = EDCourse._getAllCourses();

	var EDCentre = new EdCentre();
	var rsCentres = EDCentre._getAllCentre(null, null);

	var T = new Timetable()
	var rsT = T._getTimetable(intCourseID, intCentreID, intDay, strState, intTerm);
	var strCentre = new String("");

	%><!--#include file="../src/html/admin/timetableList.asp"--><%

}



/*
 *	
 */
function saveTimetable() {

	var strmsg = new String();
	var intTimetableID = new Number(Request("timetableid"));
	var strDatestart = null;
	if (parseInt(Request("openDay")) > 0 && parseInt(Request("openMonth")) > 0 && parseInt(Request("openYear")) > 0 ) {
		strDatestart = GBLMakeDate(Request("openDay"),Request("openMonth"),Request("openYear"), null, null, null);
	}
	
	var T = new Timetable();
		if (!isNaN(intTimetableID)) {
			T._loadTimetable(intTimetableID);
		}
		T._setTimetableCentreID(parseInt(Request("centreid")));
		T._setTimetableCourseID(parseInt(Request("courseid")));
		T._setTimetableTerm(parseInt(Request("term")));
		T._setTimetableDay(parseInt(Request("day")));
		T._setTimetableTime(new String(Request("hour") + "." + GBLLeadingZeros(Request("minute"),2) + " " + Request("meridian")));
		T._setTimetableDatestart(strDatestart);
		T._setTimetableStatus(new Number(Request("status"))==1?1:0);

	var strvalid = validateTimetable(T);
	
	if (strvalid.length == 0) {

		if (T._getTimetableID() > 0) {
			T._saveTimetable();	
		} else {
			var intTimetableID = T._addTimetable();
		}

		endProcessPlus("action=" + LIST_TIMETABLES);
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editTeacher(strmsg, T);
	}
}



/*
 *	
 */
function removeTimetable() {

	var intTimetableID = new Number(Request("timetableid"));
	
	var T = new Timetable();
	
	if (!isNaN(intTimetableID)) {
		T._setTimetableID(intTimetableID);
		T._deleteTimetable();
	}
	endProcess();
}



/*
 *	
 */
function validateTimetable(T) {
	strErr = new String();


	return strErr;
}




%>


