<%

'****************************************************************************************
'**  Copyright Notice    
'**                                                              
'**  Copyright (C)2001-2012 Web Wiz Ltd. All Rights Reserved.   
'**  
'**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS UNDER LICENSE FROM WEB WIZ LTD.                      
'**
'**  This program is free software; you can modify (at your own risk) any part of it 
'**  under the terms of the License that accompanies this software and use it both 
'**  privately and commercially.
'**
'**  All copyright notices must remain intact in the source files
'**
'**  This program is distributed in the hope that it will be useful,
'**  but WITHOUT ANY WARRANTY; without even the implied warranty of
'**  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR ANY OTHER 
'**  WARRANTIES WHETHER EXPRESSED OR IMPLIED.
'**
'****************************************************************************************



'Set the response buffer to true so we execute all asp code before sending the HTML to the clients browser
Response.Buffer = True

'Dimension variables
Dim strBody 			'Holds the body of the e-mail
Dim objJMail 			'Holds the mail server object
Dim strMyEmailAddress 		'Holds your e-mail address
Dim strSMTPServerAddress	'Holds the SMTP Server address
Dim strCCEmailAddress		'Holds any carbon copy e-mail addresses if you want to send carbon copies of the e-mail
Dim strBCCEmailAddress		'Holds any blind copy e-mail addresses if you wish to send blind copies of the e-mail
Dim strReturnEmailAddress	'Holds the return e-mail address of the user
Dim strSmtpServerUsername	'Holds the username for the SMTP server
Dim strSmtpServerPassword	'Holds the password for the SMTP server


'----------------- Place your e-mail address in the following sting ---------------------------------

strMyEmailAddress = "gandi.gan@music.yamaha.com"

'---------- Place the address of the SMTP server you are using in the following sting ---------------

strSMTPServerAddress = "smtp.bne.server-mail.com"

'------Place the username and password of the SMTP server you are using in the following stings ------

strSmtpServerUsername = "Username"
strSmtpServerPassword = "Password"

'-------------------- Place Carbon Copy e-mail address in the following sting ------------------------

strCCEmailAddress = "" 'Use this string only if you want to send the carbon copies of the e-mail

'-------------------- Place Blind Copy e-mail address in the following sting -------------------------

strBCCEmailAddress = "" 'Use this string only if you want to send the blind copies of the e-mail

'-----------------------------------------------------------------------------------------------------


'Read in the users e-mail address
strReturnEmailAddress = Request.Form("email")


'Initialse strBody string with the body of the e-mail
strBody = "<h2>E-mail sent from form on Web Site</h2>"
strBody = strBody & "<br><b>Name: </b>" & Request.Form("firstName") & " " & Request.Form("lastName")
strBody = strBody & "<br><br><b>Address: -</b>"
If (Request.Form("street1")) > "" Then 
	strBody = strBody & "<br>  " & Request.Form("street1")
End If
If (Request.Form("street2")) > "" Then 
	strBody = strBody & "<br>  " & Request.Form("street2") 
End If
If (Request.Form("town")) > "" Then 
	strBody = strBody & "<br>  " & Request.Form("town")
End If
If (Request.Form("county")) > "" Then 
	strBody = strBody & "<br>  " & Request.Form("county")
End If
If (Request.Form("country")) > "--- Choose One ---" Then
	strBody = strBody & "<br>  " & Request.Form("country")
End IF
If (Request.Form("postCode")) > "" Then 
	strBody = strBody & "<br>  " & Request.Form("postCode")
End If
strBody = strBody & "<br><br><b>Telephone: </b>" & Request.Form("tel")
strBody = strBody & "<br><b>E-mail: </b>" & strReturnEmailAddress
strBody = strBody & "<br><br><b>Enquiry: - </b><br>" & Replace(Request.Form("enquiry"), vbCrLf, "<br>")


'Check to see if the user has entered an e-mail address and that it is a valid address otherwise set the e-mail address to your own otherwise the e-mail will be rejected
If Len(strReturnEmailAddress) < 5 OR NOT Instr(1, strReturnEmailAddress, " ") = 0 OR InStr(1, strReturnEmailAddress, "@", 1) < 2 OR InStrRev(strReturnEmailAddress, ".") < InStr(1, strReturnEmailAddress, "@", 1) Then
	
	'Set the return e-mail address to your own
	strReturnEmailAddress = strMyEmailAddress
End If	


'Send the e-mail

'Create the e-mail server object
Set objJMail = Server.CreateObject("Jmail.Message")

'SMTP Server Username and Password
'objJMail.MailServerUserName = strSmtpServerUsername
'objJMail.MailServerPassword = strSmtpServerPassword

'Senders email address
objJMail.From = strReturnEmailAddress

'Senders name
objJMail.FromName = Request.Form("firstName") & " " & Request.Form("lastName")

'Who the email is sent to
objJMail.AddRecipient strMyEmailAddress

'Who the carbon copies are sent to
objJMail.AddRecipientCC strCCEmailAddress

'Who the blind copies are sent to
objJMail.AddRecipientBCC strBCCEmailAddress

'Set the subject of the e-mail
objJMail.Subject = "Enquiry sent from enquiry form on website"


'Set the main body of the e-mail (HTML format)
objJMail.HTMLBody = strBody

'Set the main body of the e-mail (Plain Text format)
'objJMail.Body = strBody

'Importance of the e-mail ( 1 - highest priority, 3 - normal, 5 - lowest)
objJMail.Priority = 3 

'Send the e-mail
objJMail.Send(strSMTPServerAddress & ":25")
	
'Close the server object
Set objJMail = Nothing
%>
<html>
<head>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<title>Contact Us</title>

<!-- Web Wiz JMmail Forms - If you want your own ASP Email Form and form then goto http://www.webwiz.co.uk -->

</head>
<body text="#000000" bgcolor="#FFFFFF" link="#0000FF" vlink="#990099" alink="#FF0000">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="2"> 
      <h1 align="center">Contact Us</h1>
    </td>
  </tr>
</table>
<br>
<br>
<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center"> Thank-you <% = Request.Form("firstName") %>&nbsp;<% = Request.Form("lastName") %> for filling in the enquiry form. 
    <br>
    I shall be receiving your enquiry shortly and will reply as soon as possible.</td>
  </tr>
</table>
<div align="center"><br>
	Powered by <a href="http://www.webwiz.co.uk" target="_blank">Web Wiz JMail Form's</a> version 2.0
	<br>Copyright &copy;2001-2012 Web Wiz Ltd.
</div>
</body>
</html>