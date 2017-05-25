<!--#include file="_gblHeader.asp"-->

<h1>Order Returns</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<% 
	var pd = new Date(Date.parse(P._getPurchaseDatecreated()));

%><p>Purchase date : <%= pd.formatDate("d F Y") %></p>

<div style="width:270px;margin-right:20px;float:left;background-color:#EEE;padding:5px;">
	<h1>Actions</h1>
		<form action="<%= CONTROLLER %>" method="post">
			<input type="hidden" name="returnid" value="<%= R._getReturnID() %>" />
			<input type="hidden" name="purchaseid" value="<%= P._getPurchaseID() %>" />
<% 

	if (R._getReturnIsProcessed().indexOf("YES") != 0) {
%>
			<fieldset style="clear:both;">
				<input type="hidden" name="action" value="<%= SAVE_PROCESSING_ACTION %>" />
				<legend><h2>GRA Pack Request</h2></legend>
				<input type="hidden" name="is_processed" value="YES" checked="checked" />

				<p>
					<input type="radio" name="return_type" value="REPLACEMENT"> Replacement<br/>
					<input type="radio" name="return_type" value="REFUND" checked="checked"> Refund
				</p>

				<p>Enter the GRA number<br/>
				<input type="text" name="gra_number" value="" /></p>

				<p>Record any notes regarding the this action<br/>
				<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

				<p><input type="submit" name="submit" value="save action" class="button"/></p>

				<p>
					Upon save, a notice will be sent to the <strong>Excel Technology</strong> requesting
					they express post the goods return pack including labels and instructions to the customer.
				</p>

			</fieldset>
<% 
	} else {
%>
		<div style="border-top:1px #DDD solid;clear:both;">
			<p style="float:right;"><img src="../images/icons/iconTick.gif" style="margin-right:20px;"/><strong><%= R._getReturnIsProcessed() %></strong></p>
			<h2 style="float:left;">GRA Pack Request</h2>
		</div>
<% 


		if (R._getReturnIsFreightBooked() != "YES") {
	%>
				<fieldset style="clear:both;">
					<input type="hidden" name="action" value="<%= SAVE_FREIGHT_ACTION %>" />
					<legend><h2>Good return pack sent</h2></legend>
					<input type="hidden" name="is_return_freight_booked" value="YES" checked="checked" />

					<p>Enter the express post label number<br/>
					<input type="text" name="express_post" value="" /></p>

					<p>Record any notes regarding the this action<br/>
					<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

					<p><input type="submit" name="submit" value="save action" class="button"/></p>

					<p>
						Upon save, a notice will be sent to the <strong>YMA Sales</strong> indicating
						that return freight has been booked for this customer.
					</p>

				</fieldset>
	<% 
		} else {
	%>
			<div style="border-top:1px #DDD solid;clear:both;">
				<p style="float:right;"><img src="../images/icons/iconTick.gif" style="margin-right:20px;"/><strong><%= R._getReturnIsFreightBooked() %></strong></p>
				<h2 style="float:left;">Good return pack sent</h2>
			</div>
	<% 


			if (R._getReturnIsReceived() != "YES") {
		%>
					<fieldset style="clear:both;">
						<input type="hidden" name="action" value="<%= SAVE_RECIEVED_ACTION %>" />
						<legend><h2>Return Items Received</h2></legend>
						<h3>Record that these items have been<br/>received by Excel Technology</h3>
		
						<input type="hidden" name="is_received" value="YES" />

						<p>Record any notes regarding the this action<br/>
						<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

						<p><input type="submit" name="submit" value="save action" class="button"/></p>

						<p>
							Upon save, a notice will be sent to the <strong>YMA Credit</strong> indicating
							that these items have been recieved by <strong>Excel Technology</strong>.
						</p>

					</fieldset>
		<% 
			} else {
		%>
				<div style="border-top:1px #DDD solid;clear:both;">
					<p style="float:right;"><img src="../images/icons/iconTick.gif" style="margin-right:20px;"/><strong><%= R._getReturnIsReceived() %></strong></p>
					<h2 style="float:left;">Return Items Received</h2>
				</div>
		<% 
		
				if (R._getReturnType().indexOf("REFUND") == 0) {

					if (R._getReturnIsItemRefunded().indexOf("YES") != 0 ) {
				%>
							<fieldset style="clear:both;">
								<input type="hidden" name="action" value="<%= SAVE_REFUND_ACTION %>" />
								<legend><h2>Return Has Been Refunded</h2></legend>
								<h3>Record that this request for product return has now been refunded by Yamaha Music Australia</h3>

								<input type="hidden" name="is_item_refunded" value="YES" />

								<p>Enter the refund receipt number<br/>
								<input type="text" name="receipt" value="" /></p>

								<p>Record any notes regarding the this action<br/>
								<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

								<p><input type="submit" name="submit" value="save action" class="button"/></p>

								<p>
									Upon save, a notice will be to the <strong>Customer</strong> informing them
									that their return and request for refund has either been honoured or denied.
								</p>

							</fieldset>
				<% 
					} else {
				%>
						<div style="border-top:1px #DDD solid;clear:both;">
							<p style="float:right;"><img src="../images/icons/iconTick.gif" style="margin-right:20px;"/><strong><%= R._getReturnIsItemRefunded() %></strong></p>
							<h2 style="float:left;">Return Has Been Refunded</h2>
						</div>

						<fieldset style="clear:both;">
							<input type="hidden" name="action" value="<%= SAVE_NOTE_ACTION %>" />
							<legend><h2>Additional notes</h2></legend>

							<p>Record any notes regarding this return<br/>
							<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

							<p><input type="submit" name="submit" value="save " class="button"/></p>

						</fieldset>

				<% 

					}
				} else {
				
					if (R._getReturnIsItemRefunded().indexOf("YES") != 0 ) {
				%>
							<fieldset style="clear:both;">
								<input type="hidden" name="action" value="<%= SAVE_REFUND_ACTION %>" />
								<legend><h2>Replacement Order Processed</h2></legend>
								<h3>Record that this request for product return has now been replaced by Yamaha Music Australia</h3>

								<input type="hidden" name="is_item_refunded" value="YES" />

								<p>Enter the replacement order number<br/>
								<input type="text" name="receipt" value="" /></p>

								<p>Record any notes regarding the this action<br/>
								<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

								<p><input type="submit" name="submit" value="save action" class="button"/></p>

								<p>
									Upon save, a notice will be to the <strong>Customer</strong> informing them
									that their return and request for refund has either been honoured or denied.
								</p>

							</fieldset>
				<% 
					} else {
				%>
						<div style="border-top:1px #DDD solid;clear:both;">
							<p style="float:right;"><img src="../images/icons/iconTick.gif" style="margin-right:20px;"/><strong><%= R._getReturnIsItemRefunded() %></strong></p>
							<h2 style="float:left;">Replacement Order Processed</h2>
						</div>

						<fieldset style="clear:both;">
							<input type="hidden" name="action" value="<%= SAVE_NOTE_ACTION %>" />
							<legend><h2>Additional notes</h2></legend>

							<p>Record any notes regarding this return<br/>
							<textarea name="notes" rows="5" style="width:250px;"><%= Request("notes") %></textarea></p>

							<p><input type="submit" name="submit" value="save " class="button"/></p>

						</fieldset>

				<% 
					}
				}


			}
		}
	}
%>
</div>

<div style="float:left;">
<table border="0" cellpadding="0" cellspacing="0" width="600px" class="border">
<tr>
	<th style="white-space : nowrap;width:40%;">Billing Details</th>
	<th style="white-space : nowrap;width:30%;">Shipping Details</th>
	<th style="white-space : nowrap;width:10%;">Items</th>
	<th style="white-space : nowrap;">Quantity</th>
	<th style="white-space : nowrap;">Price Quoted</th>
</tr><% 


	var purchaseid = 0;
	var count = 0;
	var bgcolor = "#FFFFFF";
	var refund_total = 0;


	if (rsOrder) {

		var rsOrderCount = rsOrder.RecordCount;
		if (!rsOrder && !rsOrder.EOF) {
			rsOrder.MoveFirst();
		}

		%>
			<tr>
				<td rowspan="<%= rsOrderCount %>" style="background-color:<%= bgcolor %>;">
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
				<td rowspan="<%= rsOrderCount %>" style="background-color:<%= bgcolor %>;">
					<strong><%= P._getPurchaseShipname() %></strong><br/>
					<%= P._getPurchaseShipaddress() %><br/>
					<%= P._getPurchaseShipsuburb() %>&nbsp;<%= P._getPurchaseShipstate() %>&nbsp;&nbsp;<%= P._getPurchaseShippostcode() %><br/>
				</td>
		<%
		if (rsOrder && !rsOrder.EOF) {
			while (!rsOrder.EOF) {
				%>
					<td style="background-color:<%= bgcolor %>;"><%= rsOrder("itemcode") %>
						<input type="hidden" name="orderid" value="<%= rsOrder("id") %>" />
					</td>
					<td style="background-color:<%= bgcolor %>;text-align:center;"><%= rsOrder("quantity") %></td>
					<td style="background-color:<%= bgcolor %>;text-align:right;">$<%= parseFloat(rsOrder("pricequoted")).toFixed(2) %></td>
				<%
				refund_total += (rsOrder("quantity") * rsOrder("pricequoted"));
				
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
	}
	%>
	<tr>
		<td colspan="4" style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;"><strong>Possible Refund : </strong></td>
		<td style="background-color:<%= bgcolor %>;text-align:right;padding-bottom:20px;"><strong>$<%= parseFloat(refund_total).toFixed(2) %></strong></td>
	</tr>
	</table>
</form>	

<p>&nbsp;</p>

<h2>Notes</h2>
<p><%= doBRTags(R._getReturnNotes()) %></p>

</div>
<div class="clearing"></div>




<!--#include file="_gblFooter.asp"-->
