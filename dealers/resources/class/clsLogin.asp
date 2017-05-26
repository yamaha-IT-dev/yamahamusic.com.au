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
		Session("yma_userid")     	= 0
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
			
	On Error Resume Next
	cmdObj.Execute
	'On error Goto 0
			
	if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
		testUserLogin = FALSE
	else		
		Session("yma_userid")    = cmdObj("intUserID")
		
		'call validateLogin
		
		Response.Redirect("home.asp")
		
		testUserLogin = TRUE
	end if
	
	Call DB_closeObject(paraObj)
	Call DB_closeObject(cmdObj)
			
	call CloseDataBase
end function

function validateLogin()
	if len(trim(Session("yma_userid"))) = 0 then
        Session.Abandon
		Session.Contents.RemoveAll()    
        response.Redirect("http://www.yamahamusic.com.au/dealers/resources/")    
    end if
end function
%>