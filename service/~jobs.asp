<% strSection = "jobs" %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache, must-revalidate"

dim ckiename
dim ckiefix

on error resume next

ckiename = Mid(Request.ServerVariables("HTTP_COOKIE"),1,(Instr(Request.ServerVariables("HTTP_COOKIE"),";")-1))
ckiefix = Mid(Request.ServerVariables("HTTP_COOKIE"),(Instr(Request.ServerVariables("HTTP_COOKIE"),";")+1),(len(Request.ServerVariables("HTTP_COOKIE"))-1))

if err.number <> 0 then
	response.redirect("default.asp")
end if

Response.AddHeader "Set-Cookie", ckiename & ";secure;httponly; path=/"
Response.AddHeader "Set-Cookie", ckiefix & ";secure;httponly; path=/"
%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="class/clsJob.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<% AntiFixationVerify("default.asp") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Cache-control" content="no-store">
<title>Jobs - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript">
	function session_cookie_change() {
    
	var s,a;
	
    s=document.cookie.split(/\=/);
    a=s[0];
    var dtExpires = new Date();
    dtExpires.setFullYear(1970,1,1);
    a += '; expires=' + dtExpires.toGMTString();
    a += '; path=/';
	alert(a);
}
</script>
</head>
<body>
<%
sub displayJob
	dim iRecordCount
	iRecordCount = 0
    dim strSortBy
	dim strSortItem
    dim strSQL
	dim strPageResultNumber
	dim strRecordPerPage
	dim intRecordCount
	dim strTodayDate

	strTodayDate = FormatDateTime(Date())

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic
	rs.PageSize = 800

	strSQL = "SELECT tbl_job.*, DATEDIFF(dd,job_date_created,GetDate()) as elapsed_days, tbl_users.firstname as creator, dealer_code FROM tbl_job "
	strSQL = strSQL & "	INNER JOIN tbl_users ON job_created_by = user_id "
	strSQL = strSQL & "	WHERE job_created_by = '" & session("UsrUserID") & "' "
	strSQL = strSQL & "		OR dealer_code = '" & session("usr_dealer_code") & "' "
	strSQL = strSQL & "	ORDER BY job_date_created DESC"

	'response.write strSQL & "<br>"

	rs.Open strSQL, conn

	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount

	'Select Case Request("Action")
	'    case "<<"
	'	    intpage = 1
	'		session("job_initial_page") = intpage
	'    case "<"
	'	    intpage = Request("intpage") - 1
	'		session("job_initial_page") = intpage

	'		if session("job_initial_page") < 1 then session("job_initial_page") = 1
	'    case ">"
	'	    intpage = Request("intpage") + 1
	'		session("job_initial_page") = intpage

	'		if session("job_initial_page") > intPageCount then session("job_initial_page") = IntPageCount
	'    Case ">>"
	'	    intpage = intPageCount
	'		session("job_initial_page") = intpage
    'end select

    strDisplayList = ""

	if not DB_RecSetIsEmpty(rs) Then

	    rs.AbsolutePage = session("job_initial_page")

		For intRecord = 1 To rs.PageSize
			if (DateDiff("d",rs("job_date_modified"), strTodayDate) = 0) OR (DateDiff("d",rs("job_date_created"), strTodayDate) = 0) then
				if iRecordCount Mod 2 = 0 then
					strDisplayList = strDisplayList & "<tr class=""updated_today"">"
				else
					strDisplayList = strDisplayList & "<tr class=""updated_today_2"">"
				end if
			else
				if iRecordCount Mod 2 = 0 then
					strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
				else
					strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
				end if
			end if

			strDisplayList = strDisplayList & "<td nowrap><a href=""edit_repair.asp?job_id=" & rs("job_id") & """><img src=""images/icon_view.png"" border=""0""></a></td>"
			strDisplayList = strDisplayList & "<td>" & rs("job_id") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("creator") & ", <span title=" & WeekDayName(WeekDay(rs("job_date_created"))) & ">" & FormatDateTime(rs("job_date_created"),1) & "</span></td>"
			strDisplayList = strDisplayList & "<td>" & rs("job_no") & "</td>"
			strDisplayList = strDisplayList & "<td>"
			Select Case	rs("warranty")
				case 1
					strDisplayList = strDisplayList & "<img src=""images/tick.gif"">"
				case 0
					strDisplayList = strDisplayList & "<img src=""images/cross.gif"">"
			end select
			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("firstname") & " " & rs("lastname") & ""
			if DateDiff("d",rs("job_date_created"), strTodayDate) = 0 then
				strDisplayList = strDisplayList & " <img src=""images/icon_new.gif"" border=0>"
			end if

			strDisplayList = strDisplayList & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("city") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("model_no") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("serial_no") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("invoice_no") & "</td>"
			strDisplayList = strDisplayList & "<td><span title=" & WeekDayName(WeekDay(rs("date_purchased"))) & ">" & FormatDateTime(rs("date_purchased"),1) & "</span></td>"
			strDisplayList = strDisplayList & "<td>" & rs("dealer") & "</td>"
			strDisplayList = strDisplayList & "<td>" & rs("fault") & "</td>"
			'strDisplayList = strDisplayList & "<td>" & rs("job_date_modified") & "</td>"
			'if rs("job_date_modified") = "01/01/1900" or rs("job_date_modified") = "1/1/1900" then
			'	strDisplayList = strDisplayList & "<td class=""orange_text"">NA</td>"
			'else
			'	strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("job_date_modified"),1) & "</td>"
			'end if
			'strDisplayList = strDisplayList & "<td>" & WeekDayName(WeekDay(rs("job_date_modified"))) & ", " & FormatDateTime(rs("job_date_modified"),1) & "</td>"
			strDisplayList = strDisplayList & "<td>"
			if (DateDiff("d",rs("due_date"), strTodayDate) > 0) and rs("job_status") <> 0 and rs("job_status") <> 6 then
				strDisplayList = strDisplayList & " <span style=""color:red"">" & FormatDateTime(rs("due_date"),1) & " (Overdue)</span>"
			else
				strDisplayList = strDisplayList & "<span title=" & WeekDayName(WeekDay(rs("due_date"))) & ">" & FormatDateTime(rs("due_date"),1) & "<span>"
			end if
			strDisplayList = strDisplayList & "</td>"
			'strDisplayList = strDisplayList & "<td>" & rs("elapsed_days") & " days</td>"
			strDisplayList = strDisplayList & "<td>"
			Select Case	rs("job_status")
				case 1
					strDisplayList = strDisplayList & "<font color=""purple"">New"
				case 2
					strDisplayList = strDisplayList & "<font color=""blue"">Open: Repair in-progress"
				case 3
					strDisplayList = strDisplayList & "<font color=""purple"">Open: Waiting for parts"
				case 4
					strDisplayList = strDisplayList & "<font color=""blue"">Open: Parts received"
				case 5
					strDisplayList = strDisplayList & "<font color=""purple"">Open: Return to Yamaha for service"
				case 6
					strDisplayList = strDisplayList & "<font color=""green"">Repair Completed"
				case 0
					strDisplayList = strDisplayList & "<font color=""gray"">Exported"
			end select
			strDisplayList = strDisplayList & "</font></td>"
			strDisplayList = strDisplayList & "</tr>"

			rs.movenext
			iRecordCount = iRecordCount + 1
			If rs.EOF Then Exit For
		next
	else
        strDisplayList = "<tr><td colspan=""15"" align=""center"" bgcolor=""#FFFFFF"">No jobs found.</td></tr>"
	end if

	strDisplayList = strDisplayList & "<tr>"
	strDisplayList = strDisplayList & "<td colspan=""15"" class=""recordspaging"">"
	'strDisplayList = strDisplayList & "<form name=""MovePage"" action=""jobs.asp"" method=""post"">"
    'strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("job_initial_page") & ">"

	'if session("job_initial_page") = 1 then
   	'	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
    '	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
	'else
	'	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
    '	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
	'end if
	'if session("job_initial_page") = intpagecount or intRecordCount = 0 then
    '	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
    '	strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
	'else
	'	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
    '	strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
	'end if
    'strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
	'strDisplayList = strDisplayList & "<input type=""hidden"" name=""cboStatus"" value=" & strStatus & ">"
    'strDisplayList = strDisplayList & "<br />"
    'strDisplayList = strDisplayList & "Page: " & session("job_initial_page") & " to " & intpagecount
	strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & " jobs.</h2>"
    'strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"

    call CloseDataBase()
end sub

sub main
	if not Request.ServerVariables("REQUEST_METHOD") = "POST" then
		call UTL_validateLogin
		call getUserDetails(Session("UsrUserID"))
		call calculateOverdueJobs(Session("usr_dealer_code"))
		call calculateAverageRepairTime(Session("usr_dealer_code"))
		call listJobSummary(Session("usr_dealer_code"))
		
		dim username
		dim password 
		
		username = Session("UsrUserID")
		password = Session("UsrPassword")
		
		if trim(session("job_initial_page"))  = "" then
			session("job_initial_page") = 1
		end if
	
		call displayJob
	end if
end sub

call main

dim rs, intPageCount, intpage, intRecord, strDisplayList, strJobSummary
%>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent"><h1>Repair Jobs</h1>
      <table width="800" cellpadding="5" cellspacing="0" border="0">
        <tr>
          <td valign="top"><div class="alert alert-success">
              <h3><img src="images/add_icon.png" border="0" align="bottom" /> <a href="new_repair.asp">Enter New Job</a></h3>
            </div></td>
          <td valign="top"><table cellpadding="5" cellspacing="0" class="form_box_home">
              <tr>
                <td align="center"><h2>No. Repairs over 7 days: <u><%= Session("user_overdue_jobs") %></u></h2>
                  <h3>Average Repair Time (TAT): <u><%= Session("user_KPI") %></u> day(s)</h3>
                  <table cellspacing="0" cellpadding="5" width="400">
                    <tr bgcolor="#CCCCCC">
                      <td width="70%" align="center">Job status</td>
                      <td width="30%" align="center">No of jobs</td>
                    </tr>
                    <%= strJobSummary %>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table cellspacing="0" cellpadding="4" class="database_records" width="100%">
        <tr class="innerdoctitle">
          <td>&nbsp;</td>
          <td>Repair ID</td>
          <td>Created by</td>
          <td>ASC job no</td>
          <td>Warranty?</td>
          <td>Customer</td>
          <td>City</td>
          <td>Model no</td>
          <td>Serial no</td>
          <td>Invoice no</td>
          <td>Purchased</td>
          <td>Dealer</td>
          <td>Fault</td>
          <td>Due</td>
          <td>Status</td>
        </tr>
        <%= strDisplayList %>
      </table></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>