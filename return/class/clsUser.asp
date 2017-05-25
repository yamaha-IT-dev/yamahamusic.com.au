<%
function checkUsername(strEmail)
	dim strSQL
	dim rs

	OpenDataBase()

	strSQL = "SELECT * FROM tbl_users WHERE username = '" & strEmail & "'"
	'response.Write strSQL

	set rs = Server.CreateObject("ADODB.recordset")

	rs.Open strSQL, conn

	if rs.EOF then
		Response.Redirect("register.asp")
    else
		'strMessageText = "The email address is already registered in our system. Did you happen to forget your password?"
		dim strFirstname, strUsername, strPassword, JMail

		strFirstname 	= rs("firstname")
		strUsername		= rs("username")
    	strPassword 	= rs("password")

		Set JMail = CreateObject("JMail.SMTPMail")

		JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Subject		= "Yamaha Goods Return Login"
		JMail.Sender		= "AVsales-aus@music.yamaha.com"

		JMail.AddRecipient (strEmail)

		JMail.Body    	= "Dear " & strFirstname & "," & vbCrLf _
						& "" & vbCrLf _
						& "As requested, below is your login information." & vbCrLf _
						& "" & vbCrLf _
						& "Username: Your email address" & vbCrLf _
						& "Password: " & strPassword & vbCrLf _
						& "" & vbCrLf _
						& "Regards," & vbCrLf _
						& "" & vbCrLf _
						& "Yamaha Music Australia"
		JMail.Execute

		set JMail = nothing

		strMessageText = "The email address is already registered in our system. The login details has been sent to that email (Please check your inbox). Alternatively enter a different email address."
	end if

	call CloseDataBase()
end function

function registerUser(strUsername, strPassword, strFirstname, strLastname, strStore, strAddress, strCity, strState, strPostcode, strPhone)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spRegisterUser"
    cmdObj.CommandType 			= AdCmdStoredProc

	Set paraObj = cmdObj.CreateParameter("@username",AdVarChar,AdParamInput,60,Server.HTMLEncode(strUsername))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@password",AdVarChar,AdParamInput,30,strPassword)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@firstname",AdVarChar,AdParamInput,30,Server.HTMLEncode(strFirstname))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@lastname",AdVarChar,AdParamInput,30,Server.HTMLEncode(strLastname))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@store",AdVarChar,AdParamInput,30,Server.HTMLEncode(strStore))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@address",AdVarChar,AdParamInput,60,Server.HTMLEncode(strAddress))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@city",AdVarChar,AdParamInput,20,Server.HTMLEncode(strCity))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@state",AdVarChar,AdParamInput,3,Server.HTMLEncode(strState))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@postcode",AdVarChar,AdParamInput,4,Server.HTMLEncode(strPostcode))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@phone",AdVarChar,AdParamInput,12,Server.HTMLEncode(strPhone))
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
        strMessageText = MessageText
    else
		addRequest = TRUE
		Response.Redirect("thank-you.html")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

'-----------------------------------------------
' GET USER DETAILS
'-----------------------------------------------
Function getUserDetails(intUserID)
	dim strSQL

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT * FROM tbl_users "
	strSQL = strSQL & "	WHERE user_id = " & intUserID

	rs.Open strSQL, conn

	'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
		session("usr_firstname") 	= rs("firstname")
		session("usr_lastname") 	= rs("lastname")
		session("usr_storename") 	= rs("storename")
		session("usr_dealer_code") 	= rs("dealer_code")
		session("usr_branch") 		= rs("branch")
		session("usr_address") 		= rs("address")
		session("usr_city") 		= rs("city")
		session("usr_state") 		= rs("state")
		session("usr_postcode") 	= rs("postcode")
		session("usr_phone") 		= rs("phone")
		session("usr_username")  	= rs("username")
		session("usr_password")		= rs("password")
    end if

    call CloseDataBase()

end function

'-----------------------------------------------
' UPDATE USER DETAILS
'-----------------------------------------------
function updateUser(intUserID,strFirstname,strLastname,strStore,strDealerCode,strBranch,strAddress,strCity,strState,strPostcode,strPhone,strPassword)
	dim strSQL

	Call OpenDataBase()

	strSQL = "UPDATE tbl_users SET "
	strSQL = strSQL & "firstname = '" & server.htmlencode(strFirstname) & "',"
	strSQL = strSQL & "lastname = '" & server.htmlencode(strLastname) & "',"
	strSQL = strSQL & "storename = '" & server.htmlencode(strStore) & "',"
	strSQL = strSQL & "dealer_code = '" & server.htmlencode(strDealerCode) & "',"
	strSQL = strSQL & "branch = '" & server.htmlencode(strBranch) & "',"
	strSQL = strSQL & "address = '" & server.htmlencode(strAddress) & "',"
	strSQL = strSQL & "city = '" & server.htmlencode(strCity) & "',"
	strSQL = strSQL & "state = '" & strState & "',"
	strSQL = strSQL & "postcode = '" & server.htmlencode(strPostcode) & "',"
	strSQL = strSQL & "phone = '" & server.htmlencode(strPhone) & "',"
	strSQL = strSQL & "password = '" & strPassword & "',"
	strSQL = strSQL & "date_modified = getdate() "
	strSQL = strSQL & "		WHERE user_id = " & intUserID

	'response.Write strSQL
	on error resume next
	conn.Execute strSQL

	if err <> 0 then
		strMessageText = err.description
	else
		strMessageText = "Your details have been updated."
	end if

	Call CloseDataBase()
end function
%>
