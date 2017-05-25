<% 

function Topic() {

	this.id = null;
	this.groupid = null;
	this.ownerid = null;
	this.status = null;
	this.name = null;
	this.description = null;
	this.datecreated = null;
	this.datemodified = null;

	this._getTopicID = _getTopicID;
	this._getTopicGroupID = _getTopicGroupID;
	this._getTopicOwnerID = _getTopicOwnerID;
	this._getTopicName = _getTopicName;
	this._getTopicDescription = _getTopicDescription;
	this._getTopicDatecreated = _getTopicDatecreated;
	this._getTopicDatemodified = _getTopicDatemodified;

	this._setTopicID = _setTopicID;
	this._setTopicGroupID = _setTopicGroupID;
	this._setTopicOwnerID = _setTopicOwnerID;
	this._setTopicName = _setTopicName;
	this._setTopicDescription = _setTopicDescription;
	this._setTopicDatecreated = _setTopicDatecreated;
	this._setTopicDatemodified = _setTopicDatemodified;

	this._getAllTopic = _getAllTopic;

	this._loadTopic = _loadTopic;
	this._addTopic = _addTopic;
	this._saveTopic = _saveTopic;
	this._deleteTopic = _deleteTopic;

}


function _getTopicID() 				{ return this.id; }
function _getTopicGroupID() 		{ return this.groupid; }
function _getTopicOwnerID() 		{ return this.ownerid; }
function _getTopicName()			{ return this.name; }
function _getTopicDescription()		{ return this.description; }
function _getTopicDatecreated() 	{ return this.datecreated; }
function _getTopicDatemodified() 	{ return this.datemodified; }

function _setTopicID(value) 			{ this.id = value; }
function _setTopicGroupID(value)		{ this.groupid = value; }
function _setTopicOwnerID(value)		{ this.ownerid = value; }
function _setTopicName(value) 			{ this.name = value; }
function _setTopicDescription(value) 	{ this.description = value; }
function _setTopicDatecreated(value)	{ this.datecreated = value; }
function _setTopicDatemodified(value)	{ this.datemodified = value; }



function _getAllTopic(private) {

	var private = private?1:0;
	var strSQL = "SELECT yma_topic.*, yma_group.name as [group] FROM yma_topic INNER JOIN yma_group ON yma_group.id = yma_topic.groupid WHERE yma_group.private = " + private + " AND yma_topic.[status] = 1 ORDER BY yma_group.name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}



function _loadTopic(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_topic WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.groupid = new Number(rs("groupid"));
			this.ownerid = new Number(rs("ownerid"));
			this.name = new String(rs("name"));
			this.description = new String(rs("description"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addTopic() {
	var insertParams = "groupid, ownerid, name, description, datecreated";
	var insertValues = this.groupid + ", " + this.ownerid + ", '" + this.name + "', '" + this.description + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_topic (" + insertParams + ") VALUES (" + insertValues + ")";
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

function _saveTopic() {
	var updateStr = "groupid = " + this.groupid + ", " +
					"ownerid = " + this.ownerid + ", " +
					"name = '" + this.name + "', " +
					"description = '" + this.description + "', " +
					"datemodified = getdate()";

	try {
		var strSQL = "UPDATE yma_topic SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteTopic() {
	try {
		var strSQL = "DELETE FROM yma_topic WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


%>