<%
'setup for Australian Date/Time
session.lcid = 2057
session.timeout = 420

'Response.Write "SID: " & Session.SessionID

dim strSection
dim default_url
dim local_url
local_url = Request.ServerVariables("LOCAL_ADDR")

if local_url = "172.29.64.7" then
	default_url = "http://172.29.64.7:88/"
else
	default_url = "https://www.yamahamusic.com.au/"
end if

function displayDateFormatted(strDateInput)	
	if IsNull(strDateInput) or strDateInput = "01/01/1900" or strDateInput = "1/1/1900"  then 
		response.write "NA"
	else
		response.write "" & WeekDayName(WeekDay(strDateInput)) & ", " & FormatDateTime(strDateInput,1) & " at " & FormatDateTime(strDateInput,3)	
	end if
end function
%>

<tr>
  <td align="right" class="main_header_td">
  <h3>G'day, <%= session("usr_firstname") %>!</h3>
  <% Response.Write WeekDayName(WeekDay(Date, vbLongDate)) & ", " & FormatDateTime(Date, vbLongDate) %><br />
  <img src="<%=default_url%>service/images/forward_arrow.gif" /> <a href="default.asp?logout=y">Log out</a>
  <br><img src="<%=default_url%>service/images/forward_arrow.gif" /> <a href="profile.asp">Update your profile</a>
  </td>
</tr>
<tr>
  <td align="left" class="main_header_td_2"><table cellpadding="10" cellspacing="0" border="0" width="100%">
      <tr>
        <% if strSection = "jobs" Then %>
        <td width="80" class="header_menu_selected"><a href="jobs.asp" class="heading">Jobs</a></td>
        <% else %>
        <td width="80" class="header_menu"><a href="jobs.asp" class="heading">Jobs</a></td>
        <% end if %>        
        <% if strSection = "support" Then %>
        <td width="100" class="header_menu_selected">Support</td>
        <% else %>
        <td width="100" class="header_menu"><a href="support.asp" class="heading">Support</a></td>
        <% end if %>
        <% if strSection = "links" Then %>
        <td width="100" class="header_menu_selected">Links</td>
        <% else %>
        <td width="100" class="header_menu"><a href="links.asp" class="heading">Links</a></td>
        <% end if %>
        <td class="header_menu_tail" align="right"></td>
      </tr>
    </table></td>
</tr>
