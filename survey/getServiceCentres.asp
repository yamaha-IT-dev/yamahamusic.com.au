<!--#include file="../include/connection.asp " -->
<%
response.expires=-1

call OpenDataBase()

Dim strSQL
dim rs
dim intRecord

strSQL = "SELECT DISTINCT storename "	
strSQL = strSQL & " FROM tbl_users WHERE role_id = 3 ORDER BY storename"

set rs = server.CreateObject("ADODB.Recordset")
set rs = conn.execute(strSQL)

strDisplayList = ""

do while not rs.eof
	strDisplayList = strDisplayList & Trim(rs("storename")) & ","
	rs.movenext
loop

strDisplayList = left(strDisplayList,len(strDisplayList)-1)

response.write strDisplayList

call CloseDataBase
%>