<%

function Enrolment() {

	this.id = null;
	this.timetableid = null;
	this.promocode = null;
	this.studentname = null;
	this.studentgender = "boy";
	this.studentgrade = null;
	this.studentdateofbirth = null;
	this.studentaddress = null;
	this.studentsuburb = null;
	this.studentstate = new String();
	this.studentpostcode = null;
	this.parenttitle1 = new String();
	this.parentname1 = null;
	this.parenttitle2 = new String();
	this.parentname2 = null;
	this.guardian = null;
	this.phone = null;
	this.mobile = null;
	this.email = null;
	this.backpack = null;
	this.preferredtime = null;
	this.comments = null;
	this.findout = new String();

	this.mailbody = new String('');

	this._getEnrolmentID 					= function() { return this.id; }
	this._getEnrolmentTimetableID 			= function() { return this.timetableid; }
	this._getEnrolmentPromocode 			= function() { return this.promocode; }
	this._getEnrolmentStudentname 			= function() { return this.studentname; }
	this._getEnrolmentStudentgender 		= function() { return this.studentgender; }
	this._getEnrolmentStudentgrade 			= function() { return this.studentgrade; }
	this._getEnrolmentStudentdateofbirth 	= function() { return this.studentdateofbirth; }
	this._getEnrolmentStudentaddress 		= function() { return this.studentaddress; }
	this._getEnrolmentStudentsuburb 		= function() { return this.studentsuburb; }
	this._getEnrolmentStudentstate 			= function() { return this.studentstate; }
	this._getEnrolmentStudentpostcode 		= function() { return this.studentpostcode; }
	this._getEnrolmentParenttitle1 			= function() { return this.parenttitle1; }
	this._getEnrolmentParentname1 			= function() { return this.parentname1; }
	this._getEnrolmentParenttitle2 			= function() { return this.parenttitle2; }
	this._getEnrolmentParentname2 			= function() { return this.parentname2; }
	this._getEnrolmentGuardian 				= function() { return this.guardian; }
	this._getEnrolmentPhone 				= function() { return this.phone; }
	this._getEnrolmentMobile 				= function() { return this.mobile; }
	this._getEnrolmentEmail 				= function() { return this.email; }
	this._getEnrolmentBackpack 				= function() { return this.backpack; }
	this._getEnrolmentPreferredtime 		= function() { return this.preferredtime; }
	this._getEnrolmentComments 				= function() { return this.comments; }
	this._getEnrolmentFindout 				= function() { return this.findout; }

	this._setEnrolmentID 					= function(value) { this.id = value; }
	this._setEnrolmentTimetableID 			= function(value) { this.timetableid = value; }
	this._setEnrolmentPromocode 			= function(value) { this.promocode = value; }
	this._setEnrolmentStudentname 			= function(value) { this.studentname = value; }
	this._setEnrolmentStudentgender 		= function(value) { this.studentgender = value; }
	this._setEnrolmentStudentgrade 			= function(value) { this.studentgrade = value; }
	this._setEnrolmentStudentdateofbirth 	= function(value) { this.studentdateofbirth = value; }
	this._setEnrolmentStudentaddress 		= function(value) { this.studentaddress = value; }
	this._setEnrolmentStudentsuburb  		= function(value) { this.studentsuburb = value; }
	this._setEnrolmentStudentstate	 		= function(value) { this.studentstate = value; }
	this._setEnrolmentStudentpostcode 		= function(value) { this.studentpostcode = value; }
	this._setEnrolmentParenttitle1 			= function(value) { this.parenttitle1 = value; }
	this._setEnrolmentParentname1 			= function(value) { this.parentname1 = value; }
	this._setEnrolmentParenttitle2 			= function(value) { this.parenttitle2 = value; }
	this._setEnrolmentParentname2 			= function(value) { this.parentname2 = value; }
	this._setEnrolmentGuardian 				= function(value) { this.guardian = value; }
	this._setEnrolmentPhone 				= function(value) { this.phone = value; }
	this._setEnrolmentMobile 				= function(value) { this.mobile = value; }
	this._setEnrolmentEmail 				= function(value) { this.email = value; }
	this._setEnrolmentBackpack 				= function(value) { this.backpack = value; }
	this._setEnrolmentPreferredtime 		= function(value) { this.preferredtime = value; }
	this._setEnrolmentComments 				= function(value) { this.comments = value; }
	this._setEnrolmentFindout 				= function(value) { this.findout = value; }

	this._sendEnrolment = _sendEnrolment;

}





function _sendEnrolment() {

	try {
		var T = new Timetable();
			T._loadTimetable(this.timetableid);
		var strSelectedCourse = T._getSelectedCourseByID(this.timetableid);

		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : Online Enrolment";

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail.AddRecipient("georgina_smart@gmx.yamaha.com");
			if (T._getTimetableCentreID() == 23) {
				// Adelaide
				JMail.AddRecipient("adelaide.yms@bigpond.com");
			} else {
				JMail.AddRecipient("ymec_aust@gmx.yamaha.com");
			}

			this.mailbody = "Hi,\n" +
						 "\n" +
						 "An online enrolment has been lodged on the yamahamusic.com.au website, and the person below is expecting your return call to confirm their chosen class and collect their credit card details to process their deposit.\n" +
						 "\n" +
						 "** Enrolment Details **\n" +
						 "-- Selected Course --\n" +
						 "Course         : " + strSelectedCourse + "\n" +
						 "\n" +
						 "-- Student + Parent Details --\n" +
						 "Promo Code     : " + this.promocode + "\n" +
						 "Student Name   : " + this.studentname + "\n" +
						 "Student Gender : " + this.studentgender + "\n" +
						 "Student Grade  : " + this.studentgrade + "\n" +
						 "Student DOB    : " + new Date(Date.parse(this.studentdateofbirth)).formatDate("j M Y") + "\n" +
						 "Parent         : " + this.parenttitle1 + ". " + this.parentname1 + "\n" +
						 "Parent         : " + this.parenttitle2 + ". " + this.parentname2 + "\n" +
						 "Guardian       : " + this.guardian + "\n" +
						 "Address        : " + this.studentaddress + "\n" +
						 "  Suburb       : " + this.studentsuburb + "\n" +
						 "  State        : " + this.studentstate + "\n" +
						 "  Postcode     : " + this.studentpostcode + "\n" +
						 "Phone          : " + this.phone + "\n" +
						 "Mobile         : " + this.mobile + "\n" +
						 "Email          : " + this.email + "\n" +
						 "Backpack       : " + this.backpack + "\n" +
						 "Preferred Time : " + this.preferredtime + "\n" +
						 "Found out by   : " + this.findout + "\n" +
						 "\n" +
						 "Comments       :\n" + this.comments + "\n" +
						 "\n" +
						 "\n" +
						 "Thanks. This email has been sent via the website, there is no need to reply to this email.\n" +
						 "\n" +
						 "Yamaha Music Australia\n" +
						 "\n" +
						 "w : www.yamahamusic.com.au\n" +
						 "e : au_webmaster@gmx.yamaha.com\n" +
						 "p : 1800 805 413";

			JMail.Body = this.mailbody;
			JMail.Execute();
	} catch(e) {
		Response.Write("Attempted Send : " + e.description + "<br/>");
		Response.Flush();
	}
}






%>