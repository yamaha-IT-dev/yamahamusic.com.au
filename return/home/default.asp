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
<title>Yamaha Goods Return - Home</title>
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../css/style.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<%
sub setSearch
	select case trim(request("type"))
		case "reset" 
			session("return_search") 		= ""			
			session("return_status") 		= ""
			session("return_initial_page") 	= 1
		case "search"
			session("return_search") 		= server.htmlencode(trim(Request("txtSearch")))
			session("return_status") 		= trim(request("status"))
			session("return_initial_page") 	= 1
	end select
end sub

sub displayReturn
	dim strSQL
	
	dim intRecordCount
	
	dim iRecordCount
	iRecordCount = 0		
	
	dim strTodayDate	
	strTodayDate = FormatDateTime(Date())
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic
	rs.PageSize = 100
	
	'if session("return_status") = "" then
	'	session("return_status") = "1"
	'end if
	
	strSQL = "SELECT * FROM yma_gra "
	strSQL = strSQL & "	WHERE created_by = '" & Session("UsrUserID") & "' "
	strSQL = strSQL & "		AND (model_no LIKE '%" & session("return_search") & "%' "
	strSQL = strSQL & "			OR serial_no LIKE '%" & session("return_search") & "%' "
	strSQL = strSQL & "			OR invoice_no LIKE '%" & session("return_search") & "%' "
	strSQL = strSQL & "			OR claim_no LIKE '%" & session("return_search") & "%' "
	strSQL = strSQL & "			OR replacement_order_no LIKE '%" & session("return_search") & "%') "
	strSQL = strSQL & "		AND status LIKE '%" & session("return_status") & "%' "
	strSQL = strSQL & "	ORDER BY date_created DESC"
	
	'response.write strSQL & "<br>"
	
	rs.Open strSQL, conn
			
	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount
	
	Select Case Request("Action")
	    case "<<"
		    intpage = 1
			session("return_initial_page") = intpage
	    case "<"
		    intpage = Request("intpage") - 1
			session("return_initial_page") = intpage
			
			if session("return_initial_page") < 1 then session("return_initial_page") = 1
	    case ">"
		    intpage = Request("intpage") + 1
			session("return_initial_page") = intpage
			
			if session("return_initial_page") > intPageCount then session("return_initial_page") = IntPageCount
	    Case ">>"
		    intpage = intPageCount
			session("return_initial_page") = intpage	    
    end select

    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then
	
	    rs.AbsolutePage = session("return_initial_page")  
	
		For intRecord = 1 To rs.PageSize
			strDisplayList = strDisplayList & "<tr>"
			strDisplayList = strDisplayList & "<td>"
			if rs("status") = 1 then
				strDisplayList = strDisplayList & "<a href=""submit_return.asp?id=" & rs("gra_id") & """>Submit"
			else
				strDisplayList = strDisplayList & "<a href=""update_return.asp?id=" & rs("gra_id") & """>Edit"
			end if
			strDisplayList = strDisplayList & "</a></td>"
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("date_created"),2) & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("model_no") & ""
			if DateDiff("d",rs("date_created"), strTodayDate) = 0 then
				strDisplayList = strDisplayList & " <img src=""images/icon_new.gif"" border=0>"
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("serial_no") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("invoice_no") & "</td>"
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("date_purchased"),2) & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("claim_no") & "</td>"	
			strDisplayList = strDisplayList & "<td>" & rs("replacement_order_no") & "</td>"
			strDisplayList = strDisplayList & "<td>"				
			Select Case	rs("reason")
				case 1
					strDisplayList = strDisplayList & "Damaged in transit / DOA"
				case 2
					strDisplayList = strDisplayList & "Faulty display model"
				case 3
					strDisplayList = strDisplayList & "Faulty customer purchase"
				case 4
					strDisplayList = strDisplayList & "Faulty 3rd time"
				case 5
					strDisplayList = strDisplayList & "Yamaha sales manager nominated return"
				case else
					strDisplayList = strDisplayList & "-"
			end select					
			strDisplayList = strDisplayList & "</td>"
			
			strDisplayList = strDisplayList & "<td>"
			if len(rs("uploaded_filename")) > 1 then
				strDisplayList = strDisplayList & "<a href=""http://www.yamahamusic.com.au/return/upload/" & rs("gra_id") & "/" & rs("uploaded_filename") & """ target=""_blank"">View</a>"
			else
				strDisplayList = strDisplayList & "-"
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>"	
			Select Case	rs("status")
				case 1
					strDisplayList = strDisplayList & "<font color=""orange"">Not Submitted</font>"
				case 2
					strDisplayList = strDisplayList & "<font color=""blue"">Submitted</font>"	
				case 3
					strDisplayList = strDisplayList & "<font color=""red"">Rejected</font>"
				case 0
					strDisplayList = strDisplayList & "<font color=""green"">Approved</font>"					
			end select
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("gra_no") & "</td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next

	else
        strDisplayList = "<tr><td colspan=""12"" align=""center"" bgcolor=""#FFFFFF"">No returns found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""12"" class=""recordspaging"">"
	strDisplayList = strDisplayList & "<form name=""MovePage"" action=""home.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("return_initial_page") & ">"
	
	if session("return_initial_page") = 1 then
   		strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
	else 
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
	end if	
	if session("return_initial_page") = intpagecount or intRecordCount = 0 then
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
	else
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
	end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
	strDisplayList = strDisplayList & "<input type=""hidden"" name=""cboStatus"" value=" & strStatus & ">"   
    strDisplayList = strDisplayList & "<p>Page: " & session("return_initial_page") & " to " & intpagecount
	strDisplayList = strDisplayList & "</p>"
	strDisplayList = strDisplayList & "<h3>Total: " & intRecordCount & "</h3>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"
	
    call CloseDataBase()
end sub

sub main
	call UTL_validateLogin
	call getUserDetails(Session("UsrUserID"))
	call setSearch

    if trim(session("return_initial_page"))  = "" then
    	session("return_initial_page") = 1
	end if
    
    call displayReturn
end sub

call main

dim rs, intPageCount, intpage, intRecord, strDisplayList
%>
</head>
<body>
<div class="container"> 
  <!-- #include file="../include/header-new.asp" -->
  <h2>G'day <%= Session("usr_firstname") %>, Welcome to Yamaha Goods Return!</h2>
  <p><a class="btn btn-lg btn-primary" href="../add-return.asp" role="button">New Entry &raquo;</a></p>
  <hr>
  <h3>Summary:</h3>
  <form name="frmSearch" id="frmSearch" action="home.asp?type=search" method="post" onsubmit="searchItem()">
    <div class="float_left">
    <input type="text" class="form-control" id="txtSearch" name="txtSearch" size="25" value="<%= request("txtSearch") %>" maxlength="20" placeholder="Model no / Serial no / Yamaha invoice no / Claim no / Order no" />
    </div>
    <div class="float_left">
    <select class="form-control" id="cboStatus" name="cboStatus" onchange="searchItem()">
      <option <% if session("return_status") = "" then Response.Write " selected" end if%> value="">All status</option>
      <option <% if session("return_status") = "1" then Response.Write " selected" end if%> value="1">Open</option>
      <option <% if session("return_status") = "2" then Response.Write " selected" end if%> value="2">Processing</option>
      <option <% if session("return_status") = "3" then Response.Write " selected" end if%> value="3">Rejected</option>
      <option <% if session("return_status") = "0" then Response.Write " selected" end if%> value="0">Approved</option>
    </select>
    </div>
    <div class="float_left">
    <input type="button" class="form-control" name="btnSearch" value="Search" onclick="searchItem()" />
    </div>
    <div class="float_left">
    <input type="button" class="form-control" name="btnReset" value="Reset" onclick="resetSearch()" />
    </div>
  </form>
  <div class="table-responsive">
    <table class="table table-striped">
      <thead>
        <tr>
          <td>&nbsp;</td>
          <td>Created</td>
          <td>Model no</td>
          <td>Serial no</td>
          <td>YMA invoice no</td>
          <td>Purchased</td>
          <td>Claim no</td>
          <td>Order no</td>
          <td>Reason for return</td>
          <td>Receipt</td>
          <td>Status</td>
          <td>GRA no</td>
        </tr>
      </thead>
      <%= strDisplayList %>
    </table>
  </div>
</div>
</body>
</html>