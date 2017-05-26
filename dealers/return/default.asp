<%
dim strSection
strSection = "returns"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsGoodsReturn.asp " -->
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
<title>Goods Return</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script>
function searchItem(){
    var strSearch 		= document.forms[0].txtSearch.value;
	var strStatus 		= document.forms[0].cboStatus.value;
    document.location.href = '?type=search&txtSearch=' + strSearch + '&status=' + strStatus;	
}
   
function resetSearch(){
	document.location.href = '?type=reset';
}
</script>
</head>
<body>
<%
sub setSearch
	select case trim(request("type"))
		case "reset" 
			session("gra_search") 			= ""			
			session("gra_search_status") 	= ""
			session("gra_initial_page") 	= 1
		case "search"
			session("gra_search") 			= server.htmlencode(trim(Request("txtSearch")))
			session("gra_search_status") 	= trim(request("status"))
			session("gra_initial_page") 	= 1
	end select
end sub

sub displayGRA
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
	
	'if session("gra_search_status") = "" then
	'	session("gra_search_status") = "1"
	'end if
	
	strSQL = "SELECT tbl_gra_mpd.* "
	'strSQL = strSQL & " DATEDIFF(dd,job_date_created,GetDate()) as elapsed_days "
	strSQL = strSQL & "	FROM tbl_gra_mpd "
	strSQL = strSQL & "	WHERE "
	strSQL = strSQL & "		(gra_model_no LIKE '%" & session("gra_search") & "%' "
	strSQL = strSQL & "			OR gra_serial_no LIKE '%" & session("gra_search") & "%' "
	strSQL = strSQL & "			OR gra_invoice_no LIKE '%" & session("gra_search") & "%' "
	strSQL = strSQL & " 	)"
	strSQL = strSQL & "		AND gra_status LIKE '%" & session("gra_search_status") & "%' "
	strSQL = strSQL & "		AND gra_userid = '" & session("yma_userid") & "' "
	strSQL = strSQL & "	ORDER BY gra_date_created DESC"
	
	'response.write strSQL & "<br>"
	
	rs.Open strSQL, conn
			
	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount
	
	Select Case Request("Action")
	    case "<<"
		    intpage = 1
			session("gra_initial_page") = intpage
	    case "<"
		    intpage = Request("intpage") - 1
			session("gra_initial_page") = intpage
			
			if session("gra_initial_page") < 1 then session("gra_initial_page") = 1
	    case ">"
		    intpage = Request("intpage") + 1
			session("gra_initial_page") = intpage
			
			if session("gra_initial_page") > intPageCount then session("gra_initial_page") = IntPageCount
	    Case ">>"
		    intpage = intPageCount
			session("gra_initial_page") = intpage	    
    end select

    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then
	
	    rs.AbsolutePage = session("gra_initial_page")  
	
		For intRecord = 1 To rs.PageSize
			
			if iRecordCount Mod 2 = 0 then
				strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
			else
				strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
			end if

			strDisplayList = strDisplayList & "<td >" & rs("gra_id") & "</td>"
			strDisplayList = strDisplayList & "<td >" & FormatDateTime(rs("gra_date_created"),2) & "</td>"			
			strDisplayList = strDisplayList & "<td >" & rs("gra_model_no") & ""
			if DateDiff("d",rs("gra_date_created"), strTodayDate) = 0 then
				strDisplayList = strDisplayList & " <img src=""../images/icon_new.gif"" border=""0"">"
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td >" & rs("gra_qty") & "</td>"
			strDisplayList = strDisplayList & "<td >" & rs("gra_serial_no") & "</td>"
			strDisplayList = strDisplayList & "<td >" & rs("gra_invoice_no") & "</td>"
			strDisplayList = strDisplayList & "<td >" & FormatDateTime(rs("gra_invoice_date"),2) & "</td>"
			strDisplayList = strDisplayList & "<td >" & rs("gra_reason") & "</td>"
			strDisplayList = strDisplayList & "<td >" & rs("gra_type") & "</td>"
			strDisplayList = strDisplayList & "<td >"
			Select Case	rs("gra_serviced")
				case 1
					strDisplayList = strDisplayList & "<img src=""../images/tick.gif"">"
				case 0
					strDisplayList = strDisplayList & "<img src=""../images/cross.gif"">"
			end select
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td >"
			if len(rs("gra_uploaded_filename")) > 1 then
				strDisplayList = strDisplayList & "<a href=""http://www.yamahamusic.com.au/dealers/resources/upload/" & rs("gra_id") & "/" & rs("gra_uploaded_filename") & """ target=""_blank"">View</a>"
			else
				strDisplayList = strDisplayList & "-"
			end if
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td >"
			Select Case	rs("gra_status")
				case 1
					strDisplayList = strDisplayList & "<font color=""orange"">Not Submitted"
				case 2
					strDisplayList = strDisplayList & "<font color=""blue"">Submitted"
				case 3
					strDisplayList = strDisplayList & "<font color=""red"">Rejected"
				case 4
					strDisplayList = strDisplayList & "<font color=""purple"">Send to Service Agent"
				case 0
					strDisplayList = strDisplayList & "<font color=""green"">Approved"				
			end select
			strDisplayList = strDisplayList & "</font></td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""13"" align=""center"">No Goods Return found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""13"" align=""center"">"
	strDisplayList = strDisplayList & "<form name=""MovePage"" action=""default.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("gra_initial_page") & ">"
	
	if session("gra_initial_page") = 1 then
   		strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
	else 
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
	end if	
	if session("gra_initial_page") = intpagecount or intRecordCount = 0 then
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
	else
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
	end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
	strDisplayList = strDisplayList & "<input type=""hidden"" name=""cboStatus"" value=" & strStatus & ">"
    strDisplayList = strDisplayList & "<br />"
    strDisplayList = strDisplayList & "Page: " & session("gra_initial_page") & " to " & intpagecount
	strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & "</h2>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin
	call clearNewGraSessions
	call setSearch

	if trim(session("gra_initial_page"))  = "" then
		session("gra_initial_page") = 1
	end if
		
	call displayGRA
end sub

call main

dim rs, intPageCount, intpage, intRecord, strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Goods Return</li>
      </ol>
      <h1>Goods Return</h1>
      <p><a href="../resources/new-return.asp">
        <button type="button" class="btn btn-primary btn-lg">New Return &raquo;</button>
        </a></p>
      <form name="frmSearch" id="frmSearch" action="return.asp?type=search" method="post" onsubmit="searchItem()">
        <div class="float_left">
          <input type="text" class="form-control" name="txtSearch" size="40" value="<%= request("txtSearch") %>" maxlength="20" placeholder="Search Model no / Serial no / Invoice no" />
        </div>
        <div class="float_left">
          <select class="form-control" name="cboStatus" onchange="searchItem()">
            <option <% if session("gra_search_status") = "" then Response.Write " selected" end if%> value="">All status</option>
            <option <% if session("gra_search_status") = "2" then Response.Write " selected" end if%> value="2" style="color:blue">Submitted</option>
            <option <% if session("gra_search_status") = "3" then Response.Write " selected" end if%> value="3" style="color:red">Rejected</option>
            <option <% if session("gra_search_status") = "0" then Response.Write " selected" end if%> value="0" style="color:green">Approved</option>
          </select>
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
    <td><table class="table table-striped">
        <thead>
          <tr>
            <td>ID</td>
            <td>Created</td>
            <td>Model no</td>
            <td>Qty</td>
            <td>Serial no</td>
            <td>Invoice no</td>
            <td>Invoice date</td>
            <td>Reason</td>
            <td>Type</td>
            <td>Serviced</td>
            <td>Photo</td>
            <td>Status</td>
          </tr>
        </thead>
        <%= strDisplayList %>
      </table></td>
  </tr>
  <tr>
    <td class="main_content"><div class="alert alert-info" role="alert"> <strong>Terms and Conditions</strong>
        <ol>
          <li>Please allow 5 working days for Yamaha Music Australia to approve and process your request.</li>
          <li>Proof of fault or damage, where applicable, must be illustrated with photos. Failure to supply photos will delay the request.</li>
          <li>Once the return has been approved, you will receive an email from us with a GRC (Goods Return Code). When enquiring about your goods return, please quote this number.</li>
          <li>Once your return has been approved, Yamaha Music Australia at its discretion will decide whether you have to send the product back to our warehouse, or if it is more appropriate to destroy the product in-store. In the instance where the product is to be destroyed, your local Yamaha Sales Manager must be present at the time that the product is destroyed in-store.</li>
          <li>Once approved, you will receive paperwork via Australia Post from Excel Technology which includes a con-note and paperwork that needs to be returned with the product. Please note, if you do not include this paperwork, your return will not be processed.</li>
          <li><strong>Do not attempt to return goods without approval or official paperwork from Excel Technology as the product will be returned at your expense.</strong></li>
          <li>Accessories not returned will be charged to your account at trade price.</li>
          <li>A credit will not be raised until the goods have returned and inspected. This will occur within 8 business days of the goods being received into our warehouse.</li>
          <li>Any goods found not to be faulty will be returned at the dealer's expense.</li>
        </ol>
      </div></td>
  </tr>
</table>
</body>
</html>