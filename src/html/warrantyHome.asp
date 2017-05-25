<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Music Australia - Yamaha Warranty</title>
<meta name="Description" content="" />
<meta name="Keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<script type="text/javascript" src="/utility.js"></script>
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
@import "/yamahamusic.customer.css";
</style>
<style type="text/css" media="screen">
legend {
	font-weight : bold;
	color : #333;
	margin : 0 0 0 0;
	padding : 0 0 0 0;
}
label {
	float:left;
	width : 7em;
	padding-top:0.3em;
}
label.required {
	float:left;
	width : 9em;
	padding-top:0.3em;
	font-weight : bold;
}
#warrantyperiods {
	background-image : url('images/logoWarrantyPale.jpg');
	background-repeat : no-repeat;
	background-position : top right;
}
.actionbox {
	height : 1%;
	background-color : #EFEFEF;
	padding : 5px 10px 5px 10px;
}
#warrantyperiods ul {
	padding : 0 0 0 0;
	margin : 0 0 5px 0;
}
#warrantyperiods li {
	padding : 0 0 0 0;
	margin : 0 0 10px 0;
	list-style-type : none;
}
span.reason {
	position : relative;
	float : left;
	width : 15em;
}
</style>
<script type="text/javascript">

	var arrWarrantyDocs = new Array();
		arrWarrantyDocs.push();
	<%

for (var i=0; i < GBL_WARRANTYDOCS.length; i++) {
	%>arrWarrantyDocs.push('<%= GBL_WARRANTYDOCS[i] %>');
	<%
}

%>
	function changeTerms(obj) {

		var strHref = arrWarrantyDocs[obj.selectedIndex];
		objLink = document.getElementById("termslink");

		if (obj.selectedIndex != 0) {
			objLink.setAttribute('href', strHref);
			objLink.setAttribute('target', '_blank');
		} else {
			objLink.setAttribute('href', "javascript:alert('You must choose a warranty type first');");
			objLink.setAttribute('target', '_self');
		}
	}

	</script>
<!--#include file="global/navigationStylesheet.asp" -->
</head>
<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
      <div id="leftnav"> </div>
      <!--#include file="global/globalMainContentStart.asp" -->
        <h1 style="font-size:2.5em;">Yamaha Warranty</h1>
        <div class="column" style="width:600px;">
          <h2>Now register your Yamaha product online!</h2>
          <p>Save yourself a trip to the post office and simply complete our online warranty registration form. You will need to <a href="../customer.asp?action=new_customer">register as a customer</a> of the Yamaha Music Australia website first. Then follow the steps.</p>
          <p>Select the product category below that best describes your Yamaha product, provide your model number, serial number, place of purchase, purchase date and purchase price to record your warranty online.</p>
          <div id="warrantyperiods">
            <h1>Products and Warranty Periods</h1>
            <p>Choose a product category that is relevant to you <br/>
              and read the terms and conditions of that warranty.</p>
            <h2>6 Months</h2>
            <ul>
              <li><a href="warrantyAVIT.asp">Lamp cartridges for projectors</a></li>
            </ul>
            <h2>1 Year</h2>
            <ul>
              <li><a href="warrantyVox.asp">VOX Amplification</a></li>
              <li><a href="warrantyPaiste.asp">Paiste Cymbals</a></li>
              <li><a href="warrantyDrums.asp">Yamaha Drums</a></li>
              <li><a href="warrantyCA.asp">Commercial Audio</a></li>
              <li><a href="warrantyAVIT.asp">Audio Visual Accessories</a></li>
            </ul>
            <hr />
            <h2>2 Years</h2>
            <ul>
              <li><a href="warrantyAVIT.asp">AV Receivers, Speaker &amp; Subwoofers, Hi-fi Components, Blu-ray Players</a></li>
            </ul>
            <hr />
            <h2>3 Years</h2>
            <ul>
              <li><a href="warrantyKeyboard.asp">Clavinova</a></li>
              <li><a href="warrantyKeyboard.asp">YDP, P-Series Digital Pianos and Portable Keyboards</a></li>
              <li><a href="warrantyBO.asp">Wind &amp; Percussion Instruments</a></li>
            </ul>
            <hr />
            <h2>5 Years</h2>
            <ul>
              <li><a href="warrantyGuitar.asp">Guitars</a></li>
              <li><a href="/products/proaudio/warranty.asp">Pro Audio, Mixing Desks, Speakers, Effects Units</a></li>
              <li><a href="warrantyAVIT.asp">RX-Z11 AV Receiver</a></li>
              <li><a href="warrantyAVIT.asp">RX-Z9 AV Receiver</a></li>
              <li><a href="warrantyAVIT.asp">Soavo Series speakers</a></li>
              <li><a href="warrantyAVIT.asp">HX Series speakers</a></li>
            </ul>
            <hr />
            <h2>10 Years</h2>
            <ul>
              <li><a href="../products/musicalinstruments/pianos/warranty.asp">Yamaha Acoustic Pianos</a></li>
            </ul>
            Yamaha Acoustic Pianos receive a ten year warranty,
            though the conditions of this warranty are quite
            specific and require, among other things that your
            piano is properly installed by an authorised Yamaha
            Piano Technician. <a href="../products/musicalinstruments/pianos/warranty.asp">Read more...</a>
            <div class="clearing"></div>
          </div>
        </div>
        <div class="column" style="width:350px;">
          <%
	if (Session("yma_customerid") > 0) {
%>
          <div class="actionbox">
            <h2>Register for a warranty</h2>
            <%
	if (message.length > 0) {
		%>
            <p class="alert"><%= message %></p>
            <%
	}
%>
            <form action="<%= CONTROLLER %>" method="post" id="warrantyRegistrationForm">
              <input type="hidden" name="action" value="<%= SAVE_WARRANTY %>" />
              <input type="hidden" name="customerid" value="<%= Session("customerid") %>" />
              <p>
                <label class="required">Warranty Type</label>
                <select name="warrantytypeid" style="width:120px;" onchange="changeTerms(this)">
                  <option value="">please choose...</option>
                  <%
			for (var i=1; i < GBL_WARRANTYIDS.length; i++) {
				%>
                  <option value="<%= GBL_WARRANTYIDS[i] %>"<%= W._getWarrantyTypeID()==i?" selected=\"selected\"":"" %>><%= GBL_WARRANTYTYPES[i] %></option>
                  <%
			}
		%>
                </select>
              </p>
              <p>
                <label class="required">Model Number</label>
                <input type="text" name="modelnumber" value="<%= W._getWarrantyModelnumber() %>" style="width:120px;" />
              </p>
              <p>
                <label class="required">Serial Number</label>
                <input type="text" name="serialnumber" value="<%= W._getWarrantySerialnumber() %>" style="width:120px;" />
              </p>
              <p>
                <label class="required">Place of Purchase</label>
                <input type="text" name="purchaseplace" value="<%= W._getWarrantyPurchaseplace() %>" style="width:160px;" />
              </p>
              <p>
                <label class="required">Purchase Price</label>
                <input type="text" name="purchaseprice" value="<%= W._getWarrantyPurchaseprice() %>" style="width:80px;" />
              </p>
              <p>
                <label class="required">Date of Purchase</label>
                <%

			var dRef = W._getWarrantyPurchasedate();
			var dNow = new Date();
			if (dRef.length != 0) {
				dRef = new Date(Date.parse(dRef));
			} else {
				dRef = new Date();
			}
			var refDay = dRef.getDate();
			var refMonth = dRef.getMonth();
			var refYear = dRef.getFullYear();
		%>
                <select name="dobDay">
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
                <select name="dobMonth">
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
                <select name="dobYear">
                  <option value="0">year...</option>
                  <%
			for (var i=dNow.getFullYear(); i >= dNow.getFullYear()-2; i--) {
				%>
                  <option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option>
                  <%
			}
		%>
                </select>
              </p>
              <p>
                <input type="checkbox" name="terms" value="1" <%= W._getWarrantyTerms()==1?" checked=\"checked\"":"" %> />
                Check this box to confirm that you have read and<br/>
                understood the <a href="javascript:alert('You must choose a warranty type first');" id="termslink" target="_self">terms and conditions</a> of this warranty.</p>
              <p>
                <label style="float:none;font-weight:bold;margin-bottom:0px;">Your reasons for choosing Yamaha</label>
                <%
			for (var i=0; i < arrReasons.length; i++) {
				%>
                <span class="reason">
                <input type="checkbox" name="reasons" value="<%= arrReasons[i] %>"<%= W._getWarrantyReasons().indexOf(arrReasons[i])>=0?" checked=\"checked\"":"" %> />
                &nbsp;<%= arrReasons[i] %></span>
                <%
			}
		%>
              </p>
              <div class="clearing"></div>
              </p>
              <input type="hidden" name="comments" value="<%= W._getWarrantyComments() %>" />
              <p><br/>
                <input type="submit" name="submit" value="save warranty registration" class="button" />
              </p>
            </form>
          </div>
          <h2>Previous Regsistrations</h2>
          <%
	var rsAllWarranties = W._getAllWarrantyByCustomer(Session("yma_customerid"));
	if (rsAllWarranties != null && !rsAllWarranties.EOF) {
		var rc = rsAllWarranties.RecordCount;
		%>
          <p>You have recorded <a href="<%= CONTROLLER %>?action=<%= WARRANTY_LIST %>"><strong><%= rc %> previous <%= rc>1?"warranties":"warranty" %></strong></a> with us.<br/>
            Your most recent was;
            <%
		rsAllWarranties.MoveFirst()
			%>
          </p>
          <p>Model number: <strong><%= rsAllWarranties("modelnumber") %></strong><br/>
            Serial number : <strong><%= rsAllWarranties("serialnumber") %></strong><br/>
            Place of purchase : <strong><%= rsAllWarranties("purchaseplace") %></strong><br/>
            Purchase price : <strong><%= rsAllWarranties("purchaseprice") %></strong><br/>
            Date of purchase : <strong><%= new Date(rsAllWarranties("purchasedate")).formatDate("jS F Y") %></strong><br/>
            <%

		%>
          </p>
          <p>View all of your <a href="<%= CONTROLLER %>?action=<%= WARRANTY_LIST %>">previous registrations</a>.</p>
          <%
	} else {
		%>
          <p>You have no previous warranty registrations</p>
          <%
	}


%>
          <%
	} else {
%>
          <div class="column" style="width:250px;">
            <h2>To take advantage of our online warranty registration,
              you must become a member of our online community.</h2>
            <p>There are many advantages to registering yourself as a
              customer, and once you're a part of the huge Yamaha community
              of audiophiles, musicians and artists you become part of a
              great tradition.</p>
            <div class="actionbox">
              <h2>Existing Customers</h2>
              <form action="../customer.asp" method="post" id="loginForm">
                <fieldset>
                  <legend>Log in</legend>
                  <input type="hidden" name="action" value="customer_login" />
                  <p>
                    <label for="email">Email address</label>
                    <input type="text" name="email" value="" style="width:120px;"/>
                    <br/>
                    <label for="password">Password</label>
                    <input type="password" name="password" value="" style="width:120px;" />
                    <br/>
                    <label for="submit"></label>
                    <input type="submit" name="submit" value="submit" class="button" />
                  </p>
                </fieldset>
              </form>
            </div>
            <p>&nbsp;</p>
            <h2>New Customers</h2>
            <p>If this is your first warranty registration online, we'll need you to register yourself as a customer.
              You'll only have to do this once and all we'll keep track of all your product registrations</p>
            <p><a href="/customer.asp?action=new_customer" class="button">Register now</a></p>
          </div>
          <%
	}
%>
        </div>
        <div class="clearing"></div>
        <!--#include file="global/globalMainContentEnd.asp" -->
  <!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>