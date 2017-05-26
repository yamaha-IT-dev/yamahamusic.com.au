<%
function addCoop
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddCoop"
    cmdObj.CommandType 			= AdCmdStoredProc    
	
	Set paraObj = cmdObj.CreateParameter("@coopName",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtName"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopBudget",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtBudget"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopExclusive",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboExclusive"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopPercentage",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtPercentage"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopStockAvaiability",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboStockAvailability"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopAdvertising",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("chkAdvertising"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopSignage",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("chkSignage"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopPromotionalMaterial",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("chkPromotionalMaterial"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopEvent",AdVarChar,AdParamInput,50,Server.HTMLEncode(Trim(Request("cboEvent"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopOutlet",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtOutlet"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopAdSize",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtAdSize"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopNoPlacement",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtNoPlacement"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopDatePlacement",AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtDatePlacement"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMediaSupplier",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMediaSupplier"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMediaArtwork",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMediaArtwork"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopArtworkDeadline",AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtArtworkDeadline"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopSignagePlacement",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtSignagePlacement"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopSignageDescription",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtSignageDescription"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopSignageSupplier",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboSignageSupplier"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopSignageArtwork",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboSignageArtwork"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopDateInstallation",AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtDateInstallation"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialDescription",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtMaterialDescription"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialSize",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtMaterialSize"))))
	cmdObj.Parameters.Append paraObj		
	Set paraObj = cmdObj.CreateParameter("@coopMaterialNoPage",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtMaterialNoPage"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialQty",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtMaterialQty"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialDistribute",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtMaterialDistribute"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialSupplier",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMaterialSupplier"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialArtwork",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMaterialArtwork"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMaterialDeadline",AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtMaterialDeadline"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopEventOutline",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtEventOutline"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopVenue",AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtVenue"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopEventDate",AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtEventDate"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopNoAttendee",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtNoAttendee"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopMarketingSupport",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMarketingSupport"))))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("@coopYamahaArtist",AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboYamahaArtist"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@coopCreatedBy",AdInteger,AdParamInput,2,Trim(Session("yma_userid")))
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
        id = rs(0)
        set rs = nothing
    On error Goto 0
	
    if CheckForSQLError(conn,"Add",MessageText) = TRUE then	
		strMessageText = err.description
        addRequest = FALSE
    else
		addRequest = TRUE
		Response.Redirect("coop.asp")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function updateCoop
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spUpdateCoop"
    cmdObj.CommandType 			= AdCmdStoredProc
	
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,reqID)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtName"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtBudget"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboExclusive"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtPercentage"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboStockAvailability"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("chkAdvertising"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("chkSignage"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("chkPromotionalMaterial"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,50,Server.HTMLEncode(Trim(Request("cboEvent"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtOutlet"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtAdSize"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtNoPlacement"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtDatePlacement"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMediaSupplier"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMediaArtwork"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtArtworkDeadline"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtSignagePlacement"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtSignageDescription"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboSignageSupplier"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboSignageArtwork"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtDateInstallation"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtMaterialDescription"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtMaterialSize"))))
	cmdObj.Parameters.Append paraObj		
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtMaterialNoPage"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtMaterialQty"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtMaterialDistribute"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMaterialSupplier"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMaterialArtwork"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtMaterialDeadline"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtEventOutline"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtVenue"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,Server.HTMLEncode(Trim(Request("txtEventDate"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("txtNoAttendee"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboMarketingSupport"))))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Server.HTMLEncode(Trim(Request("cboYamahaArtist"))))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,Trim(Session("yma_userid")))
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute

    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
	    updateRequest = FALSE
    else
		'Session("user_token") = ""
		strMessageText = "<div class=""alert alert-success""><img src=""images/icon_check.png""> Coop has been updated.</div>"
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
        
		updateRequest = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function getCoop(intID, strCreatedBy)
    dim strSQL
    dim rs

    call OpenDataBase()

	strSQL = "EXEC spGetCoop " & intID & "," & strCreatedBy

	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
		Session("coopID")					= Trim(rs("coopID"))
		Session("coopName")					= Trim(rs("coopName"))
		Session("coopBudget")				= Trim(rs("coopBudget"))
		Session("coopExclusive")			= Trim(rs("coopExclusive"))
        Session("coopPercentage")			= Trim(rs("coopPercentage"))
        Session("coopStockAvailability") 	= Trim(rs("coopStockAvailability"))
        Session("coopAdvertising")  		= Trim(rs("coopAdvertising"))
        Session("coopSignage")      		= Trim(rs("coopSignage"))
        Session("coopPromotionalMaterial") 	= Trim(rs("coopPromotionalMaterial"))
        Session("coopEvent")				= Trim(rs("coopEvent"))
    	Session("coopOutlet") 				= Trim(rs("coopOutlet"))
		Session("coopAdSize")				= Trim(rs("coopAdSize"))
		Session("coopNoPlacement") 			= Trim(rs("coopNoPlacement"))
		Session("coopDatePlacement")		= Trim(rs("coopDatePlacement"))
		Session("coopMediaSupplier")		= Trim(rs("coopMediaSupplier"))
		Session("coopMediaArtwork")			= Trim(rs("coopMediaArtwork"))
		Session("coopArtworkDeadline") 		= Trim(rs("coopArtworkDeadline"))
		Session("coopSignagePlacement")		= Trim(rs("coopSignagePlacement"))
		Session("coopSignageDescription")	= Trim(rs("coopSignageDescription"))
		Session("coopSignageSupplier")		= Trim(rs("coopSignageSupplier"))
		Session("coopSignageArtwork")		= Trim(rs("coopSignageArtwork"))
		Session("coopDateInstallation")		= Trim(rs("coopDateInstallation"))
		Session("coopMaterialDescription")	= Trim(rs("coopMaterialDescription"))
		Session("coopMaterialSize")			= Trim(rs("coopMaterialSize"))
		Session("coopMaterialNoPage")		= Trim(rs("coopMaterialNoPage"))
		Session("coopMaterialQty")			= Trim(rs("coopMaterialQty"))
		Session("coopMaterialDistribute")	= Trim(rs("coopMaterialDistribute"))
		Session("coopMaterialSupplier")		= Trim(rs("coopMaterialSupplier"))
		Session("coopMaterialArtwork")		= Trim(rs("coopMaterialArtwork"))
		Session("coopMaterialDeadline")		= Trim(rs("coopMaterialDeadline"))
		Session("coopEventOutline")			= Trim(rs("coopEventOutline"))
		Session("coopVenue")				= Trim(rs("coopVenue"))
		Session("coopEventDate")			= Trim(rs("coopEventDate"))
		Session("coopNoAttendee")			= Trim(rs("coopNoAttendee"))
		Session("coopMarketingSupport")		= Trim(rs("coopMarketingSupport"))
		Session("coopYamahaArtist")			= Trim(rs("coopYamahaArtist"))		
		Session("coopComments")				= Trim(rs("coopComments"))
		Session("coopStatus")				= Trim(rs("coopStatus"))
		Session("coopDateCreated")			= Trim(rs("coopDateCreated"))
		Session("coopCreatedBy")   			= Trim(rs("coopCreatedBy"))
		Session("coopDateModified")			= Trim(rs("coopDateModified"))
		Session("coopModifiedBy")   		= Trim(rs("coopModifiedBy"))
		Session("coopDateApproved")			= Trim(rs("coopDateApproved"))
		Session("coopApprovedBy")   		= Trim(rs("coopApprovedBy"))
		Session("coopApprovalCode") 		= Trim(rs("coopApprovalCode"))
		
		if Trim(session("yma_userid")) = Trim(Session("coopCreatedBy")) then
			session("coop_not_found") = "FALSE"
		else
			session("coop_not_found") = "TRUE"
		end if
	else
		session("coop_not_found") = "TRUE"
    end if

    call CloseDataBase()
end function
%>