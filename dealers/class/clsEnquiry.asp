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
		
		Dim JMail		
		Set JMail = CreateObject("JMail.SMTPMail")
		
		JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Sender		= "noreply@yamaha.com"				
		JMail.Subject		= "[Yamaha Connect] New Enquiry"
		JMail.AddRecipient  ("jaclyn.williams@music.yamaha.com")		
		JMail.AddRecipient  ("MPDOrder-AUS@music.yamaha.com ")
		JMail.Body    	= "G'day!" & vbCrLf _
						& "" & vbCrLf _
						& "An enquiry has been submitted by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
						& "" & vbCrLf _	
						& "Comments: " & strEnquiry & vbCrLf _								
						& "" & vbCrLf _						
						& "For more details: http://intranet:78/list_enquiry.asp" & vbCrLf _
						& "" & vbCrLf _
						& "This is an automated email. Please do not reply to this address."
		JMail.Execute
		
		set JMail = nothing	
		
		strMessageText = "<div class=""alert alert-success""><img src=""../images/icon_check.png""> Your enquiry has been submitted.</div>"
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>