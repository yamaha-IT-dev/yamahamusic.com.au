<% Option Explicit %>
<!--#include file="../include/connection.asp " -->
<%
sub checkUsername
    dim strSQL
    dim rs
    dim strEmail

    strEmail  = trim(request("txtEmail"))

    OpenDataBase()

    strSQL = "SELECT * FROM tbl_users WHERE username = '" & strEmail & "' "
    'response.Write strSQL

    set rs = Server.CreateObject("ADODB.recordset")

    rs.Open strSQL, conn

    'On error Goto 0
    if rs.EOF then
        strMessageText = "<br>That email address was not found in our system. Please try again with the email address you registered with."
    else
        dim strFirstname
        dim strUsername
        dim strPassword
        dim JMail

        strFirstname    = rs("firstname")
        strUsername     = rs("username")
        strPassword     = rs("password")

        Set JMail = CreateObject("JMail.Message")

        JMail.MailServerUserName    = "yamahamusicau"
        JMail.MailServerPassWord    = "str0ppy@16"
        JMail.Subject               = "Yamaha Goods Return Login Details"
        JMail.From                  = "AVsales-aus@music.yamaha.com"

        JMail.AddRecipient (strEmail)

        JMail.Body      = "Dear " & strFirstname & "," & vbCrLf _
                        & "" & vbCrLf _
                        & "As requested, below is your login information." & vbCrLf _
                        & "" & vbCrLf _
                        & "Username: Your email address" & vbCrLf _
                        & "Password: " & strPassword & vbCrLf _
                        & "" & vbCrLf _
                        & "Regards," & vbCrLf _
                        & "" & vbCrLf _
                        & "Yamaha Music Australia"
        JMail.Send("smtp.sendgrid.net:25")

        set JMail = nothing

        strMessageText = "The login details have been sent to your email. Please check your inbox."
    end if

    call CloseDataBase()
end sub

sub main
    if Request.ServerVariables("REQUEST_METHOD") = "POST" then
        if trim(request("Action")) = "Add" then
            call checkUsername
        end if
    end if
end sub

dim strMessageText
call main
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Forgot Username / Password</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap-goal.css">
<link rel="stylesheet" href="css/style.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script>
function validateFormOnSubmit(theForm) {
    var reason = "";
    var blnSubmit = true;

    reason += validateEmail(theForm.txtEmail);

    if (reason != "") {
        alert(reason);
        blnSubmit = false;

        return false;
    }

    if (blnSubmit == true) {
        theForm.Action.value = 'Add';

        return true;
    }
}
</script>
</head>
<body>
    <a href="./"><img src="images/yamaha.jpg" border="0" /></a>
    <h2>Forgot username / password?</h2>
    <form action="" method="post" name="form_forgot_password" id="form_forgot_password" onsubmit="return validateFormOnSubmit(this)">
        <div class="form-group">
            <label for="txtEmail">Email <font color="red">*</font>:</label>
            <input type="text" class="form-control" name="txtEmail" id="txtEmail" placeholder="Email Address" maxlength="60" />
        </div>
        <div class="form-group">
            <input type="hidden" name="Action" />
            <input type="submit" name="submit" id="submit" class="btn btn-default" value="Submit" />
        </div>
    </form>
    <p><font color="red"><%= strMessageText %></font></p>
    <p><img src="images/backward_arrow.gif" border="0" /> <a href="./">Back to Login</a></p>
</body>
</html>
