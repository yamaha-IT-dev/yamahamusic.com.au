<!--#include file="_gblHeader.asp"-->



<h1>Tax Invoice</h1>
<h2>Yamaha Service Centres</h2>


<h3>&nbsp;</h3>

<form>
	<input type="hidden" name="claimid" value="<%= WC._getClaimID() %>" />
	<input type="hidden" name="userid" value="<%= Session("yma_userid") %>" />
	<input type="hidden" name="status" value="<%= WC._getClaimStatus() %>" />
	<input type="hidden" name="vendorcode" value="<%= WC._getClaimVendorcode() %>" />
	<input type="hidden" name="dealercode" value="<%= WC._getClaimDealercode() %>" />
	<input type="hidden" name="retailername" value="<%= WC._getClaimRetailername() %>" />
	<input type="hidden" name="extcomment" value="<%= WC._getClaimExtcomment() %>" />

	<div class="noborder">

		<h2><strong>Service Centre Details</strong></h2>
		<p><strong><%= SC._getServiceName() %></strong>
		<br/><strong>ABN : </strong><%= SC._getServiceABN() %>
		<br/><%= SC._getServiceAddress() %>, <%= SC._getServiceCity() %>&nbsp;&nbsp;<%= SC._getServiceState() %>&nbsp;&nbsp;<%= SC._getServicePostcode() %>
		<br/>Ph : <%= SC._getServicePhone() %> &nbsp;&nbsp;Fax : <%= SC._getServiceFax() %>&nbsp;&nbsp;Email : <a href="mailto:<%= SC._getServiceEmail() %>"><%= SC._getServiceEmail() %></a></p>

	<h2><strong>Claim Details</strong></h2>
		<table border="0" cellpadding="0" cellspacing="0" width="500">
		<tr>
			<td>
				<p><label for="invoicenumber" style="float:none;">Claim Number</label><br/>
				<strong style="color:red;"><%= WC._getClaimNumber() %></strong><br/>
				<label for="invoicenumber" style="float:none;">Invoice / RTCI Number</label><br/>
				<strong><%= WC._getClaimInvoicenumber() %></strong><br/>
				<label for="repaircode" style="float:none;">Warranty Repair Code</label><br/>
				<%= WC._getClaimRepaircode() %></srong></p>
				</p>
			</td>
			<td>
				<p><label for="rctiflag" style="float:none;">Is this an <acronym title="Recipient Created Tax Invoices">RCTI?</acronym> - </label><strong><%= WC._getClaimRCTIflag()==1?"YES":"NO" %></strong>
				<br/><label for="creditflag" style="float:none;">Cheque or credit? - </label><strong><%= WC._getClaimCreditflag()==1?"CHEQUE":"CREDIT" %></strong>
				<br/><label for="oldmodelflag" style="float:none;">Is this an older product model? - </label><strong><%= WC._getClaimOldmodelflag()==1?"YES":"NO" %></stong></p>
			</td>
		</tr>
		</table>
	</div>

	<h3>Work Report</h3>

	<table border="0" cellpadding="0" cellspacing="0" width="400">
	<tr>
		<td><label for="modelnumber">Model Number</label></td>
		<td><strong><%= WC._getClaimModelnumber() %></strong></td>
		<td><label for="labourcharge">Labour Charge</label></td>
		<td align="right"><strong>$<%= new Number(WC._getClaimLabourcharge()).toFixed(2)  %></strong></td>
	</tr>
	<tr>
		<td><label for="serialnumber">Serial Number</label></td>
		<td><strong><%= WC._getClaimSerialnumber() %></strong></td>
		<td><label for="partscharge">Parts Charge</label></td>
		<td align="right"><strong>$<%= new Number(WC._getClaimPartscharge()).toFixed(2) %></strong></td>
	</tr>
	<tr>
		<td><label for="repaircode">Warranty Auth</label></td>
		<td><strong><%= WC._getClaimWarrantyauth() %></strong></td>
		<td><label for="gstcharge">GST </label></td>
		<td align="right"><strong>$<%= new Number(WC._getClaimGSTCharge()).toFixed(2) %></strong></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td><label for="total">Total</label></td>
		<td align="right"><%

			total = parseFloat(WC._getClaimLabourcharge()) + parseFloat(WC._getClaimPartscharge()) + parseFloat(WC._getClaimGSTCharge());

		%><strong>$<%= parseFloat(total).toFixed(2) %></strong></td>
	</tr>
	<tr>
		<td><label for="datepurchased">Date Purchased</label></td>
		<td><strong><%
			if (new String(WC._getClaimDatepurchased()) != "null") {
				Response.Write(new Date(Date.parse(WC._getClaimDatepurchased())).formatDate("j M Y"));
			}
		%></strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><label for="datereceived">Date Received</label></td>
		<td><strong><%
			if (new String(WC._getClaimDatereceived()) != "null") {
				Response.Write(new Date(Date.parse(WC._getClaimDatereceived())).formatDate("j M Y"));
			}
		%></strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><label for="datecompleted">Date Completed</label></td>
		<td><strong><%
			if (new String(WC._getClaimDatecompleted()) != "null") {
				Response.Write(new Date(Date.parse(WC._getClaimDatecompleted())).formatDate("j M Y"));
			}
		%></strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><label for="faultreport">Fault Report</label></td>
		<td colspan="3"><strong><%= WC._getClaimFaultreport() %></strong></td>

	</tr>
	<tr>
		<td><label for="repairreport">Repair Report</label></td>
		<td colspan="3"><strong><%= WC._getClaimRepairreport() %></strong></td>
	</tr>
	<tr>
		<td><label for="comment">Comment</label></td>
		<td colspan="3"><strong><%= WC._getClaimComment() %></strong></td>
	</tr>
	</table>

	<div class="noborder">

		<h3>Customer Details</h3>
		<table border="0" cellpadding="0" cellspacing="0" width="250">
		<tr>
			<td><label for="custname">Full Name</label></td>
			<td><strong><%= WC._getClaimCustname() %></strong></td>
		</tr>
		<tr>
			<td><label for="custaddress">Address</label></td>
			<td><strong><%= WC._getClaimCustaddress() %></strong></td>
		</tr>
		<tr>
			<td><label for="custsuburb">Suburb</label></td>
			<td><strong><%= WC._getClaimCustsuburb() %></strong></td>
		</tr>
		<tr>
			<td><label for="custstate">State</label> + <label for="custpostcode">Postcode</label></td>
			<td><strong><%= WC._getClaimCuststate() %></strong>&nbsp;&nbsp;<strong><%= WC._getClaimCustpostcode() %></strong></td>
		</tr>
		<tr>
			<td><label for="custphone">Contact Number</label></td>
			<td><strong><%= WC._getClaimCustphone() %></strong></td>
		</tr>
		</table>
	</div>

</form>



<!--#include file="_gblFooter.asp"-->
