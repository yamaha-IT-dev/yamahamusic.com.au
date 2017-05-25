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
	<style type="text/css" media="screen">@import "yamahamusic.warranty.css";</style>
	<style type="text/css" media="screen">

	.good {
		color : green;
	}

	.bad {
		color : red;
	}

	</style>

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

<h3>Upload Multiple Claims : Result</h3>

<p>&nbsp;</p>
<%
if (strRESPONSE.length > 0) {
	%><p><%= strRESPONSE %></p><%
}


%><p class="error">If there are errors, you must correct those entries and re-upload <strong>only those entries</strong> in your document.</p>

<p>If all your claims were uploaded, you can <a href="<%= CONTROLLER %>">view those items</a> and make any adjustments.</p>




<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>