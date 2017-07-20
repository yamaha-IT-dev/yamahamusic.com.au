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
<title>New Repair Job - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<link rel="stylesheet" href="../include/pikaday.css" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script src="../include/generic_form_validations.js"></script>

<script src="/loadModelNo.js" type="text/javascript"></script>

<script>
function validateTermsConditions(fld) {
    var error = "";

    if (!fld.checked) {
        fld.style.background = 'Yellow';
        error = "- You must accept our Terms and Conditions.\n"
    } else {
        fld.style.background = 'White';
    }

    return error;
}

function validateFormOnSubmit(theForm) {
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
    reason += validateDate(theForm.txtJobReceived, "Job received")
    reason += validateSpecialCharacters(theForm.txtJobReceived, "Job received")

    reason += validateEmptyField(theForm.txtJobNo,"Job no");
    reason += validateSpecialCharacters(theForm.txtJobNo,"Job no");

    reason += validateEmptyField(theForm.cboWarrantyCode,"Category");

    reason += validateEmptyField(theForm.txtModelNo,"Model no");

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

    if (reason != "") {
        alert("Some fields need correction:\n" + reason);
        blnSubmit = false;
        return false;
    }

    if (blnSubmit == true) {
        theForm.Action.value = 'Add';
        return true;
    }
}
</script>
<%
sub main
    if Request.ServerVariables("REQUEST_METHOD") = "POST" then
        if trim(request("Action")) = "Add" then
            if Trim(Session("user_token")) = Trim(Request.Form("UserToken")) then
                call addJob
            else
                response.Redirect("default.asp?logout=y")
            end if
        else
            call getWarrantyCodeList
        end if
    else
        call UTL_validateLogin
        call getUserDetails(Session("UsrUserID"))
        call getStateList
        call getWarrantyCodeList
        call getJobStatusList
        call createToken
    end if
end sub

call main

dim strMessageText, strStateList, strWarrantyCodeList, strJobStatusList
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
    <!-- #include file="include/header.asp" -->
    <tr>
        <td class="maincontent">
            <font color="red"><%= strMessageText %></font>
            <form action="" method="post" name="form_add_job" id="form_add_job" onsubmit="return validateFormOnSubmit(this)">
                <table border="0" cellpadding="5" cellspacing="5" class="form_box_nowidth">
                    <tr>
                        <td colspan="3" align="center"><h1>New Repair Job</h1></td>
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
                                        <input type="text" id="txtFirstName" name="txtFirstName" maxlength="25" size="25" required />
                                    </td>
                                    <td>
                                        <strong>Last name</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtLastName" name="txtLastName" maxlength="25" size="25" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong>Mobile phone</strong> <br />
                                        <input type="text" id="txtMobile" name="txtMobile" maxlength="12" size="15" />
                                    </td>
                                    <td>
                                        <strong>Phone no</strong><br />
                                        <input type="text" id="txtPhone" name="txtPhone" maxlength="12" size="15" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Address</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtAddress" name="txtAddress" maxlength="50" size="50" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>City</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtCity" name="txtCity" maxlength="30" size="30" required />
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
                                        <input type="text" id="txtPostcode" name="txtPostcode" maxlength="4" size="5" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Email</strong><br />
                                        <input type="text" id="txtEmail" name="txtEmail" maxlength="50" size="50" />
                                    </td>
                                </tr>
                            </table>
                            <p><span class="mandatory">* Required field</span></p>
                        </td>
                        <td valign="top">
                            <table border="0" cellpadding="5" cellspacing="0" class="form_box">
                                <tr>
                                    <td colspan="2" class="form_header">Repair Job Details</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Job Received</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtJobReceived" name="txtJobReceived" placeholder="dd/mm/yyyy" maxlength="10" size="10" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%">
                                        <strong>Job no</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtJobNo" name="txtJobNo" maxlength="7" size="10" required />
                                    </td>
                                    <td width="50%">
                                        <strong>Warranty job?</strong><br />
                                        <select name="cboWarranty">
                                            <option value="1">Yes</option>
                                            <option value="0">No</option>
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
                                        <input type="text" id="txtModelNo" name="txtModelNo" maxlength="25" size="30" required />
                                        <input type="checkbox" id="chkChangeoverModel" name="chkChangeoverModel" style="display:none;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Serial no (E.g. 21X123456XX)</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtSerialNo" name="txtSerialNo" maxlength="15" size="20" placeholder="E.g. 21X123456XX" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Dealer name</strong> <em>(Purchased from)</em> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtDealer" name="txtDealer" placeholder="Max 30 chars" maxlength="30" size="35" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <strong>Invoice / Receipt no</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtInvoiceNo" name="txtInvoiceNo" maxlength="15" size="20" required />
                                    </td>
                                    <td>
                                        <strong>Date purchased</strong> <span class="mandatory">*</span><br />
                                        <input type="text" id="txtDatePurchased" name="txtDatePurchased" placeholder="dd/mm/yyyy" maxlength="10" size="10" required />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Fault reported</strong> <span class="mandatory">*</span><br />
                                        <textarea id="txtFault" name="txtFault" rows="5" cols="50" maxlength="600" required="required" placeholder="Max 600 chars"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Accessories</strong> <br />
                                        <textarea id="txtAccessories" name="txtAccessories" rows="5" cols="50" maxlength="600" placeholder="Max 600 chars"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>Comments / Condition</strong> <br />
                                        <textarea id="txtComments" name="txtComments" rows="5" cols="50" maxlength="600" placeholder="Max 600 chars"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <div id="model-changeover-alert" style="display: none;">
                                <h2>Please Note</h2>
                                <p>Yamaha changeover/exchange program applies to this product. Special conditions may apply please check the information on the "Changeover List" a copy of which can be found in the links tab of this portal.</p>
                                <p>To be eligible for changeover;</p>
                                <ol>
                                    <li>The fault would not be rectified by a simple low cost repair and is genuinely faulty.</li>
                                    <li>The fault must be due to failure of the part listed on the “Changeover List”.</li>
                                    <li>The product meets our normal warranty conditions and the fault is not as a result of damage, corrosion or misuse.</li>
                                    <li>The product is within Yamaha warranty period (Proof of purchase is required).</li>
                                    <li>Yamaha service department has authorised the product changeover.</li>
                                </ol>
                                <p>Please follow these steps;</p>
                                <ol>
                                    <li>Take a digital photograph of the product prior to destruction, include the serial number.</li>
                                    <li>Then remove the part specified in the changeover list and retain it for three months.</li>
                                    <li>Destruction method, deface or destroy the product serial number and cause damage the product making sure it is beyond repair and cannot be returned to use. (Note irreparable damage means smashed front fascia and mainboards, include photographs)</li>
                                    <li>Take a digital photograph of the destroyed product include a clear shot of the serial number damage.</li>
                                    <li>Email the images to <a href="mailto:Matthew.madden@music.yamaha.com?subject=Changeover Request">Matthew.madden@music.yamaha.com</a> putting “Changeover request” and the portal ID in the subject line.</li>
                                    <li>When the replacement is received, notify the customer to collect and complete the job by inputting the labour charge for changeover (currently $40 plus GST) and submit the job.</li>
                                </ol>
                                <p><strong>Notes</strong></p>
                                <ol>
                                    <li>Product changeover is an alternative to repair and does not extend the customers warranty from original date of purchase.</li>
                                    <li>There is no need to have the product returned to Yamaha.</li>
                                    <li>Yamaha may request return of the part within three months.</li>
                                    <li>Warranty claim allowed for this service is $40.00 plus GST.</li>
                                    <li>The service centre is responsible for safe destruction and disposal of the faulty product and emailing the digital image to Yamaha service.</li>
                                </ol>
                                <p>If you have any questions related to this program please contact Yamaha Service on 1800 806 266.</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <br />
                            <div id="serial-alert" class="alert" style="display: none;">
                                This Serial Number does not match our database.<br />
                                Please double-check to ensure you have typed it correctly. It may require the '21' prefix.<br />
                                In any case, please continue to submit the job and Yamaha will get in touch if required.<br />
                            </div>
                            <input type="hidden" name="Action" />
                            <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
                            <input type="submit" value="Submit Repair Job" />
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <!-- #include file="include/footer.asp" -->
</table>
<script type="text/javascript" src="../include/moment.js"></script>
<script type="text/javascript" src="../include/pikaday.js"></script>
<script type="text/javascript" src="include/JobScripts.js"></script>
<script type="text/javascript">
    var picker = new Pikaday({
        field: document.getElementById('txtDatePurchased'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
        format: 'DD/MM/YYYY'
    });

    var picker = new Pikaday({
        field: document.getElementById('txtJobReceived'),
        firstDay: 1,
        minDate: new Date('2010-01-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2010,2020],
        format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>