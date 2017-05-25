<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>Yamaha Music Australia - YMEC - Teacher Network</title>
<meta name="Title" content="Yamaha Music Australia - Music Education" />
<meta name="Date" content="01/07/2006" />
<meta name="Language" content="English" />
<meta name="Publisher" content="Yamaha Music Australia Pty Ltd" />
<meta name="Rights" content="Copyright 2006, Yamaha Music Australia." />
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
	width : 760px;
	padding : 0 0 0 0;
}
h2.synergetic {
	padding : 5px 0 5px 25px;
	background-image : url('images/iconSynergetic.gif');
	background-repeat : no-repeat;
	background-position : 0% 50%;
}
</style>
<!--#include file="global/navigationStylesheet.asp" -->
</head>
<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
      <div id="left">
        <!--#include file="global/navigationLeftShallow.asp" -->
      </div>
      <!--#include file="global/globalMainContentStart.asp" -->
        <% 
	if (Session("yma_userid") > 0) {
%>
        <h1>Hi <%= C._getCustomerFirstname() %>, welcome to the YMEC Teacher Network</h1>
        <p>Please use this site to access many of the online services and resources for teachers, if you <br/>
          have any problems, queries or would like to speak to someone directly please call <strong>1300 139 506</strong></p>
        <h2>Private Room Rental Spreadsheet</h2>
        <p>Click here to download the <a href="Room_Rental_Template.xls">Spreadsheet</a></p>
        <table width="100%">
          <tr>
            <td valign="top"><%
	var R = new Resource();

		var rsAllResources = R._getAllResourcesByCategory(GBL_CATEGORY_YMEC_NEWS, true);
		%>
              <h2>NEWS</h2>
              <%
		if (rsAllResources && !rsAllResources.EOF) {
			var c = 0;
			var count = 2;
			var rcount = 0;
			while (!rsAllResources.EOF) {
				R._drawResourceItem(rsAllResources, "teachers.asp", GBL_CATEGORY_YMEC_NEWS);
				c++;
				if (c != count) {
					rsAllResources.MoveNext();
				} else {
					break;
				}
			}
			%>
              <p>View <a href="<%= CONTROLLER %>?action=<%= LIST_ITEMS %>&amp;categoryid=<%= GBL_CATEGORY_YMEC_NEWS %>">all past news items</a>.</p>
              <%
		} else {
			%>
              <p>There are no news items.</p>
              <%
		}

		R._drawResourcesShort(GBL_CATEGORY_YMEC_SYDNEY, null, "teachers.asp", 3);

		R._drawResourcesShort(GBL_CATEGORY_YMEC_MELB, null, "teachers.asp", 3);
		
		R._drawResourcesShort(GBL_CATEGORY_YMEC_PERTH, null, "teachers.asp", 3);

		R._drawResourcesShort(GBL_CATEGORY_YMEC_CLASSROOM, null, "teachers.asp", 3);

		R._drawResourcesShort(GBL_CATEGORY_YMEC_ADMIN, null, "teachers.asp", 3);


%></td>
            <td valign="top"><h2 class="synergetic">SYNERGETIC</h2>
              <h3>Have you marked your roll?</h3>
              <p>Make sure you log into the Synergetic<br/>
                Web Module and mark your roll.<br/>
                <a href="<%= GBL_SYNERGETIC %>" class="goThere">ENTER SYNERGETIC</a></p>
              <% 
	var boolCoordinator = true;
	var T = new Teacher();
		boolCoordinator = T._isCoordinator(Session("yma_userid"));

	if (boolCoordinator) {
	
%>
              <h2>Online Forms</h2>
              <p> <a href="forms.asp?action=form_absence" class="form">Teacher Absence Form</a><br/>
                <!--<a href="forms.asp?action=form_enquiry" class="form">Enquiry Capture</a><br/>-->
                <a href="forms.asp?action=form_transfer" class="form">Student Transfer</a><br/>
                <a href="forms.asp?action=form_discontinue" class="form">Student Discontinuation</a><br/>
                <a href="forms.asp?action=form_leave" class="form">Student Leave Of Absence</a><br/>
                <a href="forms.asp?action=form_makeup" class="form">Make Up Lesson</a></p>
              <%
	}

%>
              <%
		// R._drawResourcesShort(23, null, "teachers.asp", 3);
%>
              <!-- 
		<h2>Yamaha Grade Exams</h2>
		<p>Please download following forms for your reference to the Yamaha Grade Exam Proposals (FSS/YAT/Grade Exams).  Please send the completed forms to Atsuko at Yamaha Music Australia HO.<br/>
		<a class="pdf" target="_blank" href="resources/2007/FSSSummary2007.pdf">FSS Summary</a><br/>
		<a class="pdf" target="_blank" href="resources/2007/YATSummary2007.pdf">YAT Summary</a><br/>
		<a class="pdf" target="_blank" href="resources/2007/GradeExamRegulation2007.pdf">Grade Exam Regulation</a><br/>
		<a class="pdf" target="_blank" href="resources/2007/GradeExamSpecialRequestForm.pdf">Grade Exam Special Request Form</a><br/>
		<a class="pdf" target="_blank" href="resources/2007/GradeExamMaterialOrderForm.pdf">Grade Exam Material Order Form</a><br/>
		<a class="pdf" target="_blank" href="resources/2007/GradeExamFee2007.pdf">Grade Exam Fee 2007</a></p>
	    -->
              <h2>Re-enrolment Letters</h2>
              <p><a href="pdf/01_graduating_JMC.pdf" target="_blank">1 - Graduating JMC</a><br />
                <a href="pdf/02_graduating_JXC.pdf" target="_blank">2 - Graduating JXC</a><br />
                <a href="pdf/02_graduating_YMC.pdf" target="_blank">2 - Graduating YMC</a><br />
                <a href="pdf/03_YMC_4_(end-of-year).pdf" target="_blank">3 - YMC 4 (end of year)</a><br />
                <a href="pdf/03_YMC_4_(end-of-year)_add-on.pdf" target="_blank">3 - YMC 4 (end of year) add on</a><br />
                <a href="pdf/03_YMC_4_(mid-year).pdf" target="_blank">3 - YMC 4 (mid year)</a><br />
                <a href="pdf/04_graduating_JAC.pdf" target="_blank">4 - Graduating JAC</a><br />
                <a href="pdf/05_course_completion.pdf" target="_blank">5 - Course completion</a><br />
                <a href="pdf/06_teacher_change_(end-of-year).pdf" target="_blank">6 - Teacher change (end of year)</a><br />
                <a href="pdf/06_teacher_change_(mid-year).pdf" target="_blank">6 - Teacher change (mid year)</a><br />
                <a href="pdf/07_teacher_change_NEW_teacher_(end-of-year).pdf" target="_blank">7 - NEW teacher change (end of year)</a><br />
                <a href="pdf/07_teacher_change_NEW_teacher_(mid-year).pdf" target="_blank">7 - NEW teacher change (mid year)</a><br />
                <a href="pdf/08_day-time-and-or-location-change_(end-of-year).pdf" target="_blank">8 - Day, time and or location change (end of year)</a><br />
                <a href="pdf/08_day-time-and-or-location-change_(mid-year).pdf" target="_blank">8 - Day, time and or location change (mid year)</a><br />
                <a href="pdf/09_teacher-day-time-and-or-location-change_(end-of-year).pdf" target="_blank">9 - Teacher, day, time and or location change (end of year)</a><br />
                <a href="pdf/09_teacher-day-time-and-or-location-change_(mid-year).pdf" target="_blank">9 - Teacher, day, time and or location change (mid year)</a><br />
                <a href="pdf/10_NEW_teacher-day-time-and-or-location-change_(end-of-year).pdf" target="_blank">10 - NEW Teacher, day, time and or location change (end of year)</a><br />
                <a href="pdf/10_NEW_teacher-day-time-and-or-location-change_(mid-year).pdf" target="_blank">10 - NEW Teacher, day, time and or location change (mid year)</a><br />
                <a href="pdf/11_disbanding_no_options.pdf" target="_blank">11 - Disbanding No Options</a><br />
                <a href="pdf/12_disbanding_one_option.pdf" target="_blank">12 - Disbanding One option</a><br />
                <a href="pdf/13_disbanding_two_or_more_options.pdf" target="_blank">13 - Disbanding Two or more options</a><br />
                <a href="pdf/14_MWO.pdf" target="_blank">14 - MWO</a><br />
                <a href="pdf/15_MWO_day-time-and-or-location-change.pdf" target="_blank">15 - MWO - Day, Time and or Location Change</a><br />
                <a href="pdf/16_MWO_teacher-day-time-and-or-location-change.pdf" target="_blank">16 - MWO - Teacher, day, time and or location change</a><br />
                <a href="pdf/17_MWO_NEW_teacher-day-time-and-or-location-change.pdf" target="_blank">17 - MWO - NEW Teacher, day, time and or location change</a><br />
                <a href="pdf/18_MWO_teacher-change.pdf" target="_blank">18 - MWO - Teacher Change</a><br />
                <a href="pdf/19_MWO_teacher-change_NEW_teacher.pdf" target="_blank">19 - MWO - Teacher Change - NEW Teacher</a><br />
                <a href="pdf/20_teacher_leaving_no_option.pdf" target="_blank">20 - Teacher Leaving No Option</a><br />
                <a href="pdf/continuing_classes.pdf" target="_blank">Continuing Classes</a><br />
              </p></td>
            <td valign="top"><h1>CONTACTS</h1>
              <h3>Customer Service Centre</h3>
              <p>p: 1300 139 506<br/>
                e : <a href="mailto:ymec_aust@gmx.yamaha.com">ymec_aust@gmx.yamaha.com</a></p>
                <hr />
              <h2>Regional Co-Ordinators</h2>
              <h3>VIC Bayside (Brighton &amp; Carnegie) - John Corlett</h3>
              <p>p: 0419 596 099<br/>
                e : <a href="mailto:rcvic_bay@gmx.yamaha.com">rcvic_bay@gmx.yamaha.com</a></p>
              <h3>VIC Eastern (Berwick, Balwyn North, Glen Waverley) - Belinda Glass</h3>
              <p>p: 0438 046 484<br/>
                e : <a href="mailto:rcvic_east@gmx.yamaha.com">rcvic_east@gmx.yamaha.com</a></p>
              <h3>VIC North/Western (Altona, Strathmore, Point Cook) - Peta Walter</h3>
              <p>p: 0438 067 996<br/>
                e : <a href="mailto:rcvic_nw@gmx.yamaha.com">rcvic_nw@gmx.yamaha.com</a></p>              
              <h3>NSW Hills (Baulkham Hills) - Matthew Breaden</h3>
              <p>p: 0417 025 930<br/>
                e : <a href="mailto:rcnsw_hills@gmx.yamaha.com">rcnsw_hills@gmx.yamaha.com</a></p>
              <h3>NSW Central (Chatswood) - Rita Higuchi</h3>
              <p>p:  0438 388 037<br/>
                e : <a href="mailto:rcnsw_central@gmx.yamaha.com">rcnsw_central@gmx.yamaha.com</a></p>
              <h3>WA Perth (Canning Vale, Morley) - Noelene Beacham</h3>
              <p>p:  0409 189 885<br/>
                e : <a href="mailto:rc_wa@gmx.yamaha.com">rc_wa@gmx.yamaha.com</a></p>              
              </td>
          </tr>
        </table>
        <% 
	} else {

%>
        <h1>Yamaha Music Teacher Network</h1>
        <h2>You must be registered as a Yamaha Music 
          teacher to access this system.</h2>
        <form action="<%= CONTROLLER %>" method="post" id="loginForm">
          <input type="hidden" name="action" value="<%= TEACHER_LOGIN %>" />
          <% 
		if (message.length > 0) {
			%>
          <p class="alert"><%= message %></p>
          <%
		}
	%>
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td>username</td>
              <td><input name="username" type="text" value="<%= U._getUserUsername() %>" size="25" maxlength="50" /></td>
            </tr>
            <tr>
              <td>password</td>
              <td><input name="password" type="password" value="<%= U._getUserPassword() %>" size="25" maxlength="25" /></td>
            </tr>
          </table>
          <p>
            <input type="submit" name="submit" value="log in" class="button" />
          </p>
        </form>
        <!--
	<h2>Not Registered?</h2>

	<p>If you are a teacher with a Yamaha Education Centre 
	and wish to access our online resources but don't have a username and password
	<a href="mailto:ymfaustralia@gmx.yamaha.com">contact our education manager</a>
	and detail your request.</p>
-->
        <% 
	}
%>
        <a href="forgot.asp">Forgot your username / password?</a>
        <div class="clearing"></div>
        <p>&nbsp;</p>
        <!--#include file="global/globalMainContentEnd.asp" -->
  <!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>