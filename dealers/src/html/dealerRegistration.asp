<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Connect - Registration</title>
<link rel="stylesheet" href="../include/stylesheet.css" type="text/css" />
</head>
<body class="login_page">
<table border="0" align="center" class="login_table">
  <tr>
    <td><a href="default.asp"><img src="../images/yamaha_logo_login.jpg" border="0" /></a> <br />
      <img src="../images/login_text_header.jpg" border="0" /></td>
  </tr>
  <tr>
    <td valign="top"><table cellpadding="0" cellspacing="0" class="login_inner_table">
        <tr>
          <td class="login_1">&nbsp;</td>
          <td class="login_2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" class="login_column"><img src="../images/user_registration.jpg" border="0" />
            <%
	if (message.length > 0) {
		%>
            <p class="error_message"><%= message %></p>
            <%
	}
%>
            <form name="registrationForm" action="<%= CONTROLLER %>" method="post">
              <input type="hidden" name="action" value="<%= SAVE_REGISTRATION %>">
              <input type="hidden" name="usertypeid" value="<%= U._getUserUsertypeID() %>" />

                <p><strong>Email (Username):</strong><br />
                  <input type="text" name="username" value="<%= U._getUserUsername() %>" maxlength="50" style="width:250px;" class="green_border" />
                </p>
                <p><strong>Confirm Email:</strong><br />
                   <input type="text" name="email" maxlength="50" value="<%= C._getCustomerEmail() %>" style="width:250px;" class="green_border" />
              </p>
                <p><strong>Password:</strong><br />
                  <input type="password" name="password" value="<%= U._getUserPassword() %>" maxlength="30" style="width:250px;" class="green_border" />
                </p>   
                <hr />
                <p><strong>Store Name</strong><br />
                <input type="text" name="storename" value="<%= C._getCustomerCountry() %>" maxlength="25" style="width:250px;" class="green_border" /></p>           
              <p style="float:left;padding-right:10px;"><strong>Title</strong> <br/>
                <select name="title" style="width:50px;border:#c7dea6 1px solid">
                  <option value="">...</option>
                  <%
			for (var i=1; i < GBL_TITLES.length; i++) {
				%>
                  <option value="<%= GBL_TITLES[i] %>"<%= C._getCustomerTitle().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option>
                  <%
			}
		%>
                </select>
                
              <p style="float:left;padding-right:10px;"><strong>First Name</strong><br/>
                <input type="text" name="firstname" value="<%= C._getCustomerFirstname() %>" maxlength="25" style="width:250px;" class="green_border" />
              <p style="float:left;padding-right:10px;"><strong>Last Name</strong><br/>
                <input type="text" name="lastname" value="<%= C._getCustomerLastname() %>" maxlength="25" style="width:250px;" class="green_border" />
              <p style="clear:both;"><strong>Address</strong><br/>
              <input type="text" name="address" value="<%= C._getCustomerAddress() %>" maxlength="50" style="width:400px;" class="green_border" />
              </p>
              <p style="float:left;padding-right:10px;"><strong>Suburb</strong><br/>
                <input type="text" name="suburb" maxlength="25" value="<%= C._getCustomerCity() %>" style="width:145px;" class="green_border" />
              </p>
              <p style="float:left;padding-right:10px;"><strong>State</strong><br/>
                <select name="state" style="width:75px;border:#c7dea6 1px solid"  >
                  <option value="">choose...</option>
                  <%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%>
                  <option value="<%= GBL_STATES_SHORT[i] %>"<%= C._getCustomerState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_SHORT[i] %></option>
                  <%
			}
		%>
                </select>
              </p>
              <p style="float:left;padding-right:10px;"><strong>Postcode</strong><br/>
                <input type="text" name="postcode" maxlength="4" value="<%= C._getCustomerPostcode() %>" style="width:50px;" class="green_border" />
              </p>
              <div class="clearing"></div>
              <p style="float:left;padding-right:10px;"><strong>Phone No</strong><br/>
                <input type="text" name="phone" maxlength="15" value="<%= C._getCustomerPhone() %>" style="width:120px;" class="green_border" />
              </p>
              <div class="clearing"></div>
              <p>
                <input type="image" name="submit" src="../images/btn_register.jpg" >
              </p>             
            </form></td>
        </tr>
        <tr>
          <td colspan="2" class="login_column"><p><em>All fields are required</em></p>
          <p><img src="../../images/backward_arrow.gif" border="0" /> <a href="../resources/">Back to the login page</a></p></td>
        </tr>
        <tr>
          <td class="login_3">&nbsp;</td>
          <td class="login_4">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
