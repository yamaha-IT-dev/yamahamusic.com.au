<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Administration</title>

	<meta name="description" content="" />
	<meta name="keywords" content="" />

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<style type="text/css" media="screen, print">@import "admin.css";</style>
	<style type="text/css" media="screen, print">@import "admin.nav.css";</style>

</head>
<body>
<div id="header"></div>
<div id="navigation">
	<ul id="nav">
<%
	if (Session("yma_userid") > 0) {

		var Usr = new User();
			Usr._loadUser(Session("yma_userid"));

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 2 || Usr._getUserUsertypeID() == 4 || Usr._getUserUsertypeID() == 5) {
%>
			<li style="border-left:1px #FFFFFF solid;margin-left:20px;"><a href="ctrlResource.asp">Dealer Resources</a>
			<ul>
				<li><a href="ctrlResource.asp">List all resources</a></li>
				<li><a href="ctrlResource.asp?action=new_resource">Add new resource</a></li>
			</ul></li>
			<li><a href="ctrlCategory.asp">Product Categories</a>
			<ul>
				<li><a href="ctrlCategory.asp">List all categories</a></li>
				<li><a href="ctrlCategory.asp?action=new_category">Add new category</a></li>
			</ul></li>
			<li><a href="ctrlType.asp">Resource Types</a>
			<ul>
				<li><a href="ctrlType.asp">List all resource type</a></li>
				<li><a href="ctrlType.asp?action=new_type">Add new resource type</a></li>
			</ul></li>
<%
		}

%>
			<li style="border-left:1px #FFFFFF solid;margin-left:20px;"><a href="default.asp?action=user_logout">Log Out</a></li>
<%
	} else {
%>
		<li style="border-left:1px #FFFFFF solid;margin-left:20px;"><a href="default.asp">User Login</a></li>
<%
	}
%>
	</ul>
	<div style="clear:both;"></div>
</div>

<div id="outer_wrapper">
	<div id="wrapper">
		<div id="container">
			<div id="content">
				<div id="main">