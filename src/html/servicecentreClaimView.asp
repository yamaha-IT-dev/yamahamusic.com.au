<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Welcome</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<script type="text/javascript" src="/prototype.js"></script>

	<script type="text/javascript" src="/schedule.js"></script>
	<script type="text/javascript" src="/string_library.js"></script>
	<script type="text/javascript" src="/content_validation.js"></script>


	<style type="text/css" media="all">@import "/yamahamusic.css";</style>
	<style type="text/css" media="all">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="print">

		@import "yamahamusic.warranty-print.css";


	</style>

	<style type="text/css" media="all">
		@import "yamahamusic.warranty-tweak.css";

		#invoice_label 	{ display : none; }
		.textBlock		{ display : block; font-size : 1.2em; width : 230px; }
		.textBlockShort	{ display : block; font-size : 1.2em; width : 130px; }

	</style>


</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<div id="left">
	<!--#include file="global/navigationLeftShallow.asp" -->
</div>
<!--#include file="global/globalMainContentStart.asp" -->

<h1>Yamaha Service Centres</h1>
<h2>Warranty Claim</h2>

<h3>&nbsp;</h3>

<h3>Claim Details</h3>


<form id="formToValidate" action="<%= CONTROLLER %>" method="post">

	<div>
		<fieldset style="float:left;border-bottom:0px;">

			<input type="hidden" name="action" value="save_claim" />

			<input type="hidden" name="claimid" value="<%= WC._getClaimID() %>" />
			<input type="hidden" name="serviceid" value="<%= WC._getClaimServiceID() %>" />
			<input type="hidden" name="userid" value="<%= Session("yma_userid") %>" />
			<input type="hidden" name="status" value="<%= WC._getClaimStatus() %>" />
			<input type="hidden" name="vendorcode" value="<%= WC._getClaimVendorcode() %>" />
			<input type="hidden" name="dealercode" value="<%= WC._getClaimDealercode() %>" />
			<input type="hidden" name="retailername" value="<%= WC._getClaimRetailername() %>" />
			<input type="hidden" name="extcomment" value="<%= WC._getClaimExtcomment() %>" />
			<input type="hidden" name="repaircode" value="<%= WC._getClaimRepaircode() %>" />
			<input type="hidden" name="oldmodelflag" value="<%= WC._getClaimOldmodelflag() %>" />

			<label class="required" for="creditflag">
				<span class="labelText">Payment Terms </span>

				<span class="textBlock">
					<%= WC._getClaimCreditflag()==0?"<strong>Cheque</strong>":"" %>
					<%= WC._getClaimCreditflag()==1?"<strong>Credit</strong>":"" %>
				</span>
			</label>

			<label class="required" for="rctiflag">
				<span class="labelText">Is this an RCTI or Tax Invoice?</span>

				<span class="textBlock">
					<%= WC._getClaimRCTIflag()==0?"<strong>Tax Invoice</strong>":"" %>
					<%= WC._getClaimRCTIflag()==1?"<strong>RCTI</strong>":"" %>
				</span>
			</label>

			<%
				if (WC._getClaimRCTIflag()==0)
				{
			%>
			<label for="invoicenumber" id="invoice_label">
				<span class="labelText">Invoice Number</span>
				<span style="font-size:1.6em;"><%= WC._getClaimInvoicenumber() %></span>
			</label>
			<%
				}
				else
				{
			%>
			<label for="rctinumber" id="rcti_label">
				<span class="labelText">RTCI Number</span>
				<span class="textBlock"><%= WC._getClaimRctinumber() %></span>
			</label>
			<%
				}
			%>
		</fieldset>


		<fieldset style="float:left;padding-left:20px;border-bottom:0px;">

			<label for="dateinvoice">
				<span class="labelText"><strong>Invoice Date</strong> </span>
				<span class="textBlockShort"><%= new Date(Date.parse(WC._getClaimDateinvoice())).formatDate("jS F Y") %></span>
			</label>

			<label for="datepurchased">
				<span class="labelText"><strong>Date Purchased</strong> </span>
				<span class="textBlockShort"><%= new Date(Date.parse(WC._getClaimDatepurchased())).formatDate("jS F Y") %></span>

			</label>

			<label for="datereceived">
				<span class="labelText"><strong>Date Received</strong> </span>
				<span class="textBlockShort"><%= new Date(Date.parse(WC._getClaimDatereceived())).formatDate("jS F Y") %></span>
			</label>

			<label for="datecompleted">
				<span class="labelText"><strong>Date Completed</strong> </span>
				<span class="textBlockShort"><%= new Date(Date.parse(WC._getClaimDatecompleted())).formatDate("jS F Y") %></span>
			</label>

		</fieldset>



		<div class="clearing"></div>
	</div>
	<div style="background-color: #F0F1F3;">

		<fieldset class="alt" style="float:left;">

			<label class="required" for="modelnumber">
				<span class="labelText">Model Number </span>
				<span class="textBlock"><%= WC._getClaimModelnumber() %></span>
			</label>

			<label class="required" for="serialnumber">
				<span class="labelText">Serial Number </span>
				<span class="textBlock"><%= WC._getClaimSerialnumber() %></span>
			</label>

			<label for="warrantyauth">
				<span class="labelText">Warranty Authorisation </span>
				<span class="textBlock"><%= WC._getClaimWarrantyauth() %></span>
			</label>

			<label class="required" for="faultreport">
				<span class="labelText">Fault Report </span>
				<span class="textBlock"><%= WC._getClaimFaultreport() %></span>
			</label>

			<label class="required" for="repairreport">
				<span class="labelText">Repair Report </span>
				<span class="textBlock"><%= WC._getClaimRepairreport() %></span>
			</label>

			<label for="comment">
				<span class="labelText">Comment </span>
				<span class="textBlock"><%= WC._getClaimComment() %></span>
			</label>


		</fieldset>
		<fieldset class="alt" style="float:left;padding-left:20px;border-bottom:0px;">

			<label class="required" for="labourcharge">
				<span class="labelText">Labour Charge<br/>(EX GST)</span>
				<span class="textBlockShort"><%= WC._getClaimLabourcharge() %></span>
			</label>

			<label class="required" for="partscharge">
				<span class="labelText">Parts Charge<br/>(EX GST)</span>
				<span class="textBlockShort"><%= WC._getClaimPartscharge() %></span>
			</label>

			<label for="gstcharge">
				<span class="labelText"><strong>GST</strong></span>
				<span class="textBlockShort"><%= WC._getClaimGSTCharge() %></span>
			</label>

			<label for="gstcharge">
				<span class="labelText"><strong>Total</strong></span>
				<span class="textBlockShort"><%= WC._getClaimTotalCharge() %></span>
			</label>

		</fieldset>


		<div class="clearing"></div>
	</div>

	<fieldset>

		<p><strong>Customer Details</strong></p>

		<label class="required" for="custname">
			<span class="labelText">Full Name </span>
			<span class="textBlock"><%= WC._getClaimCustname() %></span>
		</label>

		<label class="required" for="custaddress">
			<span class="labelText">Address </span>
			<span class="textBlock"><%= WC._getClaimCustaddress() %></span>
		</label>

		<label class="required" for="custsuburb">
			<span class="labelText">Suburb </span>
			<span class="textBlock"><%= WC._getClaimCustsuburb() %></span>
		</label>

		<label class="required" for="custstate">
			<span class="labelText">State </span>
			<span class="textBlock"><%= WC._getClaimCuststate() %></span>
		</label>

		<label class="required" for="custpostcode">
			<span class="labelText">Postcode </span>
			<span class="textBlock"><%= WC._getClaimCustpostcode() %></span>
		</label>

		<label for="custphone">
			<span class="labelText">Phone Number </span>
			<span class="textBlock"><%= WC._getClaimCustphone() %></span>
		</label>


	</fieldset>

</form>


<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>