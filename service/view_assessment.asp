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
<link rel="stylesheet" href="include/stylesheet.css" />
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<!--<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">-->
<script src="//code.jquery.com/jquery.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<%
sub main	
	call UTL_validateLogin
	dim intID
	intID = Request("id")
	
	call getSkillAssessment(intID)
	
	dim strHighRankName, strMidRankName, strBasicRankName, strOverallRank
	
	strHighRankName = checkHighQuestions(session("q1"),session("q2"),session("q3"),session("q4"),session("q5"),session("q6"),session("q7"),session("total_high"))			
	strMidRankName = checkMidQuestions(session("q8"),session("q9"),session("q10"),session("q11"),session("q12"),session("q13"),session("q14"),session("q15"),session("q16"),session("q17"),session("q18"),session("total_mid"))			
	strBasicRankName = checkBasicQuestions(session("q19"),session("q20"),session("q21"),session("q22"),session("q23"),session("q24"),session("q25"),session("total_basic"))
			
	strOverallRank = Max3(Cint(strHighRankName), Cint(strMidRankName), Cint(strBasicRankName)) 
	
	select case strOverallRank
		case 1
			strRanking = "A"
		case 2
			strRanking = "B"
		case 3
			strRanking = "C"
		case 4
			strRanking = "D"
		case 5
			strRanking = "E"
	end select
end sub

call main

dim strMessageText, strRanking
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent">
    <% if session("assessment_not_found") <> "TRUE" then %>
      <!--<h1>Your Rank is: </h1>-->
      <p><a href="assessment.asp"><i class="fa fa-arrow-left"></i> Back to Skills Assessment</a></p>
      <table width="700" border="0" cellspacing="0" cellpadding="8">
        <tr>
          <td><h3>High level questions:</h3></td>
          <td><h3>Answer</h3></td>
        </tr>
        <tr class="highlighted-row">
          <td>1. Know and understand the terms used in technical specifications</td>
          <td><%= Session("q1") %></td>
        </tr>
        <tr>
          <td>2. Know the limitations for each product based on their specifications and can confirm them</td>
          <td><%= Session("q2") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>3. Have a defined procedure for dealing with &quot;No Fault Found&quot; cases</td>
          <td><%= Session("q3") %></td>
        </tr>
        <tr>
          <td>4. Can replace integrated circuits (ICs) on printed circuit boards</td>
          <td><%= Session("q4") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>5. Have a basic knowledge of music theory (chords, scales etc.)</td>
          <td><%= Session("q5") %></td>
        </tr>
        <tr>
          <td>6. Can operate Yamaha products &amp; explain the differences between different models in the same range</td>
          <td><%= Session("q6") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>7. Able to trace faults to faults to the specific circuit board</td>
          <td><%= Session("q7") %></td>
        </tr>
        <tr>
          <td colspan="2"><h3>Mid level questions:</h3></td>
        </tr>
        <tr class="highlighted-row">
          <td>8. Can set up a home network</td>
          <td><%= Session("q8") %></td>
        </tr>
        <tr>
          <td>9. Know how to disassemble and re-assemble most repair units</td>
          <td><%= Session("q9") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>10. Can diagnose and repair to component level</td>
          <td><%= Session("q10") %></td>
        </tr>
        <tr>
          <td>11. Have knowledge of common repair issues with Yamaha and can apply them</td>
          <td><%= Session("q11") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>12. Can replace circuit boards</td>
          <td><%= Session("q12") %></td>
        </tr>
        <tr>
          <td>13. Understand circuit diagrams and how the circuits work</td>
          <td><%= Session("q13") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>14. Know how to use service jigs</td>
          <td><%= Session("q14") %></td>
        </tr>
        <tr>
          <td>15. Able to repair damaged or broken circuit boards</td>
          <td><%= Session("q15") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>16. Can update software/firmware</td>
          <td><%= Session("q16") %></td>
        </tr>
        <tr>
          <td>17. Understand the following terms; Decibel, Total Harmonic Distortion, Current, Voltage</td>
          <td><%= Session("q17") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>18. Can understand and follow a block diagram</td>
          <td><%= Session("q18") %></td>
        </tr>
        <tr>
          <td colspan="2"><h3>Basic level questions:</h3></td>
        </tr>
        <tr class="highlighted-row">
          <td>19. Able to secure cables and fix them to prevent vibration</td>
          <td><%= Session("q19") %></td>
        </tr>
        <tr>
          <td>20. Can use a signal tracer to locate faults</td>
          <td><%= Session("q20") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>21. Know how to set up and use an oscilloscope to trace faults</td>
          <td><%= Session("q21") %></td>
        </tr>
        <tr>
          <td>22. Understand how to use a multimeter</td>
          <td><%= Session("q22") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>23. Can access and navigate YSISS (Yamaha Service Information Support System)</td>
          <td><%= Session("q23") %></td>
        </tr>
        <tr>
          <td>24. Understand Service News and can apply them to the related unit(s)</td>
          <td><%= Session("q24") %></td>
        </tr>
        <tr class="highlighted-row">
          <td>25. Can locate spare parts in the service manual and order using part number</td>
          <td><%= Session("q25") %></td>
        </tr>
      </table>
      <% else %>
      <h1>Sorry but Assessment ID: <%= request("id") %> cannot be found in the system.</h1>
      <% end if %>
      </td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>