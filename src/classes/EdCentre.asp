<% 

function EdCentre() {

	this.id = 0;
	this.name = new String();
	this.address = new String();
	this.city = new String();
	this.state = new String();
	this.country = new String();
	this.postcode = new String();
	this.mapref = new String();
	this.coordinates = new String();
	this.regionalcontact = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getEdCentreID = _getEdCentreID;
	this._getEdCentreName = _getEdCentreName;
	this._getEdCentreAddress = _getEdCentreAddress;
	this._getEdCentreCity = _getEdCentreCity;
	this._getEdCentreState = _getEdCentreState;
	this._getEdCentreCountry = _getEdCentreCountry;
	this._getEdCentrePostcode = _getEdCentrePostcode;
	this._getEdCentreMapref = _getEdCentreMapref;
	this._getEdCentreCoordinates = _getEdCentreCoordinates;
	this._getEdCentreRegionalcontact = _getEdCentreRegionalcontact;
	this._getEdCentreDatecreated = _getEdCentreDatecreated;
	this._getEdCentreDatemodified = _getEdCentreDatemodified;

	this._setEdCentreID = _setEdCentreID;
	this._setEdCentreName = _setEdCentreName;
	this._setEdCentreAddress = _setEdCentreAddress;
	this._setEdCentreCity = _setEdCentreCity;
	this._setEdCentreState = _setEdCentreState;
	this._setEdCentreCountry = _setEdCentreCountry;
	this._setEdCentrePostcode = _setEdCentrePostcode;
	this._setEdCentreMapref = _setEdCentreMapref;
	this._setEdCentreCoordinates = _setEdCentreCoordinates;
	this._setEdCentreRegionalcontact = _setEdCentreRegionalcontact;
	this._setEdCentreDatecreated = _setEdCentreDatecreated;
	this._setEdCentreDatemodified = _setEdCentreDatemodified;

	this._centreSearch = _centreSearch;
	this._getAllCentre = _getAllCentre;
	
	this._loadEdCentre = _loadEdCentre;
	this._addEdCentre = _addEdCentre;
	this._saveEdCentre = _saveEdCentre;
	this._deleteEdCentre = _deleteEdCentre;

}


function _getEdCentreID()				{ return this.id; }
function _getEdCentreName()				{ return this.name; }
function _getEdCentreAddress()			{ return this.address; }
function _getEdCentreCity()				{ return this.city; }
function _getEdCentreState()			{ return this.state; }
function _getEdCentreCountry()			{ return this.country; }
function _getEdCentrePostcode()			{ return this.postcode; }
function _getEdCentreMapref()			{ return this.mapref; }
function _getEdCentreCoordinates()		{ return this.coordinates; }
function _getEdCentreRegionalcontact()	{ return this.regionalcontact; }
function _getEdCentreDatecreated()		{ return this.datecreated; }
function _getEdCentreDatemodified()		{ return this.datemodified; }

function _setEdCentreID(value)				{ this.id = value; }
function _setEdCentreName(value)			{ this.name = value; }
function _setEdCentreAddress(value)			{ this.address = value; }
function _setEdCentreCity(value)			{ this.city = value; }
function _setEdCentreState(value)			{ this.state = value; }
function _setEdCentreCountry(value)			{ this.country = value; }
function _setEdCentrePostcode(value)		{ this.postcode = value; }
function _setEdCentreMapref(value)			{ this.mapref = value; }
function _setEdCentreCoordinates(value)		{ this.coordinates = value; }
function _setEdCentreRegionalcontact(value)	{ this.regionalcontact = value; }
function _setEdCentreDatecreated(value)		{ this.datecreated = value; }
function _setEdCentreDatemodified(value)	{ this.datemodified = value; }



function _centreSearch(postcode) {

	var fltRADIUS = 0.25;
	var strSQLCENTROIDPRE = new String();
		strSQLCENTROIDPRE += "DECLARE @long AS float; DECLARE @lat AS float; DECLARE @radius AS float; SET @radius = " + fltRADIUS + "; ";
		strSQLCENTROIDPRE += "SELECT @long = long FROM yma_centroid WHERE postcode = '" + postcode + "'; ";
		strSQLCENTROIDPRE += "SELECT @lat = lat FROM yma_centroid WHERE postcode = '" + postcode + "'; ";
		strSQLCENTROIDPRE = postcode&&postcode.length>0?strSQLCENTROIDPRE:"";
	var strSQLCENTROIDQRY = postcode&&postcode.length>0?"AND ymec_centre.postcode IN (SELECT postcode FROM yma_centroid WHERE 1=1 AND long < @long + @radius AND long > @long - @radius AND lat < @lat + @radius AND lat > @lat - @radius)":"";

	var	strSQL = strSQLCENTROIDPRE + "SELECT ymec_centre.* FROM ymec_centre WHERE 1 = 1 " + strSQLCENTROIDQRY + " ORDER BY name ASC";


	if (postcode) {
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



function _getAllCentre(status, state) {

	var strStatus = status!=null?" AND ymec_centre.status = " + status:"";
	var strState = state!=null?" AND ymec_centre.state = '" + state + "'":"";

	var	strSQL = "SELECT ymec_centre.* FROM ymec_centre WHERE 1 = 1 " + strStatus + strState + " ORDER BY SUBSTRING(postcode, 1, 1) ASC, name ASC";

// Response.Write(strSQL);

	var rsCNR = Server.CreateObject("ADODB.Recordset");
		rsCNR.Open(strSQL, GBL_CONN, 2, 2);

	if (rsCNR && !rsCNR.EOF) {
		return rsCNR;
	} else {
		return null;
	}
}


function _loadEdCentre(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymec_centre WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.name = new String(rs("name"));
			this.address = new String(rs("address"));
			this.city = new String(rs("city"));
			this.state = new String(rs("state"));
			this.country = new String(rs("country"));
			this.postcode = new String(rs("postcode"));
			this.mapref = new String(rs("mapref"));
			this.coordinates = new String(rs("coordinates"));
			this.regionalcontact = new String(rs("regionalcontact"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addEdCentre() {
	var insertParams = "name, address, city, state, country, postcode, mapref, regionalcontact, datecreated";
	var insertValues = "'" + this.name + "', '" + this.address + "', '" + this.city + "', '" + this.state + "', '" + this.country + "', '" + this.postcode + "', '" + this.mapref + "', '" + this.regionalcontact + "', getdate()";

	try {
		var strSQL = "INSERT INTO ymec_centre (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveEdCentre() {
	var updateStr = "name = '" + this.name + "', " +
					"address = '" + this.address + "', " +
					"city = '" + this.city + "', " +
					"state = '" + this.state + "', " +
					"country = '" + this.country + "', " +
					"postcode = '" + this.postcode + "', " +
					"mapref = '" + this.mapref + "', " +
					"regionalcontact = '" + this.regionalcontact + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE ymec_centre SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteEdCentre() {
	try {
		var strSQL = "DELETE FROM ymec_centre WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}




%>