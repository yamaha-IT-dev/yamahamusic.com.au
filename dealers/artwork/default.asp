<%
dim strSection
strSection = "artwork"
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
<title>Artwork</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%
sub displayArtwork		
    dim strSQL
	
	dim intRecordCount
	
	dim iRecordCount
	iRecordCount = 0		
	
	dim strTodayDate	
	strTodayDate = FormatDateTime(Date())
	
    call OpenDataBase()
	
	set rs = Server.CreateObject("ADODB.recordset")
	
	rs.CursorLocation 	= 3
    rs.CursorType 		= 3
	rs.PageSize 		= 90000
	
	strSQL = "SELECT * FROM tbl_connect_artwork"
	strSQL = strSQL & "	WHERE"	
	strSQL = strSQL & "		artCreatedBy = '" & session("yma_userid") & "'"
	strSQL = strSQL & "	ORDER BY artDateCreated DESC"
	
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
			strDisplayList = strDisplayList & "<td nowrap><a href=""update-artwork.asp?id=" & rs("artID") & """>" & rs("artID") & "</a></td>"			
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("artDateCreated"),2) & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("artProjectName") & "</td>"			
			strDisplayList = strDisplayList & "<td>" & rs("artType") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("artColour") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("artSize") & "</td>"			
			strDisplayList = strDisplayList & "<td>" & rs("artPages") & "</td>"
			strDisplayList = strDisplayList & "<td>"
			Select Case trim(rs("artOrientation"))
				case 1
					strDisplayList = strDisplayList & "Portrait"
				case 2
					strDisplayList = strDisplayList & "Landscape"					
			end select
			strDisplayList = strDisplayList & "</td>"				
			strDisplayList = strDisplayList & "<td>"
			Select Case	rs("artStatus")
				case 1
					strDisplayList = strDisplayList & "<font color=""blue"">Submitted"
				case 2
					strDisplayList = strDisplayList & "<font color=""purple"">Pending Approval"	
				case 3
					strDisplayList = strDisplayList & "<font color=""orange"">On-hold"
				case 4
					strDisplayList = strDisplayList & "<font color=""green"">Approved"	
				case 0
					strDisplayList = strDisplayList & "<font color=""gray"">Completed"
			end select
			strDisplayList = strDisplayList & "</font></td>"
			strDisplayList = strDisplayList & "<td>" & rs("artNotes") & "</td>"
			strDisplayList = strDisplayList & "<td><a href=""../resources/new-asset.asp?id=" & rs("artID") & "&type=1""><button type=""button"" class=""btn btn-primary"">UPLOAD FILE &raquo;</button></td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1	
			If rs.EOF Then Exit For 
		next
	else
        strDisplayList = "<tr><td colspan=""11"" align=""center"">No Artwork found.</td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr><td colspan=""11"" align=""center""><h2>Total: " & intRecordCount & "</h2></td></p>"
	
    call CloseDataBase()
end sub

sub main
	call validateLogin
	call displayArtwork
end sub

call main

dim rs, intPageCount, intRecord, strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content">
    <ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li class="active">Artwork</li>
      </ol>
    <h1>Artwork Requests</h1>
    <p>To make it easier for you, we have an in-house graphic design department who can work with you to create attractive artwork for your next Yamaha, Steinberg, Paiste or Vox promotion. From flyers to advertisements to billboards, we can create all forms of finished artwork. Whether it is for print, radio or online usage, we can work with all mediums. To start the process please click the below &quot;New Artwork&quot; link. Once we receive it at head office, we will notify you and let you know if we are able to accommodate your requested deadlines.</p>
      <a href="new-artwork.asp">
      <button type="button" class="btn btn-primary btn-lg">New Artwork &raquo;</button></a></td>
  </tr>
  <tr>
    <td><table class="table table-striped">
        <thead><tr>
          <td>Artwork ID</td>
          <td>Requested</td>
          <td>Project Name</td>
          <td>Type</td>
          <td>Colour</td>
          <td>Size</td>
          <td>Pages</td>
          <td>Orientation</td>
          <td>Status</td>
          <td>Yamaha's Notes</td>
          <td></td>
        </tr></thead>
        <%= strDisplayList %>
      </table></td>
  </tr>
</table>
</body>
</html>