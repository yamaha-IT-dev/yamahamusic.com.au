<%
'-----------------------------------------------
' ADD BOOKING
'-----------------------------------------------
function addBooking(reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy)
    dim strSQL

    call OpenDataBase()

    strSQL = "INSERT INTO tbl_connect_request (reqCategory, reqName, reqType, reqTypeOther, reqAudience, reqVenue, reqProduct, reqDate, reqTime, reqDuration,reqOutcome,reqStaff,reqPromote, reqAttendee, reqEntryFee, reqEntryFeeCost, reqBudget, reqGiveaway, reqBrochure, reqProjector, reqScreen, reqStart, reqComments, reqCreatedBy) VALUES ("

    strSQL = strSQL & "'" & reqCategory & "',"
    strSQL = strSQL & "'" & reqName & "',"
    strSQL = strSQL & "'" & reqType & "',"
    strSQL = strSQL & "'" & reqTypeOther & "',"
    strSQL = strSQL & "'" & reqAudience & "',"
    strSQL = strSQL & "'" & reqVenue & "',"
    strSQL = strSQL & "'" & reqProduct & "',"
    strSQL = strSQL & "CONVERT(datetime,'" & Trim(reqDate) & "',103),"
    strSQL = strSQL & "'" & reqTime & "',"
    strSQL = strSQL & "'" & reqDuration & "',"
    strSQL = strSQL & "'" & reqOutcome & "',"
    strSQL = strSQL & "'" & reqStaff & "',"
    strSQL = strSQL & "'" & reqPromote & "',"
    strSQL = strSQL & "'" & reqAttendee & "',"
    strSQL = strSQL & "'" & reqEntryFee & "',"
    strSQL = strSQL & "'" & reqEntryFeeCost & "',"
    strSQL = strSQL & "'" & reqBudget & "',"
    strSQL = strSQL & "'" & reqGiveaway & "',"
    strSQL = strSQL & "'" & reqBrochure & "',"
    strSQL = strSQL & "'" & reqProjector & "',"
    strSQL = strSQL & "'" & reqScreen & "',"
    strSQL = strSQL & "'" & reqStart & "',"
    strSQL = strSQL & "'" & reqComments & "',"
    strSQL = strSQL & "'" & reqCreatedBy & "')"

    response.Write strSQL

    'on error resume next
    conn.Execute strSQL

    if err <> 0 then
        strMessageText = err.description
    else
        response.Redirect("bookings.asp")
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' ADD CONNECT REQUEST
'-----------------------------------------------
function addConnectRequest(reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy)
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj                  = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection     = conn
    cmdObj.CommandText          = "spAddConnectRequest"
    cmdObj.CommandType          = AdCmdStoredProc

    Set paraObj = cmdObj.CreateParameter("@reqCategory",AdInteger,AdParamInput,2,reqCategory)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqName",AdVarChar,AdParamInput,90,reqName)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqType",AdVarChar,AdParamInput,50,reqType)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqTypeOther",AdVarChar,AdParamInput,50,DB_NullToEmpty(reqTypeOther))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqAudience",AdVarChar,AdParamInput,50,reqAudience)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqVenue",AdVarChar,AdParamInput,50,reqVenue)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqProduct",AdVarChar,AdParamInput,50,reqProduct)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqDate",AdVarChar,AdParamInput,20,reqDate)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqTime",AdVarChar,AdParamInput,20,reqTime)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqDuration",AdVarChar,AdParamInput,20,reqDuration)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqOutcome",AdVarChar,AdParamInput,500,reqOutcome)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqStaff",AdVarChar,AdParamInput,50,reqStaff)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqPromote",AdVarChar,AdParamInput,120,reqPromote)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqAttendee",AdVarChar,AdParamInput,8,reqAttendee)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqEntryFee",AdInteger,AdParamInput,2,reqEntryFee)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqEntryFeeCost",AdVarChar,AdParamInput,10,DB_NullToEmpty(reqEntryFeeCost))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqBudget",AdInteger,AdParamInput,2,reqBudget)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqGiveaway",AdInteger,AdParamInput,2,reqGiveaway)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqBrochure",AdInteger,AdParamInput,2,reqBrochure)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqProjector",AdInteger,AdParamInput,2,reqProjector)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqScreen",AdInteger,AdParamInput,2,reqScreen)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqStart",AdVarChar,AdParamInput,120,reqStart)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqComments",AdVarChar,AdParamInput,120,reqComments)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqCreatedBy",AdInteger,AdParamInput,2,reqCreatedBy)
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
    else
        addRequest = TRUE

        Dim JMail
        Set JMail = CreateObject("JMail.Message")

        JMail.MailServerUserName = "yamahamusicau"
        JMail.MailServerPassWord = "str0ppy@16"
        JMail.From               = "noreply@music.yamaha.com"

        select case reqCategory
            case 1
                JMail.Subject = "[Yamaha Connect] New Demonstrator Booking"
                JMail.AddRecipient ("leon.blaher@music.yamaha.com")
            case 2
                JMail.Subject = "[Yamaha Connect] New Event Booking"
            case 3
                JMail.Subject = "[Yamaha Connect] New Training Booking"
            case 4
                JMail.Subject = "[Yamaha Connect] New Product Training Booking"
                JMail.AddRecipient ("leon.blaher@music.yamaha.com")
            case else
                JMail.Subject = "[Yamaha Connect] New Booking"
        end select
        JMail.AddRecipient ("alexander.yabsley@music.yamaha.com")
        'JMail.AddRecipient ("victor.samson@music.yamaha.com")

        If reqCategory <> 4 Then
            'Booking Category 1, 2 or 3
            JMail.Body  = "G'day!" & vbCrLf _
                        & "" & vbCrLf _
                        & "A new booking has been submitted via Yamaha Connect by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
                        & "" & vbCrLf _
                        & "Name: " & reqName & vbCrLf _
                        & "Type: " & reqType & vbCrLf _
                        & "Audience: " & reqAudience & vbCrLf _
                        & "Venue: " & reqVenue & vbCrLf _
                        & "Date: " & reqDate & vbCrLf _
                        & "" & vbCrLf _
                        & "For more details: http://intranet:78/list_booking.asp" & vbCrLf _
                        & "" & vbCrLf _
                        & "This is an automated email. Please do not reply to this address."
        Else
            'Create a human readable list of modules for the email
            Dim moduleArray
            Dim strModules
            strModules = ""
            moduleArray = Split(reqName, ",")
            For i = 0 to UBound(moduleArray)
                strModules = strModules & "- " & getProductTrainingName(moduleArray(i)) & vbCrLf
            Next

            'Booking Category 4
            Jmail.Body = "G'day!" & vbCrLf _
                       & "" & vbCrLf _
                       & "A new booking has been submitted via Yamaha Connect by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
                       & "" & vbCrLf _
                       & "Modules: " & vbCrLf _
                       & strModules & vbCrLf _
                       & "" & vbCrLf _
                       & "Date: " & reqDate & vbCrLf _
                       & "Time: " & reqTime & vbCrLf _
                       & "Participants: " & reqOutcome &  vbCrLf _
                       & "" & vbCrLf _
                       & "For more details: http://intranet:78/list_booking.asp" & vbCrLf _
                       & "" & vbCrLf _
                       & "This is an automated email. Please do not reply to this address."
        End If

        JMail.Send("smtp.sendgrid.net:25")

        set JMail = nothing

        Response.Redirect("./")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

'-----------------------------------------------
' UPDATE CONNECT REQUEST
'-----------------------------------------------
function updateConnectRequest(reqID,reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy)
    Dim cmdObj, paraObj
'
    call OpenDataBase

    Set cmdObj                  = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection     = conn
    cmdObj.CommandText          = "spUpdateConnectRequest"
    cmdObj.CommandType          = AdCmdStoredProc

    Set paraObj = cmdObj.CreateParameter("@reqID",AdInteger,AdParamInput,4,reqID)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqCategory",AdInteger,AdParamInput,2,reqCategory)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqName",AdVarChar,AdParamInput,90,reqName)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqType",AdVarChar,AdParamInput,50,reqType)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqTypeOther",AdVarChar,AdParamInput,50,DB_NullToEmpty(reqTypeOther))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqAudience",AdVarChar,AdParamInput,50,reqAudience)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqVenue",AdVarChar,AdParamInput,50,reqVenue)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqProduct",AdVarChar,AdParamInput,50,reqProduct)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqDate",AdVarChar,AdParamInput,20,reqDate)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqTime",AdVarChar,AdParamInput,20,reqTime)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqDuration",AdVarChar,AdParamInput,20,reqDuration)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqOutcome",AdVarChar,AdParamInput,500,reqOutcome)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqStaff",AdVarChar,AdParamInput,50,reqStaff)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqPromote",AdVarChar,AdParamInput,120,reqPromote)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqAttendee",AdVarChar,AdParamInput,8,reqAttendee)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqEntryFee",AdInteger,AdParamInput,2,reqEntryFee)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqEntryFeeCost",AdVarChar,AdParamInput,10,DB_NullToEmpty(reqEntryFeeCost))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqBudget",AdInteger,AdParamInput,2,reqBudget)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqGiveaway",AdInteger,AdParamInput,2,reqGiveaway)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqBrochure",AdInteger,AdParamInput,2,reqBrochure)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqProjector",AdInteger,AdParamInput,2,reqProjector)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqScreen",AdInteger,AdParamInput,2,reqScreen)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqStart",AdVarChar,AdParamInput,120,reqStart)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqComments",AdVarChar,AdParamInput,120,reqComments)
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@reqCreatedBy",AdInteger,AdParamInput,2,reqCreatedBy)
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute

    response.Write cmdObj.Execute
    On error Goto 0

    If CheckForSQLError(conn,"Update",strMessageText) = TRUE Then
        updateRequest = FALSE
    Else
        strMessageText = "<div class=""alert alert-success""><img src=""../images/icon_check.png""> Booking has been updated.</div>"

        updateRequest = TRUE
    End If

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase

    'Email appropriate Yamaha people that the booking has been updated
    Dim JMail
    Set JMail = CreateObject("JMail.Message")

    JMail.MailServerUserName = "yamahamusicau"
    JMail.MailServerPassWord = "str0ppy@16"
    JMail.From               = "noreply@music.yamaha.com"

    Select Case reqCategory
        Case 1
            JMail.Subject = "[Yamaha Connect] Updated Demonstrator Booking"
            JMail.AddRecipient ("leon.blaher@music.yamaha.com")
        Case 2
            JMail.Subject = "[Yamaha Connect] Updated Event Booking"
        Case 3
            JMail.Subject = "[Yamaha Connect] Updated Training Booking"
        Case 4
            JMail.Subject = "[Yamaha Connect] Updated Product Training Booking"
            JMail.AddRecipient ("leon.blaher@music.yamaha.com")
        Case Else
            JMail.Subject = "[Yamaha Connect] Updated Booking"
    End Select
    JMail.AddRecipient ("alexander.yabsley@music.yamaha.com")
    'JMail.AddRecipient ("victor.samson@music.yamaha.com")

    If reqCategory <> 4 Then
        'Booking Category 1, 2 or 3
        JMail.Body = "G'day!" & vbCrLf _
                   & "" & vbCrLf _
                   & "A booking has been updated via Yamaha Connect by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
                   & "" & vbCrLf _
                   & "Name: " & reqName & vbCrLf _
                   & "Type: " & reqType & vbCrLf _
                   & "Audience: " & reqAudience & vbCrLf _
                   & "Venue: " & reqVenue & vbCrLf _
                   & "Date: " & reqDate & vbCrLf _
                   & "" & vbCrLf _
                   & "For more details: http://intranet:78/list_booking.asp" & vbCrLf _
                   & "" & vbCrLf _
                   & "This is an automated email. Please do not reply to this address."
    Else
        'Create a human readable list of modules for the email
        Dim moduleArray
        Dim strModules
        strModules = ""
        moduleArray = Split(reqName, ",")
        For i = 0 to UBound(moduleArray)
            strModules = strModules & "- " & getProductTrainingName(moduleArray(i)) & vbCrLf
        Next

        Jmail.Body = "G'day!" & vbCrLf _
                   & "" & vbCrLf _
                   & "A booking has been updated via Yamaha Connect by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
                   & "" & vbCrLf _
                   & "Modules: " & vbCrLf _
                   & strModules & vbCrLf _
                   & "" & vbCrLf _
                   & "Date: " & reqDate & vbCrLf _
                   & "Time: " & reqTime & vbCrLf _
                   & "Participants: " & reqOutcome &  vbCrLf _
                   & "" & vbCrLf _
                   & "For more details: http://intranet:78/list_booking.asp" & vbCrLf _
                   & "" & vbCrLf _
                   & "This is an automated email. Please do not reply to this address."
    End If

    JMail.Send("smtp.sendgrid.net:25")

    Set JMail = Nothing

    'Redirect the user back to the Booking page
    Response.Redirect("./")
end function

'-----------------------------------------------
' GET CONNECT BOOKING
'-----------------------------------------------
function getConnectBooking(intID, strCreatedBy)
    dim strSQL
    dim rs

    call OpenDataBase()

    strSQL = "EXEC spGetConnectRequest " & intID & "," & strCreatedBy

    set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
        session("reqID")            = Trim(rs("reqID"))
        session("reqCategory")      = Trim(rs("reqCategory"))
        session("reqName")          = Trim(rs("reqName"))
        session("reqType")          = Trim(rs("reqType"))
        session("reqTypeOther")     = Trim(rs("reqTypeOther"))
        session("reqAudience")      = Trim(rs("reqAudience"))
        session("reqVenue")         = Trim(rs("reqVenue"))
        session("reqProduct")       = Trim(rs("reqProduct"))
        session("reqDate")          = Trim(rs("reqDate"))
        session("reqTime")          = Trim(rs("reqTime"))
        session("reqDuration")      = Trim(rs("reqDuration"))
        session("reqOutcome")       = Trim(rs("reqOutcome"))
        session("reqStaff")         = Trim(rs("reqStaff"))
        session("reqPromote")       = Trim(rs("reqPromote"))
        session("reqAttendee")      = Trim(rs("reqAttendee"))
        session("reqEntryFee")      = Trim(rs("reqEntryFee"))
        session("reqEntryFeeCost")  = Trim(rs("reqEntryFeeCost"))
        session("reqBudget")        = Trim(rs("reqBudget"))
        session("reqGiveaway")      = Trim(rs("reqGiveaway"))
        session("reqBrochure")      = Trim(rs("reqBrochure"))
        session("reqProjector")     = Trim(rs("reqProjector"))
        session("reqScreen")        = Trim(rs("reqScreen"))
        session("reqStart")         = Trim(rs("reqStart"))
        session("reqComments")      = Trim(rs("reqComments"))
        session("reqStatus")        = Trim(rs("reqStatus"))
        session("reqDateCreated")   = Trim(rs("reqDateCreated"))
        session("reqCreatedBy")     = Trim(rs("reqCreatedBy"))
        session("reqDateModified")  = Trim(rs("reqDateModified"))
        session("reqModifiedBy")    = Trim(rs("reqModifiedBy"))
        session("reqDateApproved")  = Trim(rs("reqDateApproved"))
        session("reqApprovedBy")    = Trim(rs("reqApprovedBy"))

        if Trim(session("yma_userid")) = Trim(session("reqCreatedBy")) then
            session("request_not_found")   = "FALSE"
        else
            session("request_not_found")   = "TRUE"
        end if
    else
        session("request_not_found")        = "TRUE"
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' GET A HUMAN READABLE PRODUCT TRAINING NAME
' CREATED: Victor Samson (2016-06-30)
'-----------------------------------------------
Function getProductTrainingName(moduleNumber)
    Select Case moduleNumber
        Case "11"   getProductTrainingName = "Keyboard - PSR-E / PSR-I / NP - Module 1"
        Case "12"   getProductTrainingName = "Keyboard - PSR-E / PSR-I / NP - Module 2"
        Case "13"   getProductTrainingName = "Keyboard - PSR-E / PSR-I / NP - Module 3"
        Case "21"   getProductTrainingName = "Keyboard - PSR-S / PSR-A - Module 1"
        Case "22"   getProductTrainingName = "Keyboard - PSR-S / PSR-A - Module 2"
        Case "23"   getProductTrainingName = "Keyboard - PSR-S / PSR-A - Module 3"
        Case "31"   getProductTrainingName = "Keyboard - Tyros - Module 1"
        Case "32"   getProductTrainingName = "Keyboard - Tyros - Module 2"
        Case "33"   getProductTrainingName = "Keyboard - Tyros - Module 3"
        Case "41"   getProductTrainingName = "Digital Piano - P-SERIES / YDP ARIUS - Module 1"
        Case "42"   getProductTrainingName = "Digital Piano - P-SERIES / YDP ARIUS - Module 2"
        Case "43"   getProductTrainingName = "Digital Piano - P-SERIES / YDP ARIUS - Module 3"
        Case "51"   getProductTrainingName = "Digital Piano - CLP CLAVINOVA - Module 1"
        Case "52"   getProductTrainingName = "Digital Piano - CLP CLAVINOVA - Module 2"
        Case "53"   getProductTrainingName = "Digital Piano - CLP CLAVINOVA - Module 3"
        Case "61"   getProductTrainingName = "Digital Piano - AVANTGRAND - Module 1"
        Case "62"   getProductTrainingName = "Digital Piano - AVANTGRAND - Module 2"
        Case "71"   getProductTrainingName = "Digital Piano Arranger - DGX / YDP-V240 - Module 1"
        Case "72"   getProductTrainingName = "Digital Piano Arranger - DGX / YDP-V240 - Module 2"
        Case "73"   getProductTrainingName = "Digital Piano Arranger - DGX / YDP-V240 - Module 3"
        Case "81"   getProductTrainingName = "Digital Piano Arranger - CVP CLAVINOVA - Module 1"
        Case "82"   getProductTrainingName = "Digital Piano Arranger - CVP CLAVINOVA - Module 2"
        Case "83"   getProductTrainingName = "Digital Piano Arranger - CVP CLAVINOVA - Module 3"
        Case "91"   getProductTrainingName = "Pianos & Hybrids - PIANO - Module 1"
        Case "92"   getProductTrainingName = "Pianos & Hybrids - PIANO - Module 2"
        Case "101"  getProductTrainingName = "Pianos & Hybrids - DISKLAVIER - Module 1"
        Case "102"  getProductTrainingName = "Pianos & Hybrids - DISKLAVIER - Module 2"
        Case "103"  getProductTrainingName = "Pianos & Hybrids - DISKLAVIER - Module 3"
        Case Else   getProductTrainingName = ""
    End Select
End Function
%>