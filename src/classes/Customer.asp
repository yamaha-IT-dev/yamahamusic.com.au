<%

function Customer() {

	this.id = 0;
	this.title = new String();
	this.firstname = new String();
	this.lastname = new String();
	this.address = new String();
	this.city = new String();
	this.state = new String();
	this.country = new String();
	this.postcode = new String();
	this.phone = new String();
	this.email = new String();
	this.password = new String();
	this.optinnews = 0;
	this.optinproduct = 0;
	this.optinyaypc = 0;
	this.optinteacher = 0;
	this.logincount = 0;
	this.followup = 0;
	this.lastlogin = new String();
	this.datefollowup = new String();
	this.dateofbirth = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getCustomerID				= function() { return this.id; }
	this._getCustomerTitle			= function() { return this.title; }
	this._getCustomerFirstname		= function() { return this.firstname; }
	this._getCustomerLastname		= function() { return this.lastname; }
	this._getCustomerAddress		= function() { return this.address; }
	this._getCustomerCity			= function() { return this.city; }
	this._getCustomerState			= function() { return this.state; }
	this._getCustomerCountry		= function() { return this.country; }
	this._getCustomerPostcode		= function() { return this.postcode; }
	this._getCustomerPhone			= function() { return this.phone; }
	this._getCustomerEmail			= function() { return this.email; }
	this._getCustomerPassword		= function() { return this.password; }
	this._getCustomerOptinnews		= function() { return this.optinnews; }
	this._getCustomerOptinproduct	= function() { return this.optinproduct; }
	this._getCustomerOptinyaypc		= function() { return this.optinyaypc; }
	this._getCustomerOptinteacher	= function() { return this.optinteacher; }
	this._getCustomerFollowup		= function() { return this.followup; }
	this._getCustomerLogincount		= function() { return this.logincount; }
	this._getCustomerLastlogin		= function() { return this.lastlogin; }
	this._getCustomerDatefollowup	= function() { return this.datefollowup; }
	this._getCustomerDateofbirth	= function() { return this.dateofbirth; }
	this._getCustomerDatecreated	= function() { return this.datecreated; }
	this._getCustomerDatemodified	= function() { return this.datemodified; }

	this._setCustomerID				= function(value) { this.id = value; }
	this._setCustomerTitle			= function(value) { this.title = value; }
	this._setCustomerFirstname		= function(value) { this.firstname = value; }
	this._setCustomerLastname		= function(value) { this.lastname = value; }
	this._setCustomerAddress		= function(value) { this.address = value; }
	this._setCustomerCity			= function(value) { this.city = value; }
	this._setCustomerState			= function(value) { this.state = value; }
	this._setCustomerCountry		= function(value) { this.country = value; }
	this._setCustomerPostcode		= function(value) { this.postcode = value; }
	this._setCustomerPhone			= function(value) { this.phone = value; }
	this._setCustomerEmail			= function(value) { this.email = value; }
	this._setCustomerPassword		= function(value) { this.password = value; }
	this._setCustomerOptinnews		= function(value) { this.optinnews = value; }
	this._setCustomerOptinproduct	= function(value) { this.optinproduct = value; }
	this._setCustomerOptinyaypc		= function(value) { this.optinyaypc = value; }
	this._setCustomerOptinteacher	= function(value) { this.optinteacher = value; }
	this._setCustomerFollowup		= function(value) { this.followup = value; }
	this._setCustomerLogincount		= function(value) { this.logincount = value; }
	this._setCustomerLastlogin		= function(value) { this.lastlogin = value; }
	this._setCustomerDatefollowup	= function(value) { this.datefollowup = value; }
	this._setCustomerDateofbirth	= function(value) { this.dateofbirth = value; }
	this._setCustomerDatecreated	= function(value) { this.datecreated = value; }
	this._setCustomerDatemodified	= function(value) { this.datemodified = value; }

	this._getAllCustomers = _getAllCustomers;
	this._getCustomerCount = _getCustomerCount;
	this._getAllCustomersAsLeads = _getAllCustomersAsLeads;
	this._getCustomersByQuery = _getCustomersByQuery;

	this._loadCustomer = _loadCustomer;
	this._addCustomer = _addCustomer;
	this._saveCustomer = _saveCustomer;
	this._deleteCustomer = _deleteCustomer;

	this._emailExistsAlready = _emailExistsAlready;
	this._authenticateCustomer = _authenticateCustomer;
	this._recordLogin = _recordLogin;
	this._recordFollowup = _recordFollowup;

	this._removeCustomerFromProduct = _removeCustomerFromProduct;
	this._addCustomerToProduct = _addCustomerToProduct;

	this._isValid = _isCustomerValid;
}







function _getAllCustomers(letter) {

	var strSQL = "SELECT * FROM yma_customer WHERE SUBSTRING(lastname, 1, 1) = '" + letter + "' ORDER BY lastname ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getCustomerCount() {

	var count = 0;
	var strSQL = "SELECT count(id) FROM yma_customer";
	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		count = rs.Fields(0).value;
	}
	return count;
}


function _getAllCustomersAsLeads(year) {
	var strSQL = "SELECT " +
				 "	yma_customer.id, " +
				 "	yma_customer.title, " +
				 "	yma_customer.firstname, " +
				 "	yma_customer.lastname, " +
				 "	yma_customer.state, " +
				 "	yma_customer.followup, " +
				 "	yma_customer.datefollowup, " +
				 "	yma_customer.datecreated, " +
				 "	yma_customer.datemodified, " +
				 "	DATEPART (ww, MAX(ymec_lead.datecreated)) as 'week' " +
				 "FROM yma_customer " +
				 "INNER JOIN ymec_lead " +
				 "	ON ymec_lead.customerid = yma_customer.id " +
				 "WHERE " +
				 "  DATEPART (yy, ymec_lead.datecreated) = " + year + " " +
				 "GROUP BY " +
				 "	yma_customer.id, " +
				 "	yma_customer.title, " +
				 "	yma_customer.firstname, " +
				 "	yma_customer.lastname, " +
				 "	yma_customer.state, " +
				 "	yma_customer.followup, " +
				 "	yma_customer.datefollowup, " +
				 "	yma_customer.datecreated,  " +
				 "	yma_customer.datemodified " +
				 "ORDER BY  " +
				 "	MAX(ymec_lead.datecreated) " +
				 "DESC";

// Response.Write(strSQL);

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getCustomersByQuery(SQL) {
	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(SQL, GBL_CONN, 3, 2);
	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}



function _loadCustomer(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_customer WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));
			this.title = new String(rs("title"));
			this.firstname = new String(rs("firstname"));
			this.lastname = new String(rs("lastname"));
			this.address = new String(rs("address"));
			this.city = new String(rs("city"));
			this.state = new String(rs("state"));
			this.country = new String(rs("country"));
			this.postcode = new String(rs("postcode"));
			this.phone = new String(rs("phone"));
			this.email = new String(rs("email"));
			this.password = new String(rs("password"));
			this.optinnews = new Number(rs("optinnews"));
			this.optinproduct = new Number(rs("optinproduct"));
			this.optinyaypc = new Number(rs("optinyaypc"));
			this.optinteacher = new Number(rs("optinteacher"));
			this.followup = new Number(rs("followup"));
			this.logincount = new Number(rs("logincount"));
			this.lastlogin = new String(rs("lastlogin"));
			this.datefollowup = new String(rs("datefollowup"));
			this.dateofbirth = new String(rs("dateofbirth"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addCustomer() {
	var insertParams = "title, firstname, lastname, address, city, state, country, postcode, phone, email, password, optinnews, optinproduct, optinyaypc, optinteacher, dateofbirth, datecreated";
	var insertValues = "'" + this.title + "', '" + this.firstname + "', '" + this.lastname + "', '" + this.address + "', '" + this.city + "', '" + this.state + "', '" + this.country + "', '" + this.postcode + "', '" + this.phone + "', '" + this.email + "', '" + this.password + "', " + this.optinnews + ", " + this.optinproduct + ", " + this.optinyaypc + ", " + this.optinteacher + ", '" + this.dateofbirth + "', getdate()";


	try {
		var strSQL = "INSERT INTO yma_customer (" + insertParams + ") VALUES (" + insertValues + ")";
		GBL_CONN_ALTPROVIDER.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
		Response.Flush();
		//return;
	}

	var rs = GBL_CONN_ALTPROVIDER.Execute("SELECT @@IDENTITY");
		this.id = rs.Fields(0).value;

	rs.close();
	rs = null;
	return this.id;
}


function _saveCustomer() {
	var updateStr = "title = '" + this.title + "', " +
					"firstname = '" + this.firstname + "', " +
					"lastname = '" + this.lastname + "', " +
					"address = '" + this.address + "', " +
					"city = '" + this.city + "', " +
					"state = '" + this.state + "', " +
					"country = '" + this.country + "', " +
					"postcode = '" + this.postcode + "', " +
					"phone = '" + this.phone + "', " +
					"email = '" + this.email + "', " +
					"password = '" + this.password + "', " +
					"optinnews = " + this.optinnews + ", " +
					"optinproduct = " + this.optinproduct + ", " +
					"optinyaypc = " + this.optinyaypc + ", " +
					"optinteacher = " + this.optinteacher + ", " +
					"dateofbirth = '" + this.dateofbirth + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_customer SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteCustomer() {
	try {
		var strSQL = "DELETE FROM yma_customer WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _emailExistsAlready() {
	var customerid = 0;
	try {
		var strSQL = "SELECT id FROM yma_customer WHERE email = '" + this.email + "'";

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


function _authenticateCustomer() {
	var userid = 0;
	try {
		var strSQL = "SELECT id FROM yma_customer WHERE email = '" + this.email + "' AND password = '" + this.password + "'";
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		userid = parseInt(rs("id"));
	}
	return userid;
}


function _recordLogin() {
	var updateStr = "logincount = logincount+1, " +
					"lastlogin = GETDATE()";

	try {
		var strSQL = "UPDATE yma_customer SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _recordFollowup() {
	var updateStr = "followup = 1, " +
					"datefollowup = GETDATE()";

	try {
		var strSQL = "UPDATE yma_customer SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _removeCustomerFromProduct(customerid) {
	try {
		var strSQL = "DELETE FROM yma_customerproduct WHERE customerid = " + customerid;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _addCustomerToProduct(customerid, arrProductID) {
	if (arrProductID.length > 0) {
		try {
			var strSQL = "INSERT INTO yma_customerproduct (customerid, productid) SELECT " + customerid + " AS customerid, id AS productid FROM [yma_productcategory] WHERE id IN (" + arrProductID + ")";
			GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
	}
}


function _isCustomerValid()
{
	strErr = new String();
	if (this._getCustomerFirstname().length == 0 || this._getCustomerFirstname().indexOf("undefined") == 0) {
		strErr += " - You must provide a customer firstname<br>";
	}
	if (this._getCustomerLastname().length == 0 || this._getCustomerLastname().indexOf("undefined") == 0) {
		strErr += " - You must provide a customer surname<br>";
	}
	if (this._getCustomerAddress().length > 500) {
		strErr += " - Your address should be less than 500 characters long.<br>";
	}
	if (this._getCustomerEmail().length == 0 || this._getCustomerEmail().indexOf("undefined") == 0) {
		strErr += " - You must provide a customer email address<br>";
	} else {
		var checkemail = new String(Request("checkemail"));
		if (checkemail.indexOf("undefined") == 0 || this._getCustomerEmail().indexOf(checkemail) == -1 || checkemail.length == 0) {
			if (this._emailExistsAlready() > 0) {
				strErr += " - The email address you have entered is already in use. Duplicate email addresses aren't allowed.<br>";
			}
		}
	}
	if (this._getCustomerEmail().indexOf("@") < 1) {
		strErr += " - Please check the email address entered; it must be in the form name@domain.com<br>";
	}
	if (this._getCustomerPassword().length == 0 || this._getCustomerPassword().indexOf("undefined") == 0) {
		strErr += " - You must set a password<br>";
	}
	if (this._getCustomerPassword().length < 4) {
		strErr += " - Your password must be at least four characters long.<br>";
	}

	return strErr;
}



%>