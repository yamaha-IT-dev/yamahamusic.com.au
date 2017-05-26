<%
dim strSection
strSection = "order"
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
<title>Back Orders</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/justified-nav.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script>
function searchItem() {
    var strSearch = document.forms[0].txtSearch.value;
    document.location.href = 'backorder.asp?type=search&txtSearch=' + strSearch;
}

function resetSearch() {
    document.location.href = 'backorder.asp?type=reset';
}
</script>
</head>
<body>
<%
Response.Write(session("user_truncate_dealercode"))

sub setSearch
    select case trim(request("type"))
        case "reset" 
            session("backorder_search")         = ""
            session("backorder_initial_page")   = 1
        case "search"
            session("backorder_search")         = server.htmlencode(trim(Request("txtSearch")))
            session("backorder_initial_page")   = 1
    end select
end sub

sub displayBackorder
    dim strSQL

    dim iRecordCount
    iRecordCount = 0

    dim strTodayDate
    strTodayDate = FormatDateTime(Date())

    dim intRecordCount

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation = 3   'adUseClient
    rs.CursorType = 3       'adOpenStatic
    rs.PageSize = 200

    strSQL = "SELECT *, "
    strSQL = strSQL & " case when boStatus = 2 and 'Y' = (select 'Y' from tbl_intransitexclusion where boItemCode like ItemCode) then 0 else boStatus end as boNewStatus, "
    strSQL = strSQL & " case when boStatus = 2 and 'Y' = (select 'Y' from tbl_intransitexclusion where boItemCode like ItemCode) then 0 else boDockDay end as boNewDockDay"
    strSQL = strSQL & " FROM tbl_backorder "
    strSQL = strSQL & "	WHERE "
    strSQL = strSQL & "		(boPurchaseOrder LIKE '%" & session("backorder_search") & "%'"
    strSQL = strSQL & "			OR boOrderNo LIKE '%" & session("backorder_search") & "%'"
    strSQL = strSQL & "			OR boItemName LIKE '%" & session("backorder_search") & "%'"
    strSQL = strSQL & "			OR boItemDescription LIKE '%" & session("backorder_search") & "%'"
    strSQL = strSQL & "			OR boItemCode LIKE '%" & session("backorder_search") & "%')"
    If session("user_truncate_dealercode") = "True" Then
        strSQL = strSQL & "     AND boDealerCode LIKE '%" & left(session("user_dealercode"), 6) & "%'"
    Else
        strSQL = strSQL & "     AND boDealerCode LIKE '" & session("user_dealercode") & "'"
    End If
    strSQL = strSQL & "	ORDER BY boRequestYear ASC, boRequestMonth ASC, boRequestDay ASC"

    'response.write strSQL & "<br>"
    rs.Open strSQL, conn

    intPageCount = rs.PageCount
    intRecordCount = rs.recordcount

    Select Case Request("Action")
        case "<<"
            intpage = 1
            session("backorder_initial_page") = intpage
        case "<"
            intpage = Request("intpage") - 1
            session("backorder_initial_page") = intpage

            if session("backorder_initial_page") < 1 then session("backorder_initial_page") = 1
        case ">"
            intpage = Request("intpage") + 1
            session("backorder_initial_page") = intpage

            if session("backorder_initial_page") > intPageCount then session("backorder_initial_page") = IntPageCount
        Case ">>"
            intpage = intPageCount
            session("backorder_initial_page") = intpage
    end select

    strDisplayList = ""

    if not DB_RecSetIsEmpty(rs) Then

        rs.AbsolutePage = session("backorder_initial_page")

        For intRecord = 1 To rs.PageSize
            if iRecordCount Mod 2 = 0 then
                strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
            else
                strDisplayList = strDisplayList & "<tr class=""innerdoc_2"">"
            end if
            strDisplayList = strDisplayList & "<td>" & rs("boRequestDay") & "/" & rs("boRequestMonth") & "/" & rs("boRequestYear") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("boPurchaseOrder") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("boOrderNo") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("boItemCode") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("boItemDescription") & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("boQty") & "</td>"
            strDisplayList = strDisplayList & "<td>" & FormatNumber(rs("boPriceNet")) & "</td>"
            strDisplayList = strDisplayList & "<td>" & FormatNumber(rs("boPriceTotal")) & "</td>"
            if Trim(rs("boNewDockDay")) = "0" then
                strDisplayList = strDisplayList & "<td>TBC</td>"
            else
                strDisplayList = strDisplayList & "<td>" & rs("boDockDay") & "/" & rs("boDockMonth") & "/" & rs("boDockYear") & "</td>"
            end if

            strDisplayList = strDisplayList & "<td><font color="
            Select Case trim(rs("boNewStatus"))
                case 0
                    strDisplayList = strDisplayList & "red>TBC"
                case 1
                    strDisplayList = strDisplayList & "blue>Purchase ordered"
                case 2
                    strDisplayList = strDisplayList & "purple>In transit"
                case 3
                    strDisplayList = strDisplayList & "blue>Allocated"
                case 4
                    strDisplayList = strDisplayList & "green>Ready to be shipped"
                case 5
                    strDisplayList = strDisplayList & "gray>Shipped"
                case 6
                    strDisplayList = strDisplayList & "gray>Invoiced"
                case else
                    strDisplayList = strDisplayList & rs("Status")
            end select
            strDisplayList = strDisplayList & "</font></td>"
            strDisplayList = strDisplayList & "</tr>"

            rs.movenext
            iRecordCount = iRecordCount + 1
            If rs.EOF Then Exit For
        next
    else
        strDisplayList = "<tr><td colspan=""10"" align=""center"">No back orders found.</td></tr>"
    end if

    strDisplayList = strDisplayList & "<tr>"
    strDisplayList = strDisplayList & "<td colspan=""10"" align=""center"">"
    strDisplayList = strDisplayList & "<form name=""MovePage"" action=""backorder.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("backorder_initial_page") & ">"

    if session("backorder_initial_page") = 1 then
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
    else
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
    end if
    if session("backorder_initial_page") = intpagecount or intRecordCount = 0 then
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
    else
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
    end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
    strDisplayList = strDisplayList & "<br />"
    strDisplayList = strDisplayList & "Page: " & session("backorder_initial_page") & " to " & intpagecount
    strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & "</h2>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"

    call CloseDataBase()
end sub

sub main
    call validateLogin
    call setSearch

    if trim(session("backorder_initial_page"))  = "" then
        session("backorder_initial_page") = 1
    end if

    call displayBackorder
end sub

call main

dim rs
dim intPageCount, intpage, intRecord
dim strDisplayList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
    <tr>
        <td class="main_content">
            <ol class="breadcrumb">
                <li><a href="../home/">Home</a></li>
                <li><a href="./">Order</a></li>
                <li class="active">Back Orders</li>
            </ol>
            <div class="masthead">
                <nav>
                    <ul class="nav nav-justified">
                        <li><a href="./">NEW PURCHASE ORDER</a></li>
                        <li><a href="purchase-orders.asp">YOUR PURCHASE ORDERS</a></li> 
                        <li class="active"><a>YOUR BACK ORDERS</a></li>
                    </ul>
                </nav>
            </div>
            <h1>Back Orders</h1>
            <br>
            <form name="frmSearch" id="frmSearch" action="backorder.asp?type=search" method="post" onsubmit="searchItem()">
                <div class="float_left">
                    <input type="text" class="form-control" name="txtSearch" size="50" value="<%= request("txtSearch") %>" maxlength="20" placeholder="Search Purchase order / Item / Description" />
                </div>
                <div class="float_left">
                    <input type="button" class="btn btn-primary" name="btnSearch" value="Search" onclick="searchItem()" />
                </div>
                <div class="float_left">
                    <input type="button" class="btn btn-primary" name="btnReset" value="Reset" onclick="resetSearch()" />
                </div>
            </form>
        </td>
    </tr>
    <tr>
        <td>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <td>Date Requested</td>
                        <td>Purchase Order</td>
                        <td>BASE Order No</td>
                        <td>Item</td>
                        <td>Description</td>
                        <td>Qty</td>
                        <td>Cost Ex-GST</td>
                        <td>Total Ex-GST</td>
                        <td>ETA</td>
                        <td>Status</td>
                    </tr>
                </thead>
                <%= strDisplayList %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>