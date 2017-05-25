<%Option Explicit%>
<!--#include virtual="/ForceSSL.inc"-->
<!--#include file="../include/connection.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<%
'dim ckie
'dim ckiename
'dim cookie

'ckie = Request.ServerVariables("HTTP_COOKIE")
'if ckie <> "" then
'	ckiename = Mid(ckie,1,(Instr(ckie,"=")-1))
'else
'	response.redirect("../default.asp")
'end if

'Response.AddHeader "Set-Cookie", ckiename  & "=NULL;secure;HttpOnly; path=/"

session.lcid = 2057

dim recaptcha_public_key
recaptcha_public_key = "6LeDjCIUAAAAAP2J3NX7inaxXFaURajy2NsVjbBg"

function recaptcha_challenge_writer(publickey)
	recaptcha_challenge_writer = "<script type=""text/javascript"">" & _
	 "var RecaptchaOptions = {" & _
	 " theme : 'clean'," & _
	 " tabindex : 0" & _
	 "};" & _
	 "</script>" & _
	 "<script type=""text/javascript"" src=""https://www.google.com/recaptcha/api/challenge?k=" & publickey & """></script>" & _
	 "<noscript>" & _
	 "<iframe src=""https://www.google.com/recaptcha/api/noscript?k=" & publickey & """ frameborder=""1""></iframe>" & _
	 "<textarea name=""recaptcha_challenge_field"" id=""recaptcha_challenge_field"" rows=""3"" cols=""40""></textarea>" & _
	 "<input type=""hidden"" name=""recaptcha_response_field"" id=""recaptcha_response_field"" value=""manual_challenge"">" & _
	 "</noscript>"
end function

'********************************************************************
'Function: 		SetSessionVariables
'Description: 	This function either collects the form variables and sets the required session variables or clears the previous values.
'				The session variables are used to maintain state between requests to add records.
'Parameters:	blnSetType - to fill with form variables or clear
'********************************************************************
Function SetSessionVariables(blnSetType)
	if blnSetType = TRUE then
		Session("UsrUsername") 		= server.htmlencode(Request("UserName"))
		Session("UsrPassword") 		= server.htmlencode(Request("Password"))		
	elseif blnSetType = FALSE then
		Session("UsrUsername") 		= ""
		Session("UsrPassword") 		= ""
		Session("UsrLoginRole")  	= 0
		Session("UsrUserID")     	= 0
	else
		SetSessionVariables = FALSE
		Exit Function
	end if

	Session.Timeout = 5 'number of minutes
	
	SetSessionVariables = TRUE
End Function

Function incrementFailedLoginCounter(strUsername)
	dim strSQL

	Call OpenDataBase()

	strSQL = "UPDATE tbl_users SET "
	strSQL = strSQL & "failed_login = failed_login + 1 "
	strSQL = strSQL & "		WHERE username = '" & Trim(strUsername) & "'"

	on error resume next
	conn.Execute strSQL

	On error Goto 0

	if err <> 0 then
		strMessageText = err.description
	else
		strMessageText = "Login failed. Please retry."
	end if

	Call CloseDataBase()
end function

function testUserLogin
	Dim cmdObj, paraObj
	
	call OpenDataBase

	Set cmdObj = Server.CreateObject("ADODB.Command")
	cmdObj.ActiveConnection = conn
	cmdObj.CommandText = "spUserLogin"
	cmdObj.CommandType = AdCmdStoredProc

	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Session("UsrUsername"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Session("UsrPassword"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("intUserID",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("intLogin",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj

	On Error Resume Next
	cmdObj.Execute

	'if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
	If Err.number <> 0 or conn.Errors.Count <> 0 Then	
		testUserLogin = FALSE
		call incrementFailedLoginCounter(Session("UsrUsername"))
		response.Redirect("default.asp")
	else
		Session("UsrUserID")     = cmdObj("intUserID")
		AntiFixationInit()
		response.Redirect("jobs.asp")
		
		testUserLogin = TRUE
	end if

	Call DB_closeObject(paraObj)
	Call DB_closeObject(cmdObj)

	call CloseDataBase
end function

'********************************************************************
'Page: User Login
'Description: Function used by the users to log into the system.
'Validates user name and password and gets a list of jobs.
'********************************************************************
Sub Main()	
    if(request("logout")="y")then
        Session.Abandon
		response.Redirect("default.asp")
    end if

    call SetSessionVariables(False)
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Login" then			
			' Define some variables to be used on page
			dim pubkey, privkey, challenge, form_response, test_captcha, recaptcha_confirm
			 
			' Customize your public and private keys and other variables
			pubkey = "6LeDjCIUAAAAAP2J3NX7inaxXFaURajy2NsVjbBg"
			privkey = "6LeDjCIUAAAAAHKkGZjzldvX94ZoyJs0kIckqFOM"
			 
			' Get the user input
			challenge = Request.Form("recaptcha_challenge_field")
			form_response = Request.Form("recaptcha_response_field")
			 
			' Generate the POST string for reCaptcha
			Dim VarString
			VarString = _
				"privatekey=" & privkey & _
				"&remoteip=" & Request.ServerVariables("REMOTE_ADDR") & _
				"&challenge=" & challenge & _
				"&response=" & form_response
			 
			' Make an AJAX call to validate input reCaptcha
			Dim objXmlHttp
			Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
			if isNull(objXmlHttp) then
				Set objXmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
			end if
			objXmlHttp.open "POST", "https://www.google.com/recaptcha/api/verify", False
			objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
			objXmlHttp.send VarString
			 
			' Receive response from reCaptcha server
			Dim ResponseString
			ResponseString = split(objXmlHttp.responseText, vblf)
			Set objXmlHttp = Nothing			
			
			if ResponseString(0) = "true" then
				call SetSessionVariables(True)
				if testUserLogin then
				
				end if
			else
				strMessageText = "Captcha word does not match. Please try again"
			end if
		end if	
	end if	
end sub

dim strMessageText

call Main
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Cache-control" content="no-store">
<title>Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script type="text/javascript">
var RecaptchaOptions = { theme : 'clean' };

function validateLogin(theForm) {
	var reason = "";
	var blnSubmit = true;
	
	reason += validateEmail(theForm.username);
	reason += validateSpecialCharacters(theForm.username,"Username");
	
	reason += validateEmptyField(theForm.password,"Password");

  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Login';		
		return true;
    }
}

function session_cookie_change() {
    var s,a;
    s=document.cookie.split(/\=/);            
	a=s[0];            
	alert(a);
    var dtExpires = new Date();                
    dtExpires.setFullYear(1970,1,1);            
    a += ';expires=' + dtExpires.toGMTString();            
    a += '; path=/';             
    document.cookie=a;
	alert(a);
	alert(document.cookie);
}
</script>
</head>
<body>
<img src="images/main-banner.jpg" border="0" />
<form name="loginForm" id="loginForm" method="post" action="" onsubmit="return validateLogin(this)">
  <table width="400" border="0" cellpadding="5" cellspacing="0">
    <tr>
      <td align="right">Username:</td>
      <td><input name="username" maxlength="60" style="width:250px;" /></td>
    </tr>
    <tr>
      <td align="right">Password:</td>
      <td><input name="password" type="password" maxlength="60" style="width:250px;" autocomplete="off" /></td>
    </tr>
    <tr><td colspan="2"><div id="captchadiv" name="captchadiv"><%=recaptcha_challenge_writer(recaptcha_public_key)%></div></td></tr>
    <tr>
      <td></td>
      <td><input type="hidden" name="Action" />
        <input type="hidden" name="sessionid" value="" />
        <input type="submit" value="Login" />
        <p><a href="forgot.asp">Forgot your password?</a></p>
      <font color="red"><%= strMessageText %></font></td>
    </tr>
  </table>
</form>

</body>
</html>