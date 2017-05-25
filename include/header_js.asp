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
	background: #644196;
	color: #FFF;
	text-align: center;
	text-decoration: none;
	white-space:nowrap;
}
#sddm li a:hover {
	background: #4b1e78
}
#sddm div {
	position: absolute;
	visibility: hidden;
	margin: 0;
	padding: 0;
	background: #644196;
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
	background: #644196;
	color: #FFF;
	font: 11px arial;
	white-space:nowrap;
}
#sddm div a:hover {
	background: #4b1e78;
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
    <td background="http://www.yamahamusic.com.au/images/textures/headerGlobal.jpg" height="68">&nbsp;</td>
  </tr>
  <tr>
    <td height="22" bgcolor="#FFFFFF"><table cellpadding="0" cellspacing="0" width="100%" bgcolor="#644196">
        <tr>
          <td nowrap="nowrap"><table cellpadding="0" cellspacing="0" style="font-size:8pt; color:#FFF" bgcolor="#FFFFFF">
              <tr>
                <td nowrap="nowrap" height="22" style="white-space:nowrap"><ul id="sddm">
                    <li><a href="<%=default_url%>">Home</a></li>
                    <li><a href="<%=default_url%>shop/default.asp" onmouseover="mopen('m1')" onmouseout="mclosetime()">Shop</a>
                      <div id="m1" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"> <a href="<%=default_url%>shop/products.asp">Browse Products</a> <a href="<%=default_url%>shop/products.asp?action=search_items&amp;class=SALE">Sale Items</a> <a href="<%=default_url%>shop/cart.asp">Your Cart</a> <a href="<%=default_url%>shop/checkout.asp">Checkout</a> <a href="<%=default_url%>shop/help.asp">Help</a> <a href="<%=default_url%>shop/contact.asp">Contact Us</a></div>
                    </li>
                    <li><a href="<%=default_url%>products/av/">Audio Visual</a>
                      
                    </li>
                    <li><a href="<%=default_url%>products/musicalinstruments/default.asp" onmouseover="mopen('m3')" onmouseout="mclosetime()">Musical Instruments</a>
                      <div id="m3" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"><a href="<%=default_url%>products/musicalinstruments/bandorchestral/default.asp">Band &amp; Orchestral</a> <a href="<%=default_url%>products/musicalinstruments/digitalpianos/default.asp">Digital Pianos</a> <a href="<%=default_url%>products/musicalinstruments/pianos/hybrid/default.asp">Disklavier</a> <a href="<%=default_url%>products/musicalinstruments/drums/default.asp">Drums</a> <a href="http://www.paiste.com/">Paiste Cymbals</a> <a href="<%=default_url%>products/musicalinstruments/keyboards/default.asp">Home Keyboards</a> <a href="<%=default_url%>products/musicalinstruments/guitars/default.asp">Guitars</a> <a href="http://www.voxamps.com/" target="_blank">Vox</a> <a href="<%=default_url%>products/musicalinstruments/pianos/default.asp">Pianos</a> <a href="<%=default_url%>brochures/musical-instrument.asp">Brochures</a></div>
                    </li>
                    <li><a href="<%=default_url%>products/musicproduction/default.asp" onmouseover="mopen('m4')" onmouseout="mclosetime()">Music Production</a>
                      <div id="m4" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"><a href="<%=default_url%>products/musicproduction/synths/default.asp">Synthesizers</a> <a href="<%=default_url%>products/musicproduction/cmp/default.asp">Computer Music Products</a> <a href="http://www.steinberg.net/">Steinberg</a> <a href="<%=default_url%>products/musicalinstruments/cp-series/default.asp">Stage Pianos</a> <a href="<%=default_url%>products/musicproduction/audioworkstations/default.asp">Audio Workstations</a> <a href="<%=default_url%>products/musicproduction/controllers/default.asp">Controllers</a> <a href="<%=default_url%>products/musicproduction/accessories/default.asp">Accessories</a> <a href="<%=default_url%>products/musicproduction/cmp/cubase.asp">Cubase AI 4</a> <a href="<%=default_url%>products/musicproduction/steinberg/default.asp">Steinberg Support</a> <a href="<%=default_url%>brochures/music-production.asp">Brochures</a></div>
                    </li>
                    <li><a href="<%=default_url%>products/proaudio/default.asp" onmouseover="mopen('m5')" onmouseout="mclosetime()">Pro Audio</a>
                      <div id="m5" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"><a href="<%=default_url%>products/proaudio/artists.asp">Artists</a> <a href="<%=default_url%>products/proaudio/passive-mixers/default.asp">Passive Mixers</a> <a href="<%=default_url%>products/proaudio/powered-mixers/default.asp">Powered Mixers</a> <a href="<%=default_url%>products/proaudio/speakers/default.asp">Speakers</a> <a href="<%=default_url%>products/proaudio/studio-monitors/default.asp">Studio Monitors</a> <a href="<%=default_url%>products/proaudio/portable-sound/default.asp">Portable Sound</a> <a href="<%=default_url%>products/proaudio/effectsprocessors/default.asp">Effects Processors</a> <a href="<%=default_url%>products/proaudio/poweramps/default.asp">Power Amps</a> <a href="<%=default_url%>products/proaudio/mobile-recording/default.asp">Mobile Recording</a> <a href="<%=default_url%>products/proaudio/warranty.asp">Warranty</a> <a href="<%=default_url%>brochures/pro-audio.asp">Brochures</a></div>
                    </li>
                    <li><a href="<%=default_url%>products/commaudio/default.asp" onmouseover="mopen('m6')" onmouseout="mclosetime()">Commercial Audio</a>
                      <div id="m6" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"><a href="<%=default_url%>products/commaudio/news.asp">News</a> <a href="<%=default_url%>products/commaudio/digital-mixers/default.asp">Digital Mixers</a> <a href="<%=default_url%>products/commaudio/processors/default.asp">Digital Signal Processors</a> <a href="<%=default_url%>products/commaudio/effects/default.asp">Add-On Effects</a> <a href="<%=default_url%>products/commaudio/poweramps/default.asp">Power Amplifiers</a> <a href="<%=default_url%>products/commaudio/interfaces/default.asp">Interfaces</a> <a href="<%=default_url%>products/commaudio/speakers/default.asp">Installation Series Loudspeakers</a> <a href="<%=default_url%>products/commaudio/cards/default.asp">Mini-YGDAI Cards</a>
                        <nav level="b">
                        <a href="<%=default_url%>products/commaudio/alleasing/default.asp">Alleasing</a> <a href="<%=default_url%>brochures/commercial-audio.asp">Brochures</a></div>
                    </li>
                    <li><a href="<%=default_url%>artists/default.asp" onmouseover="mopen('m7')" onmouseout="mclosetime()">Artists</a>
                      <div id="m7" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"><a href="<%=default_url%>artists/pianos_keys.asp">Piano &amp; Keyboard</a> <a href="<%=default_url%>artists/drums/default.asp">Drums</a> <a href="<%=default_url%>artists/vox/default.asp">VOX</a> <a href="<%=default_url%>artists/keys-and-hitech/default.asp">Keys &amp; Hi-Tech</a> <a href="<%=default_url%>artists/strings.asp">Strings</a> <a href="<%=default_url%>artists/guitars/default.asp">Guitars</a> <a href="<%=default_url%>artists/brass_woodwind.asp">Brass &amp; Woodwind</a> <a href="<%=default_url%>artists/paiste/default.asp">Paiste</a></div>
                    </li>
                    <li><a href="http://www.yamahamusicschool.com.au/" onmouseover="mopen('m8')" onmouseout="mclosetime()">Education</a>
                      <div id="m8" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"><a href="<%=default_url%>education/teachers.asp" class="lock">Teacher Network</a></div>
                    </li>
                    <li><a href="<%=default_url%>dealers/default.asp" onmouseover="mopen('m9')" onmouseout="mclosetime()">Dealers</a>
                      <div id="m9" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"> <a href="<%=default_url%>dealers/default.asp">Dealer Locator</a> <a href="<%=default_url%>dealers/resources/default.asp">Dealer Login</a></div>
                    </li>
                    <li><a href="<%=default_url%>brochures">Brochures</a></li>
                    <li><a href="<%=default_url%>support/default.asp" onmouseover="mopen('m10')" onmouseout="mclosetime()">Service + Support</a>
                      <div id="m10" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"> <a href="<%=default_url%>support/search.asp">Locate a Service Centre</a> <a href="<%=default_url%>support/new_zealand.asp">For New Zealand customers</a> <a href="<%=default_url%>support/frequentrequests.asp">Frequent Support Requests</a> <a href="http://www.yamaha.co.jp/manual/english/" target="_blank">Online Owners Manuals</a> <a href="<%=default_url%>support/servicecentre.asp">Service Centres</a> <a href="<%=default_url%>support/regPPCEnquiry.asp">Piano Premium Care</a> <a href="<%=default_url%>products/musicproduction/steinberg/default.asp">Steinberg Support</a> <a href="<%=default_url%>support/firmware-update-65-series-receivers.asp">Firmware Update for 65 Series Receivers</a></div>
                    </li>
                    <li><a href="<%=default_url%>environment/default.asp" onmouseover="mopen('m11')" onmouseout="mclosetime()">Environment</a>
                      <div id="m11" onmouseover="mcancelclosetime()" onmouseout="mclosetime()"> <a href="<%=default_url%>environment/brass-and-woodwind.asp">Brass and Woodwind</a></div>
                    </li>
                    <li><a href="<%=default_url%>new-zealand.asp">For NZ</a></li>
                  </ul></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" nowrap="nowrap" style="border-bottom-color:#f0edfb; border-bottom-style:solid; border-bottom-width:1px; padding-top:10px; padding-bottom:10px; padding-left:10px; font-size:11px;">Your Location &nbsp;<img src="<%=default_url%>images/icons/iconArrowStraight.gif" border="0" />&nbsp; Commercial Audio</td>
        </tr>
      </table></td>
  </tr>
</table>
