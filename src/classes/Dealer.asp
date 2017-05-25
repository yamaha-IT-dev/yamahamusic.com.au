<% 

function Dealer() {

	this.id = 0;
	this.pronetwork = 0;
	this.clavplatinum = 0;
	this.nirprogram = 0;
	this.name = new String();
	this.address = new String();
	this.city = new String();
	this.state = new String();
	this.region = new String();
	this.country = new String();
	this.postcode = new String();
	this.email = new String();
	this.phone = new String();
	this.fax = new String();
	this.url = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getDealerID = _getDealerID;
	this._getDealerPronetwork = _getDealerPronetwork;
	this._getDealerClavplatinum = _getDealerClavplatinum;
	this._getDealerNirprogram = _getDealerNirprogram;
	this._getDealerName = _getDealerName;
	this._getDealerAddress = _getDealerAddress;
	this._getDealerCity = _getDealerCity;
	this._getDealerState = _getDealerState;
	this._getDealerRegion = _getDealerRegion;
	this._getDealerCountry = _getDealerCountry;
	this._getDealerPostcode = _getDealerPostcode;
	this._getDealerEmail = _getDealerEmail;
	this._getDealerPhone = _getDealerPhone;
	this._getDealerFax = _getDealerFax;
	this._getDealerURL = _getDealerURL;
	this._getDealerDatecreated = _getDealerDatecreated;
	this._getDealerDatemodified = _getDealerDatemodified;

	this._setDealerID = _setDealerID;
	this._setDealerPronetwork = _setDealerPronetwork;
	this._setDealerClavplatinum = _setDealerClavplatinum;
	this._setDealerNirprogram = _setDealerNirprogram;
	this._setDealerName = _setDealerName;
	this._setDealerAddress = _setDealerAddress;
	this._setDealerCity = _setDealerCity;
	this._setDealerState = _setDealerState;
	this._setDealerRegion = _setDealerRegion;
	this._setDealerCountry = _setDealerCountry;
	this._setDealerPostcode = _setDealerPostcode;
	this._setDealerEmail = _setDealerEmail;
	this._setDealerPhone = _setDealerPhone;
	this._setDealerFax = _setDealerFax;
	this._setDealerURL = _setDealerURL;
	this._setDealerDatecreated = _setDealerDatecreated;
	this._setDealerDatemodified = _setDealerDatemodified;

	this._getAllDealersByProduct = _getAllDealersByProduct;
	this._getAllDealersBySpeciality = _getAllDealersBySpeciality;
	this._dealerSearch = _dealerSearch;

	this._loadDealer = _loadDealer;
	this._addDealer = _addDealer;
	this._saveDealer = _saveDealer;
	this._deleteDealer = _deleteDealer;

	this._removeDealerFromProduct = _removeDealerFromProduct;
	this._addDealerToProduct = _addDealerToProduct;

}


function _getDealerID()				{ return this.id; }
function _getDealerPronetwork()		{ return this.pronetwork; }
function _getDealerClavplatinum()	{ return this.clavplatinum; }
function _getDealerNirprogram()		{ return this.nirprogram; }
function _getDealerName()			{ return this.name; }
function _getDealerAddress()		{ return this.address; }
function _getDealerCity()			{ return this.city; }
function _getDealerState()			{ return this.state; }
function _getDealerRegion()			{ return this.region; }
function _getDealerCountry()		{ return this.country; }
function _getDealerPostcode()		{ return this.postcode; }
function _getDealerEmail()			{ return this.email; }
function _getDealerPhone()			{ return this.phone; }
function _getDealerFax()			{ return this.fax; }
function _getDealerURL()			{ return this.url; }
function _getDealerDatecreated()	{ return this.datecreated; }
function _getDealerDatemodified()	{ return this.datemodified; }

function _setDealerID(value)			{ this.id = value; }
function _setDealerPronetwork(value)	{ this.pronetwork = value; }
function _setDealerClavplatinum(value)	{ this.clavplatinum = value; }
function _setDealerNirprogram(value)	{ this.nirprogram = value; }
function _setDealerName(value)			{ this.name = value; }
function _setDealerAddress(value)		{ this.address = value; }
function _setDealerCity(value)			{ this.city = value; }
function _setDealerState(value)			{ this.state = value; }
function _setDealerRegion(value)		{ this.region = value; }
function _setDealerCountry(value)		{ this.country = value; }
function _setDealerPostcode(value)		{ this.postcode = value; }
function _setDealerEmail(value)			{ this.email = value; }
function _setDealerPhone(value)			{ this.phone = value; }
function _setDealerFax(value)			{ this.fax = value; }
function _setDealerURL(value)			{ this.url= value; }
function _setDealerDatecreated(value)	{ this.datecreated = value; }
function _setDealerDatemodified(value)	{ this.datemodified = value; }

function _getAllDealersByProduct(productid) {

	var strSQL = "SELECT yma_dealer.* FROM yma_dealer INNER JOIN yma_dealerproduct ON yma_dealer.id = yma_dealerproduct = dealerid WHERE yma_dealerproduct.productid = " + productid + " ORDER BY name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllDealersBySpeciality(speciality) {
	
	var result = null;
	if (speciality.length != 0) {

		var strSQL = "SELECT yma_dealer.* FROM yma_dealer WHERE " + speciality + " ORDER BY name ASC";

		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN, 3, 2);

		if (!rs.EOF) {
			result = rs;
		}
	}
	return result;
	
}


function _dealerSearch(productid, state, region, postcode) {

	var fltRADIUS = region=="M"?0.15:0.25;
	var strSQLCENTROIDPRE = new String();
		strSQLCENTROIDPRE += "DECLARE @long AS float; DECLARE @lat AS float; DECLARE @radius AS float; SET @radius = " + fltRADIUS + "; ";
		strSQLCENTROIDPRE += "SELECT @long = long FROM yma_centroid WHERE postcode = '" + postcode + "'; ";
		strSQLCENTROIDPRE += "SELECT @lat = lat FROM yma_centroid WHERE postcode = '" + postcode + "'; ";
		strSQLCENTROIDPRE = postcode&&postcode!=""?strSQLCENTROIDPRE:"";
	var strSQLCENTROIDQRY = postcode&&postcode!=""?" AND yma_dealer.postcode IN (SELECT postcode FROM yma_centroid WHERE 1=1 AND long < @long + @radius AND long > @long - @radius AND lat < @lat + @radius AND lat > @lat - @radius) ":"";
	var strSQLJOIN = productid>0?" INNER JOIN yma_dealerproduct ON yma_dealerproduct.dealerid = yma_dealer.id ":""
	var strSQLPRODUCT = productid>0?" AND yma_dealerproduct.productid = " + productid:""
	var strSQLSTATE = state&&state!=""&&state!="all"?" AND yma_dealer.state = '" + state + "' ":"";
	var strSQLREGION = region&&region!=""?" AND yma_dealer.region = '" + region + "' ":"";

	var	strSQL = strSQLCENTROIDPRE + "SELECT yma_dealer.* FROM yma_dealer " + strSQLJOIN + " WHERE 1 = 1 " + strSQLPRODUCT + strSQLSTATE + strSQLREGION + strSQLCENTROIDQRY + " ORDER BY name ASC";


	if (productid>0 || state || region || postcode) {

// Response.Write(strSQL);

		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 1);
	}

	if (rs && !rs.EOF) {
		return rs;
	} else {
		return null;
	}
	GBL_CONN_ALTPROVIDER.close();
}


function _loadDealer(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_dealer WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.pronetwork = new Number(rs("pronetwork"));
			this.clavplatinum = new Number(rs("clavplatinum"));
			this.nirprogram = new Number(rs("nirprogram"));
			this.name = new String(rs("name"));
			this.address = new String(rs("address"));
			this.city = new String(rs("city"));
			this.state = new String(rs("state"));
			this.region = new String(rs("region"));
			this.country = new String(rs("country"));
			this.postcode = new String(rs("postcode"));
			this.email = new String(rs("email"));
			this.phone = new String(rs("phone"));
			this.fax = new String(rs("fax"));
			this.url = new String(rs("url"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addDealer() {
	var insertParams = "pronetwork, clavplatinum, nirprogram, name, address, city, state, region, country, postcode, email, phone, fax, url, datecreated";
	var insertValues = this.pronetwork + ", " + this.clavplatinum + ", " + this.nirprogram + ", '" + this.name + "', '" + this.address + "', '" + this.city + "', '" + this.state + "', '" + this.region + "', '" + this.country + "', '" + this.postcode + "', '" + this.email + "', '" + this.phone + "', '" + this.fax + "', '" + this.url + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_dealer (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveDealer() {
	var updateStr = "pronetwork = " + this.pronetwork + ", " +
					"clavplatinum = " + this.clavplatinum + ", " +
					"nirprogram = " + this.nirprogram + ", " +
					"name = '" + this.name + "', " +
					"address = '" + this.address + "', " +
					"city = '" + this.city + "', " +
					"state = '" + this.state + "', " +
					"region = '" + this.region + "', " +
					"country = '" + this.country + "', " +
					"postcode = '" + this.postcode + "', " +
					"email = '" + this.email + "', " +
					"phone = '" + this.phone + "', " +
					"fax = '" + this.fax + "', " +
					"url = '" + this.url + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_dealer SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteDealer() {
	try {
		var strSQL = "DELETE FROM yma_dealer WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}



function _removeDealerFromProduct(dealerid) {
	try {
		var strSQL = "DELETE FROM yma_dealerproduct WHERE dealerid = " + dealerid;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _addDealerToProduct(dealerid, arrProductID) {
	if (arrProductID.length > 0) {
		try {
			var strSQL = "INSERT INTO yma_dealerproduct (dealerid, productid) SELECT " + dealerid + " AS dealerid, id AS productid FROM [yma_productcategory] WHERE id IN (" + arrProductID + ")";
			GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
	}
}




%>