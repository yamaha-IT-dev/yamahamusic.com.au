<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Teacher Network</title>
  <script src="/utility.js"></script>
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
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
      width: 800px;
      padding: 0 0 0 0;
    }
  </style>
</head>
<body>
<!--#include file="global/globalHeader.asp" -->
<!--#include file="global/globalOuterContentStart.asp" -->
<!--#include file="global/globalMainContentStart.asp" -->
<%
if (Session("yma_userid") > 0) {
%>
  <h1>G'day <%= C._getCustomerFirstname() %>! Welcome to YME Teacher Network</h1>
  <h1><i class="fa fa-envelope-o"></i> Contact</h1>
  <p>Please note, we are currently updating our email addresses. Please use either of the following email addresses:</p>
  <ul>
    <li><a href="mailto:contact@teacher.yamahamusiceducation.com.au">contact@teacher.yamahamusiceducation.com.au</a></li>
    <li><a href="mailto:teacher@yamahamusic.edu.au">teacher@yamahamusic.edu.au</a></li>
  </ul>
  <br>
  <p>
    PO Box 268<br>
    South Melbourne VIC 3205
  </p>
  <h1>Teacher Grade Exams</h1>
  <ul>
      <li><a href="YGES_5-3_Application_Form_for_Teachers.pdf" target="_blank">Grades 5-3 Application Form for Yamaha Teachers</a></li>
      <li><a href="YGES_5-3_Materials_Order_Sheet.pdf" target="_blank">Piano Grade 5-3 Materials - Order Sheet</a></li>
  </ul>
  <h1>Pa Pa Parade – Concert Actions</h1>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/toOL3iJ9JIM" frameborder="0" allowfullscreen></iframe>
  <h1>Music Wonderland</h1>
  <h2>A Flying Penguin</h2>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/a9TSJ0R-hTY" frameborder="0" allowfullscreen></iframe>
  <h2>Flip Flap</h2>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/dp3PoCzoZfs" frameborder="0" allowfullscreen></iframe>
  <h2>Samba de Amigos</h2>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/Q5fnPp5UT_E" frameborder="0" allowfullscreen></iframe>
  <h2>Good Morning</h2>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/Dn4wvDHpLCs" frameborder="0" allowfullscreen></iframe>
  <h1>Parent Information</h1>
  <ul>
    <li><a href="junior_music_course.pdf" target="_blank">Junior Music Course</a></li>
    <li><a href="yamaha_grade_examination_system.pdf" target="_blank">Yamaha Grade Examination System</a></li>
    <li><a href="term_2_events.pdf" target="_blank">Term 2 Events</a></li>
  </ul>
  <h1>Term Two Teacher Pack - Video</h1>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/07J-AavX1eo" frameborder="0" allowfullscreen></iframe>
  <h1>Parent Talks</h1>
  <h2>MWO Graduating to JMC</h2>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/OzFgQnAXAjM" frameborder="0" allowfullscreen></iframe>
  <h2>JMC 4 Graduating to JXC</h2>
  <iframe width="560" height="315" src="https://www.youtube.com/embed/36GC442vbow" frameborder="0" allowfullscreen></iframe>
  <div class="float_left">
    <h1><i class="fa fa-link"></i> <a href="http://synergetic.yamahamusic.com.au:7008/" target="_blank">Synergetic</a></h1>
    <h1><i class="fa fa-file-pdf-o"></i> PDF Forms</h1>
    <ul>
      <li><a href="ClassCancellationForm.pdf" target="_blank">Class Cancellation</a></li>
      <li><a href="SubstituteClassRequestForm.pdf" target="_blank">Substitute Class Request</a></li>
      <li><a href="SubstituteTeacherForm.pdf" target="_blank">Substitute Teacher Request</a></li>
    </ul>
<%
var boolCoordinator = true;
var T = new Teacher();

boolCoordinator = T._isCoordinator(Session("yma_userid"));

if (boolCoordinator) {
%>
    <h1><i class="fa fa-newspaper-o"></i> Online Forms</h1>
    <ul>
      <li><a href="forms.asp?action=form_makeup">Make Up Lesson</a></li>
      <li><a href="forms.asp?action=form_discontinue">Student Discontinuation</a></li>
      <li><a href="forms.asp?action=form_leave">Student Leave Of Absence</a></li>
      <li><a href="forms.asp?action=form_transfer">Student Transfer</a></li>
      <li><a href="forms.asp?action=form_absence">Teacher Absence Form</a></li>
    </ul>
<%
}
} else {
%>
    <h1>Yamaha Music Teacher Network</h1>
    <h2>(Registered Yamaha Music teachers only)</h2>
    <form action="<%= CONTROLLER %>" method="post" id="loginForm">
      <input type="hidden" name="action" value="<%= TEACHER_LOGIN %>" />
<%
if (message.length > 0) {
%>
      <p class="alert"><%= message %></p>
<%
}
%>
      <p>U: <input name="username" type="text" value="<%= U._getUserUsername() %>" size="25" maxlength="50" placeholder="Username" /></p>
      <p>P: <input name="password" type="password" value="<%= U._getUserPassword() %>" size="25" maxlength="25" placeholder="Password" /></p>
      <p><input type="submit" name="submit" value="log in" class="button" /></p>
    </form>
    <p><a href="forgot.asp">Forgot your username / password?</a></p>
<%
}
%>
  </div>
<!--#include file="global/globalMainContentEnd.asp" -->
<!--#include file="global/globalOuterContentEnd.asp" -->
<!--#include file="global/navigationFooter.asp" -->
</body>
</html>