<!--#include file="global/pageHeaderDiscussion.asp" -->

<h1>Discussion Forums</h1>
<% 



	T._loadTopic(intTopicID);
	%><h2><%= T._getTopicName() %></h2>
	<div id="thread">
	<%

	D._drawItemFull(intThreadID, intThreadID, U, P, 0);

	D._drawThread(intThreadID, intThreadID, U, P, 1, true);

%>
	</div>

<p>&nbsp;</p>
<%

	if (Session("yma_userid")) {

		intUserID = Session("yma_userid");
		D = null;
		D = new Discussion();

		%><!--#include file="discussionForm.asp" --><%

	} else { 
	
		%><!--#include file="discussionLoginForm.asp" --><%
	}

%>
<p><a href="<%= CONTROLLER %>?action=<%= SHOW_DISCUSSION %>&topicid=<%= intTopicID %>">Return to main topic</a>.

<!--#include file="global/pageFooter.asp" -->
