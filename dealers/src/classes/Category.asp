<%

function Category() {

	this.id = null;
	this.userid = null;
	this.division = new String('MPD');
	this.title = new String();
	this.description = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getCategoryID 			= function() { return this.id; }
	this._getCategoryUserID 		= function() { return this.userid; }
	this._getCategoryDivision 		= function() { return this.division; }
	this._getCategoryTitle 			= function() { return this.title; }
	this._getCategoryDescription 	= function() { return this.description; }
	this._getCategoryDatecreated 	= function() { return this.datecreated; }
	this._getCategoryDatemodified 	= function() { return this.datemodified; }

	this._setCategoryID 			= function(value) { this.id = value; }
	this._setCategoryUserID 		= function(value) { this.userid = value; }
	this._setCategoryDivision 		= function(value) { this.division = value; }
	this._setCategoryTitle 			= function(value) { this.title = value; }
	this._setCategoryDescription 	= function(value) { this.description = value; }
	this._setCategoryDatecreated 	= function(value) { this.datecreated = value; }
	this._setCategoryDatemodified 	= function(value) { this.datemodified = value; }


	this._getAllCategories = _getAllCategories;

	this._drawCategoryList = _drawCategoryList;
	this._drawCategoryOptionList = _drawCategoryOptionList;
	this._drawCategoryCheckList = _drawCategoryCheckList;

	this._loadCategory = _loadCategory;
	this._addCategory = _addCategory;
	this._saveCategory = _saveCategory;
	this._deleteCategory = _deleteCategory;
}



function _getAllCategories(division) {

	var strSQL = "SELECT * FROM ymadex_category WHERE division = '" + division + "' ORDER BY title";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (!rs.EOF) {
		return rs;
	} else {
		return null;
	}
}

function _loadCategory(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymadex_category WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.userid = new Number(rs("userid"));
			this.division = new String(rs("division"));
			this.title = new String(rs("title"));
			this.description = new String(rs("description"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addCategory() {
	var insertParams = "userid, division, title, description, datecreated";
	var insertValues = this.userid + ", '" + this.division + "', '" + this.title + "', '" + this.description + "', getdate()";

	try {
		var strSQL = "INSERT INTO ymadex_category (" + insertParams + ") VALUES (" + insertValues + ")";
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
	var updateStr = "userid = " + this.userid + ", " +
					"division = '" + this.division + "', " +
					"title = '" + this.title + "', " +
					"description = '" + this.description + "', " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE ymadex_category SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteCategory() {
	try {
		var strSQL = "DELETE FROM ymadex_category WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}





function _drawCategoryOptionList(parentid, selectedid, indent) {
	var recC = new Category();
	//var arrCats = recC._getAllCategoriesByParentID(parentid);
	var arrCats = new Array();
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
	//var arrCats = recC._getAllCategoriesByParentID(parentid);
	var arrCats = new Array();
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