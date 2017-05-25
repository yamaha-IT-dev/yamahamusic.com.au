<%

'-----------------------------------------------
' LIST ORDERS
'-----------------------------------------------
function listOrders(intJobID)
    dim iRecordCount
    iRecordCount = 0

    dim strSQL
    dim intRecordCount

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic
    rs.PageSize = 200

    strSQL = "SELECT * FROM tbl_order "
    strSQL = strSQL & "	WHERE order_job_id = '" & intJobID & "' "
    strSQL = strSQL & "	ORDER BY order_id"

    'response.Write strSQL 

    rs.Open strSQL, conn

    intRecordCount = rs.recordcount	

    strOrderList = ""

    if not DB_RecSetIsEmpty(rs) Then

        For intRecord = 1 To rs.PageSize

            'strOrderList = strOrderList & "<tr>"
            if iRecordCount Mod 2 = 0 then
                strOrderList = strOrderList & "<tr class=""innerdoc"">"
            else
                strOrderList = strOrderList & "<tr class=""innerdoc_2"">"
            end if
            strOrderList = strOrderList & "<td>" & FormatDateTime(rs("order_date_created"),1) & "</td>"

            strOrderList = strOrderList & "<td>" & trim(rs("order_part_no")) & "</td>"
            strOrderList = strOrderList & "<td>" & trim(rs("order_description")) & "</td>"
            strOrderList = strOrderList & "<td>" & trim(rs("order_qty")) & "</td>"
            strOrderList = strOrderList & "<td>" & trim(rs("order_notes")) & "</td>"
            strOrderList = strOrderList & "<td>"
            select case trim(rs("order_status"))
                case 1
                    strOrderList = strOrderList & "<font color=""blue"">TBA"
                case 2
                    strOrderList = strOrderList & "<font color=""red"">Backorder"
                case 3
                    strOrderList = strOrderList & "<font color=""purple"">Changeover"
                case 0
                    strOrderList = strOrderList & "<font color=""green"">Completed"
            end select
            strOrderList = strOrderList & "</font></td>"

            if rs("order_eta") = "01/01/1900" or rs("order_eta") = "1/1/1900" or IsNull(rs("order_eta")) then
                strOrderList = strOrderList & "<td class=""orange_text"">NA</td>"
            else
                strOrderList = strOrderList & "<td align=""center"">" & FormatDateTime(rs("order_eta"),1) & "</td>"
            end if
            strOrderList = strOrderList & "<td align=""center"">" & trim(rs("order_comments")) & "</td>"
            strOrderList = strOrderList & "<td align=""center"">" & rs("order_ref_no") & ""
            strOrderList = strOrderList & "<a onclick=""return confirm('Are you sure you want to delete " & rs("order_part_no") & " ?');"" href='delete_order.asp?id=" & rs("order_id") & "'><img src=""images/btn_delete.gif"" border=""0""></a></td>"
            strOrderList = strOrderList & "</tr>"

            rs.movenext
            iRecordCount = iRecordCount + 1
            If rs.EOF Then Exit For
        next
    else
        strOrderList = "<tr><td colspan=""9"" align=""center"">No spare-parts orders yet.</td></tr>"
    end if

    call CloseDataBase()
end function

function addOrder
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddOrder"
    cmdObj.CommandType = AdCmdStoredProc

    session("new_job_id")               = Trim(request("job_id"))
    session("new_order_part_no")        = Ucase(Trim(request("txtPartNo")))
    session("new_order_description")    = Trim(request("txtDescription"))
    session("new_order_qty")            = Trim(request("cboQty"))
    session("new_order_notes")          = Trim(request("txtNotes"))

    Set paraObj = cmdObj.CreateParameter("@job_id",AdInteger,AdParamInput,4, session("new_job_id"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@order_part_no",AdVarChar,AdParamInput,30, session("new_order_part_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@order_description",AdVarChar,AdParamInput,30, session("new_order_description"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@order_qty",AdInteger,AdParamInput,4, session("new_order_qty"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@order_notes",AdVarChar,AdParamInput,80, session("new_order_notes"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@order_created_by",AdInteger,AdParamInput,4, session("UsrUserID"))
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
        Session("user_token") = ""
        addCustomer = TRUE

        call updateJobStatusToWaiting

        Set JMail=CreateObject("JMail.SMTPMail")

        JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Subject       = "New Spare Parts Order (Repair ID = " & Session("new_job_id") & ")"
        JMail.Sender        = "noreply@yamaha.com"
        JMail.SenderName    = "Yamaha Music Australia"

        JMail.AddRecipient ("brian.parker@music.yamaha.com")
        JMail.AddRecipient ("matthew.madden@music.yamaha.com")		

        JMail.Body  = "G'day," & vbCrLf _
                    & "" & vbCrLf _
                    & "There is a new Spare Part Order:" & vbCrLf _
                    & "" & vbCrLf _
                    & "Repair ID:   " & Session("new_job_id") & vbCrLf _
                    & "Ordered by:  " & Session("UsrUsername") & vbCrLf _
                    & "----------------------------------------------------------------------------" & vbCrLf _
                    & "Part no:     " & Session("new_order_part_no") & vbCrLf _
                    & "Description: " & Session("new_order_description") & vbCrLf _
                    & "Qty:         " & Session("new_order_qty") & vbCrLf _
                    & "Notes:       " & Session("new_order_notes") & vbCrLf _
                    & " " & vbCrLf _
                    & "For more info: http://intranet:78/view_job.asp?job_id=" & Session("new_job_id") & vbCrLf _
                    & " " & vbCrLf _
                    & "This is an automated email. Please do not reply to this email."

        JMail.Execute
        set JMail = nothing

        Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    'call CloseDataBase
end function

function updateOrder
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spUpdateOrder"
    cmdObj.CommandType = AdCmdStoredProc

    session("job_id")       = request("job_id")
    session("order_id")     = request("order_id")

    session("order_part_no")        = request("txtPartNo")
    session("order_description")    = request("txtDescription")
    session("qty")                  = request("cboQty")

    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("order_id"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("order_id"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("order_part_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15, session("order_description"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("order_qty"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("address"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("city"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdChar,AdParamInput,5, session("state"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("postcode"))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
        updateCustomer = FALSE
    else
        strMessageText = "<div class=""notification_text""><img src=""images/icon_check.png""> Order (" & session("part_no") & ")has been successfully updated.</div>"
        'strMessageText = session("part_no") & " order has been updated"
        updateCustomer = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    'call CloseDataBase
end function

function getOrder
    dim strSQL
    dim rs

    call OpenDataBase()

    strSQL = "EXEC spGetOrder " & request("order_id")

    set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
        session("order_part_no")        = rs("order_part_no")
        session("order_description")    = rs("order_description")
        session("order_qty")            = rs("order_qty")
        session("order_date_created")   = rs("order_date_created")
        session("order_created_by")     = rs("order_created_by")
        session("order_date_modified")  = rs("order_date_modified")
        session("order_modified_by")    = rs("order_modified_by")
        session("order_status")         = rs("order_status")
    end if

    call CloseDataBase()
end function

%>