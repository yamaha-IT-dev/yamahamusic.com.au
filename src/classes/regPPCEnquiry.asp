<%
function Enquiry() {

	this.recipient      = null;
	this.first_name     = null;
	this.last_name      = null;
	this.address        = null;
	this.suburb         = null;
	this.state          = "";
	this.postcode       = null;
	this.phone          = null;
	this.email          = null;
	this.dealer         = null;
	this.purchase_date  = null;
	this.serial_num     = null;

	this.mailbody = new String('');
	this.mailbody2 = new String('');
	
	this._getRecipient      = function() { return this.recipient; }
	this._getFirstName 	    = function() { return this.first_name; }
	this._getLastName       = function() { return this.last_name; }
	this._getAddress        = function() { return this.address; }
	this._getSuburb 	    = function() { return this.suburb; }
	this._getState 	        = function() { return this.state; }
	this._getPostcode       = function() { return this.postcode; }
	this._getPhone 	        = function() { return this.phone; }
	this._getEmail 	        = function() { return this.email; }
	this._getDealer 	    = function() { return this.dealer; }
	this._getPurchaseDate   = function() { return this.purchase_date; }
	this._getSerialNum      = function() { return this.serial_num; }

	this._setRecipient      = function(value) { this.recipient      = value; }
	this._setFirstName	    = function(value) { this.first_name     = value; }
	this._setLastName       = function(value) { this.last_name      = value; }
	this._setAddress        = function(value) { this.address        = value; }
	this._setSuburb 	    = function(value) { this.suburb         = value; }
	this._setState 	        = function(value) { this.state          = value; }
	this._setPostcode       = function(value) { this.postcode       = value; }
	this._setPhone	        = function(value) { this.phone          = value; }
	this._setEmail	        = function(value) { this.email          = value; }
	this._setDealer	        = function(value) { this.dealer         = value; }
	this._setPurchaseDate 	= function(value) { this.purchase_date  = value; }
	this._setSerialNum      = function(value) { this.serial_num     = value; }

	this._sendEnquiry = function()
	{

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "pianoinfo@gmx.yamaha.com";
				JMail.Subject = "Premium Piano Care Program Registration";

			  	JMail.AddRecipient("pianoinfo@gmx.yamaha.com");
				//JMail.AddRecipient("Harsono_Setiono@gmx.yamaha.com");
				
				this.mailbody = "Hi,\n" +
							 "\n" +
							 "A registration for Yamaha Premium Piano Care has been submitted via yamahamusic.com.au.\n" +
							 "\n" +
							 "-- Details --\n\n" +
							 "First Name:     " + this.first_name + "\n" +
							 "Last Name:      " + this.last_name + "\n" +
							 "Address:        " + this.address + "\n" +
							 "Suburb:         " + this.suburb + "\n" +
							 "State:          " + this.state + "\n" +
							 "Postcode:       " + this.postcode + "\n" +
 							 "Phone:          " + this.phone + "\n" +
							 "Email:          " + this.email + "\n" +
 							 "Dealer:         " + this.dealer + "\n" +
 							 "Purchase Date:  " + this.purchase_date + "\n" +
 							 "Serial Number:  " + this.serial_num + "\n" +
							 "\n" +
							 "\n" +
							 "This is an automated email, please do not reply to this email.\n" +
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
	
	this._sendAutoResponse = function()
	{

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "pianoinfo@gmx.yamaha.com";
				JMail.Subject = "Premium Piano Care Program Registration Confirmation";
								
			  	JMail.AddRecipient(this.email);				

				this.mailbody2 = "Hi,\n" +
							 "\n" +
							 "Congratulations on your new Yamaha grand piano purchase and thank you for registering for Yamaha Music Australia's Premium Care program. We trust that you will enjoy your instrument for many years to come. \n" +
							 "\n" +							 
							 "To ensure your piano preforms at its best, it should be tuned at least once every six months. The Premium Care program entitles new owners of C Series, S Series and equivalent Disklavier grand pianos to a number of free six-monthly tunings, with the number of tunings dependent on which piano you have chosen.\n" +
							 "\n" +
							 "This email is an automatic response to your registration, but you should expect to receive a welcome letter together with your Premium Care tuning vouchers within the next week. These vouchers should be treated as cash and kept in a safe place until your tunings take place. If you have any questions regarding this process, please feel free to call Felix Elliot-Dedman, Product Manager - Piano and Disklavier on 03 9693 5213.\n" +
							 "\n" +
							 "Best Regards,\n" +
							 "\n" +
							 "Yamaha Music Australia\n";						 

				JMail.Body = this.mailbody2;
				JMail.Execute();
		} catch(e) {
			Response.Write("Attempted Send : " + e.description + "<br/>");
			Response.Flush();
		}
	}
	
	this._isValid = function()
	{
		valid = new String();

		if (this.first_name && (this.first_name.length == 0 || this.first_name.indexOf("undefined") == 0)) {
			valid += " - You must provide your name.<br />";
		}
		if (this.last_name && (this.last_name.length == 0 || this.last_name.indexOf("undefined") == 0)) {
			valid += " - You must provide your family name.<br />";
		}
		if (this.address && (this.address.length == 0 || this.address.indexOf("undefined") == 0)) {
			valid += " - You must provide your street address.<br />";
		}
		if (this.suburb && (this.suburb.length == 0 || this.suburb.indexOf("undefined") == 0)) {
			valid += " - You must provide your suburb.<br />";
		}
		if (this.state && (this.state.length == 0 || this.state.indexOf("undefined") == 0)) {
			valid += " - You must provide your state.<br />";
		}
		if (this.postcode && (this.postcode.length == 0 || this.postcode.indexOf("undefined") == 0)) {
			valid += " - You must provide your post code.<br />";
		}
  		if (this.phone && (this.phone.length == 0 || this.phone.indexOf("undefined") == 0)) {
			valid += " - You must provide a contact telephone number.<br />";
		}
		
		if (this.dealer && (this.dealer.length == 0 || this.dealer.indexOf("undefined") == 0)) {
			valid += " - You must provide the name of the dealer from which you purchased your product.<br />";
		}
		if (this.purchase_date && (this.purchase_date.length == 0 || this.purchase_date.indexOf("undefined") == 0)) {
			valid += " - You must provide the name of the dealer from which you purchased your product.<br />";
		}
		if (this.purchase_date && (this.purchase_date < "6/1/2008")) {
			valid += " - Purchases made prior to June 2008 are ineligible for the Premium Care program.<br />";
		}
		if (this.serial_num && (this.serial_num.length == 0 || this.serial_num.indexOf("undefined") == 0)) {
			valid += " - You must provide your products serial number.<br />";
		}
		if (new Number(Request("terms01")) != 1) {
  		valid += "- Please indicate that you have read and agree to the terms and conditions relating to the Complimentary Tuning Voucher.<br />";
  	}
  	if (new Number(Request("terms02")) != 1) {
  		valid += "- Please indicate that you have read and agree to the terms and conditions.<br />";
  	}
		
		return valid;
	}
	
	this._isValidForPPCEnquiry = function()
	{
		valid = new String();
		var month=new Number((new String(this.purchase_date)).split("/")[1]);
        var year=new Number(new String((new String(this.purchase_date)).split("/")[2]).substring(0,4));
       
       	if (this.first_name && (this.first_name.length == 0 || this.first_name.indexOf("undefined") == 0)) {
			valid += " - You must provide your name.<br />";
		}
		if (this.last_name && (this.last_name.length == 0 || this.last_name.indexOf("undefined") == 0)) {
			valid += " - You must provide your family name.<br />";
		}
		if (this.address && (this.address.length == 0 || this.address.indexOf("undefined") == 0)) {
			valid += " - You must provide your street address.<br />";
		}
		if (this.suburb && (this.suburb.length == 0 || this.suburb.indexOf("undefined") == 0)) {
			valid += " - You must provide your suburb.<br />";
		}
		if (this.state && (this.state.length == 0 || this.state.indexOf("undefined") == 0)) {
			valid += " - You must provide your state.<br />";
		}
		if (this.postcode && (this.postcode.length == 0 || this.postcode.indexOf("undefined") == 0)) {
			valid += " - You must provide your post code.<br />";
		}
  		if (this.phone && (this.phone.length == 0 || this.phone.indexOf("undefined") == 0)) {
			valid += " - You must provide a contact telephone number.<br />";
		}
		
		if (this.dealer && (this.dealer.length == 0 || this.dealer.indexOf("undefined") == 0)) {
			valid += " - You must provide the name of the dealer from which you purchased your product.<br />";
		}
		if (year <= 2008 && month < 6) {
			valid += " - Purchases made prior to June 2008 are ineligible for the Premium Care program.<br />";
		}
		if (this.serial_num && (this.serial_num.length == 0 || this.serial_num.indexOf("undefined") == 0)) {
			valid += " - You must provide your products serial number.<br />";
		}
		if (new Number(Request("terms01")) != 1) {
  		valid += "- Please indicate that you have read and agree to the terms and conditions relating to the Complimentary Tuning Voucher.<br />";
  	}
  	if (new Number(Request("terms02")) != 1) {
  		valid += "- Please indicate that you have read and agree to the terms and conditions.<br />";
  	}
		
		return valid;
	}

}
%>