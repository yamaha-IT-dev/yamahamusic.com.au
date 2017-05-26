<%
dim strSection
strSection = "booking"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsUser.asp " -->
<!--#include file="../class/clsBooking.asp " -->
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
<title>Bookings</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%
Sub displayBooking
    Dim strSQL

    Dim intRecordCount

    Dim iRecordCount
    iRecordCount = 0

    Dim strTodayDate
    strTodayDate = FormatDateTime(Date())

    Call OpenDataBase()

    Set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation   = 3         'adUseClient
    rs.CursorType       = 3         'adOpenStatic
    rs.PageSize         = 90000

    strSQL = "SELECT * FROM tbl_connect_request"
    strSQL = strSQL & "	WHERE"
    strSQL = strSQL & "		reqCreatedBy = '" & session("yma_userid") & "'"
    strSQL = strSQL & "	ORDER BY reqDateCreated DESC"

    'response.write "<font color=white>" strSQL & "</font><br>"

    rs.Open strSQL, conn

    intPageCount        = rs.PageCount
    intRecordCount      = rs.recordcount

    strDisplayList = ""

    If Not DB_RecSetIsEmpty(rs) Then
        For intRecord = 1 To rs.PageSize
            If iRecordCount Mod 2 = 0 Then
                strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
            Else
                strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
            End If
            strDisplayList = strDisplayList & "<td nowrap><a href=""update-booking.asp?id=" & rs("reqID") & """>" & rs("reqID") & "</a></td>"
            strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("reqDateCreated"),2) & "</td>"
            strDisplayList = strDisplayList & "<td>"
            Select Case Trim(rs("reqCategory"))
                Case 1 strDisplayList = strDisplayList & "Demo"
                Case 2 strDisplayList = strDisplayList & "Event"
                Case 3 strDisplayList = strDisplayList & "Training"
                Case 4 strDisplayList = strDisplayList & "Product Training"
            End Select
            strDisplayList = strDisplayList & "</td>"
            strDisplayList = strDisplayList & "<td class=""nowrap"">"
            If Trim(rs("reqCategory")) = 4 Then
                'Display a human readable list of modules
                Dim moduleArray
                moduleArray = Split(rs("reqName"), ",")
                For i = 0 to UBound(moduleArray)
                    strDisplayList = strDisplayList & getProductTrainingName(moduleArray(i)) & "<br>"
                Next
            Else
                strDisplayList = strDisplayList & rs("reqName") & "</td>"
            End If
            strDisplayList = strDisplayList & "<td>" & rs("reqType") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("reqAudience") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("reqVenue") & "</td>"
            strDisplayList = strDisplayList & "<td>" & FormatDateTime(rs("reqDate"),2) & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("reqTime") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("reqDuration") & "</td>"
            strDisplayList = strDisplayList & "<td>"
            Select Case rs("reqStatus")
                Case 1 strDisplayList = strDisplayList & "<font color=""blue"">Submitted"
                Case 2 strDisplayList = strDisplayList & "<font color=""green"">Approved"
                Case 3 strDisplayList = strDisplayList & "<font color=""red"">Rejected"
                Case 0 strDisplayList = strDisplayList & "<font color=""gray"">Completed"
            End Select
            strDisplayList = strDisplayList & "</font></td>"
            strDisplayList = strDisplayList & "<td>" & rs("reqNotes") & "</td>"
            strDisplayList = strDisplayList & "</tr>"

            rs.movenext
            iRecordCount = iRecordCount + 1
            If rs.EOF Then Exit For
        Next
    Else
        strDisplayList = "<tr><td colspan=""12"" align=""center"">No bookings found.</td></tr>"
    End If

    strDisplayList = strDisplayList & "<tr><td colspan=""12"" align=""center""><h2>Total: " & intRecordCount & "</h2></td></p>"

    Call CloseDataBase()
End Sub

Sub main
    Call validateLogin
    Call displayBooking
End Sub

Call main

Dim rs, intPageCount, intRecord, strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
    <tr>
        <td class="main_content">
            <ol class="breadcrumb">
                <li><a href="../home/">Home</a></li>
                <li class="active">Booking</li>
            </ol>
            <h1>Demonstrator / Event / Training / Product Training Booking</h1>
            <p>Would you like to book a Demonstrator / Event / Product Training? To start the process please click on the below "New Booking" link. Once we receive it at head office, we will notify you and let you know if we are able to accommodate your booking.</p>
            <p>
                <a href="new-booking.asp"><button type="button" class="btn btn-primary btn-lg">New Booking &raquo;</button></a>
                <!-- <% If Session("user_focus") = "True" Then %>
                <a href="new-booking-focus.asp"><button type="button" class="btn btn-success btn-lg">New FOCUS Training Programme Booking &raquo;</button></a>
                <% End If %> -->
            </p>
        </td>
    </tr>
    <tr>
        <td>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <td><strong>Booking ID</strong></td>
                            <td><strong>Requested</strong></td>
                            <td><strong>Category</strong></td>
                            <td><strong>Name</strong></td>
                            <td><strong>Type</strong></td>
                            <td><strong>Audience</strong></td>
                            <td><strong>Venue</strong></td>
                            <td><strong>Date</strong></td>
                            <td><strong>Time</strong></td>
                            <td><strong>Duration</strong></td>
                            <td><strong>Status</strong></td>
                            <td><strong>Yamaha's Notes</strong></td>
                        </tr>
                    </thead>
                    <%= strDisplayList %>
                </table>
            </div>
        </td>
    </tr>
</table>
</body>
</html>