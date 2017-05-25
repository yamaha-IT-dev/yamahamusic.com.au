<!--#include file="_gblHeader.asp"-->


<h1>User Login</h1>

<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>

<form name="loginForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= VALIDATE_USER %>">
	
	<p>Enter your username<br/>
	<input type="text" name="username" value="<%= U._getUserUsername() %>" /></p>

	<p>Enter your password<br/>
	<input type="password" name="password" value="<%= U._getUserPassword() %>" /></p>

	<p><input type="submit" name="submit" value="log in" class="button" /></p>


</form>

<!--#include file="_gblFooter.asp"-->
