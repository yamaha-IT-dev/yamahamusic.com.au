<%
function deleteFiles(intID, strFilename, strThumbnail)
	dim fs, filename, ts, thumb, strMessageText
	set fs = Server.CreateObject("Scripting.FileSystemObject")
	set ts = Server.CreateObject("Scripting.FileSystemObject")
	
	set filename  	= fs.GetFile(Server.MapPath("./images/dealerex/" & strFilename))
	set thumb  		= ts.GetFile(Server.MapPath("./images/dealerex/" & strThumbnail))
	
	filename.Delete
	thumb.Delete
	
	set f = nothing
	set fs = nothing
	set t = nothing
	set ts = nothing
	
	On Error Resume Next
	
	if err <> 0 then
		strMessageText = err.description
	else
		call deleteResource(intID)
	end if 
end function

function deleteFilename(intID, strFilename)
	dim fs, filename, strMessageText
	set fs = Server.CreateObject("Scripting.FileSystemObject")		
	set filename = fs.GetFile(Server.MapPath("./images/dealerex/" & strFilename))
	
	filename.Delete
	
	set f = nothing
	set fs = nothing
	
	On Error Resume Next
	
	if err <> 0 then
		strMessageText = err.description
	else
		call deleteResource(intID)
	end if 
end function

function deleteThumbnail(intID, strThumbnail)
	dim ts, thumb, strMessageText
	
	set ts = Server.CreateObject("Scripting.FileSystemObject")
	set thumb  		= ts.GetFile(Server.MapPath("./images/dealerex/" & strThumbnail))
	
	thumb.Delete
	
	set t  = nothing
	set ts = nothing
	
	On Error Resume Next
	
	if err <> 0 then
		strMessageText = err.description
	else
		call deleteResource(intID)
	end if 
end function

function deleteResource(intID)
	dim rs, strSQL, strMessageText
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic
			
	strSQL = "DELETE FROM ymadex_resource WHERE id = " & intID
	
	rs.Open strSQL, conn
	
	Set rs = nothing
	
	if err <> 0 then
		strMessageText = err.description
	else
		Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
	end if
	
    call CloseDataBase()
end function
%>