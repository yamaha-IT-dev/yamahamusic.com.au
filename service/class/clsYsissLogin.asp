<%

Function setYsissSessionVariables(blnSetType)
    if blnSetType = TRUE then
        Session("yssUsername")  = Request("ysissUsername")
        Session("yssPassword")  = Request("ysissPassword")
    elseif blnSetType = FALSE then
        Session("yssUsername")  = ""
        Session("yssPassword")  = ""
        Session("yssID")        = 0
        Session("yssUserID")    = 0
        Session("yssStatus")    = 0
    else
        'error
        setYsissSessionVariables = FALSE
        Exit Function
    end if

    Session.Timeout = 420 'number of minutes

    setYsissSessionVariables = TRUE
End Function

function ysissLogin
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spYsissLogin"
    cmdObj.CommandType = AdCmdStoredProc

    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Session("yssUsername"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Session("yssPassword"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("yssID",AdInteger,adParamInputOutput,4,0)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("yssUserID",AdInteger,adParamInputOutput,4,0)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("yssStatus",AdInteger,adParamInputOutput,4,0)
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute
    'On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
        ysissLogin = FALSE
    else
        Session("yssID")        = cmdObj("yssID")
        Session("yssUserID")    = cmdObj("yssUserID")
        Session("yssStatus")    = cmdObj("yssStatus")

        call validateYsissLogin

        if Session("yssStatus") = 99 then
            Response.Redirect("confirm_ysiss.asp")
        else
            Response.Redirect("new_assessment.asp")
        end if

        ysissLogin = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function validateYsissLogin()
    if Len(Trim(Session("yssID"))) = 0 then
        Session("yssUsername")  = ""
        Session("yssPassword")  = ""
        Session("yssID")        = ""
        Session("yssUserID")    = ""
        Session("yssStatus")    = ""
        response.Redirect("http://www.yamahamusic.com.au/service/assessment.asp")
    end if
end function

'-----------------------------------------------
' GET YSISS DETAILS
'-----------------------------------------------
Function getYsissDetails(intID)
    dim strSQL

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic

    strSQL = "SELECT * FROM tbl_ysiss "
    strSQL = strSQL & "	WHERE yssID = " & intID

    rs.Open strSQL, conn

    'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
        session("ysissFirstname")   = Trim(rs("yssFirstname"))
        session("ysissLastname")    = Trim(rs("yssLastname"))
        session("ysissMobile")      = Trim(rs("yssMobile"))
        session("ysissEmail")       = Trim(rs("yssEmail"))
        session("ysissCompany")     = Trim(rs("yssCompany"))
    end if

    call CloseDataBase()

end function

'-----------------------------------------------
' UPDATE YSISS DETAILS
'-----------------------------------------------
function updateYsiss(intID,strFirstname,strLastname,strMobile,strEmail,strCompany)
    dim strSQL

    Call OpenDataBase()

    strSQL = "UPDATE tbl_ysiss SET "
    strSQL = strSQL & "yssFirstname = '" & server.htmlencode(strFirstname) & "',"
    strSQL = strSQL & "yssLastname = '" & server.htmlencode(strLastname) & "',"
    strSQL = strSQL & "yssMobile = '" & server.htmlencode(strMobile) & "',"
    strSQL = strSQL & "yssEmail = '" & strEmail & "',"
    strSQL = strSQL & "yssCompany = '" & server.htmlencode(strCompany) & "',"
    strSQL = strSQL & "yssStatus = 1, "
    strSQL = strSQL & "yssDateConfirmed = GetDate() "
    strSQL = strSQL & "		WHERE yssID = " & intID

    'response.Write strSQL
    on error resume next
    conn.Execute strSQL

    if err <> 0 then
        strMessageText = err.description
    else
        Response.Redirect("new_assessment.asp")
        'strMessageText = "<div class=""notification_text""><img src=""images/icon_check.png""> Your details have been updated.</div>"
    end if

    Call CloseDataBase()
end function

%>