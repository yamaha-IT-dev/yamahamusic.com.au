<%@ Language=VBScript %>
<!--#include file="../../include/connection.asp " -->
<%
dim rs
dim strSQL

Call OpenDataBase()

set rs=server.createobject("ADODB.recordset")

strSQL = "SELECT P.*, D.prod_weight, D.prod_width, D.prod_height, D.prod_depth, D.prod_volume, D.ean_code "
strSQL = strSQL & "	FROM tbl_product P "
strSQL = strSQL & "		LEFT JOIN tbl_product_detail D ON P.prod_code = D.prod_code "
strSQL = strSQL & "	WHERE "
strSQL = strSQL & "		(P.prod_code LIKE '%" & session("connect_product_search") & "%' "
strSQL = strSQL & "			OR P.prod_name LIKE '%" & session("connect_product_search") & "%' "
strSQL = strSQL & "			OR P.prod_sub_category LIKE '%" & session("connect_product_search") & "%' "
strSQL = strSQL & "			OR P.prod_short_description LIKE '%" & session("connect_product_search") & "%' "
strSQL = strSQL & "			OR P.prod_long_description LIKE '%" & session("connect_product_search") & "%' "
strSQL = strSQL & "			OR D.ean_code LIKE '%" & session("connect_product_search") & "%') "
strSQL = strSQL & "		AND P.prod_marketing_approval = 1 AND P.prod_discontinued = 0 "
strSQL = strSQL & "		AND P.prod_category LIKE '%" & session("connect_product_category") & "%' "
strSQL = strSQL & "	ORDER BY P.prod_category, P.prod_sub_category, P.prod_series, P.prod_code "

rs.open strSQL,conn,1,3

Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-Disposition", "attachment; filename=yamaha-product-list.xls"

if rs.eof <> true then
    Response.Write "<meta charset=utf-8><table border=1>"
    Response.Write "<tr>"
    Response.Write "<td><strong>Category</strong></td>"
    Response.Write "<td><strong>Sub category</strong></td>"
    Response.Write "<td><strong>Series</strong></td>"
    Response.Write "<td><strong>Code</strong></td>"
    Response.Write "<td><strong>Name</strong></td>"
    Response.Write "<td><strong>Short description</strong></td>"
    Response.Write "<td><strong>Long description</strong></td>"
    Response.Write "<td><strong>RRP inc GST</strong></td>"
    Response.Write "<td><strong>Status</strong></td>"
    Response.Write "<td><strong>Weight (kg)</strong></td>"
    Response.Write "<td><strong>Width (cm)</strong></td>"
    Response.Write "<td><strong>Height (cm)</strong></td>"
    Response.Write "<td><strong>Depth (cm)</strong></td>"
    Response.Write "<td><strong>Volume (m3)</strong></td>"
    Response.Write "<td><strong>EAN</strong></td>"
    Response.Write "</tr>"
    while not rs.eof
        Response.Write "<tr>"
        Response.Write "<td>" & rs.fields("prod_category") & "</td>"
        Response.Write "<td>" & rs.fields("prod_sub_category") & "</td>"
        Response.Write "<td>" & rs.fields("prod_series") & "</td>"
        if rs.fields("prod_category") = "PAISTE" then
            Response.Write "<td>=""" & CStr(rs.fields("prod_code")) & """</td>"
        else
            Response.Write "<td>" & rs.fields("prod_code") & "</td>"
        end if
        Response.Write "<td>" & rs.fields("prod_name") & "</td>"
        Response.Write "<td>" & rs.fields("prod_short_description") & "</td>"
        Response.Write "<td>" & rs.fields("prod_long_description") & "</td>"
        Response.Write "<td>" & rs.fields("prod_rrp") & "</td>"
        Response.Write "<td>" & rs.fields("prod_status") & "</td>"
        Response.Write "<td>" & rs.fields("prod_weight") & "</td>"
        Response.Write "<td>" & rs.fields("prod_width") & "</td>"
        Response.Write "<td>" & rs.fields("prod_height") & "</td>"
        Response.Write "<td>" & rs.fields("prod_depth") & "</td>"
        Response.Write "<td>" & rs.fields("prod_volume") & "</td>"
        Response.Write "<td>" & rs.fields("ean_code") & "</td>"
        Response.Write "</tr>"
        rs.movenext
    wend
    Response.Write "</table>"
end if

Call CloseDataBase()
%>