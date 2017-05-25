<%
Response.CacheControl = "no-cache" 
Response.AddHeader "cache-control","private"
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

dim default_url
dim local_url
local_url = Request.ServerVariables("LOCAL_ADDR")

if local_url = "172.29.64.7" then
	default_url = "http://172.29.64.7:88/technology/"
else
	default_url = "http://www.yamahamusic.com.au/technology/"
end if
%>

<h1 class="remove-bottom" style="margin-top:5px"><a href="<%=default_url%>"><img src="<%=default_url%>images/yma-logo.jpg" border="0" /></a></h1>
