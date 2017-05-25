<%
Response.CacheControl = "no-cache" 
Response.AddHeader "cache-control","private"
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 
%>
<style type="text/css">
#sddm {
	margin: 0;
	padding: 0;
	z-index: 30;
	white-space:nowrap;
}
#sddm li {
	margin: 0;
	padding: 0;
	list-style: none;
	float: left;
	font: 11px arial;
	white-space:nowrap;
}
#sddm li a {
	display: block;
	margin: 0 1px 0 0;
	padding: 4px 10px;
	background: #000;
	color: #FFF;
	text-align: center;
	text-decoration: none;
	white-space:nowrap;
}
#sddm li a:hover {
	background: #333333;
}
#sddm div {
	position: absolute;
	visibility: hidden;
	margin: 0;
	padding: 0;
	background: #000;
	border: 1px solid #FFF;
	white-space:nowrap;
}
#sddm div a {
	position: relative;
	display: block;
	margin: 0;
	padding: 5px 10px;
	width: auto;
	white-space: nowrap;
	text-align: left;
	text-decoration: none;
	background: #000;
	color: #FFF;
	font: 11px arial;
	white-space:nowrap;
}
#sddm div a:hover {
	background: #333333;
	color: #FFF;
	white-space:nowrap;
}
</style>
<script type="text/javascript"> 
// Copyright 2006-2007 javascript-array.com

var timeout	= 500;
var closetimer	= 0;
var ddmenuitem	= 0;

// open hidden layer
function mopen(id)
{	
	// cancel close timer
	mcancelclosetime();

	// close old layer
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';

	// get new layer and show it
	ddmenuitem = document.getElementById(id);
	ddmenuitem.style.visibility = 'visible';

}
// close showed layer
function mclose()
{
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
}

// go close timer
function mclosetime()
{
	closetimer = window.setTimeout(mclose, timeout);
}

// cancel close timer
function mcancelclosetime()
{
	if(closetimer)
	{
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}

// close layer when click-out
document.onclick = mclose; 

</script>
<% 
dim default_url
dim local_url
local_url = Request.ServerVariables("LOCAL_ADDR")

if local_url = "172.29.64.7" then
	default_url = "http://172.29.64.7:88/"
else
	default_url = "http://www.yamahamusic.com.au/"
end if
%>
<table width="100%" cellpadding="0" cellspacing="0">
  <tr>
    <td background="http://www.yamahamusic.com.au/dealers/images/extHeader.jpg" height="68">&nbsp;</td>
  </tr>
  <tr>
    <td height="22" bgcolor="#FFFFFF"><table cellpadding="0" cellspacing="0" width="100%" bgcolor="#000">
        <tr>
          <td nowrap="nowrap"><table cellpadding="0" cellspacing="0" style="font-size:8pt; color:#FFF" bgcolor="#FFFFFF">
              <tr>
                <td nowrap="nowrap" height="22" style="white-space:nowrap"><ul id="sddm">
                    <li><a href="<%=default_url%>dealers/resources/default.asp">Home</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=1">Browse >> Guitars</a></li>
                   	<li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=2">VOX</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=3">Drums</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=4">Paiste</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=5">Professional Audio</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=6">Music Production</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=126">Steinberg</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=136">Commercial Audio</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=137">Best of Yamaha</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=search_items&categoryid=139">Tech Support</a></li>
                    <li><a href="<%=default_url%>dealers/resources/request.asp">Your Request</a></li>
                    <li><a href="<%=default_url%>dealers/resources/FAQs.pdf" target="_blank">FAQs</a></li>
                    <li><a href="<%=default_url%>dealers/resources/contacts.asp" target="_blank">Contacts</a></li>
                    <li><a href="mailto:marketinginfo@gmx.yamaha.com">Feedback</a></li>
                    <li><a href="<%=default_url%>dealers/resources/default.asp?action=user_logout">Log Out</a></li>
                  </ul></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" nowrap="nowrap" style="border-bottom-color:#f0edfb; border-bottom-style:solid; border-bottom-width:1px; padding-top:10px; padding-bottom:10px; padding-left:10px; font-size:11px;">Your Location &nbsp;<img src="<%=default_url%>images/icons/iconArrowStraight.gif" border="0" />&nbsp; Dealer Extranet</td>
        </tr>
      </table></td>
  </tr>
</table>
