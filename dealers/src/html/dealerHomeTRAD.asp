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
	<style type="text/css" media="all">@import "/yamahamusic.css";</style>
	<style type="text/css" media="all">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="all">

		@import "yamahamusic.dealerextranet.trad.css";

		#main a.request {
			display : block;
			margin-top : 4px;
			padding-left : 20px;
			background-image : url('../images/iconRequest.gif');
			background-repeat : no-repeat;
			background-position : 2px 50%;
		}

		#main {
			height : 500px;
		}


	</style>

</head>

<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<div id="left">

	<form action="<%= CONTROLLER %>" method="post">
		<fieldset>
			<input type="hidden" name="action" value="<%= SEARCH_ITEMS %>" />

		<h1>Search</h1>

		<p><label for="typeid">Type</label><br/>
		<select name="typeid" style="width:150px;">
			<option value="0">please choose...</option>
<%
			var rsAllResourceTypes = R._getAllResourceTypes(_DIVISION, "", true);
			if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
				while (!rsAllResourceTypes.EOF) {
					%><option value="<%= rsAllResourceTypes("id") %>"<%= R._getResourceTypeID()==parseInt(rsAllResourceTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllResourceTypes("name") %></option><%
					rsAllResourceTypes.MoveNext()
				}
			}
%>
		</select>

		<label for="categoryid">Category</label><br/>
		<select name="categoryid" style="width:150px;">
			<option value="0">please choose...</option>
<%
			var rsAllCategories = Cat._getAllCategories(_DIVISION);
			if (rsAllCategories && !rsAllCategories.EOF) {
				while (!rsAllCategories.EOF) {
					%><option value="<%= rsAllCategories("id") %>"<%= R._getResourceCategoryID()==parseInt(rsAllCategories("id"))?" selected=\"selected\"":"" %>><%= rsAllCategories("title") %></option><%
					rsAllCategories.MoveNext()
				}
			}
%>
		</select>


		<label for="keywords">Keywords</label><br/>
		<input type="text" id="keywords" name="keywords" value="<%= Request("keywords") %>" style="width:142px;"/><br/>

		<input type="submit" name="submit" id="submit" value="search" class="button"></p>

		</fieldset>
	</form>

	<div id="howto" style="position:absolute;">

		<h3>Can't find what you need?</h3>
		<p>Email <a href="mailto:trad_aumarketing@gmx.yamaha.com">traditional music products marketing team</a> and we will respond to your request.</p>

	</div>


</div>
<!--#include file="global/globalMainContentStart.asp" -->

<div id="midright">
<%
	var rsAllResourceTypes = R._getAllResourceTypes(_DIVISION, "PRODUCT_INFORMATION", true);
	if (rsAllResourceTypes) {
		rsAllResourceTypes.MoveFirst();
		if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
			%>
			<h1>Product Information</h1>
			<ul><%
			while (!rsAllResourceTypes.EOF) {
				%><li><a href="<%= CONTROLLER %>?action=<%= SEARCH_ITEMS %>&amp;typeid=<%= rsAllResourceTypes("id") %>"><%= rsAllResourceTypes("name") %></a></li><%
				rsAllResourceTypes.MoveNext()
			}
			%><li><a href="http://www.yamaha.co.jp/manual/english/" target="_blank">Manuals - Online Library</a></li></ul><%
		}
	}

	var rsAllResourceTypes = R._getAllResourceTypes(_DIVISION, "MARKETING_IDEAS", true);
	if (rsAllResourceTypes) {
		rsAllResourceTypes.MoveFirst();
		if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
			%>
			<h1>Marketing Ideas</h1>
			<ul><%
			while (!rsAllResourceTypes.EOF) {
				%><li><a href="<%= CONTROLLER %>?action=<%= SEARCH_ITEMS %>&amp;typeid=<%= rsAllResourceTypes("id") %>"><%= rsAllResourceTypes("name") %></a></li><%
				rsAllResourceTypes.MoveNext()
			}
			%></ul><%
		}
	}

%>
	<h1>Professional Products</h1>
	<ul>
		<li>
			<a href="default.asp?action=<%= CHANGE_TYPE %>">Switch now to see resources for <strong>Guitars, Vox, Drums, Paiste, Music Production, Synthesizers, Recording Equipment and Professional Audio</strong></a>
		</li>
	</ul>
</div>


<%

var d = new Date();
var intmonth = d.getMonth()==12?0:d.getMonth();

if (action == SHOW_USER_HOME) {
	%>
	<h2>Welcome to <%= GBL_MONTHS[intmonth] %> trading!</h2>

	<p>This is your dedicated marketing site and we welcome any suggestions, comments, feedback or questions you may have that would help us support your business.
	Please email  <a href="mailto:trad_aumarketing@gmx.yamaha.com">trad_aumarketing@gmx.yamaha.com</a> to contact the Traditional	Music Products marketing team.</p>

	</p>
	<%
}

%>


<div id="results">
<%
	if (intTypeID == 6) {

		%><p>Each product group within Professional Music Products has a different available period of warranty.  Professional audio products under $6000rrp and all guitars come with a 5 year warranty.  Music production, drums, Paiste and Vox products have a 12 month warranty.  To make it easier for you we have created "Quick Facts" sheets on each product group which detail potential customer questions and answers, as well as ideas on how you can promote the professional audio products and guitars respective 5 year warranty.</p><%

	} else if (intTypeID == 18) {

		%><p>This new initiative is to keep you up-to-date with new products, interesting facts about current products, information on new campaigns, up and coming events, Yamaha artists and any general information that we can provide to help you and your sales staff support Yamaha product.  This newsletter will be available from this site, and provided we have your email address you will receive it directly in your in-box.  We would like to make sure that you and your staff do not miss out on receiving such important information.  Please email <a href="mailto:trad_aumarketing@gmx.yamaha.com">trad_aumarketing@gmx.yamaha.com</a> to submit your (and your staff's) email address.  If at anytime you wish to be removed, all you have to do is email a removal request to the same address.  Please note Yamaha complies with the Privacy Act and keeps in confidence any information collected.</p><%

	} else if (intTypeID == 16) {

		%><p>Would you like to hold a consumer event?  Interested in utilising a Yamaha artist?  Maybe it's to showcase a new product, a product line that needs that extra attention, or you would like to create a sales event and need an attraction?  We have a selected group of artists that are also clinicians that can help promote Yamaha products to your customers and help you generate interest and more sales.  Download the Clinician Request Form, fill it in, and either email it to <a href="mailto:trad_aumarketing@gmx.yamaha.com">trad_aumarketing@gmx.yamaha.com</a> or hand it to your Sales Manager when they next visit your store.  Once we receive it at head office, we will notify you and let you know if we are able to accommodate your requested date.  Artist schedules are usually book out quickly, so please allow plenty of time to place this request before the event date.</p><%

	} else if (intTypeID == 11) {

		%><p>Do your staff need in store training?  Is there a product group you would like to focus on within your store, but need additional in store training?  Have you recently taken on a new product line and need more information delivered directly to your staff in store to help launch it? Download the Training Request Form, fill it in, and either email it to <a href="mailto:trad_aumarketing@gmx.yamaha.com">trad_aumarketing@gmx.yamaha.com</a> or hand it to your Sales Manager when they next visit your store.  Once we receive it at head office, we will notify you and let you know if we are able to accommodate your requested date.  All product managers are able to provide in store training.</p><%
	}



	if (rsAllResources && !rsAllResources.EOF) {

		var count = 0;
		var rscount = rsAllResources.RecordCount;

		if (action == SEARCH_ITEMS) {
			%><h1>Item Search » <%= rscount %> <%= rscount==1?" item":" items" %> found</h1><%
		} else {
			%><h1>Latest Uploads</h1><%
		}


		while (!rsAllResources.EOF) {
			%>
			<div class="item">
				<%
				if (new String(rsAllResources("filesrcsm")).indexOf("null") == 0 || new String(rsAllResources("filesrcsm")).length == 0) {
					%><img src="../images/imgNoPreview.gif" /><%
				} else {
					if (parseInt(rsAllResources("typeid")) == 4) {
						%><img src="../images/imgProductPricelist.gif" /><%
					} else {
						%><img src="<%= rsAllResources("filesrcsm") %>" /><%
					}

				}
				%>
				<h2><%= rsAllResources("name") %></h2>
				<p><%= rsAllResources("description") %><br/>
				<%
				if (new String(rsAllResources("filesrclg")).indexOf("null") != 0 && new String(rsAllResources("filesrclg")).length != 0) {
					var file = new String(rsAllResources("filesrclg"))
					var ext = file.substr(file.lastIndexOf(".")+1, 3).toLowerCase();
					%><a href="<%= rsAllResources("filesrclg") %>" class="<%= ext %>">View this file (<%= ext %>)</a><%
				}
				if (parseInt(rsAllResources("typeid")) == 9) {
					%>visit <a href="http://<%= rsAllResources("name") %>/" class="<%= ext %>" target="blank"><%= rsAllResources("name") %> </a><%
				}
				if (parseInt(rsAllResources("onrequest")) == 1) {
					%><br/><a href="request.asp?action=add_item&amp;resourceid=<%= rsAllResources("id") %>" class="request">Request this item</a><%
				}
				%></p>
			</div>
			<%
			count ++;
			if (count == 3) {
				%><div style="clear:left;"></div><%
				count = 0;
			}
			rsAllResources.MoveNext();
		}
	} else {
		if (isNaN(intCategoryID)) {
			%><p>Please choose a category.</p><%
		} else {
			%><p>There are no resources.</p><%
		}
	}

%>

</div>

















<div class="clearing"></div>

<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>
