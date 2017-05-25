<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/ProductCategory.asp" -->
<!--#include file="../src/classes/Service.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var SERVICE_SEARCH = "service_search";
var NEW_SERVICE = "new_service";
var EDIT_SERVICE = "edit_service";
var SAVE_SERVICE = "save_service";
var DELETE_SERVICE = "delete_service";

// global variables & default values
var CONTROLLER = "ctrlServiceCentre.asp";
var action = SERVICE_SEARCH;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}




// state machine
if (action == SERVICE_SEARCH) {

	serviceSearch();

} else if (action == NEW_SERVICE) {

	newService();

} else if (action == EDIT_SERVICE) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Service Saved":""
	}
	editService(strmsg, null);

} else if (action == SAVE_SERVICE) {

	saveService();

} else if (action == DELETE_SERVICE) {

	removeService();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();





/*
 *	
 */
function serviceSearch() {

	var P = new ProductCategory();
	var S = new Service();

	var intProductID = Request("productid");
	if (isNaN(new Number(intProductID))) {
		intProductID = Session("yma_productid");
	} else {
		Session("yma_productid") = parseInt(Request("productid"));
	}


	var strState = Request("state");
	if (new String(strState).indexOf("undefined")==0) {
		strState = Session("yma_strstate");
		try {
			strState = new String(Session("yma_strstate"));
		} catch (e) {
			strState = new String("");
		}
	} else {
		Session("yma_strstate") = new String(Request("state"));
	}

	var rsServiceSearch = S._serviceSearch(intProductID, strState);

	%><!--#include file="../src/html/admin/servicecentreHome.asp"--><%
}

/*
 *	
 */
function newService() {

	var message = new String();
	var S = new Service();

	%><!--#include file="../src/html/admin/servicecentreEdit.asp"--><%
}



/*
 *	
 */
function editService(message, objS) {

	var intServiceID = new Number(Request("serviceid"));

	var S = null;

	if (objS) {
		S = objS;
	} else {
		S = new Service();
		if (!isNaN(intServiceID)) {
			S._loadService(intServiceID);
		}
	}

	%><!--#include file="../src/html/admin/servicecentreEdit.asp"--><%
}


/*
 *	
 */
function saveService() {

	var strmsg = new String();
	var intServiceID = new Number(Request("serviceid"));

	var S = new Service();
		if (!isNaN(intServiceID)) {
			S._loadService(intServiceID);
		}
		S._setServiceRCTIflag(new Number(Request("rctiflag"))==1?1:0);
		S._setServiceABN(cleanForSQL(new String(Request("abn"))));
		S._setServiceName(cleanForSQL(new String(Request("name"))));
		S._setServiceVendorcode(new String(Request("vendorcode")));
		S._setServiceDealercode(new String(Request("dealercode")));
		S._setServiceAddress(cleanForSQL(new String(Request("address"))));
		S._setServiceCity(cleanForSQL(new String(Request("city"))));
		S._setServiceState(cleanForSQL(new String(Request("state"))));
		S._setServiceCountry(cleanForSQL(new String(Request("country"))));
		S._setServicePostcode(cleanForSQL(new String(Request("postcode"))));
		S._setServiceEmail(cleanForSQL(new String(Request("email"))));
		S._setServicePhone(cleanForSQL(new String(Request("phone"))));
		S._setServiceMobile(cleanForSQL(new String(Request("mobile"))));
		S._setServiceFax(cleanForSQL(new String(Request("fax"))));
		S._setServiceURL(cleanForSQL(new String(Request("url"))));

	var strvalid = validateService(S);

	var arrProductID = new Array();
	if (new String(Request("productid")).indexOf("undefined") != 0) {
		arrProductID.push(new String(Request("productid")).split(","));
	}

	
	if (strvalid.length == 0) {

		if (S._getServiceID() > 0) {
			S._saveService();	
		} else {
			var intServiceID = S._addService();
		}
		S._removeServiceFromProduct(intServiceID);
		S._addServiceToProduct(intServiceID, arrProductID);

		endProcessPlus("action=" + EDIT_SERVICE + "&serviceid=" + intServiceID + "&intmsg=1");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editService(strmsg, S);
	}
}





/*
 *	
 */
function removeService() {

	var intServiceID = new Number(Request("serviceid"));
	var S = new Service();
	
	if (!isNaN(intServiceID)) {
		S._setServiceID(intServiceID);
		S._deleteService();
	}

	endProcess();
}


/*
 *	
 */
function validateService(S) {
	strErr = new String();
	if (S._getServiceName().length == 0 || S._getServiceName().indexOf("undefined") == 0) {
		strErr += " - You must provide the service business name<br>";	
	}	
	if (S._getServiceAddress().length == 0 || S._getServiceAddress().indexOf("undefined") == 0) {
		strErr += " - You must provide the service address<br>";	
	}	
	if (S._getServiceCity().length == 0 || S._getServiceCity().indexOf("undefined") == 0) {
		strErr += " - You must provide the service city<br>";	
	}	
	if (S._getServiceState().length == 0 || S._getServiceState().indexOf("undefined") == 0) {
		strErr += " - You must provide the service state<br>";	
	}	
	if (S._getServicePostcode().length == 0 || S._getServicePostcode().indexOf("undefined") == 0) {
		strErr += " - You must provide the service postcode<br>";	
	}	
	if (S._getServicePhone().length == 0 || S._getServicePhone().indexOf("undefined") == 0) {
		strErr += " - You must provide the service phone<br>";	
	}	
	
	return strErr;
}




%>


