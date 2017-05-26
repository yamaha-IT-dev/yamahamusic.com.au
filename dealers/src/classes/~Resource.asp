<%
function Resource() {

	this.id = null;
	this.typeid = null;
	this.categoryid = null;
	this.userid = null;
	this.status = 0;
	this.onrequest = 0;
	this.division = "MPD";
	this.name = new String();
	this.description = new String();
	this.filesrcsm = new String();
	this.filesrclg = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getResourceID 			= function() { return this.id; }
	this._getResourceTypeID 		= function() { return this.typeid; }
	this._getResourceCategoryID 	= function() { return this.categoryid; }
	this._getResourceUserID 		= function() { return this.userid; }
	this._getResourceStatus 		= function() { return this.status; }
	this._getResourceOnrequest 		= function() { return this.onrequest; }
	this._getResourceDivision 		= function() { return this.division; }
	this._getResourceName 			= function() { return this.name; }
	this._getResourceDescription 	= function() { return this.description; }
	this._getResourceFilesrcsm 		= function() { return this.filesrcsm; }
	this._getResourceFilesrclg 		= function() { return this.filesrclg; }
	this._getResourceDatecreated 	= function() { return this.datecreated; }
	this._getResourceDatemodified 	= function() { return this.datemodified; }

	this._setResourceID 			= function(value) { this.id = value; }
	this._setResourceTypeID 		= function(value) { this.typeid = value; }
	this._setResourceCategoryID 	= function(value) { this.categoryid = value; }
	this._setResourceUserID 		= function(value) { this.userid = value; }
	this._setResourceStatus 		= function(value) { this.status = value; }
	this._setResourceOnrequest 		= function(value) { this.onrequest = value; }
	this._setResourceDivision 		= function(value) { this.division = value; }
	this._setResourceName 			= function(value) { this.name = value; }
	this._setResourceDescription 	= function(value) { this.description = value; }
	this._setResourceFilesrcsm 		= function(value) { this.filesrcsm = value; }
	this._setResourceFilesrclg 		= function(value) { this.filesrclg = value; }
	this._setResourceDatecreated 	= function(value) { this.datecreated = value; }
	this._setResourceDatemodified 	= function(value) { this.datemodified = value; }

	this._getAllResourcesByType = _getAllResourcesByType;
	this._getAllResourcesByCategoryByType = _getAllResourcesByCategoryByType;
	this._getAllRecentResources = _getAllRecentResources;

	this._getAllResourceTypes = _getAllResourceTypes;
	this._getResourceTypeNameByID = _getResourceTypeNameByID;

	this._loadResource = _loadResource;
	this._addResource = _addResource;
	this._saveResource = _saveResource;
	this._saveResourceStatus = _saveResourceStatus;
	this._deleteResource = _deleteResource;

}

function _getAllResourcesByType(resourcetypeid, limit, active, division) {
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strLIMIT = "";
	if (limit) {
		strLIMIT = "TOP " + limit + " ";
	}
	var strSQL = "SELECT " + strLIMIT +
				 "    ymadex_resource.* " +
				 "FROM " +
				 "    ymadex_resource " +
				 "WHERE 1 = 1 " +
				 "    AND ymadex_resource.resourcetypeid = " + resourcetypeid + " " +
				 "    AND ymadex_resource.division = '" + division + "' " +
				 	strACTIVE + " " +
				 "ORDER BY " +
				 "    ymadex_resource.dateopen DESC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllResourcesByCategoryByType(categoryid, division, typeid, active, limit, keywords)
{
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strLIMIT = limit?"TOP " + limit + " ":"";
	var strCAT = categoryid > 0?" AND ymadex_resource.categoryid = " + categoryid:"";
	var strTYPE = typeid > 0?" AND ymadex_resource.typeid = " + typeid:"";
	var strKEYS = keywords?" AND ymadex_resource.name LIKE '%" + keywords + "%'":"";

	var strSQL = "SELECT " + strLIMIT +
				 "    ymadex_resource.* " +
				 "FROM " +
				 "    ymadex_resource " +
				 "WHERE " +
				 "    1 = 1 " +
				 "    AND ymadex_resource.division = '" + division + "' " +
					 strCAT + " " +
					 strTYPE + " " +
					 strKEYS + " " +
					 strACTIVE + " " +
				 "ORDER BY " +
				 "    ymadex_resource.datecreated DESC";

// Response.Write(strSQL);

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllRecentResources(division)
{

	var strSQL = "SELECT " +
				 "    ymadex_resource.id, " +
				 "    ymadex_category.id as categoryid, " +
				 "    ymadex_resource.userid, " +
				 "    ymadex_resource.division, " +
				 "    ymadex_resource.title, " +
				 "    ymadex_resource.dateopen, " +
				 "    ymadex_resource.dateclosed, " +
				 "    ymadex_resource.datecreated, " +
				 "    ymadex_category.title as category, " +
				 "    ymadex_user.username " +
				 "FROM " +
				 "    ymadex_resource " +
				 "INNER JOIN " +
				 "    ymadex_resourcecategory ON " +
				 "    ymadex_resourcecategory.resourceid = ymadex_resource.id " +
				 "INNER JOIN " +
				 "    ymadex_category ON " +
				 "    ymadex_category.id = ymadex_resourcecategory.categoryid " +
				 "INNER JOIN " +
				 "    ymadex_user ON " +
				 "    ymadex_user.id = ymadex_resource.userid " +
				 "WHERE " +
				 "    1 = 1 " +
				 "    AND DATEDIFF(dd, ymadex_resource.datecreated, getdate()) < 30 " +
				 "    AND ymadex_resource.division = '" + division + "' " +
				 "ORDER BY " +
				 "    ymadex_resource.categoryid ASC, " +
				 "    ymadex_resource.[order] ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllResourceTypes(division, type, active)
{
	var strTYPE = type.length > 0?" AND ymadex_resourcetype.type = '" + type + "'":"";
	var strACTIVE = active?" AND [status] = 1 ":"";

	var strSQL = "SELECT " +
				 "    * " +
				 "FROM " +
				 "    ymadex_resourcetype " +
				 "WHERE " +
				 "    1 = 1 " +
				 "    AND division = '" + division + "' " +
				 	strACTIVE +
				 	strTYPE +
				 "ORDER BY " +
				 "    name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getResourceTypeNameByID(typeid) {

	var strname = "";
	var strSQL = "SELECT " +
				 "    name " +
				 "FROM " +
				 "    ymadex_resourcetype " +
				 "WHERE " +
				 "    id = " + typeid + " " +
				 "ORDER BY " +
				 "    name ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		strname = new String(rs("name"));
	}
	return strname;
}


function _loadResource(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymadex_resource WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.typeid = new Number(rs("typeid"));
			this.categoryid = new Number(rs("categoryid"));
			this.userid = new Number(rs("userid"));
			this.status = new Number(rs("status"));
			this.onrequest = new Number(rs("onrequest"));
			this.division = new String(rs("division"));
			this.name = new String(rs("name"));
			this.description = new String(rs("description"));
			this.filesrcsm = new String(rs("filesrcsm"));
			this.filesrclg = new String(rs("filesrclg"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addResource() {
	
	var resource_id = 0;

	var insertParams = "typeid, categoryid, userid, [status], onrequest, division, name, description, filesrcsm, filesrclg, datecreated";
	var insertValues = this.typeid + ", " + this.categoryid + ", " + this.userid + ", " + this.status + ", " + this.onrequest + ", '" + this.division + "', '" + this.name + "', '" + this.description + "', '" + this.filesrcsm + "', '" + this.filesrclg + "', getdate()";
	var rs = null;

	try 
	{
		var strSQL = "SET NOCOUNT ON; INSERT INTO ymadex_resource (" + insertParams + ") VALUES (" + insertValues + "); SELECT @@IDENTITY as resource_id; ";
		var rs = GBL_CONN.Execute(strSQL);

			this.id = rs.Fields("resource_id").value;
		
			rs.close();
			rs = null;
	} 
	catch(e) 
	{
		Response.Write("Attempted Insert : " + e.description + "<br/>" + strSQL);
		Response.Flush();
		//return;
	}

	return this.id;
}


function _saveResource() {
	var updateStr = "typeid = " + this.typeid + ", " +
					"categoryid = " + this.categoryid + ", " +
					"userid = " + this.userid + ", " +
					"[status] = " + this.status + ", " +
					"onrequest = " + this.onrequest + ", " +
					"division = '" + this.division + "', " +
					"name = '" + this.name + "', " +
					"description = '" + this.description + "', " +
					"filesrcsm = '" + this.filesrcsm + "', " +
					"filesrclg = '" + this.filesrclg + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE ymadex_resource SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _saveResourceStatus() {
	var updateStr = "[status] = " + this.status + ", " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE ymadex_resource SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteResource() {
	try {
		var strSQL = "DELETE FROM ymadex_resource WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}



%>