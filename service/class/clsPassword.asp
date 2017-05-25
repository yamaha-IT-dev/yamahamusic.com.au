<%

function retrievePassword(strEmail)
    dim strSQL
    dim rs

    Call OpenDataBase()

    strSQL = "SELECT * FROM tbl_users WHERE username = '" & strEmail & "' "
    'response.Write strSQL	

    set rs = Server.CreateObject("ADODB.recordset")

    rs.Open strSQL, conn

    if rs.EOF then
        strMessageText = "<font color=red>Sorry, but that email address was not found in our system. Please try again with the email address you registered with.</font>"
    else
        dim strFirstname
        dim strUsername
        dim strPassword
        dim JMail

        strFirstname    = rs("firstname")
        strUsername     = rs("username")
        strPassword     = rs("password")

        Set JMail = CreateObject("JMail.SMTPMail")

        JMail.ServerAddress = "smtp.bne.server-mail.com"
        JMail.Subject       = "Service Centre Login"
        JMail.Sender        = "au_webmaster@gmx.yamaha.com"
        JMail.SenderName    = "Yamaha Music Australia"
        JMail.AddRecipient (strEmail)

        JMail.Body      = "Hi " & strFirstname & "," & vbCrLf _
                        & "" & vbCrLf _
                        & "Below is your login details as requested." & vbCrLf _
                        & "" & vbCrLf _
                        & "U: Your email" & vbCrLf _
                        & "P: " & strPassword & vbCrLf _
                        & "" & vbCrLf _
                        & "Regards," & vbCrLf _
                        & "" & vbCrLf _
                        & "Yamaha Music Australia"

        JMail.Execute

        set JMail = nothing

        strMessageText = "The login details have been sent to your email. Please check your inbox."
    end if

    call CloseDataBase()
end function

%>