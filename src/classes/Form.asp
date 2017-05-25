<%

function Form() {

	this.id = null;
	this.user = null;
	this.region = null;
	this.recipient = null;
	this.city = null;
	this.student = null;
	this.date = null;
	this.classcode = null;
	this.booklevel = null;
	this.teachercode = null;
	this.newclasscode = null;
	this.newbooklevel = null;
	this.newteachercode = null;
	this.newregion = null;
	this.comments = null;
	this.rejoin = null;
	this.reasons = null;
	this.informed_of_fee = null;
	this.lessons_attended = null
	this.books_taken = null;
	this.why_fee_waived = null;
	this.lengthabsense = null;
	this.datecommence = null;
	this.daterecommence = null;
	this.datediscontinue = null;
	this.datemissed = null;
	this.datemakeup = null;
	this.studentdateofbirth = null;
	this.studentparentname = null;
	this.studentmumsname = null;
	this.studentdadsname = null;
	this.studentaddress = null;
	this.studenthomephone = null;
	this.studentworkphone = null;
	this.studentmobilephone = null;
	this.studentemail = null;
	this.studentenquiry = null;
	this.studentcourse = null;
	this.studentday = null;
	this.studenttime = null;
	this.studentlocation = null;

	this.mailbody = new String('');

	this._getFormID  					= function() { return this.id; }
	this._getFormUser  					= function() { return this.user; }
	this._getFormRegion  				= function() { return this.region; }
	this._getFormRecipient  			= function() { return this.recipient; }
	this._getFormCity  					= function() { return this.city; }
	this._getFormStudent  				= function() { return this.student; }
	this._getFormDate  					= function() { return this.date; }
	this._getFormClasscode  			= function() { return this.classcode; }
	this._getFormBooklevel  			= function() { return this.booklevel; }
	this._getFormTeachercode  			= function() { return this.teachercode; }
	this._getFormNewclasscode  			= function() { return this.newclasscode; }
	this._getFormNewbooklevel  			= function() { return this.newbooklevel; }
	this._getFormNewteachercode  		= function() { return this.newteachercode; }
	this._getFormNewregion  			= function() { return this.newregion; }
	this._getFormComments  				= function() { return this.comments; }
	this._getFormRejoin  				= function() { return this.rejoin; }
	this._getFormReasons  				= function() { return this.reasons; }
	this._getFormInformedoffee			= function() { return this.informed_of_fee; }
	this._getFormLessonsattended  		= function() { return this.lessons_attended; }
	this._getFormBookstaken				= function() { return this.books_taken; }
	this._getFormWhyfeewaived  			= function() { return this.why_fee_waived; }
	this._getFormLengthabsence  		= function() { return this.lengthabsense; }
	this._getFormDatecommence  			= function() { return this.datecommence; }
	this._getFormDaterecommence  		= function() { return this.daterecommence; }
	this._getFormDatediscontinue  		= function() { return this.datediscontinue; }
	this._getFormDatemissed 		 	= function() { return this.datemissed; }
	this._getFormDatemakeup 			= function() { return this.datemakeup; }
	this._getFormStudentdateofbirth 	= function() { return this.studentdateofbirth; }
	this._getFormStudentparentname 		= function() { return this.studentparentname; }
	this._getFormStudentmumsname  		= function() { return this.studentmumsname; }
	this._getFormStudentdadsname  		= function() { return this.studentdadsname; }
	this._getFormStudentaddress  		= function() { return this.studentaddress; }
	this._getFormStudenthomephone  		= function() { return this.studenthomephone; }
	this._getFormStudentworkphone  		= function() { return this.studentworkphone; }
	this._getFormStudentmobilephone 	= function() { return this.studentmobilephone; }
	this._getFormStudentemail  			= function() { return this.studentemail; }
	this._getFormStudentenquiry  		= function() { return this.studentenquiry; }
	this._getFormStudentcourse  		= function() { return this.studentcourse; }
	this._getFormStudentday  			= function() { return this.studentday; }
	this._getFormStudenttime  			= function() { return this.studenttime; }
	this._getFormStudentlocation  		= function() { return this.studentlocation; }

	this._setFormID  					= function(value) { this.id = value; }
	this._setFormUser 					= function(value) { this.user = value; }
	this._setFormRegion 				= function(value) { this.region = value; }
	this._setFormRecipient 				= function(value) { this.recipient = value; }
	this._setFormCity 					= function(value) { this.city = value; }
	this._setFormStudent 				= function(value) { this.student = value; }
	this._setFormDate  					= function(value) { this.date = value; }
	this._setFormClasscode  			= function(value) { this.classcode = value; }
	this._setFormBooklevel  			= function(value) { this.booklevel = value; }
	this._setFormTeachercode  			= function(value) { this.teachercode = value; }
	this._setFormNewclasscode  			= function(value) { this.newclasscode = value; }
	this._setFormNewbooklevel  			= function(value) { this.newbooklevel = value; }
	this._setFormNewteachercode			= function(value) { this.newteachercode = value; }
	this._setFormNewregion  			= function(value) { this.newregion = value; }
	this._setFormComments  				= function(value) { this.comments = value; }
	this._setFormRejoin  				= function(value) { this.rejoin = value; }
	this._setFormReasons  				= function(value) { this.reasons = value; }
	this._setFormInformedoffee			= function(value) { this.informed_of_fee = value; }
	this._setFormLessonsattended  		= function(value) { this.lessons_attended = value; }
	this._setFormBookstaken				= function(value) { this.books_taken = value; }
	this._setFormWhyfeewaived  			= function(value) { this.why_fee_waived = value; }
	this._setFormLengthabsence  		= function(value) { this.lengthabsense = value; }
	this._setFormDatecommence  			= function(value) { this.datecommence = value; }
	this._setFormDaterecommence  		= function(value) { this.daterecommence = value; }
	this._setFormDatediscontinue  		= function(value) { this.datediscontinue = value; }
	this._setFormDatemissed  			= function(value) { this.datemissed = value; }
	this._setFormDatemakeup  			= function(value) { this.datemakeup = value; }
	this._setFormStudentdateofbirth 	= function(value) { this.studentdateofbirth = value; }
	this._setFormStudentparentname 		= function(value) { this.studentparentname = value; }
	this._setFormStudentmumsname  		= function(value) { this.studentmumsname = value; }
	this._setFormStudentdadsname  		= function(value) { this.studentdadsname = value; }
	this._setFormStudentaddress  		= function(value) { this.studentaddress = value; }
	this._setFormStudenthomephone  		= function(value) { this.studenthomephone = value; }
	this._setFormStudentworkphone  		= function(value) { this.studentworkphone = value; }
	this._setFormStudentmobilephone 	= function(value) { this.studentmobilephone = value; }
	this._setFormStudentemail  			= function(value) { this.studentemail = value; }
	this._setFormStudentenquiry 		= function(value) { this.studentenquiry = value; }
	this._setFormStudentcourse  		= function(value) { this.studentcourse = value; }
	this._setFormStudentday  			= function(value) { this.studentday = value; }
	this._setFormStudenttime  			= function(value) { this.studenttime = value; }
	this._setFormStudentlocation  		= function(value) { this.studentlocation = value; }

	this._sendTransferForm = _sendTransferForm;
	this._sendDiscontinueForm = _sendDiscontinueForm;
	this._sendLeaveForm = _sendLeaveForm;
	this._sendMakeupForm = _sendMakeupForm;
	this._sendEnquiryForm = _sendEnquiryForm;
	this._sendAbsenceForm = _sendAbsenceForm;

	this._determineRecipients = _determineRecipients;

}



function _sendTransferForm() {

	try {
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : TRANSFER - " + this.student;

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail = this._determineRecipients(JMail);

			this.mailbody = "YMEC : TRANSFER : " + this.student + "\n" +
						 "\n" +
						 "Date:    " + new Date(Date.parse(this.date)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Student Details --\n" +
						 "Student: " + this.student + "\n" +
						 "Region:  " + this.region + "\n" +

						 "\n" +
						 "-- Current Class --\n" +
						 "Code:    " + this.classcode + "\n" +
						 "Book:    " + this.booklevel + "\n" +
						 "Teacher: " + this.teachercode + "\n" +
						 "\n" +
						 "-- New Class --\n" +
						 "Code:    " + this.newclasscode + "\n" +
						 "Book:    " + this.newbooklevel + "\n" +
						 "Teacher: " + this.newteachercode + "\n" +
						 "Region:  " + this.newregion+ "\n" +
						 "\n" +
						 "\n" +
						 "Comments: " + this.comments + "\n" +
						 "Date of commencement: " + new Date(Date.parse(this.datecommence)).formatDate("j M Y") + "\n" +
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


function _sendDiscontinueForm() {

	try {
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : DISCONTINUATION - " + this.student;

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail = this._determineRecipients(JMail);

		var arr_reasons = this.reasons.split(", ");
		var str_reasons = "";
		for (i = 0; i < arr_reasons.length; i++) {
			str_reasons += "  [" + arr_reasons[i] + "] " + ARR_REASONS(arr_reasons[i]) + "\n";
		}

			this.mailbody = "YMEC : DISCONTINUATION : " + this.student + "\n" +
						 "\n" +
						 "Initial Contact            : " + new Date(Date.parse(this.date)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Student Details --\n" +
						 "Student                    : " + this.student + "\n" +
						 "School                     : " + this.city + "\n" +
						 "\n" +
						 "-- Current Class --\n" +
						 "Code                       : " + this.classcode + "\n" +
						 "Book                       : " + this.booklevel + "\n" +
						 "Teacher                    : " + this.teachercode + "\n" +
						 "\n" +
						 "Reasons...\n" +
						 str_reasons + "\n" +
						 "\n" +

						 "Discontinuation point?...\n" +
						 this.why_fee_waived + "\n" +
						 "\n" +
						 "How many lessons attended? : " + this.lessons_attended + "\n" +
						 "Add to database?          : " + this.books_taken + "\n" +
						 "\n" +
						 "Comments...\n" +
						 this.comments + "\n" +
						 "\n" +

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


function _sendLeaveForm() {

	try {
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : LEAVE OF ABSENCE - " + this.student;

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail = this._determineRecipients(JMail, null);

			this.mailbody = "YMEC : LEAVE OF ABSENCE : " + this.student + "\n" +
						 "\n" +
						 "Date:    " + new Date(Date.parse(this.date)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Student Details --\n" +
						 "Student: " + this.student + "\n" +
						 "Region:  " + this.region + "\n" +

						 "\n" +
						 "-- Current Class --\n" +
						 "Code:    " + this.classcode + "\n" +
						 "Book:    " + this.booklevel + "\n" +
						 "Teacher: " + this.teachercode + "\n" +
						 "\n" +
						 "Length of Absence: " + this.lengthabsense + "\n" +
						 "Date of first lesson missed: " + new Date(Date.parse(this.datediscontinue)).formatDate("j M Y") + "\n" +
						 "Date of last lesson missed: " + new Date(Date.parse(this.daterecommence)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "Comments: " + this.comments + "\n" +
						 "Potential to rejoin class: " + this.rejoin + "\n" +
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


function _sendMakeupForm() {

	try {
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : MAKE UP LESSON";

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail = this._determineRecipients(JMail);

			this.mailbody = "YMEC : MAKE UP LESSON : " + this.student + "\n" +
						 "\n" +
						 "Date:    " + new Date(Date.parse(this.date)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Student Details --\n" +
						 "Student: " + this.student + "\n" +
						 "Region:  " + this.region + "\n" +

						 "\n" +
						 "-- Current Class --\n" +
						 "Code:    " + this.classcode + "\n" +
						 "Book:    " + this.booklevel + "\n" +
						 "Teacher: " + this.teachercode + "\n" +
						 "\n" +
						 "-- Make up Class --\n" +
						 "Code:    " + this.newclasscode + "\n" +
						 "Book:    " + this.newbooklevel + "\n" +
						 "Teacher: " + this.newteachercode + "\n" +
						 "Region:  " + this.newregion+ "\n" +
						 "\n" +
						 "Date missed: " + new Date(Date.parse(this.datemissed)).formatDate("j M Y") + "\n" +
						 "Date of make up: " + new Date(Date.parse(this.datemakeup)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "Comments: " + this.comments + "\n" +
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


function _sendEnquiryForm() {

	try {
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : REG CO-ORD ENQUIRY";

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail = this._determineRecipients(JMail);

			this.mailbody = "YMEC : REG CO-ORD ENQUIRY\n" +
						 "\n" +
						 "Date:    " + new Date(Date.parse(this.date)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Student Details --\n" +
						 "Name  : " + this.student + "\n" +
						 "DOB   : " + new Date(Date.parse(this.studentdateofbirth)).formatDate("j M Y")  + "\n" +
						 "\n" +
						 "-- Parents Details --\n" +
						 "Mother : " + this.studentmumsname + "\n" +
						 "Father : " + this.studentdadsname + "\n" +
						 "Address : " + this.studentaddress + "\n" +
						 "Ph - home : " + this.studenthomephone + "\n" +
						 "Ph - work : " + this.studentworkphone + "\n" +
						 "Ph - mobile : " + this.studentmobilephone + "\n" +
						 "Email : " + this.studentemail + "\n" +
						 "\n" +
						 "Course   : " + this.studentcourse + "\n" +
						 "Day      : " + this.studentday + "\n" +
						 "Time     : " + this.studenttime + "\n" +
						 "Location : " + this.studentlocation + "\n" +
						 "\n" +
						 "Enquiry Notes :\n" + this.studentenquiry + "\n" +
						 "\n" +
						 "Comments :\n" + this.comments + "\n" +
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


function _sendAbsenceForm(arrAC) {

	try {
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.Subject = "YMEC : TEACHER ABSENCE";

			JMail.AddRecipient("au_webmaster@gmx.yamaha.com");
			JMail = this._determineRecipients(JMail, arrAC);


			this.mailbody = "YMEC : TEACHER ABSENCE : " + this.teachercode + "\n" +
						 "\n" +
						 "Date : " + new Date(Date.parse(this.date)).formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Teacher Details --\n" +
						 "Code          : " + this.teachercode + "\n" +
						 "City          : " + this.city  + "\n" +
						 "Absence from  : " + new Date(Date.parse(this.datecommence)).formatDate("j M Y") + "\n" +
						 "Absence until : " + new Date(Date.parse(this.daterecommence)).formatDate("j M Y") + "\n" +
						 "Reasons       : " + this.reasons + "\n" +
						 "\n" +
						 "-- Replacement Details --\n";

						for (a = 0; a < arrAC.length; a++) {

							var tmpAC = arrAC[a];

						 	this.mailbody += "" +
						 		(tmpAC.teachercode == "CANCEL"?"**":"") +
						 		tmpAC.classcode + " - " +
						 		tmpAC.datescheduled.formatDate("j/m/Y h:i A") + " - " +
						 		tmpAC.teachercode + " - " +
						 		tmpAC.comment + "\n";


						 }

			this.mailbody += "\n\nYamaha Music Australia\n" +
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



function _determineRecipients(jMail, arrAC) {

	var T = new Teacher();

	jMail.AddRecipient("ymec_aust@gmx.yamaha.com");
	jMail.AddRecipient("ymec_admin@gmx.yamaha.com");
	jMail.AddRecipient("Rose_Longmore@gmx.yamaha.com");
	
	var str_teacher = T._getTeacherEmailByCode(this.teachercode);
	var str_newteacher = T._getTeacherEmailByCode(this.newteachercode);
	var str_region = T._getTeacherEmailByRegion(this.region);
	var str_newregion = T._getTeacherEmailByRegion(this.newregion);

// Response.Write("Sending to teacher : " + str_teacher + "<br/>");
// Response.Write("Sending to new teacher : " + str_newteacher + "<br/>");
// Response.Write("Sending to region  : " + str_region + "<br/>");
// Response.Write("Sending to new region : " + str_newregion + "<br/>");

	if (this.recipient) {
		jMail.AddRecipient(this.recipient);
	}
	if (str_teacher) {
		jMail.AddRecipient(str_teacher);
	}
	if (str_newteacher) {
		jMail.AddRecipient(str_newteacher);
	}
	if (str_region) {
		jMail.AddRecipient(str_region);
	}
	if (str_newregion) {
		jMail.AddRecipient(str_newregion);
	}

	if (new String(Request("action")).indexOf("send_enquiry") != 0) {
		
		jMail.AddRecipient("john_corlett@gmx.yamaha.com");
	}

	if (arrAC && arrAC.length > 0) {
		for (a = 0; a < arrAC.length; a++) {
			var tmpAC = arrAC[a];
			if (tmpAC.teachercode != "CANCEL") {
				var tmpTeacherEmail = T._getTeacherEmailByCode(tmpAC.teachercode);
				jMail.AddRecipient(tmpTeacherEmail);
			}
		 }
	}

	return jMail
}



function AbsentClass(date, clazz, teachercode, comment) {
	this.datescheduled = date;
	this.classcode = clazz;
	this.teachercode = teachercode;
	this.comment = comment;
}



%>