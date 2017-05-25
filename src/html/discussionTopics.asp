<!--#include file="global/pageHeaderDiscussion.asp" -->

<h1>Discussion Forums</h1>

<%
	if (rsAllTopics && !rsAllTopics.EOF) {
		var tmpGroupID = 0;
		var count = 0
		while (!rsAllTopics.EOF) {

			if (tmpGroupID != parseInt(rsAllTopics("groupid"))) {
				%><h2><%= rsAllTopics("group") %></h2><%
			}

			var d = new Date(Date.parse(rsAllTopics("datecreated")));
			%>
			<h3><a href="<%= CONTROLLER %>?action=<%= SHOW_DISCUSSION %>&topicid=<%= rsAllTopics("id") %>"><%= rsAllTopics("name") %></a></h3>
			<p><%= rsAllTopics("description") %></p>
			<%
			tmpGroupID = parseInt(rsAllTopics("groupid"));
			count++;
			rsAllTopics.moveNext();
		}
	} else {
		%><p>There are no discussion topics.</p><%
	}

%>


<!--#include file="global/pageFooter.asp" -->
