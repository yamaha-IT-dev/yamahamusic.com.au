<% 
function User() {

	this.id = 0;
	this.customerid = null;
	this.usertypeid = null;
	this.username = new String();
	this.password = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getUserID = _getUserID;
	this._getUserCustomerID = _getUserCustomerID;
	this._getUserUsertypeID = _getUserUsertypeID;
	this._getUserUsername = _getUserUsername;
	this._getUserPassword = _getUserPassword;
	this._getUserDatecreated = _getUserDatecreated;
	this._getUserDatemodified = _getUserDatemodified;
	this._getUserStatus = _getUserStatus;
	
	this._setUserID = _setUserID;
	this._setUserCustomerID = _setUserCustomerID;
	this._setUserUsertypeID = _setUserUsertypeID;
	this._setUserUsername = _setUserUsername;
	this._setUserPassword = _setUserPassword;
	this._setUserDatecreated = _setUserDatecreated;
	this._setUserDatemodified = _setUserDatemodified;
	this._setUserStatus = _setUserStatus;

	this._getAllUsers = _getAllUsers;
	this._getAllDealers = _getAllDealers;
	this._getAllUserTypes = _getAllUserTypes

	this._loadUser = _loadUser;
	this._loadUserByCustomerID = _loadUserByCustomerID;
	this._addUser = _addUser;
	this._saveUser = _saveUser;
	this._deleteUser = _deleteUser;
	
	this._authenticateUser = _authenticateUser;
	this._authenticateDealer = _authenticateDealer;
	this._usernameExistsAlready = _usernameExistsAlready;
	this._recordUserLogin = _recordUserLogin;

	this._removeUserFromServiceCentre = _removeUserFromServiceCentre;
	this._addUserToServiceCentre = _addUserToServiceCentre;
}

function _getUserID()			{ return this.id; }
function _getUserCustomerID()	{ return this.customerid; }
function _getUserUsertypeID()	{ return this.usertypeid; }
function _getUserUsername()		{ return this.username; }
function _getUserPassword()		{ return this.password; }
function _getUserDatecreated()	{ return this.datecreated; }
function _getUserDatemodified()	{ return this.datemodified; }
function _getUserStatus()		{ return this.status; }

function _setUserID(value)			{ this.id = value; }
function _setUserCustomerID(value)	{ this.customerid = value; }
function _setUserUsertypeID(value)	{ this.usertypeid = value; }
function _setUserUsername(value)	{ this.username = value; }
function _setUserPassword(value)	{ this.password = value; }
function _setUserDatecreated(value)	{ this.datecreated = value; }
function _setUserDatemodified(value){ this.datemodified = value; }
function _setUserStatus(value)		{ this.status = value; }

function _getAllUsers(usertypeid) {

	strSQLUSERTYPE = usertypeid>0?" AND yma_usertype.id = " + usertypeid:"";
	strSQL = "SELECT yma_user.id, yma_user.customerid, yma_user.usertypeid, yma_usertype.name as usertype, yma_user.status, yma_user.logincount, yma_user.datelastlogin, yma_user.datecreated, yma_usertype.name as usertype, yma_user.username, yma_customer.title, yma_customer.firstname, yma_customer.lastname, yma_customer.address, yma_customer.city, yma_customer.state, yma_customer.postcode, yma_customer.phone, yma_customer.email FROM yma_user INNER JOIN yma_customer ON yma_customer.id = yma_user.customerid INNER JOIN yma_usertype ON yma_user.usertypeid = yma_usertype.id WHERE 1 = 1 " + strSQLUSERTYPE + " ORDER BY usertypeid, username ASC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
	} catch (e) {
		Response.Write("Attempted Open : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllDealers(usertypeid) {

	strSQL = "SELECT yma_user.id, yma_user.customerid, yma_user.usertypeid, yma_user.status, yma_user.logincount, yma_user.datelastlogin, yma_user.datecreated, yma_usertype.name as usertype, yma_user.username, yma_customer.title, yma_customer.firstname, yma_customer.lastname, yma_customer.address, yma_customer.city, yma_customer.state, yma_customer.postcode, yma_customer.phone, yma_customer.email FROM yma_user INNER JOIN yma_customer ON yma_customer.id = yma_user.customerid INNER JOIN yma_usertype ON yma_user.usertypeid = yma_usertype.id WHERE yma_usertype.id = '8' ORDER BY yma_user.datecreated ASC, username ASC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
	} catch (e) {
		Response.Write("Attempted Open : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllUserTypes() {

	var rs = GBL_CONN.Execute("SELECT yma_usertype.* FROM yma_usertype ORDER BY name ASC");

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _loadUser(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_user WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));
			this.customerid = parseInt(rs("customerid"));
			this.usertypeid = parseInt(rs("usertypeid"));
			this.username = new String(rs("username"));
			this.password = new String(rs("password"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
			this.status = new String(rs("status"));
		}
	}
}

function _loadUserByCustomerID(customerid) {
	if (customerid) {
		try {
			var strSQL = "SELECT * FROM yma_user WHERE customerid = " + customerid;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));
			this.customerid = parseInt(rs("customerid"));
			this.usertypeid = parseInt(rs("usertypeid"));
			this.username = new String(rs("username"));
			this.password = new String(rs("password"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}


function _addUser() {
	var insertParams = "customerid, usertypeid, username, password, datecreated";
	var insertValues = this.customerid + ", " + this.usertypeid + ", '" + this.username + "', '" + this.password + "', getdate()";

	try {
		var strSQL = "SET NOCOUNT ON; INSERT INTO yma_user (" + insertParams + ") VALUES (" + insertValues + "); SELECT @@IDENTITY";
		var rs = GBL_CONN.Execute(strSQL);
		this.id = rs.Fields(0).value;
		rs.close();
		rs = null;

	} catch(e) {
		Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	

	return this.id;
}


function _saveUser() {
	var updateStr = "customerid = " + this.customerid + ", " +
					"usertypeid = " + this.usertypeid + ", " +
					"username = '" + this.username + "', " +
					"password = '" + this.password + "', " +
					"status = '" + this.status + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_user SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteUser() {
	try {
		var strSQL = "DELETE FROM yma_user WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _authenticateUser() {
	var userid = 0;
	try {
		var strSQL = "SELECT id FROM yma_user WHERE username = '" + this.username + "' AND password = '" + this.password + "'";
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		userid = parseInt(rs("id"));
		this.id = userid;
		this._recordUserLogin();
	}
	return userid;
}

function _authenticateDealer() {
	var userid = 0;
	try {
		var strSQL = "SELECT id FROM yma_user WHERE status = '1' and username = '" + this.username + "' AND password = '" + this.password + "'";
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		userid = parseInt(rs("id"));
		this.id = userid;
		this._recordUserLogin();
	}
	return userid;
}


function _usernameExistsAlready() {
	var userid = 0;
	try {
		var strSQL = "SELECT id FROM yma_user WHERE username = '" + this.username + "'";
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		userid = new Number(rs("id"));
	}
	return userid;
}

function _recordUserLogin() {
	var updateStr = "logincount = logincount+1, " +
					"datelastlogin = GETDATE()";

	try {
		var strSQL = "UPDATE yma_user SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _removeUserFromServiceCentre(userid) {
	try {
		var strSQL = "DELETE FROM yma_servicecentreuser WHERE userid =  " + userid;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _addUserToServiceCentre(userid, servicecentreid) {
	try {
		var strSQL = "INSERT INTO yma_servicecentreuser (userid, servicecentreid) VALUES (" + userid + ", " + servicecentreid + ")";
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}



%>