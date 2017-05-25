<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Music Australia - Dealer Search</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
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
@import "/yamahamusic.nobordertables.css";
</style>
<style type="text/css" media="screen">
#container {
	width : 600px;
}
#main {
	margin-left : 40px;
}
</style>
<!--#include file="global/navigationStylesheet.asp" -->
</head>
<body>
<div style="margin : 10px 0 0 10px;float:left;width:150px;">
  <h2 style="font-size:1em;">Specialized Dealers</h2>
  <p style="font-size:0.85em;"><a href="<%= CONTROLLER %>?action=<%= DEALER_SEARCH %>&amp;type=clavplatinum" title="" style="text-decoration:none;"><img src="logoClavPlatinum.jpg" border="0" alt="Clavinova Platinum Dealer" /><br/>
    <strong>Clavinova Platinum</strong></a><br/>
    An exclusive network of premium dealers, specialising in the best selection of Yamaha's premium range of digital pianos.</p>
  <p style="font-size:0.85em;"><a href="<%= CONTROLLER %>?action=<%= DEALER_SEARCH %>&amp;type=pronetwork" title="" style="text-decoration:none;"><img src="logoProNetwork.gif" border="0" alt="Pro Network : Wind Instruments" /><br/>
    <strong>ProNetwork</strong></a><br/>
    An exclusive network of premium dealers, specialising in Yamaha's prestigious Professional and Custom range of Brass and Woodwind.</p>
</div>
<!--#include file="global/globalOuterContentStart.asp" -->
<!--#include file="global/globalMainContentStart.asp" -->
<h1>Yamaha Dealers</h1>
<h2>Dealer Search</h2>
<form name="searchForm" action="<%= CONTROLLER %>" method="post">
  <input type="hidden" name="action" value="<%= DEALER_SEARCH %>" />
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td><select name="productid" id="productid" style="font-size:1.2em;">
          <option value="0">choose product category...</option>
          <option value="0"<%= parseInt(intProductID)==0?" selected=\"selected\"":"" %>>Any product category</option>
          <% 
			var rsAllProduct = P._getAllProductCategoryExceptAV();
			if (rsAllProduct && !rsAllProduct.EOF) {
				while (!rsAllProduct.EOF) {
					%>
          <option value="<%= rsAllProduct("id") %>"<%= parseInt(intProductID)==rsAllProduct("id")?" selected=\"selected\"":"" %>><%= rsAllProduct("parent") %> - <%= rsAllProduct("name") %></option>
          <%
					rsAllProduct.MoveNext();
				}
			}
		%>
        </select></td>
    </tr>
    <tr>
      <td><select name="state" id="state" style="font-size:1.2em;">
          <option value="all">choose state...</option>
          <option value="all"<%= strState=="all"?" selected=\"selected\"":"" %>>All states</option>
          <% 
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%>
          <option value="<%= GBL_STATES_SHORT[i] %>"<%= strState==GBL_STATES_SHORT[i]?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option>
          <%
			}
		%>
        </select></td>
    </tr>
    <tr>
      <td style="font-size:1.2em;"><input type="text" name="postcode" value="<%= strPostcode %>" style="width:50px;" maxlength="4" />
        Postcode </td>
    </tr>
    <tr>
      <td style="font-size:1.2em;"><input type="radio" name="region" value=""<%= strRegion=="undefined"||strRegion==""?" checked=\"checked\"":"" %> onclick="clearPostCode()" />
        All Areas &nbsp;&nbsp;
        <input type="radio" name="region" value="M"<%= strRegion=="M"?" checked=\"checked\"":"" %>/>
        Metropolitan &nbsp;&nbsp;
        <input type="radio" name="region" value="R"<%= strRegion=="R"?" checked=\"checked\"":"" %>/>
        Regional </td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" name="submit" value="list dealers" class="button"  style="font-size:1.2em;"/></td>
    </tr>
  </table>
</form>
<h1><a href="http://www.yamahamusic.com.au/products/av/dealers.asp">Click here to locate AV Dealers</a></h1>
<% 

if (rsDealerSearch && !rsDealerSearch.EOF) {
	var rsRC = rsDealerSearch.RecordCount;
	var count = 0;
	if (rsRC == -1) {
		rsRC = 0;
		while (!rsDealerSearch.EOF) {
			rsRC++;
			rsDealerSearch.MoveNext();
		}
		rsDealerSearch.MoveFirst();
	}
	%>
<h2><%= rsRC %> Dealers Found</h2>
<%
	while (!rsDealerSearch.EOF) {
		%>
<div class="dealer">
  <%
		if (parseInt(Request("productid")) == 5) {
			if (new Number(rsDealerSearch("pronetwork"))==1) {	
				%>
  <img src="logoProNetwork.gif" border="0" alt="Pro Network : Wind Instruments" style="float:right;"/>
  <% 
			}
		}
		if (parseInt(Request("productid")) == 8) {
			if (new Number(rsDealerSearch("clavplatinum"))==1) {	
				%>
  <img src="logoClavPlatinum.jpg" border="0" alt="Clavinova Platinum Dealer" style="clear:both;float:right;margin-top:5px;"/>
  <% 
			}
		}
		%>
  <h3><%= rsDealerSearch("name") %></h3>
  <p><%= rsDealerSearch("address") %><br/>
    <%= rsDealerSearch("city") %>, <%= rsDealerSearch("state") %>&nbsp;&nbsp;<%= rsDealerSearch("postcode") %> <%= new String(rsDealerSearch("phone")).indexOf("null")!=0&&new String(rsDealerSearch("phone")).length!=0?"<br/><strong>Ph:</strong> " + rsDealerSearch("phone"):"" %> <%= new String(rsDealerSearch("fax")).indexOf("null")!=0&&new String(rsDealerSearch("fax")).length!=0?"<br/><strong>Fax:</strong> " + rsDealerSearch("fax"):"" %> <%= new String(rsDealerSearch("email")).indexOf("null")!=0&&new String(rsDealerSearch("email")).length!=0?"<br/><a href=\"mailto:" + rsDealerSearch("email") + "\">" + rsDealerSearch("email") + "</a>":"" %> <%= new String(rsDealerSearch("url")).indexOf("null")!=0&&new String(rsDealerSearch("url")).length!=0?"<br/><a href=\"http://" + rsDealerSearch("url") + "\" target=\"_blank\">" + rsDealerSearch("url") + "</a>":"" %> </p>
</div>
<%	
		count++
		if (count == 2) {
			%>
<div class="clearing"></div>
<%
			count = 0;
		}		
		rsDealerSearch.MoveNext();
	}
}




%>
<!--#include file="global/pageFooter.asp" -->
