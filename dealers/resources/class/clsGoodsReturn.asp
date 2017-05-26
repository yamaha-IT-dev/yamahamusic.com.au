<%
function addReturn
	Dim cmdObj, paraObj
	
    call OpenDataBase
	
    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddReturn"
    cmdObj.CommandType = AdCmdStoredProc
	
	'New Dealer Details Sessions
    session("new_dealer_name")   		= request("txtDealerName")
	session("new_dealer_contact_name")  = request("txtDealerContactName")
    session("new_dealer_phone")     	= request("txtDealerPhone")	
	session("new_dealer_email") 		= request("txtDealerEmail")
	
	'New Stock Details Sessions
	session("new_model_no")			= request("txtModelNo")
	session("new_qty")				= request("txtQty")	
	session("new_serial_no")		= request("txtSerialNo")
	session("new_invoice_no")   	= request("txtInvoiceNo")
	session("new_invoice_date")		= request("txtInvoiceDate")
	session("new_reason")     		= request("txtReason")
	session("new_type")     		= request("cboType")
	session("new_customer_name")  	= request("txtCustomerName")
	session("new_date_purchased")	= request("txtDatePurchased")
	session("new_serviced")   		= request("cboServiced")	
	session("new_date_serviced")    = request("txtDateServiced")
	session("new_serviced_by") 		= request("txtServicedBy")
	
	'New Dealer Details	Parameters
	Set paraObj = cmdObj.CreateParameter("@gra_userid",AdInteger,AdParamInput,2, session("yma_userid"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_customerid",AdInteger,AdParamInput,2, session("yma_customerid"))
	cmdObj.Parameters.Append paraObj		
	Set paraObj = cmdObj.CreateParameter("@gra_dealer_name",AdVarChar,AdParamInput,50, session("new_dealer_name"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_dealer_contact_name",AdVarChar,AdParamInput,50, session("new_dealer_contact_name"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_dealer_phone",AdVarChar,AdParamInput,20, session("new_dealer_phone"))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("@gra_dealer_email",AdVarChar,AdParamInput,80, session("new_dealer_email"))
	cmdObj.Parameters.Append paraObj
	
	'New Stock Details Parameters	
	Set paraObj = cmdObj.CreateParameter("@gra_model_no",AdVarChar,AdParamInput,50, session("new_model_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_qty",AdInteger,AdParamInput,2, session("new_qty"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_serial_no",AdVarChar,AdParamInput,80, session("new_serial_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_invoice_no",AdVarChar,AdParamInput,20, session("new_invoice_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_invoice_date",AdVarChar,AdParamInput,20, session("new_invoice_date"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_reason",AdVarChar,AdParamInput,120, session("new_reason"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_type",AdChar,AdParamInput,10, session("new_type"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_customer_name",AdVarChar,AdParamInput,30, session("new_customer_name"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_date_purchased",AdVarChar,AdParamInput,20, session("new_date_purchased"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_serviced",AdInteger,AdParamInput,2, session("new_serviced"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@gra_date_serviced",AdVarChar,AdParamInput,20, session("new_date_serviced"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@new_serviced_by",AdVarChar,AdParamInput,20, session("new_serviced_by"))
	cmdObj.Parameters.Append paraObj
	
    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
        id = rs(0)
        set rs = nothing
    On error Goto 0
	
    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
        addCustomer = FALSE
        strMessageText = MessageText
		'strMessageText = err.description
    else
		addCustomer = TRUE
		
		if request("chkPhoto") = "Yes" then	
			Response.Redirect("new-return-upload.asp")
		else		
			call clearNewGraSessions
			Response.Redirect("return.asp")
		end if			
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)
	
    call CloseDataBase
end function

function sendGraNotification(strProduct,strSerialNo,strInvoiceNo,strDateSale)
	Set JMail=CreateObject("JMail.SMTPMail")
		
	JMail.ServerAddress = "smtp.bne.server-mail.com"
	JMail.Subject		= "GRA Entry by: " & session("usr_storename") & " (" & session("usr_firstname") & " " & session("usr_lastname") & ")" & ""
	JMail.Sender		= "automailer@gmx.yamaha.com"
	JMail.SenderName	= "Yamaha Music Australia"
		
	JMail.AddRecipient ("AVsales@gmx.yamaha.com")
		
	JMail.Body 	= "G-day!" & vbCrLf _
				& "" & vbCrLf _
				& "New sales submitted by: " & session("usr_storename") & " (" & session("usr_firstname") & " " & session("usr_lastname") & ")" & vbCrLf _
				& "------------------------------------------------------------------------------" & vbCrLf _
				& "Product    : " & strProduct & vbCrLf _
				& "Serial no  : " & strSerialNo & vbCrLf _
				& "Invoice no : " & strInvoiceNo & vbCrLf _
				& "Date sale  : " & strDateSale & vbCrLf _					
				& "------------------------------------------------------------------------------" & vbCrLf _
				& " " & vbCrLf _
				& "Please click on this link to view the list: " & vbCrLf _
				& "http://172.29.64.7:78/list_entries.asp" & vbCrLf _
				& " " & vbCrLf _
				& "This is an automated email. Please do not reply to this email." & vbCrLf _
				& " " & vbCrLf _
				& "Yamaha Music Australia" & vbCrLf _

	'JMail.BodyFormat = 0
	'JMail.MailFormat = 0
	JMail.Execute
		
	set JMail = nothing
end function

'-----------------------------------------------
' UPDATE Gra
'-----------------------------------------------
Function updateGra(intGraID,intProductID,strSerialNo,strInvoiceNo,strDateSale,intModifiedBy)
	dim strSQL
	
	Call OpenDataBase()

	strSQL = "UPDATE yma_gra SET "
	strSQL = strSQL & "sales_product_id = '" & intProductID & "',"
	strSQL = strSQL & "sales_serial_no = '" & server.htmlencode(strSerialNo) & "',"
	strSQL = strSQL & "sales_invoice_no = '" & server.htmlencode(strInvoiceNo) & "',"
	strSQL = strSQL & "sales_date_sale = CONVERT(datetime,'" & strDateSale & "',103),"
	strSQL = strSQL & "sales_modified_by = '" & intModifiedBy & "',"
	strSQL = strSQL & "sales_date_modified = getdate() "
	strSQL = strSQL & "		WHERE sales_id = " & intGraID
	
	'response.Write strSQL
	on error resume next
	conn.Execute strSQL
	
	if err <> 0 then
		strMessageText = err.description
	else
		strMessageText = "The GRA has been successfully updated."
	end if 
	
	Call CloseDataBase()
end function

'-----------------------------------------------
' GET GRA
'-----------------------------------------------
Function getGra(intGraID)
	Dim strSQL
	dim rs
	
    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT GRA.*, "
	strSQL = strSQL & "	USR.username, USR.firstname, USR.lastname, USR.storename, USR.dealer_code, USR.branch, "
	strSQL = strSQL & "	USR.address, USR.city, USR.state, USR.postcode, USR.phone "
	strSQL = strSQL & "		FROM yma_gra GRA "
	strSQL = strSQL & "			LEFT JOIN tbl_users USR ON GRA.created_by = USR.user_id "
	strSQL = strSQL & "		WHERE created_by = " & session("UsrUserID") & " AND gra_id = " & intID

	rs.Open strSQL, conn

	'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
		session("username") 			= rs("username")
		session("firstname") 			= rs("firstname")
		session("lastname") 			= rs("lastname")
		session("storename") 			= rs("storename")
		session("dealer_code") 			= rs("dealer_code")
		session("branch") 				= rs("branch")
		session("address") 				= rs("address")
		session("city") 				= rs("city")
		session("state") 				= rs("state")
		session("postcode") 			= rs("postcode")
		session("phone") 				= rs("phone")
		session("model_no") 			= rs("model_no")
		session("serial_no") 			= rs("serial_no")
		session("invoice_no") 			= rs("invoice_no")
		session("date_purchased") 		= rs("date_purchased")
		session("claim_no") 			= rs("claim_no")
		session("replacement_order_no") = rs("replacement_order_no")
		session("reason") 				= rs("reason")
		session("fault") 				= rs("fault")
		session("test_performed") 		= rs("test_performed")
		session("accessories") 			= rs("accessories")
		session("packaging") 			= rs("packaging")
		session("gra_no") 				= rs("gra_no")		
		session("status") 				= rs("status")
		session("date_created") 		= rs("date_created")
		session("created_by") 			= rs("created_by")
		session("date_modified") 		= rs("date_modified")
		session("modified_by") 			= rs("modified_by")
		session("comments") 			= rs("comments")
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' GET GRA ID
'-----------------------------------------------
Function getGraID(intUserID,strModelNo,strInvoiceNo)
	Dim strSQL
	dim rs
	
    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT * FROM tbl_gra_mpd "
	strSQL = strSQL & "	WHERE gra_userid = '" & intUserID & "' "
	strSQL = strSQL & "		AND gra_model_no = '" & strModelNo & "' "
	strSQL = strSQL & "		AND gra_invoice_no = '" & strInvoiceNo & "'"

	rs.Open strSQL, conn

	'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
		session("new_gra_id") = rs("gra_id")		
    end if

    call CloseDataBase()
end function

function clearNewGraSessions
	session("new_dealer_name")   		= ""
	session("new_dealer_contact_name")  = ""
    session("new_dealer_phone")     	= ""
	session("new_dealer_email") 		= ""
	
	session("new_model_no")			= ""
	session("new_qty")				= ""
	session("new_serial_no")		= ""
	session("new_invoice_no")   	= ""
	session("new_invoice_date")		= ""
	session("new_reason")     		= ""
	session("new_type")     		= ""
	session("new_customer_name")  	= ""
	session("new_date_purchased")	= ""
	session("new_serviced")   		= ""
	session("new_date_serviced")    = ""
	session("new_serviced_by") 		= ""
end function
'-----------------------------------------------
' DELETE GRA
'-----------------------------------------------
function deleteGra(intGraID)
	dim strSQL
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic
			
	strSQL = "DELETE FROM yma_gra WHERE gra_id = " & intGraID
	
	rs.Open strSQL, conn
	
	Set rs = nothing
	
	if err <> 0 then
		strMessageText = err.description
	else
		Response.Redirect("home.asp")
	end if
	
    call CloseDataBase()
end function
%>