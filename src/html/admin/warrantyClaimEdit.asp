<!--#include file="_gblHeader.asp"-->


<script type="text/javascript" language="javascript">

	function _calculateGST() {

		var F = document.forms['claimForm']

		var fltLabour = parseFloat(F.elements['labourcharge'].value);
		var fltParts = parseFloat(F.elements['partscharge'].value);
		var fltGST = 0;

		if (!isNaN(fltLabour) && !isNaN(fltParts)) {
			fltGST = (fltLabour + fltParts) / 10;
			F.elements['gstcharge'].value = fltGST.toFixed(2);

			F.elements['totalcharge'].value = (fltLabour + fltParts + fltGST).toFixed(2);
		}
	}


</script>
<h1>Yamaha Service Centres</h1>
<h2>Warranty Claim</h2>

<h3>&nbsp;</h3>

<form name="claimForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="save_claim" />

	<input type="hidden" name="claimid" value="<%= WC._getClaimID() %>" />
	<input type="hidden" name="serviceid" value="<%= WC._getClaimServiceID() %>" />
	<input type="hidden" name="userid" value="<%= Session("yma_userid") %>" />
	<input type="hidden" name="vendorcode" value="<%= WC._getClaimVendorcode() %>" />
	<input type="hidden" name="dealercode" value="<%= WC._getClaimDealercode() %>" />
	<input type="hidden" name="retailername" value="<%= WC._getClaimRetailername() %>" />
	<input type="hidden" name="extcomment" value="<%= WC._getClaimExtcomment() %>" />

	<%
		if (message.length > 0) {
			%><p class="alert"><%= message %></p><%
		}
	%>
	<div class="noborder">

		<h3>Service Centre Details</h3>
		<p><strong><%= SC._getServiceName() %></strong>
		<br/><%= SC._getServiceAddress() %>, <%= SC._getServiceCity() %>&nbsp;&nbsp;<%= SC._getServiceState() %>&nbsp;&nbsp;<%= SC._getServicePostcode() %>
		<br/>Ph : <%= SC._getServicePhone() %> &nbsp;&nbsp;Fax : <%= SC._getServiceFax() %>&nbsp;&nbsp;Email : <a href="mailto:<%= SC._getServiceEmail() %>"><%= SC._getServiceEmail() %></a></p>

		<h3>Claim Details</h3>

		<p>Claim Number<br/><%
		if (new String(WC._getClaimNumber()).length > 0 && new String(WC._getClaimNumber()).indexOf("undefined") != 0) {
			%><span style="color:red;"><%= WC._getClaimNumber() %></span><%
		} else {
			%><span style="color:red;">Not yet assigned</span><br/>
			<input type="submit" name="submit" value="approve this claim" onclick="document.forms['claimForm'].elements['action'].value='<%= ASSIGN_CLAIM %>'" class="button" /><br/>
			<em>By approving this claim you will assign a claim number,<br/>
			close and mark this claim ready to be submitted to accounts</em>

			<%
		}
		%></p>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<p><label for="status">Claim Status</label><br/>
				<select name="status">
					<option value="">choose...</option><%
						for (var i=0; i < GBL_WARRANTY_STATUS.length; i++) {
							%><option value="<%= GBL_WARRANTY_STATUS[i] %>"<%= WC._getClaimStatus() == GBL_WARRANTY_STATUS[i]?" selected=\"selected\"":"" %>><%= GBL_WARRANTY_STATUS[i] %></option><%
						}
				%></select></p>
			</td>
			<td>
				<p>
				<label for="invoicenumber">Invoice / RTCI Number</label><br/>
				<input type="text" name="invoicenumber" value="<%= WC._getClaimInvoicenumber() %>" maxlength="20" style="width:150px;" /></p>
			</td>
			<td rowspan="2">
				<p>Flags
				<br/><input type="checkbox" name="rctiflag" value="1"<%= WC._getClaimRCTIflag()==1?" checked=\"checked\"":"" %> /><label for="rctiflag" style="float:none;">Is this an RTCI? - check for yes.</label>
				<br/><input type="checkbox" name="creditflag" value="1"<%= WC._getClaimCreditflag()==1?" checked=\"checked\"":"" %> /><label for="creditflag" style="float:none;">Is for cheque or credit? - check for credit.</label>
				<br/><input type="checkbox" name="oldmodelflag" value="1"<%= WC._getClaimOldmodelflag()==1?" checked=\"checked\"":"" %> /><label for="oldmodelflag" style="float:none;">Is this an older product model? - check for yes</label></p>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p><label for="repaircode">Warranty Repair Code</label><br/>
				<select name="repaircode">
					<option value="">choose...</option><%
						for (var i=0; i < GBL_WARRANTY_REPAIRCODE_S.length; i++) {
							%><option value="<%= GBL_WARRANTY_REPAIRCODE_S[i] %>"<%= WC._getClaimRepaircode() == GBL_WARRANTY_REPAIRCODE_S[i]?" selected=\"selected\"":"" %>><%= GBL_WARRANTY_REPAIRCODE_L[i] %></option><%
						}
				%></select></p>
			</td>
		</tr>
		</table>
	</div>

	<h3>Work Report</h3>
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><label for="modelnumber">Model Number</label></td>
		<td><input type="text" name="modelnumber" value="<%= WC._getClaimModelnumber() %>" maxlength="15" style="width:150px;" /></td>
		<td><label for="labourcharge">Labour Charge</label></td>
		<td><input type="text" name="labourcharge" value="<%= WC._getClaimLabourcharge()  %>" maxlength="12" style="width:100px;text-align:right;"  onblur="_calculateGST()"/></td>
	</tr>
	<tr>
		<td><label for="serialnumber">Serial Number</label></td>
		<td><input type="text" name="serialnumber" value="<%= WC._getClaimSerialnumber() %>" maxlength="15" style="width:150px;" /></td>
		<td><label for="partscharge">Parts Charge</label></td>
		<td><input type="text" name="partscharge" value="<%= WC._getClaimPartscharge() %>" maxlength="12" style="width:100px;text-align:right;"  onblur="_calculateGST()"/></td>
	</tr>
	<tr>
		<td><label for="repaircode">Warranty Auth</label></td>
		<td><input type="text" name="warrantyauth" value="<%= WC._getClaimWarrantyauth() %>" maxlength="12" style="width:150px;" /></td>
		<td><label for="gstcharge">GST </label></td>
		<td><input type="text" name="gstcharge" value="<%= WC._getClaimGSTCharge() %>" maxlength="12" style="width:100px;text-align:right;" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td><label for="totalcharge"><strong>Total</strong></label></td>
		<td><%

			total = parseFloat(WC._getClaimLabourcharge()) + parseFloat(WC._getClaimPartscharge()) + parseFloat(WC._getClaimGSTCharge());

		%><input type="text" name="totalcharge" value="<%= parseFloat(total).toFixed(2) %>" maxlength="12" style="width:100px;text-align:right;" onfocus="blur()" /></td>
	</tr>
	<tr>
		<td><label for="faultreport">Fault Report<br/><em>30 characters max</em></label></td>
		<td><textarea name="faultreport" rows="2" style="width:150px;"><%= WC._getClaimFaultreport() %></textarea></td>
		<td colspan="2">
			<label for="datepurchased">Date Purchased</label><br/>
			<%
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
				for (var i=2008; i >= 2000; i--) {
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
				for (var i=2008; i >= 2000; i--) {
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
				for (var i=2008; i >= 2000; i--) {
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

	<p><input type="submit" name="submit" value="update warranty claim" class="button" /></p>

</form>





<!--#include file="_gblFooter.asp"-->
