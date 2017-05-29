<%
dim strSection
strSection = "order"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsPurchaseOrder.asp " -->
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
<title>New Purchase Order</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/justified-nav.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script>
function searchItem(){
    var strSearch 		= document.forms[0].txtSearch.value;
    document.location.href = '?type=search&txtSearch=' + strSearch;	
}
   
function resetSearch(){
	document.location.href = '?type=reset';
}

function validateOrder(theForm) {
	var reason = "";
	var blnSubmit = true;
			
	reason += validateNumeric(theForm.txtQty,"Qty");
	
	reason += validateEmptyField(theForm.txtOrderNo,"Purchase Order No");
	reason += validateSpecialCharacters(theForm.txtOrderNo,"Purchase Order No");
		
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.command.value = 'order';		
		return true;
    }
}
</script>
</head>
<body>
<%
sub setSearch
	select case trim(request("type"))
		case "reset" 
			session("po_search") 		= ""
			session("po_initial_page") 	= 1
		case "search"
			session("po_search") 		= server.htmlencode(trim(Request("txtSearch")))
			session("po_initial_page") 	= 1
	end select
end sub

sub displayStock
    dim strSQL
	
	dim iRecordCount
	iRecordCount = 0
	
	dim intRecordCount
	
	dim strTodayDate	
	strTodayDate = FormatDateTime(Date())
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic
	rs.PageSize = 200
	
	strSQL = "SELECT S.*, P.prod_predicted_avg, P.prod_stock_upper, P.prod_stock_lower FROM tbl_stock S "
	strSQL = strSQL & "	INNER JOIN tbl_product P ON stock_code = prod_code "
	strSQL = strSQL & "	WHERE "
	strSQL = strSQL & "		(stock_code LIKE '%" & session("po_search") & "%' "
	strSQL = strSQL & "			OR stock_description LIKE '%" & session("po_search") & "%')"
	strSQL = strSQL & "		AND prod_discontinued = '0' "
	'strSQL = strSQL & "	ORDER BY stock_code"
	
	'response.write strSQL & "<br>"
	
	rs.Open strSQL, conn
			
	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount
	
	Select Case Request("Action")
	    case "<<"
		    intpage = 1
			session("po_initial_page") = intpage
	    case "<"
		    intpage = Request("intpage") - 1
			session("po_initial_page") = intpage
			
			if session("po_initial_page") < 1 then session("po_initial_page") = 1
	    case ">"
		    intpage = Request("intpage") + 1
			session("po_initial_page") = intpage
			
			if session("po_initial_page") > intPageCount then session("po_initial_page") = IntPageCount
	    Case ">>"
		    intpage = intPageCount
			session("po_initial_page") = intpage	    
    end select

    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then
	
	    rs.AbsolutePage = session("po_initial_page")  
	
		For intRecord = 1 To rs.PageSize			
			if iRecordCount Mod 2 = 0 then
				strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
			else
				strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
			end if
			strDisplayList = strDisplayList & "<form name=""form_order"" id=""form_order"" method=""post"" onsubmit=""return validateOrder(this)"">"
			strDisplayList = strDisplayList & "<td>" & rs("stock_code") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("stock_description") & "</td>"
			strDisplayList = strDisplayList & "<td>" & FormatNumber(rs("stock_rrp")) & "</td>"
			strDisplayList = strDisplayList & "<td>"
			if not isnull(rs("prod_predicted_avg")) then
				if Cint(rs("stock_availability")) > (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_lower"))) then
					if Cint(rs("stock_availability")) <= (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_upper"))) then
						if Cint(rs("stock_intransit")) >= 1 then
							if Cint(rs("stock_intransit")) > (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_upper"))) then
								strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, good stock arriving soon"
							else
								strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, " & rs("stock_intransit") & " arriving soon"
							end if
						else
							strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now"
						end if
					else	
						if Cint(rs("stock_availability")) > 1 then 
							strDisplayList = strDisplayList & "<font color=green>Good stock available</font>"
						else
							strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now"
						end if
					end if					
				else
					if Cint(rs("prod_stock_lower")) <> 0 then
						strDisplayList = strDisplayList & "<font color=orange>Call for availability</font>"
					else
						if Cint(rs("stock_intransit")) >= 1 then							
							if Cint(rs("stock_intransit")) > (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_upper"))) then
								strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, good stock arriving soon"
							else
								strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, " & rs("stock_intransit") & " arriving soon"
							end if
						else
							strDisplayList = strDisplayList & "<font color=red><strong>" & rs("stock_availability") & "</strong> available now</font>"
						end if	
					end if	
				end if
			end if
			strDisplayList = strDisplayList & "</td>"
			
			'strDisplayList = strDisplayList & "<td>" & FormatNumber(rs("stock_wholesale")) & "</td>"
			
			strDisplayList = strDisplayList & "<td><input type=""text"" class=""form-control"" id=""txtQty"" name=""txtQty"" placeholder=""Qty"" maxlength=""3"" size=""2"" required></td>"			
			strDisplayList = strDisplayList & "<td><input type=""text"" class=""form-control"" id=""txtOrderNo"" name=""txtOrderNo"" placeholder=""Purchase Order No"" maxlength=""20"" size=""20"" required></td>"
			strDisplayList = strDisplayList & "<td>"
			strDisplayList = strDisplayList & "<input type=""hidden"" name=""command"" value=""order"">"
			strDisplayList = strDisplayList & "<input type=""hidden"" name=""product"" value=""" & rs("stock_code") & """>"
			strDisplayList = strDisplayList & "<input type=""hidden"" name=""price"" value=""" & rs("stock_wholesale") & """>"
			strDisplayList = strDisplayList & "<input type=""submit"" class=""btn btn-primary"" value=""Order Now"" onclick=""return confirm('Please confirm to order this " & rs("stock_code") & "?');"" />"			
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "</form>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""8"" align=""center"">No records found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""8"" align=""center"">"
	strDisplayList = strDisplayList & "<form name=""MovePage"" action=""default.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("po_initial_page") & ">"
	
	if session("po_initial_page") = 1 then
   		strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
	else 
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
	end if	
	if session("po_initial_page") = intpagecount or intRecordCount = 0 then
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
	else
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
	end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
    strDisplayList = strDisplayList & "<br />"
    strDisplayList = strDisplayList & "Page: " & session("po_initial_page") & " to " & intpagecount
	strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & "</h2>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin				
	call setSearch

	if trim(session("po_initial_page"))  = "" then
		session("po_initial_page") = 1
	end if
		
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		dim strModelNo, intQty, intPrice, strOrderNo, intTotal
		
		strModelNo 	= Server.HTMLEncode(Request("product"))
		intPrice 	= FormatNumber(Request("price"))			
		intQty 		= Server.HTMLEncode(Request("txtQty"))
		strOrderNo 	= Server.HTMLEncode(Request("txtOrderNo"))
			
		Select Case Trim(Request("command"))
			case "order"
				'intTotal = (intPrice * 1.1) * intQty
				intTotal = (intPrice * 1.1) * intQty
				'response.write "<h2 style=color:white>" & intPrice & "</h2>"
				call addConnectPO(strModelNo, intQty, CLng(intPrice), CLng(intTotal), strOrderNo, session("yma_userid"))
		end select
	end if
		
	call displayStock
end sub

call main

dim rs, intPageCount, intpage, intRecord, strDisplayList, strMessageText
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Order</li>
      </ol>
      <div class="masthead">        
        <nav>
          <ul class="nav nav-justified">
            <li class="active"><a>NEW PURCHASE ORDER</a></li>
            <li><a href="purchase-orders.asp">YOUR PURCHASE ORDERS</a></li> 
            <li><a href="backorder.asp">YOUR BACK ORDERS</a></li>
          </ul>
        </nav>
      </div>      
      <h1>New Purchase Order</h1>
      <p>      
      <form name="frmSearch" id="frmSearch" action="?type=search" method="post" onsubmit="searchItem()">
        <div class="float_left">
          <input type="text" class="form-control" name="txtSearch" size="30" value="<%= request("txtSearch") %>" maxlength="20" placeholder="Search Model no / Description" />
        </div>
        <div class="float_left">
          <input type="button" class="btn btn-primary" name="btnSearch" value="Search" onclick="searchItem()" />
        </div>
        <div class="float_left">
          <input type="button" class="btn btn-primary" name="btnReset" value="Reset" onclick="resetSearch()" />
        </div>
      </form>
      </p></td>
  </tr>
  <tr>
    <td><h2><%= strMessageText %></h2>
      <table class="table table-striped">
        <thead>
          <tr>
            <td>Model No</td>
            <td>Description</td>
            <td>RRP inc GST</td>
            <td>Availability</td>
<!--       
	   <td>Wholesale ex GST</td>
-->
			<td>Qty</td>
            <td>Purchase Order No</td>
            <td></td>
          </tr>
        </thead> 
        <tbody>
          <%= strDisplayList %>
          </tbody>       
      </table></td>
  </tr>
  <tr>
    <td class="main_content"><div class="alert alert-info" role="alert"> Please note pricing is shown as Trade Price (ex-GST) only. If you are a ranging dealer your discount will still apply but is not shown on this screen.<br>
        From time to time Yamaha Music Australia will have a special offer on a product. This special pricing will <u>not</u> be visible on this screen.
        </p>
      </div></td>
  </tr>
</table>
</body>
</html>