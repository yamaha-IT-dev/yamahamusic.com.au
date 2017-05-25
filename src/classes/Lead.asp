<% 

function Lead() {

	this.id = 0;
	this.customerid = null;
	this.postcode = new String();
	this.preferred = new String();
	this.sessionid = new String();
	this.datecreated = new String();

	this._getLeadID = _getLeadID;
	this._getLeadCustomerID = _getLeadCustomerID;
	this._getLeadPostcode = _getLeadPostcode;
	this._getLeadPreferred = _getLeadPreferred;
	this._getLeadSessionID = _getLeadSessionID;
	this._getLeadDatecreated = _getLeadDatecreated;

	this._setLeadID = _setLeadID;
	this._setLeadCustomerID = _setLeadCustomerID;
	this._setLeadPostcode = _setLeadPostcode;
	this._setLeadPreferred = _setLeadPreferred;
	this._setLeadSessionID = _setLeadSessionID;
	this._setLeadDatecreated = _setLeadDatecreated;

	this._loadLeadBySessionID = _loadLeadBySessionID;
	this._loadLeadByCustomerID = _loadLeadByCustomerID;
	this._loadLead = _loadLead;
	this._addLead = _addLead;
	this._saveLead = _saveLead;
	this._saveLeadPreferred = _saveLeadPreferred;
	this._deleteLead = _deleteLead;

}


function _getLeadID()			{ return this.id; }
function _getLeadCustomerID()	{ return this.customerid; }
function _getLeadPostcode()		{ return this.postcode; }
function _getLeadPreferred()	{ return this.preferred; }
function _getLeadSessionID()	{ return this.sessionid; }
function _getLeadDatecreated()	{ return this.datecreated; }

function _setLeadID(value)			{ this.id = value; }
function _setLeadCustomerID(value)	{ this.customerid = value; }
function _setLeadPostcode(value)	{ this.postcode = value; }
function _setLeadPreferred(value)	{ this.preferred = value; }
function _setLeadSessionID(value)	{ this.sessionid = value; }
function _setLeadDatecreated(value)	{ this.datecreated = value; }


function _loadLeadBySessionID(sessionid) {
	if (sessionid) {
		try {
			var strSQL = "SELECT * FROM ymec_lead WHERE sessionid = '" + sessionid + "'";
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.customerid = new Number(rs("customerid"));
			this.postcode = new String(rs("postcode"));
			this.preferred = new String(rs("preferred"));
			this.sessionid = new String(rs("sessionid"));
			this.datecreated = new String(rs("datecreated"));
		}
	}
}

function _loadLeadByCustomerID(customerid) {
	if (customerid) {
		try {
			var strSQL = "SELECT TOP 1 * FROM ymec_lead WHERE customerid = '" + customerid + "' ORDER BY datecreated DESC";
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.customerid = new Number(rs("customerid"));
			this.postcode = new String(rs("postcode"));
			this.preferred = new String(rs("preferred"));
			this.sessionid = new String(rs("sessionid"));
			this.datecreated = new String(rs("datecreated"));
		}
	}
}

function _loadLead(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymec_lead WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.customerid = new Number(rs("customerid"));
			this.postcode = new String(rs("postcode"));
			this.preferred = new String(rs("preferred"));
			this.sessionid = new String(rs("sessionid"));
			this.datecreated = new String(rs("datecreated"));
		}
	}
}

function _addLead() {
	var insertParams = "customerid, postcode, sessionid, datecreated";
	var insertValues = this.customerid + ", '" + this.postcode + "', '" + this.sessionid + "', getdate()";

	try {
		var strSQL = "INSERT INTO ymec_lead (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveLead() {
	var updateStr = "customerid = " + this.customerid + ", " +
					"postcode = '" + this.postcode + "', " +
					"sessionid = '" + this.sessionid + "'";

	try {
		var strSQL = "UPDATE ymec_lead SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _saveLeadPreferred() {
	var updateStr = "preferred = '" + this.preferred + "'";

	try {
		var strSQL = "UPDATE ymec_lead SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _deleteLead() {
	try {
		var strSQL = "DELETE FROM ymec_lead WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}




%>