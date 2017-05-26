<%
function addConnectPO(strModelNo, intQty, intPrice, intTotal, strOrderNo, intCreatedBy)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddConnectPO"
    cmdObj.CommandType 			= AdCmdStoredProc
	
	Set paraObj = cmdObj.CreateParameter("@purModelNo",AdVarChar,AdParamInput,50,strModelNo)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@purQty",AdInteger,AdParamInput,2,intQty)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@purPrice",AdVarChar,AdParamInput,18,intPrice)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@purTotal",AdVarChar,AdParamInput,18,intTotal)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@purOrderNo",AdVarChar,AdParamInput,20,strOrderNo)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@purCreatedBy",AdInteger,AdParamInput,2,intCreatedBy)
	cmdObj.Parameters.Append paraObj
	
	'response.write "<h3 style=color:white>" & cmdObj.Execute & "</h3>"
	
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
		Response.Redirect("purchase-orders.asp")
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>