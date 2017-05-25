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
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Category.asp" -->
<!--#include file="../src/classes/Resource.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_RECENT = "list_recent";
var LIST_RESOURCE = "list_resource";
var NEW_RESOURCE = "new_resource";
var EDIT_RESOURCE = "edit_resource";
var SAVE_RESOURCE = "save_resource";
var DELETE_RESOURCE = "delete_resource";
var MOVE_RESOURCE_UP = "move_resource_up";
var MOVE_RESOURCE_DOWN = "move_resource_down";
var SET_STATUS = "set_status";

// global variables & default values
var CONTROLLER = "ctrlResource.asp";
var action = LIST_RECENT;

// overide default values from request
if (strContentType.toLowerCase() == "multipart/form-data") {
	action = UPL.form("action");
} else {
	if (new String(Request("action")) != "undefined") {
		action = Request("action");
	}
}




// state machine
if (action == LIST_RECENT) {

	listRecentResources();

} else if (action == LIST_RESOURCE) {

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

} else if (action == MOVE_RESOURCE_UP) {

	moveResourceUp();

} else if (action == MOVE_RESOURCE_DOWN) {

	moveResourceDown();

} else if (action == SET_STATUS) {

	setStatus();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

//GBL_CONN.close();



/*
 *	
 */
function listRecentResources() {

	var R = new Resource();
	var rsRecentResources = R._getAllRecentResources();
	
	%><!--#include file="../src/html/admin/resourceRecent.asp"--><%
}


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
	
	var intResourceTypeID = Request("resourcetypeid");
	if (isNaN(parseInt(intResourceTypeID))) {
		try {
			intResourceTypeID = parseInt(Session("yma_resourcetypeid"));
		} catch (e) {
			intResourceTypeID = 0;
		}
	} else {
		Session("yma_resourcetypeid") = parseInt(intResourceTypeID);
	}
	
//Response.Write("intCategoryID = " + new String(intCategoryID) + "<br/>");
//Response.Write("intResourceTypeID = " + new String(intResourceTypeID) + "<br/>");

	var rsAllResources = null;
	if (intCategoryID > 0 && intResourceTypeID > 0) {
		rsAllResources = R._getAllResourcesByCategoryByType(intCategoryID, intResourceTypeID);
	}
	%><!--#include file="../src/html/admin/resourceList.asp"--><%
}


/*
 *	
 */
function newResource() {

	var message = new String();
	var R = new Resource();
		R._setResourceUserID(Session("yma_userid"));

	%><!--#include file="../src/html/admin/resourceEdit.asp"--><%
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

	%><!--#include file="../src/html/admin/resourceEdit.asp"--><%
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
		R._setResourceTypeID(new Number(UPL.form("resourcetypeid")));
		R._setResourceOrder(new Number(UPL.form("order")));
		R._setResourceTitle(lightRinseForSQL(new String(UPL.form("title"))));
		R._setResourceBody(lightRinseForSQL(new String(UPL.form("body"))));
		R._setResourceExtract(cleanForSQL(new String(UPL.form("extract"))));
		R._setResourceURL(lightRinseForSQL(new String(UPL.form("url"))));
		R._setResourceLink(lightRinseForSQL(new String(UPL.form("link"))));
		R._setResourceBGColor(cleanForSQL(new String(UPL.form("bgcolor"))));
		R._setResourceDateopen(GBLMakeDate(UPL.form("openDay"),UPL.form("openMonth"),UPL.form("openYear"), UPL.form("openHour"), UPL.form("openMinute"), null));
		R._setResourceDateclosed(GBLMakeDate(UPL.form("closedDay"),UPL.form("closedMonth"),UPL.form("closedYear"), null, null, null));

		

		if (new Number(UPL.form("filesrcsm_REMOVE")) == 1) {
			R._setResourceFilesrcsm("");	
		} else {
			var arrImgResponse = saveImage("filesrcsm", null, "images/resources");
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
			var arrImgResponse = saveImage("filesrclg", null, "images/resources");
			if (arrImgResponse[0] == true) {
				R._setResourceFilesrclg(arrImgResponse[1]);	
			} else {
				if (new String(arrImgResponse[1]).length > 0) {
					strerr+=arrImgResponse[1];
				}
			}
		}



	var arrCatID = new Array();
	if (new String(UPL.form("categoryid")).indexOf("undefined") != 0) {
		arrCatID.push(new String(UPL.form("categoryid")).split(","));
	}

	var strvalid = validateResource(R, arrCatID);
	
	if (strvalid.length == 0 && strerr.length == 0) {

		if (R._getResourceID() > 0) {
			R._saveResource();	
		} else {
			//var intOrder = R._getMaxOrderByTypeByCategory(R._getResourceTypeID(), arrCatID[0]);
			R._setResourceOrder(0);
			var intResourceID = R._addResource();			
		}
		R._removeResourceFromCategory(intResourceID);
		R._addResourceToCategory(intResourceID, arrCatID);

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
function moveResourceUp() {
	var intResourceID = new Number(Request("resourceid"));
	var R = new Resource();
	if (!isNaN(intResourceID)) {
		R._reorderResourceUp(intResourceID);
	}
	endProcessPlus("action=" + LIST_RESOURCE);
}

/*
 *	
 */
function moveResourceDown() {
	var intResourceID = new Number(Request("resourceid"));
	var R = new Resource();
	if (!isNaN(intResourceID)) {
		R._reorderResourceDown(intResourceID);
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
function validateResource(R, arrCatID) {
	strErr = new String();
	if (R._getResourceTitle().length == 0 || R._getResourceTitle().indexOf("undefined") == 0) {
		strErr += " - You must provide a title for the resource item<br>";	
	}	
	if (R._getResourceBody().length == 0 && R._getResourceExtract().length == 0) {
		strErr += " - You must provide either an extract or some body text for this resource item<br>";	
	}
	if (arrCatID.length == 0) {
		strErr += " - You must choose a category for this item to be displayed in.<br>";	
	}
	
	return strErr;
}


%>


