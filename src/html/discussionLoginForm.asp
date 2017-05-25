<form name="discussionLogin" action="<%= CONTROLLER %>" method="POST">
	<input type="hidden" name="action" value="<%= AUTHENTICATE_USER %>">
	<input type="hidden" name="referrer" value="<%= Request.ServerVariables("SCRIPT_NAME") %>?<%= Request.QueryString %>">

	<h2>Discussion Forum Login</h2>
	<p>If you're a <abbr title="A registered user is a customer who has registered to use the forums">registered user</abbr> you can join this discussion, why don't you log in and share your thoughts.</p>
<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
	<table cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td><p>Username</p></td>
		<td><input name="username" type="text" value="<%= U._getUserUsername() %>" size="20"></td>
	</tr>
	<tr>
		<td><p>Password</p></td>
		<td><input name="password" type="password" value="<%= U._getUserPassword() %>" size="20" ></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" name="submit" value="login" class="button"></td>
	</tr>
	</table>

</form>