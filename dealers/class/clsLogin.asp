<%
'********************************************************************
'Function: 		SetSessionVariables
'Description: 	This function either collects the form variables and sets the required session variables or clears the previous values.
'				The session variables are used to maintain state between requests to add records. 
'Parameters:	blnSetType - to fill with form variables or clear
'********************************************************************
Function SetSessionVariables(blnSetType)
	if blnSetType = TRUE then 
		Session("usrUsername") 	= Request("username")
		Session("usrPassword") 	= Request("password")
	elseif blnSetType = FALSE then 
		Session("usrUsername") 	= ""
		Session("usrPassword") 	= ""
		Session("yma_userid")   = 0
	else 
		'error
		SetSessionVariables = FALSE
		Exit Function
	end if
	
	Session.Timeout = 420 'number of minutes
	
	SetSessionVariables = TRUE
End Function

function testUserLogin
	Dim cmdObj, paraObj
	
	call OpenDataBase
			
	Set cmdObj = Server.CreateObject("ADODB.Command")
	cmdObj.ActiveConnection = conn
	cmdObj.CommandText = "spConnectLogin"
	cmdObj.CommandType = AdCmdStoredProc
			
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Session("usrUsername"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Session("usrPassword"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("intUserID",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("intCustomerID",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj
			
	On Error Resume Next
	cmdObj.Execute
	'On error Goto 0
			
	if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
		testUserLogin = FALSE
	else		
		Session("yma_userid") 		= cmdObj("intUserID")
		Session("yma_customerid") 	= cmdObj("intCustomerID")
		
		call validateLogin
		
		Response.Redirect("home/")
		
		testUserLogin = TRUE
	end if
	
	Call DB_closeObject(paraObj)
	Call DB_closeObject(cmdObj)
			
	call CloseDataBase
end function

function validateLogin()
	if Len(Trim(Session("yma_userid"))) = 0 then
        Session.Abandon
		Session.Contents.RemoveAll()    
        response.Redirect("http://www.yamahamusic.com.au/dealers/")    
    end if
end function

function retrievePassword(strEmail)
	dim strSQL		
		
	Call OpenDataBase()
	
	strSQL = "SELECT password FROM yma_user WHERE username = '" & strEmail & "' "
	
	response.Write strSQL	
	
	set rs = Server.CreateObject("ADODB.recordset")			
	
	rs.Open strSQL, conn
	
	'On error Goto 0
	if rs.EOF then
    	strMessageText = "<div class=""alert alert-danger""><img src=""../images/icon_cross.png"">That email was not found. Please retry with a different email.</div>"
    else
    	dim strPassword
    	strPassword = rs("password")						
		
		Set JMail = CreateObject("JMail.SMTPMail")
		
		JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Subject		= "Yamaha Connect Login"
		JMail.Sender		= "noreply@yamahamusic.com"
		
		JMail.AddRecipient (strEmail)
		
		JMail.Body    	= "G'day!" & vbCrLf _
						& "" & vbCrLf _
						& "As requested. Your password is: " & strPassword & vbCrLf _
						& "" & vbCrLf _
						& "This is an automated email. Please do not reply to this address."
		JMail.Execute
		
		set JMail = nothing	
									
		strMessageText = "<div class=""alert alert-success""><img src=""../images/icon_check.png"">Found it! Please check your inbox.</div>"
	end if	
	
	call CloseDataBase()
end function
%>