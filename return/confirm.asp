<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsGRA.asp " -->
<!--#include file="class/clsUser.asp " -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Goods Return Authority - Thank you</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
</head>
<body>
<%
sub sendEmailNotification
	Set JMail=CreateObject("JMail.SMTPMail")

	JMail.ServerAddress = "smtp.bne.server-mail.com"
	JMail.Subject		= "New GRA - Entry by: " & session("usr_storename") & " (" & session("usr_firstname") & " " & session("usr_lastname") & ")" & ""
	JMail.Sender		= "AVsales-aus@music.yamaha.com"
	JMail.SenderName	= "Yamaha Music Australia"

	JMail.AddRecipient ("AVsales-aus@music.yamaha.com")

	JMail.Body    	= "G-day!" & vbCrLf _
					& "" & vbCrLf _
					& "There is a new GRA submitted by: " & session("usr_storename") & " (" & session("usr_branch") & ")" & vbCrLf _
					& "------------------------------------------------------------------------------" & vbCrLf _
					& "Model no       : " & session("new_model_no") & vbCrLf _
					& "Serial no      : " & session("new_serial_no") & vbCrLf _
					& "Invoice no     : " & session("new_invoice_no") & vbCrLf _
					& "Date purchased : " & session("new_date_purchased") & vbCrLf _
					& "Claim no       : " & session("new_claim_no") & vbCrLf _
					& "Order no       : " & session("new_replacement_order_no") & vbCrLf _
					& "Reason         : " & session("new_reason") & vbCrLf _
					& "Fault          : " & session("new_fault") & vbCrLf _
					& "Tests          : " & session("new_test_performed") & vbCrLf _
					& "Accessories    : " & session("new_accessories") & vbCrLf _
					& "Packaging      : " & session("new_packaging") & vbCrLf _
					& "------------------------------------------------------------------------------" & vbCrLf _
					& " " & vbCrLf _
					& "Please click on this link to view the list: " & vbCrLf _
					& "http://intranet:78/list_gra.asp" & vbCrLf _
					& " " & vbCrLf _
					& "This is an automated email. Please do not reply to this email." & vbCrLf _
					& " " & vbCrLf _
					& "Yamaha Music Australia" & vbCrLf _

	'JMail.BodyFormat = 0
	'JMail.MailFormat = 0
	JMail.Execute

	set JMail = nothing
end sub

sub main
	call UTL_validateLogin
	call sendEmailNotification
	call setClearGraSessions
end sub

call main
%>
<table border="0" cellpadding="0" cellspacing="0" align="center" height="100%" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td valign="top"><h2 align="center">The GRA has been successfully submitted.</h2>
      <p align="center">Click here to go back to the <a href="home.asp">home</a> or here to <a href="add_return.asp">add another record</a></p></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>
