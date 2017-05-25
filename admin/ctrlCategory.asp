<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Category.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_CATEGORY = "list_category";
var NEW_CATEGORY = "new_category";
var EDIT_CATEGORY = "edit_category";
var SAVE_CATEGORY = "save_category";
var DELETE_CATEGORY = "delete_category";

// global variables & default values
var CONTROLLER = "ctrlCategory.asp";
var action = LIST_CATEGORY;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}




// state machine
if (action == LIST_CATEGORY) {

	listCategory();

} else if (action == NEW_CATEGORY) {

	newCategory();

} else if (action == EDIT_CATEGORY) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Category Saved":""
	}
	editCategory(strmsg, null);

} else if (action == SAVE_CATEGORY) {

	saveCategory();

} else if (action == DELETE_CATEGORY) {

	removeCategory();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *	
 */
function listCategory() {

	var C = new Category();
	var rsAllCategories = C._getAllCategories();
	%><!--#include file="../src/html/admin/categoryList.asp"--><%
}


/*
 *	
 */
function newCategory() {

	var message = new String();
	var C = new Category();
		C._setCategoryUserID(Session("yma_userid"));

	%><!--#include file="../src/html/admin/categoryEdit.asp"--><%
}



/*
 *	
 */
function editCategory(message, objC) {

	var intCategoryID = new Number(Request("categoryid"));

	var C = null;

	if (objC) {
		C = objC;
	} else {
		C = new Category();
		if (!isNaN(intCategoryID)) {
			C._loadCategory(intCategoryID);
		}
	}

	%><!--#include file="../src/html/admin/categoryEdit.asp"--><%
}


/*
 *	
 */
function saveCategory() {

	var strmsg = new String();
	var intCategoryID = new Number(Request("categoryid"));

	var C = new Category();
		if (!isNaN(intCategoryID)) {
			C._loadCategory(intCategoryID);
		}
		C._setCategoryParentID(new Number(Request("parentid")));
		C._setCategoryUserID(new Number(Request("userid")));
		C._setCategoryTitle(cleanForSQL(new String(Request("title"))));
		C._setCategoryDescription(cleanForSQL(new String(Request("description"))));
		C._setCategoryURL(cleanForSQL(new String(Request("url"))));


	var strvalid = validateCategory(C);
	
	if (strvalid.length == 0) {

		if (C._getCategoryID() > 0) {
			C._saveCategory();	
		} else {
			var intCategoryID = C._addCategory();
		}
		endProcessPlus("action=" + EDIT_CATEGORY + "&categoryid=" + intCategoryID + "&intmsg=1");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editCategory(strmsg, C);
	}
}





/*
 *	
 */
function removeCategory() {

	var intCategoryID = new Number(Request("categoryid"));
	var C = new Category();
	
	if (!isNaN(intCategoryID)) {
		C._setCategoryID(intCategoryID);
		C._deleteCategory();
	}

	endProcess();
}


/*
 *	
 */
function validateCategory(C) {
	strErr = new String();
	if (C._getCategoryTitle().length == 0 || C._getCategoryTitle().indexOf("undefined") == 0) {
		strErr += " - You must provide a title for this category<br>";	
	}	
	
	return strErr;
}




%>


