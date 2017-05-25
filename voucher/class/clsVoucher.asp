<%
function getVoucherDetails(intID, strSerialNo)
	dim strSQL

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT C.*, dealer_name FROM yma_premium_care C "
	strSQL = strSQL & " 	INNER JOIN yma_premium_care_dealers D ON D.dealer_id = C.dealer_id "
	strSQL = strSQL & "	WHERE premiumcare_id = " & intID & " AND C.serial_no = '" & strSerialNo & "' AND serial_no_check = 1 AND voucher_redeemed = 0"

	rs.Open strSQL, conn	

    if not DB_RecSetIsEmpty(rs) Then
		Session("voucherCustomerID")	= rs("premiumcare_id")
        Session("voucherFirstname")		= rs("firstname")
        Session("voucherLastname")     	= rs("lastname")
		Session("voucherAddress")     	= rs("address")
        Session("voucherCity")     		= rs("city")
        Session("voucherState")    		= rs("state")
		Session("voucherPostcode") 		= rs("postcode")
		Session("voucherPiano")			= rs("product")
		Session("voucherSerialNo")		= rs("serial_no")
		Session("voucherDealerName")	= rs("dealer_name")
		Session("voucherPurchaseDate")	= rs("purchase_date")
		Session("voucherExpiryDate")	= rs("voucher_expiry_date")
		Session("voucher_not_found")= "FALSE"			
	else
		Session("voucher_not_found")= "TRUE"
    end if

    call CloseDataBase()
end function

function checkVoucher(intID)
	dim strSQL
	dim rs
	
	OpenDataBase()
	
	strSQL = "SELECT voucher_redeemed FROM yma_premium_care WHERE premiumcare_id = '" & intID & "'"
	'response.Write strSQL	
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.Open strSQL, conn
	
	if not DB_RecSetIsEmpty(rs) Then
		intVoucherRedeemed = rs("voucher_redeemed")
    end if		
	
	call CloseDataBase()
end function
%>