<% 

function UserType() {

	this.id = 0;
	this.name = null;

	this._getUserTypeID = _getUserTypeID;
	this._getUserTypeName = _getUserTypeName;

	this._setUserTypeID = _setUserTypeID;
	this._setUserTypeName = _setUserTypeName;

	this._getAllUserTypes = _getAllUserTypes;

	this._loadUserType = _loadUserType;
}


function _getUserTypeID()		{ return this.id; }
function _getUserTypeName()	{ return this.name; }

function _setUserTypeID(value)			{ this.id = value; }
function _setUserTypeName(value)	{ this.name = value; }


function _getAllUserTypes() {

	var rs = GBL_CONN.Execute("SELECT id, name FROM yma_usertype ORDER BY id ASC");

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}



function _loadUserType(id) {
	if (id) {
		try {
			var strSQL = "SELECT id, name FROM yma_usertype WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.name = new String(rs("name"));
		}
	}
}



%>