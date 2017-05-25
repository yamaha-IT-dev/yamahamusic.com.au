<% 
Dim strURL
strURL = "http://www.yamahamusic.com.au/return/"
%>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
      <a class="navbar-brand" href="<%= strURL %>home/" title="Home"><img src="<%= strURL %>images/home.png"></a>
      </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li class="dropdown"> <a href="" class="dropdown-toggle" data-toggle="dropdown">Entries <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="<%= strURL %>add-sales.asp">New Entry</a></li>
            <li><a href="<%= strURL %>entry/">Submitted Entries</a></li>
          </ul>
        </li>
        <li><a href="<%= strURL %>profile/" class="dropdown-toggle">Profile</a></li>        
        <li><a href="<%= strURL %>terms/" class="dropdown-toggle">Terms &amp; Conditions</a></li>
        <li><a href="<%= strURL %>?logout=y" class="dropdown-toggle">Log out</a></li>
      </ul>
    </div>
  </div>
</div>