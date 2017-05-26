<%
'-----------------------------------------------
' GET USER DETAILS
'-----------------------------------------------
Function getUserDetails(intCustomerID)
	dim strSQL

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT * FROM yma_customer "
	strSQL = strSQL & "	WHERE id = " & intCustomerID 

	rs.Open strSQL, conn

	'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
		session("user_firstname") 	= rs("firstname")
		session("user_lastname") 	= rs("lastname")
		session("user_address") 	= rs("address")
		session("user_city") 		= rs("city")
		session("user_state") 		= rs("state")
		session("user_postcode") 	= rs("postcode")
		session("user_phone") 		= rs("phone")
		session("user_email")		= rs("email")
		session("user_storename")	= rs("country")
		session("user_dealercode")	= rs("dealer_code")
		session("user_datecreated") = rs("datecreated")
		session("user_datemodified") = rs("datemodified")
    end if
	
    call CloseDataBase()
end function

'-----------------------------------------------
' GET USER PROFILE
'-----------------------------------------------
Function getUserProfile(intUserID)
	dim strSQL
	
    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT username, logincount, datelastlogin, datecreated "
	strSQL = strSQL & "	FROM yma_user U"
	strSQL = strSQL & "	WHERE id = '" & intUserID & "'"
	
	'response.write strSQL
	
	rs.Open strSQL, conn

    if not DB_RecSetIsEmpty(rs) Then
		session("usrUsername")  	= rs("username")
		session("usrLogincount") 	= rs("logincount")
		session("usrDateLastLogin") = rs("datelastlogin")
		session("usrDateCreated") 	= rs("datecreated")
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' UPDATE USER DETAILS
'-----------------------------------------------
Function updateUserDetails(intCustomerID, strFirstname, strLastname, strAddress, strCity, strState, intPostcode, strPhone, strStorename, strDealerCode)
	dim strSQL
	
	Call OpenDataBase()
	
	strSQL = "UPDATE yma_customer SET "
	strSQL = strSQL & "firstname = '" & Server.HTMLEncode(strFirstname) & "',"
	strSQL = strSQL & "lastname = '" & Server.HTMLEncode(strLastname)& "',"
	strSQL = strSQL & "address = '" & Server.HTMLEncode(strAddress)& "',"
	strSQL = strSQL & "city = '" & Server.HTMLEncode(strCity)& "',"
	strSQL = strSQL & "state = '" & Server.HTMLEncode(strState)& "',"
	strSQL = strSQL & "postcode = '" & Server.HTMLEncode(intPostcode)& "',"
	strSQL = strSQL & "phone = '" & Server.HTMLEncode(strPhone)& "',"
	strSQL = strSQL & "country = '" & Server.HTMLEncode(strStorename)& "',"
	strSQL = strSQL & "dealer_code = '" & Server.HTMLEncode(strDealerCode)& "',"
	strSQL = strSQL & "datemodified = getdate()"
	strSQL = strSQL & " WHERE id = " & intCustomerID
	
	'response.Write strSQL
	
	on error resume next
	conn.Execute strSQL
	
	'On error Goto 0
	
	if err <> 0 then
		strMessageText = err.description
	else
		strMessageText = "<div class=""alert alert-success""><img src=""images/icon_check.png""> Your profile has been updated.</div>"
	end if
	
	Call CloseDataBase()
end Function

'-----------------------------------------------
' UPDATE USER PROFILE
'-----------------------------------------------
function updateUserProfile(intUserID,strPassword)
	dim strSQL
	
	Call OpenDataBase()
	
	strSQL = "UPDATE yma_user SET "
	strSQL = strSQL & "password = '" & server.htmlencode(strPassword )& "',"
	strSQL = strSQL & "datemodified = getdate() WHERE id = " & intUserID
	
	on error resume next
	conn.Execute strSQL
	
	'On error Goto 0
	
	if err <> 0 then
		strMessageText = err.description
	else
		strMessageText = "<div class=""alert alert-success""><img src=""../images/icon_check.png""> Your password has been successfully changed.</div>"
	end if 
	
	Call CloseDataBase()
end function

'-----------------------------------------------
' VALIDATE LOGIN ACROSS ALL PAGES
'-----------------------------------------------
function validateLogin()
	if Len(Trim(Session("yma_userid"))) = 0 or Len(Trim(Session("yma_customerid"))) = 0 or Trim(Session("yma_userid")) = "0" then
        Session.Abandon
		Session.Contents.RemoveAll()
        Response.Redirect("http://www.yamahamusic.com.au/dealers/")
    end if
end function
%>