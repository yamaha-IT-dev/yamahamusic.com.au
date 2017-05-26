<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsFile.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Delete Filename</title>
</head>
<body>
<%
sub main
	dim intID, strFilename, strMessageText
	 
	intID 			= Trim(Request("id"))
	strFilename 	= Trim(Request("filename"))
	
	call deleteFilename(intID, strFilename)
end sub

call main
%>
<%= strMessageText %>
</body>