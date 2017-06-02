<%
function cleanUserInput(id) 
	cleanUserInput= Replace(Trim(Request.Form(id)),"'","''")
end function

Sub createAndAddParameter(cmdObj,parameterName, sessionId, size, isNumber)

	if isNumber=true then
		Set paraObj = cmdObj.CreateParameter(parameterName,AdInteger,AdParamInput,size, session(sessionId))
		
	else
		Set paraObj = cmdObj.CreateParameter(parameterName,AdVarChar,AdParamInput,size, session(sessionId))
	end if
	
	cmdObj.Parameters.Append paraObj
end sub

Function CheckForSQLError(connObj,strSQLType,strMessageText)
		Dim intNumErrors, errorObj
		
		CheckForSQLError = FALSE
		intNumErrors = connObj.Errors.Count
		UTL_DisplayMessage "Errors: " & intNumErrors,strMessageText,AdmErrorColour
		if intNumErrors > 0 then
			CheckForSQLError = TRUE
			UTL_DisplayMessage "The following errors have occured:<br>", strMessageText,AdmErrorColour
			for each errorObj in connObj.Errors
				if TestADOError(errorObj,strSQLType,strMessageText) = FALSE then
					if TestMSQLError(errorObj,strSQLType,strMessageText) = FALSE then
						TestCustomError errorObj,strSQLType,strMessageText 
					end if
				end if
			next
		end if
		
	End Function


function addDealerPreDeliveryReg()
	Dim cmdObj, paraObj, strMessageText
response.write "xxxxx start......"
    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddPreDeliveryReg"
    cmdObj.CommandType = AdCmdStoredProc
	response.write "start......"

    session("DealerId") 	     = Trim(Request.Form("cboDealer"))
	session("ModelNo") 	         = cleanUserInput("txtModelNo")
	session("SerialNo") 	     = cleanUserInput("txtSerialNo")
	session("PreDeliveryCertNo") = cleanUserInput("txtPreDeliveryCertNo")
	session("Yasa_no") 	     = Trim(Request.Form("cboYASANo"))
	
	
	call createAndAddParameter(cmdObj,"@dealer_id","DealerId",2,true)
	call createAndAddParameter(cmdObj,"@model_no","ModelNo",12,false)
	call createAndAddParameter(cmdObj,"@serial_no","SerialNo",12,false)
	call createAndAddParameter(cmdObj,"@preDeli_cert_no","PreDeliveryCertNo",12,false)	
	call createAndAddParameter(cmdObj,"@yasa_no","Yasa_no",3,true)
	
	response.write "start......"

    On Error Resume Next
        Dim rs
        Dim id
		response.write "X4......"
        set rs = cmdObj.Execute
		response.write "X2......"
        'id = rs(0)
        set rs = nothing
    On error Goto 0
    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
		strMessageText = err.description		
		response.write "Error" & err.description
    else
		Response.Redirect("../thank-you.html")
		
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
'-----------------------------------------------
' GET PREMIUM CARE DEALERS
'-----------------------------------------------
function getYASAList
    dim strSqlQuery
    dim rs
	dim strDealerID
	dim strDealerName
	dim strDealerState
	
    call OpenDataBase()
    'WHERE status = '" & filterType & "'
	strSqlQuery = "SELECT Firstname,Lastname,YASA FROM YasaList ORDER BY Firstname,Lastname,state, city"
		
	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSqlQuery)
    
    strYASAListList = strYASAListList & "<option value=''>...</option>"
    
    if not DB_RecSetIsEmpty(rs) Then
        do until rs.EOF
        	strFirstName		= trim(rs("Firstname"))
			strLastName			= trim(rs("Lastname"))
			strYASA				= trim(rs("YASA"))
			
			dim display
			display	= strFirstName & " " &  strLastName
			strYASAListList = strYASAListList & "<option value='" & strYASA & "'>" & display & " </option>"
                    
        rs.Movenext
        loop    
    
    end if
    
    call CloseDataBase()

end function
%>