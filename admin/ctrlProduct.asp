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
<!--#include file="../src/classes/ProductCategory.asp" -->
<!--#include file="../shop/src/classes/Product.asp" -->
<!--#include file="../shop/src/classes/Inventory.asp" -->
<!--#include file="../src/logincheck.asp" -->
<% 


// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var LIST_PRODUCTS = "list_products";
var NEW_PRODUCT = "new_product";
var EDIT_PRODUCT = "edit_product";
var SAVE_PRODUCT = "save_product";
var DELETE_PRODUCT = "delete_product";
var SET_STATUS = "set_status";

var SAVE_INVENTORY = "save_inventory";
var DELETE_INVENTORY = "delete_inventory";

// global variables & default values
var CONTROLLER = "ctrlProduct.asp";
var action = LIST_PRODUCTS;

// overide default values from request
if (strContentType.toLowerCase() == "multipart/form-data") {
	action = UPL.form("action");
} else {
	if (new String(Request("action")) != "undefined") {
		action = Request("action");
	}
}


var ARR_CLASSIFICATION = new Array("PREMIUM", "REGULAR", "SALE", "MERCHANDISE");


// state machine
if (action == LIST_PRODUCTS) {

	listProducts();

} else if (action == NEW_PRODUCT) {

	newProduct();

} else if (action == EDIT_PRODUCT) {

	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		strmsg = intmsg==1?"Product Saved":""
		strmsg = intmsg==2?"Inventory Saved":""
		strmsg = intmsg==3?"Inventory Deleted":""
	}
	editProduct(strmsg, null);

} else if (action == SAVE_PRODUCT) {

	saveProduct();

} else if (action == DELETE_PRODUCT) {

	removeProduct();

} else if (action == SET_STATUS) {

	setStatus();

} else if (action == SAVE_INVENTORY) {

	saveInventory();

} else if (action == DELETE_INVENTORY) {

	deleteInventory();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();



/*
 *	
 */
function listProducts() {

	var P = new Product();
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
	
//Response.Write("intCategoryID = " + new String(intCategoryID) + "<br/>");
//Response.Write("intResourceTypeID = " + new String(intResourceTypeID) + "<br/>");

	var rsAllProducts = null;
		rsAllProducts = P._getAllProductsByCategoryAdmin(intCategoryID, "", null, false);

	%><!--#include file="../src/html/admin/productList.asp"--><%
}


/*
 *	
 */
function newProduct() {

	var message = new String();
	var intInventoryID = 0;
	var P = new Product();
		P._setProductUserID(Session("yma_userid"));

	%><!--#include file="../src/html/admin/productEdit.asp"--><%
}



/*
 *	
 */
function editProduct(message, objP, objI) {

	var P = null;
	var I = null;
	var intProductID = null;
	var intInventoryID = 0;

	if (strContentType.toLowerCase() == "multipart/form-data") {
		intProductID = new Number(UPL.form("productid"));
	} else {
		intProductID = new Number(Request("productid"));
		intInventoryID = new Number(Request("inventoryid"));
	}

	if (objP) {
		P = objP;
	} else {
		P = new Product();
		if (!isNaN(intProductID)) {
			P._loadProduct(intProductID);
		}
	}
	
	if (objI) {
		I = objI;
	} else {
		I = new Inventory();
		if (!isNaN(intInventoryID)) {
			I._loadInventory(intInventoryID);
		}
	}
	
	%><!--#include file="../src/html/admin/productEdit.asp"--><%
}



/*
 *	
 */
function saveProduct() {

	var strmsg = new String();
	var strerr = new String();

	var intProductID = new Number(UPL.form("productid"));

	var P = new Product();
		if (!isNaN(intProductID)) {
			P._loadProduct(intProductID);
		}
		P._setProductUserID(parseInt(UPL.form("userid")));
		P._setProductCategoryID(parseInt(UPL.form("categoryid")));
		P._setProductClassification(cleanForSQL(new String(UPL.form("classification"))));
		P._setProductItemcode(cleanForSQL(new String(UPL.form("itemcode"))));
		P._setProductName(cleanForSQL(new String(UPL.form("name"))));
		P._setProductDescshort(cleanForSQL(new String(UPL.form("descshort"))));
		P._setProductDesclong(cleanForSQL(new String(UPL.form("desclong"))));

		if (new Number(UPL.form("imagesm_REMOVE")) == 1) {
			P._setProductImagesm("");	
		} else {
			var arrImgResponse = saveImage("imagesm", null, "images/products");
			if (arrImgResponse[0] == true) {
				P._setProductImagesm(arrImgResponse[1]);	
			} else {
				if (new String(arrImgResponse[1]).length > 0) {
					strerr+=arrImgResponse[1];
				}
			}
		}

		if (new Number(UPL.form("imagelg_REMOVE")) == 1) {
			P._setProductImagelg("");	
		} else {
			var arrImgResponse = saveImage("imagelg", null, "images/products");
			if (arrImgResponse[0] == true) {
				P._setProductImagelg(arrImgResponse[1]);	
			} else {
				if (new String(arrImgResponse[1]).length > 0) {
					strerr+=arrImgResponse[1];
				}
			}
		}


	var strvalid = validateProduct(P);
	
	if (strvalid.length == 0 && strerr.length == 0) {

		if (P._getProductID() > 0) 
		{
			P._saveProduct();	
		} 
		else 
		{
			var intProductID = P._addProduct();
		}

		endProcessPlus("action=" + EDIT_PRODUCT + "&productid=" + intProductID + "&intmsg=1");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		editProduct(strmsg + strerr, P);
	}
}





/*
 *	
 */
function removeProduct() {

	var intProductID = new Number(Request("productid"));
	var P = new Product();
	
	if (!isNaN(intResourceID)) {
		P._setProductID(intProductID);
		P._deleteProduct();
	}
	endProcessPlus("action=" + LIST_PRODUCTS);
}



/*
 *	
 */
function setStatus() {
	var arrProductID = new Array();
	var strProductID = new String(Request("productid"));
	if (strProductID.indexOf("undefined") != 0) {
		var P = new Product();
		arrProductID = strProductID.split(", ");
		for (var i=0; i < arrProductID.length; i++) {
		
			var intStatus = !isNaN(new Number(Request("status_" + arrProductID[i])))?1:0;

			P._setProductID(arrProductID[i]);
			P._setProductStatus(intStatus);
			P._saveProductStatus();

		}
	}
	endProcessPlus("action=" + LIST_PRODUCTS);
}



/*
 *	
 */
function saveInventory() {

	var strmsg = new String();

	var intProductID = new Number(Request("productid"));
	var intInventoryID = new Number(Request("inventoryid"));

	var P = new Product();	
	var I = new Inventory();
		if (!isNaN(intInventoryID)) {
			I._loadInventory(intInventoryID);
		}
		I._setInventoryProductID(parseInt(Request("productid")));
		I._setInventoryUserID(parseInt(Request("userid")));
		I._setInventoryInstock(isNaN(parseInt(Request("instock")))?0:parseInt(Request("instock")));
		I._setInventoryAttribute(cleanForSQL(new String(Request("attribute"))));
		I._setInventoryName(cleanForSQL(new String(Request("name"))));
		I._setInventoryPriceretail(isNaN(parseFloat(Request("priceretail")))?0:parseFloat(Request("priceretail")).toFixed(2));
		I._setInventoryPricepromo(isNaN(parseFloat(Request("pricepromo")))?0:parseFloat(Request("pricepromo")).toFixed(2));
		I._setInventoryPricediscount(isNaN(parseFloat(Request("pricediscount")))?0:parseFloat(Request("pricediscount")).toFixed(2));

	var strvalid = validateInventory(I);
	
	if (strvalid.length == 0) {

		if (I._getInventoryID() > 0) {
			I._saveInventory();	
		} else {
			var intInventoryID = I._addInventory();
		}
		endProcessPlus("action=" + EDIT_PRODUCT + "&productid=" + intProductID + "&intmsg=2");		
	
	} else {
		strmsg = "These details cannot be saved at this time, check the details below and try again<br/>" + strvalid;
		P._loadProduct(intProductID);
		editProduct(strmsg, P, I);
	}
}


/*
 *	
 */
function deleteInventory() {
	
	var intProductID = new Number(Request("productid"));
	var intInventoryID = new Number(Request("inventoryid"));
	if (!isNaN(intInventoryID)) {
		var I = new Inventory();
			I._setInventoryID(intInventoryID);
			I._deleteInventory();
	}
		endProcessPlus("action=" + EDIT_PRODUCT + "&productid=" + intProductID + "&intmsg=3");		
}



/*
 *	
 */
function validateProduct(P) {
	strErr = new String();

	if (P._getProductCategoryID() == 0) {
		strErr += " - You must choose a category for this product<br/>";
	}	
	if (P._getProductClassification().length == 0 || P._getProductClassification().indexOf("undefined") == 0) {
		strErr += " - You must choose a classification for this product<br/>";
	}	
	if (P._getProductItemcode().length == 0 || P._getProductItemcode().indexOf("undefined") == 0) {
		strErr += " - You must provide an itemcode for this product<br/>";
	}	
	if (P._getProductName().length == 0 || P._getProductName().indexOf("undefined") == 0) {
		strErr += " - You must provide a name for this product<br/>";
	}	
	if (P._getProductDescshort().length == 0 || P._getProductDescshort().indexOf("undefined") == 0) {
		strErr += " - You must provide a short description for this product<br/>";
	}	
	if (P._getProductDesclong().length == 0 || P._getProductDesclong().indexOf("undefined") == 0) {
		strErr += " - You must provide a long description for this product<br/>";
	}	
	
	return strErr;
}


/*
 *	
 */
function validateInventory(I) {
	strErr = new String();

	if (isNaN(I._getInventoryInstock())) {
		strErr += " - You must set the quantity you have in stock to sell on this site<br/>";
	}	
	if (I._getInventoryAttribute().length == 0 || I._getInventoryAttribute().indexOf("undefined") == 0) {
		strErr += " - You must set an attribute for this inventory<br/>";
	}	
	if (I._getInventoryName().length == 0 || I._getInventoryName().indexOf("undefined") == 0) {
		strErr += " - You must provide a name for this inventory item<br/>";
	}
	if (I._getInventoryPriceretail() == 0) {
		strErr += " - You must set a retail price for this item<br/>";
	}	
	
	return strErr;
}


%>


