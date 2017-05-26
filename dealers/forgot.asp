<!--#include file="../include/connection.asp " -->
<!--#include file="../include/FRM_build_form.asp " -->
<!--#include file="../include/functions.asp " -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Connect - Forgot Your Login Details?</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
function trim(s)
{
  return s.replace(/^\s+|\s+$/, '');
}

function validateEmail(fld) {
    var error="";
    var tfld = trim(fld.value);                        // value of field with whitespace trimmed off
    var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
   
    if (fld.value == "") {
        fld.style.background = 'Yellow';
        error = "Email address has not been filled in.\n";
    } else if (!emailFilter.test(tfld)) {              //test email for illegal characters
        fld.style.background = 'Yellow';
        error = "Please enter a valid email address.\n";
    } else if (fld.value.match(illegalChars)) {
        fld.style.background = 'Yellow';
        error = "Email address contains illegal characters.\n";
    } else {
        fld.style.background = 'White';
    }
    return error;
}

function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;

  	reason += validateEmail(theForm.txtEmail);
  
  	if (reason != "") {
    	alert(reason);    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Add';
  		//theForm.submit();
		
		return true;
    }
}
</script>
</head>
<body class="login_page">
<%
sub checkUsername
	dim strSqlQuery
	dim strEmail
			
	strEmail  = trim(request("txtEmail"))
		
	OpenDataBase()
	
	strSqlQuery = "SELECT * FROM yma_user INNER JOIN yma_customer ON yma_user.customerid = yma_customer.id WHERE yma_customer.email = '" & strEmail & "' "
	'response.Write strSqlQuery	
	
	set rs = Server.CreateObject("ADODB.recordset")			
	
	rs.Open strSqlQuery, conn
	
	'On error Goto 0
	if rs.EOF then
    	strMessageText = "<br>That email address was not found in our system. Please try again with the email address you registered with."
    else
		dim strFirstname
		dim strUsername
    	dim strPassword
		
		strFirstname 	= rs("firstname")
		strUsername		= rs("username")
    	strPassword 	= rs("password")							
		
		Set JMail = CreateObject("JMail.SMTPMail")
		
		JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Subject		= "Yamaha Connect Login Details"
		JMail.Sender		= "au_webmaster@gmx.yamaha.com"
				
		'JMail.AddRecipientBCC ("Harsono_Setiono@gmx.yamaha.com")
		JMail.AddRecipient (strEmail)
		
		JMail.Body    	= "Dear " & strFirstname & "," & vbCrLf _
						& "" & vbCrLf _
						& "Thank you for your query. Below is the information that you requested" & vbCrLf _ 
						&	"----------------------------------------------------------------------------" & vbCrLf _
						& "Username: " & strUsername & vbCrLf _
						& "Password: " & strPassword & vbCrLf _
						&	"----------------------------------------------------------------------------" & vbCrLf _
						& "Please go to www.yamahamusic.com.au/dealers/resources/ to start using Yamaha Connect." & vbCrLf _ 
						& "" & vbCrLf _ 
						& "Best regards," & vbCrLf _ 
						& "" & vbCrLf _ 
						& "Yamaha Music Australia" & vbCrLf _ 
				
		'JMail.BodyFormat = 0
		'JMail.MailFormat = 0
		JMail.Execute
		
		set JMail = nothing	
									
		strMessageText = "The login details have been sent to your email address. Please check your email inbox."
	end if	
	
	call CloseDataBase()
end sub

sub main
	if trim(request("Action")) = "Add" then
		call checkUsername
	end if
end sub
dim strMessageText
call main
%>
<table align="center" class="login_table">
  <tr>
    <td><a href="resources/"><img src="images/yamaha_logo_login.jpg" border="0" /></a> <br />
      <img src="images/login_text_header.jpg" border="0" /></td>
  </tr>
  <tr>
    <td><table cellpadding="0" cellspacing="0" class="login_inner_table">
        <tr>
          <td class="login_1">&nbsp;</td>
          <td class="login_2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" class="login_column" valign="top"><font color="red"><%= strMessageText %></font>
          <h1>Forgot your username / password?</h1>
            <form action="" method="post" name="form_forgot_password" id="form_forgot_password" onsubmit="return validateFormOnSubmit(this)">              
              <table>
                <tr>
                  <td>Please enter your email:</td>
                  <td><input type="text" id="txtEmail" name="txtEmail" maxlength="40" size="60" class="green_border" /></td>
                </tr>
                <tr>
                  <td colspan="2"><br />
                    <input type="hidden" name="Action" />
                    <input type="submit" value="Submit" /></td>
                </tr>
              </table>
            </form>
            <p><img src="images/backward_arrow.gif" border="0" /> <a href="resources/">Back to the login page</a></p></td>
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