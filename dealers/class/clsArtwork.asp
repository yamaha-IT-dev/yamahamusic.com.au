<%
function addArtwork(artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artTerms, artComments, artImages, artCreatedBy)
	dim strSQL
	
	call OpenDataBase()
		
	strSQL = "INSERT INTO tbl_connect_artwork (artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artTerms, artComments, artImages,  artCreatedBy) VALUES ("	
	strSQL = strSQL & "'" & artProjectName & "',"
	strSQL = strSQL & "'" & artMediaType & "',"
	strSQL = strSQL & "'" & artPublication & "',"
	strSQL = strSQL & "'" & artMediaName & "',"
	strSQL = strSQL & "'" & artMediaPhone & "',"
	strSQL = strSQL & "'" & artMediaEmail & "',"
	strSQL = strSQL & "CONVERT(datetime,'" & Trim(artDeadline) & "',103),"
	strSQL = strSQL & "CONVERT(datetime,'" & Trim(artAppearance) & "',103),"
	strSQL = strSQL & "'" & artAppearanceOther & "',"
	strSQL = strSQL & "'" & artPrinted & "',"
	strSQL = strSQL & "'" & artDelivery & "',"
	strSQL = strSQL & "'" & artType & "',"
	strSQL = strSQL & "'" & artColour & "',"
	strSQL = strSQL & "'" & artSize & "',"
	strSQL = strSQL & "'" & artWidth & "',"
	strSQL = strSQL & "'" & artHeight & "',"
	strSQL = strSQL & "'" & artPages & "',"
	strSQL = strSQL & "'" & artOrientation & "',"
	strSQL = strSQL & "'" & artAudience & "',"
	strSQL = strSQL & "'" & artTheme & "',"
	strSQL = strSQL & "'" & artMainColour & "',"
	strSQL = strSQL & "'" & artHeadline & "',"
	strSQL = strSQL & "'" & artFeature & "',"
	strSQL = strSQL & "'" & artProduct & "',"
	strSQL = strSQL & "'" & artTerms & "',"
	strSQL = strSQL & "'" & artComments & "',"
	strSQL = strSQL & "'" & artImages & "',"
	strSQL = strSQL & "'" & artCreatedBy & "')"
	
	'response.Write strSQL
	
	on error resume next	
	conn.Execute strSQL
	
	if err <> 0 then
		strMessageText = err.description
	else	
		response.Redirect("./")
	end if
	
	call CloseDataBase()
end function


function addConnectArtwork(artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artTerms, artComments, artImages, artLogo, artCreatedBy)
	Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spAddConnectArtwork"
    cmdObj.CommandType 			= AdCmdStoredProc    
	
	Set paraObj = cmdObj.CreateParameter("@artProjectName",AdVarChar,AdParamInput,80,artProjectName)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artMediaType",AdVarChar,AdParamInput,80,artMediaType)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artPublication",AdVarChar,AdParamInput,80,artPublication)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artMediaName",AdVarChar,AdParamInput,80,DB_NullToEmpty(artMediaName))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artMediaPhone",AdVarChar,AdParamInput,12,DB_NullToEmpty(artMediaPhone))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artMediaEmail",AdVarChar,AdParamInput,60,DB_NullToEmpty(artMediaEmail))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artDeadline",AdVarChar,AdParamInput,20,artDeadline)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artAppearance",AdVarChar,AdParamInput,20,artAppearance)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artAppearanceOther",AdVarChar,AdParamInput,80,DB_NullToEmpty(artAppearanceOther))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artPrinted",AdInteger,AdParamInput,2,artPrinted)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artDelivery",AdInteger,AdParamInput,2,artDelivery)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artType",AdVarChar,AdParamInput,20,artType)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artColour",AdVarChar,AdParamInput,20,artColour)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artSize",AdVarChar,AdParamInput,20,artSize)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artWidth",AdInteger,AdParamInput,2,DB_NullToEmpty(artWidth))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artHeight",AdInteger,AdParamInput,2,DB_NullToEmpty(artHeight))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artPages",AdInteger,AdParamInput,2,artPages)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artOrientation",AdInteger,AdParamInput,2,artOrientation)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artAudience",AdVarChar,AdParamInput,80,artAudience)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artTheme",AdVarChar,AdParamInput,80,artTheme)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artMainColour",AdVarChar,AdParamInput,80,artMainColour)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artHeadline",AdVarChar,AdParamInput,80,artHeadline)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artFeature",AdVarChar,AdParamInput,80,artFeature)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artProduct",AdVarChar,AdParamInput,80,artProduct)
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("@artTerms",AdVarChar,AdParamInput,120,artTerms)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artComments",AdVarChar,AdParamInput,120,DB_NullToEmpty(artComments))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artImages",AdInteger,AdParamInput,2,artImages)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artLogo",AdInteger,AdParamInput,2,artLogo)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@artCreatedBy",AdInteger,AdParamInput,2,artCreatedBy)
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute		
        id = rs(0)
        set rs = nothing
    On error Goto 0
	
	'response.Write cmdObj.Execute
	
    if CheckForSQLError(conn,"Add",MessageText) = TRUE then	
		strMessageText = err.description
        addRequest = FALSE
        'strMessageText = MessageText
    else
		addRequest = TRUE
		Response.Redirect("./")
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function updateConnectArtwork(artID, artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artTerms, artComments, artImages, artLogo, artCreatedBy)
    Dim cmdObj, paraObj

    call OpenDataBase

    Set cmdObj 					= Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection 	= conn
    cmdObj.CommandText 			= "spUpdateConnectArtwork"
    cmdObj.CommandType 			= AdCmdStoredProc

	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,4,artID)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artProjectName)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artMediaType)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artPublication)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,DB_NullToEmpty(artMediaName))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,12,DB_NullToEmpty(artMediaPhone))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,60,DB_NullToEmpty(artMediaEmail))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,artDeadline)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,artAppearance)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,DB_NullToEmpty(artAppearanceOther))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artPrinted)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artDelivery)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,artType)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,artColour)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,20,artSize)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,DB_NullToEmpty(artWidth))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,DB_NullToEmpty(artHeight))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artPages)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artOrientation)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artAudience)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artTheme)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artMainColour)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artHeadline)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artFeature)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,80,artProduct)
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,120,artTerms)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdVarChar,AdParamInput,120,DB_NullToEmpty(artComments))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artImages)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artLogo)
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter(,AdInteger,AdParamInput,2,artCreatedBy)
	cmdObj.Parameters.Append paraObj

    On Error Resume Next
    cmdObj.Execute
	
	'response.write "COMMAND: " & cmdObj

	'response.Write cmdObj.Execute
    On error Goto 0

    if CheckForSQLError(conn,"Update",strMessageText) = TRUE then
	    updateRequest = FALSE
		strMessageText = err.description
    else
		'Session("user_token") = ""
		'Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
        strMessageText = "<div class=""alert alert-success""><img src=""../images/icon_check.png""> Artwork request has been updated.</div>"
		updateRequest = TRUE
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function

function getArtwork(intID, strCreatedBy)
    dim strSQL
    dim rs

    call OpenDataBase()

	strSQL = "EXEC spGetConnectArtwork " & intID & "," & strCreatedBy

	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    if not DB_RecSetIsEmpty(rs) Then
		session("artID")			= Trim(rs("artID"))		
		session("artProjectName")	= Trim(rs("artProjectName"))
		session("artMediaType")		= Trim(rs("artMediaType"))		
        session("artPublication")	= Trim(rs("artPublication"))
        session("artMediaName")     = Trim(rs("artMediaName"))
        session("artMediaPhone")    = Trim(rs("artMediaPhone"))
        session("artMediaEmail")    = Trim(rs("artMediaEmail"))
		session("artDeadline")      = Trim(rs("artDeadline"))
		session("artAppearance")    = Trim(rs("artAppearance"))
		session("artAppearanceOther") = Trim(rs("artAppearanceOther"))
		session("artPrinted")      	= Trim(rs("artPrinted"))
		session("artDelivery")      = Trim(rs("artDelivery"))
		session("artType")      	= Trim(rs("artType"))
		session("artColour")      	= Trim(rs("artColour"))
		session("artSize")      	= Trim(rs("artSize"))
		session("artWidth")      	= Trim(rs("artWidth"))
		session("artHeight")      	= Trim(rs("artHeight"))
		session("artPages")      	= Trim(rs("artPages"))
		session("artOrientation")   = Trim(rs("artOrientation"))
		session("artAudience")      = Trim(rs("artAudience"))
		session("artTheme")      	= Trim(rs("artTheme"))
		session("artMainColour")    = Trim(rs("artMainColour"))
		session("artHeadline")      = Trim(rs("artHeadline"))
		session("artFeature")      	= Trim(rs("artFeature"))
		session("artProduct")      	= Trim(rs("artProduct"))
		session("artTerms")      	= Trim(rs("artTerms"))		
		session("artComments")      = Trim(rs("artComments"))
		session("artImages")      	= Trim(rs("artImages"))
		session("artLogo")      	= Trim(rs("artLogo"))        
		session("artStatus")		= Trim(rs("artStatus"))
		session("artDateCreated")	= Trim(rs("artDateCreated"))
		session("artCreatedBy")   	= Trim(rs("artCreatedBy"))		
		session("artDateModified")	= Trim(rs("artDateModified"))
		session("artModifiedBy")   	= Trim(rs("artModifiedBy"))			
		session("artDateApproved")	= Trim(rs("artDateApproved"))
		session("artApprovedBy")   	= Trim(rs("artApprovedBy"))
		
		if Trim(session("yma_userid")) = Trim(session("artCreatedBy")) then
			session("artwork_not_found") 	= "FALSE"
		else
			session("artwork_not_found") 	= "TRUE"
		end if
	else
		session("artwork_not_found") 		= "TRUE"
    end if

    call CloseDataBase()
end function
%>