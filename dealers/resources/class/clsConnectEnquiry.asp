<%
function addEnquiry(intCategory,strEnquiry,intCreatedBy)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddConnectEnquiry"
    cmdObj.CommandType 			= AdCmdStoredProc

	Set paraObj = cmdObj.CreateParameter("@enqCategory",AdInteger,AdParamInput,2,intCategory)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@enqEnquiry",AdVarChar,AdParamInput,250,strEnquiry)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@enqCreatedBy",AdInteger,AdParamInput,2,intCreatedBy)
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
    else
		addRequest = TRUE
		strMessageText = "Your enquiry has been successfully submitted."
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>