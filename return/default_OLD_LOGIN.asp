<%Option Explicit%>
<!--#include file="../include/connection.asp " -->
<%
session.lcid = 2057
'********************************************************************
'Function: 		SetSessionVariables
'Description: 	This function either collects the form variables and sets the required session variables or clears the previous values.
'				The session variables are used to maintain state between requests to add records. 
'Parameters:	blnSetType - to fill with form variables or clear
'********************************************************************
Function SetSessionVariables(blnSetType)
	if blnSetType = TRUE then 
		'save the form values
		Session("UsrUsername") 		= server.htmlencode(Request("UserName"))
		Session("UsrPassword") 		= server.htmlencode(Request("Password"))
	elseif blnSetType = FALSE then 
		'clear the session variables and set defaults
		Session("UsrUsername") 		= ""
		Session("UsrPassword") 		= ""
		Session("UsrLoginRole")  	= 0
		Session("UsrUserID")     	= 0
		Session("UsrDivision") 		= ""
	else 
		'error
		SetSessionVariables = FALSE
		Exit Function
	end if
	
	Session.Timeout = 180 'number of minutes
	
	SetSessionVariables = TRUE
End Function
    
function testUserLogin

	Dim cmdObj, paraObj
	
	call OpenDataBase
			
	Set cmdObj = Server.CreateObject("ADODB.Command")
	cmdObj.ActiveConnection = conn
	cmdObj.CommandText = "spUserLogin"
	cmdObj.CommandType = AdCmdStoredProc
			
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Session("UsrUsername"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Session("UsrPassword"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("intUserID",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("intLogin",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj
	'Set paraObj = cmdObj.CreateParameter("strDivision",AdInteger,adParamInputOutput,50,0)
	'cmdObj.Parameters.Append paraObj
			
	On Error Resume Next
	cmdObj.Execute
	'On error Goto 0
			
	if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
		testUserLogin = FALSE
	else
		Session("UsrLoginRole")  = cmdObj("intLogin")
		Session("UsrUserID")     = cmdObj("intUserID")
				
		UTL_validateLogin
		
		if Request.Cookies("current_URL_cookie_gra") = "" then
			response.Redirect("home.asp")
		else 
			response.Redirect(Request.Cookies("current_URL_cookie_gra"))
		end if
		testUserLogin = TRUE
	end if
	
	Call DB_closeObject(paraObj)
	Call DB_closeObject(cmdObj)
			
	call CloseDataBase

end function

'********************************************************************
'Page: User Login
'Description: Function used by the users to log into the system.
'Validates user name and password and gets a list of courses.
'********************************************************************
Sub Main()

    if(request("logout")="y")then
        Session.Abandon        
    end if

    call SetSessionVariables(False)
    
    if trim(request("Action")) = "Login" then
    
        call SetSessionVariables(True)
    
        ' We check if the user is login		
        if testUserLogin then
        end if
    end if
end sub

call Main

dim strMessageText
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Goods Return Authority</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
    function setFocus()
    {
    document.forms[0].username.focus();
    }
 
    // We validate the for fields
    function validateForm()
    {    
        var strUsername = document.forms[0].username.value;
        var strPassword = document.forms[0].password.value;
        var blnSubmit = true;
        
        // We check if all the values are entered
        if (strUsername == ''){
            alert('Please enter a username to login');
            document.forms[0].username.focus();
            blnSubmit = false;            
        }
        
        if ((strPassword == '') && (blnSubmit == true)){
            alert('Please enter a password to login');
            document.forms[0].password.focus();
            blnSubmit = false;            
        }
        
        if (blnSubmit == true){
            document.forms[0].Action.value = 'Login';            
            return true;            
            //document.forms[0].submit();
        } else {
        
            return false;
        }    
    }
</script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" height="100%" class="main_content_table">
  <tr>
    <td valign="top"><img src="images/main-banner.jpg" border="0" />
      <h2 align="center">Goods Return</h2>
      <form name="gra_login_form" id="gra_login_form" method="post" action="default.asp" onsubmit="return validateForm()">
        <table width="550" align="center" border="0" cellpadding="4" cellspacing="0">
          <tr>
            <td colspan="2"><h2><img src="images/add_icon.png" border="0" /> <a href="register.asp">New user? Register here</a></h2></td>
          </tr>
          <tr>
            <td>Username (Email):</td>
            <td><input name="username" maxlength="55" size="65" /></td>
          </tr>
          <tr>
            <td>Password:</td>
            <td><input name="password" type="password" maxlength="50" size="65" /></td>
          </tr>
          <tr>
            <td colspan="2"><font color="red"><%= strMessageText %></font></td>
          </tr>
          <tr>
            <td></td>
            <td><p>
                <input type="hidden" name="Action" />
                <input type="submit" value="Login" />
              </p>
              <p><a href="forgot.asp"><small>Forgot your username / password?</small></a></p></td>
          </tr>
        </table>
      </form></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>