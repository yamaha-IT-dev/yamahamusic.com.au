<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>YMA Admin</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<script type="text/javascript" src="/utility.js"></script>
<style type="text/css" media="screen, print">
@import "admin.css";
</style>
<style type="text/css" media="screen, print">
@import "admin.nav.css";
</style>
</head>
<body>
<div id="header"></div>
<div id="navigation">
  <ul id="nav">
    <li style="border-left:1px #FFFFFF solid;margin-left:20px;"><a href="default.asp">HOME</a></li>
    <% 
	if (Session("yma_userid") > 0) {
	
		var Usr = new User();
			Usr._loadUser(Session("yma_userid"));

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 2 || Usr._getUserUsertypeID() == 4 || Usr._getUserUsertypeID() == 5) {
%>
    <li><a href="ctrlResource.asp">RESOURCES</a>
      <ul>
        <li><a href="ctrlResource.asp">List recent resources</a></li>
        <li><a href="ctrlResource.asp?action=list_resource">List all resources</a></li>
        <li><a href="ctrlResource.asp?action=new_resource">Add new resource</a></li>
        <li><a href="ctrlCategory.asp">List all categories</a></li>
        <li><a href="ctrlCategory.asp?action=new_category">Add new category</a></li>
      </ul>
    </li>
    <% 
		}

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 3) {
%>
    <li><a href="ctrlDealer.asp">DEALERS</a>
      <ul>
        <li><a href="ctrlDealer.asp">List all dealers</a></li>
        <li><a href="ctrlDealer.asp?action=new_dealer">Add new dealer</a></li>
      </ul>
    </li>
    <% 
		}

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 4) {
%>
    <li><a href="ctrlServiceCentre.asp">SERVICE</a>
      <ul>
        <li><a href="ctrlServiceCentre.asp">List all service centres</a></li>
        <li><a href="ctrlServiceCentre.asp?action=new_service">Add new service centre</a></li>
        <li><a href="ctrlWarrantyClaim_light.asp">Warranty Claims (OPEN)</a></li>
        <li><a href="ctrlWarrantyClaim_overdue.asp">Warranty Claims (Repair >20days)</a></li>
        <li><a href="ctrlWarrantyClaim_2013.asp">Warranty Claims (2013)</a></li>
        <li><a href="ctrlWarrantyClaim_2012.asp">Warranty Claims (2012)</a></li>
        <li><a href="ctrlWarrantyClaim_2011.asp">Warranty Claims (2011)</a></li>
        <li><a href="ctrlWarrantyClaim.asp">Warranty Claims (2010)</a></li>
        <li><a href="ctrlWarrantyClaim.asp?action=export_filter">Export warranty claims</a></li>
      </ul>
    </li>
    <% 
		}

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 4) {
%>
    <!--<li><a href="ctrlCustomer.asp">CUSTOMERS</a>
      <ul>
        <li><a href="ctrlCustomer.asp">List all customers</a></li>
        <li><a href="ctrlCustomer.asp?action=new_customer">Add new customer</a></li>
        <li><a href="ctrlCustomer.asp?action=customer_report">Customer reports</a></li>
      </ul>
    </li>-->
    <% 
		}
		
		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 4) {
%>
    <li><a href="ctrlUser.asp">USERS</a>
      <ul>
        <li><a href="ctrlUser.asp">List all users</a></li>
        <li><a href="ctrlUser.asp?action=list_dealers">List Yamaha Connect dealers</a></li>
        <li><a href="ctrlUser.asp?action=create_user">Add new user</a></li>
      </ul>
    </li>
    <% 
		}

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 5) {
%>
    <li><a href="ctrlTeacher.asp">YMEC</a>
      <ul>
        <li><a href="ctrlTeacher.asp">View all teachers</a></li>
        <li><a href="ctrlTimetable.asp">Manage Timetable</a></li>
      </ul>
    </li>
    <%
		}

		if (Usr._getUserUsertypeID() == 1 || Usr._getUserUsertypeID() == 7) {
%>
    <!--<li><a href="ctrlProduct.asp">Shop</a>
      <ul>
        <li><a href="ctrlProduct.asp">Manage products</a></li>
        <li><a href="ctrlPurchase.asp">Manage orders</a></li>
        <li><a href="ctrlReturn.asp">Manage returns</a></li>
      </ul>
    </li>-->
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
