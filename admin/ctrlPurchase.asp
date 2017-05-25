<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/ProductCategory.asp" -->
<!--#include file="../shop/src/classes/Product.asp" -->
<!--#include file="../shop/src/classes/Inventory.asp" -->
<!--#include file="../shop/src/classes/Purchase.asp" -->
<!--#include file="../shop/src/classes/Order.asp" -->
<!--#include file="../shop/src/classes/Note.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_PURCHASES = "list_purchases";
var VIEW_PURCHASE = "view_purchase";
var SAVE_SALES_ACTION = "save_sales_action";
var SAVE_FULFILLMENT_ACTION = "save_fulfillment_action";

// global variables & default values
var CONTROLLER = "ctrlPurchase.asp";
var action = LIST_PURCHASES;

// overide default values from request
if (new String(Request("action")) != "undefined") {
	action = Request("action");
}

// state machine
if (action == LIST_PURCHASES) {

	listPurchases();

} else if (action == VIEW_PURCHASE) {

	viewPurchase();

} else if (action == SAVE_SALES_ACTION) {

	saveSalesAction();

} else if (action == SAVE_FULFILLMENT_ACTION) {

	saveFulfillmentAction();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();



/*
 *	
 */
function listPurchases() {

	var P = new Purchase();
	var O = new Order();
	var d = new Date();
	var sYear = d.getFullYear();
	
	var intmonth = parseInt(new String(Request("month")));
	var intyear = parseInt(new String(Request("year")));
	var strbillname = new String(Request("billname"));
	var stritemcode = new String(Request("itemcode"));

	if (!isNaN(intmonth) && !isNaN(intyear)) {

// Response.Write(intmonth + "<br/>");	
// Response.Write(intyear + "<br/>");	
	
		d.setMonth(intmonth);
		d.setYear(intyear);
	} else {
		intmonth = d.getMonth();
		intyear = d.getYear();
	}
	if (parseInt(Request("month")) == -1) {
		intmonth = -1;
	}


	//var arrPurchases = P._getAllPurchasesByMonth(d.getMonth()+1, d.getYear());
	var arrPurchases = P._searchPurchases(intmonth+1, intyear, strbillname, stritemcode);


	%><!--#include file="../src/html/admin/purchaseList.asp"--><%
}


/*
 *	
 */
function viewPurchase() {

	var message = new String();
	var intPurchaseID = parseInt(Request("purchaseid"));
	var N = new Note();
	var O = new Order();
	var P = new Purchase();
		P._loadPurchase(intPurchaseID);

	%><!--#include file="../src/html/admin/purchaseView.asp"--><%
}




/*
 *	
 */

function saveSalesAction() {

	var intPurchaseID = parseInt(Request("purchaseid"));

	var P = new Purchase();
		P._loadPurchase(intPurchaseID);
		P._setPurchaseIsProcessed(new String(Request("is_processed")));
		P._setPurchaseBaseorder(new String(Request("base_order")));
		P._savePurchaseSalesAction();

		P._generateMailbody();
		P._dispatchFulfilmentRequest();

	endProcessPlus("action=" + VIEW_PURCHASE + "&purchaseid=" + intPurchaseID);
}

/*
 *	
 */
function saveFulfillmentAction() {

	var intPurchaseID = parseInt(Request("purchaseid"));

	var P = new Purchase();
		P._loadPurchase(intPurchaseID);
		P._setPurchaseIsFulfilled(new String(Request("is_fulfilled")));
		P._setPurchaseBaseinvoice(new String(Request("base_invoice")));
		P._setPurchaseConnote(new String(Request("connote")));
		P._savePurchaseFulfillmentAction();

		P._generateMailbody();
		P._dispatchFulfillmentEmailToCustomer();
		P._dispatchFulfillmentEmailToYMASales();

	endProcessPlus("action=" + VIEW_PURCHASE + "&purchaseid=" + intPurchaseID);
}



%>


