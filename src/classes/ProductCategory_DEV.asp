<% 

function ProductCategory() {

	this.id = null;
	this.parentid = null;
	this.userid = null;
	this.name = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getProductCategoryID = _getProductCategoryID;
	this._getProductCategoryParentID = _getProductCategoryParentID;
	this._getProductCategoryUserID = _getProductCategoryUserID;
	this._getProductCategoryName = _getProductCategoryName;
	this._getProductCategoryDatecreated = _getProductCategoryDatecreated;
	this._getProductCategoryDatemodified = _getProductCategoryDatemodified;

	this._setProductCategoryID = _setProductCategoryID;
	this._setProductCategoryParentID = _setProductCategoryParentID;
	this._setProductCategoryUserID = _setProductCategoryUserID;
	this._setProductCategoryName = _setProductCategoryName;
	this._setProductCategoryDatecreated = _setProductCategoryDatecreated;
	this._setProductCategoryDatemodified = _setProductCategoryDatemodified;

	this._getAllProductCategory = _getAllProductCategory;
	this._getAllProductCategorysByDealer = _getAllProductCategorysByDealer;
	this._getAllProductCategorysByService = _getAllProductCategorysByService;
	this._getAllProductCategorysByCustomer = _getAllProductCategorysByCustomer;
	this._getAllProductCategorysSoldInShop = _getAllProductCategorysSoldInShop;
	this._loadProductCategory = _loadProductCategory;
}


function _getProductCategoryID()			{ return this.id; }
function _getProductCategoryParentID() 		{ return this.parentid; }
function _getProductCategoryUserID()		{ return this.userid; }
function _getProductCategoryName()			{ return this.name; }
function _getProductCategoryDatecreated()	{ return this.datecreated; }
function _getProductCategoryDatemodified()	{ return this.datemodified; }

function _setProductCategoryID(value)			{ this.id = value; }
function _setProductCategoryParentID(value)		{ this.parentid = value; }
function _setProductCategoryUserID(value)		{ this.userid = value; }
function _setProductCategoryName(value)			{ this.name = value; }
function _setProductCategoryDatecreated(value)	{ this.datecreated = value; }
function _setProductCategoryDatemodified(value)	{ this.datemodified = value; }


function _getAllProductCategory() {

	var strSQL = "SELECT product.id, product.parentid, yma_productcategory.name as parent, product.name FROM yma_productcategory AS product INNER JOIN yma_productcategory ON product.parentid = yma_productcategory.id ORDER BY yma_productcategory.name, product.name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllProductCategorysByDealer(dealerid) {
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


function _getAllProductCategorysByService(servicecentreid) {
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


function _getAllProductCategorysByCustomer(customerid) {
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

function _getAllProductCategorysSoldInShop() {

	var strSQL = "SELECT  " + 
		"	count(ymashop_product.id) as 'products',  " + 
		"	category.id,  " + 
		"	yma_productcategory.name as 'parent',  " + 
		"	category.name  " + 
		"FROM  " + 
		"	yma_productcategory AS category  " + 
		"INNER JOIN  " + 
		"	yma_productcategory ON  " + 
		"	yma_productcategory.id = category.parentid " + 
		"INNER JOIN  " + 
		"	ymashop_product ON  " + 
		"	ymashop_product.categoryid = category.id  " + 
		"INNER JOIN   " + 
		"	ymashop_inventory ON   " + 
		"	ymashop_inventory.productid = ymashop_product.id  " + 
		"WHERE 1 = 1  " + 
		"	AND ymashop_product.status != 0  " + 
		"	AND ymashop_inventory.instock != 0  " + 
		"GROUP BY  " + 
		"	category.id,  " + 
		"	yma_productcategory.name,  " + 
		"	category.name  " + 
		"ORDER BY " + 
		"	category.id";
// Response.Write(strSQL);

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}



function _loadProductCategory(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_productcategory WHERE id = " + id;
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