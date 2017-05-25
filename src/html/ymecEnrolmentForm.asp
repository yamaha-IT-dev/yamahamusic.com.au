<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
	<title>Yamaha Music Australia - Education</title>

	<meta name="Title" content="Yamaha Music Australia - Music Education" />
	<meta name="Description" content="Yamaha Music Education Centres provide music lessons and online enrolment for children right accross Victoria, New South Wales and South Australia. Our Music Wonderland, Junior Music and Group Music Classes are perfect for children from 3 - 12 years of age." />
	<meta name="Keywords" content="music lessons, music education, keyboard lessons, piano lessons, solfege singing, kinder music classes, music for children, yamaha music education centre, yamaha music lessons, young musicians, junior music, music courses, music wonderland, free information sessions, yamaha music school, class timetable, enrolment, Balwyn North, Berwick, Blackburn, Brighton, Canterbury, Eltham North, Endeavour Hills, Glen Waverley, Malvern, Newport, Strathmore, Thornbury, Adelaide, Baulkham Hills, Chatswood, Dulwich Hill, Jannali, Wentworthville, Yamaha, Music, Education, Wonderland, Family, Music Days, Dreams, Musicians, Keyboards, Teachers, Teach, Learn, Passionate, Kindergarten, Prep, Children, Novice, Learner, Audio, Visual, HiFi Components, Musical, Instruments, Pianos, Grand Pianos, Upright Pianos, Disclavier, Guitars, Pacifica, Drums, Paiste, Cymbals, Brass, Woodwind, Clavinova, Electronic, Keyboards, Tyros, Synth, Synthesizers, Pro Audio, PA, Mixers, Desks, Mixing Desks, Power Amps, Rock, Roll, Swing, Jazz, Blues, Hip Hop, Latin, Country, Western, Oz Music, Trumpets, Trombones, Flutes, Saxaphones, Music Connect, YMEC, Music Education, YAYPC, Youth Piano Competition" />
	<meta name="Date" content="01/07/2006" />
	<meta name="Language" content="English" />
	<meta name="Publisher" content="Yamaha Music Australia Pty Ltd" />
	<meta name="Rights" content="Copyright 2006, Yamaha Music Australia." />


	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

	<script type="text/javascript" src="/utility.js"></script>
	<script type="text/javascript" src="/prototype.js"></script>

	<style type="text/css" media="screen">@import "/yamahamusic.css";</style>
	<style type="text/css" media="print">@import "/yamahamusic.print.css";</style>
	<style type="text/css" media="screen">@import "/yamahamusic.nav.css";</style>
	<style type="text/css" media="screen">@import "yamahamusic.ymec.css";</style>
	<style type="text/css" media="screen">
	#main {
		width : 700px;
		padding : 0 0 0 0;
	}

	label {
		float : left;
		font-weight : bold;
		width : 16em;
		margin-right : 10px;
	}

	#timetable_search p {
		float : left;
	}

	</style>

	<script type="text/javascript">

	function findClasses() {

		new Insertion.Top('timetable', '<div style="text-align:center;"><img src="/images/icons/iconLoading.gif" /><br/>Loading, please wait.</div>');

		var url = 'ajax_timetable.asp';
		var params = 'action=' + $F('ajax_action') +
					 '&term=' + $F('term') +
					 '&state=' + $F('state') +
					 '&courseid=' + $F('courseid') +
					 '&centreid=' + $F('centreid') +
					 '&day=' + $F('day');
		var ajax = new Ajax.Updater(
			{success: 'timetable'}, url,
			{method: 'get', parameters: params, onFailure: reportError, onComplete: checkTimetableRadio}
		);
	}

	function reportError(request) {
		$F('timetable') = "Error";
	}


	function checkTimetableRadio() {
		var rxID = parseInt($F('rx_timetableid'));
		if (rxID > 0) {
			var eTID = $('timetableid_' + rxID)
//alert(eTID);
				eTID.checked = true;
		}

	}


	</script>

<!--#include file="global/navigationStylesheet.asp" -->

</head>
<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<div id="left">
<!--#include file="global/navigationLeftShallow.asp" -->
</div>
<div id="banner"><img src="images/pageBannerGeneral.jpg"/></div>
<!--#include file="global/globalMainContentStart.asp" -->


<h1>YMEC Enrolment</h1>
<h2>We are excited that you would like to enrol in one of Yamaha's music education classes. Please complete the following form and a Yamaha Music Education Administrator will contact you to confirm your class time and collect your deposit.</h2>
<p>&nbsp;</p>
<%
	if (message.length > 0) {
		%><p class="alert"><%= message %></p><%
	}
%>
<form name="enquiryForm" action="<%= CONTROLLER %>" method="post">
	<input type="hidden" name="action" value="<%= ENROL_SEND %>">
	<input type="hidden" name="rx_timetableid" id="rx_timetableid" value="<%= Request("timetableid") %>">

	<h2><strong>Step 1. Search for a course</strong></h2>
	<input type="hidden" name="ajax_action" id="ajax_action" value="ajax_lookup_enrol" />
	<fieldset id="timetable_search">
	<input type="hidden" name="ajax_action" id="ajax_action" value="ajax_lookup_timetable" />

	<p>Choose Term
	<br/><select name="term" id="term">
		<option value="0">any term</option><%

	for (i = 1; i <= 4; i++) {
		%><option value="<%= i %>"<%= parseInt(Request("term"))==i?" selected=\"selected\"":"" %>>Term <%= i %></option><%
	}

	%></select>&nbsp;</p>

	<p>Choose State
	<br/><select name="state" id="state">
		<option value="">any state</option><%

	var arrS = new Array("VIC", "NSW", "SA","WA");

	for (i = 0; i < arrS.length; i++) {
		%><option value="<%= arrS[i] %>"<%= Request("state")==arrS[i]?" selected=\"selected\"":"" %>><%= arrS[i] %></option><%
	}

	%></select>&nbsp;</p>

	<p>Choose centre
	<br/><select name="centreid" id="centreid">
		<option value="">any centre</option><%

	var EC = new EdCentre();
	var rsEC = EC._getAllCentre(1, null);
	if (rsEC && !rsEC.EOF) {
		while (!rsEC.EOF) {
			%><option value="<%= rsEC("id") %>"<%= parseInt(Request("centreid"))==parseInt(rsEC("id"))?" selected=\"selected\"":"" %>><%= rsEC("state") %> : <%= rsEC("name") %></option><%
			rsEC.MoveNext();
		}
	}

	%></select>&nbsp;</p>

	<p>Choose Day
	<br/><select name="day" id="day">
		<option value="">any day</option><%

	for (i = 1; i < 8; i++) {
		%><option value="<%= i %>"<%= parseInt(Request("day"))==i?" selected=\"selected\"":"" %>><%= GBL_DAYS[i] %></option><%
	}

	%></select>&nbsp;</p>

	<p>Choose course
	<br/><select name="courseid" id="courseid">
		<option value="">any course</option><%

	var EC = new EdCourse();
	var rsEC = EC._getAllCourses();
	if (rsEC && !rsEC.EOF) {
		while (!rsEC.EOF) {
			%><option value="<%= rsEC("id") %>"<%= parseInt(Request("courseid"))==parseInt(rsEC("id"))?" selected=\"selected\"":"" %>><%= rsEC("name") %></option><%
			rsEC.MoveNext();
		}
	}

	%></select>&nbsp;</p>

	<p>&nbsp;
	<br/><input type="button" name="ajax_submit" value="go" class="button" onclick="findClasses();"/></p>
	</fieldset>
<div id="timetable" style="margin:10px 0 20px 0;">

</div>


	<img src="images/bannerBackpack.gif" style="float:right;margin:0 0 0 0;" />

	<h2><strong>Step 2. Enrolment details</strong></h2>

	<p><label for"promocode">Promotional Code</label>
	<input type="text" name="promocode" value="<%= E._getEnrolmentPromocode() %>" style="width:150px;"/></p>

	<p><label for"date">Student's name</label>
	<input type="text" name="studentname" value="<%= E._getEnrolmentStudentname() %>" style="width:150px;"/></p>

	<p><label for"date">Student's gender</label>
	<input type="radio" name="studentgender" value="boy" <%= new String(E._getEnrolmentStudentgender()).indexOf("boy") ==0?" checked=\"checked\"":"" %>/>Boy&nbsp;&nbsp;
	<input type="radio" name="studentgender" value="girl"<%= new String(E._getEnrolmentStudentgender()).indexOf("girl")==0?" checked=\"checked\"":"" %>/>Girl&nbsp;
	</p>

	<p><label for"date">Student's grade</label>
	<input type="text" name="studentgrade" value="<%= E._getEnrolmentStudentgrade() %>" style="width:75px;"/></p>

	<p><label for"date">Student's date of birth</label>
	<%

		var dRef = new String(E._getEnrolmentStudentdateofbirth());
		if (dRef.length != 0) {
			dRef = new Date(Date.parse(dRef));
		} else {
			dRef = new Date();
		}
		var refDay = dRef.getDate();
		var refMonth = dRef.getMonth();
		var refYear = dRef.getFullYear();
	%>
	<select name="fDay">
		<option value="0">day...</option><%
		for (var i=1; i <= 31; i++) {
			%><option value="<%= i %>"<%= refDay==i?" selected=\"selected\"":"" %>><%= i %></option><%
		}
	%></select>&nbsp;
	<select name="fMonth">
		<option value="0">month...</option><%
		for (var i=0; i < 12; i++) {
			%><option value="<%= i+1 %>"<%= refMonth==i?" selected=\"selected\"":"" %>><%= GBL_MONTHS[i] %></option><%
		}
	%></select>&nbsp;
	<select name="fYear">
		<option value="0">year...</option><%
		for (var i=2006; i >= 1970; i--) {
			%><option value="<%= i %>"<%= refYear==i?" selected=\"selected\"":"" %>><%= i %></option><%
		}
	%></select></p>

	<p><label for"studentaddress">Address</label>
	<textarea name="studentaddress" rows="2" style="width:200px;"><%= E._getEnrolmentStudentaddress() %></textarea></p>

	<p><label for"studentsuburb">Suburb</label>
	<input type="text" name="studentsuburb" value="<%= E._getEnrolmentStudentsuburb() %>" style="width:150px;"/></p>

	<p><label for"studentstate">State</label>
	<select name="studentstate">
		<option value="">choose state...</option><%
		for (var i=0; i < GBL_STATES_SHORT.length; i++) {
			%><option value="<%= GBL_STATES_SHORT[i] %>"<%= E._getEnrolmentStudentstate().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option><%
		}
	%></select></p>

	<p><label for"studentpostcode">Postcode</label>
	<input type="text" name="studentpostcode" value="<%= E._getEnrolmentStudentpostcode() %>" style="width:50px;"/></p>


	<p><label for"parentname">Parents' names</label>
	<select name="parenttitle1"><option value=""></option><%
		for (var i=1; i < GBL_TITLES.length; i++) {
			%><option value="<%= GBL_TITLES[i] %>"<%= E._getEnrolmentParenttitle1().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option><%
		}
	%></select>&nbsp;<input type="text" name="parentname1" value="<%= E._getEnrolmentParentname1() %>" style="width:200px;"/></p>

	<p><label for"parentname2">&nbsp;</label>
	<select name="parenttitle2"><option value=""></option><%
		for (var i=1; i < GBL_TITLES.length; i++) {
			%><option value="<%= GBL_TITLES[i] %>"<%= E._getEnrolmentParenttitle2().indexOf(GBL_TITLES[i])==0?" selected=\"selected\"":"" %>><%= GBL_TITLES[i] %></option><%
		}
	%></select>&nbsp;<input type="text" name="parentname2" value="<%= E._getEnrolmentParentname2() %>" style="width:200px;"/></p>

	<p><label for"guardian">Guardian (if appropriate)</label>
	<input type="text" name="guardian" value="<%= E._getEnrolmentGuardian() %>" style="width:200px;"/></p>

	<p><label for"phone">Preferred contact telephone number</label>
	<input type="text" name="phone" value="<%= E._getEnrolmentPhone() %>" style="width:150px;"/><br/>
	<small>Please include your area code</small></p>

	<p><label for"mobile">Alternate contact telephone number</label>
	<input type="text" name="mobile" value="<%= E._getEnrolmentMobile() %>" style="width:150px;"/><br/>
	<small>Please include your area code</small></p>

	<p><label for"email">Email address</label>
	<input type="text" name="email" value="<%= E._getEnrolmentEmail() %>" style="width:150px;"/></p>

	<p><label for"time">Preferred contact time</label>
	<select name="time" style="width:200px;">
		<option value="">choose...</option><%
		for (var i=0; i < arrCsTimes.length; i++) {
			%><option value="<%= arrCsTimes[i] %>"<%= new String(E._getEnrolmentPreferredtime()).indexOf(arrCsTimes[i])==0?" selected=\"selected\"":"" %>><%= arrCsTimes[i] %></option><%
		}
	%></select></p>

	<p><label for"backpack">Would you like to purchase a backpack for $15 each plus $3 postage and handling?</label>
	<input type="radio" name="backpack" value="1"<%=    new String(E._getEnrolmentBackpack()).indexOf("1")==0?" checked=\"checked\"":"" %>/>One &nbsp;&nbsp;
	<input type="radio" name="backpack" value="2"<%=    new String(E._getEnrolmentBackpack()).indexOf("2")==0?" checked=\"checked\"":"" %>/>Two &nbsp;&nbsp;
	<input type="radio" name="backpack" value="More"<%= new String(E._getEnrolmentBackpack()).indexOf("More")==0?" checked=\"checked\"":"" %>/>More &nbsp;&nbsp;
	<input type="radio" name="backpack" value="null"<%= new String(E._getEnrolmentBackpack()).indexOf("null")==0?" checked=\"checked\"":"" %>/>None<br/>
	<em>The purchase of your backpack will be confirmed when you pay your deposit.</em>
	</p>

	<p><label for"findout">Where did you find out about YMEC?</label>
	<select name="findout" style="width:300px;">
		<option value="" style="font-style:italic;">please choose...</option><%
		for (var i=1; i < arrFoundOut.length; i++) {
			%><option value="<%= arrFoundOut[i] %>"<%= E._getEnrolmentFindout().indexOf(arrFoundOut[i])==0?" selected=\"selected\"":"" %>><%= arrFoundOut[i] %></option><%
		}
	%></select></p>

	<p><label for"comments">Do you have any additional comments?</label>
	<textarea name="comments" rows="4" style="width:300px;"><%= E._getEnrolmentComments() %></textarea></p>

	<h2>Terms and Conditions</h2>
	<p>In making this enrolment, I understand and agree to the following conditions:</p>
	<p><strong><em> Effective 1 January 2007 </em></strong></p>

	<ul>
		<li><strong>NEW STUDENTS</strong>
			<ol>
				<li>A deposit of $50 is required upon enrolment to secure a place in a class. This will be deducted from the first invoice and is non refundable if the class you have enrolled in commences. <strong></strong></li>
				<li>New classes will begin, in most cases, in the first week of the school term. If for any reason your class is unable to start as anticipated you will be notified immediately.<strong></strong></li>
			</ol></li>

		<li><strong>CLASSES</strong>
			<ol>
				<li>A parent is required to attend lessons with their child for Music Wonderland and Junior Music Course. Yamaha recommends a parent to attend lessons with their child for the Young Musicians&rsquo; Course and encourages parental attendance for all other group courses.</li>
				<li>Siblings are not permitted in the classroom as they may prove to be a distraction to other students.</li>
				<li>We endeavour to maintain the class day, time, location and teacher for the duration of the course. If unforeseen circumstances arise, such as a class falling below five (5) students, or a teacher becoming unavailable, there may be a need to change the day, time, location and/or teacher.</li>
			</ol></li>

		<li><strong>TUITION FEES</strong>
			<ol>
				<li>Invoices will be issued on a semester basis. </li>
				<li>There are 3 payment options.
				<ol style="list-style-type:lower-alpha;">
					<li>5 equal installments using Direct Debit (savings, cheque or credit card account) </li>
					<li>2 equal installments using BPay, credit card or cheque </li>
					<li>1 upfront payment using BPay, credit card or cheque </li>
				</ol>
				<li>Sibling Discount is only applicable to brothers and sisters. </li>
				<li>Account adjustments (if applicable) will be made at the end of the semester and will be adjusted against the invoice for the following semester. </li>
				<li>Statements will be supplied upon request.</li>
			</ol></li>

		<li><strong>ACCOUNT ADJUSTMENTS</strong></p>
			<ol>
				<li>Absences
				<ul>
					<li>Refunds will not be given for student absences. </li>
					<li>If your child is unable to attend for four (4) or more consecutive weeks a nominal credit will be given. </li>
				</ul></li>

				<li>Class Cancellations<br/>
					Every effort will be made to ensure that classes will not be cancelled; however, where this is unavoidable you will be credited for the lesson.</li>

				<li>Discontinuations
				<ul>
					<li> Should you wish to discontinue the Yamaha course, we request that you contact your Regional Co-ordinator or the Education Customer Service Centre on 1300 139 506 option 1.</li>
					<li> You will only be credited for 75% of the remaining fees for that semester. </li>
				</ul></li>

				<li>Non Payment of Fees </li>
				<ul>
					<li>Fees that are not paid in full or by installment when due will incur a $25 late fee and if the matter is referred to a debt collector you will be responsible for all costs incurred. </li>
					<li>You will incur a $9 fee if your Direct Debit transaction is declined. </li>
				</ul>
			</ol></li>
	</ul>

	<p><input type="checkbox" name="terms" value="1" <%= parseInt(Request("terms"))==1?" checked=\"checked\"":"" %> /><strong>I have read and understood the Terms and Conditions.</strong></p>

	<p><input type="submit" name="submit" value="submit enrolment" class="button"/></p>

</form>


<%
/* ASP Start */
	if (new String(Request("submit")).indexOf("submit enrolment") == 0) {
%>
	<script type="text/javascript">
		findClasses();
	</script>
<%
	}
/* ASP End */
%>



<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>