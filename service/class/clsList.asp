<%

'-----------------------------------------------
' STATES: update_job.asp
'-----------------------------------------------
function getStateList
    dim arrStateFillText
    dim arrStateFillID
    dim intCounter

    arrStateFillText        = split(arrStateText, ",")
    arrStateFillID          = split(arrStateID, ",")

    strStateList = strStateList & "<option value=''>...</option>"

    if isarray(arrStateFillID) then
        if ubound(arrStateFillID) > 0 then
            for intCounter = 0 to ubound(arrStateFillID)

                if trim(session("new_state")) = trim(arrStateFillID(intCounter)) or trim(session("state")) = trim(arrStateFillID(intCounter)) then
                    strStateList = strStateList & "<option selected value=" & arrStateFillID(intCounter) & ">" & arrStateFillText(intCounter) & "</option>"
                else
                   	strStateList = strStateList & "<option value=" & arrStateFillID(intCounter) & ">" & arrStateFillText(intCounter) & "</option>"
                end if
            next
        end if
    end if
end function

'-----------------------------------------------
' JOB STATUS: update_job.asp
'-----------------------------------------------
function getJobStatusList
    dim arrJobStatusFillText
    dim arrJobStatusFillID
    dim intCounter

    arrJobStatusFillText    = split(arrJobStatusText, ",")
    arrJobStatusFillID      = split(arrJobStatusID, ",")

    if isarray(arrJobStatusFillID) then
        if ubound(arrJobStatusFillID) > 0 then
            for intCounter = 0 to ubound(arrJobStatusFillID)
                if trim(session("new_job_status")) = trim(arrJobStatusFillID(intCounter)) or trim(session("job_status")) = trim(arrJobStatusFillID(intCounter)) then
                    strJobStatusList = strJobStatusList & "<option selected value=" & arrJobStatusFillID(intCounter) & ">" & arrJobStatusFillText(intCounter) & "</option>"
                else
                   	strJobStatusList = strJobStatusList & "<option value=" & arrJobStatusFillID(intCounter) & ">" & arrJobStatusFillText(intCounter) & "</option>"
                end if
            next
        end if
    end if
end function

'-----------------------------------------------
' ORDER STATUS: update_job.asp
'-----------------------------------------------
function getOrderStatusList
    dim arrOrderStatusFillText
    dim arrOrderStatusFillID
    dim intCounter

    arrOrderStatusFillText  = split(arrOrderStatusText, ",")
    arrOrderStatusFillID    = split(arrOrderStatusID, ",")

    if isarray(arrOrderStatusFillID) then
        if ubound(arrOrderStatusFillID) > 0 then
            for intCounter = 0 to ubound(arrOrderStatusFillID)
                if trim(session("order_status")) = trim(arrOrderStatusFillID(intCounter)) then
                    strOrderStatusList = strOrderStatusList & "<option selected value=" & arrOrderStatusFillID(intCounter) & ">" & arrOrderStatusFillText(intCounter) & "</option>"
                else
                    strOrderStatusList = strOrderStatusList & "<option value=" & arrOrderStatusFillID(intCounter) & ">" & arrOrderStatusFillText(intCounter) & "</option>"
                end if
            next
        end if
    end if
end function

'-----------------------------------------------
' WARRANTY CODES: update_job.asp
'-----------------------------------------------
function getWarrantyCodeList
    dim arrWarrantyCodeFillText
    dim arrWarrantyCodeFillID
    dim intCounter

    arrWarrantyCodeFillText    = split(arrWarrantyCodeText, ",")
    arrWarrantyCodeFillID      = split(arrWarrantyCodeID, ",")

    strWarrantyCodeList = strWarrantyCodeList & "<option value=''>...</option>"

    if isarray(arrWarrantyCodeFillID) then
        if ubound(arrWarrantyCodeFillID) > 0 then
            for intCounter = 0 to ubound(arrWarrantyCodeFillID)
                if trim(session("new_warranty_code")) = trim(arrWarrantyCodeFillID(intCounter)) or trim(session("warranty_code")) = trim(arrWarrantyCodeFillID(intCounter)) then
                    strWarrantyCodeList = strWarrantyCodeList & "<option selected value=" & arrWarrantyCodeFillID(intCounter) & ">" & arrWarrantyCodeFillText(intCounter) & "</option>"
                else
                   	strWarrantyCodeList = strWarrantyCodeList & "<option value=" & arrWarrantyCodeFillID(intCounter) & ">" & arrWarrantyCodeFillText(intCounter) & "</option>"
                end if
            next
        end if
    end if
end function

%>