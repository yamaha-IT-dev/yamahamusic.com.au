<%

function addCustomer
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddCustomer"
    cmdObj.CommandType = AdCmdStoredProc

    Set paraObj = cmdObj.CreateParameter("@first_name",AdVarChar,AdParamInput,20, request("txtFirstName"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@last_name",AdVarChar,AdParamInput,20, request("txtLastName"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@phone_no",AdVarChar,AdParamInput,15, request("txtPhoneNo"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@company",AdVarChar,AdParamInput,50, request("txtMobile"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@address",AdVarChar,AdParamInput,50, request("txtAddress"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@city",AdVarChar,AdParamInput,30, request("txtCity"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@state",AdChar,AdParamInput,5, request("cboState"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter("@postcode",AdVarChar,AdParamInput,5, request("txtPostcode"))
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
        'response.Redirect("add_customer.asp?update=y&customer_id=" & id)
        Response.Redirect("thank-you.asp")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase

end function

function updateCustomer
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spUpdateCustomer"
    cmdObj.CommandType = AdCmdStoredProc

    session("customer_id")  = request("customer_id")
    session("first_name")   = request("txtFirstname")
    session("last_name")    = request("txtLastname")
    session("phone_no")     = request("txtPhoneNo")
    session("mobile")       = request("txtMobile")
    session("address")      = request("txtAddress")
    session("city")         = request("txtCity")
    session("state")        = request("cboState")
    session("postcode")     = request("txtPostcode")
    session("status")       = request("cboStatus")

    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("first_name"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20, session("last_name"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,15, session("phone_no"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50, session("mobile"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50, session("address"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,30, session("city"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdChar,AdParamInput,5, session("state"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,5, session("postcode"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdBoolean,AdParamInput,4, session("status"))
    cmdObj.Parameters.Append paraObj
    Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4, session("customer_id"))
    cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
        updateCustomer = FALSE
    else
        strMessageText = session("customer_name") & " has been updated"
        updateCustomer = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

%>