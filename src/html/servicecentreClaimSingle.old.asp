<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Welcome</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.hideright.css";</style>

	<style type="text/css" media="screen">@import "yamahamusic.warranty.css";</style>

	<script type="text/javascript" language="javascript">

		function _calculateGST() {

			var F = document.forms['claimForm']

			var fltLabour = parseFloat(F.elements['labourcharge'].value);
			var fltParts = parseFloat(F.elements['partscharge'].value);
			var fltGST = 0;

			if (!isNaN(fltLabour) && !isNaN(fltParts)) {
				fltGST = (fltLabour + fltParts) / 10;
				F.elements['gstcharge'].value = fltGST.toFixed(2);
			}
		}


	</script>

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

<form name="claimForm" action="<%= CONTROLLER %>" method="post">
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

	<%
		if (message.length > 0) {
			%><p class="alert"><%= message %></p><%
		}
	%>
	<div class="noborder">

		<h3>Claim Details</h3>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<p><label for="invoicenumber">Invoice / RTCI Number</label><br/>
				<input type="text" name="invoicenumber" value="<%= WC._getClaimInvoicenumber() %>" maxlength="20" style="width:150px;" /></p>
			</td>
			<td style="padding-right:50px;">
				<p><strong>Is this an RTCI?</strong><br/>
				<input type="radio" name="rctiflag" value="0"<%= WC._getClaimRCTIflag()==0?" checked=\"checked\"":"" %> /><label for="rctiflag">No</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="rctiflag" value="1"<%= WC._getClaimRCTIflag()==1?" checked=\"checked\"":"" %> /><label for="rctiflag">Yes</label>
			</td>
			<td>
				<p><strong>Payment Terms</strong><br/>
				<input type="radio" name="creditflag" value="0"<%= WC._getClaimCreditflag()==0?" checked=\"checked\"":"" %> /><label for="creditflag">Cheque</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="creditflag" value="1"<%= WC._getClaimCreditflag()==1?" checked=\"checked\"":"" %> /><label for="creditflag">Credit</label>
			</td>
		</tr>
		</table>
	</div>

	<h3>Work Report</h3>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td><label for="modelnumber">Model Number</label></td>
		<td><input type="text" name="modelnumber" value="<%= WC._getClaimModelnumber() %>" maxlength="15" style="width:150px;" /></td>
		<td><label for="labourcharge">Labour Charge<br/>(EX GST)</label></td>
		<td><input type="text" name="labourcharge" value="<%= WC._getClaimLabourcharge()  %>" maxlength="12" style="width:100px;" onblur="_calculateGST()"/></td>
	</tr>
	<tr>
		<td><label for="serialnumber">Serial Number</label></td>
		<td><input type="text" name="serialnumber" value="<%= WC._getClaimSerialnumber() %>" maxlength="15" style="width:150px;" /></td>
		<td><label for="partscharge">Parts Charge<br/>(EX GST)</label></td>
		<td><input type="text" name="partscharge" value="<%= WC._getClaimPartscharge() %>" maxlength="12" style="width:100px;"  onblur="_calculateGST()"/></td>
	</tr>
	<tr>
		<td><label for="repaircode">Warranty Auth</label></td>
		<td><input type="text" name="warrantyauth" value="<%= WC._getClaimWarrantyauth() %>" maxlength="12" style="width:150px;" /></td>
		<td><label for="gstcharge">GST<br/>(Calculated Automatically)</label></td>
		<td><input type="text" name="gstcharge" value="<%= WC._getClaimGSTCharge() %>" maxlength="12" style="width:100px;border:0;" onfocus="blur()"/></td>
	</tr>
	<tr>
		<td><label for="faultreport">Fault Report<br/><em>30 characters max</em></label></td>
		<td><textarea name="faultreport" rows="2" style="width:150px;"><%= WC._getClaimFaultreport() %></textarea></td>
		<td colspan="2">
			<label for="datepurchased">Date Purchased</label><br/>
			<%
				var rDate = new Date();
				var curYear = rDate.getFullYear()

				var dRef = WC._getClaimDatepurchased();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
			<select name="purDay">
				<option value="0">day...</option><%
				for (var i=1; i <= 31; i++) {
					%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>&nbsp;
			<select name="purMonth">
				<option value="0">month...</option><%
				for (var i=0; i < 12; i++) {
					%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
				}
			%></select>&nbsp;
			<select name="purYear">
				<option value="0">year...</option><%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>
		</td>
	</tr>
	<tr>
		<td><label for="repairreport">Repair Report<br/><em>50 characters max</em></label></td>
		<td><textarea name="repairreport" rows="2" style="width:150px;"><%= WC._getClaimRepairreport() %></textarea></td>
		<td colspan="2">
			<label for="datereceived">Date Received</label><br/>
			<%
				var dRef = WC._getClaimDatereceived();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
			<select name="recDay">
				<option value="0">day...</option><%
				for (var i=1; i <= 31; i++) {
					%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>&nbsp;
			<select name="recMonth">
				<option value="0">month...</option><%
				for (var i=0; i < 12; i++) {
					%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
				}
			%></select>&nbsp;
			<select name="recYear">
				<option value="0">year...</option><%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>
		</td>
	</tr>
	<tr>
		<td><label for="comment">Comment<br/><em>50 characters max</em></label></td>
		<td><textarea name="comment" rows="2" style="width:150px;"><%= WC._getClaimComment() %></textarea></td>
		<td colspan="2">
			<label for="datecompleted">Date Completed</label><br/>
			<%
				var dRef = WC._getClaimDatecompleted();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
			<select name="compDay">
				<option value="0">day...</option><%
				for (var i=1; i <= 31; i++) {
					%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>&nbsp;
			<select name="compMonth">
				<option value="0">month...</option><%
				for (var i=0; i < 12; i++) {
					%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
				}
			%></select>&nbsp;
			<select name="compYear">
				<option value="0">year...</option><%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>
		</td>
	</tr>
	</table>

	<div class="noborder">

		<h3>Customer Details</h3>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><label for="custname">Full Name</label></td>
			<td><input type="text" name="custname" value="<%= WC._getClaimCustname() %>" maxlength="50" style="width:200px;" /></td>
		</tr>
		<tr>
			<td><label for="custaddress">Address</label></td>
			<td><textarea name="custaddress" rows="2" style="width:200px;"><%= WC._getClaimCustaddress() %></textarea></td>
		</tr>
		<tr>
			<td><label for="custsuburb">Suburb</label></td>
			<td><input type="text" name="custsuburb" value="<%= WC._getClaimCustsuburb() %>" maxlength="50" style="width:150px;" /></td>
		</tr>
		<tr>
			<td><label for="custstate">State</label> + <label for="custpostcode">Postcode</label></td>
			<td><select name="custstate" style="width:100px;">
				<option value="">choose...</option><%
					for (var i=0; i < GBL_STATES_SHORT.length; i++) {
						%><option value="<%= GBL_STATES_SHORT[i] %>"<%= WC._getClaimCuststate().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
					}
			%></select>&nbsp;&nbsp;<input type="text" name="custpostcode" value="<%= WC._getClaimCustpostcode() %>" maxlength="4" style="width:50px;" /></td>
		</tr>
		<tr>
			<td><label for="custphone">Contact Number</label></td>
			<td><input type="text" name="custphone" value="<%= WC._getClaimCustphone() %>" maxlength="10" style="width:100px;" /></td>
		</tr>
		</table>
	</div>

	<p><input type="submit" name="submit" value="submit warranty claim" class="button" /></p>

</form>




<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>