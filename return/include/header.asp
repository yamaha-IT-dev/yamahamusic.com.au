<%
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
  <td align="right" class="main_header_td"><img src="<%=default_url%>return/images/forward_arrow.gif" /> <a href="default.asp?logout=y">Log out</a></td>
</tr>
<tr>
  <td align="left" class="main_header_td_2"><a href="<%=default_url%>return/home.asp">Home</a> | <a href="<%=default_url%>return/add_return.asp">New Return</a> | <a href="<%=default_url%>return/update_user.asp">Update your details</a> | <a href="<%=default_url%>return/help.asp">Help</a><small>
    <div align="right">G'day <%= Session("usr_firstname") %>!</div>
    </small></td>
</tr>
