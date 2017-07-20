<% strSection = "jobs"
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsJob.asp" -->
<!--#include file="class/clsList.asp" -->
<!--#include file="class/clsOrder.asp" -->
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
<title>Edit Repair Job - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<link rel="stylesheet" href="../include/pikaday.css" type="text/css" />
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script src="include/autoSum.js"></script>
<script src="/loadModelNo.js" type="text/javascript"></script>
<script>
function validateUpdateJobForm(theForm) {
    var reason = "";
    var blnSubmit = true;

    // CUSTOMER DETAILS
    reason += validateEmptyField(theForm.txtFirstName,"First name");
    reason += validateSpecialCharacters(theForm.txtFirstName,"First name");

    reason += validateEmptyField(theForm.txtLastName,"Last name");
    reason += validateSpecialCharacters(theForm.txtLastName,"Last name");

    reason += validateSpecialCharacters(theForm.txtMobile,"Mobile");

    reason += validateSpecialCharacters(theForm.txtPhone,"Phone");

    reason += validateEmptyField(theForm.txtAddress,"Address");
    reason += validateSpecialCharacters(theForm.txtAddress,"Address");

    reason += validateEmptyField(theForm.txtCity,"City");
    reason += validateSpecialCharacters(theForm.txtCity,"City");

    reason += validateEmptyField(theForm.cboState,"State");

    reason += validateNumeric(theForm.txtPostcode,"Postcode");
    reason += validateSpecialCharacters(theForm.txtPostcode,"Postcode");

    if (theForm.txtEmail.value != "") {
        reason += validateEmail(theForm.txtEmail,"Email");
        reason += validateSpecialCharacters(theForm.txtEmail,"Email");
    }

    // JOB DETAILS
    reason += validateSpecialCharacters(theForm.txtJobReceived,"Job received");

    reason += validateEmptyField(theForm.txtJobNo,"Job no");
    reason += validateSpecialCharacters(theForm.txtJobNo,"Job no");

    reason += validateEmptyField(theForm.txtModelNo,"Model no");

    reason += validateEmptyField(theForm.cboWarrantyCode,"Category");

    reason += validateEmptyField(theForm.txtSerialNo,"Serial no");
    reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial no");

    reason += validateEmptyField(theForm.txtDealer,"Dealer name");
    reason += validateSpecialCharacters(theForm.txtDealer,"Dealer name");

    reason += validateEmptyField(theForm.txtInvoiceNo,"Invoice no");
    reason += validateSpecialCharacters(theForm.txtInvoiceNo,"Invoice no");

    reason += validateDate(theForm.txtDatePurchased,"Date purchased");
    reason += validateSpecialCharacters(theForm.txtDatePurchased,"Date purchased");

    reason += validateEmptyField(theForm.txtFault,"Fault");
    reason += validateSpecialCharacters(theForm.txtFault,"Fault");

    reason += validateSpecialCharacters(theForm.txtAccessories,"Accessories");

    reason += validateSpecialCharacters(theForm.txtComments,"Comments");

    if (theForm.txtLabour.value != "") {
        reason += validateSpecialCharacters(theForm.txtLabour,"Labour");
        reason += validateNumeric(theForm.txtLabour,"Labour");
    }

    if (theForm.txtParts.value != "") {
        reason += validateSpecialCharacters(theForm.txtParts,"Parts");
        reason += validateNumeric(theForm.txtParts,"Parts");
    }

    if (theForm.txtTravelRate.value != "") {
        reason += validateSpecialCharacters(theForm.txtTravelRate,"Travel Rate");
        reason += validateNumeric(theForm.txtTravelRate,"Travel Rate");
    }

    if (theForm.txtTravelHours.value != "") {
        reason += validateSpecialCharacters(theForm.txtTravelHours,"Travel Hours");
        reason += validateNumeric(theForm.txtTravelHours,"Travel Hours");
    }

    reason += validateSpecialCharacters(theForm.txtRepairReport,"Repair Report");

    if (theForm.txtDateCompleted.value != "") {
        reason += validateDate(theForm.txtDateCompleted,"Date competed");
        reason += validateSpecialCharacters(theForm.txtDateCompleted,"Date completed");
    }

    reason += validateSpecialCharacters(theForm.txtDateReturn,"Date Return");
    reason += validateSpecialCharacters(theForm.txtDateReceived,"Date Received");
    reason += validateSpecialCharacters(theForm.txtCourier,"Courier");
    reason += validateSpecialCharacters(theForm.txtConnote,"Connote");

    if (theForm.cboStatus.value == "5") {
        reason += validateDate(theForm.txtDateReturn,"Date Return");
        reason += validateEmptyField(theForm.txtPickupCourier,"Pickup Courier");
        reason += validateEmptyField(theForm.txtPickupConnote, "Pickup Connote");
        reason += validateDate(theForm.txtDateReceived,"Date Received");
        reason += validateEmptyField(theForm.txtCourier,"Return Courier");
        reason += validateEmptyField(theForm.txtConnote,"Return Connote");
    }

    if (theForm.cboStatus.value == "6") {
        reason += validateNumeric(theForm.txtLabour,"Labour");
        reason += validateSpecialCharacters(theForm.txtParts,"Parts");
        reason += validateEmptyField(theForm.txtRepairReport,"Repair report");
        reason += validateDate(theForm.txtDateCompleted,"Date competed");
    }

    if (reason != "") {
        alert("Some fields need correction:\n" + reason);
        blnSubmit = false;
        return false;
    }

    if (blnSubmit == true) {
        theForm.Action.value = 'Update';
        return true;
    }
}

function validateAddOrderForm(theForm) {
    var reason = "";
    var blnSubmit = true;

    // NEW ORDER FORM
    reason += validateEmptyField(theForm.txtPartNo,"Part no");
    reason += validateSpecialCharacters(theForm.txtPartNo,"Part no");

    reason += validateEmptyField(theForm.txtDescription,"Description");
    reason += validateSpecialCharacters(theForm.txtDescription,"Description");

    if (reason != "") {
        alert("Some fields need correction:\n" + reason);
        blnSubmit = false;
        return false;
    }

    if (blnSubmit == true) {
        theForm.Action.value = 'Order';
        return true;
    }
}
</script>
<%
sub main
    on error resume next

    intJobID = request("job_id")

    if Request.ServerVariables("REQUEST_METHOD") = "POST" then
        select case Trim(Request("Action"))
            case "Update"
                if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
                    call updateJob
                else
                    response.Redirect("default.asp?logout=y")
                end if
            case "Order"
                if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
                    call addOrder
                else
                    response.Redirect("default.asp?logout=y")
                end if
        end select
    else
        call UTL_validateLogin
        call getUserDetails(Session("UsrUserID"))
        call createToken
    end if

    call getJob
    call getJobStatusList
    call getStateList
    call getWarrantyCodeList
    call listOrders(intJobID)
end sub

call main

dim strMessageText, strStateList, strWarrantyCodeList, strJobStatusList, strOrderList, intJobID
%>
</head>
<body>
    <table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
        <!-- #include file="include/header.asp" -->
        <tr>
            <td class="maincontent">
                <% if session("job_not_found") <> "TRUE" then %>
                <%= strMessageText %>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top">
                            <form action="" method="post" name="form_update_job" id="form_update_job" onsubmit="return validateUpdateJobForm(this)">
                                <table border="0" cellpadding="5" cellspacing="5" class="form_box_nowidth">
                                    <tr>
                                        <td colspan="2" align="center"><h1>Edit Job</h1></td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                            <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                                                <tr>
                                                    <td colspan="2" class="form_header">Customer Contact Details</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>First name</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtFirstName" name="txtFirstName" maxlength="25" size="25" value="<%= Server.HTMLencode(session("firstname") & "") %>" required />
                                                    </td>
                                                    <td>
                                                        <strong>Last name</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtLastName" name="txtLastName" maxlength="25" size="25" value="<%= Server.HTMLencode(session("lastname") & "") %>" required />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>Mobile no</strong><br />
                                                        <input type="text" id="txtMobile" name="txtMobile" maxlength="12" size="15" value="<%= Server.HTMLencode(session("mobile") & "") %>" />
                                                    </td>
                                                    <td>
                                                        <strong>Phone no</strong><br />
                                                        <input type="text" id="txtPhone" name="txtPhone" maxlength="12" size="15" value="<%= Server.HTMLencode(session("phone") & "") %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Address</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtAddress" name="txtAddress" maxlength="50" size="50" value="<%= Server.HTMLencode(session("address") & "") %>" required />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>City</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtCity" name="txtCity" maxlength="25" size="25" value="<%= Server.HTMLencode(session("city") & "") %>" required />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%">
                                                        <strong>State</strong> <span class="mandatory">*</span><br />
                                                        <select name="cboState">
                                                            <%= strStateList %>
                                                        </select>
                                                    </td>
                                                    <td width="50%">
                                                        <strong>Postcode</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="5" value="<%= Server.HTMLencode(session("postcode") & "") %>" required />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Email</strong><br />
                                                        <input type="text" id="txtEmail" name="txtEmail" maxlength="50" size="50" value="<%= Server.HTMLencode(session("email") & "") %>" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                                                <tr>
                                                    <td colspan="2" class="form_header">Repair Job Details</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Job Received</strong><br />
                                                        <input type="text" id="txtJobReceived" name="txtJobReceived" maxlength="10" size="10" placeholder="dd/mm/yyyy" value="<% if session("job_received") <> "01/01/1900" then response.write Server.HTMLencode(session("job_received") & "" ) end if %>" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="form_column_35">
                                                        <strong>Job no</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtJobNo" name="txtJobNo" maxlength="8" size="10" value="<%= Server.HTMLencode(session("job_no") & "") %>" required />
                                                    </td>
                                                    <td class="form_column_40">
                                                        <strong>Warranty job?</strong><br />
                                                        <select name="cboWarranty">
                                                            <option value="1" <% if session("warranty") = 1 then response.write " selected" %>>Yes</option>
                                                            <option value="0" <% if session("warranty") = 0 then response.write " selected" %>>No</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>Category</strong> <span class="mandatory">*</span><br />
                                                        <select name="cboWarrantyCode">
                                                            <%= strWarrantyCodeList %>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <strong>Model no</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtModelNo" name="txtModelNo" maxlength="25" size="25" value="<%= Server.HTMLencode(session("model_no") & "") %>" required />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Serial no</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtSerialNo" name="txtSerialNo" maxlength="15" size="20" value="<%= Server.HTMLencode(session("serial_no") & "") %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Dealer name</strong> <em>(Purchased from)</em> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtDealer" name="txtDealer" maxlength="30" size="35" value="<%= Server.HTMLencode(session("dealer") & "") %>" required />
                                                        <em>(max 30 chars)</em>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <strong>Invoice / Receipt no</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtInvoiceNo" name="txtInvoiceNo" maxlength="15" size="20" value="<%= Server.HTMLencode(session("invoice_no") & "") %>" required />
                                                    </td>
                                                    <td>
                                                        <strong>Date purchased</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtDatePurchased" name="txtDatePurchased" maxlength="10" size="10" placeholder="dd/mm/yyyy" value="<%= Server.HTMLencode(session("date_purchased") & "") %>" required />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Fault reported</strong> <span class="mandatory">*</span><br />
                                                        <textarea id="txtFault" name="txtFault" rows="5" cols="50" maxlength="600" required="required" placeholder="Max 600 chars"><%= Server.HTMLencode(session("fault") & "") %></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Accessories</strong><br />
                                                        <textarea id="txtAccessories" name="txtAccessories" rows="5" cols="50" maxlength="600" placeholder="Max 600 chars"><%= Server.HTMLencode(session("accessories") & "") %></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <strong>Comments / Condition</strong><br />
                                                        <textarea id="txtComments" name="txtComments" rows="5" cols="50" maxlength="600" placeholder="Max 600 chars"><%= Server.HTMLencode(session("comments") & "") %></textarea>
                                                    </td>
                                                </tr>
                                            </table>
                                            <p><span class="mandatory">* Required field</span></p>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                                                <tr>
                                                    <td colspan="3" class="form_header">Repair Report Details</td>
                                                </tr>
                                                <tr>
                                                    <td width="15%" valign="top"><strong>Labour $</strong></td>
                                                    <td width="85%" colspan="2">
                                                        <input type="text" id="txtLabour" name="txtLabour" placeholder="0.00" maxlength="6" size="6" onfocus="startCalc();" onblur="stopCalc();" value="<%= Server.HTMLencode(session("labour") & "") %>" />
                                                        <em>(exclude GST)</em>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top"><strong>Parts $</strong></td>
                                                    <td colspan="2">
                                                        <input type="text" id="txtParts" name="txtParts" placeholder="0.00" maxlength="6" size="6" onfocus="startCalc();" onblur="stopCalc();" value="<%= Server.HTMLencode(session("parts") & "") %>" />
                                                        <em>(exclude GST)</em>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top"><strong>Travel $</strong></td>
                                                    <td>
                                                        <input type="text" id="txtTravelRate" name="txtTravelRate" placeholder="0" maxlength="6" size="6" onfocus="startCalc();" onblur="stopCalc();" value="<%= Server.HTMLencode(session("travel_rate")) %>" />
                                                        <em>(rate exclude GST)</em>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txtTravelHours" name="txtTravelHours" placeholder="0" maxlength="6" size="6" onfocus="startCalc();" onblur="stopCalc();" value="<%= Server.HTMLencode(session("travel_hours")) %>" />
                                                        <em>(hours)</em>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top"><strong>GST $</strong></td>
                                                    <td colspan="2">
                                                        <input type="text" id="txtGST" name="txtGST" maxlength="6" size="6" style="background-color:#CCC" value="<%= FormatNumber(session("gst") & "",2) %>" />
                                                        <em>(Auto-generated)</em>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top"><strong>Total $</strong></td>
                                                    <td colspan="2">
                                                        <input type="text" id="txtTotal" name="txtTotal" maxlength="6" size="6" style="background-color:#CCC" value="<%= FormatNumber(session("total") & "",2) %>" />
                                                        <em>(Auto-generated)</em>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <strong>Repair report</strong><br />
                                                        <textarea id="txtRepairReport" name="txtRepairReport" rows="5" cols="50" maxlength="600" placeholder="Max 600 chars"><%= Server.HTMLencode(session("repair_report") & "") %></textarea>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <strong>Date completed</strong><br />
                                                        <input type="text" id="txtDateCompleted" name="txtDateCompleted" placeholder="dd/mm/yyyy" maxlength="10" size="10" value="<% if session("date_completed") <> "01/01/1900" then response.write Server.HTMLencode(session("date_completed") & "" ) end if %>" />
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td colspan="3">
                                                        <a href="" id="extraCompletedJobButton" class="button">Complete Job</a>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                                                <tr>
                                                    <td class="form_header">Job Status</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>Status</strong><br />
                                                        <% if Trim(session("job_status")) <> 0 then %>
                                                        <select name="cboStatus">
                                                            <option <% if session("job_status") = "1" then Response.Write " selected" end if%> value="1">New</option>
                                                            <option <% if session("job_status") = "2" then Response.Write " selected" end if%> value="2">Open: Repair in-progress</option>
                                                            <option <% if session("job_status") = "3" then Response.Write " selected" end if%> value="3">Open: Waiting for parts</option>
                                                            <option <% if session("job_status") = "7" then Response.Write " selected" end if%> value="7">Open: Parts received</option>
                                                            <option <% if session("job_status") = "4" then Response.Write " selected" end if%> value="4">Open: Parts received</option>
                                                            <option <% if session("job_status") = "5" then Response.Write " selected" end if%> value="5">Open: Return to Yamaha for service</option>
                                                            <option <% if session("job_status") = "8" then Response.Write " selected" end if%> value="8">Changeover</option>
                                                            <option <% if session("job_status") = "6" then Response.Write " selected" end if%> value="6">Repair completed</option>
                                                        </select>
                                                        <% else %>
                                                        EXPORTED
                                                        <% end if %>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table border="0" width="100%" cellpadding="5" cellspacing="0" class="thin_border">
                                                <tr>
                                                    <td align="right"><strong>Due date:</strong></td>
                                                    <td><%= FormatDateTime(session("due_date"),1) %></td>
                                                </tr>
                                                <tr>
                                                    <td width="25%" align="right"><strong>Created by:</strong></td>
                                                    <td width="75%"><%= session("asc_firstname") %>, <%= displayDateFormatted(session("job_date_created")) %></td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><strong>Last modified:</strong></td>
                                                    <td><%= displayDateFormatted(session("job_date_modified")) %></td>
                                                </tr>
                                                <tr>
                                                    <td align="right"><strong>Elapsed:</strong></td>
                                                    <td><%= session("job_elapsed_days") %> days</td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table border="0" cellpadding="5" cellspacing="0" class="form_box" id="return_to_yamaha" style="display: none;">
                                                <tr>
                                                    <td class="form_header" colspan="3">Return To Yamaha</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>Pickup Date</strong><br />
                                                        <input type="text" id="txtDateReturn" name="txtDateReturn" placeholder="dd/mm/yyyy" maxlength="10" size="10" value="<% if session("date_return") <> "01/01/1900" then response.write Server.HTMLencode(session("date_return") & "" ) end if %>" />
                                                    </td>
                                                    <td>
                                                        <strong>Pickup Courier</strong>
                                                        <input type="text" id="txtPickupCourier" name="txtPickupCourier" maxlength="20" size="24" value="<%= Server.HTMLencode(session("pickup_courier") & "") %>" />
                                                    </td>
                                                    <td>
                                                        <strong>Pickup Con-note</strong>
                                                        <input type="text" id="txtPickupConnote" name="txtPickupConnote" maxlength="12" size="18" value="<%= Server.HTMLencode(session("pickup_connote") & "") %>" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>Return Date</strong><br />
                                                        <input type="text" id="txtDateReceived" name="txtDateReceived" placeholder="dd/mm/yyyy" maxlength="10" size="10" value="<% if session("date_received") <> "01/01/1900" then response.write Server.HTMLencode(session("date_received") & "" ) end if %>" />
                                                    </td>
                                                    <td>
                                                        <strong>Return Courier</strong><br />
                                                        <input type="text" id="txtCourier" name="txtCourier" maxlength="20" size="24" value="<%= Server.HTMLencode(session("return_courier") & "") %>" />
                                                    </td>
                                                    <td>
                                                        <strong>Return Con-note</strong><br />
                                                        <input type="text" id="txtConnote" name="txtConnote" maxlength="12" size="18" value="<%= Server.HTMLencode(session("return_connote") & "") %>" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <p><%= strMessageText %></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br />
                                            <% if Trim(session("job_status")) <> 0 then %>
                                            <input type="hidden" name="Action" />
                                            <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
                                            <input type="submit" value="Save Repair Job" />
                                            <% end if %>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </td>
                        <td class="form_column" id="spare_parts_order">
                            <table border="0" cellpadding="5" cellspacing="5" class="form_box_nowidth">
                                <tr>
                                    <td align="center"><h1>Spare Parts Order</h1></td>
                                </tr>
                                <tr>
                                    <td>
                                        <% if Trim(session("job_status")) <> 0 then %>
                                        <form action="" method="post" name="form_add_order" id="form_add_order" onsubmit="return validateAddOrderForm(this)">
                                            <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                                                <tr>
                                                    <td colspan="4" class="form_header">New Order</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <strong>Part no</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtPartNo" name="txtPartNo" maxlength="20" size="20" required />
                                                    </td>
                                                    <td>
                                                        <strong>Description</strong> <span class="mandatory">*</span><br />
                                                        <input type="text" id="txtDescription" name="txtDescription" maxlength="30" size="30" required />
                                                    </td>
                                                    <td>
                                                        <strong>Qty</strong><br />
                                                        <select name="cboQty">
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                            <option value="6">6</option>
                                                            <option value="7">7</option>
                                                            <option value="8">8</option>
                                                            <option value="9">9</option>
                                                            <option value="10">10</option>
                                                            <option value="11">11</option>
                                                            <option value="12">12</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <strong>Notes</strong><br />
                                                        <input type="text" id="txtNotes" name="txtNotes" maxlength="80" size="20" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" align="center">
                                                        <input type="hidden" name="Action" />
                                                        <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
                                                        <input type="submit" value="Submit Order" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </form>
                                        <% end if %>
                                        <h2>Ordered Spare Parts for this job</h2>
                                        <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                            <tr class="innerdoctitle">
                                                <td>Submitted</td>
                                                <td nowrap="nowrap">Part no</td>
                                                <td>Description</td>
                                                <td>Qty</td>
                                                <td>Notes</td>
                                                <td>Status</td>
                                                <td>ETA</td>
                                                <td>Comments</td>
                                                <td>Ref no</td>
                                            </tr>
                                            <%= strOrderList %>
                                        </table>
                                        <p><em>*Please note that dates supplied for back-order spare part deliveries are guides only, the delivery time can vary considerably</em></p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <% else %>
                <h1>Sorry but Repair ID: <%= request("job_id") %> cannot be found in the system.</h1>
                <% end if %>
            </td>
        </tr>
        <!-- #include file="include/footer.asp" -->
    </table>
    <script type="text/javascript" src="../include/moment.js"></script>
    <script type="text/javascript" src="../include/pikaday.js"></script>
    <script type="text/javascript" src="include/JobScripts.js"></script>
    <script type="text/javascript">
        var picker = new Pikaday({
            field: document.getElementById('txtJobReceived'),
            firstDay: 1,
            minDate: new Date('2010-01-01'),
            maxDate: new Date('2020-12-31'),
            yearRange: [2010,2020],
            format: 'DD/MM/YYYY'
        });

        var picker = new Pikaday({
            field: document.getElementById('txtDatePurchased'),
            firstDay: 1,
            minDate: new Date('2010-01-01'),
            maxDate: new Date('2020-12-31'),
            yearRange: [2010,2020],
            format: 'DD/MM/YYYY'
        });

        var picker = new Pikaday({
            field: document.getElementById('txtDateCompleted'),
            firstDay: 1,
            minDate: new Date('2014-01-01'),
            maxDate: new Date('2020-12-31'),
            yearRange: [2014,2020],
            format: 'DD/MM/YYYY'
        });

        var picker = new Pikaday({
            field: document.getElementById('txtDateReturn'),
            firstDay: 1,
            minDate: new Date('2014-01-01'),
            maxDate: new Date('2020-12-31'),
            yearRange: [2014,2020],
            format: 'DD/MM/YYYY'
        });

        var picker = new Pikaday({
            field: document.getElementById('txtDateReceived'),
            firstDay: 1,
            minDate: new Date('2014-01-01'),
            maxDate: new Date('2020-12-31'),
            yearRange: [2014,2020],
            format: 'DD/MM/YYYY'
        });

        $(function() {
            $("#txtSerialNo").trigger("change");

            $("#extraCompletedJobButton").click(function() {
                event.preventDefault();
                $("input[value='Save Repair Job']").click();
            });

            $("select[name=cboStatus]").change(function() {
                var selectedValue = $(this).val();

                if (selectedValue === "5") {
                    $("#return_to_yamaha").show();
                } else {
                    $("#return_to_yamaha").hide();
                }

                if (selectedValue === "8") {
                    $("#spare_parts_order").hide();
                } else {
                    $("#spare_parts_order").show();
                }
            });

            $("select[name=cboStatus]").trigger("change");
        });
    </script>
</body>
</html>