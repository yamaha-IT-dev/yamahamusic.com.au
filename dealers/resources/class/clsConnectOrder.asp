<%
function addConnectOrder(intResourceID,intQty,intCreatedBy)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddConnectOrder"
    cmdObj.CommandType 			= AdCmdStoredProc

	Set paraObj = cmdObj.CreateParameter("@ordResourceID",AdInteger,AdParamInput,2,intResourceID)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@ordQty",AdInteger,AdParamInput,2,intQty)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnCreatedBy",AdInteger,AdParamInput,2,intCreatedBy)
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
		Response.Redirect("marketing-orders.asp")
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER") & "?q=success")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function addWebBanner(intResourceID, intQty, intWidth, intHeight, intOrientation, intCreatedBy)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddWebBanner"
    cmdObj.CommandType 			= AdCmdStoredProc

	Set paraObj = cmdObj.CreateParameter("@ordResourceID",AdInteger,AdParamInput,2,intResourceID)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@ordQty",AdInteger,AdParamInput,2,intQty)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@ordWidth",AdInteger,AdParamInput,2,intWidth)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@ordHeight",AdInteger,AdParamInput,2,intHeight)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@ordOrientation",AdInteger,AdParamInput,2,intOrientation)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@trnCreatedBy",AdInteger,AdParamInput,2,intCreatedBy)
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
		Response.Redirect("marketing-orders.asp")
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>