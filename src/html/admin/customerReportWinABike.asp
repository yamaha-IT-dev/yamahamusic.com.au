<!--#include file="_gblHeader.asp"-->


<h1>Customer Reports</h1>

<h2>Win a Bike Competition</h2>
<%
	
	if (rsAllCustomers && !rsAllCustomers.EOF) {

		var intRecordCount = rsAllCustomers.RecordCount;
		var intStart = !isNaN(parseInt(Request("start")))?parseInt(Request("start")):0;
		var intPageSize = 25;
		var intCount = 0
		var intPageCount = Math.ceil(intRecordCount/intPageSize);


		%><p>Go to page : <%
		for (var i=0; i<intPageCount; i++) {
			var strBold = Math.floor(intStart/intPageSize)==i?" style=\"font-weight:bold;\"":"";
			%><a href="<%= CONTROLLER %>?start=<%= i*intPageSize %>"<%= strBold %>><%= i+1 %></a>&nbsp;&nbsp;<%
		}
		if (Math.floor(intStart/intPageSize)+1 != intPageCount) {
			%><a href="<%= CONTROLLER %>?start=<%= intStart+intPageSize %>">[next]</a><% 
		}
		%></p><%


		rsAllCustomers.Move(intStart);

		%><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th>State</th>
			<th>Model</th>
			<th>Number Sold</th>
		</tr>
		<%
		while (!rsAllCustomers.EOF) {
			%>
			<tr>
				<td><%= rsAllCustomers("state") %></td>
				<td><%= rsAllCustomers("modelnumber") %></td>
				<td><%= rsAllCustomers("sold") %></td>
			</tr>
			<%
			rsAllCustomers.moveNext();
			intCount++;
			if (intCount == intPageSize) {
				break;
			}
		}
		%></table><%
	} else {
		%><p>There are no users.</p><%
	}

%>

<!--#include file="_gblFooter.asp"-->
