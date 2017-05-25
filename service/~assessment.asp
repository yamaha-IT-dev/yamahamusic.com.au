<% strSection = "assessment"
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsAssessment.asp" -->
<!--#include file="class/clsList.asp" -->
<!--#include file="class/clsToken.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<% AntiFixationVerify("default.asp") %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
	<script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<title>Skills Assessment Summary - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<!--<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">-->
<script src="//code.jquery.com/jquery.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<%
sub displayAssessment
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
	rs.PageSize = 500
	
	strSQL = "SELECT * FROM tbl_assessment "	
	strSQL = strSQL & "	WHERE created_by = '" & Session("UsrUserID") & "'"	
	strSQL = strSQL & "	ORDER BY id"
	
	'response.Write strSQL
	
	rs.Open strSQL, conn
	
	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount	

    strDisplayList = ""
	
	if not DB_RecSetIsEmpty(rs) Then	   
	
		For intRecord = 1 To rs.PageSize
			if iRecordCount Mod 2 = 0 then
				strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
			else
				strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
			end if

			dim strHighRankName, strMidRankName, strBasicRankName, strOverallRank
			strHighRankName = checkHighQuestions(rs("q1"),rs("q2"),rs("q3"),rs("q4"),rs("q5"),rs("q6"),rs("q7"),rs("total_high"))
			strMidRankName = checkMidQuestions(rs("q8"),rs("q9"),rs("q10"),rs("q11"),rs("q12"),rs("q13"),rs("q14"),rs("q15"),rs("q16"),rs("q17"),rs("q18"),rs("total_mid"))			
			strBasicRankName = checkBasicQuestions(rs("q19"),rs("q20"),rs("q21"),rs("q22"),rs("q23"),rs("q24"),rs("q25"),rs("total_basic"))
			
			strOverallRank = Max3(Cint(strHighRankName), Cint(strMidRankName), Cint(strBasicRankName)) 
			
			strDisplayList = strDisplayList & "<td><a href=""view_assessment.asp?id=" & rs("id") & """>View</a></td>"
			strDisplayList = strDisplayList & "<td>" & rs("id") & "</td>"
			strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("date_created"),1) & "</td>"		
			strDisplayList = strDisplayList & "<td>" & rs("total_high") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("total_mid") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("total_basic") & "</td>"	
			strDisplayList = strDisplayList & "<td>" & rs("total_score") & "</td>"
			strDisplayList = strDisplayList & "<td><strong>"							
			select case strOverallRank			
				case 1
					strDisplayList = strDisplayList & "A"
				case 2
					strDisplayList = strDisplayList & "B"
				case 3
					strDisplayList = strDisplayList & "C"
				case 4
					strDisplayList = strDisplayList & "D"
				case 5
					strDisplayList = strDisplayList & "E"
			end select
			strDisplayList = strDisplayList & "</strong></td>"
			strDisplayList = strDisplayList & "</tr>"
			
			rs.movenext
			iRecordCount = iRecordCount + 1
			If rs.EOF Then Exit For
		next
	else
        strDisplayList = "<tr><td colspan=""8"" align=""center"" bgcolor=""white"">You have not done any skills assessment yet. <h2><a href=""new_assessment.asp"">Click here for New Skills Assessment</a></h2></td></tr>"
	end if
	
	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""8"" class=""recordspaging"">"	
	strDisplayList = strDisplayList & "<h2>" & intRecordCount & " record found</h2>"    
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"
	
    call CloseDataBase()
end sub

sub main	
	call UTL_validateLogin
	call displayAssessment
end sub

call main

dim strDisplayList
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent"><h1>Skills Assessment</h1>
      <h2><a href="new_assessment.asp"><i class="fa fa-plus"></i> New Assessment</a></h2>
      <table cellspacing="0" cellpadding="5" class="db_records" width="800">
        <tr class="innerdoctitle">  
          <td></td>
          <td>Assessment ID</td>
          <td>Submitted</td>  
          <td>Total High</td>
          <td>Total Mid</td>
          <td>Total Base</td>        
          <td>Total Score</td>
          <td>Rank</td>
        </tr>
        <%= strDisplayList %>
      </table>
      <hr>
      <h3>Ranking:</h3>
      <p>A - Technician can provide highly reliable work with plenty of technical knowledge and understanding<br>
        B - Technician can carry out repairs to unit / sub assembly change over, some ablity to repair to component level<br>
        C - Technician can repair basic faults, board swap outs and component level under supervision<br>
      D - Technician tries to repair in various ways, but struggles to complete the work and requires deep technical support</p>
      </td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>