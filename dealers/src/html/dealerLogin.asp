<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Yamaha Connect Login</title>
<link rel="stylesheet" href="../include/stylesheet.css" type="text/css" />
</head>
<body class="login_page">
<div align="center">
  <p><img src="../images/yamaha_logo_login.jpg" border="0" /></p>
  <p><img src="../images/login_text_header.jpg" border="0" /></p>
  <table cellpadding="0" cellspacing="0" class="login_inner_table">
    <tr>
      <td class="login_column" width="50%"><h1>Login</h1>
        <%
		if (message.length > 0) {
			%>
        <p class="error_message"><%= message %></p>
        <%
		}
		  %>
        <form action="<%= CONTROLLER %>" method="post" id="loginForm">
          <input type="hidden" name="action" value="<%= VALIDATE_USER %>" />
          <p>Username (Email):<br/>
            <input name="username" type="email" value="<%= U._getUserUsername() %>" size="35" maxlength="60" placeholder="Email Address" required />
          </p>
          <p>Password:<br/>
            <input type="password" name="password" value="<%= U._getUserPassword() %>" size="35" maxlength="50" placeholder="Password" autocomplete="off" required />
          </p>
          <p>
            <input type="submit" name="submit" id="submit" value="Login" />
          </p>
        </form>
        <p><a href="../forgot.asp">Forgotten password?</a></p></td>
      <td valign="top" width="50%"><!--<h1>New User</h1>
        <p>Don't have a username / password?</p>
        <h2><a href="register.asp">Register Here</a></h2>-->
        </td>
    </tr>
  </table>
</div>
</body>
</html>