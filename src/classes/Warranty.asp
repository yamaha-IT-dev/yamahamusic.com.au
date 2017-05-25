<% 

function Warranty() {

	this.id = null;
	this.customerid = null;
	this.typeid = 0;
	this.number = null;
	this.modelnumber = new String();
	this.serialnumber = new String();
	this.purchaseplace = new String();
	this.purchaseprice = new String();
	this.purchasedate = new String();
	this.datecreated = new String();
	this.comments = new String();
	this.reasons = new String();
	this.terms = 0;

	this._getWarrantyID = _getWarrantyID;
	this._getWarrantyCustomerID = _getWarrantyCustomerID;
	this._getWarrantyTypeID = _getWarrantyTypeID;
	this._getWarrantyNumber = _getWarrantyNumber;
	this._getWarrantyModelnumber = _getWarrantyModelnumber;
	this._getWarrantySerialnumber = _getWarrantySerialnumber;
	this._getWarrantyPurchaseplace = _getWarrantyPurchaseplace;
	this._getWarrantyPurchaseprice = _getWarrantyPurchaseprice;
	this._getWarrantyPurchasedate = _getWarrantyPurchasedate;
	this._getWarrantyDatecreated = _getWarrantyDatecreated;
	this._getWarrantyComments = _getWarrantyComments;
	this._getWarrantyReasons = _getWarrantyReasons;
	this._getWarrantyTerms = _getWarrantyTerms;

	this._setWarrantyID = _setWarrantyID;
	this._setWarrantyCustomerID = _setWarrantyCustomerID;
	this._setWarrantyTypeID = _setWarrantyTypeID;
	this._setWarrantyNumber = _setWarrantyNumber;
	this._setWarrantyModelnumber = _setWarrantyModelnumber;
	this._setWarrantySerialnumber = _setWarrantySerialnumber;
	this._setWarrantyPurchaseplace = _setWarrantyPurchaseplace;
	this._setWarrantyPurchaseprice = _setWarrantyPurchaseprice;
	this._setWarrantyPurchasedate = _setWarrantyPurchasedate;
	this._setWarrantyDatecreated = _setWarrantyDatecreated;
	this._setWarrantyComments = _setWarrantyComments;
	this._setWarrantyReasons = _setWarrantyReasons;
	this._setWarrantyTerms = _setWarrantyTerms;

	this._getAllWarrantyByCustomer = _getAllWarrantyByCustomer;
	this._hasCustomerRecordedWarrantyBefore = _hasCustomerRecordedWarrantyBefore;

	this._loadWarranty = _loadWarranty;
	this._addWarranty = _addWarranty;
	this._saveWarranty = _saveWarranty;
	this._deleteWarranty = _deleteWarranty;
}


function _getWarrantyID()				{ return this.id; }
function _getWarrantyCustomerID()		{ return this.customerid; }
function _getWarrantyTypeID()			{ return this.typeid; }
function _getWarrantyNumber()			{ return this.number; }
function _getWarrantyModelnumber()		{ return this.modelnumber; }
function _getWarrantySerialnumber()		{ return this.serialnumber; }
function _getWarrantyPurchaseplace()	{ return this.purchaseplace; }
function _getWarrantyPurchaseprice()	{ return this.purchaseprice; }
function _getWarrantyPurchasedate()		{ return this.purchasedate; }
function _getWarrantyDatecreated()		{ return this.datecreated; }
function _getWarrantyComments()			{ return this.comments; }
function _getWarrantyReasons()			{ return this.reasons; }
function _getWarrantyTerms()			{ return this.terms; }

function _setWarrantyID(value)				{ this.id = value; }
function _setWarrantyCustomerID(value)		{ this.customerid = value; }
function _setWarrantyTypeID(value)			{ this.typeid = value; }
function _setWarrantyNumber(value)			{ this.number = value; }
function _setWarrantyModelnumber(value)		{ this.modelnumber = value; }
function _setWarrantySerialnumber(value)	{ this.serialnumber = value; }
function _setWarrantyPurchaseplace(value)	{ this.purchaseplace = value; }
function _setWarrantyPurchaseprice(value)	{ this.purchaseprice = value; }
function _setWarrantyPurchasedate(value)	{ this.purchasedate = value; }
function _setWarrantyDatecreated(value)		{ this.datecreated = value; }
function _setWarrantyComments(value)		{ this.comments = value; }
function _setWarrantyReasons(value)			{ this.reasons = value; }
function _setWarrantyTerms(value)			{ this.terms = value; }


function _getAllWarrantyByCustomer(customerid) {

	var strSQL = "SELECT * FROM yma_warranty WHERE customerid = " + customerid + " AND warrantytypeid IN (1, 2, 3, 6, 8, 9, 12, 13) ORDER BY purchasedate DESC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 1, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}




function _loadWarranty(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_warranty WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.customerid = null;
			this.typeid = null;
			this.number = null;
			this.modelnumber = new String(rs("modelnumber"));
			this.serialnumber = new String(rs("serialnumber"));
			this.purchaseplace = new String(rs("purchaseplace"));
			this.purchaseprice = new String(rs("purchaseprice"));
			this.purchasedate = new String(rs("purchasedate"));
			this.comments = new String(rs("comments"));
			this.reasons = new String(rs("reasons"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addWarranty() {
	var insertStr = "INSERT INTO yma_warranty SELECT " +
						this.customerid + " as customerid, " +
						this.typeid + "	as warrantytypeid, " +
						"	MAX(number)+1, " +
						"'" + this.modelnumber + "' as modelnumber, " +
						"'" + this.serialnumber + "' as serialnumber, " +
						"'" + this.purchaseplace + "' as purchaseplace, " +
						"'" + this.purchaseprice + "' as purchaseprice, " +
						"'" + this.purchasedate + "' as purchasedate, " +
						"getdate() as datecreated, " +
						"'" + this.comments + "' as comments, " +
						"'" + this.reasons + "' as reasons" +
					" FROM yma_warranty WHERE warrantytypeid = " + this.typeid;
	try {
		GBL_CONN.Execute(insertStr);
	} catch(e) {
		Response.Write("Attempted Insert : " + e.description + "<br>" + insertStr);
		Response.Flush();
		//return;
	}
	
	var rs = GBL_CONN.Execute("SELECT @@IDENTITY");
		this.id = rs.Fields(0).value;

	rs.close();
	rs = null;

	return this.id;
}


function _saveWarranty() {
	var updateStr = "customerid = " + this.customerid + ", " +
					"warrantytypeid = " + this.warrantytypeid + ", " +
					"number = " + this.number + ", " +
					"modelnumber = '" + this.modelnumber + "', " +
					"serialnumber = '" + this.serialnumber + "', " +
					"purchaseplace = '" + this.purchaseplace + "', " +
					"purchaseprice = '" + this.purchaseprice + "', " +
					"purchasedate = '" + this.purchasedate + "', " +
					"datemodified = GETDATE()"  + ", "
					"comments = '" + this.comments + "', " + 
					"reasons = '" + this.reasons + "'";

	try {
		var strSQL = "UPDATE yma_warranty SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteWarranty() {
	try {
		var strSQL = "DELETE FROM yma_warranty WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _hasCustomerRecordedWarrantyBefore(customerid, warrantytypeid) {

	var has_warranty_thingied_before = 0;
	var strSQL = "SELECT count(id) FROM yma_warranty WHERE warrantytypeid = " + warrantytypeid + " AND customerid = " + customerid;

	if (!isNaN(customerid))
	{
		try {
	
			var rs = GBL_CONN.Execute(strSQL);
			if (rs && !rs.EOF) {
			
				has_warranty_thingied_before = new Number(rs.Fields(0).value);
			}
			rs.close();
			rs = null;
	
		} catch(e) {
			Response.Write("Attempted check : " + e.description + "<br>" + strSQL);
			Response.Flush();
			//return;
		}
	}
	return has_warranty_thingied_before;
}



%>