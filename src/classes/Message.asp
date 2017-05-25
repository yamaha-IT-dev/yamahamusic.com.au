<%

function Message()
{

	this.name = new String();
	this.sender = new String();
	this.email = new String();
	this.subject = new String();
	this.message = new String();
	this.mail = Server.CreateObject("JMail.SMTPMail")

	this._getMessageName 	= function() { return this.name; }
	this._getMessageSender 	= function() { return this.sender; }
	this._getMessageEmail 	= function() { return this.email; }
	this._getMessageSubject	= function() { return this.subject; }
	this._getMessageMessage	= function() { return this.message; }

	this._setMessageName 	= function(value) { this.name = value; }
	this._setMessageSender 	= function(value) { this.sender = value; }
	this._setMessageEmail 	= function(value) { this.email = value; }
	this._setMessageSubject	= function(value) { this.subject = value; }
	this._setMessageMessage	= function(value) { this.message = value; }

	this.add_recipient = function(str_email, type)
	{
		if (type == "CC")
		{
			this.mail.AddRecipientCC(str_email);
		}
		else if (type == "BCC")
		{
			this.mail.AddRecipientBCC(str_email);
		}
		else
		{
			this.mail.AddRecipient(str_email);
		}
	}

	this._send = function()
	{
		try
		{
				this.mail.ServerAddress = GBL_MAIL_SERVER;
				this.mail.Sender = this.sender;
				this.mail.Subject = this.subject;

				var mailbody = this.subject + "\n" +
							 "\n" +
							 "Date : " + new Date().formatDate("j M Y") + "\n" +
							 "\n" +
							 "-- Sender Details --\n" +
							 "Name          : " + this.name + "\n" +
							 "Email         : " + this.email + "\n" +
							 "-- Message --\n\n" +
							 "" + this.message + "\n\n" +
							 "\n\nYamaha Music Australia\n" +
							 "\n" +
							 "w : www.yamahamusic.com.au\n" +
							 "e : au_webmaster@gmx.yamaha.com\n" +
							 "p : 1800 805 413";

				this.mail.Body = mailbody;
				this.mail.Execute();
		}
		catch(e)
		{
			throw e;
		}
	}


}



%>