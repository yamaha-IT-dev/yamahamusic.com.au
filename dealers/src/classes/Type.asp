<%

function Type() {

	this.id = null;
	this.status = null;
	this.division = new String();
	this.type = new String();
	this.name = new String();
	this.description = new String();

	this._getTypeID 			= function() { return this.id; }
	this._getTypeStatus 		= function() { return this.status; }
	this._getTypeDivision 		= function() { return this.division; }
	this._getTypeType 			= function() { return this.type; }
	this._getTypeName 			= function() { return this.name; }
	this._getTypeDescription 	= function() { return this.description; }

	this._setTypeID 			= function(value) { this.id = value; }
	this._setTypeStatus 		= function(value) { this.status = value; }
	this._setTypeDivision 		= function(value) { this.division = value; }
	this._setTypeType 			= function(value) { this.type = value; }
	this._setTypeName 			= function(value) { this.name = value; }
	this._setTypeDescription 	= function(value) { this.description = value; }

	this._getAllTypes = _getAllTypes;

	this._loadType = _loadType;
	this._addType = _addType;
	this._saveType = _saveType;
	this._deleteType = _deleteType;
}




function _getAllTypes(division) {

	var strSQL = "SELECT * FROM ymadex_resourcetype WHERE division = '" + division + "' ORDER BY [type], name";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _loadType(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymadex_resourcetype WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.status = parseInt(rs("status"));
			this.division = new String(rs("division"));
			this.type = new String(rs("type"));
			this.name = new String(rs("name"));
			this.description = new String(rs("description"));
		}
	}
}

function _addType() {
	var insertParams = "status, division, type, name, description";
	var insertValues = this.status + ", '" + this.division + "', '" + this.type + "', '" + this.name + "', '" + this.description + "'";

	try {
		var strSQL = "INSERT INTO ymadex_resourcetype (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveType() {
	var updateStr = "status = " + this.status + ", " +
					"division = '" + this.division + "', " +
					"type = '" + this.type + "', " +
					"name = '" + this.name + "', " +
					"description = '" + this.description + "'";

	try {
		var strSQL = "UPDATE ymadex_resourcetype SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteType() {
	try {
		var strSQL = "DELETE FROM ymadex_resourcetype WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}






%>