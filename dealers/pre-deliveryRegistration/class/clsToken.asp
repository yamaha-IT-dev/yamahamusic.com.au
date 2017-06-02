<!--#include file="../../include/md5.asp" -->
<%
'-----------------------------------------------
' Create a Unique Hashed Token
'-----------------------------------------------
Function createToken()
	dim TypeLib
    Set TypeLib = CreateObject("Scriptlet.TypeLib")
	session("user_token") = md5(Mid(TypeLib.Guid, 2, 25) & session.sessionID)
    Set TypeLib = Nothing
End Function
%>