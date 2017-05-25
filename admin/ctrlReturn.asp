<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/ProductCategory.asp" -->
<!--#include file="../shop/src/classes/Product.asp" -->
<!--#include file="../shop/src/classes/Inventory.asp" -->
<!--#include file="../shop/src/classes/Purchase.asp" -->
<!--#include file="../shop/src/classes/Return.asp" -->
<!--#include file="../shop/src/classes/Order.asp" -->
<!--#include file="../shop/src/classes/Note.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_RETURNS 			= "list_returns";
var VIEW_RETURN 			= "view_return";
var NEW_RETURN 				= "new_return";
var SAVE_PROCESSING_ACTION	= "save_processing_action";
var SAVE_FREIGHT_ACTION		= "save_freight_action";
var SAVE_RECIEVED_ACTION	= "save_recieved_action";
var SAVE_REFUND_ACTION		= "save_refund_action";
var SAVE_NOTE_ACTION		= "save_note_action";

// global variables & default values
var CONTROLLER				= "ctrlReturn.asp";
var action 					= LIST_RETURNS;

// overide default values from request
if (new String(Request("action")) != "undefined") {
	action = Request("action");
}

var Usr = new User();
	Usr._loadUser(Session("yma_userid"));


// state machine
if (action == LIST_RETURNS) {

	listReturns();

} else if (action == VIEW_RETURN) {

	viewReturn();

} else if (action == NEW_RETURN) {

	newReturn();

} else if (action == SAVE_PROCESSING_ACTION) {

	saveProcessingAction();

} else if (action == SAVE_FREIGHT_ACTION) {

	saveFreightAction();

} else if (action == SAVE_RECIEVED_ACTION) {

	saveReceivedAction();

} else if (action == SAVE_REFUND_ACTION) {

	saveRefundAction();

} else if (action == SAVE_NOTE_ACTION) {

	saveNoteAction();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();



/*
 *	
 */
function listReturns() {

	var R = new Return();
	var O = new Order();

	var rsReturns = R._getAllReturns();

	%><!--#include file="../src/html/admin/returnList.asp"--><%
}


/*
 *	
 */
function viewReturn() {

	var message = new String();

	var intReturnID = parseInt(Request("returnid"));

	var O = new Order();
	var P = new Purchase();
	var R = new Return();
		R._getReturn(intReturnID);
		P._loadPurchase(R._getReturnPurchaseID());

	var rsOrder = O._getOrderItemsByReturn(R._getReturnID());

	%><!--#include file="../src/html/admin/returnEdit.asp"--><%
}


/*
 *	
 */
function newReturn() {

	var message = new String();
	var intPurchaseID = parseInt(Request("purchaseid"));
	var strOrderIDs = new String(Request("order_id"));
	var O = new Order();
	var R = new Return();

	var P = new Purchase();
		P._loadPurchase(intPurchaseID);

	var rsOrder = null;
	if (strOrderIDs.indexOf("undefined") != 0 && strOrderIDs.length != 0) {
		rsOrder = O._getOrderItemsForReturn(Request("order_id"))
	}
	
	%><!-- #include file="../src/html/admin/returnEdit.asp"--><%
}


/*
 *	
 */

function saveProcessingAction() {

	var intReturnID = parseInt(Request("returnid"));
	var intPurchaseID = parseInt(Request("purchaseid"));
	var arrOrderID = new String(Request("orderid")).split(", ");
	var strDate = new Date().formatDate("jS F Y g:ia");
	var strNotes = new String(Request("notes"));
	var strGRA = new String(Request("gra_number"));
	var strType = new String(Request("return_type"));

	var O = new Order();
	var P = new Purchase();
		P._loadPurchase(intPurchaseID);

	var notes_body = "------------------------------------------\n" +
					 strDate + " : " + action + " : by " + Usr._getUserUsername() + "\n" +
					 "BASE GRA NUMBER : " + strGRA + "\n" +
					 strNotes + "\n\n";

	var R = new Return();
		R._setReturnID(intReturnID);
		R._setReturnPurchaseID(intPurchaseID);
		R._setReturnCustomerID(P._getPurchaseCustomerID());
		R._setReturnIsProcessed(new String(Request("is_processed")));
		R._setReturnBaseGRA(strGRA);
		R._setReturnType(strType);
		R._setReturnNotes(cleanForSQL(notes_body));

	if (intReturnID == 0)
	{
		intReturnID = R._addProcessingAction();
		for (i = 0; i < arrOrderID.length; i++) {
			O._saveOrderReturnID(intReturnID, arrOrderID[i]);
		}
	}
	else
	{
		R._saveProcessingAction();
	}
	R._dispatchGRAPackRequest(notes_body);

	endProcessPlus("action=" + VIEW_RETURN + "&returnid=" + intReturnID);
}

/*
 *	
 */
function saveFreightAction() {

	var intReturnID = parseInt(Request("returnid"));
	var intPurchaseID = parseInt(Request("purchaseid"));
	var strDate = new Date().formatDate("jS F Y g:ia");
	var strNotes = new String(Request("notes"));
	var strLabel = new String(Request("express_post"));

	var notes_body = "------------------------------------------\n" +
					 strDate + " : " + action + " : by " + Usr._getUserUsername() + "\n" +
					 "EXPRESS POST LABEL NUMBER : " + strLabel + "\n" +
					 strNotes + "\n\n";

	var R = new Return();
		R._setReturnID(intReturnID);
		R._setReturnConnote(strLabel);
		R._setReturnIsFreightBooked(new String(Request("is_return_freight_booked")));
		R._setReturnNotes(cleanForSQL(notes_body));
		R._saveFreightAction();
		R._dispatchGRAPackSentNotice(notes_body);
		
	endProcessPlus("action=" + VIEW_RETURN + "&returnid=" + intReturnID);
}


/*
 *	
 */
function saveReceivedAction() {

	var intReturnID = parseInt(Request("returnid"));
	var intPurchaseID = parseInt(Request("purchaseid"));
	var strDate = new Date().formatDate("jS F Y g:ia");
	var strNotes = new String(Request("notes"));


	var notes_body = "------------------------------------------\n" +
					 strDate + " : " + action + " : by " + Usr._getUserUsername() + "\n" +
					 strNotes + "\n\n";

	var R = new Return();
		R._getReturn(intReturnID);
		R._setReturnPurchaseID(intPurchaseID);
		R._setReturnIsReceived(new String(Request("is_received")));
		R._setReturnNotes(cleanForSQL(notes_body));
		R._saveReceivedAction();
		R._generateCustomerReturnDetails();
		
		if (R._getReturnType().indexOf("REFUND") == 0) 
		{
			R._dispatchCreditRefundRequest(notes_body);
		} 
		else 
		{
			R._dispatchSalesReplacementRequest(notes_body);
		}

	endProcessPlus("action=" + VIEW_RETURN + "&returnid=" + intReturnID);
}


/*
 *	
 */
function saveRefundAction() {

	var intReturnID = parseInt(Request("returnid"));
	var intPurchaseID = parseInt(Request("purchaseid"));
	var strDate = new Date().formatDate("jS F Y g:ia");
	var strNotes = new String(Request("notes"));
	var strReceipt = new String(Request("receipt"))
	var notes_body = "------------------------------------------\n" +
				     strDate + " : " + action + " : by " + Usr._getUserUsername() + "\n";
						 
	var P = new Purchase();
	var R = new Return();
		R._getReturn(intReturnID);

		if (R._getReturnType().indexOf("REFUND") == 0) 
		{
			notes_body += "REFUND RECEIPT NUMBER : " + strReceipt + "\n" +
						  strNotes + "\n\n";
		} 
		else 
		{
			notes_body += "REPLACEMENT ORDER NUMBER : " + strReceipt + "\n" +
						  strNotes + "\n\n";
		}

		R._setReturnPurchaseID(intPurchaseID);
		R._setReturnIsItemRefunded(new String(Request("is_item_refunded")));
		R._setReturnNotes(cleanForSQL(notes_body));
		R._setReturnReceipt(strReceipt);
		R._saveRefundAction();
		R._generateCustomerReturnDetails();

	var O = new Order();
		O._saveOrderReturnStatus(intReturnID);

		if (R._getReturnType().indexOf("REFUND") == 0) 
		{
			R._dispatchCustomerRefundNotice();
			endProcessPlus("action=" + VIEW_RETURN + "&returnid=" + intReturnID);
		} 
		else 
		{
			var intReplacementPurchaseID = 0;

			P._loadPurchase(intPurchaseID);
			P._setPurchaseNotes("REPLACEMENT ITEM : <a href=\"ctrlReturn.asp?action=view_return&returnid=" + intReturnID + "\">VIEW RETURN RECORD</a>");
			intReplacementPurchaseID = P._addPurchase();
			
			var rsReturnOrderItems = O._getOrderItemsByReturn(intReturnID);
			while (!rsReturnOrderItems.EOF) 
			{
				O._setOrderPurchaseID(intReplacementPurchaseID);
				O._setOrderCustomerID(rsReturnOrderItems("customerid"));
				O._setOrderProductID(rsReturnOrderItems("productid"));
				O._setOrderInventoryID(rsReturnOrderItems("inventoryid"));
				O._setOrderQuantity(rsReturnOrderItems("quantity"));
				O._setOrderItemcode(rsReturnOrderItems("itemcode"));
				O._setOrderName(rsReturnOrderItems("name"));
				O._setOrderPricequoted(parseFloat(rsReturnOrderItems("pricequoted")).toFixed(2));

				O._addOrder();
			
				rsReturnOrderItems.MoveNext();
			}
			
			R._dispatchCustomerReplacementNotice();
			
			Response.Redirect("ctrlPurchase.asp?action=view_purchase&purchaseid=" + intReplacementPurchaseID);
			
		}


}


/*
 *	
 */
function saveNoteAction() {
	var intReturnID = parseInt(Request("returnid"));
	var intPurchaseID = parseInt(Request("purchaseid"));
	var strDate = new Date().formatDate("jS F Y g:ia");
	var strNotes = new String(Request("notes"));

	var notes_body = "------------------------------------------\n" +
					 strDate + " : " + action + " : by " + Usr._getUserUsername() + "\n" +
					 strNotes + "\n\n";

	var R = new Return();
		R._setReturnID(intReturnID);
		R._setReturnPurchaseID(intPurchaseID);
		R._setReturnNotes(cleanForSQL(notes_body));

		R._saveNotesAction();

	endProcessPlus("action=" + VIEW_RETURN + "&returnid=" + intReturnID);
}




%>


