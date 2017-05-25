<% 

function Teacher() {

	this.id = null;
	this.userid = null;
	this.name = null;
	this.code = null;
	this.email = null;
	this.state = null;
	this.region = null;
	this.coordinator = null;

	this._getTeacherID = _getTeacherID;
	this._getTeacherUserID = _getTeacherUserID;
	this._getTeacherName = _getTeacherName;
	this._getTeacherCode = _getTeacherCode;
	this._getTeacherEmail = _getTeacherEmail;
	this._getTeacherState = _getTeacherState;
	this._getTeacherRegion = _getTeacherRegion;
	this._getTeacherCoordinator = _getTeacherCoordinator;

	this._setTeacherID = _setTeacherID;
	this._setTeacherUserID = _setTeacherUserID;
	this._setTeacherName = _setTeacherName;
	this._setTeacherCode = _setTeacherCode;
	this._setTeacherEmail = _setTeacherEmail;
	this._setTeacherState = _setTeacherState;
	this._setTeacherRegion = _setTeacherRegion;
	this._setTeacherCoordinator = _setTeacherCoordinator;

	this._getAllTeachers = _getAllTeachers;
	this._getAllTeachersAsRS = _getAllTeachersAsRS;
	this._getAllTeachersNotAssigned = _getAllTeachersNotAssigned;
	this._loadTeacher = _loadTeacher;
	this._loadTeacherByCode = _loadTeacherByCode;
	this._isCoordinator = _isCoordinator;
	this._getTeacherEmailByCode = _getTeacherEmailByCode;
	this._getTeacherEmailByRegion = _getTeacherEmailByRegion;
	
	this._addTeacher = _addTeacher;
	this._saveTeacher = _saveTeacher;
	this._deleteTeacher = _deleteTeacher;

}

function _getTeacherID() 				{ return this.id; }
function _getTeacherUserID() 			{ return this.userid; }
function _getTeacherName()				{ return this.name; }
function _getTeacherCode()				{ return this.code; }
function _getTeacherEmail()				{ return this.email; }
function _getTeacherState()				{ return this.state; }
function _getTeacherRegion()			{ return this.region; }
function _getTeacherCoordinator()		{ return this.coordinator; }

function _setTeacherID(value) 			{ this.id = value; }
function _setTeacherUserID(value) 		{ this.userid = value; }
function _setTeacherName(value)			{ this.name = value; }
function _setTeacherCode(value) 		{ this.code = value; }
function _setTeacherEmail(value)		{ this.email = value; }
function _setTeacherState(value)		{ this.state = value; }
function _setTeacherRegion(value)		{ this.region = value; }
function _setTeacherCoordinator(value)	{ this.coordinator = value; }



function _getAllTeachers() {
	var Keys = new Array();
	var rs = GBL_CONN.Execute("SELECT id FROM ymec_teacher ORDER BY code");
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("id"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}

function _getAllTeachersAsRS() {

	var strSQL = "SELECT ymec_teacher.*, yma_customer.firstname + ' ' + yma_customer.lastname as 'name', yma_customer.email FROM ymec_teacher INNER JOIN yma_user ON ymec_teacher.userid = yma_user.id INNER JOIN yma_customer ON yma_customer.id = yma_user.customerid ORDER BY yma_customer.state DESC, ymec_teacher.code ASC";
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


function _getAllTeachersNotAssigned() {
	
	var strSQL = "SELECT yma_user.id as userid, yma_customer.* FROM yma_user INNER JOIN yma_customer ON yma_customer.id = yma_user.customerid WHERE yma_user.id NOT IN (SELECT userid FROM ymec_teacher) AND yma_user.usertypeid = 5"
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


function _loadTeacher(id) {
	if (id) {
		try {
			var strSQL = "SELECT ymec_teacher.*, yma_customer.firstname + ' ' + yma_customer.lastname as 'name', ymec_teacher.email FROM ymec_teacher INNER JOIN yma_user ON ymec_teacher.userid = yma_user.id INNER JOIN yma_customer ON yma_customer.id = yma_user.customerid WHERE ymec_teacher.id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));
			this.userid = parseInt(rs("userid"));
			this.code = new String(rs("code"));
			this.name = new String(rs("name"));
			this.email = new String(rs("email"));
			this.state = new String(rs("state"));
			this.region = new String(rs("region"));
			this.coordinator = parseInt(rs("coordinator"));
		}
	}
}

function _loadTeacherByCode(code) {

	if (code) {
		try {
			var strSQL = "SELECT ymec_teacher.*, yma_customer.firstname + ' ' + yma_customer.lastname as 'name', yma_customer.email FROM ymec_teacher INNER JOIN yma_user ON ymec_teacher.userid = yma_user.id INNER JOIN yma_customer ON yma_customer.id = yma_user.customerid WHERE ymec_teacher.code = '" + code + "'";
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));
			this.code = new String(rs("code"));
			this.name = new String(rs("name"));
			this.email = new String(rs("email"));
			this.state = new String(rs("state"));
			this.region = new String(rs("region"));
			this.coordinator = parseInt(rs("coordinator"));
		}
	}
}


function _isCoordinator(userid) {

	var co = false;
	if (userid) {
		try {
			var strSQL = "SELECT coordinator FROM ymec_teacher WHERE ymec_teacher.userid = " + userid;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			co = parseInt(rs("coordinator"))==0?false:true;
		}
		rs.Close();
		rs = null;
	}
	return co;
}


function _getTeacherEmailByCode(code) {
	var email = null;
	if (code) {
		try {
			var strSQL = new String("SELECT email FROM ymec_teacher WHERE ymec_teacher.code = '" + code + "'");
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			email = new String(rs("email"));			
		}
	}
	return email;
}

function _getTeacherEmailByRegion(region) {
	var email = null;
	if (region) {
		for (var i=0; i < GBL_REGIONS.length; i++) {
			if (new String(region).toLowerCase().indexOf(new String(GBL_REGIONS[i]).toLowerCase()) == 0) {
				email = GBL_REGIONS_EMAIL[i];
				break;
			}
		}
	}
	return email;
}


function _addTeacher() {
	var insertParams = "userid, code, email, state, region, coordinator, datecreated";
	var insertValues = this.userid + ", '" + this.code + "', '" + this.email + "', '" + this.state + "', '" + this.region + "', " + this.coordinator + ", GETDATE()";

	try {
		var strSQL = "INSERT INTO ymec_teacher (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveTeacher() {
	var updateStr = "userid = " + this.userid + ", " +
					"code = '" + this.code + "', " +
					"email = '" + this.email + "', " +
					"state = '" + this.state + "', " +
					"region = '" + this.region + "', " +
					"coordinator = " + this.coordinator + ", " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE ymec_teacher SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteTeacher() {
	try {
		var strSQL = "DELETE FROM ymec_teacher WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


%>