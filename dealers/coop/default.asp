<%
dim strSection
strSection = "coop"
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
<title>Co-op Requests</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%
sub displayBooking
    dim strSQL

    dim intRecordCount

    dim iRecordCount
    iRecordCount = 0

    dim strTodayDate
    strTodayDate = FormatDateTime(Date())

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation   = 3     'adUseClient
    rs.CursorType       = 3     'adOpenStatic
    rs.PageSize         = 90000

    strSQL = "SELECT * FROM tbl_coop"
    strSQL = strSQL & " WHERE"
    strSQL = strSQL & "     coopCreatedBy = '" & session("yma_userid") & "'"
    strSQL = strSQL & " ORDER BY coopDateCreated DESC"

    'response.write "<font color=white>" & strSQL & "</font><br>"

    rs.Open strSQL, conn

    intPageCount        = rs.PageCount
    intRecordCount      = rs.recordcount

    strDisplayList = ""

    if not DB_RecSetIsEmpty(rs) Then
        For intRecord = 1 To rs.PageSize
            if iRecordCount Mod 2 = 0 then
                strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
            else
                strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
            end if
            'strDisplayList = strDisplayList & "<td nowrap><a href=""update-coop.asp?id=" & rs("coopID") & """>" & rs("coopID") & "</a></td>"
            strDisplayList = strDisplayList & "<td>" & rs("coopID") & "</td>"
            strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("coopDateCreated"),2) & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("coopName") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("coopBudget") & "</td>"
            strDisplayList = strDisplayList & "<td>"
            Select Case	rs("coopStatus")
                case 1
                    strDisplayList = strDisplayList & "<font color=""blue"">Submitted"
                case 2
                    strDisplayList = strDisplayList & "<font color=""green"">Approved"
                case 3
                    strDisplayList = strDisplayList & "<font color=""red"">Rejected"
                case 0
                    strDisplayList = strDisplayList & "<font color=""gray"">Completed"
            end select
            strDisplayList = strDisplayList & "</font></td>"
            strDisplayList = strDisplayList & "<td>" & rs("coopComments") & "</td>"
            strDisplayList = strDisplayList & "<td><a href=""../resources/new-asset.asp?id=" & rs("coopID") & "&type=3""><button type=""button"" class=""btn btn-primary"">UPLOAD FILES &raquo;</button></td>"
            strDisplayList = strDisplayList & "</tr>"

            rs.movenext
            iRecordCount = iRecordCount + 1
            If rs.EOF Then Exit For
        next
    else
        strDisplayList = "<tr><td colspan=""7"" align=""center"">No co-ops found.</td></tr>"
    end if

    strDisplayList = strDisplayList & "<tr><td colspan=""7"" align=""center""><h2>Total: " & intRecordCount & "</h2></td></p>"

    call CloseDataBase()
end sub

sub main
    call validateLogin
    call displayBooking
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
                <li class="active">Co-op</li>
            </ol>
            <h1>Co-op Requests</h1>
            <a href="new-coop.asp">
                <button type="button" class="btn btn-primary btn-lg">New Co-op  &raquo;</button>
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <td>Coop ID</td>
                        <td>Requested</td>
                        <td>Name</td>
                        <td>Budget</td>
                        <td>Status</td>
                        <td>Yamaha's Notes</td>
                        <td>Please note that you can upload multiple files:</td>
                    </tr>
                </thead>
                <%= strDisplayList %>
            </table>
        </td>
    </tr>
    <tr>
        <td class="main_content">
            <div class="alert alert-info" role="alert">
                <p><strong>THE DEALER’S CHECKLIST</strong></p>
                <ul>
                    <li>You have the stock available in-store to support this marketing initiative for the duration of the promotion.</li>
                    <li>All relevant sections of this form are completed.</li>
                    <li>If it’s a media request and you have already sourced the placement, please attach details of the media schedule outlining exactly where and when you are placing the media (Eg. radio and TV schedules; or if you know which page the print advertisement will appear on etc.).</li>
                    <li>If you already have artwork, TVC or radio commercial completed, please attach a copy of the artwork for YMA to review. It must still be in editable form, that is, YMA can suggest changes. Please note, that Yamaha Music Australia’s exposure will be analysed prior to approval.</li>
                    <li>Attach copies of all third party supplier quotes with transparency of costs. This applies to all requests.</li>
                    <li>Send email to <a href="mailto:marketing-aus@music.yamaha.com">marketing-aus@music.yamaha.com</a>.</li>
                </ul>
                <p>&nbsp;</p>
                <p><strong>IMPORTANT:</strong></p>
                <ul>
                    <li>If it is authorised you will receive a Co-op Approval Number (CAN). Please reference this code on your final invoice. The CAN must appear on your final invoice; otherwise, payment will not be processed.</li>
                    <li>Please note: Yamaha Music Australia will not accept invoices direct from third party suppliers.</li>
                    <li>The dealer must supply a tax invoice on the store’s letterhead, and attach all relevant third party supplier invoices (not just statements, must include all original invoice pages and/or outlines from the third party).</li>
                    <li>Proof of marketing activity (photos, photocopies, mp3s, newspaper pages, screen grabs, copy of commercials, and statistics from radio, TV and web outlets) must also accompany the tax invoice; otherwise payment will not be processed.</li>
                    <li>If proof of the marketing activity is not supplied or does not reflect the agreed co-op request, then this will result in Yamaha Music Australia refusing the claim for funding on this marketing activity; that is, payment will not be processed.</li>
                    <li>If you do not have stock available in-store to support this marketing initiative for the duration of the promotion, then this will result in Yamaha Music Australia refusing the claim for funding of this marketing activity; that is, payment will not be processed.</li>
                    <li>If at the time you submit this form, you have the stock in-store, then your situation changes, and you no longer have the stock, and you have not re-ordered stock to support the promotion, then this will result in Yamaha Music Australia refusing the claim for funding of this marketing activity; that is, payment will not be processed.</li>
                    <li>If your stock has been ordered to support this promotion, and you are on credit hold, which results in the stock not being delivered in time for the promotion, then this will also result in Yamaha Music Australia refusing the claim for funding this marketing activity; that is, payment will not be processed.</li>
                    <li>Reminder that at no time can co-op funds be used to pay-off accounts or to purchase stock.</li>
                </ul>
          </div>
        </td>
    </tr>
</table>
</body>
</html>