<% 

function ProductEnquiry() {

	this.id = null;
	this.type = null;
	this.name = null;
	this.email = null;
	this.postcode = null;
	this.source = new String();
	this.comments = null;
	this.datecreated = null;

	this.mailbody = new String('');

	this._getProductEnquiryID = _getProductEnquiryID;
	this._getProductEnquiryType = _getProductEnquiryType;
	this._getProductEnquiryName = _getProductEnquiryName;
	this._getProductEnquiryEmail = _getProductEnquiryEmail;
	this._getProductEnquiryPostcode = _getProductEnquiryPostcode;
	this._getProductEnquirySource = _getProductEnquirySource;
	this._getProductEnquiryComments = _getProductEnquiryComments;
	this._getProductEnquiryDatecreated = _getProductEnquiryDatecreated;

	this._setProductEnquiryID = _setProductEnquiryID;
	this._setProductEnquiryType = _setProductEnquiryType;
	this._setProductEnquiryName = _setProductEnquiryName;
	this._setProductEnquiryEmail = _setProductEnquiryEmail;
	this._setProductEnquiryPostcode = _setProductEnquiryPostcode;
	this._setProductEnquirySource = _setProductEnquirySource;
	this._setProductEnquiryComments = _setProductEnquiryComments;
	this._setProductEnquiryDatecreated = _setProductEnquiryDatecreated;

	this._loadProductEnquiry = _loadProductEnquiry;
	this._addProductEnquiry = _addProductEnquiry;
}

function _getProductEnquiryID()				{ return this.id; }
function _getProductEnquiryType()			{ return this.type; }
function _getProductEnquiryName()			{ return this.name; }
function _getProductEnquiryEmail()			{ return this.email; }
function _getProductEnquiryPostcode()		{ return this.postcode; }
function _getProductEnquirySource()			{ return this.source; }
function _getProductEnquiryComments()		{ return this.comments; }
function _getProductEnquiryDatecreated()	{ return this.datecreated; }

function _setProductEnquiryID(value)			{ this.id = value; }
function _setProductEnquiryType(value)			{ this.type = value; }
function _setProductEnquiryName(value)			{ this.name = value; }
function _setProductEnquiryEmail(value)			{ this.email = value; }
function _setProductEnquiryPostcode(value)		{ this.postcode = value; }
function _setProductEnquirySource(value)		{ this.source = value; }
function _setProductEnquiryComments(value)		{ this.comments = value; }
function _setProductEnquiryDatecreated(value)	{ this.datecreated = value; }



function _loadProductEnquiry(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_enquiry WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.type = new String(rs("type"));
			this.name = new String(rs("name"));
			this.email = new String(rs("email"));
			this.postcode = new String(rs("postcode"));
			this.source = new String(rs("source"));
			this.comments = new String(rs("comments"));
			this.datecreated = new String(rs("datecreated"));
		}
	}
}

function _addProductEnquiry() {
	var insertParams = "type, name, email, postcode, source, comments, datecreated";
	var insertValues = "'" + this.type + "', '" + this.name + "', '" + this.email + "', '" + this.postcode + "', '" + this.source + "', '" + this.comments + "', getdate()";


	try {
		var strSQL = "INSERT INTO yma_enquiry (" + insertParams + ") VALUES (" + insertValues + ")";

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





%>