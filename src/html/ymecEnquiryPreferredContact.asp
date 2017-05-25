 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - YMEC - Your preferred contact</title>

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
		<li><p>Login or register your details</p></li>
		<li><p>Register your students</p></li>
		<li><p><strong>Tell us your preferred contact</strong></p></li>
		<li><p>Finish</p></li>
	</ol>

</div>

<h1>Preferred Contact</h1>

<p>Please let us know your preferred option for us to contact you:

<form action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= ENQUIRY_PREFERRED_SAVE %>">

	<p>
		<input type="radio" name="contact" value="phone" />&nbsp;Phone<br/>
		<input type="radio" name="contact" value="mail" />&nbsp;Post<br/>
		<input type="radio" name="contact" value="email" />&nbsp;Email<br/>
	</p>
	
	<p>Alternatively you can contact us<br/>
	Freecall <strong>1800 805 413</strong><br/>
	Email <strong><a href="mailto:ymfaustralia@gmx.yamaha.com">ymfaustralia@gmx.yamaha.com</a></strong></p>
	
	<p><input type="submit" name="submit" value="complete the enquiry" class="button"/></p>

</form>

<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>