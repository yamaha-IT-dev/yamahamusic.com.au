<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/ProductCategory.asp" -->
<!--#include file="../src/classes/Dealer.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var DEALER_SEARCH = "dealer_search";
var NEW_DEALER = "new_dealer";
var EDIT_DEALER = "edit_dealer";
var SAVE_DEALER = "save_dealer";
var DELETE_DEALER = "delete_dealer";

// global variables & default values
var CONTROLLER = "ctrlDealer.asp";
var action = DEALER_SEARCH;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}




// state machine
if (action == DEALER_SEARCH) {

	dealerSearch();

} else if (action == NEW_DEALER) {

	newDealer();

} else if (action == EDIT_DEALER) {
	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Dealer Saved":""
	}
	editDealer(strmsg, null);

} else if (action == SAVE_DEALER) {

	saveDealer();

} else if (action == DELETE_DEALER) {

	removeDealer();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();





/*
 *	
 */
function dealerSearch() {

	var P = new ProductCategory();
	var D = new Dealer();

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
	
	var strRegion = Request("region");
	if (new String(strRegion).indexOf("undefined")==0 && new String(strRegion).length != 0) {
		strRegion = Session("yma_strregion");
		try {
			strRegion = new String(Session("yma_strregion"));
		} catch (e) {
			strRegion = new String("");
		}
	} else {
		Session("yma_strregion") = new String(Request("region"));
	}

	var rsDealerSearch = D._dealerSearch(intProductID, strState, strRegion);

	%><!--#include file="../src/html/admin/dealerHome.asp"--><%
}

/*
 *	
 */
function newDealer() {

	var message = new String();
	var D = new Dealer();

	%><!--#include file="../src/html/admin/dealerEdit.asp"--><%
}



/*
 *	
 */
function editDealer(message, objD) {

	var intDealerID = new Number(Request("dealerid"));

	var D = null;

	if (objD) {
		D = objD;
	} else {
		D = new Dealer();
		if (!isNaN(intDealerID)) {
			D._loadDealer(intDealerID);
		}
	}

	%><!--#include file="../src/html/admin/dealerEdit.asp"--><%
}


/*
 *	
 */
function saveDealer() {

	var strmsg = new String();
	var intDealerID = new Number(Request("dealerid"));

	var D = new Dealer();
		if (!isNaN(intDealerID)) {
			D._loadDealer(intDealerID);
		}
		D._setDealerPronetwork(new Number(Request("pronetwork"))==1?1:0);
		D._setDealerClavplatinum(new Number(Request("clavplatinum"))==1?1:0);
		D._setDealerNirprogram(new Number(Request("nirprogram"))==1?1:0);
		D._setDealerName(cleanForSQL(new String(Request("name"))));
		D._setDealerAddress(cleanForSQL(new String(Request("address"))));
		D._setDealerCity(cleanForSQL(new String(Request("city"))));
		D._setDealerState(cleanForSQL(new String(Request("state"))));
		D._setDealerCountry(cleanForSQL(new String(Request("country"))));
		D._setDealerPostcode(cleanForSQL(new String(Request("postcode"))));
		D._setDealerRegion(cleanForSQL(new String(Request("region"))));
		D._setDealerEmail(cleanForSQL(new String(Request("email"))));
		D._setDealerPhone(cleanForSQL(new String(Request("phone"))));
		D._setDealerFax(cleanForSQL(new String(Request("fax"))));
		D._setDealerURL(cleanForSQL(new String(Request("url"))));

	var strvalid = validateDealer(D);

	var arrProductID = new Array();
	if (new String(Request("productid")).indexOf("undefined") != 0) {
		arrProductID.push(new String(Request("productid")).split(","));
	}

	
	if (strvalid.length == 0) {

		if (D._getDealerID() > 0) {
			D._saveDealer();	
		} else {
			var intDealerID = D._addDealer();
		}
		D._removeDealerFromProduct(intDealerID);
		D._addDealerToProduct(intDealerID, arrProductID);

		endProcessPlus("action=" + EDIT_DEALER + "&dealerid=" + intDealerID + "&intmsg=1");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editDealer(strmsg, D);
	}
}





/*
 *	
 */
function removeDealer() {

	var intDealerID = new Number(Request("dealerid"));
	var D = new Dealer();
	
	if (!isNaN(intDealerID)) {
		D._setDealerID(intDealerID);
		D._deleteDealer();
	}

	endProcess();
}


/*
 *	
 */
function validateDealer(D) {
	strErr = new String();
	if (D._getDealerName().length == 0 || D._getDealerName().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer business name<br>";	
	}	
	if (D._getDealerAddress().length == 0 || D._getDealerAddress().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer address<br>";	
	}	
	if (D._getDealerCity().length == 0 || D._getDealerCity().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer city<br>";	
	}	
	if (D._getDealerState().length == 0 || D._getDealerState().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer state<br>";	
	}	
	if (D._getDealerRegion().length == 0 || D._getDealerRegion().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer region<br>";	
	}	
	if (D._getDealerCountry().length == 0 || D._getDealerCountry().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer country<br>";	
	}	
	if (D._getDealerPostcode().length == 0 || D._getDealerPostcode().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer postcode<br>";	
	}	
	if (D._getDealerPhone().length == 0 || D._getDealerPhone().indexOf("undefined") == 0) {
		strErr += " - You must provide the dealer phone<br>";	
	}	
	
	return strErr;
}




%>


