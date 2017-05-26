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
	strFilename 	= Server.HTMLEncode(Trim(Request("filename")))
	strThumbnail 	= Server.HTMLEncode(Trim(Request("thumbnail")))
	
	call deleteFiles(intID, strFilename, strThumbnail)
end sub

call main
%>
<%= strMessageText %>
</body>