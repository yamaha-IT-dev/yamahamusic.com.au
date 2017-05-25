<% 

function Category() {

	this.id = null;
	this.parentid = null;
	this.userid = null;
	this.title = new String();
	this.description = new String();
	this.url = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getCategoryID = _getCategoryID;
	this._getCategoryParentID = _getCategoryParentID;
	this._getCategoryUserID = _getCategoryUserID;
	this._getCategoryTitle = _getCategoryTitle;
	this._getCategoryDescription = _getCategoryDescription;
	this._getCategoryURL = _getCategoryURL;
	this._getCategoryDatecreated = _getCategoryDatecreated;
	this._getCategoryDatemodified = _getCategoryDatemodified;

	this._setCategoryID = _setCategoryID;
	this._setCategoryParentID = _setCategoryParentID;
	this._setCategoryUserID = _setCategoryUserID;
	this._setCategoryTitle = _setCategoryTitle;
	this._setCategoryDescription = _setCategoryDescription;
	this._setCategoryURL = _setCategoryURL;
	this._setCategoryDatecreated = _setCategoryDatecreated;
	this._setCategoryDatemodified = _setCategoryDatemodified;

	this._getAllCategories = _getAllCategories;
	this._getAllCategoriesByParentID = _getAllCategoriesByParentID;
	this._getAllCategoriesByResource = _getAllCategoriesByResource;
	
	this._drawCategoryList = _drawCategoryList;
	this._drawCategoryOptionList = _drawCategoryOptionList;
	this._drawCategoryCheckList = _drawCategoryCheckList;

	this._loadCategory = _loadCategory;
	this._addCategory = _addCategory;
	this._saveCategory = _saveCategory;
	this._deleteCategory = _deleteCategory;
}


function _getCategoryID()			{ return this.id; }
function _getCategoryParentID() 	{ return this.parentid; }
function _getCategoryUserID()		{ return this.userid; }
function _getCategoryTitle()		{ return this.title; }
function _getCategoryDescription()	{ return this.description; }
function _getCategoryURL()			{ return this.url; }
function _getCategoryDatecreated()	{ return this.datecreated; }
function _getCategoryDatemodified()	{ return this.datemodified; }

function _setCategoryID(value)				{ this.id = value; }
function _setCategoryParentID(value)		{ this.parentid = value; }
function _setCategoryUserID(value)			{ this.userid = value; }
function _setCategoryTitle(value)			{ this.title = value; }
function _setCategoryDescription(value)		{ this.description = value; }
function _setCategoryURL(value)				{ this.url = value; }
function _setCategoryDatecreated(value)		{ this.datecreated = value; }
function _setCategoryDatemodified(value)	{ this.datemodified = value; }


function _getAllCategories() {

	var strSQL = "SELECT * FROM yma_category ORDER BY title ASC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _getAllCategoriesByParentID(parentid) {

	var strSQL = "SELECT * FROM yma_category WHERE parentid = " + parentid;
	var Keys = new Array();
	try {
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Get : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("id"));
		rs.MoveNext();
		i++;
	}
	rs.Close();
	return Keys;

}

function _getAllCategoriesByResource(resourceid) {
	var Keys = new Array();
	try {
		var strSQL = "SELECT yma_resourcecategory.categoryid FROM yma_resourcecategory WHERE yma_resourcecategory.resourceid = " + resourceid;
		var rs = GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Get : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("categoryid"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}



function _loadCategory(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_category WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.parentid = new Number(rs("parentid"));
			this.userid = new Number(rs("userid"));
			this.title = new String(rs("title"));
			this.description = new String(rs("description"));
			this.url = new String(rs("url"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addCategory() {
	var insertParams = "parentid, userid, title, description, url, datecreated";
	var insertValues = this.parentid + ", " + this.userid + ", '" + this.title + "', '" + this.description + "', '" + this.url + "', getdate()";

	try {
		var strSQL = "INSERT INTO yma_category (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveCategory() {
	var updateStr = "parentid = " + this.parentid + ", " +
					"userid = " + this.userid + ", " +
					"title = '" + this.title + "', " +
					"description = '" + this.description + "', " +
					"url = '" + this.url + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE yma_category SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteCategory() {
	try {
		var strSQL = "DELETE FROM yma_category WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}





function _drawCategoryOptionList(parentid, selectedid, indent) {
	var recC = new Category();
	var arrCats = recC._getAllCategoriesByParentID(parentid);
	for (var i = 0; i < arrCats.length; i++) {

		recC._loadCategory(arrCats[i]);

//Response.Write("id = " + rsCats("id") + " : parentid = " + parentid + "<br/>");
		
		%><option value="<%= recC._getCategoryID()  %>"<%= parseInt(recC._getCategoryID())==selectedid?" selected=\"selected\"":"" %>  style="padding-left:<%= (indent*10) %>px;"><%= recC._getCategoryTitle() %></option>
		<%
		
		var arrCatChildren = recC._getAllCategoriesByParentID(arrCats[i]);
		if (arrCatChildren.length > 0) {
			var nindent = indent+1;
			recC._drawCategoryOptionList(arrCats[i], selectedid, nindent)
		}
	}
}

function _drawCategoryCheckList(parentid, arrselectedid, indent) {
	var recC = new Category();
	var arrCats = recC._getAllCategoriesByParentID(parentid);
	for (var i = 0; i < arrCats.length; i++) {

		recC._loadCategory(arrCats[i]);

				var blnCatMatch = false;
				for (var j=0; j < arrselectedid.length; j++) {
					if (parseInt(arrselectedid[j])==parseInt(arrCats[i])) {
						blnCatMatch = true;
						break;
					}
				}

		%><div style="padding-left:<%= (indent*20) %>px;">
			<input type="checkbox" name="categoryid" value="<%= recC._getCategoryID()  %>"<%= blnCatMatch?" checked=\"checked\"":"" %> /><%= recC._getCategoryTitle() %>
		</div>
		<%
		
		var arrCatChildren = recC._getAllCategoriesByParentID(arrCats[i]);
		if (arrCatChildren.length > 0) {
			var nindent = indent+1;
			recC._drawCategoryCheckList(arrCats[i], arrselectedid, nindent)
		}
	}
}

function _drawCategoryList(parentid, indent) {
	var recC = new Category();
	var arrCats = recC._getAllCategoriesByParentID(parentid);
	for (var i = 0; i < arrCats.length; i++) {

		recC._loadCategory(arrCats[i]);

//Response.Write("id = " + rsCats("id") + " : parentid = " + parentid + "<br/>");

		%><div style="padding-left:<%= parseInt(indent)*10 %>px;">
			<a href="<%= CONTROLLER %>?action=<%= EDIT_CATEGORY %>&amp;categoryid=<%= recC._getCategoryID() %>" title="<%= recC._getCategoryDescription() %>"><%= recC._getCategoryTitle() %></a><br/>
		</div>
		<%
		
		
		var arrCatChildren = recC._getAllCategoriesByParentID(arrCats[i]);
		if (arrCatChildren.length > 0) {
			var nindent = indent+1;
			recC._drawCategoryList(arrCats[i], nindent)
		}
	}
}


%>