<%
'-----------------------------------------------
' SET SESSION VARIABLES
'-----------------------------------------------
function setAddGraSessions
	session("add_model_no")			= Replace(Request.Form("txtModelNo"),"'","''")
	session("add_serial_no")		= Replace(Request.Form("txtSerialNo"),"'","''")
	session("add_invoice_no")		= Replace(Request.Form("txtInvoiceNo"),"'","''")
	session("add_date_purchased") 	= Request.Form("txtDatePurchased")
	session("add_claim_no")			= Replace(Request.Form("txtClaimNo"),"'","''")
	session("add_qty")				= Replace(Request.Form("txtQty"),"'","''")
	session("add_order_no")			= Replace(Request.Form("txtOrderNo"),"'","''")
	session("add_reason")			= Trim(Request.Form("cboReason"))
	session("add_fault")			= Replace(Request.Form("txtFault"),"'","''")
	session("add_tests")			= Replace(Request.Form("txtTests"),"'","''")
	session("add_accessories")		= Trim(request.form("cboAccessories"))
	session("add_packaging")		= Trim(request.form("cboPackaging"))
end function

'-----------------------------------------------
' CLEAR SESSION VARIABLES
'-----------------------------------------------
function setClearGraSessions
	session("add_model_no")			= ""
	session("add_serial_no")		= ""
	session("add_invoice_no")		= ""
	session("add_date_purchased") 	= ""
	session("add_claim_no")			= ""
	session("add_qty")				= ""
	session("add_order_no")			= ""
	session("add_reason")			= ""
	session("add_fault")			= ""
	session("add_tests")			= ""
	session("add_accessories")		= ""
	session("add_packaging")		= ""
end function

'-----------------------------------------------
' VERIFY SERIAL NO
'-----------------------------------------------
function checkSerialNo
	dim strSQL

	Call OpenDataBase()

	strSQL = "SELECT * FROM yma_gra "
	strSQL = strSQL & "	WHERE serial_no = '" & lcase(session("add_serial_no")) & "' "
	'response.Write strSQL

	set rs = Server.CreateObject("ADODB.recordset")

	rs.Open strSQL, conn

	if rs.EOF then
		checkSerialNo = TRUE
		call addGra(session("add_model_no"),session("add_serial_no"),session("add_invoice_no"),session("add_date_purchased"),session("add_claim_no"),session("add_order_no"),session("add_reason"),session("add_fault"),session("add_tests"),session("add_accessories"),session("add_packaging"), session("add_qty"))
    else
		strMessageText = "The serial no has been used before. Please try again."
		checkSerialNo = FALSE
	end if

	call CloseDataBase()
end function

'-----------------------------------------------
' ADD Gra
'-----------------------------------------------
Function addGra(strModelNo,strSerialNo,strInvoiceNo,strDatePurchased,strClaimNo,strOrderNo,intReason,strFault,strTests,intAccessories,intPackaging, strQty)
	dim strSQL

	Call OpenDataBase()

	strSQL = "INSERT INTO yma_gra ("
	strSQL = strSQL & " model_no, "
	strSQL = strSQL & "	serial_no, "
	strSQL = strSQL & " invoice_no, "
	strSQL = strSQL & "	date_purchased, "
	strSQL = strSQL & " claim_no, "
	strSQL = strSQL & " replacement_order_no, "
	strSQL = strSQL & " reason, "
	strSQL = strSQL & " fault, "
	strSQL = strSQL & " test_performed, "
	strSQL = strSQL & " accessories, "
	strSQL = strSQL & " packaging, "
	strSQL = strSQL & " status, "
	strSQL = strSQL & " gra_qty, "
	strSQL = strSQL & " created_by "	
	strSQL = strSQL & ") VALUES ("
	strSQL = strSQL & " '" & server.htmlencode(strModelNo) & "',"
	strSQL = strSQL & " '" & server.htmlencode(strSerialNo) & "',"
	strSQL = strSQL & " '" & server.htmlencode(strInvoiceNo) & "',"
	strSQL = strSQL & " CONVERT(datetime,'" & strDatePurchased & "',103),"
	strSQL = strSQL & " '" & server.htmlencode(strClaimNo) & "',"
	strSQL = strSQL & " '" & server.htmlencode(strOrderNo) & "',"
	strSQL = strSQL & " '" & intReason & "',"
	strSQL = strSQL & " '" & server.htmlencode(strFault) & "',"
	strSQL = strSQL & " '" & server.htmlencode(strTests) & "',"
	strSQL = strSQL & " '" & intAccessories & "',"
	strSQL = strSQL & " '" & intPackaging & "',1,"
	strSQL = strSQL & " '" & server.htmlencode(strQty) & "',"
	strSQL = strSQL & " '" & Session("UsrUserID") & "')"

	'response.Write strSQL
	on error resume next
	conn.Execute strSQL

	if err <> 0 then
		strMessageText = err.description
	else
		response.Redirect("add_return_upload.asp")
	end if

	Call CloseDataBase()
end function

function sendGraNotification(strProduct,strSerialNo,strInvoiceNo,strDateSale)
	Set JMail=CreateObject("JMail.SMTPMail")

	JMail.ServerAddress = "smtp.bne.server-mail.com"
	JMail.Subject		= "GRA Entry by: " & session("usr_storename") & " (" & session("usr_firstname") & " " & session("usr_lastname") & ")" & ""
	JMail.Sender		= "AVsales-aus@music.yamaha.com"
	JMail.SenderName	= "Yamaha Music Australia"

	'JMail.AddRecipientBCC ("victor.samson@music.yamaha.com")
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
				& "http://intranet:78/list_entries.asp" & vbCrLf _
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
		session("qty") 					= rs("gra_qty")
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
' GET SALES ID
'-----------------------------------------------
Function getGraID(strModelNo,strSerialNo)
	Dim strSQL
	dim rs

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT * FROM yma_gra "
	strSQL = strSQL & "	WHERE serial_no = '" & strSerialNo & "' "
	strSQL = strSQL & "		AND model_no = '" & strModelNo & "' "
	strSQL = strSQL & "		AND created_by = '" & Session("UsrUserID") & "'"

	rs.Open strSQL, conn

	'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
		session("new_gra_id")			= rs("gra_id")
		session("new_model_no")			= rs("model_no")
		session("new_serial_no")		= rs("serial_no")
		session("new_invoice_no")		= rs("invoice_no")
		session("new_date_purchased") 	= rs("date_purchased")
		session("new_claim_no")			= rs("claim_no")
		session("new_qty")				= rs("gra_qty")
		session("new_replacement_order_no")	= rs("replacement_order_no")
		session("new_reason")			= rs("reason")
		session("new_fault")			= rs("fault")
		session("new_test_performed")	= rs("test_performed")
		session("new_accessories")		= rs("accessories")
		session("new_packaging")		= rs("packaging")
    end if

    call CloseDataBase()
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

'-----------------------------------------------
' CLEAR PREVIOUS SAVED SESSIONS
'-----------------------------------------------
Function clearAddGraSessions
	session("add_model_no")			= ""
	session("add_serial_no")		= ""
	session("add_invoice_no")		= ""
	session("add_date_purchased") 	= ""
	session("add_claim_no")			= ""
	session("add_qty")				= ""
	session("add_order_no")			= ""
	session("add_reason")			= ""
	session("add_fault")			= ""
	session("add_tests")			= ""
	session("add_accessories")		= ""
	session("add_packaging")		= ""
end Function
%>
