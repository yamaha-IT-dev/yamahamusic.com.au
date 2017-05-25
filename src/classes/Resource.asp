<% 

function Resource() {

	this.id = null;
	this.resourcetypeid = null;
	this.userid = null;
	this.order = 0;
	this.status = 0;
	this.title = new String();
	this.body = new String();
	this.extract = new String();
	this.filesrcsm = new String();
	this.filesrclg = new String();
	this.url = new String();
	this.link = new String();
	this.bgcolor = new String();
	this.dateopen = new String();
	this.dateclosed = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getResourceID = _getResourceID;
	this._getResourceTypeID = _getResourceTypeID;
	this._getResourceUserID = _getResourceUserID;
	this._getResourceOrder = _getResourceOrder;
	this._getResourceStatus = _getResourceStatus;
	this._getResourceTitle = _getResourceTitle;
	this._getResourceBody = _getResourceBody;
	this._getResourceExtract = _getResourceExtract;
	this._getResourceFilesrcsm = _getResourceFilesrcsm;
	this._getResourceFilesrclg = _getResourceFilesrclg;
	this._getResourceURL = _getResourceURL;
	this._getResourceLink = _getResourceLink;
	this._getResourceBGColor = _getResourceBGColor;
	this._getResourceDateopen = _getResourceDateopen;
	this._getResourceDateclosed = _getResourceDateclosed;
	this._getResourceDatecreated = _getResourceDatecreated;
	this._getResourceDatemodified = _getResourceDatemodified;

	this._setResourceID = _setResourceID;
	this._setResourceTypeID = _setResourceTypeID;
	this._setResourceUserID = _setResourceUserID;
	this._setResourceOrder = _setResourceOrder;
	this._setResourceStatus = _setResourceStatus;
	this._setResourceTitle = _setResourceTitle;
	this._setResourceBody = _setResourceBody;
	this._setResourceExtract = _setResourceExtract;
	this._setResourceFilesrcsm = _setResourceFilesrcsm;
	this._setResourceFilesrclg = _setResourceFilesrclg;
	this._setResourceURL = _setResourceURL;
	this._setResourceLink = _setResourceLink;
	this._setResourceBGColor = _setResourceBGColor;
	this._setResourceDateopen = _setResourceDateopen;
	this._setResourceDateclosed = _setResourceDateclosed;
	this._setResourceDatecreated = _setResourceDatecreated;
	this._setResourceDatemodified = _setResourceDatemodified;

	this._getAllResourcesByCategory = _getAllResourcesByCategory;
	this._getAllResourcesByCategoryForHome = _getAllResourcesByCategoryForHome;
	this._getAllResourcesByType = _getAllResourcesByType;
	this._getAllResourcesByCategoryByType = _getAllResourcesByCategoryByType;
	this._getAllCurrentResourcesByCategoryByType = _getAllCurrentResourcesByCategoryByType;
	this._getAllRecentResources = _getAllRecentResources;
	this._getAllResourceTypes = _getAllResourceTypes;
	this._getMaxOrderByTypeByCategory = _getMaxOrderByTypeByCategory;

	this._loadResource = _loadResource;
	this._addResource = _addResource;
	this._saveResource = _saveResource;
	this._saveResourceStatus = _saveResourceStatus;
	this._deleteResource = _deleteResource;

	this._reorderResourceUp = _reorderResourceUp;
	this._reorderResourceDown = _reorderResourceDown;

	this._removeResourceFromCategory = _removeResourceFromCategory;
	this._addResourceToCategory = _addResourceToCategory;

	this._drawResourceItem = _drawResourceItem;
	this._drawResourcesShort = _drawResourcesShort;

}


function _getResourceID()			{ return this.id; }
function _getResourceTypeID() 		{ return this.resourcetypeid; }
function _getResourceUserID()		{ return this.userid; }
function _getResourceOrder()		{ return this.order; }
function _getResourceStatus()		{ return this.status; }
function _getResourceTitle()		{ return this.title; }
function _getResourceBody()			{ return this.body; }
function _getResourceExtract()		{ return this.extract; }
function _getResourceFilesrcsm()	{ return this.filesrcsm; }
function _getResourceFilesrclg()	{ return this.filesrclg; }
function _getResourceURL()			{ return this.url; }
function _getResourceLink()			{ return this.link; }
function _getResourceBGColor()		{ return this.bgcolor; }
function _getResourceDateopen()		{ return this.dateopen; }
function _getResourceDateclosed()	{ return this.dateclosed; }
function _getResourceDatecreated()	{ return this.datecreated; }
function _getResourceDatemodified()	{ return this.datemodified; }

function _setResourceID(value)				{ this.id = value; }
function _setResourceTypeID(value)			{ this.resourcetypeid = value; }
function _setResourceUserID(value)			{ this.userid = value; }
function _setResourceOrder(value)			{ this.order = value; }
function _setResourceStatus(value)			{ this.status = value; }
function _setResourceTitle(value)			{ this.title = value; }
function _setResourceBody(value)			{ this.body = value; }
function _setResourceExtract(value)			{ this.extract = value; }
function _setResourceFilesrcsm(value)		{ this.filesrcsm = value; }
function _setResourceFilesrclg(value)		{ this.filesrclg = value; }
function _setResourceURL(value)				{ this.url = value; }
function _setResourceLink(value)			{ this.link = value; }
function _setResourceBGColor(value)			{ this.bgcolor = value; }
function _setResourceDateopen(value)		{ this.dateopen = value; }
function _setResourceDateclosed(value)		{ this.dateclosed = value; }
function _setResourceDatecreated(value)		{ this.datecreated = value; }
function _setResourceDatemodified(value)	{ this.datemodified = value; }




function _getAllResourcesByCategoryForHome(categoryid, active) {
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strSQL = "SELECT TOP 10 yma_resource.* FROM yma_resource INNER JOIN yma_resourcecategory ON yma_resourcecategory.resourceid = yma_resource.id WHERE yma_resourcecategory.categoryid = " + categoryid + " AND yma_resource.resourcetypeid NOT IN (6) " + strACTIVE + " ORDER BY yma_resource.dateopen DESC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllResourcesByCategory(categoryid, active) {
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strSQL = "SELECT yma_resource.* FROM yma_resource INNER JOIN yma_resourcecategory ON yma_resourcecategory.resourceid = yma_resource.id WHERE yma_resourcecategory.categoryid = " + categoryid + " " + strACTIVE + " ORDER BY yma_resource.dateopen DESC";
	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllResourcesByType(resourcetypeid, limit, active) {
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strLIMIT = "";
	if (limit) {
		strLIMIT = "TOP " + limit + " ";
	}
	var strSQL = "SELECT " + strLIMIT + " yma_resource.* FROM yma_resource WHERE yma_resource.resourcetypeid = " + resourcetypeid + " " + strACTIVE + " ORDER BY yma_resource.dateopen DESC";
	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllResourcesByCategoryByType(categoryid, resourcetypeid, active, limit) {
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strLIMIT = limit?"TOP " + limit + " ":"";

	var strSQL = "SELECT " + strLIMIT + " yma_resource.* FROM yma_resource INNER JOIN yma_resourcecategory ON yma_resourcecategory.resourceid = yma_resource.id WHERE yma_resourcecategory.categoryid = " + categoryid + " AND yma_resource.resourcetypeid = " + resourcetypeid + " " + strACTIVE + " ORDER BY yma_resource.dateopen DESC";
	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllCurrentResourcesByCategoryByType(categoryid, resourcetypeid, active, limit) {
	var strACTIVE = active?" AND [status] = 1 ":"";
	var strLIMIT = limit?"TOP " + limit + " ":"";

	var strSQL = "SELECT " + strLIMIT + " yma_resource.* FROM yma_resource INNER JOIN yma_resourcecategory ON yma_resourcecategory.resourceid = yma_resource.id WHERE yma_resourcecategory.categoryid = " + categoryid + " AND yma_resource.resourcetypeid = " + resourcetypeid + " " + strACTIVE + " AND yma_resource.dateopen > '2009/07/22' ORDER BY yma_resource.dateopen DESC";
	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllRecentResources() {

	var strSQL = "SELECT yma_resource.id, yma_category.id as categoryid, yma_resource.userid, yma_resource.title, yma_resource.dateopen, yma_resource.dateclosed, yma_resource.datecreated, yma_category.title as category, yma_user.username FROM yma_resource INNER JOIN yma_resourcecategory ON yma_resourcecategory.resourceid = yma_resource.id INNER JOIN yma_category ON yma_category.id = yma_resourcecategory.categoryid INNER JOIN yma_user ON yma_user.id = yma_resource.userid WHERE DATEDIFF(dd, yma_resource.datecreated, getdate()) < 30 ORDER BY yma_resource.categoryid ASC, yma_resource.[order] ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getAllResourceTypes() {

	var strSQL = "SELECT * FROM yma_resourcetype ORDER BY id ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}


function _getMaxOrderByTypeByCategory(resourcetypeid, categoryid) {
	var intOrder = 0;
	try {
		var strSQL = "SELECT MAX([order]) as odr FROM yma_resource INNER JOIN yma_resourcecategory ON yma_resourcecategory.resourceid = yma_resource.id WHERE yma_resource.resourcetypeid = " + resourcetypeid + " AND yma_resourcecategory.categoryid = " + categoryid;
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	if (!rs.EOF) {
		intOrder = new Number(rs("odr"));
	}
	rs.close();
	rs = null;
	return intOrder;
}




function _loadResource(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_resource WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.resourcetypeid = new Number(rs("resourcetypeid"));
			this.userid = new Number(rs("userid"));
			this.order = new Number(rs("order"));
			this.status = new Number(rs("status"));
			this.title = new String(rs("title"));
			this.body = new String(rs("body"));
			this.extract = new String(rs("extract"));
			this.filesrcsm = new String(rs("filesrcsm"));
			this.filesrclg = new String(rs("filesrclg"));
			this.url = new String(rs("url"));
			this.link = new String(rs("link"));
			this.bgcolor = new String(rs("bgcolor"));
			this.dateopen = new String(rs("dateopen"));
			this.dateclosed = new String(rs("dateclosed"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addResource() {
	var insertParams = "resourcetypeid, userid, [order], title, body, extract, filesrcsm, filesrclg, url, link, bgcolor, dateopen, dateclosed, datecreated";
	var insertValues = this.resourcetypeid + ", " + this.userid + ", " + this.order + ", '" + this.title + "', '" + this.body + "', '" + this.extract + "', '" + this.filesrcsm + "', '" + this.filesrclg + "', '" + this.url + "', '" + this.link + "', '" + this.bgcolor + "', '" + this.dateopen + "', '" + this.dateclosed + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_resource (" + insertParams + ") VALUES (" + insertValues + ")";
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
		Response.Flush();
		//return;
	}
	
	var rs = GBL_CONN.Execute("select max(id) from yma_resource group by id order by id desc");
		this.id = rs.Fields(0).value;

	rs.close();
	rs = null;

	return this.id;
}


function _saveResource() {
	var updateStr = "resourcetypeid = " + this.resourcetypeid + ", " +
					"userid = " + this.userid + ", " +
					"[order] = " + this.order + ", " +
					"[status] = " + this.status + ", " +
					"title = '" + this.title + "', " +
					"body = '" + this.body + "', " +
					"extract = '" + this.extract + "', " +
					"filesrcsm = '" + this.filesrcsm + "', " +
					"filesrclg = '" + this.filesrclg + "', " +
					"url = '" + this.url + "', " +
					"link = '" + this.link + "', " +
					"bgcolor = '" + this.bgcolor + "', " +
					"dateopen = '" + this.dateopen + "', " +
					"dateclosed = '" + this.dateclosed + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_resource SET " + updateStr + " WHERE id = " + this.id;
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
		var strSQL = "UPDATE yma_resource SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteResource() {
	try {
		var strSQL = "DELETE FROM yma_resource WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _removeResourceFromCategory(resourceid) {
	try {
		var strSQL = "DELETE FROM yma_resourcecategory WHERE resourceid =  " + resourceid;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _addResourceToCategory(resourceid, arrCategoryID) {
	try {
		var strSQL = "INSERT INTO yma_resourcecategory (resourceid, categoryid) SELECT " + resourceid + " AS resourceid, id AS categoryid FROM [yma_category] WHERE id IN (" + arrCategoryID + ")";
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}



function _reorderResourceUp(resourceid) {
	try {
		// get the existing order number
		var strSQL = "SELECT id, [order], resourcetypeid FROM yma_resource WHERE id = " + resourceid;
		var rs = GBL_CONN.Execute(strSQL);
		var tmpOrder = rs("order");
		var tmpType = rs("resourcetypeid");
		// get the id of record above to swap with
		var strSQL = "SELECT top 1 id, [order] FROM yma_resource WHERE [order] < " + tmpOrder + " AND resourcetypeid = " + tmpType + " order by [order] DESC";
		var rs = GBL_CONN.Execute(strSQL);
		var tmpID = rs("id");
		var tmpDiffOrder = rs("order");
		var intOrderDiff = tmpOrder - tmpDiffOrder;
		// apply the changes and perform the swap.
		GBL_CONN.Execute("UPDATE yma_resource SET [order] = [order]-" + intOrderDiff + " WHERE id = " + resourceid);
		GBL_CONN.Execute("UPDATE yma_resource SET [order] = [order]+" + intOrderDiff + " WHERE id = " + tmpID);
		
	} catch(e) {
		//Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		//Response.Flush();
	}
}


function _reorderResourceDown(resourceid) {
	try {
		// get the existing order number
		var strSQL = "SELECT id, [order], resourcetypeid FROM yma_resource WHERE id = " + resourceid;
		var rs = GBL_CONN.Execute(strSQL);
		var tmpOrder = rs("order");
		var tmpType = rs("resourcetypeid");
		// get the id of record below to swap with
		var strSQL = "SELECT top 1 id, [order] FROM yma_resource WHERE [order] > " + tmpOrder + " AND resourcetypeid = " + tmpType + " order by [order] ASC";
		var rs = GBL_CONN.Execute(strSQL);
		var tmpID = rs("id");
		var tmpDiffOrder = rs("order");
		var intOrderDiff = tmpDiffOrder - tmpOrder;
		// apply the changes and perform the swap.
		GBL_CONN.Execute("UPDATE yma_resource SET [order] = [order]+" + intOrderDiff + " WHERE id = " + resourceid);
		GBL_CONN.Execute("UPDATE yma_resource SET [order] = [order]-" + intOrderDiff + " WHERE id = " + tmpID);
		
	} catch(e) {
		//Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		//Response.Flush();
	}

}


function _drawResourceItem(rsR, strViewer, categoryid) {
			
	if (!strViewer) {
		strViewer = "/news/news.asp";
	}

	%><div class="item"><%

	var d = new Date(rsR("dateopen"));

	%><h4><%= d.formatDate("jS F Y") %></h4>
	<h3><%= rsR("title") %></h3><%

	if (new String(rsR("filesrcsm")).length > 0) {
		%><img src="<%= rsR("filesrcsm") %>" border="0" alt="<%= rsR("title") %>" title="<%= rsR("title") %>"/><% 
	}
	%>
	<p><%= cleanForText(rsR("extract")) %>&nbsp;<%
	var strLink = "View item...";
	if (new String(rsR("link")).length != 0 && new String(rsR("link")).indexOf("null") != 0) {
		strLink = cleanForText(rsR("link"));
	}
	var strCatPair = "";
	if (categoryid) {
		strCatPair = "&amp;categoryid=" + categoryid;
	}
	if (new String(rsR("body")).length > 0) {
		if (new String(rsR("url")).length != 0) {
			%><a href="<%= rsR("url") %>"><%= strLink %></a><% 
		} else {
			%><a href="<%= strViewer %>?action=view_item&resourceid=<%= rsR("id") %><%= strCatPair %>"><%= strLink %></a><% 
		}
	}
	if (new String(rsR("filesrclg")).length > 0) {
		if (new String(rsR("filesrclg")).indexOf(".pdf") > 0) {
			%><br/><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="pdf"><%= strLink %></a><% 
		} else if (new String(rsR("filesrclg")).indexOf(".doc") > 0) {
			%><br/><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="doc"><%= strLink %></a><% 
		} else if (new String(rsR("filesrclg")).indexOf(".xls") > 0) {
			%><br/><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="xls"><%= strLink %></a><% 
		} else {
			%><br/><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="file"><%= strLink %></a><% 
		}
	}


	%></p>
	</div><%

}



function _drawResourcesShort(categoryid, style, strViewer, count) {

	if (!strViewer) {
		strViewer = "/news/news.asp";
	}

	var C = new Category();
		C._loadCategory(categoryid);

	var rsR = this._getAllResourcesByCategory(categoryid, true);

	%><h2><%= C._getCategoryTitle() %></h2>
	<p><%= C._getCategoryDescription().indexOf("null")!=0&&C._getCategoryDescription().length!=0?C._getCategoryDescription() + "<br/>":"" %><%

	if (rsR && !rsR.EOF) {
		var strLink = "Read more...";
		var c = 0;
		var rcount = rsR.RecordCount;
		if (count > rcount) {
			count = rcount;
		}

		while (!rsR.EOF) {

			if (new String(rsR("link")).length != 0 && new String(rsR("link")).indexOf("null") != 0) {
				strLink = cleanForText(rsR("link"));
			}
			if (new String(rsR("body")).length > 0) {
				if (new String(rsR("url")).length != 0) {
					%><a href="<%= rsR("url") %>"><%= strLink %></a><br/><% 
				} else {
					%><a href="<%= strViewer %>?action=view_item&resourceid=<%= rsR("id") %>"><%= strLink %></a><br/><% 
				}
			}
			if (new String(rsR("filesrclg")).length > 0 && new String(rsR("filesrclg")).indexOf(".pdf") > 0) {

				%><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="pdf" target="_blank"><%= strLink %></a><br/><% 

			} else if (new String(rsR("filesrclg")).length > 0 && new String(rsR("filesrclg")).indexOf(".doc") > 0) {

				%><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="doc" target="_blank"><%= strLink %></a><br/><% 

			} else if (new String(rsR("filesrclg")).length > 0 && new String(rsR("filesrclg")).indexOf(".xls") > 0) {

				%><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="xls" target="_blank"><%= strLink %></a><br/><% 

			} else {

				%><a href="<%= rsR("filesrclg") %>" title="<%= rsR("title") %>" class="file" target="_blank"><%= strLink %></a><br/><% 

			}
			c++;
			if (c == count) {
				if (rcount > count) {
					%><a href="<%= strViewer %>?action=list_items&amp;categoryid=<%= categoryid %>" class="goThere">View all <%= rcount %> items</a><%
				}
				break;
			} else {
				rsR.MoveNext();
			}
		}
	} else {
		%><strong>There are no items.</strong><br/><%
	}

	%></p><%

}






%> 