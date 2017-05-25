<% 

function Product() {

	this.id = null;
	this.parentid = null;
	this.userid = null;
	this.name = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getProductID = _getProductID;
	this._getProductParentID = _getProductParentID;
	this._getProductUserID = _getProductUserID;
	this._getProductName = _getProductName;
	this._getProductDatecreated = _getProductDatecreated;
	this._getProductDatemodified = _getProductDatemodified;

	this._setProductID = _setProductID;
	this._setProductParentID = _setProductParentID;
	this._setProductUserID = _setProductUserID;
	this._setProductName = _setProductName;
	this._setProductDatecreated = _setProductDatecreated;
	this._setProductDatemodified = _setProductDatemodified;

	this._getAllProduct = _getAllProduct;
	this._getAllProductsByDealer = _getAllProductsByDealer
	this._getAllProductsByService = _getAllProductsByService
	this._getAllProductsByCustomer = _getAllProductsByCustomer
	this._loadProduct = _loadProduct;
}


function _getProductID()			{ return this.id; }
function _getProductParentID() 		{ return this.parentid; }
function _getProductUserID()		{ return this.userid; }
function _getProductName()			{ return this.name; }
function _getProductDatecreated()	{ return this.datecreated; }
function _getProductDatemodified()	{ return this.datemodified; }

function _setProductID(value)			{ this.id = value; }
function _setProductParentID(value)		{ this.parentid = value; }
function _setProductUserID(value)		{ this.userid = value; }
function _setProductName(value)			{ this.name = value; }
function _setProductDatecreated(value)	{ this.datecreated = value; }
function _setProductDatemodified(value)	{ this.datemodified = value; }


function _getAllProduct() {

	var strSQL = "SELECT product.id, product.parentid, yma_product.name as parent, product.name FROM yma_product AS product INNER JOIN yma_product ON product.parentid = yma_product.id ORDER BY yma_product.name, product.name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllProductsByDealer(dealerid) {
	var Keys = new Array();
	try {
		var strSQL = "SELECT yma_dealerproduct.productid FROM yma_dealerproduct WHERE yma_dealerproduct.dealerid = " + dealerid;
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Get : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("productid"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}


function _getAllProductsByService(servicecentreid) {
	var Keys = new Array();
	try {
		var strSQL = "SELECT yma_servicecentreproduct.productid FROM yma_servicecentreproduct WHERE yma_servicecentreproduct.servicecentreid = " + servicecentreid;
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Get : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("productid"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}


function _getAllProductsByCustomer(customerid) {
	var Keys = new Array();
	try {
		var strSQL = "SELECT yma_customerproduct.productid FROM yma_customerproduct WHERE yma_customerproduct.customerid = " + customerid;
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Get : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("productid"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}


function _loadProduct(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_product WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.parentid = new Number(rs("parentid"));
			this.userid = new Number(rs("userid"));
			this.name = new String(rs("name"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}



%>