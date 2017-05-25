<% strSection = "jobs" %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache, must-revalidate"
%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="class/clsJob.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<% AntiFixationVerify("default.asp") %>
<!doctype html>
<html>
<head>
<meta charset="utf-8" http-equiv="Cache-control" content="no-store">
<title>Jobs - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css">
<script>
function session_cookie_change() {
    var s, a;
    s = document.cookie.split(/\=/);
    a = s[0];
    var dtExpires = new Date();
    dtExpires.setFullYear(1970,1,1);
    a += '; expires=' + dtExpires.toGMTString();
    a += '; path=/';
    alert(a);
}

function searchJob() {
    var strID       = document.forms[0].txtID.value;
    var strASC      = document.forms[0].txtASC.value;
    var strModelNo  = document.forms[0].txtModelNo.value;
    var strDealer   = document.forms[0].txtDealer.value;
    var strStatus   = document.forms[0].cboStatus.value;

    document.location.href = "jobs.asp?type=search&id=" + strID + "&asc=" + strASC + "&modelno=" + strModelNo + "&dealer=" + strDealer + "&status=" + strStatus;
}

function resetSearch() {
    document.location.href = "jobs.asp?type=reset";
}
</script>
</head>
<body>
<%
sub setSearch
    select case (trim(request("type")))
        case "reset"
            session("adm_job_id")       = ""
            session("adm_job_asc")      = ""
            session("adm_job_model_no") = ""
            session("adm_job_dealer")   = ""
            session("adm_job_status")   = ""
        case "search"
            session("adm_job_id")       = trim(request("id"))
            session("adm_job_asc")      = trim(request("asc"))
            session("adm_job_model_no") = trim(request("modelno"))
            session("adm_job_dealer")   = trim(request("dealer"))
            session("adm_job_status")   = trim(request("status"))
    end select
end sub

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

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic
    rs.PageSize = 800

    strSQL = "SELECT tbl_job.*, DATEDIFF(dd,job_date_created,GetDate()) as elapsed_days, tbl_users.firstname as creator, dealer_code FROM tbl_job "
    strSQL = strSQL & "	INNER JOIN tbl_users ON job_created_by = user_id "
    strSQL = strSQL & "	WHERE job_created_by = '" & session("UsrUserID") & "' "
    strSQL = strSQL & "		OR dealer_code = '" & session("usr_dealer_code") & "' "

    if session("adm_job_id") <> "" then
        strSQL = strSQL & " AND job_id = " & session("adm_job_id") & " "
    end if

    if session("adm_job_asc") <> "" then
        strSQL = strSQL & " AND job_no like '%" & session("adm_job_asc") & "%' "
    end if

    if session("adm_job_model_no") <> "" then
        strSQL = strSQL & " AND model_no like '%" & session("adm_job_model_no") & "%' "
    end if

    if session("adm_job_dealer") <> "" then
        strSQL = strSQL & " AND dealer like '%" & session("adm_job_dealer") & "%' "
    end if

    if session("adm_job_status") <> "" then
        strSQL = strSQL & " AND job_status = " & session("adm_job_status") & " "
    end if

    strSQL = strSQL & " ORDER BY job_date_created DESC"

    'response.write strSQL & "<br>"

    rs.Open strSQL, conn

    intPageCount = rs.PageCount
    intRecordCount = rs.recordcount

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

            '1
            strDisplayList = strDisplayList & "<td nowrap><a href=""edit_repair.asp?job_id=" & rs("job_id") & """>" & rs("job_id") & "</a></td>"

            '2
            strDisplayList = strDisplayList & "<td nowrap>" & rs("creator") & ", <span title=" & WeekDayName(WeekDay(rs("job_date_created"))) & ">" & FormatDateTime(rs("job_date_created"),1) & "</span></td>"

            '3
            strDisplayList = strDisplayList & "<td>" & rs("job_no") & "</td>"

            '4
            strDisplayList = strDisplayList & "<td>"
            Select Case	rs("warranty")
                case 1
                    strDisplayList = strDisplayList & "<img src=""images/tick.gif"">"
                case 0
                    strDisplayList = strDisplayList & "<img src=""images/cross.gif"">"
            end select
            strDisplayList = strDisplayList & "</td>"

            '5
            strDisplayList = strDisplayList & "<td>" & rs("firstname") & " " & rs("lastname") & ""
            if DateDiff("d",rs("job_date_created"), strTodayDate) = 0 then
                strDisplayList = strDisplayList & " <img src=""images/icon_new.gif"" border=0>"
            end if
            strDisplayList = strDisplayList & "</td>"

            '6
            strDisplayList = strDisplayList & "<td>" & rs("city") & "</td>"

            '7
            strDisplayList = strDisplayList & "<td>" & rs("model_no") & "</td>"

            '8
            strDisplayList = strDisplayList & "<td>" & rs("serial_no") & "</td>"

            '9
            strDisplayList = strDisplayList & "<td>" & rs("invoice_no") & "</td>"

            '10
            strDisplayList = strDisplayList & "<td><span title=" & WeekDayName(WeekDay(rs("date_purchased"))) & ">" & FormatDateTime(rs("date_purchased"),1) & "</span></td>"

            '11
            strDisplayList = strDisplayList & "<td>" & rs("dealer") & "</td>"

            '12
            strDisplayList = strDisplayList & "<td>"
            if Len(rs("fault")) > 30 then
                strDisplayList = strDisplayList & left(rs("fault"), 30) & "hellip;"
            else
                strDisplayList = strDisplayList & rs("fault")
            end if
            strDisplayList = strDisplayList & "</td>"

            '13
            strDisplayList = strDisplayList & "<td>"
            if (DateDiff("d",rs("due_date"), strTodayDate) > 0) and rs("job_status") <> 0 and rs("job_status") <> 6 then
                strDisplayList = strDisplayList & " <span style=""color:red"">" & FormatDateTime(rs("due_date"),1) & " (Overdue)</span>"
            else
                strDisplayList = strDisplayList & "<span title=" & WeekDayName(WeekDay(rs("due_date"))) & ">" & FormatDateTime(rs("due_date"),1) & "<span>"
            end if
            strDisplayList = strDisplayList & "</td>"

            '14
            strDisplayList = strDisplayList & "<td>"
            Select Case	rs("job_status")
                case 1
                    strDisplayList = strDisplayList & "<font color=""purple"">New"
                case 2
                    strDisplayList = strDisplayList & "<font color=""blue"">Open: Repair in-progress"
                case 3
                    strDisplayList = strDisplayList & "<font color=""purple"">Open: Waiting for parts"
                case 7
                    strDisplayList = strDisplayList & "<font color=""purple"">Open: Parts dispatched"
                case 4
                    strDisplayList = strDisplayList & "<font color=""blue"">Open: Parts received"
                case 5
                    strDisplayList = strDisplayList & "<font color=""purple"">Open: Return to Yamaha for service"
                case 6
                    strDisplayList = strDisplayList & "<font color=""green"">Repair Completed"
                case 8
                    strDisplayList = strDisplayList & "<font color=""purple"">Changeover"
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
        strDisplayList = "<tr><td colspan=""14"" align=""center"" bgcolor=""#FFFFFF"">No jobs found.</td></tr>"
    end if

    strDisplayList = strDisplayList & "<tr>"
    strDisplayList = strDisplayList & "<td colspan=""14"" class=""recordspaging"">"
    strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & " jobs.</h2>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"

    call CloseDataBase()
end sub

sub main
    call setSearch

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

        if trim(session("job_initial_page")) = "" then
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
        <td class="maincontent">
            <h1>Repair Jobs</h1>
            <div class="alert alert-search">
                <form name="frmSearch" id="frmSearch" action="jobs.asp?type=search" method="post" onsubmit="searchJob()">
                    <strong>Search:</strong>
                    <input type="text" name="txtID" size="15" maxlength="20" placeholder="ID" style="display:inline;" value="<%= session("adm_job_ID") %>" />
                    <input type="text" name="txtASC" size="15" maxlength="20" placeholder="ASC Job No" style="display:inline;" value="<%= session("adm_job_ASC") %>" />
                    <input type="text" name="txtModelNo" size="15" maxlength="20" placeholder="Model No" style="display:inline;" value="<%= session("adm_job_model_no") %>" />
                    <input type="text" name="txtDealer" size="15" maxlength="20" placeholder="Dealer" style="display:inline;" value="<%= session("adm_job_dealer") %>" />
                    <select name="cboStatus" style="display:inline;" onchange="searchJob()">
                        <option <% if session("adm_job_status") = ""  then Response.Write " selected" end if%> value="">All status (except Completed &amp; Exported)</option>
                        <option <% if session("adm_job_status") = "1" then Response.Write " selected" end if%> value="1" style="color:purple;">New</option>
                        <option <% if session("adm_job_status") = "2" then Response.Write " selected" end if%> value="2" style="color:blue;">Open: Repair in-progress</option>
                        <option <% if session("adm_job_status") = "3" then Response.Write " selected" end if%> value="3" style="color:purple;">Open: Waiting for Parts</option>
                        <option <% if session("adm_job_status") = "7" then Response.Write " selected" end if%> value="7" style="color:purple;">Open: Parts dispatched</option>
                        <option <% if session("adm_job_status") = "4" then Response.Write " selected" end if%> value="4" style="color:blue;">Open: Parts received</option>
                        <option <% if session("adm_job_status") = "5" then Response.Write " selected" end if%> value="5" style="color:purple;">Open: Return to Yamaha for service</option>
                        <option <% if session("adm_job_status") = "8" then Response.Write " selected" end if%> value="8" style="color:purple;">Changeover</option>
                        <option <% if session("adm_job_status") = "6" then Response.Write " selected" end if%> value="6" style="color:green;">Repair Completed</option>
                        <option <% if session("adm_job_status") = "0" then Response.Write " selected" end if%> value="0" style="color:gray;">Exported</option>
                    </select>
                    <input type="button" name="btnSearch" value="Search" onclick="searchJob()" style="margin-bottom:0; font-size: 12px; padding:5px 10px;" />
                    <input type="button" name="btnReset" value="Reset" onclick="resetSearch()" style="margin-bottom:0; font-size: 12px; padding:5px 10px;">
                </form>
            </div>
            <table width="800" cellpadding="5" cellspacing="0" border="0">
                <tr>
                    <td valign="top">
                        <div class="alert alert-success">
                            <h3><img src="images/add_icon.png" border="0" align="bottom" /> <a href="new_repair.asp">Enter New Job</a></h3>
                        </div>
                    </td>
                    <td valign="top">
                        <table cellpadding="5" cellspacing="0" class="form_box_home">
                            <tr>
                                <td align="center">
                                    <h2>No. Repairs over 7 days: <u><%= Session("user_overdue_jobs") %></u></h2>
                                    <h3>Average Repair Time (TAT): <u><%= Session("user_KPI") %></u> day(s)</h3>
                                    <table cellspacing="0" cellpadding="5" width="400">
                                        <tr bgcolor="#CCCCCC">
                                            <td width="70%" align="center">Job status</td>
                                            <td width="30%" align="center">No of jobs</td>
                                        </tr>
                                        <%= strJobSummary %>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table cellspacing="0" cellpadding="5" class="database_records" width="100%">
                <tr class="innerdoctitle">
                    <td>ID</td>
                    <td>Created by</td>
                    <td>ASC job no</td>
                    <td>Warranty</td>
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
            </table>
        </td>
    </tr>
    <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>