<!--#include file="global/pageHeaderDiscussion.asp" -->

<h1>Discussion Forums</h1>

<% 

	T._loadTopic(intTopicID);
	
	%><h2><%= T._getTopicName() %> Discussion Topics</h2><%


/*
	This loop calls a recursive function [drawThread()] 
	this is located back in the controller, the HTML here
	really only handles the first posts to the thread.

	Check the controller to adjust any of the HTML for the
	other parts of the thread.

 */
	var depthcount = 0;
	var bgcolor = "#F0EDFB";
	if (arrDiscussion.length > 0) {
		for (var i=0; i < arrDiscussion.length; i++) {
			%><div id="discussion" style="background-color:<%= bgcolor %>;"><%
			var intDiscussionID = arrDiscussion[i];

			D._drawItemLite(intDiscussionID, intDiscussionID, U, P, depthcount);

			/*
			var arrChildren = D._getAllDiscussionByParent(intDiscussionID);
			if (arrChildren.length > 0) {
				D._drawThread(intDiscussionID, intDiscussionID, U, P, depthcount++, false);
			}
			*/
			depthcount = 0;
			bgcolor = bgcolor=="#F0EDFB"?"#FFFFFF":"#F0EDFB";
			%></div><%
		}
	} else {
		if (arrDiscussion.length == 0) {
			if (Session("yma_userid")) {
				%><p><strong>This discussion topic is empty</strong></p><%
			} else {
				%><p><strong>This discussion topic is empty</strong><br/>Since you are not logged in or authorised to post on this forum, you may not start a new thread.</p><%
			}
		} else if (depthcount == 0) {
			%><p>Sorry, no one has replied to this post yet.</p><%
		}
	}


%>

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

<!--#include file="global/pageFooter.asp" -->
