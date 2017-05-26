<%
dim strSection
strSection = "artwork"
%>
<!--#include file="../../include/connection.asp" -->
<!--#include file="../class/clsArtwork.asp" -->
<!--#include file="../class/clsUser.asp" -->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="../../js/html5shiv.js"></script>
  <script src="../../js/respond.js"></script>
<![endif]-->
<title>Update Artwork</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../include/pikaday.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<script src="../../include/generic_form_validations.js"></script>
<script src="../../include/usableforms.js"></script>
<script>
function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;
	  	
	reason += validateEmptyField(theForm.txtProjectName,"Project name");
	reason += validateSpecialCharacters(theForm.txtProjectName,"Project name");
	
	reason += validateEmptyField(theForm.txtPublication,"Publication");
	reason += validateSpecialCharacters(theForm.txtPublication,"Publication");
	
	reason += validateDate(theForm.txtDeadline,"Deadline");
	
	reason += validateDate(theForm.txtAppearance,"Appearance");
	
	//reason += validateEmail(theForm.txtDeliveryEmail);
	
	reason += validateEmptyField(theForm.txtAudience,"Audience");
	reason += validateSpecialCharacters(theForm.txtAudience,"Audience");
	
	reason += validateEmptyField(theForm.txtTheme,"Theme");
	reason += validateSpecialCharacters(theForm.txtTheme,"Theme");
	
	reason += validateEmptyField(theForm.txtMainColour,"Main Colours");
	reason += validateSpecialCharacters(theForm.txtMainColour,"Main Colours");
	
	reason += validateEmptyField(theForm.txtHeadline,"Headline");
	reason += validateSpecialCharacters(theForm.txtHeadline,"Headline");
		
	reason += validateEmptyField(theForm.txtFeature,"Feature");
	reason += validateSpecialCharacters(theForm.txtFeature,"Feature");
	
	reason += validateEmptyField(theForm.txtProduct,"Products");
	reason += validateSpecialCharacters(theForm.txtProduct,"Products");
	
	reason += validateEmptyField(theForm.txtTerms,"Terms and Conditions");
	reason += validateSpecialCharacters(theForm.txtTerms,"Terms and Conditions");
	
  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
    	
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.action.value = 'submit';
  		theForm.submit();
		
		return true;
    }
}
</script>
</head>
<body>
<!--#include file="../include/header_new.asp " -->
<%
sub main
	call validateLogin
		
	dim intID
	intID = Server.URLEncode(Request("id"))				
		
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("action")) = "submit" then
			Dim artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artComments, artTerms, artImages, artLogo, artCreatedBy
									
			artProjectName 	= Server.HTMLEncode(Trim(Request("txtProjectName")))
			artMediaType 	= Server.HTMLEncode(Trim(Request("cboMediaType")))
			artPublication 	= Server.HTMLEncode(Trim(Request("txtPublication")))
			artMediaName 	= Server.HTMLEncode(Trim(Request("txtMediaName")))
			artMediaPhone 	= Server.HTMLEncode(Trim(Request("txtMediaPhone")))				
			artMediaEmail 	= Server.HTMLEncode(Trim(Request("txtMediaEmail")))
			artDeadline 	= Server.HTMLEncode(Trim(Request("txtDeadline")))
			artAppearance 	= Server.HTMLEncode(Trim(Request("txtAppearance")))
			artAppearanceOther = Server.HTMLEncode(Trim(Request("txtAppearanceOther")))
			artPrinted 		= Server.HTMLEncode(Trim(Request("cboPrinted")))
			artDelivery 	= Server.HTMLEncode(Trim(Request("cboDelivery")))
			artType 		= Server.HTMLEncode(Trim(Request("cboType")))
			artColour 		= Server.HTMLEncode(Trim(Request("cboColour")))
			artSize 		= Server.HTMLEncode(Trim(Request("cboSize")))
			artWidth 		= Server.HTMLEncode(Trim(Request("txtWidth")))
			artHeight 		= Server.HTMLEncode(Trim(Request("txtHeight")))
			artPages 		= Server.HTMLEncode(Trim(Request("cboPages")))
			artOrientation 	= Server.HTMLEncode(Trim(Request("cboOrientation")))
			artAudience		= Server.HTMLEncode(Trim(Request("txtAudience")))
			artTheme 		= Server.HTMLEncode(Trim(Request("txtTheme")))
			artMainColour 	= Server.HTMLEncode(Trim(Request("txtMainColour")))
			artHeadline 	= Server.HTMLEncode(Trim(Request("txtHeadline")))
			artFeature 		= Server.HTMLEncode(Trim(Request("txtFeature")))
			artProduct 		= Server.HTMLEncode(Trim(Request("txtProduct")))				
			artTerms 		= Server.HTMLEncode(Trim(Request("txtTerms")))
			artComments 	= Server.HTMLEncode(Trim(Request("txtComments")))
			artImages 		= Server.HTMLEncode(Trim(Request("cboImages")))
			artLogo 		= Server.HTMLEncode(Trim(Request("cboLogo")))
			artCreatedBy 	= Trim(Session("yma_userid"))
			
			call updateConnectArtwork(intID, artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artTerms, artComments, artImages, artLogo, artCreatedBy)
		end if
	end if
		
	if isNumeric(intID) then
		call getArtwork(intID,Session("yma_userid"))
	else
		Response.Redirect("error.html")
	end if	
end sub

call main

dim strMessageText, intID
%>
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content"><ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Artwork</a></li>
        <li class="active">Update Artwork</li>
      </ol>
      <% if session("artwork_not_found") <> "TRUE" then %>
      <h1>Update Artwork ID = <%= Server.URLEncode(Request("id")) %></h1>
      <form method="post" name="form_add_participant" id="form_add_participant" onsubmit="return validateFormOnSubmit(this)">
        <table border="0" cellpadding="5" cellspacing="0" class="main_form_table">
          <tr>
            <td colspan="2" class="column_header">Media</td>
          </tr>
          <tr>
            <td width="30%">Project name<span class="mandatory">*</span>:</td>
            <td width="70%"><input type="text" id="txtProjectName" name="txtProjectName" maxlength="80" size="80" value="<%= session("artProjectName") %>" required /></td>
          </tr>
          <tr>
            <td>Media type:</td>
            <td><select name="cboMediaType" id="cboMediaType">
                <option value="Direct Mail" <% if session("artMediaType") = "Direct Mail" then Response.Write " selected" end if %> rel="none">Direct mail</option>
                <option value="Online" <% if session("artMediaType") = "Online" then Response.Write " selected" end if %> rel="none">Online</option>
                <option value="Outdoor" <% if session("artMediaType") = "Outdoor" then Response.Write " selected" end if %> rel="none">Outdoor</option>
                <option value="Magazine" <% if session("artMediaType") = "Magazine" then Response.Write " selected" end if %> rel="none">Print - Magazine</option>
                <option value="Newspaper" <% if session("artMediaType") = "Newspaper" then Response.Write " selected" end if %> rel="none">Print - Newspaper</option>
                <option value="Newsletter" <% if session("artMediaType") = "Newsletter" then Response.Write " selected" end if %> rel="none">Print - Newsletter</option>
                <option value="Radio" <% if session("artMediaType") = "Radio" then Response.Write " selected" end if %> rel="none">Radio</option>
                <option value="TV" <% if session("artMediaType") = "TV" then Response.Write " selected" end if %> rel="none">TV</option>
              </select></td>
          </tr>
          <tr>
            <td>Publication<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtPublication" name="txtPublication" maxlength="80" size="80" value="<%= session("artPublication") %>" required /></td>
          </tr>
          <tr>
            <td>Media's contact name:</td>
            <td><input type="text" id="txtMediaName" name="txtMediaName" maxlength="80" size="80" value="<%= session("artMediaName") %>" /></td>
          </tr>
          <tr>
            <td>Media's phone no:</td>
            <td><input type="text" id="txtMediaPhone" name="txtMediaPhone" maxlength="12" size="15" value="<%= session("artMediaPhone") %>" /></td>
          </tr>
          <tr>
            <td>Media's email:</td>
            <td><input type="email" id="txtMediaEmail" name="txtMediaEmail" maxlength="60" size="60" value="<%= session("artMediaEmail") %>" /></td>
          </tr>
          <tr>
            <td>Deadline<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtDeadline" id="txtDeadline" maxlength="10" size="10" value="<%= session("artDeadline") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Media appearance date<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtAppearance" id="txtAppearance" maxlength="10" size="10" value="<%= session("artAppearance") %>" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>If more than 1 appearance, please list:</td>
            <td><input type="text" id="txtAppearanceOther" name="txtAppearanceOther" maxlength="80" size="80" value="<%= session("artAppearanceOther") %>" /></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Delivery</td>
          </tr>
          <tr>
            <td>To be printed:</td>
            <td><select name="cboPrinted" id="cboPrinted">
                <option value="0" <% if session("artPrinted") = "0" then Response.Write " selected" end if %> rel="none">No</option>
                <option value="1" <% if session("artPrinted") = "1" then Response.Write " selected" end if %> rel="none">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Supply artwork as:</td>
            <td><select name="cboDelivery" id="cboDelivery">
                <option value="1" <% if session("artDelivery") = "1" then Response.Write " selected" end if %> rel="none">Quickcut</option>
                <option value="2" <% if session("artDelivery") = "2" then Response.Write " selected" end if %> rel="email">Print-optimised PDF (via email)</option>
                <option value="3" <% if session("artDelivery") = "3" then Response.Write " selected" end if %> rel="disk">Artwork (file on disk)</option>
              </select></td>
          </tr>
          <tr rel="email">
            <td>&nbsp;</td>
            <td><h3>Please note that this will be sent to your <u>registered email</u></h3></td>
          </tr>
          <tr rel="disk">
            <td>&nbsp;</td>
            <td><h3>Please note that this will be sent to your <u>registered address</u></h3></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Artwork</td>
          </tr>
          <tr>
            <td>Type:</td>
            <td><select name="cboType" id="cboType">
                <option value="Ad" <% if session("artType") = "Ad" then Response.Write " selected" end if %>>Advertisement</option>
                <option value="Indoor" <% if session("artType") = "Indoor" then Response.Write " selected" end if %>>Indoor banner</option>
                <option value="Outdoor" <% if session("artType") = "Outdoor" then Response.Write " selected" end if %>>Outdoor banner</option>
                <option value="Flyer" <% if session("artType") = "Flyer" then Response.Write " selected" end if %>>Flyer</option>
                <option value="Postcard" <% if session("artType") = "Postcard" then Response.Write " selected" end if %>>Postcard</option>
                <option value="Poster" <% if session("artType") = "Poster" then Response.Write " selected" end if %>>Poster</option>
                <option value="Price Tag" <% if session("artType") = "Price Tag" then Response.Write " selected" end if %>>Price tag</option>
                <option value="Swing Tag" <% if session("artType") = "Swing Tag" then Response.Write " selected" end if %>>Swing tag</option>
                <option value="Sticker" <% if session("artType") = "Sticker" then Response.Write " selected" end if %>>Sticker</option>
                <option value="Website" <% if session("artType") = "Website" then Response.Write " selected" end if %>>Website banner</option>
              </select></td>
          </tr>
          <tr>
            <td>Colour:</td>
            <td><select name="cboColour" id="cboColour">
                <option value="Full" <% if session("artColour") = "Full" then Response.Write " selected" end if %>>Full Colour</option>
                <option value="Mono" <% if session("artColour") = "Mono" then Response.Write " selected" end if %>>Mono (Black and White)</option>
                <option value="Quickcut" <% if session("artColour") = "Quickcut" then Response.Write " selected" end if %>>Quickcut</option>
                <option value="One Colour" <% if session("artColour") = "One Colour" then Response.Write " selected" end if %>>One Colour</option>
                <option value="Two Colour" <% if session("artColour") = "Two Colour" then Response.Write " selected" end if %>>Two Colour</option>
              </select></td>
          </tr>
          <tr>
            <td>Size:</td>
            <td><select name="cboSize" id="cboSize">
                <option value="A3" <% if session("artSize") = "A3" then Response.Write " selected" end if %> rel="none">A3</option>
                <option value="A4" <% if session("artSize") = "A4" then Response.Write " selected" end if %> rel="none">A4</option>
                <option value="A5" <% if session("artSize") = "A5" then Response.Write " selected" end if %> rel="none">A5</option>
                <option value="DL" <% if session("artSize") = "DL" then Response.Write " selected" end if %> rel="none">DL</option>
                <option value="Other" <% if session("artSize") = "Other" then Response.Write " selected" end if %> rel="other">Other</option>
              </select></td>
          </tr>
          <tr rel="other">
            <td>Width<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtWidth" name="txtWidth" maxlength="5" size="5" value="<%= session("artWidth") %>" />
              pixels</td>
          </tr>
          <tr rel="other">
            <td>Height<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtHeight" name="txtHeight" maxlength="5" size="5" value="<%= session("artHeight") %>" />
              pixels</td>
          </tr>
          <tr>
            <td>No of pages:</td>
            <td><select name="cboPages" id="cboPages">
                <option value="1" <% if session("artPages") = "1" then Response.Write " selected" end if %>>Single-sided</option>
                <option value="2" <% if session("artPages") = "2" then Response.Write " selected" end if %>>Double-sided</option>
              </select></td>
          </tr>
          <tr>
            <td>Orientation:</td>
            <td><select name="cboOrientation" id="cboOrientation">
                <option value="1" <% if session("artOrientation") = "1" then Response.Write " selected" end if %>>Portrait</option>
                <option value="2" <% if session("artOrientation") = "2" then Response.Write " selected" end if %>>Landscape</option>
              </select></td>
          </tr>
          <tr>
            <td colspan="2" class="column_header">Customised Artwork</td>
          </tr>
          <tr>
            <td width="30%">Target audience<span class="mandatory">*</span>:</td>
            <td width="70%"><input type="text" id="txtAudience" name="txtAudience" maxlength="80" size="80" value="<%= session("artAudience") %>" required /></td>
          </tr>
          <tr>
            <td>Theme (Look &amp; feel)<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtTheme" name="txtTheme" maxlength="80" size="80" value="<%= session("artTheme") %>" required />
              <em>(Eg. rock and roll / grunge feel)</em></td>
          </tr>
          <tr>
            <td>Main colours<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtMainColour" name="txtMainColour" maxlength="80" size="80" value="<%= session("artMainColour") %>" required /></td>
          </tr>
          <tr>
            <td>Headline<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtHeadline" name="txtHeadline" maxlength="80" size="80" value="<%= session("artHeadline") %>" required /></td>
          </tr>
          <tr>
            <td>Feature (Call to action)<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtFeature" name="txtFeature" maxlength="80" size="80" value="<%= session("artFeature") %>" required />
              <em>(Eg. Sale on now!)</em></td>
          </tr>
          <tr>
            <td>List the product codes &amp; the prices<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtProduct" name="txtProduct" maxlength="80" size="80" value="<%= session("artProduct") %>" required /></td>
          </tr>
          <tr>
            <td>Terms &amp; Conditions to be included<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtTerms" name="txtTerms" maxlength="120" size="110" value="<%= session("artTerms") %>" required /></td>
          </tr>
          <tr>
            <td>Comments:</td>
            <td><input type="text" id="txtComments" name="txtComments" maxlength="120" size="110" value="<%= session("artComments") %>" /></td>
          </tr>
          <tr>
            <td>Any other images to be included?<span class="mandatory">*</span></td>
            <td><select name="cboImages" id="cboImages">
                <option value="0" <% if session("artImages") = "0" then Response.Write " selected" end if %> rel="none">No</option>
                <option value="1" <% if session("artImages") = "1" then Response.Write " selected" end if %> rel="yes">Yes</option>
              </select></td>
          </tr>
          <tr rel="yes">
            <td colspan="2"><em>If yes, please email them to <a href="mailto:marketinginfo@gmx.yamaha.com">marketinginfo@gmx.yamaha.com</a> and specify that they are for this brief. Please quote the project name that you have given to this brief.</em></td>
          </tr>
          <tr>
            <td>Emailed your store logo to <a href="mailto:marketinginfo@gmx.yamaha.com">marketinginfo@gmx.yamaha.com</a>?<span class="mandatory">*</span></td>
            <td><select name="cboLogo" id="cboLogo">
                <option value="0" <% if session("artLogo") = "0" then Response.Write " selected" end if %> rel="no">No</option>
                <option value="1" <% if session("artLogo") = "1" then Response.Write " selected" end if %> rel="none">Yes</option>
              </select></td>
          </tr>
          <tr rel="no">
            <td colspan="2"><em>If no, please ensure you email your logo to <a href="mailto:marketinginfo@gmx.yamaha.com">marketinginfo@gmx.yamaha.com</a> and specify that it is for this brief. Please quote the project name that you have given to this brief. If we do not receive your logo, it will not be included in the artwork.</em></td>
          </tr>
        </table>
        <br>
        <div class="form-group">
          <input type="hidden" name="action" />
          <input type="submit" name="submit" id="submit" value="Save" />
        </div>
        <span class="mandatory">*</span> <em>Mandatory</em>
      </form>
      <%= strMessageText %>
      <% else %>
      <h1>Sorry but Artwork ID: <%= Server.URLEncode(Request("id")) %> cannot be found in the system.</h1>
      <% end if %></td>
  </tr>
</table>
<script type="text/javascript" src="../../include/moment.js"></script> 
<script type="text/javascript" src="../../include/pikaday.js"></script> 
<script type="text/javascript">
	var picker = new Pikaday(
    {
        field: document.getElementById('txtDeadline'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
	
	var picker = new Pikaday(
    {
        field: document.getElementById('txtAppearance'),
        firstDay: 1,
        minDate: new Date('2014-06-01'),
        maxDate: new Date('2020-12-31'),
        yearRange: [2014,2020],
		format: 'DD/MM/YYYY'
    });
</script>
</body>
</html>