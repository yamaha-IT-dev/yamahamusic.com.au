<%@LANGUAGE="JScript"%>
<% 
	Response.Buffer = true; 

%>
<!--#include file="src/global.asp" -->
<!--#include file="src/utility.asp" -->
<!--#include file="src/logincheck_customer.asp" -->
<!--#include file="src/classes/Customer.asp" -->
<!--#include file="src/classes/User.asp" -->
<!--#include file="src/classes/ProductCategory.asp" -->
<!--#include file="src/classes/Navigation.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var CUSTOMER_HOME = "customer_home";
var CUSTOMER_WELCOME = "customer_welcome";
var CUSTOMER_LOGIN = "customer_login";
var CUSTOMER_LOGOUT = "customer_logout";
var NEW_CUSTOMER = "new_customer";
var EDIT_CUSTOMER = "edit_customer";
var SAVE_CUSTOMER = "save_customer";
var SEND_PASSWORD = "send_password";

// global variables & default values
var CONTROLLER = "customer2.asp";
var action = CUSTOMER_HOME;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}


var intmsg = new Number(Request("intmsg"));
var strmsg = new String();
if (!isNaN(intmsg)) {
	var strmsg = intmsg==1?"<p style=\"color:green;\">Your details have been updated successfully.</p><p>Return to <a href=\"" + CONTROLLER + "\">Customer Home</a></p>":strmsg;
	var strmsg = intmsg==2?"<p style=\"color:green;font-size:1.2em;\">Thank you for registering. Your details have been saved successfully.</p>":strmsg;
}

// state machine
if (action == CUSTOMER_HOME) {

	showCustomerHome(strmsg, null);

} else if (action == CUSTOMER_WELCOME) {

	showCustomerWelcome(strmsg, null);

} else if (action == CUSTOMER_LOGIN) {

	authenticateCustomer();

} else if (action == CUSTOMER_LOGOUT) {

	customerLogout();

} else if (action == NEW_CUSTOMER) {

	newCustomer();

} else if (action == EDIT_CUSTOMER) { 

	editCustomer('', null);

} else if (action == SAVE_CUSTOMER) {

	saveCustomer();

} else if (action == SEND_PASSWORD) {

	sendPassword();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *	
 */
function showCustomerHome(message, objC) {

	var C = null;

	if (objC) {
		C = objC;
	} else {
		C = new Customer();
		if (new Number(Session("yma_customerid")) > 0) {
			C._loadCustomer(Session("yma_customerid"));
		}
	}
	var strreferrer = new String(Request.ServerVariables("HTTP_REFERER"));
	
	%><!--#include file="src/html/customerHome.asp"--><%
}


/*
 *	
 */
function showCustomerWelcome(message, objC) {

	var C = null;

	if (objC) {
		C = objC;
	} else {
		C = new Customer();
		if (new Number(Session("yma_customerid")) > 0) {
			C._loadCustomer(Session("yma_customerid"));
		}
	}
	
	var strreferrer = new String();
		
	%><!--#include file="src/html/customerWelcome.asp"--><%
}


function authenticateCustomer() {

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
		
		var strreferrer = new String(Request.ServerVariables("HTTP_REFERER"));
		
		%><!--#include file="src/html/customerHome.asp"--><%
		
		// Response.Redirect();
	} else {
		strmsg = "Your login failed, please check your details and try again."
		showCustomerHome(strmsg, C);
	}
}


function customerLogout() {

	Session("yma_customerid") = null;
	Session("yma_userid") = null;

	var strReferer = new String(Request.ServerVariables("HTTP_REFERER"));
	if (strReferer.length == 0 || strReferer.indexOf("undefined") == 0) {
		strReferer = "/home.asp";
	}
	//Response.Redirect(strReferer);

	%><!--#include file="src/html/customerGoodbye.asp"--><%

}


/*
 *	
 */
function newCustomer() {

	var message = new String();
	var C = new Customer();

	var strReturn = new String();
	if (new String(Request("return")).indexOf("true") == 0) {
		strReturn = Request.ServerVariables("HTTP_REFERER");
	}

	%><!--#include file="src/html/customerEdit2.asp"--><%
}



/*
 *	
 */
function editCustomer(message, objC) {

	
	var strReturn = new String();
	var intCustomerID = new Number(Session("yma_customerid"));

	var C = null;

	if (objC) {
		C = objC;
	} else {
		C = new Customer();
		if (!isNaN(intCustomerID)) {
			C._loadCustomer(intCustomerID);
		}
	}

	%><!--#include file="src/html/customerEdit.asp"--><%
}


/*
 *	
 */
function saveCustomer() {

	var intmsg = 0;
	var strmsg = new String();
	var intCustomerID = new Number(Request("customerid"));

	var strReturn = new String();
	if (new String(Request("return")).length != 0 && new String(Request("return")).indexOf("undefined") != 0) {
		strReturn = new String(Request("return"));
	}

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
		C._setCustomerOptinyaypc(new Number(Request("optinyaypc"))==1?1:0);
		C._setCustomerOptinteacher(new Number(Request("optinteacher"))==1?1:0);
		C._setCustomerDateofbirth(GBLMakeDate(Request("dobDay"),Request("dobMonth"),Request("dobYear"), null, null, null));

	var strvalid = validateCustomer(C);

	var arrProductID = new Array();
	if (new String(Request("productid")).indexOf("undefined") != 0) {
		arrProductID.push(new String(Request("productid")).split(","));
	}
	
	if (strvalid.length == 0) {

		if (C._getCustomerID() > 0) {
			C._saveCustomer();
			
			var U = new User();
				U._loadUserByCustomerID(C._getCustomerID());
			if (U._getUserID() > 0) {
				U._setUserPassword(cleanForSQL(new String(Request("password"))));
				U._saveUser();
			}
			
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
			
			Session.Timeout = 240; 
			Session("yma_customerid") = intCustomerID;
			intmsg = 2;
		}

		C._removeCustomerFromProduct(intCustomerID);
		C._addCustomerToProduct(intCustomerID, arrProductID);

		if (strReturn.length == 0) {
			if (intmsg == 2) {
				endProcessPlus("action=" + CUSTOMER_WELCOME + "&intmsg=" + intmsg);		
			} else {
				endProcessPlus("action=" + CUSTOMER_HOME + "&intmsg=" + intmsg);		
			}
		} else {
			Response.Redirect(strReturn);
		}

	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editCustomer(strmsg, C);
	}
}


function sendPassword() {

	var strMessage = new String();
	var strEmail = new String(Request("email"));
	var C = new Customer();
		C._setCustomerEmail(strEmail);
	var intCustomerID = C._emailExistsAlready(strEmail);
	
	if (intCustomerID > 0) {

		C._loadCustomer(intCustomerID);

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "au_webmaster@gmx.yamaha.com";
				JMail.Subject = "Yamaha Music : Forgotten something?";
				JMail.AddRecipient(C._getCustomerEmail());

				JMail.Body = "Hi " + C._getCustomerFirstname() +",\n" +
							 "Lost something? No problem we've found it.\n" +
							 "\n" +
							 "Here is your password : " + C._getCustomerPassword() + "\n" +
							 "\n" +
							 "Thanks for being part of our community.\n" +
							 "\n" +
							 "Regards,\n" +
							 "Yamaha Music Australia\n" +
							 "\n" +
							 "w : www.yamahamusic.com.au\n" +
							 "e : au_webmaster@gmx.yamaha.com\n" +
							 "p : 1800 805 413";
				JMail.Execute();
		} catch(e) {
			Response.Write("Attempted Send : " + e.description + "<br/>");
			Response.Flush();
		}
		strMessage = "Thanks, you're password is on it's way.";
		showCustomerHome(strMessage, null);
	} else {
		strMessage = "Sorry, we were unable to locate that email address in our database.";
		showCustomerHome(strMessage, null);
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
	if (C._getCustomerAddress().length > 500) {
		strErr += " - Your address should be less than 500 characters long.<br>";	
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
	if (new Number(Request("dobDay")) == 0 || new Number(Request("dobMonth")) == 0 || new Number(Request("dobYear")) == 0) {
		strErr += " - Please check your date of birth - you must fill in all the fields<br>";	
	}	
	if (!GBLValidateDate(new Number(Request("dobYear")), new Number(Request("dobMonth")), new Number(Request("dobDay")))) {
		strErr += " - Please check your date of birth - your date isn't right<br>";	
	}	
	if (C._getCustomerEmail().indexOf("@") < 1) {
		strErr += " - Please check the email address entered; it must be in the form name@domain.com<br>";	
	}	
	if (C._getCustomerPassword().length == 0 || C._getCustomerPassword().indexOf("undefined") == 0) {
		strErr += " - You must set a password<br>";	
	}	
	if (C._getCustomerPassword().length < 4) {
		strErr += " - Your password must be at least four characters long.<br>";	
	}	
	
	return strErr;
}


%>


