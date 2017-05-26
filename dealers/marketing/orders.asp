<%
dim strSection
strSection = "marketing"
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
<title>Marketing Resource Orders</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/justified-nav.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../../js/main.js"></script>
</head>
<body>
<%
sub displayOrder		
    dim strSQL
	
	dim intRecordCount
	
	dim iRecordCount
	iRecordCount = 0		
	
	dim strTodayDate	
	strTodayDate = FormatDateTime(Date())
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation 	= 3	'adUseClient
    rs.CursorType 		= 3		'adOpenStatic
	rs.PageSize 		= 90000
	
	strSQL = "SELECT O.*,R.name AS itemName, T.name AS typeName, C.title AS categoryName FROM tbl_connect_order O"
	strSQL = strSQL & "	INNER JOIN ymadex_resource R ON R.id = O.ordResourceID"
	strSQL = strSQL & "	INNER JOIN ymadex_resourcetype T ON T.id = R.typeid"
	strSQL = strSQL & "	INNER JOIN ymadex_category C ON C.id = R.categoryid"
	strSQL = strSQL & "	WHERE"	
	strSQL = strSQL & "		ordCreatedBy = '" & session("yma_userid") & "'"
	strSQL = strSQL & "	ORDER BY ordDateCreated DESC"
	
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
			strDisplayList = strDisplayList & "<td>" & rs("ordID") & "</td>"
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("ordDateCreated"),1) & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("typeName") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("categoryName") & "</td>"			
			strDisplayList = strDisplayList & "<td>" & rs("itemName") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("ordQty") & "</td>"			
			strDisplayList = strDisplayList & "<td>"
			if rs("ordWidth") = 0 then
				strDisplayList = strDisplayList & "-"
			else
				strDisplayList = strDisplayList & rs("ordWidth")
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>"
			if rs("ordHeight") = 0 then
				strDisplayList = strDisplayList & "-"
			else
				strDisplayList = strDisplayList & rs("ordHeight")
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>"
			Select Case trim(rs("ordOrientation"))
				case 1
					strDisplayList = strDisplayList & "Static"
				case 2
					strDisplayList = strDisplayList & "Animated"	
				case 0
					strDisplayList = strDisplayList & "-"
			end select
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td><font "
			Select Case trim(rs("ordStatus"))
				case 0
					strDisplayList = strDisplayList & "color=""green"">Dispatched"
				case 1
					strDisplayList = strDisplayList & "color=""blue"">Submitted"
				case 2
					strDisplayList = strDisplayList & "color=""orange"">Out of stock"
				case 3
					strDisplayList = strDisplayList & "color=""red"">No longer available"
			end select
			strDisplayList = strDisplayList & "</font></td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""10"" align=""center"">No orders found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr><td colspan=""10"" align=""center""><h2>Total: " & intRecordCount & "</h2></td></p>"
	
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
        <li><a href="./">Marketing</a></li>
        <li class="active">Your Orders</li>
      </ol>
      <div class="masthead">        
        <nav>
          <ul class="nav nav-justified">
            <li><a href="./">MARKETING MATERIALS</a></li>
            <li class="active"><a>YOUR ORDERS</a></li>            
          </ul>
        </nav>
      </div>      
      <h1>Your Orders</h1>
      </td>
  </tr>
  <tr>
    <td><table class="table table-striped">
        <thead>
          <tr>
            <td>Order ID</td>
            <td>Date Requested</td>
            <td>Type</td>
            <td>Category</td>
            <td>Item Name</td>
            <td>Qty</td>
            <td>Width</td>
            <td>Height</td>
            <td>Orientation</td>
            <td>Status</td>
          </tr>
        </thead>
        <%= strDisplayList %>
      </table></td>
  </tr>
</table>
</body>
</html>