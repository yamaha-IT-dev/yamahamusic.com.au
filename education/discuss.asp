<%@LANGUAGE=JScript%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/Topic.asp" -->
<!--#include file="../src/classes/Group.asp" -->
<!--#include file="../src/classes/Discussion.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Profile.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var SHOW_TOPICS = "show_topics";
var SHOW_DISCUSSION = "show_discussion";
var READ_POST = "read_post";
var NEW_POST = "new_post";
var SAVE_POST = "save_post";
var NULLIFY_POST = "nullify_post";
var REPORT_ABUSE = "report_abuse";
var AUTHENTICATE_USER = "authenticate_user";

// global variables & default values
var CONTROLLER = "discuss.asp";
var action = SHOW_DISCUSSION;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}

var intUserID = Session("yma_userid");

if (Session("yma_userid")) {

	// state machine
	if (action == SHOW_TOPICS) {

		showTopics();

	} else if (action == SHOW_DISCUSSION) {

		showDiscussion();

	} else if (action == READ_POST) {

		readPost();

	} else if (action == NEW_POST) {

		newPost(new String(''), null);

	} else if (action == SAVE_POST) {

		savePost();

	} else if (action == NULLIFY_POST) {

		nullifyPost();

	} else if (action == AUTHENTICATE_USER) {

		authenticateUser();

	} else {
		// TODO Eroor page
		Response.Write("Unsupported action: " + action);
	}
} else {
	Response.Redirect("teachers.asp");
}


/*
 *	
 */
function showTopics() {
	var intUserID = Session("yma_userid");
	var D = new Discussion();
	var T = new Topic();

	var rsAllTopics = T._getAllTopic(true);


	if (!isNaN(intUserID) && intUserID != 0) {
		var U = new User();
			U._loadUser(intUserID);
		/* Check for rights to access this area. */
		if (U._getUserUsertypeID() != GBL_USERTYPE_TEACHER && U._getUserUsertypeID() != GBL_USERTYPE_ADMIN) {
			Response.Redirect("/notpermitted.asp");			
		}
	}		

	%><!--#include file="../src/html/discussionTopics.asp"--><%
}


/*
 *	
 */
function showDiscussion(message) {

	var intTopicID = 2; // SET TO DEFAULT TO TEACHER TOPICS 	//new Number(Request("topicid"));
	var intThreadID = 0;
	var originalMessage = new String();
	var message = new String();

	var intParentID = new Number(Request("parentid"));
	if (isNaN(intParentID)) {
		intParentID = 0;
	}

	var intUserID = Session("yma_userid");
	if (!isNaN(intUserID) && intUserID != 0) {
		var U = new User();
			U._loadUser(intUserID);
		/* Check for rights to access this area. */
		if (U._getUserUsertypeID() != GBL_USERTYPE_TEACHER && U._getUserUsertypeID() != GBL_USERTYPE_ADMIN) {
			Response.Redirect("/notpermitted.asp");			
		}
	}	
	
	var D = new Discussion();
	var T = new Topic();
	var U = new User();
	var P = new Profile();

	var arrDiscussion = D._getAllDiscussionByTopic(intTopicID);
	var depthcount = 1;
	
	%><!--#include file="../src/html/discussionThreadTeacher.asp"--><%
}


/*
 *	
 */
function newPost(message, obj) {
	var D = new Discussion();

	var originalMessage = new String();
	var intTopicID = new Number(Request("topicid"));
	var intThreadID = new Number(Request("threadid"));
	var intParentID = new Number(Request("parentid"));

	var intUserID = new Number(Request("userid"));;

	if (obj == null && intParentID != 0) {
		D._loadDiscussion(intParentID);
		if (D._getDiscussionSubject().indexOf("RE: ")) {
			D._setDiscussionSubject("RE: " + D._getDiscussionSubject());
		}
		originalMessage = D._getDiscussionMessage();
		D._setDiscussionMessage("");
	}
	
	if (obj) {
		D = obj;
	}
	
	%><!--#include file="../src/html/global/pageHeaderDiscussion.asp" --><%
	%><h1>Discussion Forums</h1><%
	%><!--#include file="../src/html/discussionForm.asp"--><%
	%><!--#include file="../src/html/global/pageFooter.asp" --><%
}




/*
 *	
 */
function savePost() {

	var intThreadID = new Number(Request("threadid"));
	var intParentID = new Number(Request("parentid"));
	var intTopicID = new Number(Request("topicid"));
	var intUserID = new Number(Request("userid"));

	var D = new Discussion();
	
		D._setDiscussionParentID(intParentID);
		D._setDiscussionTopicID(intTopicID);
		D._setDiscussionUserID(intUserID);
		D._setDiscussionUsernotify(new Number(Request("usernotify"))==1?1:0);
		D._setDiscussionStatus(1);
		D._setDiscussionSubject(cleanForSQL(new String(Request("subject"))));
		D._setDiscussionMessage(cleanForSQL(new String(Request("message"))));
		D._setDiscussionRemoteIP(cleanForSQL(new String(Request.ServerVariables("REMOTE_ADDR"))));

	var valid = validatePost(D);
	
	if (valid.length == 0) {

		intDiscussionID = D._addDiscussion();

/*
	Uncomment this code to activate moderation upon the
	Clavinova Club Website. The content of posts will be
	forwarded to the email accounts you nominate. These
	people will be able to 'nullify' inappropriate posts
	by replacing their content with a single click.

		strBody = "Hello Bread Discussion Board Moderator, \n" +
				  "Somone has posted some content to the bread discussion board.\n" +
				  "-------------------------------------------------------------\n" +
				  "Subject : " + D._getDiscussionSubject() + "\n\n" +
				  D._getDiscussionMessage() + "\n\n" +
				  "-------------------------------------------------------------\n" +
				  "\n\n" +
				  "Load the page below to nullify this post if you believe that the content is not appropriate for the Bread Website.\n" +
				  "<http://" + GBL_DOMAIN + "/community/discuss.asp?action=nullify_post&discussionid=" + intDiscussionID + ">\n\n";

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER; 
				JMail.Sender = "bread@bread.com.au";
				JMail.Subject = "Bread Discussion : Moderate Post";
				JMail.AddRecipient("sarah.macdonald@dare.com.au");
				JMail.AddRecipient("jay@2wc.com.au");
				//JMail.AddRecipient("travo@prozacblues.com");
				JMail.Body = strBody;
				JMail.Execute();
		} catch(e) {
			Response.Write("oops : " + e.description);
		}
		if (!e) {
*/

		if (intThreadID > 0) {	
			endProcessPlus('action=' + READ_POST + "&threadid=" + intThreadID + "&discussionid=" + intDiscussionID);
		} else {
			endProcessPlus('action=' + READ_POST + "&threadid=" + intDiscussionID + "&discussionid=" + intDiscussionID);
		}
//		}
	} else {
		newPost(valid, D);
	}
}


/*
 *	
 */
function readPost() {

	var intThreadID = new Number(Request("threadid"));
	var intDiscussionID = new Number(Request("discussionid"));
	var intUserID = Session("yma_userid");
	var originalMessage = new String();
	var message = new String();

	var T = new Topic()
	var U = new User();
	var P = new Profile();
	var D = new Discussion();
		D._loadDiscussion(intDiscussionID);	

	var arrDiscussion = D._getAllDiscussionByParent(D._getDiscussionID());
	var intTopicID = D._getDiscussionTopicID();
	var intParentID = D._getDiscussionID();

	%><!--#include file="../src/html/discussionPost.asp"--><%

}


/*
 *	
 */
function nullifyPost() {
	var intDiscussionID = new Number(Request("discussionid"));
	var d = new Date();
	var strd = d.getYear() + ((d.getMonth()+1)<=9?"0"+(d.getMonth()+1):(d.getMonth()+1)) + (d.getDate()<=9?"0"+d.getDate():d.getDate()) + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()

	if (!isNaN(intDiscussionID)) {

		var D = new Discussion();
			D._loadDiscussion(intDiscussionID);	
			D._setDiscussionSubject("");
			D._setDiscussionMessage("The contents of this post have been suppressed as they were deemed inappropriate for the Bread Community.");
			D._setDiscussionDate(strd);
			D._saveDiscussion();
	}
	Response.Write("Post has been successfuly moderated");
}

/*
 *	
 */
function deleteDiscussion() {
	var D = new Discussion();
		D._setDiscussionID(Request("discussionid"));
		D._deleteDiscussion();
}



function validatePost(D) {
	var strMessage = new String();

	if (D._getDiscussionSubject() == '' || D._getDiscussionSubject() == "undefined") {
		strMessage += "You must enter a valid subject.<br>";	
	}
	if (D._getDiscussionMessage() == '' || D._getDiscussionMessage() == "undefined") {
		strMessage += "Your message cannot be blank.<br>";	
	}

	if (badLanguage(D._getDiscussionSubject()) || badLanguage(D._getDiscussionMessage())) {
		strMessage += "It's great that you consider yourself an interesting and colourful person but please don't use unacceptable language in our discussion forums. Review your post to make sure that it doesn't contain any rude words.<br>";
	}



	if (strMessage.length > 0) {
		strMessage = "Please check the following details and try again<br>" + strMessage;
	}
	return strMessage;
}


function userLogin(message, obj) {
	var intUserID = new Number(Session("yma_userid"));
	var U = null;

	if (obj) {
		U = obj;
	} else {
		U = new User();
	}
	%><!--#include file="../src/html/discussionLogin.asp"--><%
}


/*  
 *	
 */ 
function authenticateUser() {

	var strmsg = new String();
	var strReferrer = new String(Request("referrer"));

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
		Response.Redirect(strReferrer);
	} else {
		strmsg = "Your login failed, please check your details and try again."
		userLogin(strmsg, U);
	}

}





%>
