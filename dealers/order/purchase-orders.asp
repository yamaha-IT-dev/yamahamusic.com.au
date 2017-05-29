<%
dim strSection
strSection = "order"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsUser.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="../../js/html5shiv.js"></script>
  <script src="../../js/respond.js"></script>
<![endif]-->
<title>Purchase Orders</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/justified-nav.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%
sub displayOrder		
    dim strSQL
	
	dim intRecordCount
	
	dim iRecordCount
	iRecordCount = 0
	
	dim intTotal
	intTotal = 0	
	
	dim strTodayDate	
	strTodayDate = FormatDateTime(Date())
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation 	= 3	'adUseClient
    rs.CursorType 		= 3		'adOpenStatic
	rs.PageSize 		= 90000
	
	strSQL = "SELECT * FROM tbl_connect_po"	
	strSQL = strSQL & "	WHERE"	
	strSQL = strSQL & "		purCreatedBy = '" & session("yma_userid") & "'"
	strSQL = strSQL & "	ORDER BY purDateCreated DESC"
	
	'response.write "<font color=white>" strSQL & "</font><br>"
	
	rs.Open strSQL, conn
			
	intPageCount 		= rs.PageCount
	intRecordCount 		= rs.recordcount
		
    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then	
		For intRecord = 1 To rs.PageSize			
			if iRecordCount Mod 2 = 0 then
				strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
			else
				strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
			end if
			strDisplayList = strDisplayList & "<td>" & rs("purID") & "</td>"
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("purDateCreated"),1) & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("purModelNo") & "</td>"
			<!--
			strDisplayList = strDisplayList & "<td>" & FormatNumber(rs("purPrice")) & "</td>"
			-->
			strDisplayList = strDisplayList & "<td>" & rs("purQty") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("purOrderNo") & "</td>"
			strDisplayList = strDisplayList & "<td>" & FormatNumber(rs("purTotal")) & "</td>"				
			strDisplayList = strDisplayList & "<td><font "
			Select Case trim(rs("purStatus"))
				case 0
					strDisplayList = strDisplayList & "color=""green"">Completed"
				case 1
					strDisplayList = strDisplayList & "color=""blue"">Submitted"				
			end select
			strDisplayList = strDisplayList & "</font></td>"	
			strDisplayList = strDisplayList & "</tr>"
			'intTotal = intTotal + Cint(rs("purTotal"))
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""8"" align=""center"">No purchase orders found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr><td colspan=""8"" align=""center""><h2>Total: " & intRecordCount & "</h2>"
	'strDisplayList = strDisplayList & "<h1>Total: $" & FormatNumber(intTotal) & "<h1></td></tr>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin
	call displayOrder
end sub

call main

dim rs, intPageCount, intRecord, strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Order</a></li>
        <li class="active">Purchase Orders</li>
      </ol>
      <div class="masthead">        
        <nav>
          <ul class="nav nav-justified">
            <li><a href="./">NEW PURCHASE ORDER</a></li>
            <li class="active"><a>YOUR PURCHASE ORDERS</a></li> 
            <li><a href="backorder.asp">YOUR BACK ORDERS</a></li>           
          </ul>
        </nav>
      </div>      
      <h1>Your Purchase Orders</h1></td>
  </tr>
  <tr>
    <td><table class="table table-striped">
        <thead>
          <tr>
            <td>PO ID</td>
            <td>Date Requested</td>
            <td>Model No</td>
            <!--
			<td>Wholesale ex GST</td>
            -->
			<td>Qty</td>
            <td>Purchase Order No</td>
            <td>Total inc GST</td>
            <td>Status</td>
          </tr>
        </thead>
        <%= strDisplayList %>
      </table></td>
  </tr>
</table>
</body>
</html>