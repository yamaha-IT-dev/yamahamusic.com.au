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
<title>New Artwork</title>
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
        theForm.Action.value = 'Add';
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
	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Add" then
			Dim artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artComments, artTerms, artImages, artLogo, artCreatedBy
									
			artProjectName 	= Server.HTMLEncode(Trim(Request("txtProjectName")))
			artMediaType 	= Server.HTMLEncode(Trim(Request("cboMediaType")))
			artPublication 	= Server.HTMLEncode(Trim(Request("txtPublication")))
			artMediaName 	= Server.HTMLEncode(Trim(Request("txtMediaName")))
			artMediaPhone 	= Server.HTMLEncode(Trim(Request("txtMediaPhone")))				
			artMediaEmail 	= Server.HTMLEncode(Trim(Request("txtMediaEmail")))
			artDeadline 	= Server.HTMLEncode(Trim(Request("txtDeadline")))
			artAppearance 	= Server.HTMLEncode(Trim(Request("txtAppearance")))
			artAppearanceOther 	= Server.HTMLEncode(Trim(Request("txtAppearanceOther")))
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
			'artLogo 		= Server.HTMLEncode(Trim(Request("cboLogo")))
			artCreatedBy 	= Trim(Session("yma_userid"))
			
			call addArtwork(artProjectName, artMediaType, artPublication, artMediaName, artMediaPhone, artMediaEmail, artDeadline, artAppearance, artAppearanceOther, artPrinted, artDelivery, artType, artColour, artSize, artWidth, artHeight, artPages, artOrientation, artAudience, artTheme, artMainColour, artHeadline, artFeature, artProduct, artTerms, artComments, artImages, artCreatedBy)
		end if
	end if	
end sub

call main
%>
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content">
      <ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Artwork</a></li>
        <li class="active">New Artwork</li>
      </ol>
      <h1>New Artwork</h1>      
      <form method="post" name="form_add_participant" id="form_add_participant" onsubmit="return validateFormOnSubmit(this)">        
        <table border="0" cellpadding="5" cellspacing="0" class="main_form_table">
          <tr>
            <td colspan="2" class="column_header">Media</td>
          </tr>
          <tr>
            <td width="30%">Project name<span class="mandatory">*</span>:</td>
            <td width="70%"><input type="text" id="txtProjectName" name="txtProjectName" maxlength="80" size="80" required /></td>
          </tr>
          <tr>
            <td>Media type:</td>
            <td><select name="cboMediaType" id="cboMediaType">
                <option value="Direct Mail" rel="none">Direct mail</option>
                <option value="Online" rel="none">Online</option>
                <option value="Outdoor" rel="none">Outdoor</option>
                <option value="Magazine" rel="none">Print - Magazine</option>
                <option value="Newspaper" rel="none">Print - Newspaper</option>
                <option value="Newsletter" rel="none">Print - Newsletter</option>
                <option value="Radio" rel="none">Radio</option>
                <option value="TV" rel="none">TV</option>
              </select></td>
          </tr>
          <tr>
            <td>Publication<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtPublication" name="txtPublication" maxlength="80" size="80" required /></td>
          </tr>
          <tr>
            <td>Media's contact name:</td>
            <td><input type="text" id="txtMediaName" name="txtMediaName" maxlength="80" size="80" /></td>
          </tr>
          <tr>
            <td>Media's phone no:</td>
            <td><input type="text" id="txtMediaPhone" name="txtMediaPhone" maxlength="12" size="15" /></td>
          </tr>
          <tr>
            <td>Media's email:</td>
            <td><input type="email" id="txtMediaEmail" name="txtMediaEmail" maxlength="60" size="60" /></td>
          </tr>
          <tr>
            <td>Deadline<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtDeadline" id="txtDeadline" maxlength="10" size="10" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Media appearance date<span class="mandatory">*</span>:</td>
            <td><input type="text" name="txtAppearance" id="txtAppearance" maxlength="10" size="10" required />
              <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>If more than 1 appearance, please list:</td>
            <td><input type="text" id="txtAppearanceOther" name="txtAppearanceOther" maxlength="80" size="80" /></td>
          </tr>        
          <tr>
            <td colspan="2" class="column_header">Delivery</td>
          </tr>
          <tr>
            <td>To be printed:</td>
            <td><select name="cboPrinted" id="cboPrinted">
                <option value="0" rel="none">No</option>
                <option value="1" rel="none">Yes</option>
              </select></td>
          </tr>
          <tr>
            <td>Supply artwork as:</td>
            <td><select name="cboDelivery" id="cboDelivery">
                <option value="1" rel="none">Quickcut</option>
                <option value="2" rel="email">Print-optimised PDF (via email)</option>
                <option value="3" rel="disk">Artwork (file on disk)</option>
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
                <option value="Ad">Advertisement</option>
                <option value="Indoor">Indoor banner</option>
                <option value="Outdoor">Outdoor banner</option>
                <option value="Flyer">Flyer</option>
                <option value="Postcard">Postcard</option>
                <option value="Poster">Poster</option>
                <option value="Price Tag">Price tag</option>
                <option value="Swing Tag">Swing tag</option>
                <option value="Sticker">Sticker</option>
                <option value="Website">Website banner</option>
              </select></td>
          </tr>
          <tr>
            <td>Colour:</td>
            <td><select name="cboColour" id="cboColour">               
                <option value="Full">Full Colour</option>
                <option value="Mono">Mono (Black and White)</option>
                <option value="Quickcut">Quickcut</option>
                <option value="One Colour">One Colour</option>
                <option value="Two Colour">Two Colour</option>
              </select></td>
          </tr>
          <tr>
            <td>Size:</td>
            <td><select name="cboSize" id="cboSize">
                <option value="A3" rel="none">A3</option>  
                <option value="A4" rel="none">A4</option>                              
                <option value="A5" rel="none">A5</option>               
                <option value="DL" rel="none">DL</option>
                <option value="Other" rel="other">Other</option>
              </select></td>
          </tr>
          <tr rel="other">
            <td>Width<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtWidth" name="txtWidth" maxlength="5" size="5" /> pixels</td>
          </tr>
          <tr rel="other">
            <td>Height<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtHeight" name="txtHeight" maxlength="5" size="5" /> pixels</td>
          </tr>
          <tr>
            <td>No of pages:</td>
            <td><select name="cboPages" id="cboPages">
                <option value="1">Single-sided</option>
                <option value="2">Double-sided</option>
              </select></td>
          </tr>
          <tr>
            <td>Orientation:</td>
            <td><select name="cboOrientation" id="cboOrientation">
                <option value="1">Portrait</option>
                <option value="2">Landscape</option>
              </select></td>
          </tr>        
          <tr>
            <td colspan="2" class="column_header">Customised Artwork</td>
          </tr>
          <tr>
            <td>Target audience<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtAudience" name="txtAudience" maxlength="80" size="80" required /></td>
          </tr>
          <tr>
            <td>Theme (Look &amp; feel)<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtTheme" name="txtTheme" maxlength="80" size="80" required />
              <em>(Eg. rock and roll / grunge feel)</em></td>
          </tr>
          <tr>
            <td>Main colours<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtMainColour" name="txtMainColour" maxlength="80" size="80" required /></td>
          </tr>
          <tr>
            <td>Headline<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtHeadline" name="txtHeadline" maxlength="80" size="80" required /></td>
          </tr>
          <tr>
            <td>Feature (Call to action)<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtFeature" name="txtFeature" maxlength="80" size="80" required />
              <em>(Eg. Sale on now!)</em></td>
          </tr>
          <tr>
            <td>List the product codes &amp; the prices<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtProduct" name="txtProduct" maxlength="80" size="80" required /></td>
          </tr>          
          <tr>
            <td>Terms &amp; Conditions to be included<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtTerms" name="txtTerms" maxlength="120" size="110" required /></td>
          </tr>
          <tr>
            <td>Comments:</td>
            <td><input type="text" id="txtComments" name="txtComments" maxlength="120" size="110" /></td>
          </tr>
          <tr>
            <td>Any other images to be included?<span class="mandatory">*</span></td>
            <td><select name="cboImages" id="cboImages">
                <option value="0" rel="none">No</option>
                <option value="1" rel="yes">Yes</option>
              </select></td>
          </tr>
          <tr rel="yes">
            <td colspan="2"><em>If so, do not forget to upload them once you have submitted this form by clicking &quot;<strong>Add Asset</strong>&quot;</em></td>
          </tr>
        </table>
        <br>
        <div class="form-group">
          <input type="hidden" name="Action" />
          <input type="submit" name="submit" id="submit" value="Submit" />
        </div>
        <span class="mandatory">*</span> <em>Mandatory</em>
        <p>Please note that you are able to upload files after submitting this form by clicking <button type="button" class="btn btn-primary">UPLOAD FILE &raquo;</button></p>
      </form></td>
  </tr>
</table>
<script src="../../include/moment.js"></script>
<script src="../../include/pikaday.js"></script>
<script>
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