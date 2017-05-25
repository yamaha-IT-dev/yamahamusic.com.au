<!--#include file="_gblHeader.asp"-->

<h1>View Purchase</h1>

<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<%
	var pd = new Date(Date.parse(P._getPurchaseDatecreated()));

%><p>Purchase date : <%= pd.formatDate("d F Y") %></p>

<form action="ctrlReturn.asp" method="post">
	<input type="hidden" name="action" value="new_return" />
	<input type="hidden" name="purchaseid" value="<%= P._getPurchaseID() %>" />

<table border="0" cellpadding="0" cellspacing="0" width="800px" class="border">
<tr>
	<th style="white-space : nowrap;width:35%;">Billing Details</th>
	<th style="white-space : nowrap;width:35%;">Shipping Details</th>
	<th style="white-space : nowrap;width:10%;">Items</th>
	<th style="white-space : nowrap;">Quantity</th>
	<th style="white-space : nowrap;">Price INC.Tax</th>
	<th style="white-space : nowrap;">Price EX.Tax</th>
	<th style="white-space : nowrap;">Return</th>
</tr><%


	var purchaseid = 0;
	var count = 0;
	var bgcolor = "#FFFFFF";


	var rsOrder = O._getAllOrderByPurchase(P._getPurchaseID());
	var rsOrderCount = rsOrder.RecordCount;

	if (!rsOrder && rsOrder.EOF) {
		rsOrder.MoveFirst();
	}

	%>
		<tr>
			<td rowspan="<%= rsOrderCount+2 %>" style="background-color:<%= bgcolor %>;">
				<p><strong><%= P._getPurchaseBillname() %></strong><br/>
				<%= P._getPurchaseBilladdress() %><br/>
				<%= P._getPurchaseBillsuburb() %>&nbsp;<%= P._getPurchaseBillstate() %>&nbsp;&nbsp;<%= P._getPurchaseBillpostcode() %><br/>
				<br/>
				p : <%= P._getPurchaseBillphone() %><br/>
				e : <a href="mailto:<%= P._getPurchaseBillemail() %>"><%= P._getPurchaseBillemail() %></a><br/>
				f : <%= P._getPurchaseBillfax() %><br/>

				</p>

				<p>ANZ eGate<br/>
				Receipt : <strong><%= P._getPurchaseReceipt() %></strong></p>
			</td>
			<td rowspan="<%= rsOrderCount+2 %>" style="background-color:<%= bgcolor %>;">
				<strong><%= P._getPurchaseShipname() %></strong><br/>
				<%= P._getPurchaseShipaddress() %><br/>
				<%= P._getPurchaseShipsuburb() %>&nbsp;<%= P._getPurchaseShipstate() %>&nbsp;&nbsp;<%= P._getPurchaseShippostcode() %><br/>
			</td>
	<%
	if (rsOrder && !rsOrder.EOF) {
		while (!rsOrder.EOF) {
			%>
				<td style="background-color:<%= bgcolor %>;"><%= rsOrder("itemcode") %></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;"><%= rsOrder("quantity") %></td>
				<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(rsOrder("pricequoted")).toFixed(2) %></td>
				<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat((rsOrder("pricequoted")/11)*10).toFixed(2) %></td>
				<td style="background-color:<%= bgcolor %>;text-align:right;white-space:nowrap;">
<%
				if (P._getPurchaseIsFulfilled() == "SHIPPED") {

					if (parseInt(rsOrder("returnid")) > 0 && parseInt(rsOrder("is_returned")) != 0 )
					{
						%>Item <a href="ctrlReturn.asp?action=view_return&returnid=<%= rsOrder("returnid") %>">returned</a><%
					}
					else if ( parseInt(rsOrder("returnid")) > 0 )
					{
						%>Return <a href="ctrlReturn.asp?action=view_return&returnid=<%= rsOrder("returnid") %>">in process</a><%
					}
					else
					{
						%><input type="checkbox" name="order_id" value="<%= rsOrder("id") %>" /><%
					}
				}
%>
				</td>
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td style="background-color:<%= bgcolor %>;">SURCHARGE</td>
		<td style="background-color:<%= bgcolor %>;text-align:center;">1</td>
		<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(P._getPurchaseTotalcard()).toFixed(2) %></td>
		<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat((P._getPurchaseTotalcard()/11)*10).toFixed(2) %></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;">
		<div style="text-align:left;float:left;width:300px;">
		<strong>Notes : </strong><br/>
		<span style="color:red;"><%= P._getPurchaseNotes() %></span>
		</div>
		<strong>Total : </strong></td>
		<td style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;"><strong>$<%= parseFloat(P._getPurchaseTotalvalue()).toFixed(2) %></strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
<%
	if (P._getPurchaseIsFulfilled() == "SHIPPED") {
%>
	<tr>
		<td colspan="5" style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;">
			Start a GRA / Return process for the <strong>selected items</strong>
		</td>
		<td><input type="submit" name="submit" value="GO" class="button" /></td>
	</tr>
<%
	}
%>
	</table>
</form>

<%

	if (P._getPurchaseIsProcessed() != "COMPLETED") {
%>
	<form action="<%= CONTROLLER %>" method="post" style="width:180px;margin-right:20px;float:left;">
		<input type="hidden" name="action" value="<%= SAVE_SALES_ACTION %>" />
		<input type="hidden" name="purchaseid" value="<%= P._getPurchaseID() %>" />
		<fieldset>
			<legend><h2>Record Sales Action</h2></legend>

			<input type="hidden" name="is_processed" value="COMPLETED" />

			<p>BASE Order Number:<br/>
			<input type="text" name="base_order" value="" /></p>

			<p><input type="submit" name="submit" value="save sales action" class="button"/></p>

			<p>
				Upon save, a notice will be sent to <strong>Excel HiFi / 3BC</strong>
				with notice to dispatch this order.
			</p>

		</fieldset>
	</form>
<%
	} else {
%>
	<div style="width:180px;margin-right:20px;float:left;">
		<h2>Sales Action</h2>
		<p><strong><%= P._getPurchaseIsProcessed() %></strong><br/>
		BASE Order : <%= P._getPurchaseBaseorder() %><br/>
		</p>
	</div>
<%
	}
%>


<%
if (P._getPurchaseIsProcessed() == "COMPLETED") {

	if (P._getPurchaseIsFulfilled() != "SHIPPED") {
%>
<form action="<%= CONTROLLER %>" method="post" style="width:180px;margin-right:20px;float:left;">
	<input type="hidden" name="action" value="<%= SAVE_FULFILLMENT_ACTION %>" />
	<input type="hidden" name="purchaseid" value="<%= P._getPurchaseID() %>" />
	<fieldset>
		<legend><h2>Record Fulfillment Action</h2></legend>

		<input type="hidden" name="is_fulfilled" value="SHIPPED" />

		<p>Consignment Note:<br/>
		<input type="text" name="connote" value="" /></p>

		<p>BASE Invoice Number:<br/>
		<input type="text" name="base_invoice" value="" /></p>

		<p><input type="submit" name="submit" value="save fulfillment action" class="button"/></p>

		<p>
			Upon save, a notice will be sent to the <strong>Customer</strong> and
			<strong>YMA Sales</strong> to inform them that this order has been shipped.
		</p>

	</fieldset>
</form>
<%
	} else {
%>
	<div style="width:180px;margin-right:20px;float:left;">
		<h2>Fulfillment Action</h2>
		<p><strong><%= P._getPurchaseIsFulfilled() %></strong><br/>
		BASE Invoice : <%= P._getPurchaseBaseinvoice() %><br/>
		Con-note : <%= P._getPurchaseConnote() %><br/>
		</p>
	</div>
<%
	}
}
%>

<div class="clearing"></div>


<p>&nbsp;</p>


<!--#include file="_gblFooter.asp"-->
