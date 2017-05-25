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

	<style type="text/css" media="screen">
	
		@import "yamahamusic.warranty.css";
		
		#main
		{
			width : 650px;
		}
		
		table th
		{
			white-space:nowrap;
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



<h1>Warranty Claims</h1>
<h3>Yamaha Service Centres</h3>

<div class="column">
	<h2>Add a new claim</h2>
	<p>To make an online service warranty claim you will need to ensure that you have the following;</p>
	<a href="<%= CONTROLLER %>?action=<%= ADD_CLAIM %>" class="button">submit a new claim</a>
</div>

<div class="column" style="width:250px;">
	<h2>Upload multiple claims</h2>
	<p>Your accounting program must output your claims in the correct format. <a href="resources/WarrantyClaims-HowTo.pdf">Download our how-to</a> to learn more about this.</p>
	<a href="<%= CONTROLLER %>?action=<%= UPLOAD_CLAIMS %>" class="button">upload multiple claims</a>
</div>

<div class="clearing"></div>

<p><strong><a href="resources/WarrantyClaims-HowTo.pdf" target="_blank" class="pdf">Warranty Claim How-To</a></strong></p>


<h2>Your recent claims</h2>
<%

	if (rsClaims && !rsClaims.EOF) {

		var intRecordCount = rsClaims.RecordCount;
		var intStart = !isNaN(parseInt(Request("start")))?parseInt(Request("start")):0;
		var intPageSize = 20;
		var intCount = 0
		var intPageCount = Math.ceil(intRecordCount/intPageSize);
/*
Response.Write("intRecordCount = " + intRecordCount + "<br/>");
Response.Write("intStart = " + intStart + "<br/>");
Response.Write("intPageSize = " + intPageSize + "<br/>");
Response.Write("intCount = " + intCount + "<br/>");
Response.Write("intPageCount = " + intPageCount + "<br/>");
*/
		%><p>Go to page : <%
		for (var i=0; i<intPageCount; i++) {
			var strBold = Math.floor(intStart/intPageSize)==i?" style=\"font-weight:bold;\"":"";
			%><a href="<%= CONTROLLER %>?start=<%= i*intPageSize %>"<%= strBold %>><%= i+1 %></a>&nbsp;&nbsp;<%
		}
		if (Math.floor(intStart/intPageSize)+1 != intPageCount) {
			%><a href="<%= CONTROLLER %>?start=<%= intStart+intPageSize %>">[next]</a><%
		}
		%></p><%


		rsClaims.Move(intStart);

		%><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<th>&nbsp;</th>
			<th>Claim N<sup style="text-transform:lowercase;">o</sup></th>
			<th>Invoice N<sup style="text-transform:lowercase;">o</sup></th>
			<th>RCTI N<sup style="text-transform:lowercase;">o</sup></th>
			<th>Model Number</th>
			<th>Serial Number</th>
			<th>Status</th>
			<th>Received</th>
            <th>Completed</th>
            <th>Time to repair</th>
			<th>Claimed</th>
			<th>Modified</th>
		</tr>
		<%
		while (!rsClaims.EOF) {
			%>
			<tr>
				<td align="center"><%
				if (new String(rsClaims("status")).indexOf("OPEN") == 0) {
					%><a href="<%= CONTROLLER %>?action=<%= EDIT_CLAIM %>&claimid=<%= rsClaims("id") %>" class="button">EDIT</a><%
					%><a href="<%= CONTROLLER %>?action=<%= VIEW_CLAIM %>&claimid=<%= rsClaims("id") %>" class="button">VIEW</a><%
				} else {
					%><a href="<%= CONTROLLER %>?action=<%= VIEW_CLAIM %>&claimid=<%= rsClaims("id") %>" class="button">VIEW</a><%
				}
				%></td>
				<td><%= rsClaims("claimnumber") %>&nbsp;</td>
				<td><%= new String(rsClaims("invoicenumber"))!="null"?rsClaims("invoicenumber"):"" %></td>
				<td><%= new String(rsClaims("rctinumber"))!="null"?rsClaims("rctinumber"):"" %></td>
				<td><%= rsClaims("modelnumber") %></td>
				<td><%= rsClaims("serialnumber") %></td>
				<td><%= rsClaims("status") %></td>
				<td><%= new Date(Date.parse(rsClaims("datereceived"))).formatDate("d/m/Y") %></td>
                <td><%= new Date(Date.parse(rsClaims("datecompleted"))).formatDate("d/m/Y") %></td>
                <td><% if (rsClaims("repairdays") >= 20) {
	  			Response.Write("<font color=red>");
	  		}	 	  
	  %><%= rsClaims("repairdays") %> days</td>
				<td><%= new Date(Date.parse(rsClaims("datecreated"))).formatDate("d/m/Y") %></td>
				<td><%
					if (new String(rsClaims("datemodified")) != "null") {
						Response.Write(new Date(Date.parse(rsClaims("datemodified"))).formatDate("d/m/Y"));
					} else {
						%>&nbsp;<%
					}
				%></td>
			</tr>
			<%
			rsClaims.moveNext();
			intCount++;
			if (intCount == intPageSize) {
				break;
			}
		}
		%></table><%
	} else {
		%><p>You have not yet made any online claims</p><%
	}

%>



<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>