<%
function checkUsername(strEmail)
    dim strSQL
    dim rs

    call OpenDataBase()

    strSQL = "SELECT * FROM yma_user WHERE username = '" & strEmail & "'"
    'response.Write strSQL

    set rs = Server.CreateObject("ADODB.recordset")

    rs.Open strSQL, conn

    if rs.EOF then
        Response.Redirect("confirm/")
    else
        dim strUsername, strPassword, JMail

        strUsername = rs("username")
        strPassword = rs("password")

        Set JMail = CreateObject("JMail.SMTPMail")

        JMail.ServerAddress = "smtp.bne.server-mail.com"
        JMail.Subject       = "Yamaha Connect Login"
        JMail.Sender        = "MPDOrders-AUS@music.yamaha.com"

        JMail.AddRecipient (strEmail)

        JMail.Body          = "G'day," & vbCrLf _
                            & "" & vbCrLf _
                            & "As requested, your password is: " & strPassword & vbCrLf _
                            & "" & vbCrLf _
                            & "This is an automated email. Please do not reply to this address."
        JMail.Execute

        set JMail = nothing

        strMessageText = "<div class=""alert alert-danger""><img src=""../images/icon_cross.png""> That email is already registered in our system. The login detail has been sent to that email.</div>"
    end if

    call CloseDataBase()
end function

function registerUser(strUsername, strPassword, strFirstname, strLastname, strAddress, strCity, strState, strPostcode, strPhone, strDealer)
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj                  = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection     = conn
    cmdObj.CommandText          = "spRegisterConnectUser"
    cmdObj.CommandType          = AdCmdStoredProc

    Set paraObj = cmdObj.CreateParameter("@username",AdVarChar,AdParamInput,60,Server.HTMLEncode(strUsername))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@password",AdVarChar,AdParamInput,20,strPassword)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@firstname",AdVarChar,AdParamInput,30,Server.HTMLEncode(strFirstname))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@lastname",AdVarChar,AdParamInput,30,Server.HTMLEncode(strLastname))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@address",AdVarChar,AdParamInput,60,Server.HTMLEncode(strAddress))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@city",AdVarChar,AdParamInput,20,Server.HTMLEncode(strCity))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@state",AdVarChar,AdParamInput,3,Server.HTMLEncode(strState))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@postcode",AdVarChar,AdParamInput,4,Server.HTMLEncode(strPostcode))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@phone",AdVarChar,AdParamInput,12,Server.HTMLEncode(strPhone))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@dealer",AdVarChar,AdParamInput,30,Server.HTMLEncode(strDealer))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
        id = rs(0)
        set rs = nothing
    On error Goto 0

    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
        strMessageText = err.description
        addRequest = FALSE
        strMessageText = MessageText
    else
        addRequest = TRUE

        Set JMail = CreateObject("JMail.SMTPMail")

        JMail.ServerAddress   = "smtp.bne.server-mail.com"
        JMail.Subject         = "New Yamaha Connect User Registration"
        JMail.Sender          = "noreply@yamaha.com.au"
        JMail.AddRecipient     ("MPDOrders-AUS@music.yamaha.com")

        JMail.Body            = "G'day!" & vbCrLf _
                              & "" & vbCrLf _
                              & "This new user registration requires your approval." & vbCrLf _
                              & "" & vbCrLf _
                              & "Username: " & strUsername & vbCrLf _
                              & "First name: " & strFirstname & vbCrLf _
                              & "Last name: " & strLastname & vbCrLf _
                              & "Address: " & strAddress & vbCrLf _
                              & "City: " & strCity & vbCrLf _
                              & "Dealer: " & strDealer & vbCrLf _
                              & "" & vbCrLf _
                              & "This is an automated email. Please do not reply to this address."
        JMail.Execute

        set JMail = nothing

        Response.Redirect("thank-you.html")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>