<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/EdCentre.asp" -->
<!--#include file="../src/classes/Lead.asp" -->
<!--#include file="../src/classes/Student.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var ENQUIRY_HOME = "enquiry_home";
var ENQUIRY_CHOOSE = "enquiry_choose";
var ENQUIRY_COURSE = "enquiry_course";
var ENQUIRY_FMD = "enquiry_fmd";
var ENQUIRY_FMD_SEARCH = "enquiry_fmd_search";
var ENQUIRY_CUSTOMER_LOGIN = "enquiry_login";
var ENQUIRY_CUSTOMER = "enquiry_customer";
var ENQUIRY_CUSTOMER_SAVE = "enquiry_customer_save";
var ENQUIRY_CUSTOMER_DONE = "enquiry_customer_done";
var ENQUIRY_STUDENT = "enquiry_student";
var ENQUIRY_STUDENT_SAVE = "enquiry_student_save";
var ENQUIRY_PREFERRED = "enquiry_preferred";
var ENQUIRY_PREFERRED_SAVE = "enquiry_preferred_save";
var ENQUIRY_THANKS = "enquiry_thanks";
var ENQUIRY_FAQ = "enquiry_faq";

// global variables & default values
var CONTROLLER = "enquiry.asp";
var action = ENQUIRY_HOME;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}


// state machine
if (action == ENQUIRY_HOME) {

	showEnquiryHome();

} else if (action == ENQUIRY_CHOOSE) {
 
	enquiryChoose();

} else if (action == ENQUIRY_COURSE) {

	enquiryCourse();

} else if (action == ENQUIRY_FMD) {

	enquiryFMD('');

} else if (action == ENQUIRY_FMD_SEARCH) {

	enquiryFMDSearch();

} else if (action == ENQUIRY_CUSTOMER) {

	enquiryCustomer('', null);

} else if (action == ENQUIRY_CUSTOMER_LOGIN) {

	authenticateUser();

} else if (action == ENQUIRY_CUSTOMER_SAVE) {

	saveCustomer();

} else if (action == ENQUIRY_CUSTOMER_DONE) {

	enquiryCustomerDone();

} else if (action == ENQUIRY_STUDENT) {

	enquiryStudent('', null);

} else if (action == ENQUIRY_STUDENT_SAVE) {

	saveStudent();

} else if (action == ENQUIRY_PREFERRED) {

	enquiryPreferred();

} else if (action == ENQUIRY_PREFERRED_SAVE) {

	savePreferred();

} else if (action == ENQUIRY_THANKS) {

	enquiryThanks();

} else if (action == ENQUIRY_FAQ) {

	enquiryFAQ();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();


/*	*/
function showEnquiryHome() {

	%><!--#include file="../src/html/ymecEnquiryHome.asp"--><%
}

/*	*/
function enquiryChoose() {

	%><!--#include file="../src/html/ymecEnquiryChoose.asp"--><%
}

/*	*/
function enquiryCourse() {

	var strCourse = new String(Request("course"));

	if (strCourse.indexOf("one") == 0 || strCourse.indexOf("undefined") == 0) {
		%><!--#include file="../src/html/ymecEnquiryCourse1.asp"--><%
	} else if (strCourse.indexOf("two") == 0) {
		%><!--#include file="../src/html/ymecEnquiryCourse2.asp"--><%
	} else if (strCourse.indexOf("three") == 0) {
		%><!--#include file="../src/html/ymecEnquiryCourse3.asp"--><%
	} else if (strCourse.indexOf("four") == 0) {
		%><!--#include file="../src/html/ymecEnquiryCourse4.asp"--><%
	}
}

/*	*/
function enquiryFMD(message) {

	%><!--#include file="../src/html/ymecEnquiryFMD.asp"--><%
}


/*	*/
function enquiryFMDSearch(message) {

	var strPostcode = new String(Request("postcode"));
	var strSessionID = new String(Session.SessionID);
	
	if (strPostcode.length != 0 && strPostcode.indexOf("undefined") != 0)  {

		var L = new Lead();
			L._setLeadCustomerID(0);
			L._setLeadPostcode(strPostcode);
			L._setLeadSessionID(strSessionID);
			L._addLead();

		var EC = new EdCentre();
		var rsEdCentres = EC._centreSearch(strPostcode);

		%><!--#include file="../src/html/ymecEnquiryFMDResults.asp"--><%
		
	} else {
		enquiryFMD("You need to provide your postcode so we can determine whether or not an education centre is nearby.");
	}
}


/*	*/
function enquiryCustomer(message, objC) {

	var C = null;
	if (objC) {
		C = objC;
	} else {
		C = new Customer();
		if (new Number(Session("yma_customerid")) > 0) {
			C._loadCustomer(Session("yma_customerid"));
		}
	}

	%><!--#include file="../src/html/ymecEnquiryCustomer.asp"--><%
}


/*	*/
function enquiryCustomerDone() {

	%><!--#include file="../src/html/ymecEnquiryCustomerDone.asp"--><%
}


/*	*/
function enquiryStudent(message, objS) {

	if (!Session("yma_customerid")) {
		endProcess();
	}

	var intCustomerID = Session("yma_customerid");
	var S = null;
	if (objS) {
		S = objS;
	} else {
		S = new Student();
	}
	var rsStudents = S._getAllStudentsByCustomer(intCustomerID);

	%><!--#include file="../src/html/ymecEnquiryStudent.asp"--><%
}


/*
 *	
 */
function saveStudent() {

	var strmsg = new String();

	var S = new Student();
		S._setStudentCustomerID(new Number(Request("customerid")));
		S._setStudentName(cleanForSQL(new String(Request("name"))));
		S._setStudentSchoolLevel(cleanForSQL(new String(Request("schoollevel"))));
		S._setStudentPrevEdu(cleanForSQL(new String(Request("prevedu"))));
		S._setStudentDateofbirth(GBLMakeDate(Request("dobDay"),Request("dobMonth"),Request("dobYear"), null, null, null));

	var strvalid = validateStudent(S);

	if (strvalid.length == 0) {

		var intStudentID = S._addStudent();
		endProcessPlus("action=" + ENQUIRY_STUDENT);

	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		enquiryStudent(strmsg, S);
	}
}

/*	*/
function enquiryPreferred() {

	%><!--#include file="../src/html/ymecEnquiryPreferredContact.asp"--><%
}

/*	*/
function savePreferred() {

	var strContact = new String(Request("contact")).indexOf("undefined")==0?"none":new String(Request("contact"));
	var strSessionID = new String(Session.SessionID);

	var L = new Lead();
		L._loadLeadBySessionID(strSessionID);

	if (L._getLeadID() != 0) {
		L._setLeadPreferred(strContact);
		L._saveLeadPreferred();
	}


	var intCustomerID = L._getLeadCustomerID();
	if (intCustomerID > 0) {

		var C = new Customer();

		var rsStudents = null;
		var S = new Student();
		rsStudents = S._getAllStudentsByCustomer(intCustomerID);
		var strStudents = new String();

		if (rsStudents && !rsStudents.EOF) {
			while (!rsStudents.EOF) {
				
				strStudents += rsStudents("name") + "\n" + 
							  "DoB : " + new Date(Date.parse(rsStudents("dateofbirth"))).formatDate("d/m/Y") + "\n" +
							  "School Level : " + rsStudents("schoollevel") + "\n" +
							  "Previous Education : " + rsStudents("prevedu") + "\n\n";
					
				rsStudents.MoveNext();
			}
		}

		C._loadCustomer(intCustomerID);

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "au_ymec@gmx.yamaha.com";
				JMail.Subject = "Yamaha Music Education Centre : Confirm Enquiry";
				JMail.AddRecipient(C._getCustomerEmail());

				JMail.Body = "Hi " + C._getCustomerFirstname() +",\n" +
							 "Thank you for your enquiry regarding music education courses at Yamaha.\n" +
							 "\n" +
							 "We're delighted that you're interested in the courses at our Yamaha Music Education Centres. This email is a confirmation of your enquiry.\n" +
							 "\n" +
							 "At this very moment your enquiry is also being forwarded to our music education team and they will respond to your enquiry as soon as possible.\n" +
							 "\n" +
							 "Here are the details that you have provided:\n" +
							 "\n" +
							 C._getCustomerTitle() + " " + C._getCustomerFirstname() + " " + C._getCustomerLastname() + "\n" +
							 C._getCustomerAddress() + "\n" +
							 C._getCustomerCity() + " " + C._getCustomerState() + " " + C._getCustomerPostcode() + "\n" +
							 "p : " + C._getCustomerPhone() + "\n" +
							 "e : " + C._getCustomerEmail() + "\n" +
							 "\n" +
							 "Your preferred method of contact is : " + L._getLeadPreferred() + "\n" +
							 "\n" +
							 (strStudents.length>0?"You have registered the following students : \n" + strStudents:"") + 
							 "\n" +
							 "Regards,\n" +
							 "Yamaha Music Education Centre\n" +
							 "\n" +
							 "w : www.yamahamusic.com.au\n" +
							 "e : au_ymec@gmx.yamaha.com\n" +
							 "p : 1800 805 413" + GBL_PRIVACY_STATEMENT;
				JMail.Execute();
		} catch(e) {
			Response.Write("Attempted Send : " + e.description + "<br/>");
			Response.Flush();
		}

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "au_webmaster@gmx.yamaha.com";
				JMail.Subject = "YMEC : New Enquiry";
				// JMail.AddRecipient("au_ymec@gmx.yamaha.com");
				JMail.AddRecipient("travis_winters@gmx.yamaha.com");

				JMail.Body = "Hi There,\n" +
							 "A new enquiry has been lodged via the yamahamusic.com.au website, please respond to this customer as soon as you are able using their preferred method of contact.\n" +
							 "\n" +
							 "Here are the details that they have sent us:\n" +
							 "\n" +
							 C._getCustomerTitle() + " " + C._getCustomerFirstname() + " " + C._getCustomerLastname() + "\n" +
							 C._getCustomerAddress() + "\n" +
							 C._getCustomerCity() + " " + C._getCustomerState() + " " + C._getCustomerPostcode() + "\n" +
							 "p : " + C._getCustomerPhone() + "\n" +
							 "e : " + C._getCustomerEmail() + "\n" +
							 "\n" +
							 "Their preferred method of contact is : " + L._getLeadPreferred() + "\n" +
							 "\n" +
							 (strStudents.length>0?"They have registered the following students : \n" + strStudents:"") + 
							 "\n" +
							 "Regards,\n" +
							 "Yamaha Music Australia\n" +
							 "\n" +
							 "w : www.yamahamusic.com.au\n" +
							 "e : au_ymec@gmx.yamaha.com\n" +
							 "p : 1800 805 413";
				JMail.Execute();
		} catch(e) {
			Response.Write("Attempted Send : " + e.description + "<br/>");
			Response.Flush();
		}

	}




	endProcessPlus("action=" + ENQUIRY_THANKS);

}


/*	*/
function enquiryThanks() {

	%><!--#include file="../src/html/ymecEnquiryThanks.asp"--><%
}


/*	*/
function enquiryFAQ() {

	%><!--#include file="../src/html/ymecEnquiryFAQ.asp"--><%
}




/*  
 *	
 */ 
function authenticateUser() {

	var strmsg = new String();


	var C = new Customer();
		C._setCustomerEmail(cleanForSQL(new String(Request("email"))));
		C._setCustomerPassword(cleanForSQL(new String(Request("password"))));

	var customerid = C._authenticateCustomer();

	if (customerid > 0) {
		// timeout in four hours
		Session.Timeout = 240; 
		Session("yma_customerid") = customerid;
		C._loadCustomer(customerid);
		C._recordLogin();
		
		var L = new Lead();
			L._loadLeadBySessionID(Session.SessionID);
			
		if (L._getLeadID() != 0) {
			L._setLeadCustomerID(customerid)
			L._saveLead();
		}
		//Response.Redirect(Request.ServerVariables("HTTP_REFERER"));
		endProcessPlus("action=" + ENQUIRY_STUDENT);

	} else {
		strmsg = "Your login failed, please check your details and try again."
		enquiryCustomer(strmsg, C);
	}

}


/*
 *	
 */
function saveCustomer() {

	var intmsg = 0;
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
		C._setCustomerPostcode(cleanForSQL(new String(Request("postcode"))));
		C._setCustomerPhone(cleanForSQL(new String(Request("phone"))));
		C._setCustomerEmail(cleanForSQL(new String(Request("email"))));
		C._setCustomerPassword(cleanForSQL(new String(Request("password"))));
		C._setCustomerOptinnews(new Number(Request("optinnews"))==1?1:0);
		C._setCustomerOptinproduct(new Number(Request("optinproduct"))==1?1:0);
		C._setCustomerDateofbirth(GBLMakeDate(Request("dobDay"),Request("dobMonth"),Request("dobYear"), null, null, null));

	var strvalid = validateCustomer(C);

	if (strvalid.length == 0) {

		if (C._getCustomerID() > 0) {
			C._saveCustomer();
			intmsg = 1;
		} else {
			var intCustomerID = C._addCustomer();
			
			/*
				At this point do we want to email a confirmation
				notice to this persons inbox?
				
				Do we want to allow them to set their own password
				at first? - or set one for their initial login and then they
				can login after that?
				
				Initial password can be sent to their nominated
				email address, just to make sure that they're not 
				setting up a bogus account.
			
			
			*/
			
			
			var L = new Lead();
				L._loadLeadBySessionID(Session.SessionID);

			if (L._getLeadID() != 0) {
				L._setLeadCustomerID(intCustomerID)
				L._saveLead();
			}
			Session.Timeout = 240; 
			Session("yma_customerid") = intCustomerID;
			intmsg = 2;
		}

		endProcessPlus("action=" + ENQUIRY_CUSTOMER_DONE);

	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		enquiryCustomer(strmsg, C);
	}
}




/*
 *	
 */
function validateCustomer(C) {
	strErr = new String();
	if (C._getCustomerFirstname().length == 0 || C._getCustomerFirstname().indexOf("undefined") == 0) {
		strErr += " - You must provide a customer firstname<br>";	
	}	
	if (C._getCustomerLastname().length == 0 || C._getCustomerLastname().indexOf("undefined") == 0) {
		strErr += " - You must provide a customer surname<br>";	
	}	
	if (C._getCustomerEmail().length == 0 || C._getCustomerEmail().indexOf("undefined") == 0) {
		strErr += " - You must provide a customer email address<br>";	
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
	if (C._getCustomerPassword().length == 0 || C._getCustomerPassword().indexOf("undefined") == 0) {
		strErr += " - You must set a password<br>";	
	}	
	if (C._getCustomerPassword().length < 4) {
		strErr += " - Your password must be at least four characters long.<br>";	
	}	
	
	return strErr;
}


/*
 *	
 */
function validateStudent(S) {
	strErr = new String();
	if (S._getStudentName().length == 0 || S._getStudentName().indexOf("undefined") == 0) {
		strErr += " - You must provide a student name<br>";	
	}	
	if (S._getStudentDateofbirth().length == 0 || S._getStudentDateofbirth().indexOf("undefined") == 0) {
		strErr += " - You must provide the students' date of birth<br>";	
	}	
	if (S._getStudentSchoolLevel().length == 0 || S._getStudentSchoolLevel().indexOf("undefined") == 0) {
		strErr += " - You must indicate the student school level.<br>";	
	}	
	
	return strErr;
}





%>


