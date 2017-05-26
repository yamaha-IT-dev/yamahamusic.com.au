<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsFile.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Delete Thumbnail</title>
</head>
<body>
<%
sub main
	dim intID, strThumbnail, strMessageText
	 
	intID 			= Trim(Request("id"))	
	strThumbnail 	= Trim(Request("thumbnail"))
	
	call deleteThumbnail(intID, strThumbnail)
end sub

call main
%>
<%= strMessageText %>
</body>