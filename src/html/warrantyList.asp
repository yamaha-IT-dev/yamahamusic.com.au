<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Welcome</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.customer.css";</style>
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
				<div id="leftnav">

				</div>
<!--#include file="global/globalMainContentStart.asp" -->

<h1 style="font-size:2.5em;">Yamaha Warranty</h1>
<% 
	if (Session("yma_customerid") > 0) {
%>

	<h2>Previous Regsistrations</h2>
<% 
	var rsAllWarranties = W._getAllWarrantyByCustomer(Session("yma_customerid"));
	if (rsAllWarranties != null && !rsAllWarranties.EOF) {
		%><table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<th>Model Number</th>
			<th>Serial Number</th>
			<th>Place of Purchase</th>
			<th>Purchase Price</th>
			<th>Purchase Date</th>
		</tr><%
		while (!rsAllWarranties.EOF) {
			%>
			<tr>
				<td><%= rsAllWarranties("modelnumber") %></td>
				<td><%= rsAllWarranties("serialnumber") %></td>
				<td><%= rsAllWarranties("purchaseplace") %></td>
				<td><%= rsAllWarranties("purchaseprice") %></td>
				<td><%= new Date(rsAllWarranties("purchasedate")).formatDate("jS F Y") %></td>
			</tr><%
			rsAllWarranties.MoveNext();	
		}
		%></table><%
	} else {
		%><p>You have no previous warranty registrations</p><%
	}




%>

	<h2>Register a new product</h2>

	<form name="warrantyRegistrationForm" action="<%= CONTROLLER %>" method="post">
		<input type="hidden" name="action" value="<%= SAVE_WARRANTY %>" />
		<input type="hidden" name="customerid" value="<%= Session("customerid") %>" />

		<p><label class="required">Warranty Type</label>
		<select name="warrantytypeid" style="width:120px;" onchange="changeTerms(this)">
			<option value="">please choose...</option><%
			for (var i=1; i < GBL_WARRANTYIDS.length; i++) {
				%><option value="<%= GBL_WARRANTYIDS[i] %>"<%= W._getWarrantyTypeID()==i?" selected=\"selected\"":"" %>><%= GBL_WARRANTYTYPES[i] %></option>
				<%
			}
		%></select></p>

		<p><label class="required">Model Number</label>
		<input type="text" name="modelnumber" value="<%= W._getWarrantyModelnumber() %>" style="width:120px;" /></p>

		<p><label class="required">Serial Number</label>
		<input type="text" name="serialnumber" value="<%= W._getWarrantySerialnumber() %>" style="width:120px;" /></p>

		<p><label class="required">Place of Purchase</label>
		<input type="text" name="purchaseplace" value="<%= W._getWarrantyPurchaseplace() %>" style="width:160px;" /></p>

		<p><label class="required">Purchase Price</label>
		<input type="text" name="purchaseprice" value="<%= W._getWarrantyPurchaseprice() %>" style="width:80px;" /></p>

		<p><label class="required">Date of Purchase</label>
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
			<option value="0">day...</option><%
			for (var i=1; i <= 31; i++) {
				%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select>&nbsp;
		<select name="dobMonth">
			<option value="0">month...</option><%
			for (var i=0; i < 12; i++) {
				%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
			}
		%></select>&nbsp;
		<select name="dobYear">
			<option value="0">year...</option><%
			for (var i=dNow.getFullYear(); i >= dNow.getFullYear()-2; i--) {
				%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
			}
		%></select></p>

		<p><input type="checkbox" name="terms" value="1" <%= W._getWarrantyTerms()==1?" checked=\"checked\"":"" %> /> Check this box to confirm that you have read and<br/>understood the <a href="javascript:alert('You must choose a warranty type first');" id="termslink" target="_self">terms and conditions</a> of this warranty.</p>

		<p><input type="submit" name="submit" value="save warranty registration" class="button" /></p>
	
	</form>



<% 
	}
%>

<div class="clearing"></div>


<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>