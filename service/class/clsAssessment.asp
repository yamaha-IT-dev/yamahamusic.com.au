<%

function addAssessment
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddAssessment"
    cmdObj.CommandType = AdCmdStoredProc

    session("q1")           = Trim(request("rad1"))
    session("q2")           = Trim(request("rad2"))
    session("q3")           = Trim(request("rad3"))
    session("q4")           = Trim(request("rad4"))
    session("q5")           = Trim(request("rad5"))
    session("q6")           = Trim(request("rad6"))
    session("q7")           = Trim(request("rad7"))
    session("q8")           = Trim(request("rad8"))
    session("q9")           = Trim(request("rad9"))
    session("q10")          = Trim(request("rad10"))
    session("q11")          = Trim(request("rad11"))
    session("q12")          = Trim(request("rad12"))
    session("q13")          = Trim(request("rad13"))
    session("q14")          = Trim(request("rad14"))
    session("q15")          = Trim(request("rad15"))
    session("q16")          = Trim(request("rad16"))
    session("q17")          = Trim(request("rad17"))
    session("q18")          = Trim(request("rad18"))
    session("q19")          = Trim(request("rad19"))
    session("q20")          = Trim(request("rad20"))
    session("q21")          = Trim(request("rad21"))
    session("q22")          = Trim(request("rad22"))
    session("q23")          = Trim(request("rad23"))
    session("q24")          = Trim(request("rad24"))
    session("q25")          = Trim(request("rad25"))

    Set paraObj = cmdObj.CreateParameter("@q1",AdInteger,AdParamInput,2, session("q1"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q2",AdInteger,AdParamInput,2, session("q2"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q3",AdInteger,AdParamInput,2, session("q3"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q4",AdInteger,AdParamInput,2, session("q4"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q5",AdInteger,AdParamInput,2, session("q5"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q6",AdInteger,AdParamInput,2, session("q6"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q7",AdInteger,AdParamInput,2, session("q7"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q8",AdInteger,AdParamInput,2, session("q8"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q9",AdInteger,AdParamInput,2, session("q9"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q10",AdInteger,AdParamInput,2, session("q10"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q11",AdInteger,AdParamInput,2, session("q11"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q12",AdInteger,AdParamInput,2, session("q12"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q13",AdInteger,AdParamInput,2, session("q13"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q14",AdInteger,AdParamInput,2, session("q14"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q15",AdInteger,AdParamInput,2, session("q15"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q16",AdInteger,AdParamInput,2, session("q16"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q17",AdInteger,AdParamInput,2, session("q17"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q18",AdInteger,AdParamInput,2, session("q18"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q19",AdInteger,AdParamInput,2, session("q19"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q20",AdInteger,AdParamInput,2, session("q20"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q21",AdInteger,AdParamInput,2, session("q21"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q22",AdInteger,AdParamInput,2, session("q22"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q23",AdInteger,AdParamInput,2, session("q23"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q24",AdInteger,AdParamInput,2, session("q24"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@q25",AdInteger,AdParamInput,2, session("q25"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@created_by",AdInteger,AdParamInput,2, session("yssID"))
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

        Set JMail=CreateObject("JMail.SMTPMail")
        JMail.ServerAddress = "smtp.bne.server-mail.com"
        JMail.Subject       = "New Self-Assessment Submission"
        JMail.Sender        = "noreply@yamaha.com"
        JMail.SenderName    = "Yamaha Music Australia"
        JMail.AddRecipient ("drew.morrow@music.yamaha.com")
        JMail.Body  = "G'day!" & vbCrLf _
                    & "" & vbCrLf _
                    & "There is a new self-assessment submission." & vbCrLf _
                    & " " & vbCrLf _
                    & "http://intranet:78/list_assessment.asp" & vbCrLf _
                    & " " & vbCrLf _
                    & "This is an automated email. Please do not reply to this email."

        JMail.Execute
        set JMail = nothing

        Response.Redirect("thank-you.asp")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

'-----------------------------------------------
' GET ASSESSMENT
'-----------------------------------------------
function getSkillAssessment(intID)
    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic

    strSQL = "SELECT * FROM tbl_assessment WHERE id = " & intID

    rs.Open strSQL, conn

    'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
        session("q1")   = Trim(rs("q1"))
        session("q2")   = Trim(rs("q2"))
        session("q3")   = Trim(rs("q3"))
        session("q4")   = Trim(rs("q4"))
        session("q5")   = Trim(rs("q5"))
        session("q6")   = Trim(rs("q6"))
        session("q7")   = Trim(rs("q7"))
        session("q8")   = Trim(rs("q8"))
        session("q9")   = Trim(rs("q9"))
        session("q10")  = Trim(rs("q10"))
        session("q11")  = Trim(rs("q11"))
        session("q12")  = Trim(rs("q12"))
        session("q13")  = Trim(rs("q13"))
        session("q14")  = Trim(rs("q14"))
        session("q15")  = Trim(rs("q15"))
        session("q16")  = Trim(rs("q16"))
        session("q17")  = Trim(rs("q17"))
        session("q18")  = Trim(rs("q18"))
        session("q19")  = Trim(rs("q19"))
        session("q20")  = Trim(rs("q20"))
        session("q21")  = Trim(rs("q21"))
        session("q22")  = Trim(rs("q22"))
        session("q23")  = Trim(rs("q23"))
        session("q24")  = Trim(rs("q24"))
        session("q25")  = Trim(rs("q25"))

        session("assessment_date_created")  = Trim(rs("date_created"))
        session("assessment_created_by")    = Trim(rs("created_by"))

        session("total_score")  = Trim(rs("total_score"))
        session("total_high")   = Trim(rs("total_high"))
        session("total_mid")    = Trim(rs("total_mid"))
        session("total_basic")  = Trim(rs("total_score"))

        if Trim(session("UsrUserID")) = Trim(session("assessment_created_by")) then
            session("assessment_not_found") = "FALSE"
        else
            session("assessment_not_found") = "TRUE"
        end if
    else
        session("assessment_not_found") = "TRUE"
    end if

    call CloseDataBase()
end function

function Max3(int1, int2, int3)
    if (int1 > int2) then
        if (int1 > int3) then
            Max3 = int1
        else
            Max3 = int3
        end if
    elseif (int2 > int3) then
        Max3 = int2
    else
        Max3 = int3
    end if
end function

function checkHighQuestions(q1,q2,q3,q4,q5,q6,q7,intTotalHigh)
    if (q1 >= 3 and q2 >= 3 and q3 >= 3 and q4 >= 3 and q5 >= 3 and q6 >= 3 and q7 >= 3) or intTotalHigh >= 28 then
        checkHighQuestions = 1 '"A"
    else
        if (q1 >= 2 and q2 >= 2 and q3 >= 2 and q4 >= 2 and q5 >= 2 and q6 >= 2 and q7 >= 2) or intTotalHigh >= 14 then
            checkHighQuestions = 2 '"B"
        else
            checkHighQuestions = 3 '"C"
        end if
    end if
end function

function checkHigh(intTotalHigh)
    select case intTotalHigh
        case 28,29,30,31,32,33,34,35
            checkHigh = "A"
        case 14,15,16,17,18,19,20,21,22,23,24,25,26,27
            checkHigh = "B"
        case 7,8,9,10,11,12,13
            checkHigh = "C"
    end select
end function

'----------------------------------------------------------------------

function checkMidQuestions(q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,intTotalHigh)
    if (q1 >= 3 and q2 >= 3 and q3 >= 3 and q4 >= 3 and q5 >= 3 and q6 >= 3 and q7 >= 3 and q8 >= 3 and q9 >= 3 and q10 >= 3 and q11 >= 3) or intTotalHigh >= 30 then
        checkMidQuestions = 1 '"A"
    else
        if (q1 >= 2 and q2 >= 2 and q3 >= 2 and q4 >= 2 and q5 >= 2 and q6 >= 2 and q7 >= 2 and q8 >= 2 and q9 >= 2 and q10 >= 2 and q11 >= 2) or intTotalHigh >= 20 then
            checkMidQuestions = 3 '"C"
        else
            checkMidQuestions = 4 '"D"
        end if
    end if
end function

function checkMid(intTotalMid)
    select case intTotalMid
        case 30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55
            checkMid = "A"
        case 20,21,22,23,24,25,26,27,28,29
            checkMid = "C"
        case 11,12,13,14,15,16,17,18,19
            checkMid = "D"
        case 7,8,9,10
            checkMid = "E"
    end select
end function

'----------------------------------------------------------------------

function checkBasicQuestions(q1,q2,q3,q4,q5,q6,q7,intTotalHigh)
    if (q1 >= 4 and q2 >= 4 and q3 >= 4 and q4 >= 4 and q5 >= 4 and q6 >= 4 and q7 >= 4) or intTotalHigh >= 32 then
        checkBasicQuestions = 1 '"A"
    else
        if (q1 >= 3 and q2 >= 3 and q3 >= 3 and q4 >= 3 and q5 >= 3 and q6 >= 3 and q7 >= 3) or intTotalHigh >= 24 then
            checkBasicQuestions = 2 '"B"
        else
            if (q1 >= 2 and q2 >= 2 and q3 >= 2 and q4 >= 2 and q5 >= 2 and q6 >= 2 and q7 >= 2) or intTotalHigh >= 16 then
                checkBasicQuestions = 3 '"C"
            else
                if (q1 >= 1 and q2 >= 1 and q3 >= 1 and q4 >= 1 and q5 >= 1 and q6 >= 1 and q7 >= 1) or intTotalHigh >= 8 then
                    checkBasicQuestions = 4 '"D"
                else
                    checkBasicQuestions = 5
                end if
            end if
        end if
    end if
end function

function checkBasic(intTotalBasic)
    select case intTotalBasic
        case 32,33,34,35
            checkBasic = "A"
        case 24,25,26,27,28,29,30,31
            checkBasic = "B"
        case 16,17,18,19,20,21,22,23
            checkBasic = "C"
        case 8,9,10,11,12,13,14,15
            checkBasic = "D"
        case 7
            checkBasic = "E"
    end select
end function

function getAssessment
    dim strSQL
    dim rs

    call OpenDataBase()

    strSQL = "EXEC spGetAssessment " & request("id")

    set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
        session("q1")   = Trim(rs("q1"))
        session("q2")   = Trim(rs("q2"))
        session("q3")   = Trim(rs("q3"))
        session("q4")   = Trim(rs("q4"))
        session("q5")   = Trim(rs("q5"))
        session("q6")   = Trim(rs("q6"))
        session("q7")   = Trim(rs("q7"))
        session("q8")   = Trim(rs("q8"))
        session("q9")   = Trim(rs("q9"))
        session("q10")  = Trim(rs("q10"))
        session("q11")  = Trim(rs("q11"))
        session("q12")  = Trim(rs("q12"))
        session("q13")  = Trim(rs("q13"))
        session("q14")  = Trim(rs("q14"))
        session("q15")  = Trim(rs("q15"))
        session("q16")  = Trim(rs("q16"))
        session("q17")  = Trim(rs("q17"))
        session("q18")  = Trim(rs("q18"))
        session("q19")  = Trim(rs("q19"))
        session("q20")  = Trim(rs("q20"))
        session("q21")  = Trim(rs("q21"))
        session("q22")  = Trim(rs("q22"))
        session("q23")  = Trim(rs("q23"))
        session("q24")  = Trim(rs("q24"))
        session("q25")  = Trim(rs("q25"))

        session("created_by") = Trim(rs("created_by"))

        if Trim(session("UsrUserID")) = Trim(session("job_created_by")) or Trim(session("usr_dealer_code")) = Trim(session("job_dealer_code")) then
            session("job_not_found")    = "FALSE"
        else
            session("job_not_found")    = "TRUE"
        end if
    else
        session("job_not_found")    = "TRUE"
    end if

    call CloseDataBase()
end function

%>