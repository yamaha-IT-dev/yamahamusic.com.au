<% strSection = "assessment"
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsAssessment.asp" -->
<!--#include file="class/clsList.asp" -->
<!--#include file="class/clsToken.asp" -->
<!--#include file="class/clsUser.asp" -->
<!--#include file="include/AntiFixation.asp" -->
<% AntiFixationVerify("default.asp") %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
	<script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<title>Skills Assessment - Yamaha Service Centre Portal</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<!--<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">-->
<script src="//code.jquery.com/jquery.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="../include/generic_form_validations.js"></script>
<script>
function validateQuestion(fld,errormsg) {
    var error = "";
	
    if ((fld[0].checked == false) && (fld[1].checked == false) && (fld[2].checked == false) && (fld[3].checked == false) && (fld[4].checked == false)) {
       error = "- " + errormsg + " is empty.\n"
    } 
    return error;
}

function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;

	reason += validateQuestion(theForm.rad1,"Question 1");
	reason += validateQuestion(theForm.rad2,"Question 2");
	reason += validateQuestion(theForm.rad3,"Question 3");
	reason += validateQuestion(theForm.rad4,"Question 4");
	reason += validateQuestion(theForm.rad5,"Question 5");
	reason += validateQuestion(theForm.rad6,"Question 6");
	reason += validateQuestion(theForm.rad7,"Question 7");
	reason += validateQuestion(theForm.rad8,"Question 8");
	reason += validateQuestion(theForm.rad9,"Question 9");
	reason += validateQuestion(theForm.rad10,"Question 10");
	reason += validateQuestion(theForm.rad11,"Question 11");	
	reason += validateQuestion(theForm.rad12,"Question 12");
	reason += validateQuestion(theForm.rad13,"Question 13");
	reason += validateQuestion(theForm.rad14,"Question 14");
	reason += validateQuestion(theForm.rad15,"Question 15");
	reason += validateQuestion(theForm.rad16,"Question 16");
	reason += validateQuestion(theForm.rad17,"Question 17");
	reason += validateQuestion(theForm.rad18,"Question 18");
	reason += validateQuestion(theForm.rad19,"Question 19");
	reason += validateQuestion(theForm.rad20,"Question 20");
	reason += validateQuestion(theForm.rad21,"Question 21");
	reason += validateQuestion(theForm.rad22,"Question 22");
	reason += validateQuestion(theForm.rad23,"Question 23");
	reason += validateQuestion(theForm.rad24,"Question 24");
	reason += validateQuestion(theForm.rad25,"Question 25");	

  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Add';
		return true;
    }
}
</script>
<%
sub main	
	if Request.ServerVariables("REQUEST_METHOD") = "POST" then
		if trim(request("Action")) = "Add" then
			call addAssessment
		end if
	else
		call UTL_validateLogin
		call getUserDetails(Session("UsrUserID"))
	end if
end sub

call main

dim strMessageText
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td class="maincontent"><h1>Skills Assessment</h1>
      <h2>Please rate your skill level from 1 to 5 based on the following criteria:</h2>
      <p>5 - Able to teach the subject to others as well as do it myself<br>
        4 - Know the subject well and can do it by myself<br>
        3 - Can do it by myself<br>
        2 - Can do it with support from others<br>
      1 - Unable to do it at all</p>
      <font color="red"><%= strMessageText %></font>
      <form action="" method="post" name="form_add" id="form_add" onsubmit="return validateFormOnSubmit(this)">        
        <table width="800" border="0" cellspacing="0" cellpadding="8">
          <tr>
            <td><h3>High level questions:</h3></td>
            <td><h1>1</h1></td>
            <td><h1>2</h1></td>
            <td><h1>3</h1></td>
            <td><h1>4</h1></td>
            <td><h1>5</h1></td>
          </tr>
          <tr>
            <td>1. Know and understand the terms used in technical specifications</td>
            <td><input type="radio" name="rad1" id="rad1" value="1" required /></td>
            <td><input type="radio" name="rad1" id="rad1" value="2" /></td>
            <td><input type="radio" name="rad1" id="rad1" value="3" /></td>
            <td><input type="radio" name="rad1" id="rad1" value="4" /></td>
            <td><input type="radio" name="rad1" id="rad1" value="5" /></td>
          </tr>
          <tr>
            <td>2. Know the limitations for each product based on their specifications and can confirm them</td>
            <td><input type="radio" name="rad2" id="rad2" value="1" required /></td>
            <td><input type="radio" name="rad2" id="rad2" value="2" /></td>
            <td><input type="radio" name="rad2" id="rad2" value="3" /></td>
            <td><input type="radio" name="rad2" id="rad2" value="4" /></td>
            <td><input type="radio" name="rad2" id="rad2" value="5" /></td>
          </tr>
          <tr>
            <td>3. Have a defined procedure for dealing with &quot;No Fault Found&quot; cases</td>
            <td><input type="radio" name="rad3" id="rad3" value="1" required /></td>
            <td><input type="radio" name="rad3" id="rad3" value="2" /></td>
            <td><input type="radio" name="rad3" id="rad3" value="3" /></td>
            <td><input type="radio" name="rad3" id="rad3" value="4" /></td>
            <td><input type="radio" name="rad3" id="rad3" value="5" /></td>
          </tr>
          <tr>
            <td>4. Can replace integrated circuits (ICs) on printed circuit boards</td>
            <td><input type="radio" name="rad4" id="rad4" value="1" required /></td>
            <td><input type="radio" name="rad4" id="rad4" value="2" /></td>
            <td><input type="radio" name="rad4" id="rad4" value="3" /></td>
            <td><input type="radio" name="rad4" id="rad4" value="4" /></td>
            <td><input type="radio" name="rad4" id="rad4" value="5" /></td>
          </tr>
          <tr>
            <td>5. Have a basic knowledge of music theory (chords, scales etc.)</td>
            <td><input type="radio" name="rad5" id="rad5" value="1" required /></td>
            <td><input type="radio" name="rad5" id="rad5" value="2" /></td>
            <td><input type="radio" name="rad5" id="rad5" value="3" /></td>
            <td><input type="radio" name="rad5" id="rad5" value="4" /></td>
            <td><input type="radio" name="rad5" id="rad5" value="5" /></td>
          </tr>
          <tr>
            <td>6. Can operate Yamaha products &amp; explain the differences between different models in the same range</td>
            <td><input type="radio" name="rad6" id="rad6" value="1" required /></td>
            <td><input type="radio" name="rad6" id="rad6" value="2" /></td>
            <td><input type="radio" name="rad6" id="rad6" value="3" /></td>
            <td><input type="radio" name="rad6" id="rad6" value="4" /></td>
            <td><input type="radio" name="rad6" id="rad6" value="5" /></td>
          </tr>
          <tr>
            <td>7. Able to trace faults to faults to the specific circuit board</td>
            <td><input type="radio" name="rad7" id="rad7" value="1" required /></td>
            <td><input type="radio" name="rad7" id="rad7" value="2" /></td>
            <td><input type="radio" name="rad7" id="rad7" value="3" /></td>
            <td><input type="radio" name="rad7" id="rad7" value="4" /></td>
            <td><input type="radio" name="rad7" id="rad7" value="5" /></td>
          </tr>
          <tr>
            <td colspan="6"><h3>Mid level questions:</h3></td>
          </tr>
          <tr>
            <td>8. Can set up a home network</td>
            <td><input type="radio" name="rad8" id="rad8" value="1" required /></td>
            <td><input type="radio" name="rad8" id="rad8" value="2" /></td>
            <td><input type="radio" name="rad8" id="rad8" value="3" /></td>
            <td><input type="radio" name="rad8" id="rad8" value="4" /></td>
            <td><input type="radio" name="rad8" id="rad8" value="5" /></td>
          </tr>
          <tr>
            <td>9. Know how to disassemble and re-assemble most repair units</td>
            <td><input type="radio" name="rad9" id="rad9" value="1" required /></td>
            <td><input type="radio" name="rad9" id="rad9" value="2" /></td>
            <td><input type="radio" name="rad9" id="rad9" value="3" /></td>
            <td><input type="radio" name="rad9" id="rad9" value="4" /></td>
            <td><input type="radio" name="rad9" id="rad9" value="5" /></td>
          </tr>
          <tr>
            <td>10. Can diagnose and repair to component level</td>
            <td><input type="radio" name="rad10" id="rad10" value="1" required /></td>
            <td><input type="radio" name="rad10" id="rad10" value="2" /></td>
            <td><input type="radio" name="rad10" id="rad10" value="3" /></td>
            <td><input type="radio" name="rad10" id="rad10" value="4" /></td>
            <td><input type="radio" name="rad10" id="rad10" value="5" /></td>
          </tr>
          <tr>
            <td>11. Have knowledge of common repair issues with Yamaha and can apply them</td>
            <td><input type="radio" name="rad11" id="rad11" value="1" required /></td>
            <td><input type="radio" name="rad11" id="rad11" value="2" /></td>
            <td><input type="radio" name="rad11" id="rad11" value="3" /></td>
            <td><input type="radio" name="rad11" id="rad11" value="4" /></td>
            <td><input type="radio" name="rad11" id="rad11" value="5" /></td>
          </tr>
          <tr>
            <td>12. Can replace circuit boards</td>
            <td><input type="radio" name="rad12" id="rad12" value="1" required /></td>
            <td><input type="radio" name="rad12" id="rad12" value="2" /></td>
            <td><input type="radio" name="rad12" id="rad12" value="3" /></td>
            <td><input type="radio" name="rad12" id="rad12" value="4" /></td>
            <td><input type="radio" name="rad12" id="rad12" value="5" /></td>
          </tr>
          <tr>
            <td>13. Understand circuit diagrams and how the circuits work</td>
            <td><input type="radio" name="rad13" id="rad13" value="1" required /></td>
            <td><input type="radio" name="rad13" id="rad13" value="2" /></td>
            <td><input type="radio" name="rad13" id="rad13" value="3" /></td>
            <td><input type="radio" name="rad13" id="rad13" value="4" /></td>
            <td><input type="radio" name="rad13" id="rad13" value="5" /></td>
          </tr>
          <tr>
            <td>14. Know how to use service jigs</td>
            <td><input type="radio" name="rad14" id="rad14" value="1" required /></td>
            <td><input type="radio" name="rad14" id="rad14" value="2" /></td>
            <td><input type="radio" name="rad14" id="rad14" value="3" /></td>
            <td><input type="radio" name="rad14" id="rad14" value="4" /></td>
            <td><input type="radio" name="rad14" id="rad14" value="5" /></td>
          </tr>
          <tr>
            <td>15. Able to repair damaged or broken circuit boards</td>
            <td><input type="radio" name="rad15" id="rad15" value="1" required /></td>
            <td><input type="radio" name="rad15" id="rad15" value="2" /></td>
            <td><input type="radio" name="rad15" id="rad15" value="3" /></td>
            <td><input type="radio" name="rad15" id="rad15" value="4" /></td>
            <td><input type="radio" name="rad15" id="rad15" value="5" /></td>
          </tr>
          <tr>
            <td>16. Can update software/firmware</td>
            <td><input type="radio" name="rad16" id="rad16" value="1" required /></td>
            <td><input type="radio" name="rad16" id="rad16" value="2" /></td>
            <td><input type="radio" name="rad16" id="rad16" value="3" /></td>
            <td><input type="radio" name="rad16" id="rad16" value="4" /></td>
            <td><input type="radio" name="rad16" id="rad16" value="5" /></td>
          </tr>
          <tr>
            <td>17. Understand the following terms; Decibel, Total Harmonic Distortion, Current, Voltage</td>
            <td><input type="radio" name="rad17" id="rad17" value="1" required /></td>
            <td><input type="radio" name="rad17" id="rad17" value="2" /></td>
            <td><input type="radio" name="rad17" id="rad17" value="3" /></td>
            <td><input type="radio" name="rad17" id="rad17" value="4" /></td>
            <td><input type="radio" name="rad17" id="rad17" value="5" /></td>
          </tr>
          <tr>
            <td>18. Can understand and follow a block diagram</td>
            <td><input type="radio" name="rad18" id="rad18" value="1" required /></td>
            <td><input type="radio" name="rad18" id="rad18" value="2" /></td>
            <td><input type="radio" name="rad18" id="rad18" value="3" /></td>
            <td><input type="radio" name="rad18" id="rad18" value="4" /></td>
            <td><input type="radio" name="rad18" id="rad18" value="5" /></td>
          </tr>
          <tr>
            <td colspan="6"><h3>Basic level questions:</h3></td>
          </tr>
          <tr>
            <td>19. Able to secure cables and fix them to prevent vibration</td>
            <td><input type="radio" name="rad19" id="rad19" value="1" required /></td>
            <td><input type="radio" name="rad19" id="rad19" value="2" /></td>
            <td><input type="radio" name="rad19" id="rad19" value="3" /></td>
            <td><input type="radio" name="rad19" id="rad19" value="4" /></td>
            <td><input type="radio" name="rad19" id="rad19" value="5" /></td>
          </tr>
          <tr>
            <td>20. Can use a signal tracer to locate faults</td>
            <td><input type="radio" name="rad20" id="rad20" value="1" required /></td>
            <td><input type="radio" name="rad20" id="rad20" value="2" /></td>
            <td><input type="radio" name="rad20" id="rad20" value="3" /></td>
            <td><input type="radio" name="rad20" id="rad20" value="4" /></td>
            <td><input type="radio" name="rad20" id="rad20" value="5" /></td>
          </tr>
          <tr>
            <td>21. Know how to set up and use an oscilloscope to trace faults</td>
            <td><input type="radio" name="rad21" id="rad21" value="1" required /></td>
            <td><input type="radio" name="rad21" id="rad21" value="2" /></td>
            <td><input type="radio" name="rad21" id="rad21" value="3" /></td>
            <td><input type="radio" name="rad21" id="rad21" value="4" /></td>
            <td><input type="radio" name="rad21" id="rad21" value="5" /></td>
          </tr>
          <tr>
            <td>22. Understand how to use a multimeter</td>
            <td><input type="radio" name="rad22" id="rad22" value="1" required /></td>
            <td><input type="radio" name="rad22" id="rad22" value="2" /></td>
            <td><input type="radio" name="rad22" id="rad22" value="3" /></td>
            <td><input type="radio" name="rad22" id="rad22" value="4" /></td>
            <td><input type="radio" name="rad22" id="rad22" value="5" /></td>
          </tr>
          <tr>
            <td>23. Can access and navigate YSISS (Yamaha Service Information Support System)</td>
            <td><input type="radio" name="rad23" id="rad23" value="1" required /></td>
            <td><input type="radio" name="rad23" id="rad23" value="2" /></td>
            <td><input type="radio" name="rad23" id="rad23" value="3" /></td>
            <td><input type="radio" name="rad23" id="rad23" value="4" /></td>
            <td><input type="radio" name="rad23" id="rad23" value="5" /></td>
          </tr>
          <tr>
            <td>24. Understand Service News and can apply them to the related unit(s)</td>
            <td><input type="radio" name="rad24" id="rad24" value="1" required /></td>
            <td><input type="radio" name="rad24" id="rad24" value="2" /></td>
            <td><input type="radio" name="rad24" id="rad24" value="3" /></td>
            <td><input type="radio" name="rad24" id="rad24" value="4" /></td>
            <td><input type="radio" name="rad24" id="rad24" value="5" /></td>
          </tr>
          <tr>
            <td>25. Can locate spare parts in the service manual and order using part number</td>
            <td><input type="radio" name="rad25" id="rad25" value="1" required /></td>
            <td><input type="radio" name="rad25" id="rad25" value="2" /></td>
            <td><input type="radio" name="rad25" id="rad25" value="3" /></td>
            <td><input type="radio" name="rad25" id="rad25" value="4" /></td>
            <td><input type="radio" name="rad25" id="rad25" value="5" /></td>
          </tr>
        </table>
        <input type="hidden" name="Action" />
        <input type="hidden" name="UserToken" value="<%= Session("user_token") %>" />
        <p><input type="submit" value="Submit" /></p>
      </form></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>