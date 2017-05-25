<% 

function Service() {

	this.id = 0;
	this.rctiflag = 0;
	this.abn = new String();
	this.name = new String();
	this.vendorcode = new String();
	this.dealercode = new String();
	this.address = new String();
	this.city = new String();
	this.state = new String();
	this.country = new String();
	this.postcode = new String();
	this.email = new String();
	this.phone = new String();
	this.mobile = new String();
	this.fax = new String();
	this.url = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getServiceID = _getServiceID;
	this._getServiceRCTIflag = _getServiceRCTIflag;
	this._getServiceABN = _getServiceABN;
	this._getServiceName = _getServiceName;
	this._getServiceVendorcode = _getServiceVendorcode;
	this._getServiceDealercode = _getServiceDealercode;
	this._getServiceAddress = _getServiceAddress;
	this._getServiceCity = _getServiceCity;
	this._getServiceState = _getServiceState;
	this._getServiceCountry = _getServiceCountry;
	this._getServicePostcode = _getServicePostcode;
	this._getServiceEmail = _getServiceEmail;
	this._getServicePhone = _getServicePhone;
	this._getServiceMobile = _getServiceMobile;
	this._getServiceFax = _getServiceFax;
	this._getServiceURL = _getServiceURL;
	this._getServiceDatecreated = _getServiceDatecreated;
	this._getServiceDatemodified = _getServiceDatemodified;

	this._setServiceID = _setServiceID;
	this._setServiceRCTIflag = _setServiceRCTIflag;
	this._setServiceABN = _setServiceABN;
	this._setServiceName = _setServiceName;
	this._setServiceVendorcode = _setServiceVendorcode;
	this._setServiceDealercode = _setServiceDealercode;
	this._setServiceAddress = _setServiceAddress;
	this._setServiceCity = _setServiceCity;
	this._setServiceState = _setServiceState;
	this._setServiceCountry = _setServiceCountry;
	this._setServicePostcode = _setServicePostcode;
	this._setServiceEmail = _setServiceEmail;
	this._setServicePhone = _setServicePhone;
	this._setServiceMobile = _setServiceMobile;
	this._setServiceFax = _setServiceFax;
	this._setServiceURL = _setServiceURL;
	this._setServiceDatecreated = _setServiceDatecreated;
	this._setServiceDatemodified = _setServiceDatemodified;

	this._getAllService = _getAllService;
	this._getAllServicesByProduct = _getAllServicesByProduct;
	this._getServiceByUser = _getServiceByUser;
	this._serviceSearch = _serviceSearch;

	this._loadService = _loadService;
	this._addService = _addService;
	this._saveService = _saveService;
	this._deleteService = _deleteService;

	this._removeServiceFromProduct = _removeServiceFromProduct;
	this._addServiceToProduct = _addServiceToProduct;

}


function _getServiceID()			{ return this.id; }
function _getServiceRCTIflag()		{ return this.rctiflag; }
function _getServiceABN()			{ return this.abn; }
function _getServiceName()			{ return this.name; }
function _getServiceVendorcode()	{ return this.vendorcode; }
function _getServiceDealercode()	{ return this.dealercode; }
function _getServiceAddress()		{ return this.address; }
function _getServiceCity()			{ return this.city; }
function _getServiceState()			{ return this.state; }
function _getServiceCountry()		{ return this.country; }
function _getServicePostcode()		{ return this.postcode; }
function _getServiceEmail()			{ return this.email; }
function _getServicePhone()			{ return this.phone; }
function _getServiceMobile()		{ return this.mobile; }
function _getServiceFax()			{ return this.fax; }
function _getServiceURL()			{ return this.url; }
function _getServiceDatecreated()	{ return this.datecreated; }
function _getServiceDatemodified()	{ return this.datemodified; }

function _setServiceID(value)			{ this.id = value; }
function _setServiceRCTIflag(value)		{ this.rctiflag = value; }
function _setServiceABN(value)			{ this.abn = value; }
function _setServiceName(value)			{ this.name = value; }
function _setServiceVendorcode(value)	{ this.vendorcode = value; }
function _setServiceDealercode(value)	{ this.dealercode = value; }
function _setServiceAddress(value)		{ this.address = value; }
function _setServiceCity(value)			{ this.city = value; }
function _setServiceState(value)		{ this.state = value; }
function _setServiceCountry(value)		{ this.country = value; }
function _setServicePostcode(value)		{ this.postcode = value; }
function _setServiceEmail(value)		{ this.email = value; }
function _setServicePhone(value)		{ this.phone = value; }
function _setServiceMobile(value)		{ this.mobile = value; }
function _setServiceFax(value)			{ this.fax = value; }
function _setServiceURL(value)			{ this.url= value; }
function _setServiceDatecreated(value)	{ this.datecreated = value; }
function _setServiceDatemodified(value)	{ this.datemodified = value; }


function _getAllService() {

	var strSQL = "SELECT yma_servicecentre.* FROM yma_servicecentre ORDER BY state, name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllServicesByProduct(productid) {

	var strSQL = "SELECT yma_servicecentre.* FROM yma_servicecentre INNER JOIN yma_servicecentreproduct ON yma_servicecentre.id = yma_servicecentreproduct = dealerid WHERE yma_servicecentreproduct.productid = " + productid + " ORDER BY name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getServiceByUser(userid) {
	var intServiceCentreID = 0;
	try {
		var strSQL = "SELECT servicecentreid FROM yma_servicecentreuser WHERE userid = " + userid;
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		intServiceCentreID = new Number(rs("servicecentreid"));
	}
	rs.close();
	rs = null;
	return intServiceCentreID;
}

function _serviceSearch(productid, state, postcode) {

	var fltRADIUS = 0.25;
	var strSQLCENTROIDPRE = new String();
		strSQLCENTROIDPRE += "DECLARE @long AS float; DECLARE @lat AS float; DECLARE @radius AS float; SET @radius = " + fltRADIUS + "; ";
		strSQLCENTROIDPRE += "SELECT @long = long FROM yma_centroid WHERE postcode = '" + postcode + "'; ";
		strSQLCENTROIDPRE += "SELECT @lat = lat FROM yma_centroid WHERE postcode = '" + postcode + "'; ";
		strSQLCENTROIDPRE = postcode&&postcode!=""?strSQLCENTROIDPRE:"";
	var strSQLCENTROIDQRY = postcode&&postcode!=""?"AND yma_servicecentre.postcode IN (SELECT postcode FROM yma_centroid WHERE 1=1 AND long < @long + @radius AND long > @long - @radius AND lat < @lat + @radius AND lat > @lat - @radius)":"";
	var strSQLJOIN = productid>0?" INNER JOIN yma_servicecentreproduct ON yma_servicecentreproduct.servicecentreid= yma_servicecentre.id ":""
	var strSQLPRODUCT = productid>0?" AND yma_servicecentreproduct.productid = " + productid:""
	var strSQLSTATE = state&&state!=""&&state!="all"?" AND yma_servicecentre.state = '" + state + "'":"";

	var	strSQL = strSQLCENTROIDPRE + "SELECT yma_servicecentre.* FROM yma_servicecentre " + strSQLJOIN + " WHERE 1 = 1 " + strSQLPRODUCT + strSQLSTATE + strSQLCENTROIDQRY + " ORDER BY name ASC";


	if (productid>0 || state || postcode) {

//Response.Write(strSQL);

		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 2, 2);
	}

	if (rs && !rs.EOF) {
		return rs;
	} else {
		return null;
	}
	GBL_CONN_ALTPROVIDER.close();
}


function _loadService(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_servicecentre WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.rctiflag = new Number(rs("rctiflag"));
			this.abn = new String(rs("abn"));
			this.name = new String(rs("name"));
			this.vendorcode = new String(rs("vendorcode"));
			this.dealercode = new String(rs("dealercode"));
			this.address = new String(rs("address"));
			this.city = new String(rs("city"));
			this.state = new String(rs("state"));
			this.country = new String(rs("country"));
			this.postcode = new String(rs("postcode"));
			this.email = new String(rs("email"));
			this.phone = new String(rs("phone"));
			this.mobile = new String(rs("mobile"));
			this.fax = new String(rs("fax"));
			this.url = new String(rs("url"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addService() {
	var insertParams = "rctiflag, abn, name, vendorcode, dealercode, address, city, state, country, postcode, email, phone, mobile, fax, url, datecreated";
	var insertValues = this.rctiflag + ", '" + this.abn + "', '" + this.name + "', '" + this.vendorcode + "', '" + this.dealercode + "', '" + this.address + "', '" + this.city + "', '" + this.state + "', '" + this.country + "', '" + this.postcode + "', '" + this.email + "', '" + this.phone + "', '" + this.mobile + "', '" + this.fax + "', '" + this.url + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_servicecentre (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveService() {
	var updateStr = "rctiflag = " + this.rctiflag + ", " +
					"abn = '" + this.abn + "', " +
					"name = '" + this.name + "', " +
					"vendorcode = '" + this.vendorcode + "', " +
					"dealercode = '" + this.dealercode + "', " +
					"address = '" + this.address + "', " +
					"city = '" + this.city + "', " +
					"state = '" + this.state + "', " +
					"country = '" + this.country + "', " +
					"postcode = '" + this.postcode + "', " +
					"email = '" + this.email + "', " +
					"phone = '" + this.phone + "', " +
					"mobile = '" + this.mobile + "', " +
					"fax = '" + this.fax + "', " +
					"url = '" + this.url + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_servicecentre SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteService() {
	try {
		var strSQL = "DELETE FROM yma_servicecentre WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}



function _removeServiceFromProduct(servicecentreid) {
	try {
		var strSQL = "DELETE FROM yma_servicecentreproduct WHERE servicecentreid = " + servicecentreid;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _addServiceToProduct(servicecentreid, arrProductID) {
	if (arrProductID.length > 0) {
		try {
			var strSQL = "INSERT INTO yma_servicecentreproduct (servicecentreid, productid) SELECT " + servicecentreid + " AS servicecentreid, id AS productid FROM [yma_productcategory] WHERE id IN (" + arrProductID + ")";
			GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
	}
}




%>