<!--#include file="_gblHeader.asp"-->


<h1>List All Customers - <%= C._getCustomerCount() %></h1>
<h2><%


	var strLetter = new String(Request("letter")).indexOf("undefined")==0?"A":new String(Request("letter"));

	for (var i=0; i<26; i++) {
		tmpLetter = String.fromCharCode("A".charCodeAt(0) + i);
		if (tmpLetter.indexOf(strLetter) == 0) {
			%><strong><%= tmpLetter %></strong><%		
		} else {
			%><a href="<%= CONTROLLER %>?letter=<%= tmpLetter %>"><%= tmpLetter %></a><%		
		}
		if (i < 25) { %>&nbsp;-&nbsp;<% }
	}

%></h2>
<%

	var rsAllCustomers = C._getAllCustomers(strLetter);
	
	if (rsAllCustomers && !rsAllCustomers.EOF) {

		var intRecordCount = rsAllCustomers.RecordCount;
		var intStart = !isNaN(parseInt(Request("start")))?parseInt(Request("start")):0;
		var intPageSize = 25;
		var intCount = 0
		var intPageCount = Math.ceil(intRecordCount/intPageSize);
/*
Response.Write("intRecordCount = " + intRecordCount + "<br/>");
Response.Write("intStart = " + intStart + "<br/>");
Response.Write("intPageSize = " + intPageSize + "<br/>");
Response.Write("intCount = " + intCount + "<br/>");
Response.Write("intPageCount = " + intPageCount + "<br/>");
*/
		%><p>Go to page : <%
		for (var i=0; i<intPageCount; i++) {
			var strBold = Math.floor(intStart/intPageSize)==i?" style=\"font-weight:bold;\"":"";
			%><a href="<%= CONTROLLER %>?letter=<%= strLetter %>&start=<%= i*intPageSize %>"<%= strBold %>><%= i+1 %></a>&nbsp;&nbsp;<%
		}
		if (Math.floor(intStart/intPageSize)+1 != intPageCount) {
			%><a href="<%= CONTROLLER %>?letter=<%= strLetter %>&start=<%= intStart+intPageSize %>">[next]</a><% 
		}
		%></p><%


		rsAllCustomers.Move(intStart);

		%><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th></th>
			<th style="width:35%;">Full Name</th>
			<th style="width:15%;">State</th>
			<th style="width:15%;">Joined</th>
			<th style="width:15%;">Changed</th>
			<th></th>
		</tr>
		<%
		while (!rsAllCustomers.EOF) {
			%>
			<tr>
				<td><a href="<%= CONTROLLER %>?action=<%= EDIT_CUSTOMER %>&customerid=<%= rsAllCustomers("id") %>" class="button">EDIT</a></td>
				<td><%= new String(rsAllCustomers("lastname")).toUpperCase() %>,&nbsp;<%= rsAllCustomers("title") %>&nbsp;<%= rsAllCustomers("firstname") %></td>
				<td><%= rsAllCustomers("state") %></td>
				<td><%= new Date(Date.parse(rsAllCustomers("datecreated"))).formatDate("d/m/Y") %></td>
				<td><%
					if (new String(rsAllCustomers("datemodified")) != "null") {
						Response.Write(new Date(Date.parse(rsAllCustomers("datemodified"))).formatDate("d/m/Y"));
					}
				%></td>
				<td><a href="<%= CONTROLLER %>?action=<%= DELETE_CUSTOMER %>&customerid=<%= rsAllCustomers("id") %>" class="button" onclick="return confirm('Are you sure you want to delete this customer?');">DELETE</a></td>
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
