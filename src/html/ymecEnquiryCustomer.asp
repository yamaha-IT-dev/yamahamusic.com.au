<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Login or register as a customer</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.enquiry.css";</style>
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

<div id="enquiry">
	<h3>Enquiry Steps</h3>
	<ol>
		<li><p>Enquiry Start</p></li>
		<li><p>Learn about the courses</p></li>
		<li><p>Participate in a free lesson</p></li>
		<li><p><strong>Login or register your details</strong></p></li>
		<li><p>Register your students</p></li>
		<li><p>Tell us your preferred contact</p></li>
		<li><p>Finish</strong></p></li>
	</ol>

</div>


<h1>Register Your Details</h1>

<%

if (!Session("customerid")) {

	if (action == ENQUIRY_CUSTOMER_LOGIN || action == ENQUIRY_CUSTOMER) {
		%><h2>Customer Login</h2><%
		if (message.length) {
			%><p class="alert"><%= message %><%
		}
		%>
		<p>If you have already signed up to the yamahamusic.com.au website you can log in and we'll match your details with your enquiry</p>
		<form name="enquiryCustomerLogin" action="<%= CONTROLLER %>" method="get">
			<input type="hidden" name="action" value="<%= ENQUIRY_CUSTOMER_LOGIN %>" />

			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>email address</td>
				<td><input type="text" name="email" value="<%= C._getCustomerEmail() %>" /></td>
			</tr>
			<tr>
				<td>password</td>
				<td><input type="password" name="password" value="<%= C._getCustomerPassword() %>" /></td>
			</tr>
			</table>

			<p><input type="submit" name="submit" value="log in" class="button" /></p>

		</form>
		<%
	}
	
	%>
	<%
	if (action == ENQUIRY_CUSTOMER_SAVE || action == ENQUIRY_CUSTOMER) {
		%><h2>New Customer Sign Up</h2><%
		if (message.length) {
			%><p class="alert"><%= message %><%
		}
		%>
	
	<form name="newCustomerForm" action="<%= CONTROLLER %>" method="post">
		<input type="hidden" name="action" value="<%= ENQUIRY_CUSTOMER_SAVE %>" />
		<input type="hidden" name="customerid" value="<%= C._getCustomerID() %>" />
		<input type="hidden" name="checkemail" value="<%= C._getCustomerEmail() %>" />

		<table border="0" cellpadding="0" cellspacing="0" style="width:370px;">
		<tr>
			<td style="width:110px;" class="required"><strong>Title, Firstname</strong></td>
			<td class="required"><select name="title" style="width:50px;">
				<option value="">...</option><%
				for (var i=1; i < GBL_TITLES.length; i++) {
					%><option value="<%= GBL_TITLES[i] %>"<%= C._getCustomerTitle().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option><%
				}
			%></select>&nbsp;
			<input type="text" name="firstname" value="<%= C._getCustomerFirstname() %>" style="width:143px;" /></td>
		</tr>
		<tr>
			<td class="required"><strong>Surname</strong></td>
			<td class="required"><input type="text" name="lastname" value="<%= C._getCustomerLastname() %>" style="width:200px;" /></td>
		</tr>
		<tr>
			<td><strong>Address</strong></td>
			<td><textarea name="address" rows="3" style="width:200px;"><%= C._getCustomerAddress() %></textarea></td>
		</tr>
		<tr>
			<td><strong>City / Suburb / Town</strong></td>
			<td><input type="text" name="city" value="<%= C._getCustomerCity() %>" style="width:200px;" /></td>
		</tr>
		<tr>
			<td><strong>State</strong></td>
			<td><input type="text" name="state" value="<%= C._getCustomerState() %>" style="width:200px;" /></td>
		</tr>
		<tr>
			<td><strong>Country</strong></td>
			<td><input type="text" name="country" value="<%= C._getCustomerCountry() %>" style="width:200px;" /></td>
		</tr>
		<tr>
			<td class="required"><strong>Postcode</strong></td>
			<td class="required"><input type="text" name="postcode" value="<%= C._getCustomerPostcode() %>" style="width:50px;" /></td>
		</tr>
		<tr>
			<td><strong>Contact Phone</strong></td>
			<td><input type="text" name="phone" value="<%= C._getCustomerPhone() %>" style="width:100px;" /></td>
		</tr>
		<tr>
			<td><strong>Date of Birth</strong></td>
			<td><%

				var dRef = C._getCustomerDateofbirth();
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
				for (var i=2005; i >= 1920; i--) {
					%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
				}
			%></select>
			</td>
		</tr>
		<tr>
			<td class="required"><strong>Email Address</strong></td>
			<td class="required"><input type="text" name="email" value="<%= C._getCustomerEmail() %>" style="width:200px;" /></td>
		</tr>
		<tr>
			<td class="required"><strong>Password</strong></td>
			<td class="required"><input type="password" name="password" value="<%= C._getCustomerPassword() %>" style="width:200px;" /></td>
		</tr>
		<tr>
			<td class="required" colspan="2">
				<h2>Email Updates</h2>
				From time to time Yamaha Music Australia might send out an email updating customers about Yamaha Music Australia news &amp events and the Yamaha product range. Do you wish to receive these notices?
			</td>
		</tr>
		<tr>
			<td class="required" colspan="2"><input type="checkbox" name="optinnews" value="1" <%= C._getCustomerOptinnews()==1?" checked=\"checked\"":"" %> /> Check this to be sent News and Event information about Yamaha Music Australia.</td>
		</tr>
		<tr>
			<td class="required" colspan="2"><input type="checkbox" name="optinproduct" value="1" <%= C._getCustomerOptinproduct()==1?" checked=\"checked\"":"" %> /> Check this to be notified of new Yamaha Product releases.</td>
		</tr>
		</table>

		<p><input type="submit" name="submit" value="save customer" class="button" /></p>
	
	</form>
<% 
	}

%>
	
	
	
	
<%

} else {

	if (action == ENQUIRY_CUSTOMER_LOGIN) {
		%>
			<h3>Thanks <%= C._getCustomerFirstname() %></h3>
		<%
	} else {
		%>
			<h3>Great</h3>
			<p>Hi <%= C._getCustomerFirstname() %>, we can see that you've already logged in, we can match this enquiry with your customer details.</p>
		<%
	}
	%>
	<p>Would you now like to give us a few details about the prospective students who will be attending YMEC?</p>

	<p><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_STUDENT %>">Yeah Sure</a></p>

	<%
	

}


%>


<p><a href="<%= CONTROLLER %>?action=<%= ENQUIRY_HOME %>">Cancel Enquiry </a></p>





<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>