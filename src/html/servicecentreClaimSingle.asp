<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
	<title>Yamaha Music Australia - Welcome</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<script type="text/javascript" src="/utility.js"></script>
	<script type="text/javascript" src="/prototype.js"></script>
	<script type="text/javascript" src="/schedule.js"></script>
	<script type="text/javascript" src="/string_library.js"></script>
	<script type="text/javascript" src="/content_validation.js"></script>
	<style type="text/css" media="screen">
@import "/yamahamusic.css";
</style>
	<style type="text/css" media="print">
@import "/yamahamusic.print.css";
</style>
	<style type="text/css" media="screen">
@import "/yamahamusic.nav.css";
</style>
	<style type="text/css" media="screen">
@import "yamahamusic.warranty-tweak.css";
#invoice_label {
	display : none;
}
</style>
	<script type="text/javascript" language="javascript">

		function _calculateGST() {

			var F = document.forms['formToValidate']

			var fltLabour = parseFloat(F.elements['labourcharge'].value);
			var fltParts = parseFloat(F.elements['partscharge'].value);
			var fltGST = 0;

			if (!isNaN(fltLabour) && !isNaN(fltParts)) {
				fltGST = (fltLabour + fltParts) / 10;
				F.elements['gstcharge'].value = fltGST.toFixed(2);
			}
		}

		function _setType()
		{
			if ($('rcti_1').checked)
			{
				// if the claim is an RTCI
				var style = { display: 'block' }; var h = $H(style); Element.setStyle($('rcti_label'), h);
				var style = { display: 'none' }; var h = $H(style); Element.setStyle($('invoice_label'), h);
			}
			else
			{
				var style = { display: 'none' }; var h = $H(style); Element.setStyle($('rcti_label'), h);
				var style = { display: 'block' }; var h = $H(style); Element.setStyle($('invoice_label'), h);
			}

			if ($('rcti_0').checked)
			{
				var style = { display: 'none' }; var h = $H(style); Element.setStyle($('rcti_label'), h);
				var style = { display: 'block' }; var h = $H(style); Element.setStyle($('invoice_label'), h);
			}
			else
			{
				var style = { display: 'block' }; var h = $H(style); Element.setStyle($('rcti_label'), h);
				var style = { display: 'none' }; var h = $H(style); Element.setStyle($('invoice_label'), h);
			}
		}


	</script>
	</head>

	<body>
    <!--#include file="global/globalHeader.asp" --> 
    <!--#include file="global/globalOuterContentStart.asp" -->
          <div id="left"> 
            <!--#include file="global/navigationLeftShallow.asp" --> 
          </div>
          <!--#include file="global/globalMainContentStart.asp" -->
            
            <h1>Yamaha Service Centres</h1>
            <h2>Warranty Claim</h2>
            <h3>&nbsp;</h3>
            <h3>Claim Details</h3>
            <p id="introduction">Please complete the form below and ensure the required fields are complete</p>
            <%
		if (message.length > 0) {
			%>
            <%= message %>
            <%
		}
	%>
            <form id="formToValidate" action="<%= CONTROLLER %>" method="post">
              <div>
                <fieldset style="float:left;border-bottom:0px;">
                  <input type="hidden" name="action" value="save_claim" />
                  <input type="hidden" name="claimid" value="<%= WC._getClaimID() %>" />
                  <input type="hidden" name="serviceid" value="<%= WC._getClaimServiceID() %>" />
                  <input type="hidden" name="userid" value="<%= Session("yma_userid") %>" />
                  <input type="hidden" name="status" value="<%= WC._getClaimStatus() %>" />
                  <input type="hidden" name="vendorcode" value="<%= WC._getClaimVendorcode() %>" />
                  <input type="hidden" name="dealercode" value="<%= WC._getClaimDealercode() %>" />
                  <input type="hidden" name="retailername" value="<%= WC._getClaimRetailername() %>" />
                  <input type="hidden" name="extcomment" value="<%= WC._getClaimExtcomment() %>" />
                  <input type="hidden" name="repaircode" value="<%= WC._getClaimRepaircode() %>" />
                  <input type="hidden" name="oldmodelflag" value="<%= WC._getClaimOldmodelflag() %>" />
                  <label class="required" for="creditflag"> <span class="labelText">Payment Terms <span class="requiredMarker">(required)</span></span> <span>
                    <input type="radio" name="creditflag" value="0"<%= WC._getClaimCreditflag()==0?" checked=\"checked\"":"" %> />
                    <strong>Cheque</strong> &nbsp;
                    <input type="radio" name="creditflag" value="1"<%= WC._getClaimCreditflag()==1?" checked=\"checked\"":"" %> />
                    <strong>Credit</strong> </span> </label>
                  <label class="required" for="rctiflag"> <span class="labelText">Is this an RCTI or Tax Invoice?</span> <span>
                    <input type="radio" name="rctiflag" id="rcti_0" value="0"<%= WC._getClaimRCTIflag()==0?" checked=\"checked\"":"" %> onclick="_setType();" />
                    <strong>Tax Invoice</strong> &nbsp;
                    <input type="radio" name="rctiflag" id="rcti_1" value="1"<%= WC._getClaimRCTIflag()==1?" checked=\"checked\"":"" %> onclick="_setType();" />
                    <strong>RCTI</strong> </span> </label>
                  <label for="invoicenumber" id="invoice_label"> <span class="labelText"> Invoice Number <span class="requiredMarker">(required)</span> </span>
                    <input id="invoiceNumber" name="invoicenumber" class="text" type="text" value="<%= WC._getClaimInvoicenumber() %>" maxlength="20" style="width:100px;"/>
                  </label>
                  <label for="rctinumber" id="rcti_label"> <span class="labelText"> RTCI Number <span class="requiredMarker">(required)</span> </span>
                    <input id="rctiNumber" name="rctinumber" class="text" type="text" value="<%= WC._getClaimRctinumber() %>" maxlength="20" style="width:100px;"/>
                  </label>
                </fieldset>
                <fieldset style="float:left;padding-left:20px;border-bottom:0px;">
                  <label for="dateinvoice"> <span class="labelText"><strong>Invoice Date</strong> <span class="requiredMarker">(required)</span></span> <span>
                    <%
				var rDate = new Date();
				var curYear = rDate.getFullYear()

				var dRef = WC._getClaimDateinvoice();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
                    <select name="invDay">
                    <option value="0">day...</option>
                    <%
				for (var i=1; i <= 31; i++) {
					%>
                    <option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option>
                    <%
				}
			%>
                  </select>
                    &nbsp;
                    <select name="invMonth">
                    <option value="0">month...</option>
                    <%
				for (var i=0; i < 12; i++) {
					%>
                    <option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option>
                    <%
				}
			%>
                  </select>
                    &nbsp;
                    <select name="invYear">
                    <option value="0">year...</option>
                    <%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%>
                    <option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option>
                    <%
				}
			%>
                  </select>
                    </span> </label>
                  <label for="datepurchased"> <span class="labelText"><strong>Date Purchased</strong> <span class="requiredMarker">(required)</span></span> <span>
                    <%
				var rDate = new Date();
				var curYear = rDate.getFullYear()

				var dRef = WC._getClaimDatepurchased();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
                    <select name="purDay">
                    <option value="0">day...</option>
                    <%
				for (var i=1; i <= 31; i++) {
					%>
                    <option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option>
                    <%
				}
			%>
                  </select>
                    &nbsp;
                    <select name="purMonth">
                    <option value="0">month...</option>
                    <%
				for (var i=0; i < 12; i++) {
					%>
                    <option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option>
                    <%
				}
			%>
                  </select>
                    &nbsp;
                    <select name="purYear">
                    <option value="0">year...</option>
                    <%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%>
                    <option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option>
                    <%
				}
			%>
                  </select>
                    </span> </label>
                  <label for="datereceived"> <span class="labelText"><strong>Date Received</strong> <span class="requiredMarker">(required)</span></span>
                    <%
				var dRef = WC._getClaimDatereceived();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
                    <select name="recDay">
                      <option value="0">day...</option>
                      <%
				for (var i=1; i <= 31; i++) {
					%>
                      <option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option>
                      <%
				}
			%>
                    </select>
                    &nbsp;
                    <select name="recMonth">
                      <option value="0">month...</option>
                      <%
				for (var i=0; i < 12; i++) {
					%>
                      <option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option>
                      <%
				}
			%>
                    </select>
                    &nbsp;
                    <select name="recYear">
                      <option value="0">year...</option>
                      <%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%>
                      <option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option>
                      <%
				}
			%>
                    </select>
                    </span> </label>
                  <label for="datecompleted"> <span class="labelText"><strong>Date Completed</strong> <span class="requiredMarker">(required)</span></span>
                    <%
				var dRef = WC._getClaimDatecompleted();
				if (dRef.length != 0) {
					dRef = new Date(Date.parse(dRef));
				} else {
					dRef = new Date();
				}
				var refDay = dRef.getDate();
				var refMonth = dRef.getMonth();
				var refYear = dRef.getFullYear();
			%>
                    <select name="compDay">
                      <option value="0">day...</option>
                      <%
				for (var i=1; i <= 31; i++) {
					%>
                      <option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option>
                      <%
				}
			%>
                    </select>
                    &nbsp;
                    <select name="compMonth">
                      <option value="0">month...</option>
                      <%
				for (var i=0; i < 12; i++) {
					%>
                      <option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option>
                      <%
				}
			%>
                    </select>
                    &nbsp;
                    <select name="compYear">
                      <option value="0">year...</option>
                      <%
				for (var i=curYear+1; i >= curYear-5; i--) {
					%>
                      <option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option>
                      <%
				}
			%>
                    </select>
                    </span> </label>
                </fieldset>
                <div class="clearing"></div>
              </div>
              <div style="background-color: #F0F1F3;">
                <fieldset class="alt" style="float:left;">
                  <label class="required" for="modelnumber"> <span class="labelText">Model Number <span class="requiredMarker">(required)</span></span>
                    <input id="modelnumber" name="modelnumber" class="text" type="text" value="<%= WC._getClaimModelnumber() %>" maxlength="15" style="width:100px;"/>
                  </label>
                  <label class="required" for="serialnumber"> <span class="labelText">Serial Number <span class="requiredMarker">(required)</span></span>
                    <input id="serialnumber" name="serialnumber" class="text" type="text" value="<%= WC._getClaimSerialnumber() %>" maxlength="15" style="width:100px;"/>
                  </label>
                  <label for="warrantyauth"> <span class="labelText">Warranty Authorisation </span>
                    <input id="warrantyauth" name="warrantyauth" class="text" type="text" value="<%= WC._getClaimWarrantyauth() %>" maxlength="12" style="width:100px;"/>
                  </label>
                  <label class="required" for="faultreport"> <span class="labelText">Fault Report <span class="requiredMarker">(required - 30 characters max)</span></span>
                    <input id="faultreport" name="faultreport" class="text" type="text" value="<%= WC._getClaimFaultreport() %>" maxlength="30" size="30" />
                  </label>
                  <label class="required" for="repairreport"> <span class="labelText">Repair Report <span class="requiredMarker">(required - 50 characters max)</span></span>
                    <input id="repairreport" name="repairreport" class="text" type="text" value="<%= WC._getClaimRepairreport() %>" maxlength="50" size="50" />
                  </label>
                  <label for="comment"> <span class="labelText">Comment <br/>
                    (50 characters max)</span>
                    <input id="comment" name="comment" class="text" type="text" value="<%= WC._getClaimComment() %>" maxlength="50" size="50" />
                  </label>
                </fieldset>
                <fieldset class="alt" style="float:left;padding-left:20px;border-bottom:0px;">
                  <label class="required" for="labourcharge"> <span class="labelText">Labour Charge<br/>
                    (EX GST)<span class="requiredMarker">(required)</span></span>
                    <input type="text" name="labourcharge" value="<%= WC._getClaimLabourcharge()  %>" maxlength="12" style="font-size:1.2em;text-align:right;width:80px;" onblur="_calculateGST()"/>
                  </label>
                  <label class="required" for="partscharge"> <span class="labelText">Parts Charge<br/>
                    (EX GST)<span class="requiredMarker">(required)</span></span>
                    <input type="text" name="partscharge" value="<%= WC._getClaimPartscharge() %>" maxlength="12" style="font-size:1.2em;text-align:right;width:80px;"  onblur="_calculateGST()"/>
                  </label>
                  <label for="gstcharge"> <span class="labelText"><strong>GST</strong><br/>
                    (Calculated Automatically)</span>
                    <input type="text" name="gstcharge" value="<%= WC._getClaimGSTCharge() %>" maxlength="12" style="font-size:1.2em;text-align:right;font-weight:bold;width:80px;border:0;background:none;" onfocus="blur()"/>
                  </label>
                </fieldset>
                <div class="clearing"></div>
              </div>
              <fieldset>
                <p><strong>Customer Details</strong></p>
                <label class="required" for="custname"> <span class="labelText">Full Name <span class="requiredMarker">(required)</span></span>
                  <input id="custname" name="custname" class="text" type="text" maxlength="20" size="20"  value="<%= WC._getClaimCustname() %>" />
                </label>
                <label class="required" for="custaddress"> <span class="labelText">Address <span class="requiredMarker">(required)</span></span>
                  <input id="custaddress" name="custaddress" class="text" type="text" value="<%= WC._getClaimCustaddress() %>" maxlength="50" size="50" />
                </label>
                <label class="required" for="custsuburb"> <span class="labelText">Suburb <span class="requiredMarker">(required)</span></span>
                  <input id="custsuburb" name="custsuburb" class="text" type="text" maxlength="20" size="20" value="<%= WC._getClaimCustsuburb() %>" />
                </label>
                <label class="required" for="custstate"> <span class="labelText">State <span class="requiredMarker">(required)</span></span>
                  <select id="custstate" name="custstate">
                    <option value="">choose...</option>
                    <%
					for (var i=0; i < GBL_STATES_SHORT.length; i++) {
						%>
                    <option value="<%= GBL_STATES_SHORT[i] %>"<%= WC._getClaimCuststate().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option>
                    <%
					}
			%>
                  </select>
                </label>
                <label class="required" for="custpostcode"> <span class="labelText">Postcode <span class="requiredMarker">(required)</span></span>
                  <input type="text" name="custpostcode" value="<%= WC._getClaimCustpostcode() %>" maxlength="4" style="width:50px;" />
                </label>
                <label for="custphone"> <span class="labelText">Phone Number </span>
                  <input id="custphone" name="custphone" class="text" type="text" maxlength="12" value="<%= WC._getClaimCustphone() %>" />
                </label>
              </fieldset>
              <fieldset class="submit">
                <p>
                  <input type="submit" name="submit" value="submit warranty claim" class="button" />
                </p>
              </fieldset>
            </form>
            <script type="text/javascript" language="javascript">
 _setType();
</script> 
            
            <!--#include file="global/globalMainContentEnd.asp" --> 
      <!--#include file="global/globalOuterContentEnd.asp" --> 
    <!--#include file="global/navigationFooter.asp" -->
</body>
</html>