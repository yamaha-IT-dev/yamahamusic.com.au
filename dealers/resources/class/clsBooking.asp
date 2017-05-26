<%
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

function addConnectRequest(reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddConnectRequest"
    cmdObj.CommandType 			= AdCmdStoredProc    
	
	Set paraObj = cmdObj.CreateParameter("@reqCategory",AdInteger,AdParamInput,2,reqCategory)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@reqName",AdVarChar,AdParamInput,50,reqName)
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
	Set paraObj = cmdObj.CreateParameter("@reqOutcome",AdVarChar,AdParamInput,120,reqOutcome)
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
	'response.Write cmdObj.Execute
	
    if CheckForSQLError(conn,"Add",MessageText) = TRUE then	
		strMessageText = err.description
        addRequest = FALSE
        'strMessageText = MessageText
    else
		addRequest = TRUE
		Response.Redirect("bookings.asp")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function updateConnectRequest(reqID,reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy)
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spUpdateConnectRequest"
    cmdObj.CommandType 			= AdCmdStoredProc
	
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,reqID)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqCategory)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,reqName)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,reqType)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,DB_NullToEmpty(reqTypeOther))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,reqAudience)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,reqVenue)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,reqProduct)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,reqDate)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,reqTime)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,reqDuration)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,120,reqOutcome)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,reqStaff)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,120,reqPromote)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,8,reqAttendee)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqEntryFee)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,10,DB_NullToEmpty(reqEntryFeeCost))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqBudget)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqGiveaway)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqBrochure)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqProjector)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqScreen)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,120,reqStart)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,120,reqComments)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,reqCreatedBy)
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute

	'response.Write cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
	    updateRequest = FALSE
    else
		'Session("user_token") = ""
		strMessageText = "<div class=""alert alert-success""><img src=""images/icon_check.png""> Booking has been updated.</div>"
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
        
		updateRequest = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function getConnectBooking(intID, strCreatedBy)
    dim strSQL
    dim rs

    call OpenDataBase()

	strSQL = "EXEC spGetConnectRequest " & intID & "," & strCreatedBy

	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
		session("reqID")			= Trim(rs("reqID"))
		session("reqCategory")		= Trim(rs("reqCategory"))
		session("reqName")			= Trim(rs("reqName"))
		session("reqType")			= Trim(rs("reqType"))
		session("reqTypeOther")		= Trim(rs("reqTypeOther"))		
        session("reqAudience")		= Trim(rs("reqAudience"))        
        session("reqVenue")        	= Trim(rs("reqVenue"))
        session("reqProduct")      	= Trim(rs("reqProduct"))
        session("reqDate")      	= Trim(rs("reqDate"))
        session("reqTime")     		= Trim(rs("reqTime"))
        session("reqDuration")    	= Trim(rs("reqDuration"))
    	session("reqOutcome") 		= Trim(rs("reqOutcome"))
		session("reqStaff")			= Trim(rs("reqStaff"))
		session("reqPromote") 		= Trim(rs("reqPromote"))
		session("reqAttendee")		= Trim(rs("reqAttendee"))
		session("reqEntryFee")		= Trim(rs("reqEntryFee"))
		session("reqEntryFeeCost")	= Trim(rs("reqEntryFeeCost"))
		session("reqBudget")		= Trim(rs("reqBudget"))
		session("reqGiveaway")		= Trim(rs("reqGiveaway"))
		session("reqBrochure")		= Trim(rs("reqBrochure"))
		session("reqProjector")		= Trim(rs("reqProjector"))
		session("reqScreen")		= Trim(rs("reqScreen"))
		session("reqStart")			= Trim(rs("reqStart"))
		session("reqComments")		= Trim(rs("reqComments"))
		session("reqStatus")		= Trim(rs("reqStatus"))
		session("reqDateCreated")	= Trim(rs("reqDateCreated"))
		session("reqCreatedBy")   	= Trim(rs("reqCreatedBy"))		
		session("reqDateModified")	= Trim(rs("reqDateModified"))
		session("reqModifiedBy")   	= Trim(rs("reqModifiedBy"))			
		session("reqDateApproved")	= Trim(rs("reqDateApproved"))
		session("reqApprovedBy")   	= Trim(rs("reqApprovedBy"))
		
		if Trim(session("yma_userid")) = Trim(session("reqCreatedBy")) then
			session("request_not_found") 	= "FALSE"
		else
			session("request_not_found") 	= "TRUE"
		end if
	else
		session("request_not_found") 		= "TRUE"
    end if
	
	'on error resume next
	
	'if err <> 0 then
	'	strMessageText = err.description
	'else
	'	response.Redirect("error.asp")
	'end if

    call CloseDataBase()
end function
%>