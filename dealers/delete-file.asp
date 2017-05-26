<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsFile.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Delete File</title>
</head>
<body>
<%
sub main
	dim intID, strFilename, strThumbnail, strMessageText
	 
	intID 			= Trim(Request("id"))
	strFilename 	= Trim(Request("filename"))
	strThumbnail 	= Trim(Request("thumbnail"))
	
	call deleteFiles(intID, strFilename, strThumbnail)
	'strFilename = Replace(strFilename,"&","%26")
	'Response.write Server.MapPath("./images/dealerex/" & strFilename)
end sub

call main
%>
<%= strMessageText %>
</body>