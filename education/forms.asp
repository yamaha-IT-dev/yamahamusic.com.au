<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Form.asp" -->
<!--#include file="../src/classes/Teacher.asp" -->
<!--#include file="../src/classes/EdCentre.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<%

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var FORMS_HOME = "forms_home";
var FORM_TRANSFER = "form_transfer";
var FORM_DISCONTINUE = "form_discontinue";
var FORM_LEAVE = "form_leave";
var FORM_MAKEUP = "form_makeup";
var FORM_ENQUIRY = "form_enquiry";
var FORM_ABSENCE = "form_absence";
var SEND_TRANSFER = "send_transfer";
var SEND_DISCONTINUE = "send_discontinue";
var SEND_LEAVE = "send_leave";
var SEND_MAKEUP = "send_makeup";
var SEND_ENQUIRY = "send_enquiry";
var SEND_ABSENCE = "send_absence";
var ADD_CLASS = "add_class";
var SHOW_SENT = "show_sent";

// global variables & default values
var CONTROLLER = "forms.asp";
var action = FORMS_HOME;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}

var arrReasons = new Array("Student lost interest", "Student not keeping up", "Student ahead of class", "Parent lost interest", "Family leaving area", "Can no longer afford", "Clash with other activity", "Time inconvenient", "Personal problem", "Illness", "School pressures", "Teacher change", "Transfer to private lesson", "Transfer to other course", "Class disbanded");
var arrEnquiry = new Array("Enquiry, wants information posted.", "Book in directly to class - please contact for deposit.");
var arrCourses = new Array("Music Wonderland", "Junior Music", "Young Musicians", "Other");
var arrCsTimes = new Array("Morning (9am - 12pm)", "Afternoon (2pm - 5.30pm)", "Evening (after 6pm)", "Anytime");

var arrLocations = new Array("VIC - Canterbury", "VIC - Glen Waverley", "VIC - Blackburn", "VIC - Endeavour Hills", "VIC - Malvern", "VIC - Frankston", "VIC - Newport", "VIC - Strathmore", "VIC - Templestowe", "VIC - Thornbury", "NSW - Baulkham Hills", "NSW - Chatswood", "NSW - Dulwich Hill", "NSW - Jannali", "NSW - Kogarah", "NSW - Waverley", "NSW - Wentworthville");
var arrLocEmails = new Array("rcvic_east@gmx.yamaha.com", "rcvic_east@gmx.yamaha.com", "rcvic_east@gmx.yamaha.com", "rcvic_east@gmx.yamaha.com", "rcvic_bay@gmx.yamaha.com", "rcvic_bay@gmx.yamaha.com", "rcvic_bay@gmx.yamaha.com", "rcvic_bay@gmx.yamaha.com", "rcvic_bay@gmx.yamaha.com", "rcvic_bay@gmx.yamaha.com", "rcnsw_hills@gmx.yamaha.com", "rcnsw_central@gmx.yamaha.com", "rcnsw_south@gmx.yamaha.com", "rcnsw_south@gmx.yamaha.com", "rcnsw_south@gmx.yamaha.com", "rcnsw_central@gmx.yamaha.com", "rcnsw_hills@gmx.yamaha.com");

var arrAbsence = new Array("Immediate Illness", "Health Reasons", "Family Commitment", "Holiday", "Clash with work/uni", "Other");

var ARR_REASONS = Server.CreateObject("Scripting.Dictionary");
	ARR_REASONS.add("E1",  "Student ahead of class");
	ARR_REASONS.add("E2",  "Immaturity of child");
	ARR_REASONS.add("E3",  "Practice issues");
	ARR_REASONS.add("E4",  "Teacher concern");
	ARR_REASONS.add("E5",  "Class dynamics");
	ARR_REASONS.add("E6",  "Lack of parental commitment");
	ARR_REASONS.add("E7",  "Doesn't see value in group method");
	ARR_REASONS.add("E8",  "Going to music in school");
	ARR_REASONS.add("E9",  "Going to different group music program");
	ARR_REASONS.add("E10", "Other");
	ARR_REASONS.add("L1",  "Graduated without issue");
	ARR_REASONS.add("L2",  "Class disbanded");
	ARR_REASONS.add("L3",  "Family leaving district");
	ARR_REASONS.add("L4",  "Can no longer afford");
	ARR_REASONS.add("L5",  "Clash with another activity");
	ARR_REASONS.add("L6",  "Illness");
	ARR_REASONS.add("L7",  "Change of class teacher");
	ARR_REASONS.add("L8",  "Did not start new class");
	ARR_REASONS.add("L9",  "Over-commitment");
	ARR_REASONS.add("L10", "Started school");
	ARR_REASONS.add("L11", "Change of class time");



if (Session("yma_userid")) {

	// state machine
	if (action == FORMS_HOME) {

		showFormsHome();

	} else if (action == FORM_TRANSFER) {

		showTransferForm(new String(''), null);

	} else if (action == FORM_DISCONTINUE) {

		showDiscontinuationForm(new String(''), null);

	} else if (action == FORM_LEAVE) {

		showLeaveForm(new String(''), null);

	} else if (action == FORM_MAKEUP) {

		showMakeupForm(new String(''), null);

	} else if (action == FORM_ENQUIRY) {

		showEnquiryForm(new String(''), null);

	} else if (action == FORM_ABSENCE) {

		showAbsenceForm(new String(''), null, new Array());

	} else if (action == SEND_TRANSFER) {

		sendTransferForm();

	} else if (action == SEND_DISCONTINUE) {

		sendDiscontinuationForm();

	} else if (action == SEND_LEAVE) {

		sendLeaveForm();

	} else if (action == SEND_MAKEUP) {

		sendMakeupForm();

	} else if (action == SEND_ENQUIRY) {

		sendEnquiryForm();

	} else if (action == SEND_ABSENCE || ADD_CLASS) {

		sendAbsenceForm();

	} else if (action == SHOW_SENT) {

		showSent();

	} else {
		// TODO Eroor page
		Response.Write("Unsupported action: " + action);
	}
} else {
	Response.Redirect("teachers.asp");
}

GBL_CONN.close();




/*
 *
 */
function showFormsHome() {

	var intUserID = Session("yma_userid");
	if (!isNaN(intUserID) && intUserID != 0) {
		var U = new User();
			U._loadUser(intUserID);
		/* Check for rights to access this area. */
		if (U._getUserUsertypeID() != GBL_USERTYPE_TEACHER && U._getUserUsertypeID() != GBL_USERTYPE_ADMIN) {
			Response.Redirect("/notpermitted.asp");
		}
	}

	%><!--#include file="../src/html/teacherFormsHome.asp"--><%
}

/*
 *
 */
function showTransferForm(message, objF) {

	var F = null;
	if (!objF) {
		F = new Form();
		F._setFormDate(new String(""));
		F._setFormDatecommence(new String(""));
	} else {
		F = objF;
	}
	var T = new Teacher();

	%><!--#include file="../src/html/teacherFormTransfer.asp"--><%
}

/*
 *
 */
function showDiscontinuationForm(message, objF) {

	var F = null;
	if (!objF) {
		F = new Form();
		F._setFormDate(new String(""));
		F._setFormReasons(new String(""));
		F._setFormDatediscontinue(new String(""));
		F._setFormInformedoffee(new String("No"));
		F._setFormBookstaken(new String("No"));
	} else {
		F = objF;
	}
	var T = new Teacher();
	var EC = new EdCentre();

	%><!--#include file="../src/html/teacherFormDiscontinue.asp"--><%
}

/*
 *
 */
function showLeaveForm(message, objF) {

	var F = null;
	if (!objF) {
		F = new Form();
		F._setFormDate(new String(""));
		F._setFormDatediscontinue(new String(""));
		F._setFormDaterecommence(new String(""));
	} else {
		F = objF;
	}
	var T = new Teacher();

	%><!--#include file="../src/html/teacherFormLeave.asp"--><%
}

/*
 *
 */
function showMakeupForm(message, objF) {

	var F = null;
	if (!objF) {
		F = new Form();
		F._setFormDate(new String(""));
		F._setFormDatemissed(new String(""));
		F._setFormDatemakeup(new String(""));
	} else {
		F = objF;
	}
	var T = new Teacher();

	%><!--#include file="../src/html/teacherFormMakeup.asp"--><%
}


/*
 *
 */
function showEnquiryForm(message, objF) {

	var F = null;
	if (!objF) {
		F = new Form();
		F._setFormDate(new String(""));
		F._setFormStudentdateofbirth(new String(""));
		F._setFormStudentenquiry(new String(""));
	} else {
		F = objF;
	}

	%><!--#include file="../src/html/teacherFormEnquiry.asp"--><%
}


/*
 *
 */
function showAbsenceForm(message, objF, arrAC) {

	var F = null;
	var T = new Teacher();
	var AC = new AbsentClass(new Date(), new String(), 0, new String());
	var EC = new EdCentre();

	if (!objF) {
		F = new Form();
		F._setFormDate(new String(""));
		F._setFormReasons(new String(""));
		F._setFormDatecommence(new String(""));
		F._setFormDaterecommence(new String(""));

		var arrAbsentClasses = new Array();
			arrAbsentClasses.push(AC);
	} else {
		F = objF;
		arrAbsentClasses = arrAC;
	}

	%><!--#include file="../src/html/teacherFormAbsence.asp"--><%
}



/*
 *
 */
function sendTransferForm() {
	var F = new Form();

		F._setFormRegion(new String(Request("region")));
		F._setFormCity(new String(Request("city")));
		F._setFormStudent(new String(Request("student")));

		F._setFormDate(GBLMakeDate(Request("fDay"),Request("fMonth"),Request("fYear"), null, null, null));

		F._setFormClasscode(new String(Request("classcode")));
		F._setFormBooklevel(new String(Request("booklevel")));
		F._setFormTeachercode(new String(Request("teachercode")));

		F._setFormNewclasscode(new String(Request("newclasscode")));
		F._setFormNewbooklevel(new String(Request("newbooklevel")));
		F._setFormNewteachercode(new String(Request("newteachercode")));
		F._setFormNewregion(new String(Request("newregion")));

		F._setFormComments(new String(Request("comments")));

		F._setFormDatecommence(GBLMakeDate(Request("cDay"),Request("cMonth"),Request("cYear"), null, null, null));

	var strvalid = validateForm(F);
	if (strvalid.length == 0) {
		// showTransferForm("Checks out okay...", F);
		F._sendTransferForm();
		showSent(F);
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		showTransferForm(strmsg, F);
	}
}


/*
 *
 */
function sendDiscontinuationForm() {
	var F = new Form();

		F._setFormStudent(new String(Request("student")));
		F._setFormCity(new String(Request("city")));

		F._setFormDate(GBLMakeDate(Request("fDay"),Request("fMonth"),Request("fYear"), null, null, null));

		F._setFormClasscode(new String(Request("classcode")));
		F._setFormBooklevel(new String(Request("booklevel")));
		F._setFormTeachercode(new String(Request("teachercode")));

		F._setFormReasons(new String(Request("reasons")));

		F._setFormInformedoffee(new String(Request("informed_of_fee")));
		F._setFormLessonsattended(new String(Request("lessons_attended")));
		F._setFormBookstaken(new String(Request("books_taken")));
		F._setFormWhyfeewaived(new String(Request("why_fee_waived")));

		F._setFormComments(new String(Request("comments")));

		F._setFormDatediscontinue(GBLMakeDate(Request("cDay"),Request("cMonth"),Request("cYear"), null, null, null));

	var strvalid = validateForm(F);

	if (strvalid.length == 0)
	{
		// showTransferForm("Checks out okay...", F);
		var EC = new EdCentre();
			EC._loadEdCentre(F._getFormCity());
		F._setFormRecipient(EC._getEdCentreRegionalcontact());
		F._sendDiscontinueForm();
		showSent(F);
	}
	else
	{
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		showDiscontinuationForm(strmsg, F);
	}
}



/*
 *
 */
function sendLeaveForm() {
	var F = new Form();

		F._setFormRegion(new String(Request("region")));
		F._setFormCity(new String(Request("city")));
		F._setFormStudent(new String(Request("student")));

		F._setFormDate(GBLMakeDate(Request("fDay"),Request("fMonth"),Request("fYear"), null, null, null));

		F._setFormClasscode(new String(Request("classcode")));
		F._setFormBooklevel(new String(Request("booklevel")));
		F._setFormTeachercode(new String(Request("teachercode")));

		F._setFormLengthabsence(new String(Request("lengthabsense")));
		F._setFormDatediscontinue(GBLMakeDate(Request("diDay"),Request("diMonth"),Request("diYear"), null, null, null));
		F._setFormDaterecommence(GBLMakeDate(Request("cDay"),Request("cMonth"),Request("cYear"), null, null, null));

		F._setFormComments(new String(Request("comments")));
		F._setFormRejoin(new String(Request("rejoin")));


	var strvalid = validateForm(F);
	if (strvalid.length == 0) {
		// showTransferForm("Checks out okay...", F);
		F._sendLeaveForm();
		showSent(F);
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		showLeaveForm(strmsg, F);
	}
}

/*
 *
 */
function sendMakeupForm() {
	var F = new Form();

		F._setFormRegion(new String(Request("region")));
		F._setFormCity(new String(Request("city")));
		F._setFormStudent(new String(Request("student")));

		F._setFormDate(GBLMakeDate(Request("fDay"),Request("fMonth"),Request("fYear"), null, null, null));

		F._setFormClasscode(new String(Request("classcode")));
		F._setFormBooklevel(new String(Request("booklevel")));
		F._setFormTeachercode(new String(Request("teachercode")));

		F._setFormNewclasscode(new String(Request("newclasscode")));
		F._setFormNewbooklevel(new String(Request("newbooklevel")));
		F._setFormNewteachercode(new String(Request("newteachercode")));
		F._setFormNewregion(new String(Request("newregion")));

		F._setFormDatemissed(GBLMakeDate(Request("cDay"),Request("cMonth"),Request("cYear"), null, null, null));
		F._setFormDatemakeup(GBLMakeDate(Request("mDay"),Request("mMonth"),Request("mYear"), null, null, null));

		F._setFormComments(new String(Request("comments")));


	var strvalid = validateForm(F);
	if (strvalid.length == 0) {
		// showTransferForm("Checks out okay...", F);
		F._sendMakeupForm();
		showSent(F);
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		showMakeupForm(strmsg, F);
	}
}

/*
 *
 */
function sendEnquiryForm() {

	var F = new Form();

		F._setFormRegion(new String(Request("region")));
		F._setFormCity(new String(Request("city")));
		F._setFormStudent(new String(Request("student")));

		F._setFormStudentmumsname(new String(Request("studentmumsname")));
		F._setFormStudentdadsname(new String(Request("studentdadsname")));
		F._setFormStudentaddress(new String(Request("studentaddress")));
		F._setFormStudenthomephone(new String(Request("studenthomephone")));
		F._setFormStudentworkphone(new String(Request("studentworkphone")));
		F._setFormStudentmobilephone(new String(Request("studentmobilephone")));
		F._setFormStudentemail(new String(Request("studentemail")));
		F._setFormStudentenquiry(new String(Request("studentenquiry")));
		F._setFormStudentcourse(new String(Request("studentcourse")));
		F._setFormStudentday(new String(Request("studentday")));
		F._setFormStudenttime(new String(Request("studenttime")));
		F._setFormStudentlocation(new String(Request("studentlocation")));
		F._setFormStudentenquiry(new String(Request("enquiry")));

		F._setFormDate(GBLMakeDate(Request("fDay"),Request("fMonth"),Request("fYear"), null, null, null));
		F._setFormStudentdateofbirth(GBLMakeDate(Request("dDay"),Request("dMonth"),Request("dYear"), null, null, null));

		F._setFormComments(new String(Request("comments")));

	var strvalid = validateForm(F);
	if (strvalid.length == 0) {
		// showTransferForm("Checks out okay...", F);
		F._sendEnquiryForm();
		showSent(F);
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		showEnquiryForm(strmsg, F);
	}
}

/*
 *
 */
function sendAbsenceForm() {

	var strmsg = new String();
	var F = new Form();
	var arrAC = new Array();


		F._setFormCity(new String(Request("city")));
		//F._setFormRecipient(arrLocEmails[new Number(Request("location"))]);

		F._setFormDate(GBLMakeDate(Request("fDay"),Request("fMonth"),Request("fYear"), null, null, null));
		F._setFormTeachercode(new String(Request("teachercode")));
		F._setFormDatecommence(GBLMakeDate(Request("cDay"),Request("cMonth"),Request("cYear"), null, null, null));
		F._setFormDaterecommence(GBLMakeDate(Request("rcDay"),Request("rcMonth"),Request("rcYear"), null, null, null));
		F._setFormReasons(new String(Request("reasons")));

	var arrAbs = new String(Request("absent")).split(", ");

	for (var i=0; i < arrAbs.length; i++) {

		if (new String(Request("classcode_" + i ).length > 0) && new String(Request("teachercode_" + i )).length > 0) {
			var tmpAC = new AbsentClass();
				tmpAC.datescheduled = new Date(Date.parse(GBLMakeDate(Request("cDay_" + i),Request("cMonth_" + i),Request("cYear_" + i), Request("cHour_" + i), Request("cMinute_" + i), null)));
				tmpAC.classcode = new String(Request("classcode_" + i ));
				tmpAC.teachercode = new String(Request("teachercode_" + i ));
				tmpAC.comment = new String(Request("comments_" + i ));

			arrAC.push(tmpAC);
		}

	}

		//F._setFormComments(new String(Request("comments")));

	if (action == SEND_ABSENCE) {

		var strvalid = validateForm(F);
		if (strvalid.length == 0) {
			// showTransferForm("Checks out okay...", F);
			var EC = new EdCentre();
				EC._loadEdCentre(F._getFormCity());
			F._setFormCity(EC._getEdCentreState() + " - " + EC._getEdCentreName());
			F._setFormRecipient(EC._getEdCentreRegionalcontact());
			F._sendAbsenceForm(arrAC);
			showSent(F);
		} else {
			strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
			showAbsenceForm(strmsg, F, arrAC);
		}

	} else if (action == ADD_CLASS) {

		arrAC.push(new AbsentClass(new Date(), new String(), 0, new String()));
		showAbsenceForm(strmsg, F, arrAC);

	}
}

/*
 *
 */
function showSent(F) {

	%><!--#include file="../src/html/teacherFormsSent.asp"--><%
}


/*
 *
 */
function validateForm(F) {
	strErr = new String();
	if (F._getFormRegion() && (F._getFormRegion().length == 0 || F._getFormRegion().indexOf("undefined") == 0)) {
		strErr += " - You must indicate your region<br/>";
	}
	if (F._getFormCity() && (F._getFormCity().length == 0 || F._getFormCity().indexOf("undefined") == 0)) {
		strErr += " - You must indicate your city<br/>";
	}
	if (F._getFormStudent() && (F._getFormStudent().length == 0 || F._getFormStudent().indexOf("undefined") == 0)) {
		strErr += " - You must provide a student name<br/>";
	}
	if (F._getFormClasscode() && (F._getFormClasscode().length == 0 || F._getFormClasscode().indexOf("undefined") == 0)) {
		strErr += " - You must indicate current class code<br/>";
	}
	if (F._getFormBooklevel() && (F._getFormBooklevel().length == 0 || F._getFormBooklevel().indexOf("undefined") == 0)) {
		strErr += " - You must indicate current book level<br/>";
	}
	if (F._getFormTeachercode() && (F._getFormTeachercode().length == 0 || F._getFormTeachercode().indexOf("undefined") == 0)) {
		strErr += " - You must indicate current teacher code<br/>";
	}
	if (F._getFormNewclasscode() && (F._getFormNewclasscode().length == 0 || F._getFormNewclasscode().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the changed class code<br/>";
	}
	if (F._getFormNewbooklevel() && (F._getFormNewbooklevel().length == 0 || F._getFormNewbooklevel().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the changed book level<br/>";
	}
	if (F._getFormNewteachercode() && (F._getFormNewteachercode().length == 0 || F._getFormNewteachercode().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the changed teacher code<br/>";
	}
	if (F._getFormNewregion() && (F._getFormNewregion().length == 0 || F._getFormNewregion().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the new region<br/>";
	}
	if (F._getFormComments() && (F._getFormComments().length == 0 || F._getFormComments().indexOf("undefined") == 0)) {
		strErr += " - You must provide some comment<br/>";
	}
	if (F._getFormRejoin() && (F._getFormRejoin().length == 0 || F._getFormRejoin().indexOf("undefined") == 0)) {
		strErr += " - You must indicate if there is potential to rejoin the class<br/>";
	}
	if (F._getFormReasons() && (F._getFormReasons().length == 0 || F._getFormReasons().indexOf("undefined") == 0)) {
		strErr += " - You must provide the reasons for the absence<br/>";
	}

	if (F._getFormInformedoffee() && (F._getFormInformedoffee().length == 0 || F._getFormInformedoffee().indexOf("undefined") == 0)) {
		strErr += " - You must indicate whether or not this person was informed of the 25% discontinuation fee<br/>";
	}
	if (F._getFormLessonsattended() && (F._getFormLessonsattended().length == 0 || F._getFormLessonsattended().indexOf("undefined") == 0)) {
		strErr += " - You must indicate how many lessons were attended by this student<br/>";
	}
	if (F._getFormBookstaken() && (F._getFormBookstaken().length == 0 || F._getFormBookstaken().indexOf("undefined") == 0)) {
		strErr += " - You must indicate whether or not any books were taken<br/>";
	}
	if (F._getFormWhyfeewaived() && (F._getFormWhyfeewaived().length == 0 || F._getFormWhyfeewaived().indexOf("undefined") == 0)) {
		strErr += " - You must explain why the discontinuation fee was waived<br/>";
	}

	if (F._getFormLengthabsence() && (F._getFormLengthabsence().length == 0 || F._getFormLengthabsence().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the length of absence<br/>";
	}
	if (F._getFormStudentparentname() && (F._getFormStudentparentname().length == 0 || F._getFormStudentparentname().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the parent names<br/>";
	}
	if (F._getFormStudentmumsname() && (F._getFormStudentmumsname().length == 0 || F._getFormStudentmumsname().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the students mothers name<br/>";
	}
	if (F._getFormStudentdadsname() && (F._getFormStudentdadsname().length == 0 || F._getFormStudentdadsname().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the students fathers name<br/>";
	}
	if (F._getFormStudentaddress() && (F._getFormStudentaddress().length == 0 || F._getFormStudentaddress().indexOf("undefined") == 0)) {
		strErr += " - You must provide the students address<br/>";
	}
	if (F._getFormStudenthomephone() && (F._getFormStudenthomephone().length == 0 || F._getFormStudenthomephone().indexOf("undefined") == 0)) {
		strErr += " - You must provide a home contact number<br/>";
	}
	if (F._getFormStudentworkphone() && (F._getFormStudentworkphone().length == 0 || F._getFormStudentworkphone().indexOf("undefined") == 0)) {
		strErr += " - You must provide a work contact number<br/>";
	}
	if (F._getFormStudentmobilephone() && (F._getFormStudentmobilephone().length == 0 || F._getFormStudentmobilephone().indexOf("undefined") == 0)) {
		strErr += " - You must provide a mobile contact number<br/>";
	}
	if (F._getFormStudentemail() && (F._getFormStudentemail().length == 0 || F._getFormStudentemail().indexOf("undefined") == 0)) {
		strErr += " - You must provide the email address<br/>";
	}
	if (F._getFormStudentenquiry() && (F._getFormStudentenquiry().length == 0 || F._getFormStudentenquiry().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the nature of the enquiry<br/>";
	}
	if (F._getFormStudentcourse() && (F._getFormStudentcourse().length == 0 || F._getFormStudentcourse().indexOf("undefined") == 0)) {
		strErr += " - You must provide the course this student is enquiring about<br/>";
	}
	if (F._getFormStudentday() && (F._getFormStudentday().length == 0 || F._getFormStudentday().indexOf("undefined") == 0)) {
		strErr += " - You must show whether or not a student has a preferred day<br/>";
	}
	if (F._getFormStudenttime() && (F._getFormStudenttime().length == 0 || F._getFormStudenttime().indexOf("undefined") == 0)) {
		strErr += " - You must show whether or not a student has a preferred time<br/>";
	}
	if (F._getFormStudentlocation() && (F._getFormStudentlocation().length == 0 || F._getFormStudentlocation().indexOf("undefined") == 0)) {
		strErr += " - You must indicate which location this student will be attending<br/>";
	}
	if (F._getFormStudentenquiry() && (F._getFormStudentenquiry().length == 0 || F._getFormStudentenquiry().indexOf("undefined") == 0)) {
		strErr += " - You must indicate the nature of the enquiry<br/>";
	}

	//this._getFormDate = _getFormDate;

/*
	if (new Number(Request("dobDay")) == 0 || new Number(Request("dobMonth")) == 0 || new Number(Request("dobYear")) == 0) {
		strErr += " - Please check your date of birth - you must fill in all the fields<br/>";
	}
	if (!GBLValidateDate(new Number(Request("dobYear")), new Number(Request("dobMonth")), new Number(Request("dobDay")))) {
		strErr += " - Please check your date of birth - your date isn't right<br/>";
	}
*/

	return strErr;
}


%>


