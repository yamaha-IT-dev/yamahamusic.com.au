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
	<style type="text/css" media="screen">@import "/yamahamusic.hideright.css";</style>

	<style type="text/css" media="screen">@import "yamahamusic.warranty.css";</style>
<!--#include file="global/navigationStylesheet.asp" -->

	<script type="text/javascript" language="javascript">

		function _calculateGST() {

			var F = document.forms['claimForm']

			var fltLabour = parseFloat(F.elements['labourcharge'].value);
			var fltParts = parseFloat(F.elements['partscharge'].value);
			var fltGST = 0;

			if (!isNaN(fltLabour) && !isNaN(fltParts)) {
				fltGST = (fltLabour + fltParts) / 10;
				F.elements['gstcharge'].value = fltGST.toFixed(2);
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

<h3>Upload Multiple Claims</h3>

<form name="claimForm" action="<%= CONTROLLER %>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="action" value="<%= CAPTURE_MULTIPLE %>" />
	<input type="hidden" name="serviceid" value="<%= WC._getClaimServiceID() %>" />
	<input type="hidden" name="userid" value="<%= Session("yma_userid") %>" />
	<input type="hidden" name="status" value="<%= WC._getClaimStatus() %>" />
	<input type="hidden" name="vendorcode" value="<%= WC._getClaimVendorcode() %>" />
	<input type="hidden" name="dealercode" value="<%= WC._getClaimDealercode() %>" />
	<input type="hidden" name="retailername" value="<%= WC._getClaimRetailername() %>" />

	<%
		if (message.length > 0) {
			%><p class="alert"><%= message %></p><%
		}
	%>
	<p>Choose your file<br/>
	<input type="file" name="filesrc" value="" size="34" style="width:250px;"/><br/>

	<p><input type="submit" name="submit" value="upload claims" class="button" /></p>

</form>

<p>Your accounting program must output your claims in the correct format or you must prepare your claims using our <a href="resources/YMA_WarrantyClaimUpload.xlt">template</a>
<br/><a href="resources/WarrantyClaims-HowTo.pdf" class="pdf">Download our how-to</a> to learn more about this.</p>

<p>To upload multiple claims, you must submit them in an Excel&trade; document.
<br/>You can use our upload template;
<br/><a href="resources/YMA_WarrantyClaimUpload.xlt" class="xls">Download our upload template</a></p>

<p><strong>Required Fields</strong><br/>
All fields are required, we've attempted to streamline the upload process, so all the fields in the Excel template are required - <strong>except</strong> customer phone, though this is preferred. 
</p>

<h2>Important Tips</h2>
<p><strong style="color:red;">NOTE</strong> you must not change the name of the Excel Worksheet. This must be kept as "Claims" when you attempt to upload your claims.</p>
<p><strong style="color:red;">NOTE</strong> you must not copy over the first row - this is critical in defining the information below.</p>

<p><strong>Validation</strong><br/>
If one of the claims in your upload fails, it won't affect your other claims. After your claims have been processed, you will be shown which claims were uploaded successfully and which claims failed (and why). You can easily, edit and adjust the invalid claims and re-upload them - <strong>make sure that you remove the successful claims from the document</strong> duplicate claims will not be honoured.</p>


<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>