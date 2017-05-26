<%@LANGUAGE="JScript"%>
<%
	Server.ScriptTimeout = 3600;
	var UPL = Server.CreateObject("SoftArtisans.FileUp");
	var strContentType = new String(Request.ServerVariables("HTTP_CONTENT_TYPE"));
	var nPos = strContentType.indexOf(";");

	if (strContentType.length > 0 && nPos > 0) {
		strContentType = strContentType.substring(0, nPos);
	}

%>
<!--#include file="../../src/global.asp" -->
<!--#include file="../../src/utility.asp" -->
<!--#include file="../../src/classes/User.asp" -->
<!--#include file="../../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Category.asp" -->
<!--#include file="../src/classes/Resource.asp" -->
<!--#include file="../../src/logincheck.asp" -->
<%


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_RESOURCE = "list_resource";
var NEW_RESOURCE = "new_resource";
var EDIT_RESOURCE = "edit_resource";
var SAVE_RESOURCE = "save_resource";
var DELETE_RESOURCE = "delete_resource";
var SET_STATUS = "set_status";

// global variables & default values
var CONTROLLER = "ctrlResource.asp";
var action = LIST_RESOURCE;

// overide default values from request
if (strContentType.toLowerCase() == "multipart/form-data") {
	action = UPL.form("action");
} else {
	if (new String(Request("action")) != "undefined") {
		action = Request("action");
	}
}



var _DIVISION = parseInt(Session("yma_division"))==3?"TRAD":"MPD";

// state machine
if (action == LIST_RESOURCE) {

	listResources();

} else if (action == NEW_RESOURCE) {

	newResource();

} else if (action == EDIT_RESOURCE) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Resource Saved":""
	}
	editResource(strmsg, null);

} else if (action == SAVE_RESOURCE) {

	saveResource();

} else if (action == DELETE_RESOURCE) {

	removeResource();

} else if (action == SET_STATUS) {

	setStatus();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();



/*
 *
 */
function listResources() {

	var R = new Resource();
	var intCategoryID = Request("categoryid");

	if (isNaN(parseInt(intCategoryID))) {
		try {
			intCategoryID = parseInt(Session("yma_categoryid"));
		} catch (e) {
			intCategoryID = 0;
		}
	} else {
		Session("yma_categoryid") = parseInt(intCategoryID);
	}

	var intResourceTypeID = Request("typeid");
	if (isNaN(parseInt(intResourceTypeID))) {
		try {
			intResourceTypeID = parseInt(Session("yma_typeid"));
		} catch (e) {
			intResourceTypeID = 0;
		}
	} else {
		Session("yma_typeid") = parseInt(intResourceTypeID);
	}

// Response.Write("intCategoryID = " + new String(intCategoryID) + "<br/>");
// Response.Write("intResourceTypeID = " + new String(intResourceTypeID) + "<br/>");

	var rsAllResources = null;
	if (intCategoryID > 0 && intResourceTypeID > 0) {
		rsAllResources = R._getAllResourcesByCategoryByType(intCategoryID, _DIVISION, intResourceTypeID);
	}
	%><!--#include file="../src/html/adminResourceList.asp"--><%
}




/*
 *
 */
function newResource() {

	var message = new String();
	var R = new Resource();
		R._setResourceUserID(Session("yma_userid"));
		R._setResourceDivision(_DIVISION);

	%><!--#include file="../src/html/adminResourceEdit.asp"--><%
}



/*
 *
 */
function editResource(message, objR) {

	var intResourceID = null;
	if (strContentType.toLowerCase() == "multipart/form-data") {
		intResourceID = new Number(UPL.form("resourceid"));
	} else {
		intResourceID = new Number(Request("resourceid"));
	}

	var R = null;

	if (objR) {
		R = objR;
	} else {
		R = new Resource();
		if (!isNaN(intResourceID)) {
			R._loadResource(intResourceID);
		}
	}

	%><!--#include file="../src/html/adminResourceEdit.asp"--><%
}




/*
 *
 */
function saveResource() {

	var strmsg = new String();
	var strerr = new String();
	var intResourceID = new Number(UPL.form("resourceid"));

	var R = new Resource();
		if (!isNaN(intResourceID)) {
			R._loadResource(intResourceID);
		}
		R._setResourceUserID(new Number(UPL.form("userid")));
		R._setResourceTypeID(parseInt(UPL.form("typeid")));
		R._setResourceCategoryID(parseInt(UPL.form("categoryid")));
		R._setResourceDivision(lightRinseForSQL(new String(UPL.form("division"))));
		R._setResourceOnrequest(parseInt(UPL.form("onrequest"))==1?1:0);
		R._setResourceName(lightRinseForSQL(new String(UPL.form("name"))));
		R._setResourceDescription(lightRinseForSQL(new String(UPL.form("description"))));

		if (new Number(UPL.form("filesrcsm_REMOVE")) == 1) {
			R._setResourceFilesrcsm("");
		} else {
			var arrImgResponse = saveImage("filesrcsm", null, "images/dealerex");
			if (arrImgResponse[0] == true) {
				R._setResourceFilesrcsm(arrImgResponse[1]);
			} else {
				if (new String(arrImgResponse[1]).length > 0) {
					strerr+=arrImgResponse[1];
				}
			}
		}

		if (new Number(UPL.form("filesrclg_REMOVE")) == 1) {
			R._setResourceFilesrclg("");
		} else {
			var arrImgResponse = saveImage("filesrclg", null, "images/dealerex");
			if (arrImgResponse[0] == true) {
				R._setResourceFilesrclg(arrImgResponse[1]);
			} else {
				if (new String(arrImgResponse[1]).length > 0) {
					strerr+=arrImgResponse[1];
				}
			}
		}

	var strvalid = validateResource(R);

	if (strvalid.length == 0 && strerr.length == 0) {

		if (R._getResourceID() > 0) {
			R._saveResource();
		} else {
			var intResourceID = R._addResource();
		}

		endProcessPlus("action=" + EDIT_RESOURCE + "&resourceid=" + intResourceID + "&intmsg=1");

	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editResource(strmsg + strerr, R);
	}
}





/*
 *
 */
function removeResource() {

	var intResourceID = new Number(Request("resourceid"));
	var R = new Resource();

	if (!isNaN(intResourceID)) {
		R._setResourceID(intResourceID);
		R._deleteResource();
	}
	endProcessPlus("action=" + LIST_RESOURCE);
}




/*
 *
 */
function setStatus() {
	var arrResourceID = new Array();
	var strResourceID = new String(Request("resourceid"));
	if (strResourceID.indexOf("undefined") != 0) {
		var R = new Resource();
		arrResourceID = strResourceID.split(", ");
		for (var i=0; i < arrResourceID.length; i++) {
			var intStatus = !isNaN(new Number(Request("status_" + arrResourceID[i])))?1:0;

			R._setResourceID(arrResourceID[i]);
			R._setResourceStatus(intStatus);
			R._saveResourceStatus();

		}
	}
	endProcessPlus("action=" + LIST_RESOURCE);
}




/*
 *
 */
function validateResource(R) {
	strErr = new String();

	if (R._getResourceTypeID() == 0) {
		strErr += " - You must specify a <strong>type</strong> for this item<br>";
	}

	if (R._getResourceCategoryID() == 0) {
		strErr += " - You must choose a <strong>category</strong> for this item<br>";
	}

	if (R._getResourceName().length == 0 || R._getResourceName().indexOf("undefined") == 0) {
		strErr += " - You must give this item a <strong>name</strong><br>";
	}

	return strErr;
}


%>


