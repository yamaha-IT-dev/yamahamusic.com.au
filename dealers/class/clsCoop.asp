<%
function addCoop(coopName, coopBudget, coopExclusive, coopPercentage, coopStockAvailability, coopAdvertising, coopSignage, coopPromotionalMaterial, coopEvent, coopOutlet, coopAdSize, coopNoPlacement, coopDatePlacement, coopMediaSupplier, coopMediaArtwork, coopArtworkDeadline, coopSignagePlacement, coopSignageDescription, coopSignageSupplier, coopSignageArtwork, coopDateInstallation, coopMaterialDescription, coopMaterialSize, coopMaterialNoPage, coopMaterialQty, coopMaterialDistribute, coopMaterialSupplier, coopMaterialArtwork, coopMaterialDeadline, coopEventOutline, coopVenue, coopEventDate, coopNoAttendee, coopMarketingSupport, coopYamahaArtist, coopCreatedBy)
  Dim cmdObj, paraObj

  call OpenDataBase

  Set cmdObj                = Server.CreateObject("ADODB.Command")
  cmdObj.ActiveConnection   = conn
  cmdObj.CommandText        = "spAddCoop"
  cmdObj.CommandType        = AdCmdStoredProc

  Set paraObj = cmdObj.CreateParameter("@coopName",AdVarChar,AdParamInput,80,coopName)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopBudget",AdVarChar,AdParamInput,200,coopBudget)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopExclusive",AdInteger,AdParamInput,2,coopExclusive)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopPercentage",AdInteger,AdParamInput,2,coopPercentage)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopStockAvailability",AdInteger,AdParamInput,2,coopStockAvailability)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopAdvertising",AdVarChar,AdParamInput,80,coopAdvertising)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopSignage",AdVarChar,AdParamInput,80,coopSignage)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopPromotionalMaterial",AdVarChar,AdParamInput,80,coopPromotionalMaterial)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopEvent",AdVarChar,AdParamInput,50,coopEvent)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopOutlet",AdVarChar,AdParamInput,80,coopOutlet)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopAdSize",AdVarChar,AdParamInput,80,coopAdSize)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopNoPlacement",AdVarChar,AdParamInput,5,coopNoPlacement)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopDatePlacement",AdVarChar,AdParamInput,20,coopDatePlacement)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMediaSupplier",AdInteger,AdParamInput,2,coopMediaSupplier)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMediaArtwork",AdInteger,AdParamInput,2,coopMediaArtwork)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopArtworkDeadline",AdVarChar,AdParamInput,20,coopArtworkDeadline)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopSignagePlacement",AdVarChar,AdParamInput,80,coopSignagePlacement)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopSignageDescription",AdVarChar,AdParamInput,80,coopSignageDescription)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopSignageSupplier",AdInteger,AdParamInput,2,coopSignageSupplier)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopSignageArtwork",AdInteger,AdParamInput,2,coopSignageArtwork)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopDateInstallation",AdVarChar,AdParamInput,20,coopDateInstallation)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialDescription",AdVarChar,AdParamInput,80,coopMaterialDescription)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialSize",AdVarChar,AdParamInput,80,coopMaterialSize)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialNoPage",AdVarChar,AdParamInput,5,coopMaterialNoPage)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialQty",AdVarChar,AdParamInput,5,coopMaterialQty)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialDistribute",AdVarChar,AdParamInput,80,coopMaterialDistribute)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialSupplier",AdInteger,AdParamInput,2,coopMaterialSupplier)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialArtwork",AdInteger,AdParamInput,2,coopMaterialArtwork)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMaterialDeadline",AdVarChar,AdParamInput,20,coopMaterialDeadline)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopEventOutline",AdVarChar,AdParamInput,80,coopEventOutline)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopVenue",AdVarChar,AdParamInput,80,coopVenue)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopEventDate",AdVarChar,AdParamInput,20,coopEventDate)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopNoAttendee",AdVarChar,AdParamInput,5,coopNoAttendee)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopMarketingSupport",AdInteger,AdParamInput,2,coopMarketingSupport)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopYamahaArtist",AdInteger,AdParamInput,2,coopYamahaArtist)
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter("@coopCreatedBy",AdInteger,AdParamInput,2,coopCreatedBy)
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

    Dim JMail
    Set JMail = CreateObject("JMail.SMTPMail")

    JMail.ServerAddress   = "smtp.bne.server-mail.com"
    JMail.Sender          = "Marketing-AUS@music.yamaha.com"
    JMail.Subject         = "[Yamaha Connect] New Coop Request"
    JMail.AddRecipient("jaclyn.williams@music.yamaha.com")
    JMail.AddRecipient("dion.durante@music.yamaha.com")
    JMail.Body            = "G'day!" & vbCrLf _
                          & "" & vbCrLf _
                          & "A new coop has been submitted by " & session("user_firstname") & " " & session("user_lastname") & vbCrLf _
                          & "" & vbCrLf _
                          & "Project name: " & Trim(Request("txtName")) & vbCrLf _
                          & "Budget: " & Trim(Request("txtBudget")) & vbCrLf _
                          & "" & vbCrLf _
                          & "For more details: http://172.29.64.7:78/list_coop.asp" & vbCrLf _
                          & "" & vbCrLf _
                          & "This is an automated email. Please do not reply to this address."
    JMail.Execute

    set JMail = nothing
    Response.Redirect("./")
  end if

  Call DB_closeObject(paraObj)
  Call DB_closeObject(cmdObj)

  call CloseDataBase
end function

function updateCoop
  Dim cmdObj, paraObj

  call OpenDataBase

  Set cmdObj                = Server.CreateObject("ADODB.Command")
  cmdObj.ActiveConnection   = conn
  cmdObj.CommandText        = "spUpdateCoop"
  cmdObj.CommandType        = AdCmdStoredProc

  Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,Server.URLEncode(Request("id")))
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
  Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtAdvertising"))))
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtSignage"))))
  cmdObj.Parameters.Append paraObj
  Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,Server.HTMLEncode(Trim(Request("txtPromotionalMaterial"))))
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
    strMessageText = "<div class=""alert alert-success""><img src=""../images/icon_check.png""> Coop Request has been updated.</div>"

    updateRequest = TRUE
  end if

  Call DB_closeObject(paraObj)
  Call DB_closeObject(cmdObj)

  Call CloseDataBase
end function

function getCoop(intID, strCreatedBy)
  dim strSQL
  dim rs

  call OpenDataBase()

  strSQL = "EXEC spGetCoop " & intID & "," & strCreatedBy

  set rs = server.CreateObject("ADODB.Recordset")
  set rs = conn.execute(strSQL)

  if not DB_RecSetIsEmpty(rs) Then
    Session("coopID")                     = Trim(rs("coopID"))
    Session("coopName")                   = Trim(rs("coopName"))
    Session("coopBudget")                 = Trim(rs("coopBudget"))
    Session("coopExclusive")              = Trim(rs("coopExclusive"))
    Session("coopPercentage")             = Trim(rs("coopPercentage"))
    Session("coopStockAvailability")      = Trim(rs("coopStockAvailability"))
    Session("coopAdvertising")            = Trim(rs("coopAdvertising"))
    Session("coopSignage")                = Trim(rs("coopSignage"))
    Session("coopPromotionalMaterial")    = Trim(rs("coopPromotionalMaterial"))
    Session("coopEvent")                  = Trim(rs("coopEvent"))
    Session("coopOutlet")                 = Trim(rs("coopOutlet"))
    Session("coopAdSize")                 = Trim(rs("coopAdSize"))
    Session("coopNoPlacement")            = Trim(rs("coopNoPlacement"))
    Session("coopDatePlacement")          = Trim(rs("coopDatePlacement"))
    Session("coopMediaSupplier")          = Trim(rs("coopMediaSupplier"))
    Session("coopMediaArtwork")           = Trim(rs("coopMediaArtwork"))
    Session("coopArtworkDeadline")        = Trim(rs("coopArtworkDeadline"))
    Session("coopSignagePlacement")       = Trim(rs("coopSignagePlacement"))
    Session("coopSignageDescription")     = Trim(rs("coopSignageDescription"))
    Session("coopSignageSupplier")        = Trim(rs("coopSignageSupplier"))
    Session("coopSignageArtwork")         = Trim(rs("coopSignageArtwork"))
    Session("coopDateInstallation")       = Trim(rs("coopDateInstallation"))
    Session("coopMaterialDescription")    = Trim(rs("coopMaterialDescription"))
    Session("coopMaterialSize")           = Trim(rs("coopMaterialSize"))
    Session("coopMaterialNoPage")         = Trim(rs("coopMaterialNoPage"))
    Session("coopMaterialQty")            = Trim(rs("coopMaterialQty"))
    Session("coopMaterialDistribute")     = Trim(rs("coopMaterialDistribute"))
    Session("coopMaterialSupplier")       = Trim(rs("coopMaterialSupplier"))
    Session("coopMaterialArtwork")        = Trim(rs("coopMaterialArtwork"))
    Session("coopMaterialDeadline")       = Trim(rs("coopMaterialDeadline"))
    Session("coopEventOutline")           = Trim(rs("coopEventOutline"))
    Session("coopVenue")                  = Trim(rs("coopVenue"))
    Session("coopEventDate")              = Trim(rs("coopEventDate"))
    Session("coopNoAttendee")             = Trim(rs("coopNoAttendee"))
    Session("coopMarketingSupport")       = Trim(rs("coopMarketingSupport"))
    Session("coopYamahaArtist")           = Trim(rs("coopYamahaArtist"))
    Session("coopComments")               = Trim(rs("coopComments"))
    Session("coopStatus")                 = Trim(rs("coopStatus"))
    Session("coopDateCreated")            = Trim(rs("coopDateCreated"))
    Session("coopCreatedBy")              = Trim(rs("coopCreatedBy"))
    Session("coopDateModified")           = Trim(rs("coopDateModified"))
    Session("coopModifiedBy")             = Trim(rs("coopModifiedBy"))
    Session("coopDateApproved")           = Trim(rs("coopDateApproved"))
    Session("coopApprovedBy")             = Trim(rs("coopApprovedBy"))
    Session("coopApprovalCode")           = Trim(rs("coopApprovalCode"))

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

sub updateCoopRequest
  dim strSQL

  Call OpenDataBase()

  strSQL = "UPDATE tbl_coop SET "
  strSQL = strSQL & "coopName                 = '" & Server.HTMLEncode(Trim(Request(txtName))) & "',"
  strSQL = strSQL & "coopBudget               = '" & Server.HTMLEncode(Trim(Request(txtBudget))) & "',"
  strSQL = strSQL & "coopExclusive            = '" & Server.HTMLEncode(Trim(Request(cboExclusive))) & "',"
  strSQL = strSQL & "coopPercentage           = '" & Server.HTMLEncode(Trim(Request(txtPercentage))) & "',"
  strSQL = strSQL & "coopStockAvailability    = '" & Server.HTMLEncode(Trim(Request(cboStockAvailability))) & "',"
  strSQL = strSQL & "coopAdvertising          = '" & Server.HTMLEncode(Trim(Request(txtAdvertising))) & "',"
  strSQL = strSQL & "coopSignage              = '" & Server.HTMLEncode(Trim(Request(txtSignage))) & "',"
  strSQL = strSQL & "coopPromotionalMaterial  = '" & Server.HTMLEncode(Trim(Request(txtPromotionalMaterial))) & "',"
  strSQL = strSQL & "coopEvent                = '" & Server.HTMLEncode(Trim(Request(cboEvent))) & "',"
  strSQL = strSQL & "coopOutlet               = '" & Server.HTMLEncode(Trim(Request(cboOutlet))) & "',"
  strSQL = strSQL & "coopAdSize               = '" & Server.HTMLEncode(Trim(Request(txtAdSize))) & "',"
  strSQL = strSQL & "coopNoPlacement          = '" & Server.HTMLEncode(Trim(Request(txtNoPlacement))) & "',"
  strSQL = strSQL & "coopDatePlacement        = '" & Server.HTMLEncode(Trim(Request(txtDatePlacement))) & "',"
  strSQL = strSQL & "coopMediaSupplier        = '" & Server.HTMLEncode(Trim(Request(cboMediaSupplier))) & "',"
  strSQL = strSQL & "coopMediaArtwork         = '" & Server.HTMLEncode(Trim(Request(cboMediaArtwork))) & "',"
  strSQL = strSQL & "coopArtworkDeadline      = '" & Server.HTMLEncode(Trim(Request(txtArtworkDeadline))) & "',"
  strSQL = strSQL & "coopSignagePlacement     = '" & Server.HTMLEncode(Trim(Request(txtSignagePlacement))) & "',"
  strSQL = strSQL & "coopSignageDescription   = '" & Server.HTMLEncode(Trim(Request(txtSignageDescription))) & "',"
  strSQL = strSQL & "coopSignageSupplier      = '" & Server.HTMLEncode(Trim(Request(cboSignageSupplier))) & "',"
  strSQL = strSQL & "coopSignageArtwork       = '" & Server.HTMLEncode(Trim(Request(cboSignageArtwork))) & "',"
  strSQL = strSQL & "coopDateInstallation     = '" & Server.HTMLEncode(Trim(Request(txtDateInstallation))) & "',"
  strSQL = strSQL & "coopMaterialDescription  = '" & Server.HTMLEncode(Trim(Request(txtMaterialDescription))) & "',"
  strSQL = strSQL & "coopMaterialSize         = '" & Server.HTMLEncode(Trim(Request(txtMaterialSize))) & "',"
  strSQL = strSQL & "coopMaterialNoPage       = '" & Server.HTMLEncode(Trim(Request(txtMaterialNoPage))) & "',"
  strSQL = strSQL & "coopMaterialQty          = '" & Server.HTMLEncode(Trim(Request(txtMaterialQty))) & "',"
  strSQL = strSQL & "coopMaterialDistribute   = '" & Server.HTMLEncode(Trim(Request(txtMaterialDistribute))) & "',"
  strSQL = strSQL & "coopMaterialSupplier     = '" & Server.HTMLEncode(Trim(Request(cboMaterialSupplier))) & "',"
  strSQL = strSQL & "coopMaterialArtwork      = '" & Server.HTMLEncode(Trim(Request(cboMaterialArtwork))) & "',"
  strSQL = strSQL & "coopMaterialDeadline     = '" & Server.HTMLEncode(Trim(Request(txtMaterialDeadline))) & "',"
  strSQL = strSQL & "coopEventOutline         = '" & Server.HTMLEncode(Trim(Request(txtEventOutline))) & "',"
  strSQL = strSQL & "coopVenue                = '" & Server.HTMLEncode(Trim(Request(txtVenue))) & "',"
  strSQL = strSQL & "coopEventDate            = '" & Server.HTMLEncode(Trim(Request(txtEventDate))) & "',"
  strSQL = strSQL & "coopNoAttendee           = '" & Server.HTMLEncode(Trim(Request(txtNoAttendee))) & "',"
  strSQL = strSQL & "coopMarketingSupport     = '" & Server.HTMLEncode(Trim(Request(cboMarketingSupport))) & "',"
  strSQL = strSQL & "coopYamahaArtist         = '" & Server.HTMLEncode(Trim(Request(cboYamahaArtist))) & "',"
  strSQL = strSQL & "coopModifiedBy           = '" & Session("yma_userid") & "',"
  strSQL = strSQL & "coopDateModified         = GetDate() WHERE coopID = " & Server.URLEncode(Request("id"))

  response.Write strSQL

  on error resume next
  conn.Execute strSQL

  if err <> 0 then
    strMessageText = err.description
  else
    strMessageText = "<div class=""notification_text""><img src=""../images/icon_check.png""> Coop Request has been updated.</div>"
  end if

  Call CloseDataBase()
end sub
%>