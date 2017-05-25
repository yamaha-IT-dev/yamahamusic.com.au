<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Music Australia - Service Centre Home</title>
<meta name="Description" content="" />
<meta name="Keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
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
#main {
	width : auto;
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
        <h1>Yamaha Service Centre Portal</h1>
        <%
	if (Session("yma_userid") > 0) {
%>
        <!--<h2>Service Centre Knowledge Base</h2>-->
        <h3>Welcome back <%= C._getCustomerFirstname() %>.</h3>
        <div class="column">
          <h2>Warranty Claims and RCTI</h2>
          <h3>Entering your claim as an RCTI (Recipient Created Tax Invoice) will ensure prompt payment.</h3>
          <p>The tax invoice option can also be selected, although this will result in a lengthy delay in payment; due to payment not taking place until the hard copy of the invoice is sent by you to Yamaha Music Australia.</p>
          <p>Payment may take 3-4 weeks to occur for tax invoices, selecting the RCTI payment will result in payments being made weekly.</p>
        </div>
        <div class="column" style="width:550px;background-color:#DCF9B4;padding:2px 5px 0 5px;margin-bottom:10px;border:1px #0C0 solid;">
          <h1>Online Warranty Claims</h1>
          <h3>There is now a convenient way for you to submit your warranty claims to Yamaha Music Australia.</h3>
          <p>You can submit your warranties online in bulk using our <a href="warrantyclaim.asp?action=upload_claims">upload service</a>, or you can <a href="warrantyclaim.asp?action=add_claim">submit a single claim</a> at a time. Make sure you read the <a href="resources/WarrantyClaims-HowTo.pdf" target="_blank">How To document</a> before preparing your upload. <a href="warrantyclaim.asp">All your claims</a> can be easily reviewed and edited online.</p>
          <p>For enquiries and support regarding online warranty claims, please call <strong>1300 739 390</strong>.</p>
          <p>Read our <strong><a href="resources/WarrantyClaims-HowTo.pdf" target="_blank">warranty claim How To document</a> (1.9 MB)</strong></p>
        </div>
        <div class="clearing"></div>
        <div class="column" style="width:800px;background-color:#EFEFEF;padding:2px 5px 0 5px;margin-bottom:10px;border:1px #666 solid;">
          <h1>Technical Support</h1>          
          <p>Yamaha Technical Support for MPD is located at Southbank as part of our head office building at the address below:</p>
          <p><strong>Yamaha Music Australia Pty Ltd<br />
            Level 1/ 99 Queensbridge St<br />
            Southbank VIC 3006</strong></p>
          <p>Yamaha Technical Support for AVIT is located at Excel Technology Hallam:<br />
            Toll Free: <strong>1300 739 390</strong></p>
          <p>As Yamaha regularly distributes service bulletins/service manuals on the YSISS internet site, please refer to these first, prior to contacting our technical staff. </p>
          <p>If you have difficulties to access YSSIS, please email <a href="mailto:Jeff_John@gmx.yamaha.com">Jeff_John@gmx.yamaha.com</a> with:</p>
          <ul>
            <li>Contact Name</li>
            <li>The Name of the Service Centre</li>
            <li>The Address of the Service Centre</li>
            <li>Telephone No of Service Centre</li>
            <li>Email Address</li>
          </ul>
          <p>You will be provided with a Username and Password</p>
<p><strong>Please do not automatically send repairs directly to us as they will not be accepted and will be returned to you at your cost.</strong></p>
          <!--<p>If we do agree to accept a repair upon our discretion, you will be given a return authority number. This number must be written in an obvious place on the address label when the equipment is returned.<br />
            <strong>Do not return equipment without obtaining this number.</strong></p>
          <p>Equipment that is returned must be carefully packed. (Please avoid loose packaging as it tends to settle &amp; offers little protection) <strong>A note must be enclosed explaining the reason for return, the fault and purchase details if warranty is being claimed.</strong></p>
          <p>Freight costs are not covered by our warranty; however we may agree to cover freight in special circumstances. In this situation our carrier must be used. Please contact us for our carrier details. <br />
            Accounts from other carriers can not be accepted.</p>
          <p>When accepting a warranty repair, we expect that you will check the customers purchase receipt to ensure that the repair is within the warranty period for that product.<br />
            Please remember: the warranty is to protect the customer against faulty material &amp; or workmanship and it <strong>does not cover routine cleaning and maintenance.</strong></p>
          <p>If you do have a difficult repair, please contact the relevant Technical Support Co-ordinator to discuss the problem. We will offer advice and try to help locate the problem, or if necessary, will make arrangements to assist in some other way.</p>
          <p>If you have a major problem or delay in completing a repair, please keep the customer informed about progress or delays. If the customer becomes dissatisfied or aggravated about the delay, discuss the problem with our technical support staff.</p>
          <p>It is in everyone&rsquo;s best interest that problems are resolved quickly before they waste time and create unnecessary conflict.</p>-->
        </div>
        <div class="column" style="width:800px;padding:2px 5px 0 5px;margin-bottom:10px;">
          <h1>Approved Yamaha Authorised Service Centre Support Contact List</h1>
          <table cellpadding="3" cellspacing="0" border="1">
            <tr>
              <td><strong>Name</strong></td>
              <td><strong>Job Title</strong></td>
              <td><strong>Free Call No.</strong></td>
              <td><strong>Direct Phone No.</strong></td>
              <td><strong>Email</strong></td>
            </tr>
            <tr>
              <td>Jeff John</td>
              <td>Logistics &amp; Service Manager</td>
              <td>&nbsp;</td>
              <td>(03) 9693 5255</td>
              <td><a href="mailto:jeff_john@gmx.yamaha.com">jeff_john@gmx.yamaha.com</a></td>
            </tr>
            <tr>
              <td colspan="5"><strong>Spare Parts:</strong></td>
            </tr>
            
            <tr>
              <td>Brian Parker</td>
              <td>Spare Part Sales</td>
              <td>1300 739 390</td>
              <td>(03) 9693 5129</td>
              <td><a href="mailto:brian_parker@gmx.yamaha.com">brian_parker@gmx.yamaha.com</a></td>
            </tr>
            <tr>
              <td>Matthew Madden</td>
              <td>Service & Spare Parts Coordinator</td>
              <td>-</td>
              <td>(03) 9693 5167</td>
              <td><a href="mailto:matthew_madden@gmx.yamaha.com">matthew_madden@gmx.yamaha.com</a></td>
            </tr>
            <tr>
              <td colspan="5"><strong>Audio Visual:</strong></td>
            </tr>
            <tr>
              <td>Gary Brown</td>
              <td>Technical Support AV Products Division</td>
              <td>1800 806 266</td>
              <td>(03) 9693 5198</td>
              <td><a href="mailto:service_excel@gmx.yamaha.com">service_excel@gmx.yamaha.com</a></td>
            </tr>
            <tr>
              <td colspan="5"><strong>Music Products:</strong></td>
            </tr>
            <tr>
              <td>Drew Parsons</td>
              <td>Customer Support Specialist Music &amp; Audio Tech</td>
              <td>1300 739 390</td>
              <td>(03) 9693 5148</td>
              <td><a href="mailto:drew_parsons@gmx.yamaha.com">drew_parsons@gmx.yamaha.com</a></td>
            </tr>
            <tr>
              <td>Joseph Pantalleresco</td>
              <td>Technical Support Music Products Division</td>
              <td>1800 806 266</td>
              <td>(03) 9693 5107</td>
              <td><a href="mailto:joseph_pantalleresco@gmx.yamaha.com">joseph_pantalleresco@gmx.yamaha.com</a></td>
            </tr>
          </table>
        </div>
        <div class="clearing"></div>
        <%
	} else {

%>        
        <form action="<%= CONTROLLER %>" method="post" id="loginForm">
          <input type="hidden" name="action" value="service_login" />
          <%
			if (message.length > 0) {
				%>
          <p class="alert"><%= message %></p>
          <%
			}
		%>
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td>Username:</td>
              <td><input type="text" name="username" value="<%= U._getUserUsername() %>" size="35" maxlength="30" /></td>
            </tr>
            <tr>
              <td>Password:</td>
              <td><input type="password" name="password" value="<%= U._getUserPassword() %>" size="35" maxlength="30" /></td>
            </tr>
          </table>
          <p>
            <input type="submit" name="submit" value="log in" class="button" />
          </p>
        </form>
        <a href="forgot.asp">Forgot your username / password?</a>
        <p>Not registered? Please <a href="mailto:Jeff_John@gmx.yamaha.com">contact our service manager</a> and detail your request.</p>
<%
	}
%>
        <!--#include file="global/globalMainContentEnd.asp" -->
  <!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>