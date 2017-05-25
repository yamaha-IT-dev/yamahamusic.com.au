<!--#include file="_gblHeader.asp"-->

<h1>Online Purchases</h1>

<form action="<%= CONTROLLER %>" method="post" id="purchase_search">
	<div style="float:left;">
		<fieldset>
		<legend>Get purchases by month (filter by billing name or item code) </legend>
		<input type="hidden" name="action" value="<%= LIST_PURCHASES %>" />

		<p><label>Month</label><br/><%

		%><select name="month">
			<option value="-1"<%= intmonth==-1?" selected=\"selected\"":"" %>>all</option>
			<%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i %>"<%= intmonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;</p>

		<p><label>Year</label><br/>
		<select name="year">
			<option value="0">all</option>
			<%
			for (var i=sYear+5; i > sYear-5; i--) {
				%><option value="<%= i %>"<%= intyear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;</p>

		<p><label>Billing name </label><br/>
		<input type="text" name="billname" value="<%= Request("billname") %>" style="width:100px;" />&nbsp;&nbsp;</p>

		<p><label>Itemcode...</label><br/>
		<input type="text" name="itemcode" value="<%= Request("itemcode") %>" style="width:100px;" />&nbsp;&nbsp;</p>

		<p><label>&nbsp;</label><br/>
		<input type="submit" name="submit" value="go" class="button" /></p>

		</fieldset>
	</div>
</form>

<div class="clearing"></div>

<p>&nbsp;</p>






<%
	if (arrPurchases.length > 0) {

		%>
		<table border="0" cellpadding="0" cellspacing="0" style="width:700px;" class="nobg">
		<tr>
			<th></th>
			<th>Billing Details</th>
			<th>Processed</th>
			<th>Shipped</th>
			<th>Item</th>
			<th>Quantity</th>
			<th style="white-space : nowrap;">Price Quoted INC</th>
			<th style="white-space : nowrap;">Price Quoted EX.</th>
		</tr>
		<%

		var purchaseid = 0;
		var count = 0;
		var bgcolor = "#FFFFFF";

		for (var i=0; i < arrPurchases.length; i++) {

			P._loadPurchase(arrPurchases[i]);
			var rsOrder = O._getAllOrderByPurchase(arrPurchases[i]);
			var rsOrderCount = 1;

			if (rsOrder && !rsOrder.EOF) {
				rsOrderCount = rsOrder.RecordCount+3;
				rsOrder.MoveFirst();
			}

			%>
				<tr>
					<td rowspan="<%= rsOrderCount %>" style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= VIEW_PURCHASE %>&purchaseid=<%= P._getPurchaseID() %>" class="button">View</a></td>
					<td rowspan="<%= rsOrderCount %>" style="background-color:<%= bgcolor %>;width:50%;">
						<a href="<%= CONTROLLER %>?action=<%= VIEW_PURCHASE %>&purchaseid=<%= P._getPurchaseID() %>"><strong><%= P._getPurchaseBillname() %></strong></a><br/>
						<%= P._getPurchaseBilladdress() %>,&nbsp;<%= P._getPurchaseBillsuburb() %>&nbsp;<%= P._getPurchaseBillstate() %>&nbsp;&nbsp;<%= P._getPurchaseBillpostcode() %><br/>
						<%
							var pd = new Date(Date.parse(P._getPurchaseDatecreated()));

						%>
						<small>purchase date :</small> <%= pd.formatDate("d F Y") %>
						<%
							if (P._getPurchaseNotes().indexOf("REPLACEMENT ITEM") == 0) {
								%><br/><strong style="color:red;">REPLACEMENT</strong><%
							}
						%>
					</td>
			<%
				if (P._getPurchaseBaseorder().indexOf("null") == 0 && P._getPurchaseBaseinvoice().indexOf("null") == 0)
				{
			%>
					<td rowspan="<%= rsOrderCount %>" colspan="2" style="background-color:<%= bgcolor %>;vertical-align:middle;">
						<img src="../images/icons/iconCircle.gif" style="float:left;margin-right:5px;"/>
						<strong>New order</strong></td>
			<%
				} else {
			%>
					<td rowspan="<%= rsOrderCount %>" style="background-color:<%= bgcolor %>;vertical-align:middle;"><%

					if (P._getPurchaseBaseorder().indexOf("null") != 0) {
						%><img src="../images/icons/iconTick.gif" style="float:left;margin-right:5px;"/><%
					} else {
						%>&nbsp;<%
					}

					%></td>
					<td rowspan="<%= rsOrderCount %>" style="background-color:<%= bgcolor %>;vertical-align:middle;"><%

					if (P._getPurchaseBaseinvoice().indexOf("null") != 0) {
						%><img src="../images/icons/iconTick.gif" style="float:left;margin-right:5px;"/><%
					} else {
						%>&nbsp;<%
					}

					%></td>
			<%
				}
			%>
			<%
			if (rsOrder && !rsOrder.EOF) {
				while (!rsOrder.EOF) {
					%>
						<td style="background-color:<%= bgcolor %>;"><%= rsOrder("itemcode") %></td>
						<td style="background-color:<%= bgcolor %>;text-align:center;"><%= rsOrder("quantity") %></td>
						<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(rsOrder("pricequoted")).toFixed(2) %></td>
						<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat((rsOrder("pricequoted")/11)*10).toFixed(2) %></td>
					<%
					rsOrder.MoveNext();
					if (!rsOrder.EOF) {
						%>
							</tr>
							<tr>
						<%
					} else {
						%></tr><%
					}
				}
			}
			%>
			<tr>
				<td style="background-color:<%= bgcolor %>;">SHIPPING</td>
				<td style="background-color:<%= bgcolor %>;text-align:center;">1</td>
				<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(P._getPurchaseTotalfreight()).toFixed(2) %></td>
				<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat((P._getPurchaseTotalfreight()/11)*10).toFixed(2) %></td>
			</tr>
			<tr>
				<td style="background-color:<%= bgcolor %>;">SURCHARGE</td>
				<td style="background-color:<%= bgcolor %>;text-align:center;">1</td>
				<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(P._getPurchaseTotalcard()).toFixed(2) %></td>
				<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat((P._getPurchaseTotalcard()/11)*10).toFixed(2) %></td>
			</tr>
			<tr>
				<td style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;font-size:1.2em;" colspan="2"><strong>Total : </strong></td>
				<td style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;font-size:1.2em;"><strong>$<%= parseFloat(P._getPurchaseTotalvalue()).toFixed(2) %></strong></td>
				<td style="background-color:<%= bgcolor %>;">&nbsp</td>
			</tr>
			<%


			bgcolor = bgcolor=="#FFFFFF"?"#EFEFEF":"#FFFFFF";
			count ++;
			purchaseid = P._getPurchaseID();
		}
		purchaseid = null;

		%>
		</table>
		<%
	} else {
		%><p>There have been no purchases found matching your search criteria.</p><%
	}

%>
<!--#include file="_gblFooter.asp"-->
