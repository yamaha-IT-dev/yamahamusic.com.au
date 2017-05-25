<% 

function Student() {

	this.id = 0;
	this.leadid = null;
	this.customerid = null;
	this.name = new String();
	this.schoollevel = new String();
	this.prevedu = new String();
	this.dateofbirth = new String();

	this._getStudentID = _getStudentID;
	this._getStudentLeadID = _getStudentLeadID;
	this._getStudentCustomerID = _getStudentCustomerID;
	this._getStudentName = _getStudentName;
	this._getStudentSchoolLevel = _getStudentSchoolLevel;
	this._getStudentPrevEdu = _getStudentPrevEdu;
	this._getStudentDateofbirth = _getStudentDateofbirth;

	this._setStudentID = _setStudentID;
	this._setStudentLeadID = _setStudentLeadID;
	this._setStudentCustomerID = _setStudentCustomerID;
	this._setStudentName = _setStudentName;
	this._setStudentSchoolLevel = _setStudentSchoolLevel;
	this._setStudentPrevEdu = _setStudentPrevEdu;
	this._setStudentDateofbirth = _setStudentDateofbirth;

	this._getAllStudentsByCustomer = _getAllStudentsByCustomer;

	this._loadStudent = _loadStudent;
	this._addStudent = _addStudent;
	this._saveStudent = _saveStudent;
	this._deleteStudent = _deleteStudent;

}


function _getStudentID()			{ return this.id; }
function _getStudentLeadID()		{ return this.leadid; }
function _getStudentCustomerID()	{ return this.customerid; }
function _getStudentName()			{ return this.name; }
function _getStudentSchoolLevel()	{ return this.schoollevel; }
function _getStudentPrevEdu()		{ return this.prevedu; }
function _getStudentDateofbirth()	{ return this.dateofbirth; }

function _setStudentID(value)			{ this.id = value; }
function _setStudentLeadID(value)		{ this.leadid = value; }
function _setStudentCustomerID(value)	{ this.customerid = value; }
function _setStudentName(value)			{ this.name = value; }
function _setStudentSchoolLevel(value)	{ this.schoollevel = value; }
function _setStudentPrevEdu(value)		{ this.prevedu = value; }
function _setStudentDateofbirth(value)	{ this.dateofbirth = value; }


function _getAllStudentsByCustomer(customerid) {

	var strSQL = "SELECT * FROM ymec_lead_student WHERE customerid = " + customerid + " ORDER BY name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}




function _loadStudent(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymec_lead_student WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.leadid = new Number(rs("leadid"));
			this.customerid = new Number(rs("customerid"));
			this.name = new String(rs("name"));
			this.schoollevel = new String(rs("schoollevel"));
			this.prevedu = new String(rs("prevedu"));
			this.dateofbirth = new String(rs("dateofbirth"));
		}
	}
}

function _addStudent() {
	var insertParams = "customerid, name, schoollevel, prevedu, dateofbirth";
	var insertValues = this.customerid + ", '" + this.name + "', '" + this.schoollevel + "', '" + this.prevedu + "', '" + this.dateofbirth + "'";

	try {
		var strSQL = "INSERT INTO ymec_lead_student (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveStudent() {
	var updateStr = "customerid = " + this.customerid + ", " +
					"name = '" + this.name + "', " +
					"schoollevel = '" + this.schoollevel + "', " +
					"prevedu = '" + this.prevedu + "', " +
					"dateofbirth = '" + this.dateofbirth + "'";

	try {
		var strSQL = "UPDATE ymec_lead_student SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteStudent() {
	try {
		var strSQL = "DELETE FROM ymec_lead_student WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}




%>