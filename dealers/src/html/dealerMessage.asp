<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Dealer Extranet</title>

	<meta name="Title" content="Yamaha Music Australia - Dealer Extranet" />
	<meta name="Description" content="" />
	<meta name="Keywords" content="" />
	<meta name="Date" content="01/07/2006" />
	<meta name="Language" content="English" />
	<meta name="Publisher" content="Yamaha Music Australia Pty Ltd" />
	<meta name="Rights" content="Copyright 2006, Yamaha Music Australia." />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">

		@import "yamahamusic.dealerextranet.css";

		#message {
			float : left;
			margin : 0 20px 0 0;
		}

		#messageitems {
			float : left;
			width : 350px;
			padding : 0 10px 10px 10px;
		
		}

		p.whatsit {
			clear : both;
			margin : 0 0px 0 0;
		}

		div.thing {
			float : left;
		}
		
		a.remove {
			display : block;
			float:right;
		}
		
		
	</style>
	
</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<div id="left">

	<div id="howto" style="float:none;">
	
		<h3>Can’t find what you need?</h3>
		<p>Email <a href="mailto:marketinginfo@gmx.yamaha.com">professional music products marketing team</a> and we will respond to your request.</p>

		<h3>How to use this site?</h3>
		<p>Download the <a href="#">user guide</a> to find out how this site can help grow your business.  This easy to use navigation guide will show you how each section of this site has been designed to give you as much information as possible to help you make decisions about Yamaha Professional Music Products.</p>
	
	</div>

</div>
<!--#include file="global/globalMainContentStart.asp" -->


<h1>Request items from professional music products marketing team</h1>
<% 
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form action="<%= CONTROLLER %>" method="post">
	<fieldset id="message">
	
		<input type="hidden" name="action" value="<%= SEND_MESSAGE %>">

		<p><label for="name">Name</label><br/>
		<input type="text" name="name" value="<%= M._getMessageName() %>" style="width:250px;" />

		<p><label for="email">Email address</label><br/>
		<input type="text" name="email" value="<%= M._getMessageEmail() %>" style="width:250px;" />

		<p><label for="message">Your message</label><br/>
		<textarea name="message" rows="5" style="width:250px;"><%= M._getMessageMessage() %></textarea>

		<p><input type="submit" name="submit" value="submit" class="button" /></p>


	</fieldset>
		
	<fieldset id="messageitems">
<% 
	%><%
	if (M._getMessageItems().length > 0) {
		%><h2>Requested Items</h2><%
		for (i = 0; i < M._getMessageItems().length; i++) {
			R._loadResource(M._getMessageItems()[i]);
			%><p class="whatsit"><div class="thing"><%= R._getResourceName() %></div><a href="<%= CONTROLLER %>?action=<%= REMOVE_ITEM %>&amp;resourceid=<%= R._getResourceID() %>" class="remove">remove item</a></p>
			<%

		}
		%><div class="clearing"></div>
		<p>&nbsp;</p>

		<h2>Looking for more?</h2>
		<p>You don't have to make this request <em>right now</em> you can<br/>
		<a href="default.asp">return to the homepage</a> and add more items if you wish.<br/>
		Unfortunately though, if you close your internet browser,<br/>
		your selection may be lost.</p>
		
		<%
	}

%>		
	</fieldset>	
	
</form>

<div class="clearing"></div>

<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>
