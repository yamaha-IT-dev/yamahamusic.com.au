<%
dim strSection
strSection = "home"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsUser.asp " -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="../js/html5shiv.js"></script>
  <script src="../js/respond.js"></script>
<![endif]-->
<title>Yamaha Connect Home</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<link rel="stylesheet" href="../../css/pure-min.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../../js/rollover.js"></script>
</head>
<%
sub main
	call validateLogin
	call getUser(Session("yma_userid"))
end sub

call main
%>
<body>
<!--#include file="../include/header_new.asp " -->
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="login_column">
    <h1>Hi <%= session("user_firstname") %>, Welcome to Yamaha Connect</h1>    
    <p align="right"><strong><%= session("user_firstname") & " " & session("user_lastname") %></strong><br>
    <%= session("user_address") %><br>
    <%= session("user_city") & " " & session("user_state") & " " & session("user_postcode") %><br>
    (<a href="../profile/">Edit here</a>)</p>
     <div class="pure-g">
        <div class="pure-u-1-5"><a href="../marketing/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('marketing','','../icons/icon_marketing_roll.jpg',0)"><img src="../icons/icon_marketing.jpg" border="0" id="marketing" name="marketing" /></a></div>
        <div class="pure-u-1-5"><a href="../booking/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('booking','','../icons/icon_booking_roll.jpg',0)"><img src="../icons/icon_booking.jpg" border="0" id="booking" name="booking" /></a></div>
        <div class="pure-u-1-5"><a href="../stock/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('stock','','../icons/icon_stock_roll.jpg',0)"><img src="../icons/icon_stock.jpg" border="0" id="stock" name="stock" /></a></div>
        <div class="pure-u-1-5"><a href="../order/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('order','','../icons/icon_order_roll.jpg',0)"><img src="../icons/icon_order.jpg" border="0" id="order" name="order" /></a></div>
        <div class="pure-u-1-5"><a href="../order/backorder.asp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('backorder','','../icons/icon_back-orders_roll.jpg',0)"><img src="../icons/icon_back-orders.jpg" border="0" id="backorder" name="backorder" /></a></div>
     </div>
     <div class="pure-g">
        <div class="pure-u-1-5"><a href="../artwork/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('artwork','','../icons/icon_artwork_roll.jpg',0)"><img src="../icons/icon_artwork.jpg" border="0" id="artwork" name="artwork" /></a></div>
        <div class="pure-u-1-5"><a href="../return/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('return','','../icons/icon_return_roll.jpg',0)"><img src="../icons/icon_return.jpg" border="0" id="return" name="return" /></a></div>
        <div class="pure-u-1-5"><a href="../product/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('product','','../icons/icon_product_roll.jpg',0)"><img src="../icons/icon_product.jpg" border="0" id="product" name="product" /></a></div>
        <div class="pure-u-1-5"><a href="../contact/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('contact','','../icons/icon_contact_roll.jpg',0)"><img src="../icons/icon_contact.jpg" border="0" id="contact" name="contact" /></a></div>
        <div class="pure-u-1-5"><a href="../profile/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('profile','','../icons/icon_profile_roll.jpg',0)"><img src="../icons/icon_profile.jpg" border="0" id="profile" name="profile" /></a></div>
     </div></td>
  </tr>    
</table>
</body>
</html>