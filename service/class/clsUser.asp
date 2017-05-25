<%

'-----------------------------------------------
' GET USER DETAILS
'-----------------------------------------------
Function getUserDetails(intUserID)
    dim strSQL

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic

    strSQL = "SELECT * FROM tbl_users "
    strSQL = strSQL & "	WHERE user_id = " & intUserID 

    rs.Open strSQL, conn

    'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
        session("usr_firstname")    = Trim(rs("firstname"))
        session("usr_lastname")     = Trim(rs("lastname"))
        session("usr_storename")    = Trim(rs("storename"))
        session("usr_dealer_code")  = Ucase(Trim(rs("dealer_code")))
        session("usr_vendor_code")  = Ucase(Trim(rs("vendor_code")))
        session("usr_address")      = Trim(rs("address"))
        session("usr_city")         = Trim(rs("city"))
        session("usr_state")        = Trim(rs("state"))
        session("usr_postcode")     = Trim(rs("postcode"))
        session("usr_phone")        = Trim(rs("phone"))
        session("usr_username")     = Trim(rs("username"))
        session("usr_password")     = Trim(rs("password"))
    end if

    call CloseDataBase()

end function

'-----------------------------------------------
' UPDATE USER DETAILS
'-----------------------------------------------
function updateUser(intUserID,strFirstname,strLastname,strStore,strDealerCode,strVendorCode,strAddress,strCity,strState,strPostcode,strPhone,strPassword)
    dim strSQL

    Call OpenDataBase()

    strSQL = "UPDATE tbl_users SET "
    strSQL = strSQL & "firstname = '" & server.htmlencode(strFirstname) & "',"
    strSQL = strSQL & "lastname = '" & server.htmlencode(strLastname) & "',"
    strSQL = strSQL & "storename = '" & server.htmlencode(strStore) & "',"
    strSQL = strSQL & "dealer_code = '" & server.htmlencode(strDealerCode) & "',"
    strSQL = strSQL & "vendor_code = '" & server.htmlencode(strVendorCode) & "',"
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
        strMessageText = "<div class=""notification_text""><img src=""images/icon_check.png""> Your details have been updated.</div>"
    end if

    Call CloseDataBase()
end function

%>