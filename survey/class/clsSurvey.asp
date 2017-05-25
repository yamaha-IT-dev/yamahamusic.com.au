<%
function addSurvey
	Dim cmdObj, paraObj
	
    call OpenDataBase
	
    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddSurvey"
    cmdObj.CommandType = AdCmdStoredProc
	
	session("find") 		= Request.Form("cboFind")
	session("find_other") 	= Request.Form("txtFindOther")
	session("service") 		= Request.Form("radService")
	session("fixed") 		= Request.Form("radFixed")
	session("location") 	= Request.Form("radLocation")
	session("appearance") 	= Request.Form("radAppearance")
	session("attitude") 	= Request.Form("radAttitude")
	session("knowledge") 	= Request.Form("radKnowledge")
	session("date_repair") 	= Request.Form("txtDateRepair")
	session("date_completed") = Request.Form("txtDateCompleted")
	session("speed") 		= Request.Form("radSpeed")
	session("satisfaction") = Request.Form("radSatisfaction")
	session("charged") 		= Request.Form("radCharged")
	session("cost") 		= Request.Form("txtCost")
	session("comments") 	= Request.Form("txtComments")

	Set paraObj = cmdObj.CreateParameter("@find",AdInteger,AdParamInput,2,session("find"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@find_other",AdVarChar,AdParamInput,50,DB_NullToEmpty(session("find_other")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@service",AdInteger,AdParamInput,2,session("service"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@fixed",AdInteger,AdParamInput,2,session("fixed"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@location",AdInteger,AdParamInput,2,session("location"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@appearance",AdInteger,AdParamInput,2,session("appearance"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@attitude",AdInteger,AdParamInput,2,session("attitude"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@knowledge",AdInteger,AdParamInput,2,session("knowledge"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@date_repair",AdVarChar,AdParamInput,20,session("date_repair"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@date_completed",AdVarChar,AdParamInput,20,session("date_completed"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@speed",AdInteger,AdParamInput,2,session("speed"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@satisfaction",AdInteger,AdParamInput,2,session("satisfaction"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@charged",AdInteger,AdParamInput,2,session("charged"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@cost",AdVarChar,AdParamInput,8,DB_NullToEmpty(session("cost")))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@comments",AdVarChar,AdParamInput,120,session("comments"))
	cmdObj.Parameters.Append paraObj
	
    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
		
		response.write cmdObj.CommandText
        id = rs(0)
        set rs = nothing
    On error Goto 0
	
    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
        addSurvey = FALSE
        strMessageText = MessageText
		'strMessageText = err.description
    else
		addSurvey = TRUE
		Response.Redirect("thank-you.html")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)
	
    call CloseDataBase
end function
%>