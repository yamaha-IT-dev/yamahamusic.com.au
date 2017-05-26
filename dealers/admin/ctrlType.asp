<%@LANGUAGE="JScript"%>
<!--#include file="../../src/global.asp" -->
<!--#include file="../../src/utility.asp" -->
<!--#include file="../../src/classes/User.asp" -->
<!--#include file="../src/classes/Type.asp" -->
<!--#include file="../../src/logincheck.asp" -->
<%


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_TYPE = "list_type";
var NEW_TYPE = "new_type";
var EDIT_TYPE = "edit_type";
var SAVE_TYPE = "save_type";
var DELETE_TYPE = "delete_type";

// global variables & default values
var CONTROLLER = "ctrlType.asp";
var action = LIST_TYPE;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}

var _DIVISION = parseInt(Session("yma_division"))==3?"TRAD":"MPD";

// state machine
if (action == LIST_TYPE) {

	listType();

} else if (action == NEW_TYPE) {

	newType();

} else if (action == EDIT_TYPE) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Type Saved":""
	}
	editType(strmsg, null);

} else if (action == SAVE_TYPE) {

	saveType();

} else if (action == DELETE_TYPE) {

	removeType();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *
 */
function listType() {

	var T = new Type();
	var rsAllTypes = T._getAllTypes(_DIVISION);
	%><!--#include file="../src/html/adminTypeList.asp"--><%
}


/*
 *
 */
function newType() {

	var message = new String();
	var T = new Type();
		T._setTypeDivision(_DIVISION);
		T._setTypeStatus(1);

	%><!--#include file="../src/html/adminTypeEdit.asp"--><%
}



/*
 *
 */
function editType(message, objT) {

	var intTypeID = new Number(Request("typeid"));

	var T = null;

	if (objT) {
		T = objT;
	} else {
		T = new Type();
		if (!isNaN(intTypeID)) {
			T._loadType(intTypeID);
		}
	}

	%><!--#include file="../src/html/adminTypeEdit.asp"--><%
}


/*
 *
 */
function saveType() {

	var strmsg = new String();
	var intTypeID = new Number(Request("typeid"));

	var T = new Type();
		if (!isNaN(intTypeID)) {
			T._loadType(intTypeID);
		}
		T._setTypeStatus(parseInt(Request("status"))==1?1:0);
		T._setTypeDivision(cleanForSQL(new String(Request("division"))));
		T._setTypeType(cleanForSQL(new String(Request("type"))));
		T._setTypeName(cleanForSQL(new String(Request("name"))));
		T._setTypeDescription(cleanForSQL(new String(Request("description"))));


	var strvalid = validateType(T);

	if (strvalid.length == 0) {

		if (T._getTypeID() > 0) {
			T._saveType();
		} else {
			var intTypeID = T._addType();
		}
		endProcessPlus("action=" + EDIT_TYPE + "&typeid=" + intTypeID + "&intmsg=1");

	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editType(strmsg, C);
	}
}





/*
 *
 */
function removeType() {

	var intTypeID = new Number(Request("typeid"));
	var T = new Type();

	if (!isNaN(intTypeID)) {
		T._setTypeID(intTypeID);
		T._deleteType();
	}

	endProcess();
}


/*
 *
 */
function validateType(T) {
	strErr = new String();
	if (T._getTypeName().length == 0 || T._getTypeName().indexOf("undefined") == 0) {
		strErr += " - You must provide a name for this resource type<br>";
	}

	return strErr;
}




%>


