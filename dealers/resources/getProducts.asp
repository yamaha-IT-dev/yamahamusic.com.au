<!--#include file="../../include/connection.asp " -->
<%
response.expires=-1

call OpenDataBase()

Dim strSQL
dim rs
dim intRecord

strSQL = "SELECT DISTINCT prod_code "	
strSQL = strSQL & " FROM tbl_product_detail ORDER BY prod_code"

set rs = server.CreateObject("ADODB.Recordset")
set rs = conn.execute(strSQL)

strDisplayList = ""

do while not rs.eof
	strDisplayList = strDisplayList & Trim(rs("prod_code")) & ","
	rs.movenext
loop

strDisplayList = left(strDisplayList,len(strDisplayList)-1)

response.write strDisplayList

call CloseDataBase
%>