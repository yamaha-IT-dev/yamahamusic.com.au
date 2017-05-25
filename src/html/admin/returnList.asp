<!--#include file="_gblHeader.asp"-->

<h1>Order Returns</h1>

<%

	if (rsReturns && !rsReturns.EOF) {
		%><table border="0" cellpadding="0" cellspacing="0" class="border">
		<tr>
			<th>Date return initiated</th>
			<th>Purchase</th>
			<th>Name</th>
			<th>Processed?</th>
			<th>Freight Booked?</th>
			<th>Received?</th>
			<th>Refunded?</th>
		</tr>
		<%
		var bgcolor = "#FFFFFF";
		while (!rsReturns.EOF) {
			strD = new Date(Date.parse(rsReturns("datecreated"))).formatDate("jS F Y g:ia")
			
			%>
			<tr>
				<td style="background-color:<%= bgcolor %>;"><a href="<%= CONTROLLER %>?action=<%= VIEW_RETURN %>&returnid=<%= rsReturns("id") %>"><%= strD %></a></td>
				<td style="background-color:<%= bgcolor %>;"><a href="ctrlPurchase.asp?action=view_purchase&purchaseid=<%= rsReturns("purchaseid") %>">view purchase</a></td>
				<td style="background-color:<%= bgcolor %>;"><%= rsReturns("billname") %></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;"><% rsReturns("is_processed")=="YES"?%><img src="../images/icons/iconTick.gif"/><% :"" %></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;"><% rsReturns("is_return_freight_booked")=="YES"?%><img src="../images/icons/iconTick.gif"/><% :"" %></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;"><% rsReturns("is_received")=="YES"?%><img src="../images/icons/iconTick.gif"/><% :"" %></td>
				<td style="background-color:<%= bgcolor %>;text-align:center;"><% rsReturns("is_item_refunded")=="YES"?%><img src="../images/icons/iconTick.gif"/><% :"" %></td>
			</tr>
			<%
			bgcolor = bgcolor=="#FFFFFF"?"#EFEFEF":"#FFFFFF";
			rsReturns.MoveNext();
		}
		%></table>
		<%
	}
	else 
	{
		%><p>There have been no returns found matching your search criteria.</p><%
	}

%>
<!--#include file="_gblFooter.asp"-->
