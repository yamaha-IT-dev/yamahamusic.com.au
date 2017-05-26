<%
dim strSection
strSection = "booking"
%>
<!--#include file="../../include/connection.asp " -->
<!--#include file="../class/clsBooking.asp " -->
<!--#include file="../class/clsUser.asp " -->
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
<title>New Booking</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../../../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../../include/pikaday.css">
<link rel="stylesheet" href="../include/stylesheet.css">
<script src="//code.jquery.com/jquery.js"></script>
<script src="../include/jquery.validate.min.js"></script>
<script src="../include/additional-methods.min.js"></script>
<script src="../../bootstrap/js/bootstrap.js"></script>
<style>
    /* Override Bootstrap default */
    .btn-primary:active,
    .btn-primary.active {
        background-color: #285e8e;
    }
</style>
</head>
<body>
<!--#include file="../include/header_new.asp " -->
<%
Sub main
    Call validateLogin

    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        Dim reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy

        If Trim(Request("cboCategory")) <> "4" Then
            ' Populate variables with a regular booking
            reqCategory       = Server.HTMLEncode(Trim(Request("cboCategory")))
            reqName           = Server.HTMLEncode(Trim(Request("txtName")))
            reqType           = Server.HTMLEncode(Trim(Request("cboType")))
            reqTypeOther      = Server.HTMLEncode(Trim(Request("txtTypeOther")))
            reqAudience       = Server.HTMLEncode(Trim(Request("cboAudience")))
            reqVenue          = Server.HTMLEncode(Trim(Request("txtVenue")))
            reqProduct        = Server.HTMLEncode(Trim(Request("txtProduct")))
            reqDate           = Server.HTMLEncode(Trim(Request("txtDate")))
            reqTime           = Server.HTMLEncode(Trim(Request("txtTime")))
            reqDuration       = Server.HTMLEncode(Trim(Request("txtDuration")))
            reqOutcome        = Server.HTMLEncode(Trim(Request("txtOutcome")))
            reqStaff          = Server.HTMLEncode(Trim(Request("txtStaff")))
            reqPromote        = Server.HTMLEncode(Trim(Request("txtPromote")))
            reqAttendee       = Server.HTMLEncode(Trim(Request("txtAttendee")))
            reqEntryFee       = Server.HTMLEncode(Trim(Request("cboEntryFee")))
            reqEntryFeeCost   = Server.HTMLEncode(Trim(Request("txtEntryFeeCost")))
            reqBudget         = Server.HTMLEncode(Trim(Request("cboBudget")))
            reqGiveaway       = Server.HTMLEncode(Trim(Request("cboGiveaway")))
            reqProjector      = Server.HTMLEncode(Trim(Request("cboProjector")))
            reqScreen         = Server.HTMLEncode(Trim(Request("cboScreen")))
            reqBrochure       = Server.HTMLEncode(Trim(Request("cboBrochure")))
            reqStart          = Server.HTMLEncode(Trim(Request("txtStart")))
            reqComments       = Server.HTMLEncode(Trim(Request("txtComments")))
            reqCreatedBy      = Trim(Session("yma_userid"))
        Else
            ' Populate variables with a Product Training booking
            reqCategory       = Server.HTMLEncode(Trim(Request("cboCategory")))
            reqName           = ""
            reqType           = ""
            reqTypeOther      = NULL
            reqAudience       = ""
            reqVenue          = ""
            reqProduct        = ""
            reqDate           = Server.HTMLEncode(Trim(Request("txtDate")))
            reqTime           = Server.HTMLEncode(Trim(Request("txtTime")))
            reqDuration       = ""
            reqOutcome        = Server.HTMLEncode(Trim(Request("txtParticipants")))
            reqStaff          = ""
            reqPromote        = ""
            reqAttendee       = ""
            reqEntryFee       = 0
            reqEntryFeeCost   = NULL
            reqBudget         = 0
            reqGiveaway       = 0
            reqProjector      = 0
            reqScreen         = 0
            reqBrochure       = 0
            reqStart          = ""
            reqComments       = Server.HTMLEncode(Trim(Request("txtComments")))
            reqCreatedBy      = Trim(Session("yma_userid"))

            ' Build the reqName string (a CSV list of modules numbers e.g. '11,21,31') of modules selected
            If Request("keyboard-psre-module1") <> "" Then reqName = reqName + Request("keyboard-psre-module1") + "," End If
            If Request("keyboard-psre-module2") <> "" Then reqName = reqName + Request("keyboard-psre-module2") + "," End If
            If Request("keyboard-psre-module3") <> "" Then reqName = reqName + Request("keyboard-psre-module3") + "," End If
            If Request("keyboard-psrs-module1") <> "" Then reqName = reqName + Request("keyboard-psrs-module1") + "," End If
            If Request("keyboard-psrs-module2") <> "" Then reqName = reqName + Request("keyboard-psrs-module2") + "," End If
            If Request("keyboard-psrs-module3") <> "" Then reqName = reqName + Request("keyboard-psrs-module3") + "," End If
            If Request("keyboard-tyros-module1") <> "" Then reqName = reqName + Request("keyboard-tyros-module1") + "," End If
            If Request("keyboard-tyros-module2") <> "" Then reqName = reqName + Request("keyboard-tyros-module2") + "," End If
            If Request("keyboard-tyros-module3") <> "" Then reqName = reqName + Request("keyboard-tyros-module3") + "," End If
            If Request("digitalpiano-pseries-module1") <> "" Then reqName = reqName + Request("digitalpiano-pseries-module1") + "," End If
            If Request("digitalpiano-pseries-module2") <> "" Then reqName = reqName + Request("digitalpiano-pseries-module2") + "," End If
            If Request("digitalpiano-pseries-module3") <> "" Then reqName = reqName + Request("digitalpiano-pseries-module3") + "," End If
            If Request("digitalpiano-clavinova-module1") <> "" Then reqName = reqName + Request("digitalpiano-clavinova-module1") + "," End If
            If Request("digitalpiano-clavinova-module2") <> "" Then reqName = reqName + Request("digitalpiano-clavinova-module2") + "," End If
            If Request("digitalpiano-clavinova-module3") <> "" Then reqName = reqName + Request("digitalpiano-clavinova-module3") + "," End If
            If Request("digitalpiano-avantgrand-module1") <> "" Then reqName = reqName + Request("digitalpiano-avantgrand-module1") + "," End If
            If Request("digitalpiano-avantgrand-module2") <> "" Then reqName = reqName + Request("digitalpiano-avantgrand-module2") + "," End If
            If Request("digitalpianoarranger-dgx-module1") <> "" Then reqName = reqName + Request("digitalpianoarranger-dgx-module1") + "," End If
            If Request("digitalpianoarranger-dgx-module2") <> "" Then reqName = reqName + Request("digitalpianoarranger-dgx-module2") + "," End If
            If Request("digitalpianoarranger-dgx-module3") <> "" Then reqName = reqName + Request("digitalpianoarranger-dgx-module3") + "," End If
            If Request("digitalpianoarranger-clavinova-module1") <> "" Then reqName = reqName + Request("digitalpianoarranger-clavinova-module1") + "," End If
            If Request("digitalpianoarranger-clavinova-module2") <> "" Then reqName = reqName + Request("digitalpianoarranger-clavinova-module2") + "," End If
            If Request("digitalpianoarranger-clavinova-module3") <> "" Then reqName = reqName + Request("digitalpianoarranger-clavinova-module3") + "," End If
            If Request("pianohybrid-piano-module1") <> "" Then reqName = reqName + Request("pianohybrid-piano-module1") + "," End If
            If Request("pianohybrid-piano-module2") <> "" Then reqName = reqName + Request("pianohybrid-piano-module2") + "," End If
            If Request("pianohybrid-disklavier-module1") <> "" Then reqName = reqName + Request("pianohybrid-disklavier-module1") + "," End If
            If Request("pianohybrid-disklavier-module2") <> "" Then reqName = reqName + Request("pianohybrid-disklavier-module2") + "," End If
            If Request("pianohybrid-disklavier-module3") <> "" Then reqName = reqName + Request("pianohybrid-disklavier-module3") + "," End If

            'Delete the final comma
            If reqName <> "" Then
                reqName = LEFT(reqName, (LEN(reqName) - 1))
            End If
        End If

        Call addConnectRequest(reqCategory,reqName,reqType,reqTypeOther,reqAudience,reqVenue,reqProduct,reqDate,reqTime,reqDuration,reqOutcome,reqStaff,reqPromote,reqAttendee,reqEntryFee,reqEntryFeeCost,reqBudget,reqGiveaway,reqBrochure,reqProjector,reqScreen,reqStart,reqComments,reqCreatedBy)
    End If
End Sub

Call main
%>
<table align="center" cellpadding="0" cellspacing="0" class="main_table">
  <tr>
    <td class="main_content">
      <ol class="breadcrumb">
        <li><a href="../home/">Home</a></li>
        <li><a href="./">Booking</a></li>
        <li class="active">New Booking</li>
      </ol>
      <h1>New Booking</h1>
      <form method="post" name="form_request" id="form_request" action="new-booking.asp">
        <table border="0" cellpadding="5" cellspacing="0" class="main_form_table">
          <tr>
            <td width="25%">Category:</td>
            <td width="75%">
              <select name="cboCategory" id="cboCategory">
                <option value="1">Demonstrator</option>
                <option value="2">Event</option>
                <option value="3">Training</option>
                <option value="4">Product Training</option>
              </select>
            </td>
          </tr>
          <tr class="second">
            <td colspan="2"><h2>Keyboard, Digital &amp; Acoustic Piano Product Training Modules</h2></td>
          </tr>
          <tr class="second">
            <td colspan="2"><h3>Keyboard</h3></td>
          </tr>
          <tr class="second">
            <td>PSR-E / PSR-I / NP:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including Voices (sounds), Styles (accompaniments, rhythm), Songs (Preset songs), Song Recorder, Registrations (your Panel settings), Apps &amp; Interfaces, Other Functions" data-container="body">
                  <input type="checkbox" name="keyboard-psre-module1" value="11"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Voices (functions), Styles (functions, Expansion), Songs (functions, Song Lesson Y.E.S.), Song Recorder (Multi Track), Apps &amp; Interfaces (set up &amp; application), Other Functions" data-container="body">
                  <input type="checkbox" name="keyboard-psre-module2" value="12"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="keyboard-psre-module3" value="13"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td>PSR-S / PSR-A:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including Voices (sounds), Styles (accompaniments, rhythm), Songs (Preset songs), Song Recorder, Audio Files, Registrations (your Panel settings), Apps &amp; Interfaces, Microphone &amp; Vocal Harmony, Other Functions" data-container="body">
                  <input type="checkbox" name="keyboard-psrs-module1" value="21"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Voices (functions, edit, settings), Styles (functions, edit &amp; mixer, playback settings, Live Control Knobs, Expansion Packs, Style Creator), Songs (functions, score settings), Song Recorder (MIDI / Audio, Multi Track, Song Edit, Step Record, Audio Convert), Registrations (Edit, Sequence), Apps &amp; Interfaces (set up &amp; application, Wireless LAN), Other Functions" data-container="body">
                  <input type="checkbox" name="keyboard-psrs-module2" value="22"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="keyboard-psrs-module3" value="23"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td>Tyros:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including Voices (sounds), Styles (accompaniments, rhythm), Songs (Preset songs), Song Recorder, Audio Files, Registrations (your Panel settings), Apps &amp; Interfaces, Microphone &amp; Vocal Harmony, Other Functions" data-container="body">
                  <input type="checkbox" name="keyboard-tyros-module1" value="31"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Voices (functions, edit, settings), Styles (functions, edit &amp; mixer, playback settings, Expansion Packs, Style Creator), Songs (functions, score settings), Song Recorder (MIDI / Audio, Multi Track, Song Edit, Step Record, Audio Convert), Registrations (Edit, Sequence), Apps &amp; Interfaces (set up &amp; application, Wireless LAN), Other Functions" data-container="body">
                  <input type="checkbox" name="keyboard-tyros-module2" value="32"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="keyboard-tyros-module3" value="33"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td colspan="2"><h3>Digital Piano</h3></td>
          </tr>
          <tr class="second">
            <td>P-SERIES / YDP ARIUS:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including Voices (sounds), Styles (Piano &amp; Rhythm accompaniments), Songs (Preset songs), Song Recorder, Apps &amp; Interfaces, Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpiano-pseries-module1" value="41"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Voices (functions), Styles (functions), Songs (functions), Song Recorder (MIDI / Audio, Multi Track), Apps &amp; Interfaces (set up &amp; application), Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpiano-pseries-module2" value="42"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="digitalpiano-pseries-module3" value="43"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td>CLP CLAVINOVA:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including RGE, Voices (sounds), Styles (rhythm), Songs (Preset songs), Song Recorder, Audio Files, Apps &amp; Interfaces, Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpiano-clavinova-module1" value="51"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Voices (functions, edit, settings), Styles (functions, settings), Songs (functions, settings), Song Recorder (MIDI / Audio, Multi Track, Audio Convert), Apps &amp; Interfaces (set up &amp; application, Wireless LAN), Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpiano-clavinova-module2" value="52"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="digitalpiano-clavinova-module3" value="53"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td>AVANTGRAND:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including Voices, Songs (Preset songs), Song Recorder, Apps &amp; Interfaces, Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpiano-avantgrand-module1" value="61"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Participants demonstrate topics learnt in Module 1 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="digitalpiano-avantgrand-module2" value="62"> Module 2
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td colspan="2"><h3>Digital Piano Arranger</h3></td>
          </tr>
          <tr class="second">
            <td>DGX / YDP-V240:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including Piano Room, Voices (sounds), Styles (accompaniments, rhythm), Songs (Preset songs), Song Recorder, Registrations (your Panel settings), Apps &amp; Interfaces, Microphone, Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpianoarranger-dgx-module1" value="71"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Piano Room (settings), Voices (functions), Styles (functions, Expansion), Songs (functions, Song Lesson Y.E.S.), Song Recorder (Multi Track), Apps &amp; Interfaces (set up &amp; application), Microphone (Input &amp; FX), Pedal Assign, Other Functions." data-container="body">
                  <input type="checkbox" name="digitalpianoarranger-dgx-module2" value="72"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="digitalpianoarranger-dgx-module3" value="73"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td>CVP CLAVINOVA:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; Panel orientation including RGE, Piano Room, Voices (sounds), Styles (accompaniments, rhythm), Songs (Preset songs), Song Recorder, Audio Files, Registrations (your Panel settings), Apps &amp; Interfaces, Microphone &amp; Vocal Harmony, Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpianoarranger-clavinova-module1" value="81"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate Piano Room (record &amp; Audio Playback), Voices (functions, edit, settings), Styles (functions, edit &amp; Mixer, playback settings, Expansion Packs, Style Creator), Songs (functions, score settings, Guide), Song Recorder (MIDI / Audio, Multi Track, Song Edit, Step Record, Audio Convert), Registrations (Edit, Sequence), Apps &amp; Interfaces (set up &amp; application, Wireless LAN), Other Functions" data-container="body">
                  <input type="checkbox" name="digitalpianoarranger-clavinova-module2" value="82"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="digitalpianoarranger-clavinova-module3" value="83"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td colspan="2"><h3>Pianos &amp; Hybrids</h3></td>
          </tr>
          <tr class="second">
            <td>PIANO:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha 'Key Advantage' Level 1,  Model Range" data-container="body">
                  <input type="checkbox" name="pianohybrid-piano-module1" value="91"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Yamaha 'Key Advantage' Level 2, Model Range" data-container="body">
                  <input type="checkbox" name="pianohybrid-piano-module2" value="92"> Module 2
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td>DISKLAVIER:</td>
            <td>
              <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Introduction &amp; Overview (60 mins)" data-content="Yamaha Advantage, Series Model Range, Initialisation &amp; Demo button, General overview &amp; orientation including App controller &amp; Interface, Voices (sounds), Songs (Preset songs), Song Recorder, Silent System, Disklavier Radio, PianoSoft Audio, Other Functions" data-container="body">
                  <input type="checkbox" name="pianohybrid-disklavier-module1" value="101"> Module 1
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Intermediate (60 mins)" data-content="Revision of Module 1 (Q&amp;A), Intermediate App controller &amp; Interface (functions, Wi-Fi), Voices (settings), Songs (functions, settings), Song Recorder (USB Audio), Silent System (settings), Disklavier Radio (settings), PianoSoft Audio (settings), Remote Learning (functions, settings), Other Functions" data-container="body">
                  <input type="checkbox" name="pianohybrid-disklavier-module2" value="102"> Module 2
                </label>
                <label class="btn btn-primary" data-toggle="popover" data-trigger="hover" data-placement="right" title="Advanced (60 mins)" data-content="Revision of Module 2 (Q&amp;A), Participants demonstrate topics learnt in Module 1 &amp; 2 in a sales setting to communicate their understanding and learn tools to cover customer questions and objections." data-container="body">
                  <input type="checkbox" name="pianohybrid-disklavier-module3" value="103"> Module 3
                </label>
              </div>
            </td>
          </tr>
          <tr class="second">
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr class="first">
            <td>Activity name<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtName" name="txtName" maxlength="80" size="40" required></td>
          </tr>
          <tr class="first">
            <td>Activity type:</td>
            <td>
              <select name="cboType" id="cboType">
                <option value="Clinic">Clinic</option>
                <option value="Concert">Concert</option>
                <option value="Demonstration">Demonstration</option>
                <option value="Keyboard Club">Keyboard Club</option>
                <option value="Keyboard Festival">Keyboard Festival</option>
                <option value="Product Launch">Product Launch</option>
                <option value="Shopping Centre Promo">Shopping Centre Promo</option>
                <option value="Sales Event Support">Sales Event Support</option>
                <option value="Staff Training">Staff Training</option>
                <option value="Consumer Support">Consumer Support</option>
                <option value="Other">Other</option>
              </select>
            </td>
          </tr>
          <tr class="type-other">
            <td align="right">Please specify<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtTypeOther" name="txtTypeOther" maxlength="40" size="30" required></td>
          </tr>
          <tr class="first">
            <td>Audience:</td>
            <td>
              <select name="cboAudience" id="cboAudience">
                <option value="Consumer">Consumer</option>
                <option value="Staff">Staff</option>
              </select>
            </td>
          </tr>
          <tr class="first">
            <td>Venue<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtVenue" name="txtVenue" maxlength="80" size="40" required></td>
          </tr>
          <tr class="first">
            <td>Products to be featured<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtProduct" name="txtProduct" maxlength="80" size="40" required></td>
          </tr>
          <tr>
            <td>Date<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtDate" name="txtDate" maxlength="10" size="10" required> <em>DD/MM/YYYY</em></td>
          </tr>
          <tr>
            <td>Time (of Demo/Event required)<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtTime" name="txtTime" maxlength="10" size="10" required></td>
          </tr>
          <tr class="first">
            <td>Duration<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtDuration" name="txtDuration" required></td>
          </tr>
          <tr class="first">
            <td>Learning outcomes?<span class="mandatory">*</span></td>
            <td><input type="text" id="txtOutcome" name="txtOutcome" maxlength="120" size="100" required></td>
          </tr>
          <tr class="first">
            <td>Preferred Yamaha staff / artist<span class="mandatory">*</span>:</td>
            <td valign="top"><input type="text" id="txtStaff" name="txtStaff" required> <em>*Subject to availability</em></td>
          </tr>
          <tr class="first">
            <td>Promotional plan<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtPromote" name="txtPromote" maxlength="120" size="100" required></td>
          </tr>
          <tr class="first">
            <td>Expected number of attendees<span class="mandatory">*</span>:</td>
            <td><input type="text" id="txtAttendee" name="txtAttendee" maxlength="4" size="3" required> people</td>
          </tr>
          <tr class="first">
            <td>Entry fee?</td>
            <td>
              <select name="cboEntryFee" id="cboEntryFee">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
            </td>
          </tr>
          <tr class="entry-fee">
            <td align="right">If so, how much?<span class="mandatory">*</span></td>
            <td>$ <input type="text" id="txtEntryFeeCost" name="txtEntryFeeCost" maxlength="5" size="5" required></td>
          </tr>
          <tr class="first">
            <td>Budget?</td>
            <td>
              <select name="cboBudget" id="cboBudget">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
            </td>
          </tr>
          <tr class="first">
            <td>Give-aways?</td>
            <td>
              <select name="cboGiveaway" id="cboGiveaway">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
            </td>
          </tr>
          <tr class="first">
            <td>Brochures?</td>
            <td>
              <select name="cboBrochure" id="cboBrochure">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
            </td>
          </tr>
          <tr class="first">
            <td>Projector?</td>
            <td>
              <select name="cboProjector" id="cboProjector">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
            </td>
          </tr>
          <tr class="first">
            <td>Screen?</td>
            <td>
              <select name="cboScreen" id="cboScreen">
                <option value="0">No</option>
                <option value="1">Yes</option>
              </select>
            </td>
          </tr>
          <tr class="first">
            <td>When do you plan to start promoting the event?<span class="mandatory">*</span></td>
            <td><input type="text" id="txtStart" name="txtStart" maxlength="120" size="100" required></td>
          </tr>
          <tr class="second">
            <td>Participant Names (comma-seperated):</td>
            <td><textarea id="txtParticipants" name="txtParticipants" rows="4" cols="101"></textarea></td>
          </tr>
          <tr>
            <td>Comments:</td>
            <td><input type="text" id="txtComments" name="txtComments" maxlength="120" size="100"></td>
          </tr>
        </table>
        <br>
        <div class="form-group">
          <input type="hidden" name="action" />
          <input type="submit" name="submit" id="submit" value="Submit" />
        </div>
        <span class="mandatory">*</span> <em>Mandatory</em>
      </form>
    </td>
  </tr>
</table>
<script src="../../include/moment.js"></script>
<script src="../../include/pikaday.js"></script>
<script>
var picker = new Pikaday({
    field: document.getElementById('txtDate'),
    firstDay: 1,
    minDate: new Date('2014-05-01'),
    maxDate: new Date('2020-12-31'),
    yearRange: [2014,2020],
    format: 'DD/MM/YYYY'
});

$(function() {
    // Initial setup of elements visiblity
    toggleOnCategory();
    toggleOnActivity();
    toggleOnEntryFee();

    // When Category changes adjust element visibilty
    $("#cboCategory").change(function () {
        toggleOnCategory();
    });

    $("#cboType").change(function () {
        toggleOnActivity();
    });

    $("#cboEntryFee").change(function () {
        toggleOnEntryFee();
    });

    // Enable Bootstrap tooltips
    $('[data-toggle="popover"]').popover();

    // Enable jQuery Validation on form
    $("#form_request").validate({
        rules: {
            txtAttendee: {
                number: true
            },
            txtEntryFeeCost: {
                number: true
            },
            txtName: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtTypeOther: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtVenue: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtProduct: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtTime: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtDuration: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtOutcome: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtStaff: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtPromote: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtStart: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtComments: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            },
            txtParticipants: {
                pattern: /^[a-zA-Z0-9\s!?&/.,;:'()-]+$/
            }
        },
        messages: {
            txtName: {
                pattern: "Special characters are not allowed."
            },
            txtTypeOther: {
                pattern: "Special characters are not allowed."
            },
            txtVenue: {
                pattern: "Special characters are not allowed."
            },
            txtProduct: {
                pattern: "Special characters are not allowed."
            },
            txtTime: {
                pattern: "Special characters are not allowed."
            },
            txtDuration: {
                pattern: "Special characters are not allowed."
            },
            txtOutcome: {
                pattern: "Special characters are not allowed."
            },
            txtStaff: {
                pattern: "Special characters are not allowed."
            },
            txtPromote: {
                pattern: "Special characters are not allowed."
            },
            txtStart: {
                pattern: "Special characters are not allowed."
            },
            txtComments: {
                pattern: "Special characters are not allowed."
            },
            txtParticipants: {
                pattern: "Special characters are not allowed."
            }
        }
    });
});

// When Category is 'Product Training', show appropriate elements and vice versa
function toggleOnCategory() {
    if($("#cboCategory").val() != "4") {
        $(".first").show();
        $(".second").hide();
    }
    else {
        $(".first").hide();
        $(".second").show();
    }
}

function toggleOnActivity() {
    if($("#cboType").val() == "Other") {
        $(".type-other").show();
    }
    else {
        $(".type-other").hide();
    }
}

function toggleOnEntryFee () {
    if($("#cboEntryFee").val() == "1") {
        $(".entry-fee").show();
    }
    else {
        $(".entry-fee").hide();
    }
}
</script>
</body>
</html>