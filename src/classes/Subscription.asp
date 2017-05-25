<% 

function Subscription() {

	this.id = 0;
	this.name = new String();
	this.email = new String();
	this.optin = 0;
	this.datecreated = new String();
	this.datemodified = new String();

	this._getSubscriptionID = _getSubscriptionID;
	this._getSubscriptionName = _getSubscriptionName;
	this._getSubscriptionEmail = _getSubscriptionEmail;
	this._getSubscriptionOptin = _getSubscriptionOptin;
	this._getSubscriptionDatecreated = _getSubscriptionDatecreated;
	this._getSubscriptionDatemodified = _getSubscriptionDatemodified;

	this._setSubscriptionID = _setSubscriptionID;
	this._setSubscriptionName = _setSubscriptionName;
	this._setSubscriptionEmail = _setSubscriptionEmail;
	this._setSubscriptionOptin = _setSubscriptionOptin;
	this._setSubscriptionDatecreated = _setSubscriptionDatecreated;
	this._setSubscriptionDatemodified = _setSubscriptionDatemodified;

	this._loadSubscription = _loadSubscription;
	this._addSubscription = _addSubscription;
	this._saveSubscription = _saveSubscription;
	this._deleteSubscription = _deleteSubscription;

	this._subscriberExists = _subscriberExists;

}


function _getSubscriptionID()			{ return this.id; }
function _getSubscriptionName()			{ return this.name; }
function _getSubscriptionEmail()		{ return this.email; }
function _getSubscriptionOptin()		{ return this.optin; }
function _getSubscriptionDatecreated()	{ return this.datecreated; }
function _getSubscriptionDatemodified()	{ return this.datemodified; }

function _setSubscriptionID(value)				{ this.id = value; }
function _setSubscriptionName(value)			{ this.name = value; }
function _setSubscriptionEmail(value)			{ this.email = value; }
function _setSubscriptionOptin(value)			{ this.optin = value; }
function _setSubscriptionDatecreated(value)		{ this.datecreated = value; }
function _setSubscriptionDatemodified(value)	{ this.datemodified = value; }


function _loadSubscription(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymamc_subscription WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.name = new String(rs("name"));
			this.email = new String(rs("email"));
			this.optin = new Number(rs("optin"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}


function _addSubscription() {
	var insertParams = "name, email, optin, datecreated";
	var insertValues = "'" + this.name + "', '" + this.email + "', " + this.optin + ", getdate()";

	try {
		var strSQL = "INSERT INTO ymamc_subscription (" + insertParams + ") VALUES (" + insertValues + ")";
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
		Response.Flush();
		//return;
	}
	
	var rs = GBL_CONN.Execute("SELECT @@IDENTITY");
		this.id = rs.Fields(0).value;

	rs.close();
	rs = null;

	return this.id;
}


function _saveSubscription() {
	var updateStr = "name = '" + this.name + "', " +
					"email = '" + this.email + "', " +
					"optin = " + this.optin + ", " +
					"datemodified = getdate()";

	try {
		var strSQL = "UPDATE ymamc_subscription SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _deleteSubscription() {
	try {
		var strSQL = "DELETE FROM ymamc_subscription WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}



function _subscriberExists() {
	var customerid = 0;
	try {
		var strSQL = "SELECT id FROM ymamc_subscription WHERE email = '" + this.email + "'";

		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		customerid = new Number(rs("id"));
	}
	return customerid;
}



%>