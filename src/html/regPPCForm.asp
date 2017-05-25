<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Music Australia - Yamaha Premium Piano Care Registration</title>
<meta name="Title" content="Yamaha Music Australia - Music Education" />
<meta name="Description" content="Yamaha Music Education Centres provide music lessons and online enrolment for children right accross Victoria, New South Wales and South Australia. Our Music Wonderland, Junior Music and Group Music Classes are perfect for children from 3 - 12 years of age." />
<meta name="Keywords" content="music lessons, music education, keyboard lessons, piano lessons, solfege singing, kinder music classes, music for children, yamaha music education centre, yamaha music lessons, young musicians, junior music, music courses, music wonderland, free information sessions, yamaha music school, class timetable, enrolment, Balwyn North, Berwick, Blackburn, Brighton, Canterbury, Eltham North, Endeavour Hills, Glen Waverley, Malvern, Newport, Strathmore, Thornbury, Adelaide, Baulkham Hills, Chatswood, Dulwich Hill, Jannali, Wentworthville, Yamaha, Music, Education, Wonderland, Family, Music Days, Dreams, Musicians, Keyboards, Teachers, Teach, Learn, Passionate, Kindergarten, Prep, Children, Novice, Learner, Audio, Visual, HiFi Components, Musical, Instruments, Pianos, Grand Pianos, Upright Pianos, Disclavier, Guitars, Pacifica, Drums, Paiste, Cymbals, Brass, Woodwind, Clavinova, Electronic, Keyboards, Tyros, Synth, Synthesizers, Pro Audio, PA, Mixers, Desks, Mixing Desks, Power Amps, Rock, Roll, Swing, Jazz, Blues, Hip Hop, Latin, Country, Western, Oz Music, Trumpets, Trombones, Flutes, Saxaphones, Music Connect, YMEC, Music Education, YAYPC, Youth Piano Competition" />
<meta name="Date" content="01/07/2006" />
<meta name="Language" content="English" />
<meta name="Publisher" content="Yamaha Music Australia Pty Ltd" />
<meta name="Rights" content="Copyright 2006, Yamaha Music Australia." />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
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
@import "/premiumcare/yamahamusic.premiumpianocare.css";
</style>
<script type="text/javascript" src="/prototype.js"></script>
<script type="text/javascript" src="/utility.js"></script>
</head>
<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
      <div id="left" style="padding-top:20px; padding-left:20px;">
        <img src="/premiumcare/images/logo_ppc-black.jpg" border="0" />
      </div>
      <!--#include file="global/globalMainContentStart.asp" -->
        <div id="sashlogo"></div>
        
        <div id="ppc-content">
          <h1>Premium Piano Care Program</h1>
          <%
  	if (message.length > 0) {
  		%>
          <p class="alert"><%= message %></p>
          <%
  	}
  %>
          <form name="enquiryForm" action="<%= CONTROLLER %>" method="post">
            <input type="hidden" name="action" value="<%= ENQUIRY_SEND %>">
            <p><strong>Given name:</strong> <br/>
              <input type="text" name="first_name" value="<%= E._getFirstName() %>" />
            </p>
            <p><strong>Surname:</strong> <br/>
              <input type="text" name="last_name" value="<%= E._getLastName() %>" />
            </p>
            <fieldset id="address_block">
              <p><strong>Address</strong> <br/>
                <textarea name="address" rows="2" style="width:300px;"><%= E._getAddress() %></textarea>
              </p>
              <p><strong>Suburb</strong> <br/>
                <input type="text" name="suburb" value="<%= E._getSuburb() %>" />
              </p>
              <p><strong>State</strong><br/>
                <select name="state" style="width:200px;" >
                  <option value="">choose state...</option>
                  <%
  			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
  				%>
                  <option value="<%= GBL_STATES_SHORT[i] %>"<%= E._getState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option>
                  <%
  			}
  		%>
                </select>
              </p>
              <p><strong>Postcode</strong> <br/>
                <input type="text" name="postcode" value="<%= E._getPostcode() %>" style="width:80px;" />
              </p>
            </fieldset>
            <p><strong>Telephone Number</strong> <br/>
              <input type="text" name="phone" value="<%= E._getPhone() %>" />
            </p>
            <p><strong>Email</strong> <br/>
              <input type="text" name="email" value="<%= E._getEmail() %>" />
            </p>
            <p><strong>Dealer:</strong> <br/>
              <input type="text" name="dealer" value="<%= E._getDealer() %>" />
            </p>
            <p>
              <label for"purchase_date"><strong>Purchase Date</strong></label>
              <%

  		var dRef = new String(E._getPurchaseDate());
  		if (dRef.length != 0) {
  			dRef = new Date(Date.parse(dRef));
  		} else {
  			dRef = new Date();
  		}
  		var refMonth = dRef.getMonth();
  		var refYear = dRef.getFullYear();
  		var currDate = new Date();
  		var currYear = currDate.getFullYear();
  	%>
              <select name="fMonth">
                <option value="0">month...</option>
                <%
  		for (var i=0; i < 12; i++) {
  			%>
                <option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option>
                <%
  		}
  	%>
              </select>
              &nbsp;
              <select name="fYear">
                <option value="0">year...</option>
                <%
  		for (var i=currYear; i >= 2008; i--) {
  			%>
                <option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option>
                <%
  		}
  	%>
              </select>
            </p>
            <p><strong>Serial Number:</strong> <br/>
              <input type="text" name="serial_num" value="<%= E._getSerialNum() %>" />
              &nbsp;<small>( <a href="/support/regPPCFindSerial.asp">Where can I find my serial number?</a> )</small></p>
            <p><br />
            </p>
            <p><strong>TERMS AND CONDITIONS</strong></p>
            <ul style="list-style: none; margin-left: 0;">
              <li>
                <input type="checkbox" name="terms01" value="1" <%= parseInt(Request("terms01"))==1?" checked=\"checked\"":"" %> />
                I understand that the Complimentary Tuning Voucher included in the Yamaha Piano 10 Year Warranty Booklet is invalid for my grand piano and cannot be used in conjunction with the Yamaha Piano Premium Care program.</li>
              <li>
                <input type="checkbox" name="terms02" value="1" <%= parseInt(Request("terms02"))==1?" checked=\"checked\"":"" %> />
                <strong>I have read and understood the <a href="/support/regPPCTerms.asp">Terms and Conditions</a>.</strong></li>
            </ul>           
            <p>
              <input type="submit" name="submit" value="Register" class="button"/>
            </p>
          </form>
        </div>
        <!--#include file="global/globalMainContentEnd.asp" -->
  <!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>