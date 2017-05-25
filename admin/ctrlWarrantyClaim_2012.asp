<%@LANGUAGE="JScript"%>
<!--#include file="../src/global.asp" -->
<!--#include file="../src/utility.asp" -->
<!--#include file="../src/classes/User.asp" -->
<!--#include file="../src/classes/Customer.asp" -->
<!--#include file="../src/classes/Service.asp" -->
<!--#include file="../src/classes/Claim.asp" -->
<!--#include file="../src/classes/Navigation.asp" -->
<%

if (!Session("yma_userid") > 0) {
	Response.Redirect("default.asp");
}

// supported parameters
var ACTION = "action";
var SUBMIT = "submit";

// supported actions
var CLAIMS_HOME = "claims_home";
var ADD_CLAIM = "add_claim";
var VIEW_CLAIM = "view_claim";
var EDIT_CLAIM = "edit_claim";
var MODIFY_MULTIPLE = "modify_multiple";
var SAVE_CLAIM = "save_claim";
var ASSIGN_CLAIM = "assign_claim";
var EXPORT_FILTER = "export_filter";
var EXPORT_FILTER_MODIFIED = "export_filter_modified";
var EXPORT_CLAIMS = "export_claims";
var DELETE_CLAIM = "delete_claim";

// global variables & default values
var CONTROLLER = "ctrlWarrantyClaim.asp";
var action = CLAIMS_HOME;

// overide default values from request
if (new String(Request(ACTION)) != "undefined") {
	action = Request(ACTION);
}

// state machine
if (action == CLAIMS_HOME) {

	claimsHome();

} else if (action == VIEW_CLAIM) {

	viewClaim();
} else if (action == DELETE_CLAIM) {

	removeClaim('', null);	

} else if (action == ADD_CLAIM) {

	addSingleClaim('', null);

} else if (action == EDIT_CLAIM) {

	var intmsg = new Number(Request("intmsg"));
	var strmsg = new String();
	if (!isNaN(intmsg)) {
		var strmsg = intmsg==1?"Thank you, your claim has been lodged successfully. You can continue to edit the details in this claim until the YMA service staff review and determine that this claim is ready to be processed. At this point the claim will be closed, you may open and read it, but you will not be able to edit your claim.</p><p>Return to <a href=\"" + CONTROLLER + "\">Warranty Claims</a>":strmsg;
		var strmsg = intmsg==2?"Thank you, your claim has been saved successfully.</p><p>Return to <a href=\"" + CONTROLLER + "\">Warranty Claims</a>":strmsg;
	}

	editClaim(strmsg, null);

} else if (action == SAVE_CLAIM) {

	saveClaim();

} else if (action == MODIFY_MULTIPLE) {

	modifyMultipleClaims();

} else if (action == ASSIGN_CLAIM) {

	assignClaimNumber();

} else if (action == EXPORT_FILTER || action == EXPORT_FILTER_MODIFIED) {

	exportClaimsHome();

} else if (action == EXPORT_CLAIMS) {

	exportClaimsExecute();

} else {
	// TODO Eroor page
	Response.Write("Unsupported action: " + action);
}

GBL_CONN.close();




/*
 *
 */
function claimsHome() {

	var U = new User();
	var SC = new Service();
	var WC = new Claim();

	var rsClaims = null;
		rsClaims = WC._getAllClaims2012();


	%><!--#include file="../src/html/admin/warrantyClaimsHome2012.asp"--><%
}

/*
 *
 */
function viewClaim() {

	var WC = null;

	var intClaimID = new Number(Request("claimid"));
	var WC = new Claim();
	var SC = new Service();

	if (!isNaN(intClaimID)) {

		WC._loadClaim(intClaimID);
		SC._loadService(WC._getClaimServiceID());
	}

	%><!--#include file="../src/html/admin/warrantyClaimView.asp"--><%
}

function removeClaim() {

	var intClaimID = new Number(Request("claimid"));
	var WC = new Claim();
	
	if (!isNaN(intClaimID)) {
		WC._setClaimID(intClaimID);
		WC._deleteClaim();
	}

	endProcess();
}
/*
 *
 */
function addSingleClaim(message, objC) {

	var SC = new Service();
	var WC = null;

	if (Session("yma_userid") > 0) {
		var intServiceCentreID = SC._getServiceByUser(Session("yma_userid"));
		SC._loadService(intServiceCentreID);
	}

	if (objC) {
		WC = objC;
	} else {
		WC = new Claim();
		WC._setClaimServiceID(SC._getServiceID());
		WC._setClaimRCTIflag(SC._getServiceRCTIflag());
		WC._setClaimRetailername(SC._getServiceName());
		WC._setClaimVendorcode(SC._getServiceVendorcode());
		WC._setClaimDealercode(SC._getServiceDealercode());
	}

	%><!--#include file="../src/html/admin/warrantyClaimEdit.asp"--><%
}

/*
 *
 */
 function editClaim(message, objC) {

	var intClaimID = new Number(Request("claimid"));
	var WC = null;
	var SC = new Service();

	if (objC) {
		WC = objC;
	} else {
		WC = new Claim();
		if (!isNaN(intClaimID)) {
			WC._loadClaim(intClaimID);
			SC._loadService(WC._getClaimServiceID());
		}
	}

	%><!--#include file="../src/html/admin/warrantyClaimEdit.asp"--><%
}



/*
 *
 */
function saveClaim() {

	var intmsg = 0;
	var strmsg = new String();
	var intClaimID = new Number(Request("claimid"));

	var WC = new Claim();
		if (!isNaN(intClaimID)) {
			WC._loadClaim(intClaimID);
		}
		WC._setClaimUserID(new Number(Request("userid")));
		WC._setClaimStatus(new String(Request("status")));
		WC._setClaimRepaircode(cleanForSQL(new String(Request("repaircode"))));

		WC._setClaimRCTIflag(new Number(Request("rctiflag"))==1?1:0);
		WC._setClaimCreditflag(new Number(Request("creditflag"))==1?1:0);
		WC._setClaimOldmodelflag(new Number(Request("oldmodelflag"))==1?1:0);

		WC._setClaimInvoicenumber(cleanForSQL(new String(Request("invoicenumber"))));
		WC._setClaimDealercode(cleanForSQL(new String(Request("dealercode"))));
		WC._setClaimVendorcode(cleanForSQL(new String(Request("vendorcode"))));
		WC._setClaimExtcomment(cleanForSQL(new String(Request("extcomment"))));
		WC._setClaimModelnumber(cleanForSQL(new String(Request("modelnumber"))));
		WC._setClaimSerialnumber(cleanForSQL(new String(Request("serialnumber"))));
		WC._setClaimRetailername(cleanForSQL(new String(Request("retailername"))));
		WC._setClaimFaultreport(lightRinseForSQLNoCR(new String(Request("faultreport")).substr(0,30)));
		WC._setClaimRepairreport(lightRinseForSQLNoCR(new String(Request("repairreport")).substr(0,50)));
		WC._setClaimComment(lightRinseForSQLNoCR(new String(Request("comment")).substr(0,50)));
		WC._setClaimLabourcharge(parseFloat(new Number(Request("labourcharge"))).toFixed(2));
		WC._setClaimPartscharge(parseFloat(new Number(Request("partscharge"))).toFixed(2));
		WC._setClaimGSTCharge(parseFloat(new Number(Request("gstcharge"))).toFixed(2));
		WC._setClaimCustname(cleanForSQL(new String(Request("custname"))));
		WC._setClaimCustaddress(cleanForSQL(new String(Request("custaddress")).substr(0,100)));
		WC._setClaimCustsuburb(cleanForSQL(new String(Request("custsuburb"))));
		WC._setClaimCuststate(cleanForSQL(new String(Request("custstate"))));
		WC._setClaimCustpostcode(cleanForSQL(new String(Request("custpostcode"))));
		WC._setClaimCustphone(cleanForSQL(new String(Request("custphone"))));

var inv_date = new Date(Date.parse(WC._getClaimDateinvoice()));
// Response.Write("Date Invoice = " + inv_date + "<br/>");
// Response.Write("Date Invoice = " +  + "<br/>");

		WC._setClaimDateinvoice(GBLMakeDate(inv_date.getDate(), inv_date.getMonth(), inv_date.getFullYear(), null, null, null));
		WC._setClaimDatepurchased(GBLMakeDate(Request("purDay"),Request("purMonth"),Request("purYear"), null, null, null));
		WC._setClaimDatereceived(GBLMakeDate(Request("recDay"),Request("recMonth"),Request("recYear"), null, null, null));
		WC._setClaimDatecompleted(GBLMakeDate(Request("compDay"),Request("compMonth"),Request("compYear"), null, null, null));

	var strvalid = validateClaim(WC);

	if (strvalid.length == 0) {

		if (WC._getClaimID() > 0) {
			WC._saveClaim();
			intmsg = 2;
			if (WC._getClaimStatus() == 0) {
				intmsg = 3;
			}
		} else {
			var intClaimID = WC._addClaim();

			/*
				At this point do we want to email a confirmation
				notice to this persons inbox?

				Do we want to allow them to set their own password
				at first? - or set one for their initial login and then they
				can login after that?

				Initial password can be sent to their nominated
				email address, just to make sure that they're not
				setting up a bogus account.


			*/
			intmsg = 1;
		}

		endProcessPlus("action=" + EDIT_CLAIM + "&claimid=" + intClaimID + "&intmsg=" + intmsg);

	} else {
		strmsg = "This cannot be saved, check the details below and try again : <br/>" + strvalid;
		editClaim(strmsg, WC);
	}
}

function modifyMultipleClaims()
{
	var arrcustomerid = new String(Request("claimid")).split(", ");

	for (i = 0; i < arrcustomerid.length; i++)
	{
		var intClaimID = arrcustomerid[i];

		var WC = new Claim();

			WC._loadClaim(intClaimID);
			WC._setClaimUserID(new Number(Request("userid")));
			WC._setClaimStatus(new String(Request("status")));
			WC._setClaimRepaircode(new String(Request("repaircode")));
			WC._setClaimNumber(WC._generateClaimNumber());

			WC._closeClaim();
	}
	endProcess();

}


/*
 *
 */
function assignClaimNumber() {

	var intmsg = 0;
	var strmsg = new String();
	var intClaimID = new Number(Request("claimid"));

	var WC = new Claim();
		if (!isNaN(intClaimID)) {
			WC._loadClaim(intClaimID);
		}
		WC._setClaimUserID(new Number(Request("userid")));
		WC._setClaimStatus(1);
		WC._setClaimNumber(WC._generateClaimNumber());

		WC._closeClaim();

	endProcessPlus("action=" + VIEW_CLAIM + "&claimid=" + intClaimID + "&intmsg=" + intmsg);
}


/*
 *
 */
function exportClaimsHome() {

	var U = new User();
	var SC = new Service();
	var WC = new Claim();

	var rsService = SC._getAllService();

	var dateStart	 = GBLMakeDate(Request("startDay"),Request("startMonth"),Request("startYear"), null, null, null);
	var dateEnd 	 = GBLMakeDate(Request("endDay"),Request("endMonth"),Request("endYear"), null, null, null);
	var dateModified = GBLMakeDate(Request("modDay"),Request("modMonth"),Request("modYear"), null, null, null);

	if (isNaN(new Date(Date.parse(dateStart)))) {
		dateStart = new Date();
	}
	if (isNaN(new Date(Date.parse(dateEnd)))) {
		dateEnd = new Date();
	}
	if (isNaN(new Date(Date.parse(dateModified)))) {
		dateModified = new Date();
	}

	var arrServiceCentreID = new Array();

	var strServiceCentreID = new String(Request("servicecentreid"));
	if (strServiceCentreID.indexOf("undefined") != 0) {
		arrServiceCentreID = strServiceCentreID.split(', ');
	} else {
		arrServiceCentreID[0] = 0;
	}

// Response.Write("arrServiceCentreID = " + arrServiceCentreID);

	var rsClaims = null;

	if (action == EXPORT_FILTER)
	{
		rsClaims = WC._getClaimsForExport(arrServiceCentreID, dateStart, dateEnd);
	}
	else if (action == EXPORT_FILTER_MODIFIED)
	{
		rsClaims = WC._getClaimsForExportByDateModified(arrServiceCentreID, dateModified);
	}

	%><!--#include file="../src/html/admin/warrantyClaimsExport.asp"--><%

}

/*
 *
 */
function exportClaimsExecute() {

	var U = new User();
	var SC = new Service();
	var WC = new Claim();

	var dateStart	 = GBLMakeDate(Request("startDay"),Request("startMonth"),Request("startYear"), null, null, null);
	var dateEnd 	 = GBLMakeDate(Request("endDay"),Request("endMonth"),Request("endYear"), null, null, null);
	var dateModified = GBLMakeDate(Request("modDay"),Request("modMonth"),Request("modYear"), null, null, null);

	if (isNaN(new Date(Date.parse(dateStart)))) {
		dateStart = new Date();
	}
	if (isNaN(new Date(Date.parse(dateEnd)))) {
		dateEnd = new Date();
	}
	if (isNaN(new Date(Date.parse(dateModified)))) {
		dateModified = new Date();
	}

	var arrServiceCentreID = new Array();

	var strServiceCentreID = new String(Request("servicecentreid"));
	if (strServiceCentreID.indexOf("undefined") != 0) {
		arrServiceCentreID = strServiceCentreID.split(', ');
	} else {
		arrServiceCentreID[0] = 0;
	}

// Response.Write("arrServiceCentreID = " + arrServiceCentreID);

	var rsClaims = WC._getClaimsForExport(arrServiceCentreID, dateStart, dateEnd);

	if (rsClaims == null)
	{
		rsClaims = WC._getClaimsForExportByDateModified(arrServiceCentreID, dateModified);
	}

	// WC._tagClaimsAsExported(arrServiceCentreID, dateStart, dateEnd);

	%><!--#include file="../src/html/admin/warrantyClaimsAsCSV.asp"--><%

}



/*
 *
 */
function validateClaim(WC) {
	strErr = new String();
	if (WC._getClaimInvoicenumber().length == 0 || WC._getClaimInvoicenumber().indexOf("undefined") == 0) {
		strErr += " - You must provide a valid invoice number<br>";
	}
	if (WC._getClaimModelnumber().length == 0 || WC._getClaimModelnumber().indexOf("undefined") == 0) {
		strErr += " - You must provide the model number<br>";
	}
	if (WC._getClaimSerialnumber().length == 0 || WC._getClaimSerialnumber().indexOf("undefined") == 0) {
		strErr += " - You must provide the serial number<br>";
	}
	if (WC._getClaimRepaircode().length == 0 || WC._getClaimRepaircode().indexOf("undefined") == 0) {
		strErr += " - You must select a valid Warranty Repair Code<br>";
	}
	if (WC._getClaimFaultreport().length == 0 || WC._getClaimFaultreport().indexOf("undefined") == 0) {
		strErr += " - You must provide a fault report<br>";
	}
	if (WC._getClaimRepairreport().length == 0 || WC._getClaimRepairreport().indexOf("undefined") == 0) {
		strErr += " - You must provide a repair report<br>";
	}

	/*
		var re = /[-+]?([0-9]*\.[0-9]+|[0-9]+)/ig;
		Response.Write("match = " + WC._getClaimLabourcharge().match(re) + "<br/>")

		Regular Expressions are a bit of a dark art, I'm not exactly sure
		what's going on down here but I'm using some expressions that I found
		to make sure that the charges submitted are formatted as $00.00
	*/
	if (WC._getClaimLabourcharge().length == 0 || WC._getClaimLabourcharge().indexOf("undefined") == 0) {
		strErr += " - You must indicate the labour charge<br>";
	} else {
		if (isNaN(parseFloat(WC._getClaimLabourcharge()))) {
			strErr += " - Your labour charge must be in the form 00.00<br>";
		}
	}
	if (WC._getClaimPartscharge().length == 0 || WC._getClaimPartscharge().indexOf("undefined") == 0) {
		strErr += " - You must indicate the parts charge<br>";
	} else {
		if (isNaN(parseFloat(WC._getClaimPartscharge()))) {
			strErr += " - Your parts charge must be in the form 00.00<br>";
		}
	}
	if (WC._getClaimGSTCharge().length == 0 || WC._getClaimGSTCharge().indexOf("undefined") == 0) {
		strErr += " - You must indicate the GST charge<br>";
	} else {
		//if (! RegExp(/^\$?[0-9\,]+(\.\d{2})?$/).test(WC._getClaimGSTCharge().replace(/^\s+|\s+$/g, ""))) {
		if (isNaN(parseFloat(WC._getClaimGSTCharge()))) {
			strErr += " - Your GST charge must be in the form 00.00<br>";
		}
	}

	if (new Number(Request("purDay")) == 0 || new Number(Request("purMonth")) == 0 || new Number(Request("purYear")) == 0) {
		strErr += " - Please check the date of purchase - you must fill in all the fields<br>";
	}
	if (!GBLValidateDate(new Number(Request("purYear")), new Number(Request("purMonth")), new Number(Request("purDay")))) {
		strErr += " - Please check the date of purchase - your date isn't right<br>";
	}
	if (new Number(Request("recDay")) == 0 || new Number(Request("recMonth")) == 0 || new Number(Request("recYear")) == 0) {
		strErr += " - Please check the date received - you must fill in all the fields<br>";
	}
	if (!GBLValidateDate(new Number(Request("recYear")), new Number(Request("recMonth")), new Number(Request("recDay")))) {
		strErr += " - Please check the date received - your date isn't right<br>";
	}
	if (new Number(Request("compDay")) == 0 || new Number(Request("compMonth")) == 0 || new Number(Request("compYear")) == 0) {
		strErr += " - Please check the date of completion - you must fill in all the fields<br>";
	}
	if (!GBLValidateDate(new Number(Request("compYear")), new Number(Request("compMonth")), new Number(Request("compDay")))) {
		strErr += " - Please check the date of completion - your date isn't right<br>";
	}

	if (WC._getClaimCustname().length == 0 || WC._getClaimCustname().indexOf("undefined") == 0) {
		strErr += " - You must provide the customers full name<br>";
	}
	if (WC._getClaimCustaddress().length == 0 || WC._getClaimCustaddress().indexOf("undefined") == 0) {
		strErr += " - You must provide the customers address<br>";
	}
	if (WC._getClaimCustsuburb().length == 0 || WC._getClaimCustsuburb().indexOf("undefined") == 0) {
		strErr += " - You must provide the customers suburb<br>";
	}
	if (WC._getClaimCuststate().length == 0 || WC._getClaimCuststate().indexOf("undefined") == 0) {
		strErr += " - You must provide the customers state<br>";
	}
	if (WC._getClaimCustpostcode().length == 0 || WC._getClaimCustpostcode().indexOf("undefined") == 0) {
		strErr += " - You must provide the customers postcode<br>";
	}

	return strErr;
}




%>


