<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Teacher Network</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.hideright.css";</style>

<!--#include file="global/navigationStylesheet.asp" -->

</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
				<div id="left">
<!--#include file="global/navigationLeftShallow.asp" -->
				</div>
<!--#include file="global/globalMainContentStart.asp" -->


<h1>YMEC Teacher Network</h1>
<% 
	var C = new Category();
	var R = new Resource();

	var intCategoryID = new Number(Request("categoryid"));
	var intResourceID = new Number(Request("resourceid"));

	if (!isNaN(intCategoryID)) {
		C._loadCategory(intCategoryID);
		%><h1 style="text-transform:uppercase;"><%= C._getCategoryTitle() %></h1><%
	}

	if (!isNaN(intResourceID)) {

		R._loadResource(intResourceID);

		var d = new Date(R._getResourceDatecreated());

		%><h4><%= d.formatDate("jS F Y") %></h4>
		<h2><%= R._getResourceTitle() %></h2><% 
		if (R._getResourceFilesrclg().length > 0) {
			%><img src="../<%= R._getResourceFilesrclg() %>" border="0" alt="<%= R._getResourceTitle() %>" title="<%= R._getResourceTitle() %>"/><% 
		}

		// to a quick test, weak I know for HTML
		if (R._getResourceBody().indexOf("&#60;p&#62;") >= 0) {
			%><%= cleanForText(R._getResourceBody()) %><%
		} else {
			%><p><%= cleanForText(doBRTags(R._getResourceBody())) %></p><%
		}
	}



%>
	<a href="teachers.asp">&lt;&lt; Back to Teacher Network</a>




<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>