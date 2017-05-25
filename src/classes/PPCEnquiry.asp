<%

function Enquiry() {

	this.id = null;
	this.course = null;
	this.centreid = 0;
	this.location = null;
	this.recipient = null;
	this.name = null;
	this.family_name = null;
	this.childs_name = null;
	this.childs_dob = null;
	this.send_dvd = 0;
	this.address = null;
	this.suburb = null;
	this.state = "";
	this.postcode = null;
	this.phone = null;
	this.time = null;
	this.comments = null;

	this.mailbody = new String('');

	this._getEnquiryID		  = function() { return this.id; }
	this._getEnquiryCourse 	  = function() { return this.course; }
	this._getEnquiryCentreID  = function() { return this.centreid; }
	this._getEnquiryLocation  = function() { return this.location; }
	this._getEnquiryRecipient = function() { return this.recipient; }
	this._getEnquiryName 	  = function() { return this.name; }
	this._getEnquiryFamilyName= function() { return this.family_name; }
	this._getEnquiryChildsName = function() { return this.childs_name; }
	this._getEnquiryChildsDOB = function() { return this.childs_dob; }
	this._getEnquirySendDVD	  = function() { return this.send_dvd; }
	this._getEnquiryAddress   = function() { return this.address; }
	this._getEnquirySuburb 	  = function() { return this.suburb; }
	this._getEnquiryState 	  = function() { return this.state; }
	this._getEnquiryPostcode  = function() { return this.postcode; }
	this._getEnquiryPhone 	  = function() { return this.phone; }
	this._getEnquiryTime 	  = function() { return this.time; }
	this._getEnquiryDate 	  = function() { return this.date; }
	this._getEnquiryComments  = function() { return this.comments; }

	this._setEnquiryID 		  = function(value) { this.id = value; }
	this._setEnquiryCourse    = function(value) { this.course = value; }
	this._setEnquiryCentreID  = function(value) { this.centreid = value; }
	this._setEnquiryLocation  = function(value) { this.location = value; }
	this._setEnquiryRecipient = function(value) { this.recipient = value; }
	this._setEnquiryName	  = function(value) { this.name = value; }
	this._setEnquiryFamilyName= function(value) { this.family_name = value; }
	this._setEnquiryChildsName= function(value) { this.childs_name = value; }
	this._setEnquiryChildsDOB= function(value) { this.childs_dob = value; }
	this._setEnquirySendDVD	  = function(value) { this.send_dvd = value; }
	this._setEnquiryAddress   = function(value) { this.address = value; }
	this._setEnquirySuburb 	  = function(value) { this.suburb = value; }
	this._setEnquiryState 	  = function(value) { this.state = value; }
	this._setEnquiryPostcode  = function(value) { this.postcode = value; }
	this._setEnquiryPhone	  = function(value) { this.phone = value; }
	this._setEnquiryTime	  = function(value) { this.time = value; }
	this._setEnquiryDate 	  = function(value) { this.date = value; }
	this._setEnquiryComments  = function(value) { this.comments = value; }

	this._sendEnquiry = function()
	{

		var EC = new EdCentre();
			EC._loadEdCentre(this.centreid);

		this.location = EC._getEdCentreName();
		this.recipient = EC._getEdCentreRegionalcontact();

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "au_webmaster@gmx.yamaha.com";
				JMail.Subject = "YMEC : Enquiry / Call Back Request";

				//JMail.AddRecipient(this.recipient);
				JMail.AddRecipient("au_webmaster@gmx.yamaha.com");

				if (EC._getEdCentreID() == 23) {
					JMail.AddRecipient("adelaide.yms@bigpond.com");
				} else {
					JMail.AddRecipient("ymec_aust@gmx.yamaha.com");
				}


				var str_dvd = "";
				if (this.send_dvd == 1)
				{
					str_dvd = "This person has requested a promotional DVD,\nplease forward one to the following address;" + "\n" +
						this.address + "\n" +
						this.suburb + "\n" +
						this.state + "  " + this.postcode + "\n\n";
				}


				this.mailbody = "Hi,\n" +
							 "\n" +
							 "There has been a enquiry made on the yamahamusic.com.au website, and the person below is expecting your return call to answer their questions regarding music education.\n" +
							 "\n" +
							 "-- Enquiry Details --\n" +
							 "First Name     : " + this.name + "\n" +
							 "Family Name    : " + this.family_name + "\n" +
 							 "Childs Name    : " + this.childs_name + "\n" +
 							 "Childs DOB    : " + this.childs_dob + "\n" +
							 "Phone          : " + this.phone + "\n" +
							 "Preferred Time : " + this.time + "\n" +
							 "Course         : " + this.course + "\n" +
							 "Location       : " + this.location + "\n" +
							 "\n" +
							 str_dvd +
							 "Comments:\n" + this.comments + "\n" +
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



	this._isValid = function()
	{
		valid = new String();

		if (this.location && (this.location.length == 0 || this.location.indexOf("undefined") == 0)) {
			valid += " - You must select a location<br>";
		}
		if (this.name && (this.name.length == 0 || this.name.indexOf("undefined") == 0)) {
			valid += " - You must provide your name<br>";
		}
		if (this.family_name && (this.family_name.length == 0 || this.family_name.indexOf("undefined") == 0)) {
			valid += " - You must provide your family name<br>";
		}
  	if (this.childs_name && (this.childs_name.length == 0 || this.childs_name.indexOf("undefined") == 0)) {
			valid += " - You must provide your childs name<br>";
		}
		if (this.childs_dob && (this.childs_dob.length == 0 || this.childs_dob.indexOf("undefined") == 0)) {
  		strErr += " - You must indicate the students date of birth<br/>";
  	}
		if (this.phone && (this.phone.length == 0 || this.phone.indexOf("undefined") == 0)) {
			valid += " - You must provide a contact telephone number<br>";
		}
		if (this.time && (this.time.length == 0 || this.time.indexOf("undefined") == 0)) {
			valid += " - You must select a preferred contact time<br>";
		}

		if (this.send_dvd == 1)
		{
			if (this.address && (this.address.length == 0 || this.address.indexOf("undefined") == 0)) {
				valid += " - You must provide your address<br>";
			}
			if (this.suburb && (this.suburb.length == 0 || this.suburb.indexOf("undefined") == 0)) {
				valid += " - You must provide your suburb<br>";
			}
			if (this.state && (this.state.length == 0 || this.state.indexOf("undefined") == 0)) {
				valid += " - You must provide your state<br>";
			}
			if (this.postcode && (this.postcode.length == 0 || this.postcode.indexOf("undefined") == 0)) {
				valid += " - You must provide your postcode<br>";
			}

		}

		return valid;
	}

}







%>