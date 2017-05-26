<% 
function Message() {
	this.store_name = new String();
	this.store_address = new String();
	this.store_suburb = new String();
	this.store_postcode = new String();
	this.store_state = new String();
	this.store_phone = new String();
	this.name = new String();
	this.email = new String();
	this.message = new String();
	this.items = new Array();
	this.quantity0 = new String();
	this.quantity1 = new String();
	this.quantity2 = new String();
	this.quantity3 = new String();
	this.quantity4 = new String();
	this.quantity5 = new String();
	this.quantity6 = new String();
	this.quantity7 = new String();
	this.quantity8 = new String();
	this.quantity9 = new String();
	
	this._getMessageStoreName = _getMessageStoreName;
	this._getMessageStoreAddress = _getMessageStoreAddress;
	this._getMessageStoreSuburb = _getMessageStoreSuburb;
	this._getMessageStorePostcode = _getMessageStorePostcode;
	this._getMessageStoreState = _getMessageStoreState;
	this._getMessageStorePhone = _getMessageStorePhone;		
	this._getMessageName = _getMessageName;
	this._getMessageEmail = _getMessageEmail;
	this._getMessageMessage = _getMessageMessage;
	this._getMessageItems = _getMessageItems;
	this._getMessageQuantity0 = _getMessageQuantity0;
	this._getMessageQuantity1 = _getMessageQuantity1;
	this._getMessageQuantity2 = _getMessageQuantity2;
	this._getMessageQuantity3 = _getMessageQuantity3;
	this._getMessageQuantity4 = _getMessageQuantity4;
	this._getMessageQuantity5 = _getMessageQuantity5;
	this._getMessageQuantity6 = _getMessageQuantity6;
	this._getMessageQuantity7 = _getMessageQuantity7;
	this._getMessageQuantity8 = _getMessageQuantity8;
	this._getMessageQuantity9 = _getMessageQuantity9;
	
	this._setMessageStoreName = _setMessageStoreName;
	this._setMessageStoreAddress = _setMessageStoreAddress;
	this._setMessageStoreSuburb = _setMessageStoreSuburb;
	this._setMessageStorePostcode = _setMessageStorePostcode;
	this._setMessageStoreState = _setMessageStoreState;
	this._setMessageStorePhone = _setMessageStorePhone;	
	this._setMessageName = _setMessageName;
	this._setMessageEmail = _setMessageEmail;
	this._setMessageMessage = _setMessageMessage;
	this._setMessageQuantity0 = _setMessageQuantity0;
	this._setMessageQuantity1 = _setMessageQuantity1;
	this._setMessageQuantity2 = _setMessageQuantity2;
	this._setMessageQuantity3 = _setMessageQuantity3;
	this._setMessageQuantity4 = _setMessageQuantity4;
	this._setMessageQuantity5 = _setMessageQuantity5;
	this._setMessageQuantity6 = _setMessageQuantity6;
	this._setMessageQuantity7 = _setMessageQuantity7;
	this._setMessageQuantity8 = _setMessageQuantity8;
	this._setMessageQuantity9 = _setMessageQuantity9;
	
	this._parseSession = _parseSession;
	this._serializeItems = _serializeItems;
	this._addItem = _addItem;
	this._removeItem = _removeItem;
	this._sendMessage = _sendMessage;

}
function _getMessageStoreName()		{ return this.store_name; }
function _getMessageStoreAddress()	{ return this.store_address; }
function _getMessageStoreSuburb()	{ return this.store_suburb; }
function _getMessageStorePostcode()	{ return this.store_postcode; }
function _getMessageStoreState()	{ return this.store_state; }
function _getMessageStorePhone()	{ return this.store_phone; }
function _getMessageName()		{ return this.name; }
function _getMessageEmail()		{ return this.email; }
function _getMessageMessage()	{ return this.message; }
function _getMessageItems()		{ return this.items; }
function _getMessageQuantity0()		{ return this.quantity0; }
function _getMessageQuantity1()		{ return this.quantity1; }
function _getMessageQuantity2()		{ return this.quantity2; }
function _getMessageQuantity3()		{ return this.quantity3; }
function _getMessageQuantity4()		{ return this.quantity4; }
function _getMessageQuantity5()		{ return this.quantity5; }
function _getMessageQuantity6()		{ return this.quantity6; }
function _getMessageQuantity7()		{ return this.quantity7; }
function _getMessageQuantity8()		{ return this.quantity8; }
function _getMessageQuantity9()		{ return this.quantity9; }

function _setMessageStoreName(value) 	{ this.store_name = value; }
function _setMessageStoreAddress(value) { this.store_address = value; }
function _setMessageStoreSuburb(value) 	{ this.store_suburb = value; }
function _setMessageStorePostcode(value) { this.store_postcode = value; }
function _setMessageStoreState(value) 	{ this.store_state = value; }
function _setMessageStorePhone(value) 	{ this.store_phone = value; }
function _setMessageName(value)		{ this.name = value; }
function _setMessageEmail(value)	{ this.email = value; }
function _setMessageMessage(value)	{ this.message = value; }
function _setMessageQuantity0(value)	{ this.quantity0 = value; }
function _setMessageQuantity1(value)	{ this.quantity1 = value; }
function _setMessageQuantity2(value)	{ this.quantity2 = value; }
function _setMessageQuantity3(value)	{ this.quantity3 = value; }
function _setMessageQuantity4(value)	{ this.quantity4 = value; }
function _setMessageQuantity5(value)	{ this.quantity5 = value; }
function _setMessageQuantity6(value)	{ this.quantity6 = value; }
function _setMessageQuantity7(value)	{ this.quantity7 = value; }
function _setMessageQuantity8(value)	{ this.quantity8 = value; }
function _setMessageQuantity9(value)	{ this.quantity9 = value; }

function _parseSession(sessionitems) {

	var strs = new String(sessionitems);
	var arrs = strs.split("|");

	if (arrs.length > 0) {
		for (var i = 1; i < arrs.length-1; i++) {
			this.items.push(arrs[i]);
		}
	}
}

function _serializeItems() {

	var strs = new String("|");
		
	for (var i = 0; i < this.items.length; i++) {
		strs += this.items[i] + "|";
	}
	return strs
}

function _addItem(resourceid) {
	var stritems = this.items.toString();
	var already = false;
	for (var i = 0; i < this.items.length; i++) {
		if (this.items[i] == resourceid) {
			already = true;
			break;
		}
	}
	if (!already) {
		this.items.push(resourceid);
	}
}

function _removeItem(resourceid) {

	var tmparr = new Array()
	for (var i = 0; i < this.items.length; i++) {
		if (this.items[i] != resourceid) {
			tmparr.push(this.items[i]);
		}
	}
	this.items = tmparr;
}

function _sendMessage() {

	try {
		var R = new Resource();
		var JMail = Server.CreateObject("JMail.SMTPMail");
			JMail.ServerAddress = GBL_MAIL_SERVER;
			JMail.Sender = "au_webmaster@gmx.yamaha.com";
			JMail.SenderName = "Yamaha Connect";
			JMail.Subject = "Yamaha Connect: Resources Request";
			
			var tmpSenderEmail = this.email;
			
			JMail.AddRecipient("dion_durante@gmx.yamaha.com");			
			JMail.AddRecipient("jaclyn_williams@gmx.yamaha.com");
			JMail.AddRecipient("anna_bagnato@gmx.yamaha.com");
			JMail.AddRecipient("john_saccaro@gmx.yamaha.com");
			JMail.AddRecipient("nicole_pasmanik@gmx.yamaha.com");
			JMail.AddRecipient(tmpSenderEmail);
			
			this.mailbody = "Yamaha Connect: Requesting Resources\n" +
						 "\n" +
						 "Date      : " + new Date().formatDate("j M Y") + "\n" +
						 "\n" +
						 "-- Store Details --\n" +
						 "Name      : " + this.store_name + "\n" +
						 "Address   : " + this.store_address + "\n" +
						 "Suburb    : " + this.store_suburb + "\n" +						 
						 "State     : " + this.store_state + "\n" +
						 "Postcode  : " + this.store_postcode + "\n" +
						 
						 "-- Contact Person Details --\n" +
						 "Name      : " + this.name + "\n" +
						 "Phone no  : " + this.store_phone + "\n" +
						 "Email     : " + this.email + "\n" +
						
						 "-- Notes --\n" +
						 "Comments  :\n" +
						 "" + this.message + "\n" +
						 "-- Quantity --\n" +
						 "Item#0    : " + this.quantity0 + "\n" +
						 "Item#1    : " + this.quantity1 + "\n" +
						 "Item#2    : " + this.quantity2 + "\n" +
						 "Item#3    : " + this.quantity3 + "\n" +
						 "Item#4    : " + this.quantity4 + "\n" +
						 "Item#5    : " + this.quantity5 + "\n" +
						 "Item#6    : " + this.quantity6 + "\n" +
						 "Item#7    : " + this.quantity7 + "\n" +
						 "Item#8    : " + this.quantity8 + "\n" +
						 "Item#9    : " + this.quantity9 + "\n" +
						 "\n";

						if (this.items.length > 0) {

						 	this.mailbody += "-- Resources Requested --\n";
													
							for (i = 0; i < this.items.length; i++) {
								R._loadResource(this.items[i]);
							 	this.mailbody += "Item#" + i + ": " + R._getResourceName() + "\n";
							}
						}						 

			this.mailbody += "\n\nYamaha Music Australia Pty Ltd\n" +
						 "\n" +
						 "w : au.yamaha.com\n" +
						 "p : 1800 805 413";

			JMail.Body = this.mailbody;
			JMail.Execute();
			
	} catch(e) {
		throw e;
	}
}
%>