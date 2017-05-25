<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Lead.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_LEADS = "list_leads";
var SET_FOLLOWUP = "save_followup";
var EDIT_CUSTOMER = "edit_customer";

// global variables & default values
var CONTROLLER = "ctrlLead.asp";
var action = LIST_LEADS;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}




// state machine
if (action == LIST_LEADS) {

	listLeads();

} else if (action == SET_FOLLOWUP) {

	setFollowup();
	endProcess();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *	
 */
function listLeads() {

	var L = new Lead();
	var C = new Customer();
	var d = new Date();
	var year = d.getFullYear();
	if (new String(Request("year")).indexOf("undefined") != 0 && !isNaN(parseInt(Request("year")))) {
		year = parseInt(Request("year"));
	}

	var rsAllCustomers = C._getAllCustomersAsLeads(year);
	
	%><!--#include file="../src/html/admin/leadList.asp"--><%
}


/*
 *	
 */
function setFollowup() {

	var arrCustomerID = new Array();
	var strCustomerID = new String(Request("customerid"));
	if (strCustomerID.indexOf("undefined") != 0) {
		var C = new Customer();
		arrCustomerID = strCustomerID.split(", ");
		for (var i=0; i < arrCustomerID.length; i++) {
			var intFollowedUp = !isNaN(new Number(Request("followup_" + arrCustomerID[i])))?1:0;
			if (intFollowedUp > 0) {
				C._setCustomerID(arrCustomerID[i]);
				C._recordFollowup();
			}
		}
	}

}

















function getWeekNr() {

	var today = new Date();
	Year = takeYear(today);
	Month = today.getMonth();
	Day = today.getDate();
	now = Date.UTC(Year,Month,Day+1,0,0,0);

	var Firstday = new Date();
		Firstday.setYear(Year);
		Firstday.setMonth(0);
		Firstday.setDate(1);
	then = Date.UTC(Year,0,1,0,0,0);
	var Compensation = Firstday.getDay();
		Compensation == (Compensation>3)?Compensation-=4:Compensation+=3;

	NumberOfWeek =  Math.round((((now-then)/86400000)+Compensation)/7);
	return NumberOfWeek;
}

function getDateFromWeek(week) {
	
	// we have to assume it's in the current year
	var d = new Date()
	var today = new Date();
	var Year = takeYear(today);
	var Month = today.getMonth();
	var Day = today.getDate();
	var now = Date.UTC(Year,Month,Day+1,0,0,0);
	
	var Firstday = new Date();
		Firstday.setYear(Year);
		Firstday.setMonth(0);
		Firstday.setDate(1);

	var Compensation = Firstday.getDay();
		Compensation == (Compensation>3)?Compensation-=4:Compensation+=3;
	
	var first = Date.UTC(Year,0,1,0,0,0);
	
//Response.Write("first millsecond of the year = " + first + "<br/>");
//Response.Write("current millisecond (irrev) = " + now + "<br/>");

	var w = Math.abs(Math.round((((week*7)-Compensation)*86400000)));

//Response.Write("number of weeks in milliseconds = " + new Date((first+w)) + "<br/>");

	//NumberOfWeek =  Math.round((((now-then)/86400000)+Compensation)/7);

	var then = first+w;
		then = new Date(then).formatDate("j M Y");
		
	return then;

}

function takeYear(theDate)
{
	x = theDate.getYear();
	var y = x % 100;
	y += (y < 38) ? 2000 : 1900;
	return y;
}

%>


