<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Yamaha Connect - Home</title>
<style type="text/css" media="all">
@import "yamahamusic.dealerextranet.css";
#main a.request {
	display : block;
	margin-top : 4px;
	padding-left : 20px;
	background-image : url('../images/iconRequest.gif');
	background-repeat : no-repeat;
	background-position : 2px 50%;
}
</style>
</head>
<body>
<!--#include file="../../include/header.asp " -->
<!--#include file="global/navigationTop.asp" -->
<form action="<%= CONTROLLER %>" method="post">
  <table align="center" cellpadding="0" cellspacing="0" class="main_header_table">
    <tr>
      <td width="20%"><h1>Search product code:</h1></td>
      <td width="20%"><h2 style="color:white">Type?</h2></td>
      <td width="20%"><h2 style="color:white">Category?</h2></td>
      <td width="40%">&nbsp;</td>
    </tr>
    <tr>
      <td><input type="text" id="keywords" name="keywords" value="<%= Request("keywords") %>" maxlength="20" size="30" class="green_border" /></td>
      <td><input type="hidden" name="action" value="<%= SEARCH_ITEMS %>" />
      <select name="typeid" class="green_border_200">
          <option value="0">...</option>
          <%
			var rsAllResourceTypes = R._getAllResourceTypes(_DIVISION, "", true);
			if (rsAllResourceTypes && !rsAllResourceTypes.EOF) {
				while (!rsAllResourceTypes.EOF) {
					%>
          <option value="<%= rsAllResourceTypes("id") %>"<%= R._getResourceTypeID()==parseInt(rsAllResourceTypes("id"))?" selected=\"selected\"":"" %>><%= rsAllResourceTypes("name") %></option>
          <%
					rsAllResourceTypes.MoveNext()
				}
			}
%>
        </select></td>
      <td><select name="categoryid" class="green_border_200">
          <option value="0">...</option>
          <%
			var rsAllCategories = Cat._getAllCategories(_DIVISION);
			if (rsAllCategories && !rsAllCategories.EOF) {
				while (!rsAllCategories.EOF) {
					%>
          <option value="<%= rsAllCategories("id") %>"<%= R._getResourceCategoryID()==parseInt(rsAllCategories("id"))?" selected=\"selected\"":"" %>><%= rsAllCategories("title") %></option>
          <%
					rsAllCategories.MoveNext()
				}
			}
%>
        </select></td>
      
      <td><input type="image" name="submit" src="../images/btn_search.jpg" border="0" ></td>
    </tr>
  </table>
</form>
<br />
<table width="1120" align="center" border="0">
	<tr>
    	<td><a href="?action=search_items&amp;typeid=5"><img src="../icons/01_pos.jpg" border="0"></a></td>
        <td width="44">&nbsp;</td>
        <td><a href="?action=search_items&amp;typeid=3"><img src="../icons/02_productimage.jpg" border="0"></a></td>
        <td width="44">&nbsp;</td>
        <td><a href="?action=search_items&typeid=4"><img src="../icons/03_pricelist.jpg" border="0"></a></td>
        <td width="44">&nbsp;</td>
        <td><a href="products.asp"><img src="../icons/04_dimensions.jpg" border="0"></a></td>
        <td width="44">&nbsp;</td>
        <td><a href="returns.asp"><img src="../icons/05_goodsresturn.jpg" border="0"></a></td>
        <td width="44">&nbsp;</td>
        <td><a href="?action=search_items&typeid=10"><img src="../icons/06_downloadwebbanner.jpg" border="0"></a></td>
    </tr>
</table>
<br />
<table align="center" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" height="400" class="main_table">
  <tr>
    <td class="border_1">&nbsp;</td>
    <td class="border_2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" class="login_column"><!--#include file="global/navigationBread.asp" -->
      <!--#include file="global/globalMainContentStart.asp" -->
      <%
var d = new Date();
var intmonth = d.getMonth()==12?0:d.getMonth();

if (action == SHOW_USER_HOME) {
}
	if (intTypeID == 6) {

		%>
      <!--<p>Each product group within Professional Music Products has a different available period of warranty. Professional audio products under $6000rrp and all guitars come with a 5 year warranty. Music production, drums, Paiste and Vox products have a 12 month warranty. To make it easier for you we have created "Quick Facts" sheets on each product group which detail potential customer questions and answers, as well as ideas on how you can promote the professional audio products and guitars respective 5 year warranty.</p>-->
      <%
	} else if (intTypeID == 87) {

		Response.Redirect("training.asp");

	} else if (intTypeID == 18) {

		Response.Redirect("newsletter.asp");

	} else if (intTypeID == 88) {

		Response.Redirect("artwork.asp");

	} else if (intTypeID == 16) {

		Response.Redirect("event.asp");

	} else if (intTypeID == 11) {

		Response.Redirect("training.asp");	
	}

	if (rsAllResources && !rsAllResources.EOF) {

		var count = 0;
		var rscount = rsAllResources.RecordCount;

		if (action == SEARCH_ITEMS) {
			%>
      <p><b>Item Search <img src="../images/forward_arrow.gif" /> <%= rscount %> <%= rscount==1?" item":" items" %> found</b></p>
      <%
		} else {
			%>
      <h1>Latest Uploads</h1>
      <%
		}
		while (!rsAllResources.EOF) {
			%>
      <div class="item">
        <%
				if (parseInt(rsAllResources("typeid")) == 4)
				{
					%>
        <img src="../images/imgProductPricelist.gif" />
        <%
				}
				else
				{
					if (new String(rsAllResources("filesrcsm")).indexOf("null") == 0 || new String(rsAllResources("filesrcsm")).length == 0)
					{
						%>
        <img src="../images/imgNoPreview.gif" />
        <%
					}
					else
					{
						%>
        <img src="<%= rsAllResources("filesrcsm") %>" />
        <%
					}
				}
				%>
        <p><b><%= rsAllResources("name") %></b></p>
        <p><%= rsAllResources("description") %><br/>
          <%
				if (new String(rsAllResources("filesrclg")).indexOf("null") != 0 && new String(rsAllResources("filesrclg")).length != 0) {
					var file = new String(rsAllResources("filesrclg"))
					var ext = file.substr(file.lastIndexOf(".")+1, 3).toLowerCase();
					%>
          <img src="../images/forward_arrow.gif" /> <a href="<%= rsAllResources("filesrclg") %>" class="<%= ext %>">View this file (<%= ext %>)</a>
          <%
				}
				if (parseInt(rsAllResources("typeid")) == 9) {
					%>
          <img src="../images/mouse.jpg" align="bottom" /> <a href="http://www.<%= rsAllResources("name") %>/" class="<%= ext %>" target="_blank"><%= rsAllResources("name") %> </a>
          <%
				}
				if (parseInt(rsAllResources("onrequest")) == 1) {
					%>
          <br/>
          <a href="request.asp?action=add_item&amp;resourceid=<%= rsAllResources("id") %>" class="request">Request this item</a>
          <%
				}
				%>
        </p>
      </div>
      <%
			count ++;
			if (count == 6) {
				%>
      <div style="clear:left;"></div>
      <%
				count = 0;
			}
			rsAllResources.MoveNext();
		}
	} else {
		if (isNaN(intCategoryID)) {
			%>
      <p>Please choose a category.</p>
      <%
		} else {
			%>
      <p>There are no resources.</p>
      <%
		}
	}
%></td>
  </tr>
  <tr>
    <td class="border_3">&nbsp;</td>
    <td class="border_4">&nbsp;</td>
  </tr>
</table>
<!--#include file="../../include/footer.asp " -->
</body>
</html>