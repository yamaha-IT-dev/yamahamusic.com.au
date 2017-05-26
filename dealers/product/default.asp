<%
dim strSection
strSection = "product"
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
<title>Product Price List and Dimensions</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script>
function searchProduct(){    
    var strSearch 	= document.forms[0].txtSearch.value;
	var strCategory	= document.forms[0].cboCategory.value;
	
	document.location.href = '?type=search&txtSearch=' + strSearch + '&category=' + strCategory;
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
			session("connect_product_search") 		= ""
			session("connect_product_category") 	= ""		
			session("connect_product_initial_page") = 1
		case "search"
			session("connect_product_search") 		= server.htmlencode(trim(Request("txtSearch")))
			session("connect_product_category") 	= trim(request("category"))
			session("connect_product_initial_page") = 1
	end select
end sub

sub displayProduct
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
	rs.PageSize = 30
	
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
	
	'response.Write strSQL
	
	rs.Open strSQL, conn
	
	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount
	
	Select Case Request("Action")
	    case "<<"
		    intpage = 1
			session("connect_product_initial_page") = intpage
	    case "<"
		    intpage = Request("intpage") - 1
			session("connect_product_initial_page") = intpage
			
			if session("connect_product_initial_page") < 1 then session("connect_product_initial_page") = 1
	    case ">"
		    intpage = Request("intpage") + 1
			session("connect_product_initial_page") = intpage
			
			if session("connect_product_initial_page") > intPageCount then session("connect_product_initial_page") = IntPageCount
	    Case ">>"
		    intpage = intPageCount
			session("connect_product_initial_page") = intpage
    end select

    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then
	
	    rs.AbsolutePage = session("connect_product_initial_page")
	
		For intRecord = 1 To rs.PageSize
						
			if iRecordCount Mod 2 = 0 then
				strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
			else
				strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
			end if

			strDisplayList = strDisplayList & "<td>" & rs("prod_category") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_series") & "</td>"
			strDisplayList = strDisplayList & "<td><strong>" & rs("prod_code") & "</strong></td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_short_description") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_rrp") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_status") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_weight") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_width") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_height") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_depth") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("prod_volume") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("ean_code") & "</td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1
			If rs.EOF Then Exit For
		next
	else
        strDisplayList = "<tr class=""innerdoc""><td colspan=""13"" align=""center"">No products found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""13"" align=""center"">"
	strDisplayList = strDisplayList & "<form name=""MovePage"" action=""default.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("connect_product_initial_page") & ">"
	
	if session("connect_product_initial_page") = 1 then
   		strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
	else
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
	end if	
	if session("connect_product_initial_page") = intpagecount or intRecordCount = 0 then
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
	else
		strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
    	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
	end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
	strDisplayList = strDisplayList & "<input type=""hidden"" name=""cboStatus"" value=" & strStatus & ">"
    strDisplayList = strDisplayList & "<p>Page: " & session("connect_product_initial_page") & " to " & intpagecount & "</p>"
	strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & "</h2>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin
	call setSearch

	if trim(session("connect_product_initial_page")) = "" then
		session("connect_product_initial_page") = 1
	end if
		
	call displayProduct	
end sub

call main

dim rs, intPageCount, intpage, intRecord, strDisplayList, strMessageText
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Product Information</li>
      </ol>
      <h1>Product Information: RRP, Weight, Dimensions, etc.</h1>
      <p>You can search specific items below, or export the entire data in Microsoft Excel format.  When you export the data you will notice that extra columns will appear. These columns include ‘<em>Sub-Category</em>’ and ‘<em>Long Description</em>’ data.</p>
      <form name="frmSearch" id="frmSearch" action="?type=search" method="post" onsubmit="searchProduct()">
        <div class="float_left">
          <input type="text" class="form-control" name="txtSearch" size="30" value="<%= request("txtSearch") %>" maxlength="20" placeholder="Search Product / Description / EAN" />
        </div>
        <div class="float_left">
          <select class="form-control" name="cboCategory" onchange="searchProduct()">
            <option <% if session("connect_product_category") = ""  then Response.Write " selected" end if %> value="">All categories</option>
            <option <% if session("connect_product_category") = "acoustic" then Response.Write " selected" end if %> value="acoustic">Acoustic Drums</option>
            <option <% if session("connect_product_category") = "orchestral" then Response.Write " selected" end if %> value="orchestral">Band & Orchestral</option>
            <option <% if session("connect_product_category") = "network" then Response.Write " selected" end if %> value="network">Band & Orchestral - Pro Network</option>
            <option <% if session("connect_product_category") = "computer" then Response.Write " selected" end if %> value="computer">Computer Music</option>
            <option <% if session("connect_product_category") = "commercial" then Response.Write " selected" end if %> value="commercial">Commercial Audio</option>
            <option <% if session("connect_product_category") = "marching" then Response.Write " selected" end if %> value="marching">Concert & Marching Percussion</option>
            <option <% if session("connect_product_category") = "specialist" then Response.Write " selected" end if %> value="specialist">Concert Percussion - Specialist</option>
            <option <% if session("connect_product_category") = "digital" then Response.Write " selected" end if %> value="digital">Digital Pianos</option>
            <option <% if session("connect_product_category") = "electronic" then Response.Write " selected" end if %> value="electronic">Electronic Drums</option>
            <option <% if session("connect_product_category") = "guitar" then Response.Write " selected" end if %> value="guitar">Guitars</option>
            <option <% if session("connect_product_category") = "accessories" then Response.Write " selected" end if %> value="accessories">Keyboard Accessories</option>
            <option <% if session("connect_product_category") = "line 6" then Response.Write " selected" end if %> value="line 6">Line 6</option>
            <option <% if session("connect_product_category") = "paiste" then Response.Write " selected" end if %> value="paiste">Paiste</option>
            <option <% if session("connect_product_category") = "disklavier" then Response.Write " selected" end if %> value="disklavier">Piano & Disklavier</option>
            <option <% if session("connect_product_category") = "portable" then Response.Write " selected" end if %> value="portable">Portable Keyboards</option>
            <option <% if session("connect_product_category") = "professional" then Response.Write " selected" end if %> value="professional">Professional Audio</option>
            <option <% if session("connect_product_category") = "silent" then Response.Write " selected" end if %> value="silent">Silent Strings</option>
            <option <% if session("connect_product_category") = "stage" then Response.Write " selected" end if %> value="stage">Stage Pianos</option>
            <option <% if session("connect_product_category") = "licensing" then Response.Write " selected" end if %> value="licensing">Steinberg Licensing</option>
            <option <% if session("connect_product_category") = "education" then Response.Write " selected" end if %> value="education">Steinberg Software - Education Editions</option>
            <option <% if session("connect_product_category") = "retail" then Response.Write " selected" end if %> value="retail">Steinberg Software - Retail Editions</option>
            <option <% if session("connect_product_category") = "synthesizer" then Response.Write " selected" end if %> value="synthesizer">Synthesizers</option>
            <option <% if session("connect_product_category") = "vox" then Response.Write " selected" end if %> value="vox">Vox</option>
          </select>
        </div>
        <div class="float_left">
          <input type="button" class="btn btn-primary" name="btnSearch" value="Search" onclick="searchProduct()" />
        </div>
        <div class="float_left">
          <input type="button" class="btn btn-primary" name="btnReset" value="Reset" onclick="resetSearch()" />
        </div>
      </form>
      <p align="right"><a href="export.asp"><img src="../images/icon_export.png" border="0" /></a></p></td>
  </tr>
  <tr>
    <td><table class="table table-striped">
        <thead>
          <tr>
            <td width="10%">Category</td>
            <td width="10%">Series</td>
            <td width="10%">Product Code</td>
            <td width="35%">Short Description</td>
            <td width="5%">RRP inc GST</td>
            <td width="5%">Status</td>
            <td width="5%">Weight (kg)</td>
            <td width="5%">Width (cm)</td>
            <td width="5%">Height (cm)</td>
            <td width="5%">Depth (cm)</td>
            <td width="5%">Volume (m<sup>3</sup>)</td>
            <td width="5%">EAN</td>
          </tr>
        </thead>
        <%= strDisplayList %>
      </table>
      </td>
  </tr>
  <tr><td class="main_content"><div class="alert alert-info" role="alert"><p><strong>Status Legend:</strong></p>
      <p>O = Open Line<br />
        D = Dealer Only<br />
        B = Backorder Only</p>
      <p><strong>Terms and Conditions:</strong></p>
      <ul>
        <li>Recommended retail price list is effective 1<sup>st</sup> June 2014</li>
        <li>All pricing and specifications are subject to change without prior notice</li>
        <li>Some items will not have gross weight, width, height, depth and volume available.</li>
        <li>Errors and omissions excepted</li>
      </ul></div></td></tr>
</table>
</body>
</html>