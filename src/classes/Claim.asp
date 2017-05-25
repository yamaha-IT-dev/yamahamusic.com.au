<%

function Claim() {

	this.id = 0;
	this.claimid = 0;
	this.serviceid = 0;
	this.userid = 0;
	this.status = new String();
	this.rctiflag = 0;
	this.creditflag = 0;
	this.oldmodelflag = 0;

	this.claimnumber = new String();
	this.invoicenumber = new String();
	this.rctinumber = new String();
	this.dealercode = new String();
	this.vendorcode = new String();
	this.extcomment = new String();
	this.modelnumber = new String();
	this.serialnumber = new String();
	this.retailername = new String();
	this.faultreport = new String();
	this.repairreport = new String();
	this.repaircode = new String();
	this.comment = new String();
	this.labourcharge = new String('0.00');
	this.partscharge = new String('0.00');
	this.gstcharge = new String('');
	this.totalcharge = new String('0.00');

	this.custname = new String();
	this.custaddress = new String();
	this.custsuburb = new String();
	this.custstate = new String();
	this.custpostcode = new String();
	this.custphone = new String();

	this.claimnote = new String();
	this.warrantyauth = new String();

	this.dateinvoice = new String();
	this.datepurchased = new String();
	this.datereceived = new String();
	this.datecompleted = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getClaimID = 				function() { return this.id; }
	this._getClaimServiceID = 		function() { return this.serviceid; }
	this._getClaimUserID = 			function() { return this.userid; }
	this._getClaimStatus = 			function() { return this.status; }
	this._getClaimRCTIflag = 		function() { return this.rctiflag; }
	this._getClaimCreditflag = 		function() { return this.creditflag; }
	this._getClaimOldmodelflag = 	function() { return this.oldmodelflag; }
	this._getClaimNumber = 			function() { return this.claimnumber; }
	this._getClaimInvoicenumber = 	function() { return this.invoicenumber; }
	this._getClaimRctinumber = 		function() { return this.rctinumber; }
	this._getClaimDealercode = 		function() { return this.dealercode; }
	this._getClaimVendorcode = 		function() { return this.vendorcode; }
	this._getClaimExtcomment = 		function() { return this.extcomment; }
	this._getClaimModelnumber = 	function() { return this.modelnumber; }
	this._getClaimSerialnumber = 	function() { return this.serialnumber; }
	this._getClaimRetailername = 	function() { return this.retailername; }
	this._getClaimFaultreport = 	function() { return this.faultreport; }
	this._getClaimRepairreport = 	function() { return this.repairreport; }
	this._getClaimRepaircode = 		function() { return this.repaircode; }
	this._getClaimComment = 		function() { return this.comment; }
	this._getClaimLabourcharge = 	function() { return this.labourcharge; }
	this._getClaimPartscharge = 	function() { return this.partscharge; }
	this._getClaimGSTCharge = 		function() { return this.gstcharge; }
	this._getClaimTotalCharge = 	function() { return this.totalcharge; }
	this._getClaimCustname = 		function() { return this.custname; }
	this._getClaimCustaddress = 	function() { return this.custaddress; }
	this._getClaimCustsuburb = 		function() { return this.custsuburb; }
	this._getClaimCuststate = 		function() { return this.custstate; }
	this._getClaimCustpostcode = 	function() { return this.custpostcode; }
	this._getClaimCustphone = 		function() { return this.custphone; }
	this._getClaimNote = 			function() { return this.claimnote; }
	this._getClaimWarrantyauth = 	function() { return this.warrantyauth; }
	this._getClaimDateinvoice = 	function() { return this.dateinvoice; }
	this._getClaimDatepurchased = 	function() { return this.datepurchased; }
	this._getClaimDatereceived = 	function() { return this.datereceived; }
	this._getClaimDatecompleted = 	function() { return this.datecompleted; }
	this._getClaimDatecreated = 	function() { return this.datecreated; }
	this._getClaimDatemodified = 	function() { return this.datemodified; }

	this._setClaimID = 				function(value) { this.id = value; }
	this._setClaimServiceID = 		function(value) { this.serviceid = value; }
	this._setClaimUserID = 			function(value) { this.userid = value; }
	this._setClaimStatus = 			function(value) { this.status = value; }
	this._setClaimRCTIflag = 		function(value) { this.rctiflag = value; }
	this._setClaimCreditflag = 		function(value) { this.creditflag = value; }
	this._setClaimOldmodelflag = 	function(value) { this.oldmodelflag = value; }
	this._setClaimNumber = 			function(value) { this.claimnumber = value; }
	this._setClaimInvoicenumber = 	function(value) { this.invoicenumber = value; }
	this._setClaimRctinumber = 		function(value) { this.rctinumber = value; }
	this._setClaimDealercode = 		function(value) { this.dealercode = value; }
	this._setClaimVendorcode = 		function(value) { this.vendorcode = value; }
	this._setClaimExtcomment = 		function(value) { this.extcomment = value; }
	this._setClaimModelnumber = 	function(value) { this.modelnumber = value; }
	this._setClaimSerialnumber = 	function(value) { this.serialnumber = value; }
	this._setClaimRetailername = 	function(value) { this.retailername = value; }
	this._setClaimFaultreport = 	function(value) { this.faultreport = value; }
	this._setClaimRepairreport = 	function(value) { this.repairreport = value; }
	this._setClaimRepaircode = 		function(value) { this.repaircode = value; }
	this._setClaimComment = 		function(value) { this.comment = value; }
	this._setClaimLabourcharge = 	function(value) { this.labourcharge = value; }
	this._setClaimPartscharge = 	function(value) { this.partscharge = value; }
	this._setClaimGSTCharge = 		function(value) { this.gstcharge = value; }
	this._setClaimTotalCharge = 	function(value) { this.totalcharge = value; }
	this._setClaimCustname = 		function(value) { this.custname = value; }
	this._setClaimCustaddress = 	function(value) { this.custaddress = value; }
	this._setClaimCustsuburb = 		function(value) { this.custsuburb = value; }
	this._setClaimCuststate = 		function(value) { this.custstate = value; }
	this._setClaimCustpostcode = 	function(value) { this.custpostcode = value; }
	this._setClaimCustphone = 		function(value) { this.custphone = value; }
	this._setClaimNote = 			function(value) { this.claimnote = value; }
	this._setClaimWarrantyauth = 	function(value) { this.warrantyauth = value; }
	this._setClaimDateinvoice = 	function(value) { this.dateinvoice = value; }
	this._setClaimDatepurchased = 	function(value) { this.datepurchased = value; }
	this._setClaimDatereceived = 	function(value) { this.datereceived = value; }
	this._setClaimDatecompleted = 	function(value) { this.datecompleted = value; }
	this._setClaimDatecreated = 	function(value) { this.datecreated = value; }
	this._setClaimDatemodified = 	function(value) { this.datemodified = value; }

	this._getAllClaims = _getAllClaims;
	this._getAllClaims2011 = _getAllClaims2011;
	this._getAllClaims2012 = _getAllClaims2012;
	this._getAllClaims2013 = _getAllClaims2013;
	this._getAllClaimsLight = _getAllClaimsLight;
	this._getAllClaimsOverdue = _getAllClaimsOverdue;
	this._getAllClaimsByServiceCentre = _getAllClaimsByServiceCentre;
	this._getClaimsForExport = _getClaimsForExport;
	this._getClaimsForExportByDateModified = _getClaimsForExportByDateModified;
	this._tagClaimsAsExported = _tagClaimsAsExported;

	this._loadClaim = _loadClaim;
	this._addClaim = _addClaim;
	this._saveClaim = _saveClaim;
	this._deleteClaim = _deleteClaim;
	this._closeClaim = _closeClaim;

	this._generateClaimNumber = _generateClaimNumber;

	this._isValid = _isValid;
}

function _getAllClaims() {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE year(datecreated) = '2010' ORDER BY datecreated DESC, datemodified DESC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
		
		Response.Write("<h2 align=center>" + rs.RecordCount + " records found</h2>");	
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

function _getAllClaims2011() {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE year(datecreated) = '2011' ORDER BY datecreated DESC, datemodified DESC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
			
		Response.Write("<h2 align=center>" + rs.RecordCount + " records found</h2>");	
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

function _getAllClaims2012() {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE year(datecreated) = '2012' ORDER BY datecreated DESC, datemodified DESC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
			
		Response.Write("<h2 align=center>" + rs.RecordCount + " records found</h2>");	
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

function _getAllClaims2013() {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE year(datecreated) = '2013' ORDER BY datecreated DESC, datemodified DESC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
			
		Response.Write("<h2 align=center>" + rs.RecordCount + " records found</h2>");
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

function _getAllClaimsLight() {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,getdate()) as elapsed, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE datecreated > '2010-01-01' AND status = 'OPEN' ORDER BY datecreated DESC, datemodified DESC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
			
		Response.Write("<h2 align=center>" + rs.RecordCount + " records found</h2>");	
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

function _getAllClaimsOverdue() {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,getdate()) as elapsed, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE DATEDIFF(dd,datereceived,getdate()) > 20 AND datecreated > '2010-01-01' AND status = 'OPEN' ORDER BY datecreated DESC, datemodified DESC";

	try {
		var rs = Server.CreateObject("ADODB.Recordset");
			rs.Open(strSQL, GBL_CONN_ALTPROVIDER, 3, 3);
			
		Response.Write("<h2 align=center>" + rs.RecordCount + " records found</h2>");
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

function _getAllClaimsByServiceCentre(serviceid) {

	strSQL = "SELECT yma_serviceclaim.*, DATEDIFF(dd,datereceived,datecompleted) as repairdays FROM yma_serviceclaim WHERE serviceid = " + serviceid + " ORDER BY datecreated DESC";

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


function _getClaimsForExport(serviceid, datestart, dateend) {

	strSERVICE = serviceid[0]==0?"":"AND serviceid IN (" + serviceid + ")";
	strDATESTART = new Date(datestart).formatDate("Y-m-d");
	strDATEEND = new Date(dateend).formatDate("Y-m-d");
	strSQL = "SELECT * FROM yma_serviceclaim WHERE 1=1 " + strSERVICE + " AND status = 'CLOSED' AND claimnumber != '' AND DATEDIFF(day, '" + strDATESTART + "', datecreated) > 0 AND DATEDIFF(day, '" + strDATEEND + "', datecreated) < 0"

// Response.Write(strSQL);

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


function _getClaimsForExportByDateModified(serviceid, datemodified) {

	strSERVICE = serviceid[0]==0?"":"AND serviceid IN (" + serviceid + ")";
	strDATEMOD = new Date(datemodified).formatDate("Y-m-d");

	strSQL = "SELECT * FROM yma_serviceclaim WHERE 1=1 " + strSERVICE + " AND status = 'CLOSED' AND claimnumber != '' AND DATEDIFF(day, '" + strDATEMOD + "', datemodified) = 0"

// Response.Write(strSQL);

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


function _tagClaimsAsExported(serviceid, datestart, dateend) {

	strSERVICE = serviceid[0]==0?"":"AND serviceid IN (" + serviceid + ")";
	strDATESTART = new Date(datestart).formatDate("Y-m-d");
	strDATEEND = new Date(dateend).formatDate("Y-m-d");
	strDATESTAMP = new Date().formatDate("Ymd");

	strSQL = "UPDATE yma_serviceclaim SET status = 'BATCH_" + strDATESTAMP + "' WHERE 1=1 " + strSERVICE + " AND status = 'CLOSED' AND DATEDIFF(day, '" + strDATESTART + "', datecreated) > 0 AND DATEDIFF(day, '" + strDATEEND + "', datecreated) < 0"

// Response.Write(strSQL);

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


function _loadClaim(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_serviceclaim WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));

			this.serviceid = parseInt(rs("serviceid"));
			this.userid = parseInt(rs("userid"));
			this.status = new String(rs("status"));
			this.rctiflag = parseInt(rs("rctiflag"));
			this.creditflag = parseInt(rs("creditflag"));
			this.oldmodelflag = parseInt(rs("oldmodelflag"));

			this.claimnumber = new String(rs("claimnumber"));
			this.invoicenumber = new String(rs("invoicenumber"));
			this.rctinumber = new String(rs("rctinumber"));
			this.dealercode = new String(rs("dealercode"));
			this.vendorcode = new String(rs("vendorcode"));
			this.extcomment = new String(rs("extcomment"));
			this.modelnumber = new String(rs("modelnumber"));
			this.serialnumber = new String(rs("serialnumber"));
			this.retailername = new String(rs("retailername"));
			this.faultreport = new String(rs("faultreport"));
			this.repairreport = new String(rs("repairreport"));
			this.repaircode = new String(rs("repaircode"));
			this.comment = new String(rs("comment"));
			this.labourcharge = parseFloat(rs("labourcharge")).toFixed(2);
			this.partscharge = parseFloat(rs("partscharge")).toFixed(2);
			this.gstcharge = parseFloat(rs("gstcharge")).toFixed(2);
			this.totalcharge = parseFloat(rs("totalcharge")).toFixed(2);

			this.custname = new String(rs("custname"));
			this.custaddress = new String(rs("custaddress"));
			this.custsuburb = new String(rs("custsuburb"));
			this.custstate = new String(rs("custstate"));
			this.custpostcode = new String(rs("custpostcode"));
			this.custphone = new String(rs("custphone"));

			this.claimnote = new String(rs("claimnote"));
			this.warrantyauth = new String(rs("warrantyauth"));

			this.dateinvoice = new String(rs("dateinvoice"));
			this.datepurchased = new String(rs("datepurchased"));
			this.datereceived = new String(rs("datereceived"));
			this.datecompleted = new String(rs("datecompleted"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addClaim() {
	var insertParams = "userid, " +
					   "serviceid, " +
					   "status, " +
					   "rctiflag, " +
					   "creditflag, " +
					   "oldmodelflag, " +
					   "claimnumber, " +
					   "invoicenumber, " +
					   "rctinumber, " +
					   "dealercode, " +
					   "vendorcode, " +
					   "extcomment, " +
					   "modelnumber, " +
					   "serialnumber, " +
					   "retailername, " +
					   "faultreport, " +
					   "repairreport, " +
					   "repaircode, " +
					   "comment, " +
					   "labourcharge, " +
					   "partscharge , " +
					   "gstcharge, " +
					   "totalcharge, " +
					   "custname, " +
					   "custaddress, " +
					   "custsuburb, " +
					   "custstate, " +
					   "custpostcode, " +
					   "custphone, " +
					   "claimnote, " +
					   "warrantyauth, " +
					   "dateinvoice, " +
					   "datepurchased, " +
					   "datereceived, " +
					   "datecompleted, " +
					   "datecreated";

	var insertValues = this.userid + ", " +
					   this.serviceid + ", " +
					   "'" + this.status + "', " +
					   this.rctiflag + ", " +
					   this.creditflag + ", " +
					   this.oldmodelflag + ", " +
					   "'" + this.claimnumber + "', " +
					   "'" + this.invoicenumber + "', " +
					   "'" + this.rctinumber + "', " +
					   "'" + this.dealercode + "', " +
					   "'" + this.vendorcode + "', " +
					   "'" + this.extcomment + "', " +
					   "'" + this.modelnumber + "', " +
					   "'" + this.serialnumber + "', " +
					   "'" + this.retailername + "', " +
					   "'" + this.faultreport + "', " +
					   "'" + this.repairreport + "', " +
					   "'" + this.repaircode + "', " +
					   "'" + this.comment + "', " +
					   "'" + this.labourcharge + "', " +
					   "'" + this.partscharge + "', " +
					   "'" + this.gstcharge + "', " +
					   "'" + this.totalcharge + "', " +
					   "'" + this.custname + "', " +
					   "'" + this.custaddress + "', " +
					   "'" + this.custsuburb + "', " +
					   "'" + this.custstate + "', " +
					   "'" + this.custpostcode + "', " +
					   "'" + this.custphone + "', " +
					   "'" + this.claimnote + "', " +
					   "'" + this.warrantyauth + "', " +
					   "'" + this.dateinvoice + "', " +
					   "'" + this.datepurchased + "', " +
					   "'" + this.datereceived + "', " +
					   "'" + this.datecompleted + "', " +
					   "getdate()";

	try {
		var strSQL = "INSERT INTO yma_serviceclaim (" + insertParams + ") VALUES (" + insertValues + ")";
// Response.Write(strSQL + "<br/>");
		GBL_CONN_ALTPROVIDER.Execute(strSQL);
	} catch(e) {
		throw e;
		// Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
		//Response.Flush();
		//return;
	}

	var rs = GBL_CONN_ALTPROVIDER.Execute("SELECT @@IDENTITY");
		this.id = rs.Fields(0).value;

	rs.close();
	rs = null;
	return this.id;
}


function _saveClaim() {
	var updateStr = "userid = " + this.userid + ", " +
				    "serviceid = " + this.serviceid + ", " +
				    "status = '" + this.status + "', " +
				    "rctiflag = " + this.rctiflag + ", " +
				    "creditflag = " + this.creditflag + ", " +
				    "oldmodelflag = " + this.oldmodelflag + ", " +
				    "claimnumber = '" + this.claimnumber + "', " +
				    "invoicenumber = '" + this.invoicenumber + "', " +
				    "rctinumber = '" + this.rctinumber + "', " +
				    "dealercode = '" + this.dealercode + "', " +
				    "vendorcode = '" + this.vendorcode + "', " +
				    "extcomment = '" + this.extcomment + "', " +
				    "modelnumber = '" + this.modelnumber + "', " +
				    "serialnumber = '" + this.serialnumber + "', " +
				    "retailername = '" + this.retailername + "', " +
				    "faultreport = '" + this.faultreport + "', " +
				    "repairreport = '" + this.repairreport + "', " +
				    "repaircode = '" + this.repaircode + "', " +
				    "comment = '" + this.comment + "', " +
				    "labourcharge = '" + this.labourcharge + "', " +
				    "partscharge = '" + this.partscharge + "', " +
				    "gstcharge = '" + this.gstcharge + "', " +
				    "totalcharge = '" + this.totalcharge + "', " +
				    "custname = '" + this.custname + "', " +
				    "custaddress = '" + this.custaddress + "', " +
				    "custsuburb = '" + this.custsuburb + "', " +
				    "custstate = '" + this.custstate + "', " +
				    "custpostcode = '" + this.custpostcode + "', " +
				    "custphone = '" + this.custphone + "', " +
				    "claimnote = '" + this.claimnote + "', " +
				    "warrantyauth = '" + this.warrantyauth + "', " +
				    "dateinvoice = '" + this.dateinvoice + "', " +
				    "datepurchased = '" + this.datepurchased + "', " +
				    "datereceived = '" + this.datereceived + "', " +
				    "datecompleted = '" + this.datecompleted + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_serviceclaim SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _closeClaim()
{
	var updateStr = "userid = " + this.userid + ", " +
				    "status = '" + this.status + "', " +
				    "rctiflag = 1, " +
				    "repaircode = '" + this.repaircode + "', " +
				    "claimnumber = '" + this.claimnumber + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_serviceclaim SET " + updateStr + " WHERE id = " + this.id;
		//Response.Write(strSQL);
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _deleteClaim() {
	try {
		var strSQL = "DELETE FROM yma_serviceclaim WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _generateClaimNumber()
{
	var strClaimNumber = "YMA/" + this.invoicenumber;
	if (this.rctiflag == 1)
	{
		strClaimNumber = "YMA/" + this.rctinumber;
	}
	return strClaimNumber;
}


function _isValid() {

	strErr = new String();

	if ((!this.invoicenumber && this.invoicenumber.length == 0 || this.invoicenumber.indexOf("undefined") == 0 || this.invoicenumber.indexOf("null") == 0) &&
		(!this.rctinumber && this.rctinumber.length == 0 || this.rctinumber.indexOf("undefined") == 0 || this.rctinumber.indexOf("null") == 0)) {
		strErr += " - You must provide a valid invoice or rtci number<br/>";
	}

	if (!this.modelnumber && this.modelnumber.length == 0 || this.modelnumber.indexOf("undefined") == 0 || this.modelnumber.indexOf("null") == 0) {
		strErr += " - You must provide the model number<br/>";
	}
	if (!this.serialnumber && this.serialnumber.length == 0 || this.serialnumber.indexOf("undefined") == 0 || this.serialnumber.indexOf("null") == 0) {
		strErr += " - You must provide the serial number<br/>";
	}

	if (this.faultreport && this.faultreport.length == 0 || this.faultreport.indexOf("undefined") == 0 || this.faultreport.indexOf("null") == 0) {
		strErr += " - You must provide a fault report<br/>";
	}
	if (this.repairreport && this.repairreport.length == 0 || this.repairreport.indexOf("undefined") == 0 || this.repairreport.indexOf("null") == 0) {
		strErr += " - You must provide a repair report<br/>";
	}

//	var re = /^\$?([0-9]*\.[0-9]+|[0-9]+)/ig;
//	var re = /^\$?[0-9\,]+(\.\d{2})?$/ig;
	var re = /^\d{1,3}(,?\d{1,3})*\.?(\d{1,2})?$/ig;
// Response.Write("match = " + this.Labourcharge().match(re) + "<br/>")
	/*
		Regular Expressions are a bit of a dark art, I'm not exactly sure
		what's going on down here but I'm using some expressions that I found
		to make sure that the charges submitted are formatted as $00.00
	*/
	var strLCH = new String(this.labourcharge);
	if (strLCH.length == 0 || strLCH.indexOf("undefined") == 0) {
		strErr += " - You must indicate the labour charge<br/>";
	} else {
		//if (isNaN(parseFloat(this.Labourcharge().match(re)))) {
		if (! RegExp(/^\$?[0-9\,]+(\.\d{2})?$/).test(strLCH.replace(/^\s+|\s+$/g, ""))) {
			strErr += " - Your labour charge must be in the form 00.00<br/>";
		}
	}
	var strPCH = new String(this.partscharge);
	if (strPCH.length == 0 || strPCH.indexOf("undefined") == 0) {
		strErr += " - You must indicate the parts charge<br/>";
	} else {
		//if (isNaN(parseFloat(this.Partscharge().match(re)))) {
		if (! RegExp(/^\$?[0-9\,]+(\.\d{2})?$/).test(strPCH.replace(/^\s+|\s+$/g, ""))) {
			strErr += " - Your parts charge must be in the form 00.00<br/>";
		}
	}
/*
	var strGST = new String(this.GSTCharge());
	if (strGST.length == 0 || strGST.indexOf("undefined") == 0) {
		strErr += " - You must indicate the GST charge<br/>";
	} else {
		//if (isNaN(parseFloat(this.GSTCharge().match(re)))) {
		if (! RegExp(/^\$?[0-9\,]+(\.\d{2})?$/).test(strGST.replace(/^\s+|\s+$/g, ""))) {
			strErr += " - Your GST charge must be in the form 00.00<br/>";
		}
	}
*/
	if (!strContentType.toLowerCase() == "multipart/form-data") {

		if (new Number(Request("purDay")) == 0 || new Number(Request("purMonth")) == 0 || new Number(Request("purYear")) == 0) {
			strErr += " - Please check the date of purchase - you must fill in all the fields<br/>";
		}
		if (!GBLValidateDate(new Number(Request("purYear")), new Number(Request("purMonth")), new Number(Request("purDay")))) {
			strErr += " - Please check the date of purchase - your date isn't right<br/>";
		}
		if (new Number(Request("recDay")) == 0 || new Number(Request("recMonth")) == 0 || new Number(Request("recYear")) == 0) {
			strErr += " - Please check the date received - you must fill in all the fields<br/>";
		}
		if (!GBLValidateDate(new Number(Request("recYear")), new Number(Request("recMonth")), new Number(Request("recDay")))) {
			strErr += " - Please check the date received - your date isn't right<br/>";
		}
		if (new Number(Request("compDay")) == 0 || new Number(Request("compMonth")) == 0 || new Number(Request("compYear")) == 0) {
			strErr += " - Please check the date of completion - you must fill in all the fields<br/>";
		}
		if (!GBLValidateDate(new Number(Request("compYear")), new Number(Request("compMonth")), new Number(Request("compDay")))) {
			strErr += " - Please check the date of completion - your date isn't right<br/>";
		}

		if (this.custstate && this.custstate.length == 0 || this.custstate.indexOf("undefined") == 0 || this.custstate.indexOf("null") == 0) {
			strErr += " - You must provide the customers state<br/>";
		}

	} else {

		if (this.dateinvoice.indexOf("NaN") >= 0) {
			strErr += " - Please check your invoice date - it must be valid (dd/mm/yyyy) and can not be blank<br/>";
		}
		if (this.datepurchased.indexOf("NaN") >= 0) {
			strErr += " - Please check your date of purchase - it must be valid (dd/mm/yyyy) and can not be blank<br/>";
		}
		if (this.datereceived.indexOf("NaN") >= 0) {
			strErr += " - Please check your date received - it must be valid (dd/mm/yyyy) and can not be blank<br/>";
		}
		if (this.datecompleted.indexOf("NaN") >= 0) {
			strErr += " - Please check your date completed - it must be valid (dd/mm/yyyy) and can not be blank<br/>";
		}
	}

	if (!this.custname && this.custname.length == 0 || this.custname.indexOf("undefined") == 0 || this.custstate.indexOf("null") == 0) {
		strErr += " - You must provide the customers full name<br/>";
	}
	if (!this.custaddress && this.custaddress.length == 0 || this.custaddress.indexOf("undefined") == 0 || this.custaddress.indexOf("null") == 0) {
		strErr += " - You must provide the customers address<br/>";
	}
	if (!this.custsuburb && this.custsuburb.length == 0 || this.custsuburb.indexOf("undefined") == 0 || this.custsuburb.indexOf("null") == 0) {
		strErr += " - You must provide the customers suburb<br/>";
	}
	if (!this.custpostcode && this.custpostcode.length == 0 || this.custpostcode.indexOf("undefined") == 0 || this.custpostcode.indexOf("null") == 0) {
		strErr += " - You must provide the customers postcode<br/>";
	}

	return strErr;
}






%>