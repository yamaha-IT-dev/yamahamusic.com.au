<%

var replySubject = D._getDiscussionSubject();
/*
if (D._getDiscussionSubject().indexOf("RE: ") < 0) {
	replySubject = new String("RE: " + D._getDiscussionSubject());
}
*/

if (intParentID == 0) {
	%><h2>Start a new discussion in this forum</h2><%
} else {
	if (replySubject.length) {
		D._setDiscussionSubject(replySubject);
	}
	%><h2>Reply</h2><%
}


if (message.length) {
	%><p class="alert"><%= message %><%
}

%>
<a name="form"></a>
<form name="discussionForm" action="<%= CONTROLLER %>" method="POST">

	<input type="hidden" name="action" value="<%= SAVE_POST %>">
	<input type="hidden" name="threadid" value="<%= intThreadID %>">
	<input type="hidden" name="parentid" value="<%= intThreadID %>">
	<input type="hidden" name="topicid" value="<%= intTopicID %>">
	<input type="hidden" name="userid" value="<%= intUserID %>">
	
	<p><b>Subject</b>
	<br><input type="text" name="subject" value="<%= D._getDiscussionSubject() %>" style="width:400px;">

	<p><b>Message</b>
	<br><textarea name="message" rows="5" style="width:400px;"><%= D._getDiscussionMessage() %></textarea>
	
	<p><input type="checkbox" name="usernotify" value="1"<%= D._getDiscussionUsernotify()==1?" checked=\"checked\"":"" %>>&nbsp; Notify me when someone replies to my post.
	
	<p><input type="submit" name="submit" value="post message" class="button">
	
</form>