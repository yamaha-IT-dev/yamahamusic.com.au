<!--#include file="_gblHeader.asp"-->

<h1>Yamaha Service Centres</h1>
<h2>Export Claims</h2>

<div style="float:right;width : 300px;">
	<h3>Select Claims to Export</h3>

	<p>This will allow you to retrieve claims which have been CLOSED and export them for upload into base.</p>
	<p>The process for export is;
	<ol style="list-style-type:inline;">
		<li>Retrieve selection</li>
		<li>Confirm selection</li>
		<li>Export selection</li>
	</ol></p>
	<p>Once a batch of items have been exported their status will be marked as BATCH_200xxxxx where x indicates a date stamp.</p>
</div>


<form name="exportFilter" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= EXPORT_FILTER %>">

	<fieldset style="border:1px #666 solid;padding:2px 5px 2px 5px;margin-right:20px;">
		<legend>Search / Filter by Service Centre and Date Claim Entered</legend>

	<div class="column" style="width:300px;">

		<p><strong>Service Centre</strong><br/>
		<select name="servicecentreid" multiple="multiple" size="8">
			<option value="0"<%= arrServiceCentreID[0]==0?" selected=\"selected\"":"" %>>All Service Centres</option>
<%
				if (rsService && !rsService.EOF) {
					while (!rsService.EOF) {
						var isSelected = false;
						for (var i=0; i<arrServiceCentreID.length; i++) {
							if (arrServiceCentreID[i] == parseInt(rsService("id"))) {
								isSelected = true;
								break;
							}
						}
						%><option value="<%= rsService("id") %>"<%= isSelected?" selected=\"selected\"":"" %>><%= rsService("state") %>, <%= rsService("name") %></option>
						<%
						rsService.MoveNext();
					}
				}
%>
		</select>

	</div>
	<div class="column" style="width:250px;">

		<strong>Date From...</strong><br/>
		<%
			var dNow = new Date();
			var dRef = dateStart;
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="startDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="startMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="startYear">
			<option value="0">year...</option><%
			for (var i=dNow.getFullYear(); i >= dNow.getFullYear()-10; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>
		<br/>
		<strong>...Until (inclusive)</strong><br/>
		<%
			var dRef = dateEnd;
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="endDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="endMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="endYear">
			<option value="0">year...</option><%
			for (var i=dNow.getFullYear(); i >= dNow.getFullYear()-10; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></p>

		<p><input type="submit" name="submit" value="go" class="button" onclick="document.forms['exportFilter'].elements['action'].value='export_filter';"></p>

	</div>

	</fieldset>

	<fieldset style="border:1px #666 solid;padding:2px 5px 2px 5px;margin-right:20px;">
		<legend>Filter Claims by Date Claim Modified</legend>

		<strong>Date Modified</strong><br/>
		<%
			var dRef = dateModified;
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
		<select name="modDay">
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="modMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="modYear">
			<option value="0">year...</option><%
			for (var i=dNow.getFullYear(); i >= dNow.getFullYear()-10; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></p>

		<p><input type="submit" name="submit" value="go" class="button" onclick="document.forms['exportFilter'].elements['action'].value='export_filter_modified';"></p>


	</fieldset>



	<div class="clearing"></div>

<%

	if (rsClaims && !rsClaims.EOF) {

		%><h3>Claims found</h3>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th><acronym title="Claim Number">OPCLIM</acronym></th>
			<th><acronym title="Credit Note Flag">OPCCFL</acronym></th>
			<th><acronym title="RCTI Flag">OPRCTI</acronym></th>
			<th><acronym title="Vendor Code">OPSISC</acronym></th>
			<th><acronym title="Dealer Code">OPURKC</acronym></th>
			<th><acronym title="Sale to Dealer">OPGURC</acronym></th>
			<th><acronym title="Ship to Dealer">OPHSRC</acronym></th>
			<th><acronym title="Model Number">OPSOSC</acronym></th>
			<th><acronym title="Old Model Flag">OPOMDF</acronym></th>
			<th><acronym title="Serial Number">OPSIBN</acronym></th>
			<th><acronym title="Date Purchased">OPSSE</acronym></th>
			<th><acronym title="Retailer Name">OPRTLN</acronym></th>
			<th><acronym title="Fault Report">OPCOMP</acronym></th>
			<th><acronym title="Repair Report">OPTECR</acronym></th>
			<th><acronym title="External Comment Code">OPEXCC</acronym></th>
			<th><acronym title="External Comment (Usually Service Invoice Number)">OPEXCM</acronym></th>
			<th><acronym title="Internal Comment Code">OPINCC</acronym></th>
			<th><acronym title="Internal Comment">OPINCM</acronym></th>
			<th><acronym title="Repair Code">OPWARC</acronym></th>
			<th><acronym title="Labour Charge">OPLACH</acronym></th>
			<th><acronym title="Parts Charge">OPPACH</acronym></th>
			<th><acronym title="GST Charge">OPOTCH</acronym></th>
		</tr>
		<%
		while (!rsClaims.EOF) {
			%>
			<tr>
				<td><%= rsClaims("claimnumber") %></td>
				<td>0</td> <!-- <td><%= rsClaims("creditflag") %></td>-->
				<td><%= rsClaims("rctiflag") %></td>
				<td style="white-space:nowrap;"><%= rsClaims("vendorcode") %></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td style="white-space:nowrap;"><%= rsClaims("modelnumber") %></td>
				<td>1</td> <!-- <td><%= rsClaims("rctiflag") %></td>-->
				<td style="white-space:nowrap;"><%= rsClaims("serialnumber") %></td>
				<td><%= new Date(Date.parse(rsClaims("datepurchased"))).formatDate("dmy") %></td>
				<td style="white-space:nowrap;"><%= rsClaims("dealercode") + "000" %></td>
				<td style="white-space:nowrap;"><%= cleanForText(rsClaims("faultreport")) %></td>
				<td style="white-space:nowrap;"><%= cleanForText(rsClaims("repairreport")) %></td>
				<td><%= cleanForText(rsClaims("extcomment")) %></td>
				<td><%= cleanForText(rsClaims("invoicenumber")) %></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><%= rsClaims("repaircode") %></td>
				<td><%= new Number(rsClaims("labourcharge")).toFixed(2) %></td>
				<td><%= new Number(rsClaims("partscharge")).toFixed(2) %></td>
				<td><%= new Number(rsClaims("gstcharge")).toFixed(2) %></td>
			</tr>
			<%
			rsClaims.moveNext();
		}
		%></table>

		<p><input type="submit" name="submit" value="export this list" class="button" onclick="document.forms['exportFilter'].elements['action'].value='export_claims';"></p>

		<%
	} else {
		%><p>No claims found.</p><%
	}

%>

</form>

<!--#include file="_gblFooter.asp"-->
