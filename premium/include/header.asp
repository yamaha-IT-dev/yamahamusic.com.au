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
	default_url = "http://172.29.64.7:88/"
else
	default_url = "https://www.yamahamusic.com.au/"
end if
%>
<tr>
  <td align="left" class="main_header_td"><a href="http://au.yamaha.com/" target="_blank"><img src="<%=default_url%>premium/images/logo_yamaha.jpg" alt="Yamaha Music Australia" border="0" /></a>
  <p><img src="<%=default_url%>premium/images/logo_ppc.jpg" alt="Yamaha Piano Premium Care" border="0" /></p>
  </td>
</tr>
