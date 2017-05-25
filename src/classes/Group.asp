<% 

function Group() {

	this.id = null;
	this.name = null;
	this.datecreated = null;
	this.datemodified = null;

	this._getGroupID = _getGroupID;
	this._getGroupName = _getGroupName;
	this._getGroupDatecreated = _getGroupDatecreated;
	this._getGroupDatemodified = _getGroupDatemodified;

	this._setGroupID = _setGroupID;
	this._setGroupName = _setGroupName;
	this._setGroupDatecreated = _setGroupDatecreated;
	this._setGroupDatemodified = _setGroupDatemodified;

	this._getAllGroup = _getAllGroup;

	this._loadGroup = _loadGroup;
	this._addGroup = _addGroup;
	this._saveGroup = _saveGroup;
	this._deleteGroup = _deleteGroup;

}


function _getGroupID() 				{ return this.id; }
function _getGroupName()			{ return this.name; }
function _getGroupDatecreated() 	{ return this.datecreated; }
function _getGroupDatemodified() 	{ return this.datemodified; }

function _setGroupID(value) 			{ this.id = value; }
function _setGroupName(value) 			{ this.name = value; }
function _setGroupDatecreated(value)	{ this.datecreated = value; }
function _setGroupDatemodified(value)	{ this.datemodified = value; }



function _getAllGroup() {
	var Keys = new Array();
	var rs = GBL_CONN.Execute("SELECT id FROM yma_group ORDER BY name ASC");
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("id"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}



function _loadGroup(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_group WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.name = new String(rs("name"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addGroup() {
	var insertParams = "name, datecreated";
	var insertValues = "'" + this.name + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_group (" + insertParams + ") VALUES (" + insertValues + ")";
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

function _saveGroup() {
	var updateStr = "name = '" + this.name + "', " +
					"datemodified = getdate()";

	try {
		var strSQL = "UPDATE yma_group SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteGroup() {
	try {
		var strSQL = "DELETE FROM yma_group WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


%>