<%
dim strSection
strSection = "asset"
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
<title>Uploaded Assets</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%
sub displayAsset		
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
	
	strSQL = "SELECT * FROM tbl_asset"
	strSQL = strSQL & "	WHERE"	
	strSQL = strSQL & "		assetCreatedBy = '" & session("yma_userid") & "'"
	strSQL = strSQL & "	ORDER BY assetDateCreated DESC"
	
	'response.write "<font color=white>" strSQL & "</font><br>"
	
	rs.Open strSQL, conn
			
	intPageCount 		= rs.PageCount
	intRecordCount 		= rs.recordcount
		
    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then	
		For intRecord = 1 To rs.PageSize			
			strDisplayList = strDisplayList & "<tr>"			
			strDisplayList = strDisplayList & "<td>" & rs("assetID") & "</td>"			
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("assetDateCreated"),2) & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("assetName") & "</td>"			
			strDisplayList = strDisplayList & "<td>"
			Select Case trim(rs("assetType"))
				case 1
					strDisplayList = strDisplayList & "Artwork"
				case 2
					strDisplayList = strDisplayList & "Booking"
				case 3
					strDisplayList = strDisplayList & "Coop"					
			end select
			strDisplayList = strDisplayList & " (ID=" & rs("assetAssociateID") & ")</td>"		
			strDisplayList = strDisplayList & "<td><a href=""../resources/upload/" & session("yma_userid") & "/" & rs("assetFilename") & """ target=""_blank"">" & rs("assetFilename") & "</a></td>"
			strDisplayList = strDisplayList & "<td><a onclick=""return confirm('Confirm to delete " & rs("assetName") & "?');"" href=""delete-asset.asp?id=" & rs("assetID") & """><img src=""../images/icon_trash.png""></a></td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""6"" align=""center"">No assets found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr><td colspan=""6"" align=""center""><h2>Total: " & intRecordCount & "</h2></td></p>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin
	call displayAsset
end sub

call main

dim rs, intPageCount, intRecord, strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Uploaded Assets</li>
      </ol>
      <h1>Uploaded Assets</h1>
      <a href="../coop/"><button type="button" class="btn btn-primary">UPLOAD ANOTHER COOP FILES &raquo;</button></a>
      </td>
  </tr>
  <tr>
    <td><div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <td>Asset ID</td>
              <td>Date Created</td>
              <td>Name</td>
              <td>Type</td>
              <td>Filename</td>
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