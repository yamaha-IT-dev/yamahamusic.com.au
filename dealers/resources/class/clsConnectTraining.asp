<%
function addConnectTraining
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddConnectTraining"
    cmdObj.CommandType 			= AdCmdStoredProc

    session("newAudience")   	= Server.HTMLEncode(Trim(Request("cboAudience")))
	session("newAudienceOther") = Server.HTMLEncode(Trim(Request("txtAudienceOther")))
    session("newVenue")     	= Server.HTMLEncode(Trim(Request("txtVenue")))
	session("newProduct")    	= Server.HTMLEncode(Trim(Request("txtProduct")))
    session("newDate") 			= Server.HTMLEncode(Trim(Request("txtDate")))
	session("newTime") 			= Server.HTMLEncode(Trim(Request("txtTime")))
	session("newDuration") 		= Server.HTMLEncode(Trim(Request("txtDuration")))
	session("newOutcome") 		= Server.HTMLEncode(Trim(Request("txtOutcome")))
	session("newPromote") 		= Server.HTMLEncode(Trim(Request("txtPromote")))	
	session("newAttendee")		= Server.HTMLEncode(Trim(Request("txtAttendee")))
	session("newProjector")		= Server.HTMLEncode(Trim(Request("cboProjector")))
	session("newScreen")		= Server.HTMLEncode(Trim(Request("cboScreen")))
	session("newStart")			= Server.HTMLEncode(Trim(Request("txtStart")))
	session("newComments")		= Server.HTMLEncode(Trim(Request("txtComments")))

	Set paraObj = cmdObj.CreateParameter("@trnAudience",AdVarChar,AdParamInput,50,session("newAudience"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnAudienceOther",AdVarChar,AdParamInput,50,session("newAudienceOther"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnVenue",AdVarChar,AdParamInput,50,session("newVenue"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnProduct",AdVarChar,AdParamInput,50,session("newProduct"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnDate",AdVarChar,AdParamInput,20,session("newDate"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnTime",AdVarChar,AdParamInput,20,session("newTime"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnDuration",AdVarChar,AdParamInput,20,session("newDuration"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnOutcome",AdVarChar,AdParamInput,120,session("newOutcome"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnPromote",AdVarChar,AdParamInput,120,session("newPromote"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnAttendee",AdVarChar,AdParamInput,4,session("newAttendee"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnProjector",AdInteger,AdParamInput,2,session("newProjector"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnScreen",AdInteger,AdParamInput,2,session("newScreen"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnStart",AdVarChar,AdParamInput,120,session("newStart"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnComments",AdVarChar,AdParamInput,120,session("newComments"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnCreatedBy",AdInteger,AdParamInput,2,session("yma_userid"))
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
        id = rs(0)
        set rs = nothing
    On error Goto 0

    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
        addRequest = FALSE
        strMessageText = MessageText
		'strMessageText = err.description
    else
		addRequest = TRUE
		'call clearNewJobSessions
		Response.Redirect("list_training.asp")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function updateConnectTraining
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spUpdateConnectTraining"
    cmdObj.CommandType 			= AdCmdStoredProc

    session("trnID")  			= Server.URLEncode(Trim(Request("id")))
	
	session("trnAudience")   	= Server.HTMLEncode(Trim(Request("cboAudience")))
	session("trnAudienceOther") = Server.HTMLEncode(Trim(Request("txtAudienceOther")))
    session("trnVenue")     	= Server.HTMLEncode(Trim(Request("txtVenue")))
	session("trnProduct")    	= Server.HTMLEncode(Trim(Request("txtProduct")))
    session("trnDate") 			= Server.HTMLEncode(Trim(Request("txtDate")))
	session("trnTime") 			= Server.HTMLEncode(Trim(Request("txtTime")))
	session("trnDuration") 		= Server.HTMLEncode(Trim(Request("txtDuration")))
	session("trnOutcome") 		= Server.HTMLEncode(Trim(Request("txtOutcome")))
	session("trnPromote") 		= Server.HTMLEncode(Trim(Request("txtPromote")))	
	session("trnAttendee")		= Server.HTMLEncode(Trim(Request("txtAttendee")))
	session("trnProjector")		= Server.HTMLEncode(Trim(Request("cboProjector")))
	session("trnScreen")		= Server.HTMLEncode(Trim(Request("cboScreen")))
	session("trnStart")			= Server.HTMLEncode(Trim(Request("txtStart")))
	session("trnComments")		= Server.HTMLEncode(Trim(Request("txtComments")))

	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,session("trnID"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,session("firstname"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,session("lastname"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15,DB_NullToEmpty(session("phone")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,DB_NullToEmpty(session("mobile")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,session("address"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,session("city"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdChar,AdParamInput,5,session("state"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,session("postcode"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,60,DB_NullToEmpty(session("email")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,session("job_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,session("warranty"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,session("model_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdChar,AdParamInput,5,session("warranty_code"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15,session("serial_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15,session("invoice_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,session("date_purchased"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,session("dealer"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,session("fault"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,DB_NullToEmpty(session("accessories")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30,DB_NullToEmpty(session("comments")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,session("job_status"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,session("yma_userid"))
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute

	'response.Write cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
	    updateRequest = FALSE
    else
		'Session("user_token") = ""
		Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
        'strMessageText = "<div class=""notification_text""><img src=""images/icon_check.png""> Job record has been updated.</div>"
		updateRequest = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function getConnectTraining
    dim strSQL
    dim rs

    call OpenDataBase()

	strSQL = "EXEC spGetConnectTraining " & Server.URLEncode(Request("id")) & "," & Server.URLEncode(Session("yma_userid"))

	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
        session("trnAudience")		= Trim(rs("trnAudience"))
        session("trnAudienceOther") = Trim(rs("trnAudienceOther"))
        session("trnVenue")        	= Trim(rs("trnVenue"))
        session("trnProduct")      	= Trim(rs("trnProduct"))
        session("trnDate")      	= Trim(rs("trnDate"))
        session("trnTime")     		= Trim(rs("trnTime"))
        session("trnDuration")    	= Trim(rs("trnDuration"))
    	session("trnOutcome") 		= Trim(rs("trnOutcome"))
		session("trnPromote") 		= Trim(rs("trnPromote"))
		session("trnAttendee")		= Trim(rs("trnAttendee"))
		session("trnProjector")		= Trim(rs("trnProjector"))
		session("trnScreen")		= Trim(rs("trnScreen"))
		session("trnStart")			= Trim(rs("trnStart"))
		Session("trnComments")		= Trim(rs("trnComments"))
		Session("trnStatus")		= Trim(rs("trnStatus"))
		session("trnDateCreated")	= Trim(rs("trnDateCreated"))
		session("trnCreatedBy")   	= Trim(rs("trnCreatedBy"))		
		session("trnDateModified")	= Trim(rs("trnDateModified"))
		session("trnModifiedBy")   	= Trim(rs("trnModifiedBy"))			
		session("trnDateApproved")	= Trim(rs("trnDateApproved"))
		session("trnApprovedBy")   	= Trim(rs("trnApprovedBy"))
		
		if Trim(session("yma_userid")) = Trim(session("trnCreatedBy")) then
			session("training_not_found") 	= "FALSE"
		else
			session("training_not_found") 	= "TRUE"
		end if
	else
		session("training_not_found") 		= "TRUE"
    end if

    call CloseDataBase()
end function
%>