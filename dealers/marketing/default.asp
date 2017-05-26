<%
dim strSection
strSection = "marketing"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsMarketingOrder.asp " -->
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
<title>Marketing Materials</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/justified-nav.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../../js/main.js"></script>
<script>
function searchItem() {
    var strSearch   = document.forms[0].txtSearch.value;
    var strType     = document.forms[0].cboType.value;
    var strCategory = document.forms[0].cboCategory.value;

    document.location.href = '?type=search&txtSearch=' + strSearch + '&typeid=' + strType + '&category=' + strCategory;
}

function resetSearch() {
    document.location.href = '?type=reset';
}

function validateOrder(theForm) {
    var reason = "";
    var blnSubmit = true;

    reason += validateNumeric(theForm.txtQty,"Qty");

    if (reason != "") {
        alert("Some fields need correction:\n" + reason);
        blnSubmit = false;
        return false;
    }

    if (blnSubmit == true) {
        theForm.command.value = 'order';
        return true;
    }
}

function validateBanner(theForm) {
    var reason = "";
    var blnSubmit = true;

    reason += validateNumeric(theForm.txtQty,"Qty");
    reason += validateNumeric(theForm.txtWidth,"Width");
    reason += validateNumeric(theForm.txtHeight,"Height");

    if (reason != "") {
        alert("Some fields need correction:\n" + reason);
        blnSubmit = false;
        return false;
    }

    if (blnSubmit == true) {
        theForm.command.value = 'banner';
        return true;
    }
}
</script>
</head>
<body>
<%
sub setSearch
    select case trim(request("type"))
        case "reset"
            session("resource_search_keyword")  = ""
            session("resource_search_type")     = ""
            session("resource_search_category") = ""
            session("resource_initial_page")    = 1
        case "search"
            session("resource_search_keyword")  = Server.URLEncode(Trim(Request("txtSearch")))
            session("resource_search_type")     = Server.URLEncode(Trim(Request("typeid")))
            session("resource_search_category") = Server.URLEncode(Trim(Request("category")))
            session("resource_initial_page")    = 1

            'Allow certain special characters
            session("resource_search_keyword")  = Replace(session("resource_search_keyword"),"+"," ")
            session("resource_search_keyword")  = Replace(session("resource_search_keyword"),"%2D","-")
    end select
end sub

'-----------------------------------------------
' GET CATEGORIES
'-----------------------------------------------
function getResourceCategoryList
    dim strSQL
    dim rs
    dim strCategory

    call OpenDataBase()

    strSQL = "SELECT DISTINCT title, id FROM ymadex_category"
    strSQL = strSQL & "	ORDER BY title"

    set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    strCategoryList = strCategoryList & "<option value=''>All Categories</option>"

    if not DB_RecSetIsEmpty(rs) Then
        do until rs.EOF
            intCategoryID   = Trim(rs("id"))
            strCategory     = Trim(rs("title"))

            if Trim(Session("resource_search_category")) = intCategoryID then
                strCategoryList = strCategoryList & "<option selected value=" & intCategoryID & ">" & strCategory & "</option>"
            else
                strCategoryList = strCategoryList & "<option value=" & intCategoryID & ">" & strCategory & "</option>"
            end if
        rs.Movenext
        loop
    end if

    call CloseDataBase()
end function

'-----------------------------------------------
' GET RESOURCE TYPES
'-----------------------------------------------
function getResourceTypeList
    dim strSQL
    dim rs
    dim strType

    call OpenDataBase()

    strSQL = "SELECT DISTINCT name, id FROM ymadex_resourcetype WHERE division = 'MPD' AND status = 1"
    strSQL = strSQL & "	ORDER BY name"

    set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)

    strTypeList = strTypeList & "<option value=''>All Types</option>"

    if not DB_RecSetIsEmpty(rs) Then
        do until rs.EOF
            intTypeID   = Trim(rs("id"))
            strType     = trim(rs("name"))

            if Trim(Session("resource_search_type")) = intTypeID then
                strTypeList = strTypeList & "<option selected value=" & intTypeID & ">" & strType & "</option>"
            else
                strTypeList = strTypeList & "<option value=" & intTypeID & ">" & strType & "</option>"
            end if
        rs.Movenext
        loop
    end if

    call CloseDataBase()
end function

sub displayResources
    dim strSQL

    dim iRecordCount
    iRecordCount = 0

    dim intRecordCount

    dim strTodayDate
    strTodayDate = FormatDateTime(Date())

    call OpenDataBase()

    set rs = Server.CreateObject("ADODB.recordset")

    rs.CursorLocation   = 3	'adUseClient
    rs.CursorType       = 3	'adOpenStatic
    rs.PageSize         = 100

    strSQL = "SELECT R.id, R.datecreated, R.typeid, R.categoryid, R.name, R.description, R.onrequest, R.filesrcsm AS thumbnail, R.filesrclg AS filename, "
    strSQL = strSQL & "	T.name AS type, C.title AS category, ordID, ordQty "
    strSQL = strSQL & " FROM ymadex_resource R"
    strSQL = strSQL & " LEFT JOIN tbl_connect_order O ON O.ordResourceID = R.id AND (SELECT TOP 1 ordID FROM tbl_connect_order WHERE ordResourceID = R.id ORDER BY ordID DESC) = O.ordID"
    strSQL = strSQL & "	AND O.ordCreatedBy = '" & session("yma_userid") & "' "
    strSQL = strSQL & " INNER JOIN ymadex_resourcetype T ON T.id = R.typeid"
    strSQL = strSQL & " INNER JOIN ymadex_category C ON C.id = R.categoryid"
    strSQL = strSQL & "	WHERE R.status = 1"
    strSQL = strSQL & "		AND	(R.name LIKE '%" & session("resource_search_keyword") & "%'"
    strSQL = strSQL & "			OR R.description LIKE '%" & session("resource_search_keyword") & "%'"
    strSQL = strSQL & " 		)"
    if session("resource_search_type") <> "" then
        strSQL = strSQL & "	AND R.typeid = '" & session("resource_search_type") & "' "
    end if
    if session("resource_search_category") <> "" then
        strSQL = strSQL & "	AND R.categoryid = '" & session("resource_search_category") & "' "
    end if

    strSQL = strSQL & " ORDER BY R.datecreated DESC"

    'response.write "<font color=white>" & strSQL & "</font>"

    rs.Open strSQL, conn

    intPageCount = rs.PageCount
    intRecordCount = rs.recordcount

    Select Case Request("Action")
        case "<<"
            intpage = 1
            session("resource_initial_page") = intpage
        case "<"
            intpage = Request("intpage") - 1
            session("resource_initial_page") = intpage

            if session("resource_initial_page") < 1 then session("resource_initial_page") = 1
        case ">"
            intpage = Request("intpage") + 1
            session("resource_initial_page") = intpage

            if session("resource_initial_page") > intPageCount then session("resource_initial_page") = IntPageCount
        Case ">>"
            intpage = intPageCount
            session("resource_initial_page") = intpage
    end select

    strDisplayList = ""

    if not DB_RecSetIsEmpty(rs) Then

        rs.AbsolutePage = session("resource_initial_page")

        For intRecord = 1 To rs.PageSize
            strDisplayList = strDisplayList & "<tr class=""innerdoc"">"
            'strDisplayList = strDisplayList & "<td>" & rs("id") & "</td>"
            strDisplayList = strDisplayList & "<td>"
            if isnull(rs("thumbnail")) or trim(rs("thumbnail")) = "" then
                strDisplayList = strDisplayList & "-"
            else
                strDisplayList = strDisplayList & "<a href=""" & trim(rs("thumbnail")) & """ class=""preview"" target=""_blank""><img src=""" & rs("thumbnail") & """ border=""0"" class=""thumb_preview""></a>"
            end if
            strDisplayList = strDisplayList & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("type") & " / " & rs("category") & "</td>"
            'strDisplayList = strDisplayList & "<td><span title=""" & Trim(rs("description")) & """>" & rs("name") & "</span>"
            strDisplayList = strDisplayList & "<td><strong>" & rs("name") & "</strong>"
            if DateDiff("d",rs("datecreated"), strTodayDate) = 0 then
                strDisplayList = strDisplayList & " <img src=""../images/icon_new.gif"" border=""0"">"
            end if
            strDisplayList = strDisplayList & "</td>"
            strDisplayList = strDisplayList & "<td>" & rs("description") & "</td>"
            strDisplayList = strDisplayList & "<td>"
            if isnull(rs("filename")) or trim(rs("filename")) = "" then
                strDisplayList = strDisplayList & ""
            else
                strDisplayList = strDisplayList & "<a href=""" & rs("filename") & """ target=""_blank""><img src=""../images/icon_download.png"" title=""Download file"" border=""0""></a>"
            end if
            strDisplayList = strDisplayList & "</td>"
            strDisplayList = strDisplayList & "<td class=""content_column"" nowrap>"
            if rs("onrequest") = 1 then
                if rs("typeid") = 10 then
                    strDisplayList = strDisplayList & "<form name=""form_order"" id=""form_order"" method=""post"" onsubmit=""return validateBanner(this)"">"
                    strDisplayList = strDisplayList & "<div class=""float_left""><input type=""text"" class=""form-control"" id=""txtQty"" name=""txtQty"" placeholder=""Qty"" maxlength=""2"" size=""2"" value=""1""></div>"
                    strDisplayList = strDisplayList & "<div class=""float_left""><input type=""text"" class=""form-control"" id=""txtWidth"" name=""txtWidth"" placeholder=""Width"" maxlength=""4"" size=""2""></div>"
                    strDisplayList = strDisplayList & "<div class=""float_left""><input type=""text"" class=""form-control"" id=""txtHeight"" name=""txtHeight"" placeholder=""Height"" maxlength=""4"" size=""2""></div>"
                    strDisplayList = strDisplayList & "<div class=""float_left""><select class=""form-control"" id=""cboOrientation"" name=""cboOrientation"">"
                    strDisplayList = strDisplayList & "<option value=""1"">Static</option>"
                    strDisplayList = strDisplayList & "<option value=""2"">Animated</option>"
                    strDisplayList = strDisplayList & "</select></div>"
                    strDisplayList = strDisplayList & "<div class=""float_left""><input type=""hidden"" name=""command"" value=""banner"">"
                    strDisplayList = strDisplayList & "<input type=""hidden"" name=""id"" value=""" & rs("id") & """>"
                    strDisplayList = strDisplayList & "<input type=""submit"" class=""btn btn-primary"" value=""Order"" onclick=""return confirm('Please confirm to order this web banner " & rs("name") & "?');"" />"
                    strDisplayList = strDisplayList & "</div></form>"
                else
                    strDisplayList = strDisplayList & "<form name=""form_order"" id=""form_order"" method=""post"" onsubmit=""return validateOrder(this)"">"
                    strDisplayList = strDisplayList & "<div class=""float_left""><input type=""text"" class=""form-control"" id=""txtQty"" name=""txtQty"" placeholder=""Qty"" maxlength=""2"" size=""2"" value=""1""></div>"
                    strDisplayList = strDisplayList & "<div class=""float_left""><input type=""hidden"" name=""command"" value=""order"">"
                    strDisplayList = strDisplayList & "<input type=""hidden"" name=""id"" value=""" & rs("id") & """>"
                    strDisplayList = strDisplayList & "<input type=""submit"" class=""btn btn-primary"" value=""Order"" onclick=""return confirm('Please confirm to order this " & rs("name") & "?');"" />"
                    strDisplayList = strDisplayList & "</div></form>"
                end if
            end if
            strDisplayList = strDisplayList & "</td>"
            strDisplayList = strDisplayList & "<td><h2>" & rs("ordQty") & "</h2></td>"
            strDisplayList = strDisplayList & "</tr>"

            rs.movenext
            iRecordCount = iRecordCount + 1
            If rs.EOF Then Exit For
        next
    else
        strDisplayList = "<tr><td colspan=""7"" align=""center"">No marketing materials found.</td></tr>"
    end if

    strDisplayList = strDisplayList & "<tr>"
    strDisplayList = strDisplayList & "<td colspan=""7"" align=""center"">"
    strDisplayList = strDisplayList & "<form name=""MovePage"" action=""default.asp"" method=""post"">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""intpage"" value=" & session("resource_initial_page") & ">"

    if session("resource_initial_page") = 1 then
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<<"">"
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value=""<"">"
    else
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<<"">"
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value=""<"">"
    end if
    if session("resource_initial_page") = intpagecount or intRecordCount = 0 then
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">"">"
        strDisplayList = strDisplayList & "<input disabled type=""submit"" name=""action"" value="">>"">"
    else
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">"">"
        strDisplayList = strDisplayList & "<input type=""submit"" name=""action"" value="">>"">"
    end if
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""txtSearch"" value=" & strSearch & ">"
    strDisplayList = strDisplayList & "<input type=""hidden"" name=""cboCategory"" value=" & strStatus & ">"
    strDisplayList = strDisplayList & "<br />"
    strDisplayList = strDisplayList & "Page: " & session("resource_initial_page") & " to " & intpagecount
    strDisplayList = strDisplayList & "<h2>Total: " & intRecordCount & "</h2>"
    strDisplayList = strDisplayList & "</form>"
    strDisplayList = strDisplayList & "</td>"
    strDisplayList = strDisplayList & "</tr>"

    call CloseDataBase()
end sub

sub main
    call validateLogin
    call setSearch

    if Request.ServerVariables("REQUEST_METHOD") = "POST" then
        dim intResourceID, intQty, intWidth, intHeight, intOrientation

        intResourceID   = Server.URLEncode(Request("id"))
        intQty          = Server.URLEncode(Request("txtQty"))
        intWidth        = Server.URLEncode(Request("txtWidth"))
        intHeight       = Server.URLEncode(Request("txtHeight"))
        intOrientation  = Server.URLEncode(Request("cboOrientation"))

        Select Case Trim(Request("command"))
            case "order"
                call addConnectOrder(intResourceID, intQty, session("yma_userid"))
            case "banner"
                'response.write "<h1 style=color:white>" & intResourceID & ", " & intQty & ", " & intWidth & ", " & intHeight & ", " & intOrientation & "</h1>"
                call addWebBanner(intResourceID, intQty, intWidth, intHeight, intOrientation, session("yma_userid"))
        end select
    end if

    call getResourceTypeList
    call getResourceCategoryList

    if trim(session("resource_initial_page"))  = "" then
        session("resource_initial_page") = 1
    end if

    call displayResources
end sub

call main

dim strMessageText, rs, intPageCount, intpage, intRecord, strDisplayList, strTypeList, strCategoryList
%>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
    <tr>
        <td class="main_content">
            <ol class="breadcrumb">
                <li><a href="../home/">Home</a></li>
                <li class="active">Marketing</li>
            </ol>
            <div class="masthead">
                <nav>
                    <ul class="nav nav-justified">
                        <li class="active"><a>MARKETING MATERIALS</a></li>
                        <li><a href="orders.asp">YOUR ORDERS</a></li>
                    </ul>
                </nav>
            </div>
            <h1>Marketing Materials</h1>
            <form name="frmSearch" id="frmSearch" action="?type=search" method="post" onsubmit="searchItem()">
                <div class="float_left">
                    <input type="text" class="form-control" name="txtSearch" size="30" value="<%= request("txtSearch") %>" maxlength="20" placeholder="Search Name / Description" onchange="searchItem()" />
                </div>
                <div class="float_left">
                    <select name="cboType" class="form-control" onchange="searchItem()">
                        <%= strTypeList %>
                    </select>
                </div>
                <div class="float_left">
                    <select name="cboCategory" class="form-control" onchange="searchItem()">
                        <%= strCategoryList %>
                    </select>
                </div>
                <div class="float_left">
                    <input type="button" class="btn btn-primary" name="btnSearch" value="Search" onclick="searchItem()" />
                </div>
                <div class="float_left">
                    <input type="button" class="btn btn-primary" name="btnReset" value="Reset" onclick="resetSearch()" />
                </div>
            </form>
            <%= strMessageText %>
            <% if request("q") = "success" then response.write "<h2 style=color:green>SUCCESS!</h2>" end if%>.
        </td>
    </tr>
    <tr>
        <td>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <td></td>
                        <td>Type / Category</td>
                        <td>Name</td>
                        <td>Description</td>
                        <td></td>
                        <td>Qty / Width (px) / Height (px) / Orientation</td>
                        <td>Last order</td>
                    </tr>
                </thead>
                <%= strDisplayList %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>