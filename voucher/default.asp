<!doctype html>
<html>
<head>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<meta charset="utf-8">
<title>Yamaha Tuning Voucher</title>
</head>
<body>
<!--#include file="../include/connection.asp " -->
<!--#include file="class/clsDateFormat.asp" -->
<!--#include file="class/clsVoucher.asp" -->
<%
sub main
	Dim intID
	intID = Server.URLEncode(Trim(Request("id")))
	
	Dim strSerialNo
	'strSerialNo = Server.URLEncode(Trim(Request("serial")))
	strSerialNo = Trim(Request("serial"))
	
	call getVoucherDetails(intID, strSerialNo)
end sub

call main
%>
<% if Session("voucher_not_found") <> "TRUE" then %>
<p><font color="red"><%= strMessageText %></font></p>
<img src="images/banner.jpg" />
<table border="0" cellpadding="5" cellspacing="0" class="main_form_table">
  <tr>
    <td colspan="3">
    ID: <%= Session("voucherCustomerID") %>
    <h2 align="center"><img src="images/logo_yamaha.jpg" /> Tuning Voucher</h2>
    <h3 align="center"><em>Pay Yamaha Accredited Piano Technician</em></h3></td>
  </tr>
  <tr>
    <td rowspan="7" valign="top" align="center"><img src="images/logo_ppc.jpg" /></td>
    <td>&nbsp;</td>
    <td style="font-size:x-large">$160.00 inc GST</td>
  </tr>
  <tr>
    <td><strong>Piano:</strong></td>
    <td><%= Session("voucherPiano") %> (<%= Session("voucherSerialNo") %>)</td>
  </tr>
  <tr>
    <td><strong>Dealer:</strong></td>
    <td><%= Session("voucherDealerName") %></td>
  </tr>  
  <tr>
    <td><strong>Purchased:</strong></td>
    <td><%= displayDateFormatted(Session("voucherPurchaseDate")) %></td>
  </tr>
  <tr>
    <td><strong>Valid until:</strong></td>
    <td><u><%= displayDateFormatted(Session("voucherExpiryDate")) %></u></td>
  </tr>
  <tr>
    <td><strong>Name:</strong></td>
    <td><strong><%= Session("voucherFirstname") & " " & Session("voucherLastname") %></strong></td>
  </tr>
  <tr>
    <td valign="top"><strong>Address:</strong></td>
    <td><%= Session("voucherAddress") & "<br>" & Session("voucherCity") & " " & Session("voucherState") & " " & Session("voucherPostcode") %></td>
  </tr>    
  <tr>
    <td colspan="3" valign="top"><u><strong>NON-NEGOTIABLE</strong></u></td>
  </tr>
</table>
<br>
<div class="terms">
<p><strong>Terms &amp; Conditions</strong></p>
<ul>
  <li>Valid only for labour costs of tuning for the piano listed on this voucher.</li>
  <li>Voucher is valued at the amount fixed on the voucher face, payable only to the Yamaha Accredited Piano Technician who undertakes the tuning, and does not include travel time or other expenses. The voucher can not be exchanged for cash or other services.</li>
  <li>The original voucher must be submitted with the tuning invoice.</li>
  <li>Vouchers used after the listed expiration date will not be honoured.</li>
  <li>Participation in this program is deemed acceptance of these Terms &amp; Conditions.</li>
  <li><a href="http://www.yamahamusic.com.au/premium/terms-conditions.html" target="_blank">Full Terms &amp; Conditions</a></li>
</ul>
</div>
<% else %>
<h2>Oops something went wrong here.. could you please go back to your email &amp; click on the link again?</h2>
<% end if %>
</body>
</html>