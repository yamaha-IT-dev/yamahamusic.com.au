<% 

function Registration() {

	this.firstname = new String();
	this.surname = new String();
	this.email = new String();
	this.phone = new String();
	this.organisation = new String();
	this.session = new String();
	this.mailbody = new String();
	
	this.send = function() {

		try {
			var JMail = Server.CreateObject("JMail.SMTPMail");
				JMail.ServerAddress = GBL_MAIL_SERVER;
				JMail.Sender = "au_webmaster@gmx.yamaha.com";
				JMail.Subject = "Yamaha Commercial Audio : Workshop Registration";
        
        JMail.AddRecipient("shaun_herberg@gmx.yamaha.com");


				this.mailbody = "Yamaha Commercial Audio : Workshop Registration\n" +
							 "\n" +
							 "Date : " + new Date().formatDate("j M Y") + "\n" +
							 "\n" +
							 "-- Registrant Details --\n" +
							 "Name          : " + this.firstname + " " + this.surname + "\n" +
							 "Email         : " + this.email + "\n" +
							 "Phone         : " + this.phone + "\n" +
							 "Organsiation  : " + this.organisation + "\n" +
							 "Session       : " + this.session + "\n" +
							 "\n" +
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
		
			throw e;

		}	
	
	}
	
	this.validate = function() {
	
		strErr = new String();
		if (this.firstname.length == 0 || this.firstname.indexOf("undefined") == 0) {
			strErr += " - You must provide your firstname<br/>";
		}	
		if (this.surname.length == 0 || this.surname.indexOf("undefined") == 0) {
			strErr += " - You must provide your surname<br/>";
		}	
		if (this.email.length == 0 || this.email.indexOf("undefined") == 0) {
			strErr += " - You must provide your email address<br/>";
		}	
		if (this.phone.length == 0 || this.phone.indexOf("undefined") == 0) {
			strErr += " - You must provide a contact phone number<br/>";
		}	
		if (this.organisation.length == 0 || this.organisation.indexOf("undefined") == 0) {
			strErr += " - You must indicate which organisation / business you are from<br/>";
		}	
		if (this.session.length == 0 || this.session.indexOf("undefined") == 0) {
			strErr += " - You must select the session you wish to attend<br/>";	
		}	
	
		return strErr;
	
	}
	
	

}





%>