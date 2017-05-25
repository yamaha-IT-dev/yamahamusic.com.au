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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Cache-control" content="no-store">
<title>View Repair Job - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<%
sub main
	on error resume next

	intJobID = request("job_id")

	call UTL_validateLogin
	call getUserDetails(Session("UsrUserID"))
	
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
    <td class="maincontent"><% if session("job_not_found") <> "TRUE" then %>
      <%= strMessageText %>
      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top">
              <table border="0" cellpadding="5" cellspacing="5" class="form_box_nowidth">
                <tr>
                  <td colspan="2" align="center"><h1>View Job</h1></td>
                </tr>
                <tr>
                  <td valign="top"><table border="0" cellpadding="5" cellspacing="0" class="form_box">
                      <tr>
                        <td colspan="2" class="form_header">Customer Contact Details</td>
                      </tr>
                      <tr>
                        <td><strong>First name</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtFirstName" name="txtFirstName" maxlength="25" size="25" value="<%= Server.HTMLencode(session("firstname") & "") %>" /></td>
                        <td><strong>Last name</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtLastName" name="txtLastName" maxlength="25" size="25" value="<%= Server.HTMLencode(session("lastname") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td><strong>Mobile no</strong><br />
                          <input type="text" id="txtMobile" name="txtMobile" maxlength="12" size="15" value="<%= Server.HTMLencode(session("mobile") & "") %>" /></td>
                        <td><strong>Phone no</strong><br />
                          <input type="text" id="txtPhone" name="txtPhone" maxlength="12" size="15" value="<%= Server.HTMLencode(session("phone") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Address</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtAddress" name="txtAddress" maxlength="50" size="50" value="<%= Server.HTMLencode(session("address") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>City</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtCity" name="txtCity" maxlength="25" size="25" value="<%= Server.HTMLencode(session("city") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td width="50%"><strong>State</strong> <span class="mandatory">*</span><br />
                          <select name="cboState">
                            <%= strStateList %>
                          </select></td>
                        <td width="50%"><strong>Postcode</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="5" value="<%= Server.HTMLencode(session("postcode") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Email</strong><br />
                          <input type="text" id="txtEmail" name="txtEmail" maxlength="50" size="50" value="<%= Server.HTMLencode(session("email") & "") %>" /></td>
                      </tr>
                    </table>
                    <br />
                    <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                      <tr>
                        <td colspan="2" class="form_header">Repair Job Details</td>
                      </tr>
                      <tr>
                        <td class="form_column_35"><strong>Service Centre's Job no</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtJobNo" name="txtJobNo" maxlength="25" size="25" value="<%= Server.HTMLencode(session("job_no") & "") %>" /></td>
                        <td class="form_column_40"><strong>Warranty job?</strong><br />
                          <select name="cboWarranty">
                            <option value="1" <% if session("warranty") = 1 then response.write " selected" %>>Yes</option>
                            <option value="0" <% if session("warranty") = 0 then response.write " selected" %>>No</option>
                          </select></td>
                      </tr>
                      <tr>
                        <td><strong>Category</strong> <span class="mandatory">*</span><br />
                          <select name="cboWarrantyCode">
                            <%= strWarrantyCodeList %>
                          </select></td>
                        <td><strong>Model no</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtModelNo" name="txtModelNo" maxlength="25" size="25" value="<%= Server.HTMLencode(session("model_no") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Serial no</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtSerialNo" name="txtSerialNo" maxlength="15" size="20" value="<%= Server.HTMLencode(session("serial_no") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Dealer name</strong> <em>(Purchased from)</em> <span class="mandatory">*</span><br />
                          <input type="text" id="txtDealer" name="txtDealer" maxlength="30" size="35" value="<%= Server.HTMLencode(session("dealer") & "") %>" />
                          <em>(max 30 chars)</em></td>
                      </tr>
                      <tr>
                        <td valign="top"><strong>Invoice / Receipt no</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtInvoiceNo" name="txtInvoiceNo" maxlength="15" size="20" value="<%= Server.HTMLencode(session("invoice_no") & "") %>" /></td>
                        <td><strong>Date purchased</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtDatePurchased" name="txtDatePurchased" maxlength="10" size="10" value="<%= Server.HTMLencode(session("date_purchased") & "") %>" />
                          <em>DD/MM/YYYY</em></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Fault reported</strong> <span class="mandatory">*</span><br />
                          <input type="text" id="txtFault" name="txtFault" placeholder="Max 30 chars" maxlength="30" size="35" value="<%= Server.HTMLencode(session("fault") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Accessories</strong><br />
                          <input type="text" id="txtAccessories" name="txtAccessories" placeholder="Max 30 chars" maxlength="30" size="35" value="<%= Server.HTMLencode(session("accessories") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Comments / Condition</strong><br />
                          <input type="text" id="txtComments" name="txtComments" placeholder="Max 30 chars" maxlength="30" size="35" value="<%= Server.HTMLencode(session("comments") & "") %>" /></td>
                      </tr>
                    </table>
                    <p><span class="mandatory">* Required field</span></p></td>
                  <td valign="top"><table border="0" cellpadding="5" cellspacing="0" class="form_box">
                      <tr>
                        <td colspan="2" class="form_header">Repair Report Details</td>
                      </tr>
                      <tr>
                        <td width="15%" valign="top"><strong>Labour $</strong></td>
                        <td width="85%"><input type="text" id="txtLabour" name="txtLabour" placeholder="0.00" maxlength="6" size="6" onfocus="startCalc();" onblur="stopCalc();" value="<%= Server.HTMLencode(session("labour") & "") %>" />
                          <em>(exclude GST)</em></td>
                      </tr>
                      <tr>
                        <td valign="top"><strong>Parts $</strong></td>
                        <td><input type="text" id="txtParts" name="txtParts" placeholder="0.00" maxlength="6" size="6" onfocus="startCalc();" onblur="stopCalc();" value="<%= Server.HTMLencode(session("parts") & "") %>" />
                          <em>(exclude GST)</em></td>
                      </tr>
                      <tr>
                        <td valign="top"><strong>GST $</strong></td>
                        <td><input type="text" id="txtGST" name="txtGST" maxlength="6" size="6" style="background-color:#CCC" value="<%= Server.HTMLencode(session("gst") & "") %>" />
                          <em>(Auto-generated)</em></td>
                      </tr>
                      <tr>
                        <td valign="top"><strong>Total $</strong></td>
                        <td><input type="text" id="txtTotal" name="txtTotal" maxlength="6" size="6" style="background-color:#CCC" value="<%= Server.HTMLencode(session("total") & "") %>" />
                          <em>(Auto-generated)</em></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Repair report</strong><br />
                          <input type="text" id="txtRepairReport" name="txtRepairReport" placeholder="Max 30 chars" maxlength="30" size="35" value="<%= Server.HTMLencode(session("repair_report") & "") %>" /></td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Date completed</strong><br />
                          <input type="text" id="txtDateCompleted" name="txtDateCompleted" placeholder="dd/mm/yyyy" maxlength="10" size="10" value="<% if session("date_completed") <> "01/01/1900" then
					 		response.write Server.HTMLencode(session("date_completed") & "" )
					 	 end if %>" /></td>
                      </tr>
                    </table>
                    <br />
                    <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                      <tr>
                        <td colspan="2" class="form_header">Job Status</td>
                      </tr>
                      <tr>
                        <td colspan="2"><strong>Status</strong><br />
                        <% if Trim(session("job_status")) <> 0 then %>
                          <select name="cboStatus">
                            <option <% if session("job_status") = "1" then Response.Write " selected" end if%> value="1" rel="none">New</option>
                            <option <% if session("job_status") = "2" then Response.Write " selected" end if%> value="2" rel="none">Open: Repair in-progress</option>
                            <option <% if session("job_status") = "3" then Response.Write " selected" end if%> value="3" rel="none">Open: Waiting for parts</option>
                            <option <% if session("job_status") = "4" then Response.Write " selected" end if%> value="4" rel="none">Open: Parts received</option>
                            <option <% if session("job_status") = "5" then Response.Write " selected" end if%> value="5" rel="return">Open: Return to Yamaha for service</option>
                            <option <% if session("job_status") = "6" then Response.Write " selected" end if%> value="6" rel="none">Repair completed</option>
                          </select>
                          <% else %>
                          EXPORTED
                          <% end if %>
                          </td>
                      </tr>
                      <tr rel="return">
                        <td colspan="2"><em>If returned to Yamaha:</em>
                          <table>
                            <tr>
                              <td><strong>Date returned to Yamaha</strong><br />
                                <input type="text" id="txtDateReturn" name="txtDateReturn" placeholder="dd/mm/yyyy" maxlength="10" size="10" value="<% if session("date_return") <> "01/01/1900" then
					 				response.write Server.HTMLencode(session("date_return") & "" )
					 	 		end if %>" /></td>
                              <td><strong>Date received from Yamaha</strong><br />
                                <input type="text" id="txtDateReceived" name="txtDateReceived" placeholder="dd/mm/yyyy" maxlength="10" size="10" value="<% if session("date_received") <> "01/01/1900" then
					 				response.write Server.HTMLencode(session("date_received") & "" )
					 	 		end if %>" /></td>
                            </tr>
                            <tr>
                              <td><strong>Courier</strong><br />
                                <input type="text" id="txtCourier" name="txtCourier" maxlength="25" size="35" value="<%= Server.HTMLencode(session("return_courier") & "") %>" /></td>
                              <td><strong>Con-note</strong><br />
                                <input type="text" id="txtConnote" name="txtConnote" maxlength="12" size="20" value="<%= Server.HTMLencode(session("return_connote") & "") %>" /></td>
                            </tr>
                          </table></td>
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
                    <p><%= strMessageText %></p></td>
                </tr>
                <tr>
                  <td colspan="2" align="center"><br /> 
                    </td>
                </tr>
              </table>             
            </td>
          <td class="form_column"><table border="0" cellpadding="5" cellspacing="5" class="form_box_nowidth">
              <tr>
                <td align="center"><h1>Spare Parts Order</h1></td>
              </tr>
              <tr>
                <td>
                  <h2>Ordered Spare Parts for this job</h2>
                  <table cellpadding="5" cellspacing="0" border="0" width="100%">
                    <tr class="innerdoctitle">
                      <td>Submitted</td>                      
                      <td nowrap="nowrap">Part no</td>
                      <td>Description</td>
                      <td>Qty</td>
                      <td>Status</td>                      
                      <td>ETA</td>
                      <td>Comments</td>
                      <td>Ref no</td>
                    </tr>
                    <%= strOrderList %>
                  </table>
                  <p><em>*Please note that dates supplied for back-order spare part deliveries are guides only, the delivery time can vary considerably</em></p></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <% else %>
      <h1>Sorry but Repair ID: <%= request("job_id") %> cannot be found in the system.</h1>
      <% end if %></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
<script type="text/javascript" src="../include/moment.js"></script> 
<script type="text/javascript" src="../include/pikaday.js"></script> 
<script type="text/javascript">	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDatePurchased'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateCompleted'),
        firstDay: 1,
        minDate: new Date('2014-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateReturn'),
        firstDay: 1,
        minDate: new Date('2014-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDateReceived'),
        firstDay: 1,
        minDate: new Date('2014-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>