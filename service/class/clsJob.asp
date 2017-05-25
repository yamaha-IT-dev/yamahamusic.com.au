<%

function clearNewJobSessions
    'New Customer Details Sessions
    session("new_firstname")        = ""
    session("new_lastname")         = ""
    session("new_phone")            = ""
    session("new_mobile")           = ""
    session("new_address")          = ""
    session("new_city")             = ""
    session("new_state")            = ""
    session("new_postcode")         = ""
    session("new_email")            = ""

    'New Job Details Sessions
    session("new_job_received")     = ""
    session("new_job_no")           = ""
    session("new_warranty")         = ""
    session("new_model_no")         = ""
    session("new_changeover_model") = ""
    session("new_warranty_code")    = ""
    session("new_serial_no")        = ""
    session("new_invoice_no")       = ""
    session("new_date_purchased")   = ""
    session("new_dealer")           = ""
    session("new_fault")            = ""
    session("new_accessories")      = ""
    session("new_comments")         = ""
    session("new_job_status")       = ""
    Session("user_token")           = ""
end function

function addJob
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddJob"
    cmdObj.CommandType = AdCmdStoredProc

    'New Customer Details Sessions
    session("new_firstname")        = Trim(request("txtFirstname"))
    session("new_lastname")         = Trim(request("txtLastname"))
    session("new_phone")            = Trim(request("txtPhone"))
    session("new_mobile")           = Trim(request("txtMobile"))
    session("new_address")          = Trim(request("txtAddress"))
    session("new_city")             = Trim(request("txtCity"))
    session("new_state")            = Trim(request("cboState"))
    session("new_postcode")         = Trim(request("txtPostcode"))
    session("new_email")            = Trim(request("txtEmail"))

    'New Job Details Sessions
    session("new_job_received")     = Trim(request("txtJobReceived"))
    session("new_job_no")           = Trim(request("txtJobNo"))
    session("new_warranty")         = Trim(request("cboWarranty"))
    session("new_model_no")         = Ucase(Trim(request("txtModelNo")))
    session("new_changeover_model") = Request.Form("chkChangeoverModel")
    session("new_warranty_code")    = Trim(request("cboWarrantyCode"))
    session("new_serial_no")        = Ucase(Trim(request("txtSerialNo")))
    session("new_invoice_no")       = Trim(request("txtInvoiceNo"))
    session("new_date_purchased")   = Trim(request("txtDatePurchased"))
    session("new_dealer")           = Trim(request("txtDealer"))
    session("new_fault")            = Trim(request("txtFault"))
    session("new_accessories")      = Trim(request("txtAccessories"))
    session("new_comments")         = Trim(request("txtComments"))

    if session("new_changeover_model") = "on" then
        session("new_changeover_model") = 1
    else
        session("new_changeover_model") = 0
    end if

    'Customer Details
    Set paraObj = cmdObj.CreateParameter("@first_name",AdVarChar,AdParamInput,30, session("new_firstname"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@last_name",AdVarChar,AdParamInput,30, session("new_lastname"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@phone_no",AdVarChar,AdParamInput,15, session("new_phone"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@mobile",AdVarChar,AdParamInput,30, session("new_mobile"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@address",AdVarChar,AdParamInput,80, session("new_address"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@city",AdVarChar,AdParamInput,30, session("new_city"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@state",AdChar,AdParamInput,5, session("new_state"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@postcode",AdInteger,AdParamInput,4, session("new_postcode"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@email",AdVarChar,AdParamInput,60, session("new_email"))
    cmdObj.Parameters.Append paraObj

    'Job Details
    Set paraObj = cmdObj.CreateParameter("@job_received",AdVarChar,AdParamInput,20, session("new_job_received"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@job_no",AdVarChar,AdParamInput,20, session("new_job_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@warranty",AdInteger,AdParamInput,2, session("new_warranty"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@model_no",AdVarChar,AdParamInput,30, session("new_model_no"))
    cmdObj.Parameters.Append paraObj
    set paraObj = cmdObj.CreateParameter("@changeover_model",AdBoolean,AdParamInput,1, session("new_changeover_model"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@warranty_code",AdChar,AdParamInput,5, session("new_warranty_code"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@serial_no",AdVarChar,AdParamInput,15, session("new_serial_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@invoice_no",AdVarChar,AdParamInput,15, session("new_invoice_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@date_purchased",AdVarChar,AdParamInput,20, session("new_date_purchased"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@dealer",AdVarChar,AdParamInput,30, session("new_dealer"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@fault",AdVarChar,AdParamInput,600, session("new_fault"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@accessories",AdVarChar,AdParamInput,600, session("new_accessories"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@comments",AdVarChar,AdParamInput,600, session("new_comments"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@job_created_by",AdInteger,AdParamInput,2, session("UsrUserID"))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
        id = rs(0)
        set rs = nothing
    On error Goto 0

    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
        addCustomer = FALSE
        strMessageText = MessageText
        'strMessageText = err.description
    else
        addCustomer = TRUE

        if session("new_changeover_model") = "1" then
            Dim JMail
            Set JMail = CreateObject("JMail.SMTPMail")
            JMail.ServerAddress = "smtp.bne.server-mail.com"
            JMail.Subject       = "New Changeover Model Repair Job"
            JMail.Sender        = "noreply@yamaha.com"
            JMail.SenderName    = "Yamaha Music Australia"
            JMail.AddRecipient ("matthew.madden@music.yamaha.com")
            'JMail.AddRecipient ("victor.samson@music.yamaha.com")
            JMail.Body  = "G'day!" & vbCrLf _
                        & "" & vbCrLf _
                        & "A new repair job has been created with a changover model:" & vbCrLf _
                        & "" & vbCrLf _
                        & "Name:         " & Session("new_firstname") & " " & Session("new_lastname") & vbCrLf _
                        & "Suburb:       " & Session("new_city") & vbCrLf _
                        & "----------------------------------------------------------------------------" & vbCrLf _
                        & "Job Received: " & Session("new_job_received") & vbCrLf _
                        & "Job No:       " & Session("new_job_no") & vbCrLf _
                        & "Model:        " & Session("new_model_no") & vbCrLf _
                        & "Serial:       " & Session("new_serial_no") &  vbCrLf _
                        & "Dealer:       " & Session("new_dealer") & vbCrLf _
                        & "Purchased:    " & Session("new_date_purchased") & vbCrLf _
                        & "Fault:        " & Session("new_fault") & vbCrLf _
                        & "" & vbCrLf _
                        & "http://intranet:78/list_jobs.asp" & vbCrLf _
                        & "" & vbCrLf _
                        & "This is an automated email. Please do not reply to this email."
            JMail.Execute
            Set Jmail = nothing
        end if

        call clearNewJobSessions

        Response.Redirect("jobs.asp")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function updateJob
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spUpdateJob"
    cmdObj.CommandType = AdCmdStoredProc

    session("job_id")               = Trim(request("job_id"))

    'Customer Details
    session("firstname")            = Trim(request("txtFirstname"))
    session("lastname")             = Trim(request("txtLastname"))
    session("phone")                = Trim(request("txtPhone"))
    session("mobile")               = Trim(request("txtMobile"))
    session("address")              = Trim(request("txtAddress"))
    session("city")                 = Trim(request("txtCity"))
    session("state")                = Trim(request("cboState"))
    session("postcode")             = Trim(request("txtPostcode"))
    session("email")                = Trim(request("txtEmail"))

    'Job Details
    session("job_received")         = Trim(request("txtJobReceived"))
    session("job_no")               = Trim(request("txtJobNo"))
    session("warranty")             = Trim(request("cboWarranty"))
    session("model_no")             = Ucase(Trim(request("txtModelNo")))
    session("warranty_code")        = Trim(request("cboWarrantyCode"))
    session("serial_no")            = Ucase(Trim(request("txtSerialNo")))
    session("invoice_no")           = Trim(request("txtInvoiceNo"))
    session("date_purchased")       = Trim(request("txtDatePurchased"))
    session("dealer")               = Trim(request("txtDealer"))
    session("fault")                = Trim(request("txtFault"))
    session("accessories")          = Trim(request("txtAccessories"))
    session("comments")             = Trim(request("txtComments"))
    session("job_status")           = Trim(request("cboStatus"))

    'Return Details
    session("date_return")          = Trim(request("txtDateReturn"))
    session("pickup_courier")       = Trim(request("txtPickupCourier"))
    session("pickup_connote")       = Trim(request("txtPickupConnote"))
    session("date_received")        = Trim(request("txtDateReceived"))
    session("return_courier")       = Trim(request("txtCourier"))
    session("return_connote")       = Trim(request("txtConnote"))

    'Report Details
    session("labour")               = Trim(request("txtLabour"))
    session("parts")                = Trim(request("txtParts"))
    session("travel_rate")          = Trim(request("txtTravelRate"))
    session("travel_hours")         = Trim(request("txtTravelHours"))
    session("gst")                  = Trim(request("txtGST"))
    session("total")                = Trim(request("txtTotal"))
    session("repair_report")        = Trim(request("txtRepairReport"))
    session("date_completed")       = Trim(request("txtDateCompleted"))

    'Customer Details
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("job_id"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("firstname"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("lastname"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15, DB_NullToEmpty(session("phone")))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, DB_NullToEmpty(session("mobile")))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80, session("address"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("city"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdChar,AdParamInput,5, session("state"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("postcode"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,60, DB_NullToEmpty(session("email")))
    cmdObj.Parameters.Append paraObj

    'Job Details
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("job_received"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("job_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2, session("warranty"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("model_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdChar,AdParamInput,5, session("warranty_code"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15, session("serial_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15, session("invoice_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("date_purchased"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("dealer"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,600, session("fault"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,600, DB_NullToEmpty(session("accessories")))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,600, DB_NullToEmpty(session("comments")))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2, session("job_status"))
    cmdObj.Parameters.Append paraObj

    'Return Details
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("date_return"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("pickup_courier"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("pickup_connote"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("date_received"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("return_courier"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("return_connote"))
    cmdObj.Parameters.Append paraObj

    'Report Details
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,18, session("labour"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,18, session("parts"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,18, session("travel_rate"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,18, session("travel_hours"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,18, session("gst"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,18, session("total"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,600, session("repair_report"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("date_completed"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("UsrUserID"))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute

    'response.Write cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
        updateCustomer = FALSE
    else
        Session("user_token") = ""
        'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
        strMessageText = "<div class=""notification_text""><img src=""images/icon_check.png""> Job record has been updated.</div>"
        updateCustomer = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function getJob
    dim strSQL
    dim rs

    call OpenDataBase()

    strSQL = "EXEC spGetJob " & request("job_id")

    set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
        session("firstname")        = Trim(rs("firstname"))
        session("lastname")         = Trim(rs("lastname"))
        session("phone")            = Trim(rs("phone"))
        session("mobile")           = Trim(rs("mobile"))
        session("address")          = Trim(rs("address"))
        session("city")             = Trim(rs("city"))
        session("state")            = Trim(rs("state"))
        session("postcode")         = Trim(rs("postcode"))
        session("email")            = Trim(rs("email"))

        session("job_received")     = Trim(rs("job_received"))
        session("job_no")           = Trim(rs("job_no"))
        session("warranty")         = Trim(rs("warranty"))
        session("model_no")         = Trim(rs("model_no"))
        session("warranty_code")    = Trim(rs("warranty_code"))
        Session("serial_no")        = Trim(rs("serial_no"))
        session("invoice_no")       = Trim(rs("invoice_no"))
        session("date_purchased")   = Trim(rs("date_purchased"))
        session("dealer")           = Trim(rs("dealer"))
        session("fault")            = Trim(rs("fault"))
        session("accessories")      = Trim(rs("accessories"))
        session("comments")         = Trim(rs("comments"))

        session("date_return")      = Trim(rs("date_return"))
        session("pickup_courier")   = Trim(rs("pickup_courier"))
        session("pickup_connote")   = Trim(rs("pickup_connote"))
        session("date_received")    = Trim(rs("date_received"))
        session("return_courier")   = Trim(rs("return_courier"))
        session("return_connote")   = Trim(rs("return_connote"))

        session("labour")           = Trim(rs("labour"))
        session("parts")            = Trim(rs("parts"))
        session("travel_rate")      = Trim(rs("travel_rate"))
        session("travel_hours")     = Trim(rs("travel_hours"))
        session("gst")              = Trim(rs("gst"))
        session("total")            = Trim(rs("total"))
        session("repair_report")    = Trim(rs("repair_report"))
        session("date_completed")   = Trim(rs("date_completed"))

        session("due_date")         = Trim(rs("due_date"))

        session("job_created_by")   = Trim(rs("job_created_by"))
        session("job_date_created") = Trim(rs("job_date_created"))
        session("job_modified_by")  = Trim(rs("job_modified_by"))
        session("job_date_modified")= Trim(rs("job_date_modified"))
        session("job_status")       = Trim(rs("job_status"))
        session("job_elapsed_days") = Trim(rs("elapsed_days"))

        session("job_dealer_code")  = Trim(rs("asc_code"))
        session("job_vendor_code")  = Trim(rs("asc_vendor"))
        
        session("asc_firstname")    = Trim(rs("asc_firstname"))
        session("asc_lastname")     = Trim(rs("asc_lastname"))
        
        if Trim(session("UsrUserID")) = Trim(session("job_created_by")) or Trim(session("usr_dealer_code")) = Trim(session("job_dealer_code")) then
            session("job_not_found") = "FALSE"
        else
            session("job_not_found") = "TRUE"
        end if
    else
        session("job_not_found") = "TRUE"
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' LIST JOB SUMMARY: home.asp
'-----------------------------------------------
function listJobSummary(strDealerCode)
    dim strSQL

    dim intTotalPoints
    intTotalPoints = 0

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic
    rs.PageSize = 100

    strSQL = "SELECT job_status, count(job_id) AS no_jobs FROM tbl_job "
    strSQL = strSQL & "	WHERE job_created_by IN (SELECT user_id FROM tbl_users WHERE dealer_code = '" & strDealerCode & "')"
    strSQL = strSQL & "		GROUP BY job_status"

    rs.Open strSQL, conn
    'response.Write strSQL

    intRecordCount = rs.recordcount

    strJobSummary = ""

    if not DB_RecSetIsEmpty(rs) Then

        For intRecord = 1 To rs.PageSize
            strJobSummary = strJobSummary & "<tr class=""innerdoc"">"
            strJobSummary = strJobSummary & "		<td align=""center"">"
            Select Case	rs("job_status")
                case 1
                    strJobSummary = strJobSummary & "<font color=""purple"">New"
                case 2
                    strJobSummary = strJobSummary & "<font color=""blue"">Open: Repair in-progress"
                case 3
                    strJobSummary = strJobSummary & "<font color=""purple"">Open: Waiting for parts"
                case 4
                    strJobSummary = strJobSummary & "<font color=""blue"">Open: Parts received"
                case 5
                    strJobSummary = strJobSummary & "<font color=""purple"">Open: Return to Yamaha for service"
                case 6
                    strJobSummary = strJobSummary & "<font color=""green"">Repair Completed"
                case 7
                    strJobSummary = strJobSummary & "<font color=""purple"">Open: Parts dispatched"
                case 8
                    strJobSummary = strJobSummary & "<font color=""purple"">Changeover"
                case 0
                    strJobSummary = strJobSummary & "<font color=""gray"">Exported"
            end select
            strJobSummary = strJobSummary & "		</font></td>"
            strJobSummary = strJobSummary & "		<td align=""center"">" & trim(rs("no_jobs")) & "</td>"
            strJobSummary = strJobSummary & "</tr>"

            rs.movenext

            If rs.EOF Then Exit For
        next
    else
        strJobSummary = "<tr><td colspan=""2"" align=""center"">No records found.</td></tr>"
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' CALCULATE KEY PERFORMANCE INDICATOR: home.asp
'-----------------------------------------------
function calculateAverageRepairTime(strDealerCode)
    dim strSQL
    dim rs

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic

    strSQL = "SELECT CAST(AVG(DATEDIFF(DAY, job_date_created, date_completed)) AS DECIMAL(10,2)) AS average_repair_time FROM tbl_job  "
    strSQL = strSQL & "	WHERE job_status = '6' AND job_created_by IN (SELECT user_id FROM tbl_users WHERE dealer_code = '" & strDealerCode & "')"

    rs.Open strSQL, conn
    'response.Write strSQL

    if not DB_RecSetIsEmpty(rs) Then
        session("user_KPI") = rs("average_repair_time")
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' CALCULATE NO OF OVERDUE JOBS: home.asp
'-----------------------------------------------
function calculateOverdueJobs(strDealerCode)
    dim strSQL
    dim rs

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic

    strSQL = "SELECT count(job_id) as total_overdue_jobs FROM tbl_job WHERE datediff(day,getdate(),due_date) < 0  "
    strSQL = strSQL & "	AND job_status <> '6' AND job_status <> '0' AND job_created_by IN (SELECT user_id FROM tbl_users WHERE dealer_code = '" & strDealerCode & "')"

    rs.Open strSQL, conn
    'response.Write strSQL

    if not DB_RecSetIsEmpty(rs) Then
        session("user_overdue_jobs") = rs("total_overdue_jobs")
    end if

    call CloseDataBase()
end function

function updateJobStatusToWaiting
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spUpdateJobStatusToWaiting"
    cmdObj.CommandType = AdCmdStoredProc

    session("job_id") = request("job_id")

    'Customer Details
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("job_id"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("UsrUserID"))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute

    'response.Write cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
        updateCustomer = FALSE
    else
        strMessageText = "<div class=""notification_text""><img src=""images/icon_check.png""> Job status has been updated to Waiting for Parts.</div>"
        updateCustomer = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    'call CloseDataBase
end function

'-----------------------------------------------
' CHECK IF THE USER SUPPLIED SERIAL NO EXISTS IN THE DATABASE
'-----------------------------------------------
function doesSerialNumberExist(strUserSerialNo)
    dim strSQL
    dim rs
    dim matchedSerialCount

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3
    rs.CursorType = 3

    strSQL =          "SELECT COUNT(*) AS matched_serial_count "
    strSQL = strSQL & "FROM dbo.serials_from_base "
    strSQL = strSQL & "WHERE serial_no = '" & strUserSerialNo & "';"

    rs.Open strSQL, conn
    'response.Write strSQL

    if not DB_RecSetIsEmpty(rs) then
        matchedSerialCount = rs("matched_serial_count")

        if matchedSerialCount > 0 then
            doesSerialNumberExist = 1
        else
            doesSerialNumberExist = 0
        end if
    else
        doesSerialNumberExist = 0
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' CHECK THE LOOKUP TABLE TO SEE IF MODEL IS FLAGGED AS A CHANGEOVER ITEM
'-----------------------------------------------
function isModelNoAChangeover(strUserModelNo)
    dim strSQL
    dim rs
    dim changover

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3
    rs.CursorType = 3

    strSQL =          "SELECT COUNT(*) AS changeover "
    strSQL = strSQL & "FROM dbo.tbl_model_changeover_lookup "
    strSQL = strSQL & "WHERE model_no = '" & strUserModelNo & "';"

    rs.Open strSQL, conn
    'response.Write strSQL

    if not DB_RecSetIsEmpty(rs) then
        changeover = rs("changeover")

        if changeover > 0 then
            isModelNoAChangeover = 1
        else
            isModelNoAChangeover = 0
        end if
    else
        isModelNoAChangeover = 0
    end if

    call CloseDataBase()
end function

%>