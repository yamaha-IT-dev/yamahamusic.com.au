<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"

dim default_url
dim local_url
local_url = Request.ServerVariables("LOCAL_ADDR")

if local_url = "172.29.64.7" then
	default_url = "http://172.29.64.7:88/dealers/resources/"
else
	default_url = "http://www.yamahamusic.com.au/dealers/resources/"
end if
%>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
      <a class="navbar-brand" href="<%=default_url%>home.asp" title="Home">CONNECT</a></div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" title="Online Forms">Forms <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li class="dropdown-header">TEACHER</li>
            <li><a href="<%=default_url%>forms/teacher-absence.asp">Absence</a></li>
            <li class="divider"></li>
            <li class="dropdown-header">STUDENT</li>
            <li><a href="<%=default_url%>forms/student-discontinuation.asp">Discontinuation</a></li>                        
            <li><a href="<%=default_url%>forms/student-absence.asp">Leave of Absence</a></li>
            <li><a href="<%=default_url%>forms/student-makeup.asp">Make up Lesson</a></li>
            <li><a href="<%=default_url%>forms/student-transfer.asp">Transfer</a></li>
          </ul>
        </li>
        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" title="Class Reports">Reports <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=default_url%>reports/melbourne/">Melbourne</a></li>
            <li><a href="<%=default_url%>reports/sydney/">Sydney</a></li>
            <li><a href="<%=default_url%>reports/perth/">Perth</a></li>
            <li class="divider"></li>
            <li class="dropdown-header">RESOURCES</li>
            <li><a href="<%=default_url%>resources/class/">Class</a></li>
            <li><a href="<%=default_url%>resources/admin/">Admin</a></li>
          </ul>
        </li>
        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" title="Re-enrolment Letters">Letters <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="<%=default_url%>letters/graduation.asp">Graduation</a></li>
            <li><a href="<%=default_url%>letters/changes.asp">Teacher Changes</a></li>
            <li><a href="<%=default_url%>letters/disbanding.asp">Disbanding</a></li>
            <li><a href="<%=default_url%>letters/music-wonderland.asp">Music Wonderland</a></li>
          </ul>
        </li>
        <li class="dropdown"><a href="contacts/" class="dropdown-toggle" title="Contacts">Contacts</a></li>
        <li class="dropdown"><a href="faq/" class="dropdown-toggle" title="FAQ">FAQ</a></li>
        <li class="dropdown"><a href="forum/" class="dropdown-toggle" title="Forum">Forum</a></li>
      </ul>
    </div>
    <!--/.nav-collapse --> 
  </div>
</div>