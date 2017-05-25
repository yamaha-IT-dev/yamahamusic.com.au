<% 

function Profile() {

	this.id = null;
	this.customerid = null;
	this.karma = 0;
	this.nickname = new String();
	this.blurb = new String();
	this.url = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getProfileID = _getProfileID;
	this._getProfileCustomerID = _getProfileCustomerID;
	this._getProfileKarma = _getProfileKarma;
	this._getProfileNickname = _getProfileNickname;
	this._getProfileBlurb = _getProfileBlurb;
	this._getProfileURL = _getProfileURL;
	this._getProfileDatecreated = _getProfileDatecreated;
	this._getProfileDatemodified = _getProfileDatemodified;

	this._setProfileID = _setProfileID;
	this._setProfileCustomerID = _setProfileCustomerID;
	this._setProfileKarma = _setProfileKarma;
	this._setProfileNickname = _setProfileNickname;
	this._setProfileBlurb = _setProfileBlurb;
	this._setProfileURL = _setProfileURL;
	this._setProfileDatecreated = _setProfileDatecreated;
	this._setProfileDatemodified = _setProfileDatemodified;

	this._loadProfile = _loadProfile;
	this._addProfile = _addProfile;
	this._saveProfile = _saveProfile;
	this._deleteProfile = _deleteProfile;
}


function _getProfileID()			{ return this.id; }
function _getProfileCustomerID()	{ return this.customerid; }
function _getProfileKarma()			{ return this.karma; }
function _getProfileNickname()		{ return this.nickname; }
function _getProfileBlurb()			{ return this.blurb; }
function _getProfileURL()			{ return this.url; }
function _getProfileDatecreated()	{ return this.datecreated; }
function _getProfileDatemodified()	{ return this.datemodified; }

function _setProfileID(value)			{ this.id = value; }
function _setProfileCustomerID(value)	{ this.customerid = value; }
function _setProfileKarma(value)		{ this.karma = value; }
function _setProfileNickname(value)		{ this.nickname = value; }
function _setProfileBlurb(value)		{ this.blurb = value; }
function _setProfileURL(value)			{ this.url = value; }
function _setProfileDatecreated(value)	{ this.datecreated = value; }
function _setProfileDatemodified(value)	{ this.datemodified = value; }


function _loadProfile(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_profile WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.customerid = new Number(rs("customerid"));
			this.karma = new Number(rs("karma"));
			this.nickname = new String(rs("nickname"));
			this.blurb = new String(rs("blurb"));
			this.url = new String(rs("url"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addProfile() {
	var insertParams = "customerid, karma, nickname, blurb, url, datecreated";
	var insertValues = this.customerid + ", " + this.karma + ", '" + this.nickname + "', '" + this.blurb + "', '" + this.url + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_profile (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveProfile() {
	var updateStr = "customerid = " + this.customerid + ", " +
					"karma = " + this.karma + ", " +
					"nickname = '" + this.nickname + "', " +
					"blurb= '" + this.blurb + "', " +
					"url = '" + this.url + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_profile SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteProfile() {
	try {
		var strSQL = "DELETE FROM yma_profile WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


%>