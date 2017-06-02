<%
'-----------------------------------------------
' GET PREMIUM CARE DEALERS
'-----------------------------------------------
function getDealerList
    dim strSqlQuery
    dim rs
	dim strDealerID
	dim strDealerName
	dim strDealerState
	
    call OpenDataBase()
    
	strSqlQuery = "SELECT * FROM yma_premium_care_dealers WHERE status = 1 ORDER BY dealer_name, state, city"
		
	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSqlQuery)
    
    strDealerList = strDealerList & "<option value=''>...</option>"
    
    if not DB_RecSetIsEmpty(rs) Then
        do until rs.EOF
        	strDealerID		= trim(rs("dealer_id"))
			strDealerName	= trim(rs("dealer_name"))
			strDealerCity	= trim(rs("city"))
			strDealerState	= trim(rs("state"))
			
            if trim(session("dealer_id")) = strDealerID then
                strDealerList = strDealerList & "<option selected value=" & strDealerID & ">" & strDealerName & " - " & strDealerCity & " " & strDealerState & " </option>"
            else
                strDealerList = strDealerList & "<option value=" & strDealerID & ">" & strDealerName & " - " & strDealerCity & " " & strDealerState & " </option>"
            end if
                    
        rs.Movenext
        loop    
    
    end if
    
    call CloseDataBase()

end function
%>