<!--#include file="_gblHeader.asp"-->
<h1>List All Yamaha Connect Dealers</h1>
<form name="listUserForm" action="<%= CONTROLLER %>" method="post">            
<% 	
	if (rsAllDealers && !rsAllDealers.EOF) {
		%><%= rsAllDealers.RecordCount %> dealers found.<% 
	}	
	%>
</form>
<%
	if (rsAllDealers && !rsAllDealers.EOF) {

		%>
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <th></th>
              <th>Username</th>
              <th>Full Name</th>
              <th>Address</th>
              <th>City</th>
              <th>State</th>
              <th>Postcode</th>
              <th>Phone</th>
              <th>Email</th>
              <th>Login Count</th>
              <th>Date Last Login</th>
              <th>Date Created</th>
              <th>Status</th>
              <th></th>
            </tr>
            <%
		while (!rsAllDealers.EOF) {
			%>
            <tr>
              <td><a href="<%= CONTROLLER %>?action=<%= EDIT_USER %>&userid=<%= rsAllDealers("id") %>" class="button">EDIT</a></td>
              <td><%= rsAllDealers("username") %></td>
              <td><%= rsAllDealers("title") %>&nbsp;<%= rsAllDealers("firstname") %>&nbsp;<%= rsAllDealers("lastname") %></td>
              <td><%= rsAllDealers("address") %></td>
              <td><%= rsAllDealers("city") %></td>
              <td><%= rsAllDealers("state") %></td>
              <td><%= rsAllDealers("postcode") %></td>
              <td><%= rsAllDealers("phone") %></td>
              <td><%= rsAllDealers("email") %></td>
              <td><%= rsAllDealers("logincount") %></td>
              <td width="10%"><%= rsAllDealers("datelastlogin") %></td>
              <td width="10%"><%= rsAllDealers("datecreated") %></td>
              <td><%
			   if (rsAllDealers("status") == 1) {
			    	Response.Write("<font color='green'>Approved</font>")
				} else { 
					Response.Write("<font color='red'>Not Approved</font>") 
					}
			   %></td>
              <td><a href="<%= CONTROLLER %>?action=<%= DELETE_USER %>&userid=<%= rsAllDealers("id") %>" class="button" onclick="return confirm('Are you sure you want to delete <%= rsAllDealers("username") %>?');">DELETE</a></td>
            </tr>
            <%
			rsAllDealers.moveNext();
		}
		%>
          </table>
          <%
	} else {
		%>
          <p>There were no dealers found.</p>
          <%
	}
%>
<!--#include file="_gblFooter.asp"-->