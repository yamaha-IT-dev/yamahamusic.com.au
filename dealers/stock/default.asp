<%
dim strSection
strSection = "stock"
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
<title>Yamaha Stock Availability</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script>
function searchItem(){
    var strSearch 		= document.forms[0].txtSearch.value;
    document.location.href = 'default.asp?type=search&txtSearch=' + strSearch;	
}

function resetSearch(){
	document.location.href = 'default.asp?type=reset';
}
</script>
</head>
<body>
<%
sub setSearch
	select case trim(request("type"))
		case "reset" 
			session("stock_search") 			= ""
			session("stock_initial_page") 	= 1
		case "search"
			session("stock_search") 			= server.htmlencode(trim(Request("txtSearch")))
			session("stock_initial_page") 	= 1
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
	
	'strSQL = "SELECT DISTINCT S.*, P.prod_predicted_avg, P.prod_stock_upper, P.prod_stock_lower FROM tbl_stock S "
	'strSQL = strSQL & "	RIGHT JOIN tbl_product P ON stock_code = prod_code "
	'strSQL = strSQL & "	WHERE "
	'strSQL = strSQL & "		(stock_code LIKE '%" & session("stock_search") & "%' "
	'strSQL = strSQL & "			OR stock_description LIKE '%" & session("stock_search") & "%')"	
	'strSQL = strSQL & "		AND prod_discontinued = '0' "
	'strSQL = strSQL & "		AND stock_availability >= 0 "
	'strSQL = strSQL & "	ORDER BY stock_code"
	
	'strSQL = "SELECT DISTINCT S.*, P.prod_predicted_avg, P.prod_stock_upper, P.prod_stock_lower, "
	'strSQL = strSQL & "case when stock_intransit > 0 and 'Y' = (select 'Y' from tbl_intransitexclusion where stock_code like ItemCode) then (select 0 from tbl_intransitexclusion where stock_code like itemcode) else stock_intransit end as new_stock_intransit "
	'strSQL = strSQL & " FROM tbl_stock S "	
	'strSQL = strSQL & "	RIGHT JOIN tbl_product P ON stock_code = prod_code "
	'strSQL = strSQL & "	WHERE "
	'strSQL = strSQL & "		(stock_code LIKE '%" & session("stock_search") & "%' "
	'strSQL = strSQL & "			OR stock_description LIKE '%" & session("stock_search") & "%')"	
	'strSQL = strSQL & "		AND prod_discontinued = '0' "
	'strSQL = strSQL & "		AND stock_availability >= 0 "
	
	strSQL = "SELECT DISTINCT S.*, P.prod_predicted_avg, P.prod_stock_upper, P.prod_stock_lower, P.prod_name, "
	strSQL = strSQL & "case "
	strSQL = strSQL & "when stock_intransit > 0 and 'Y' = (select 'Y' from tbl_intransitexclusion where stock_code like ItemCode) then (select 0 from tbl_intransitexclusion where stock_code like itemcode) "
	strSQL = strSQL & "when 'Y' = (select 'Y' from yma_SOH_Exception_List where code like stock_code) then '-1' "
	strSQL = strSQL & "else stock_intransit end as new_stock_intransit "
	strSQL = strSQL & "FROM tbl_stock S "
	strSQL = strSQL & "	RIGHT JOIN tbl_product P ON stock_code = prod_code "
	strSQL = strSQL & "WHERE "
	strSQL = strSQL & "		(stock_code LIKE '%" & session("stock_search") & "%' "
	strSQL = strSQL & "			OR stock_description LIKE '%" & session("stock_search") & "%') "
	strSQL = strSQL & "		AND prod_discontinued = '0' "
	strSQL = strSQL & "		AND stock_availability >= 0 "
	
	'response.write strSQL & "<br>"
	
	rs.Open strSQL, conn
			
	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount
	
	Select Case Request("Action")
	    case "<<"
		    intpage = 1
			session("stock_initial_page") = intpage
	    case "<"
		    intpage = Request("intpage") - 1
			session("stock_initial_page") = intpage
			
			if session("stock_initial_page") < 1 then session("stock_initial_page") = 1
	    case ">"
		    intpage = Request("intpage") + 1
			session("stock_initial_page") = intpage
			
			if session("stock_initial_page") > intPageCount then session("stock_initial_page") = IntPageCount
	    Case ">>"
		    intpage = intPageCount
			session("stock_initial_page") = intpage
    end select

    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then
	
	    rs.AbsolutePage = session("stock_initial_page")
	
		For intRecord = 1 To rs.PageSize
			if iRecordCount Mod 2 = 0 then
				strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
			else
				strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
			end if
			strDisplayList = strDisplayList & "<td>"
			select case rs("stock_code")
				case "C1XSHPEPA"
					strDisplayList = strDisplayList & "C1XSHPE"
				case "C3XSHPEPA"
					strDisplayList = strDisplayList & "C3XSHPE"
				case "GB1KSG2PEPA"
					strDisplayList = strDisplayList & "GB1KSG2PE"
				case "U1SHPEQPA"
					strDisplayList = strDisplayList & "U1SHPEQ"
				case "YUS1SHPEPA"
					strDisplayList = strDisplayList & "YUS1SHPE"
				case "YUS3SHPEPA"
					strDisplayList = strDisplayList & "YUS3SHPE"
				case "YUS5SHPEPA"
					strDisplayList = strDisplayList & "YUS5SHPE"
				case else
					strDisplayList = strDisplayList & rs("stock_code")
			end select	
			strDisplayList = strDisplayList & "</td>"
			'strDisplayList = strDisplayList & "<td>" & rs("stock_code") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_name") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("stock_rrp") & "</td>"
			strDisplayList = strDisplayList & "<td>"
			if not isnull(rs("prod_predicted_avg")) then
				
				if Cint(rs("new_stock_intransit")) = -1 then
					strDisplayList = strDisplayList & "<font color=orange>Call for availability</font>"
				else
				if Cint(rs("prod_stock_upper")) > 1 then
					if Cint(rs("stock_availability")) > Cint(rs("prod_stock_upper")) then
						strDisplayList = strDisplayList & "<font color=green>Good stock available</font>"
					else
						strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, good stock arriving soon"	
					end if
				else
					if Cint(rs("stock_availability")) > (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_lower"))) then
						if Cint(rs("stock_availability")) <= (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_upper"))) then
							if Cint(rs("new_stock_intransit")) >= 1 then 'if Cint(rs("stock_intransit")) >= 1 then
								if Cint(rs("new_stock_intransit")) > (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_upper"))) then
									strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, good stock arriving soon"
								else
									strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, " & rs("new_stock_intransit") & " arriving soon"
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
							if Cint(rs("new_stock_intransit")) >= 1 then							
								if Cint(rs("new_stock_intransit")) > (Cint(rs("prod_predicted_avg")) * Cint(rs("prod_stock_upper"))) then
									strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, good stock arriving soon"
								else
									strDisplayList = strDisplayList & "<strong>" & rs("stock_availability") & "</strong> available now, " & rs("new_stock_intransit") & " arriving soon"
								end if
							else
								strDisplayList = strDisplayList & "<font color=red><strong>" & rs("stock_availability") & "</strong> available now</font>"
							end if	
						end if	
					end if
				end if
				end if
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""4"" align=""center"">No records found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""4"" align=""center"">"
	strDisplayList = strDisplayList & "<form name=""MovePage"" action=""default.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("stock_initial_page") & ">"
	
	if session("stock_initial_page") = 1 then
   		strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
	else 
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
	end if	
	if session("stock_initial_page") = intpagecount or intRecordCount = 0 then
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
	else
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
	end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
    strDisplayList = strDisplayList & "<br />"
    strDisplayList = strDisplayList & "Page: " & session("stock_initial_page") & " to " & intpagecount
	strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & "</h2>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin			
	call setSearch

	if trim(session("stock_initial_page"))  = "" then
		session("stock_initial_page") = 1
	end if
		
	call displayStock
end sub

call main

dim rs, intPageCount, intpage, intRecord, strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Stock Availability</li>
      </ol>
      <h1>Stock Availability (as of 8:30 this morning)</h1>
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
      </form></td>
  </tr>
  <tr>
    <td><div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <td>Model No</td>
              <td>Description</td>
              <td>RRP inc GST</td>              
              <td></td>
            </tr>
          </thead>
          <tbody>
          <%= strDisplayList %>
          </tbody>
        </table>
      </div></td>
  </tr>
</table>
</body>
</html>