<%

function getSurveyJob(intID, strEmail)
    dim strSQL

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic

    strSQL = "SELECT J.*, DATEDIFF(dd,job_date_created,GetDate()) as elapsed_days,  "
    strSQL = strSQL & "U.username as asc_username, U.firstname as asc_firstname, U.lastname as asc_lastname, U.storename as asc_storename, U.dealer_code as asc_code, U.vendor_code as asc_vendor,"
    strSQL = strSQL & "U.address as asc_address, U.city as asc_city, U.state as asc_state, U.postcode as asc_postcode, U.phone as asc_phone"
    strSQL = strSQL & " FROM tbl_job J "
    strSQL = strSQL & " 	INNER JOIN tbl_users U ON U.user_id = J.job_created_by "
    strSQL = strSQL & "	WHERE job_id = " & intID & " AND email = '" & strEmail & "'"

    rs.Open strSQL, conn

    if not DB_RecSetIsEmpty(rs) Then
        session("asc_storename")    = rs("asc_storename")
        session("firstname")        = rs("firstname")
        session("lastname")         = rs("lastname")
        session("city")             = rs("city")
        session("state")            = rs("state")
        session("model_no")         = rs("model_no")
        Session("serial_no")        = rs("serial_no")
        Session("fault")            = rs("fault")
        session("job_not_found")    = "FALSE"
    else
        session("job_not_found")    = "TRUE"
    end if

    call CloseDataBase()
end function

function addSurvey
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddSurvey"
    cmdObj.CommandType = AdCmdStoredProc

    session("find")             = Request.Form("cboFind")
    session("find_other")       = Request.Form("txtFindOther")
    session("service")          = Request.Form("radService")
    session("fixed")            = Request.Form("radFixed")
    session("location")         = Request.Form("radLocation")
    session("appearance")       = Request.Form("radAppearance")
    session("attitude")         = Request.Form("radAttitude")
    session("knowledge")        = Request.Form("radKnowledge")
    session("date_repair")      = Request.Form("txtDateRepair")
    session("date_completed")   = Request.Form("txtDateCompleted")
    session("speed")            = Request.Form("radSpeed")
    session("satisfaction")     = Request.Form("radSatisfaction")
    session("charged")          = Request.Form("radCharged")
    session("cost")             = Request.Form("txtCost")
    session("comments")         = Request.Form("txtComments")

    Set paraObj = cmdObj.CreateParameter("@find",AdInteger,AdParamInput,2,session("find"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@find_other",AdVarChar,AdParamInput,50,DB_NullToEmpty(session("find_other")))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@service",AdInteger,AdParamInput,2,session("service"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@fixed",AdInteger,AdParamInput,2,session("fixed"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@location",AdInteger,AdParamInput,2,session("location"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@appearance",AdInteger,AdParamInput,2,session("appearance"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@attitude",AdInteger,AdParamInput,2,session("attitude"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@knowledge",AdInteger,AdParamInput,2,session("knowledge"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@date_repair",AdVarChar,AdParamInput,20,session("date_repair"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@date_completed",AdVarChar,AdParamInput,20,session("date_completed"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@speed",AdInteger,AdParamInput,2,session("speed"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@satisfaction",AdInteger,AdParamInput,2,session("satisfaction"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@charged",AdInteger,AdParamInput,2,session("charged"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@cost",AdVarChar,AdParamInput,8,DB_NullToEmpty(session("cost")))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@comments",AdVarChar,AdParamInput,120,session("comments"))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute

        response.write cmdObj.CommandText
        id = rs(0)
        set rs = nothing
    On error Goto 0

    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
        addSurvey = FALSE
        strMessageText = MessageText
        'strMessageText = err.description
    else
        addSurvey = TRUE
        Response.Redirect("thank-you.html")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

%>