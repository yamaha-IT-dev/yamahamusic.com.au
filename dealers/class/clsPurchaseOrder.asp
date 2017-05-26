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
		
		Dim JMail
		
		Set JMail = CreateObject("JMail.SMTPMail")
		
		JMail.ServerAddress = "smtp.bne.server-mail.com"
		'JMail..MailServerUserName = "yamahamusicau"
		'JMail.MailServerPassword = "str0ppy@16"
		JMail.Subject		= "[Yamaha Connect] New Purchase Order"
		JMail.Sender		= "noreply@yamaha.com"
		JMail.AddRecipient  ("mpdorders-aus@music.yamaha.com")
		JMail.AddRecipient  ("alexander.yabsley@music.yamaha.com")
		
		JMail.Body    	= "G'day Internal Sales!" & vbCrLf _
						& "" & vbCrLf _
						& "A new purchase order has been submitted via Yamaha Connect by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
						& "" & vbCrLf _
						& "Product: " & strModelNo & vbCrLf _
						& "Qty: " & intQty & vbCrLf _
						& "Price: $" & intPrice & vbCrLf _
						& "Total: $" & intTotal & vbCrLf _
						& "Order no: " & strOrderNo & vbCrLf _
						& "" & vbCrLf _
						& "For more details: http://intranet:78/list_po.asp" & vbCrLf _
						& "" & vbCrLf _
						& "This is an automated email. Please do not reply to this address."
		JMail.Execute
		
		set JMail = nothing
		
		Response.Redirect("purchase-orders.asp")
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>