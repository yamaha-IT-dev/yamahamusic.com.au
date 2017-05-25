<% response.cookies("current_URL_cookie_gra") = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Querystring %>
<%
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "no-cache"
%>
<!--#include file="../include/connection.asp " -->
<!--#include file="../include/FRM_build_form.asp " -->
<!--#include file="../include/functions.asp " -->
<!--#include file="class/clsGRA.asp " -->
<!--#include file="class/clsUser.asp " -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Goods Return Authority - New Goods Return</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
<script type="text/javascript" src="../include/generic_form_validations.js"></script>
<script language="JavaScript" type="text/javascript">
function validateTermsConditions(fld) {
    var error = "";
 	if (!fld.checked) {
        fld.style.background = 'Yellow';
        error = "- You must accept our Terms and Conditions.\n"
    } else {
        fld.style.background = 'White';
    }
    return error;
}

function validateFormOnSubmit(theForm) {
	var reason = "";
	var blnSubmit = true;

	reason += validateEmptyField(theForm.txtSerialNo,"Serial No");
	reason += validateSpecialCharacters(theForm.txtSerialNo,"Serial No");
	reason += validateEmptyField(theForm.txtInvoiceNo,"Invoice No");
	reason += validateSpecialCharacters(theForm.txtInvoiceNo,"Invoice No");
	reason += validateDate(theForm.txtDatePurchased,"Date Purchased");
	reason += validateEmptyField(theForm.txtClaimNo,"Claim No");
	reason += validateSpecialCharacters(theForm.txtClaimNo,"Claim No");
	reason += validateEmptyField(theForm.txtQty,"No of Carton(s)");
	reason += validateSpecialCharacters(theForm.txtQty,"No of Carton(s)");
	reason += validateEmptyField(theForm.cboReason,"Reason");
	reason += validateEmptyField(theForm.txtFault,"Nature of fault");
	reason += validateEmptyField(theForm.txtTests,"Tests performed to verify fault");
	reason += validateEmptyField(theForm.cboAccessories,"Accessories complete");
	reason += validateEmptyField(theForm.cboPackaging,"Boxes");

  	if (reason != "") {
    	alert("Some fields need correction:\n" + reason);
		blnSubmit = false;
		return false;
  	}

	if (blnSubmit == true){
        theForm.Action.value = 'Update';
		return true;
    }
}

function submitComment(theForm) {
	var reason = "";
	var blnSubmit = true;

	reason += validateEmptyField(theForm.txtComment,"Comment");

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
'-----------------------------------------------
' GET GRA
'-----------------------------------------------
Sub getReturn

	dim intID
	intID = request("id")

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic

	strSQL = "SELECT GRA.*, "
	strSQL = strSQL & "	USR.username, USR.firstname, USR.lastname, USR.storename, USR.dealer_code, USR.branch, "
	strSQL = strSQL & "	USR.address, USR.city, USR.state, USR.postcode, USR.phone "
	strSQL = strSQL & "		FROM yma_gra GRA "
	strSQL = strSQL & "			LEFT JOIN tbl_users USR ON GRA.created_by = USR.user_id "
	strSQL = strSQL & "		WHERE created_by = " & session("UsrUserID") & " AND gra_id = " & intID

	rs.Open strSQL, conn

	'response.write strSQL

    if not DB_RecSetIsEmpty(rs) Then
		session("username") 			= rs("username")
		session("firstname") 			= rs("firstname")
		session("lastname") 			= rs("lastname")
		session("storename") 			= rs("storename")
		session("dealer_code") 			= rs("dealer_code")
		session("branch") 				= rs("branch")
		session("address") 				= rs("address")
		session("city") 				= rs("city")
		session("state") 				= rs("state")
		session("postcode") 			= rs("postcode")
		session("phone") 				= rs("phone")
		session("model_no") 			= rs("model_no")
		session("serial_no") 			= rs("serial_no")
		session("invoice_no") 			= rs("invoice_no")
		session("date_purchased") 		= rs("date_purchased")
		session("claim_no") 			= rs("claim_no")
		session("qty")		 			= rs("gra_qty")
		session("replacement_order_no") = rs("replacement_order_no")
		session("reason") 				= rs("reason")
		session("fault") 				= rs("fault")
		session("test_performed") 		= rs("test_performed")
		session("accessories") 			= rs("accessories")
		session("packaging") 			= rs("packaging")
		session("gra_no") 				= rs("gra_no")
		session("status") 				= rs("status")
		session("date_created") 		= rs("date_created")
		session("created_by") 			= rs("created_by")
		session("date_modified") 		= rs("date_modified")
		session("modified_by") 			= rs("modified_by")
		session("comments") 			= rs("comments")
		session("uploaded_filename") 	= rs("uploaded_filename")
    end if

    call CloseDataBase()

end sub
'-----------------------------------------------
' UPDATE GRA
'-----------------------------------------------
sub updateReturn
	dim strSQL
	dim intID
	intID = request("id")

	dim strSerialNo
	dim strInvoiceNo
	dim strDatePurchased
	dim strClaimNo
	dim strQty
	dim strOrderNo
	dim intReason
	dim strFault
	dim strTestsPerformed
	dim intAccessories
	dim intPackaging

	strSerialNo			= Replace(Request.Form("txtSerialNo"),"'","''")
	strInvoiceNo		= Replace(Request.Form("txtInvoiceNo"),"'","''")
	strDatePurchased 	= Request.Form("txtDatePurchased")
	strClaimNo			= Replace(Request.Form("txtClaimNo"),"'","''")
	strQty				= Replace(Request.Form("txtQty"),"'","''")
	strOrderNo			= Replace(Request.Form("txtOrderNo"),"'","''")
	intReason			= trim(request.form("cboReason"))
	strFault			= Replace(Request.Form("txtFault"),"'","''")
	strTests			= Replace(Request.Form("txtTests"),"'","''")
	intAccessories		= trim(request.form("cboAccessories"))
	intPackaging		= trim(request.form("cboPackaging"))

	Call OpenDataBase()

	strSQL = "UPDATE yma_gra SET "
	strSQL = strSQL & "serial_no = '" & server.htmlencode(strSerialNo) & "',"
	strSQL = strSQL & "invoice_no = '" & server.htmlencode(strInvoiceNo) & "',"
	strSQL = strSQL & "date_purchased = CONVERT(datetime,'" & strDatePurchased & "',103),"
	strSQL = strSQL & "claim_no = '" & server.htmlencode(strClaimNo) & "',"
	strSQL = strSQL & "gra_qty = '" & server.htmlencode(strQty) & "',"
	strSQL = strSQL & "replacement_order_no = '" & server.htmlencode(strOrderNo) & "',"
	strSQL = strSQL & "reason = '" & intReason & "',"
	strSQL = strSQL & "fault = '" & server.htmlencode(strFault) & "',"
	strSQL = strSQL & "test_performed = '" & server.htmlencode(strTests) & "',"
	strSQL = strSQL & "accessories = '" & intAccessories & "',"
	strSQL = strSQL & "packaging = '" & intPackaging & "',"
	strSQL = strSQL & "date_modified = getdate(),"
	strSQL = strSQL & "modified_by = '" & session("UsrUserID") & "' WHERE gra_id = " & intID

	'response.Write strSQL

	on error resume next
	conn.Execute strSQL

	if err <> 0 then
		strMessageText = err.description
	else
		strMessageText = "The record has been updated."
	end if

	Call CloseDataBase()
end sub

'-----------------------------------------------
' LIST COMMENTS
'-----------------------------------------------
sub listComments
    dim strSQL
	dim intID
	intID = request("id")

	dim strPageResultNumber
	dim strRecordPerPage
	dim intRecordCount

    call OpenDataBase()

	set rs = Server.CreateObject("ADODB.recordset")

	rs.CursorLocation = 3	'adUseClient
    rs.CursorType = 3		'adOpenStatic
	rs.PageSize = 200

	strSQL = "SELECT * FROM tbl_comments WHERE gra_id = " & intID & " ORDER BY comment_date"

	rs.Open strSQL, conn

	intPageCount = rs.PageCount
	intRecordCount = rs.recordcount

    strCommentsList = ""

	if not DB_RecSetIsEmpty(rs) Then

		For intRecord = 1 To rs.PageSize

			if trim(rs("comment_created_by")) = trim(session("UsrUserID")) then
				strCommentsList = strCommentsList & "<tr bgcolor=""#f8f8f8""><td style=""padding-left:40px"">"
			else
				strCommentsList = strCommentsList & "<tr><td>"
			end if
			strCommentsList = strCommentsList & " " & trim(rs("comments")) & "</td>"
			strCommentsList = strCommentsList & "<td>" & FormatDateTime(rs("comment_date"),1) & "</td>"
			if trim(rs("comment_created_by")) = trim(session("UsrUserID")) then
				strCommentsList = strCommentsList & "<td>you</td>"
			else
				strCommentsList = strCommentsList & "<td>Yamaha</td>"
			end if
			'strCommentsList = strCommentsList & "<td>" & rs("comment_created_by") & "</td>"
			strCommentsList = strCommentsList & "</tr>"

			rs.movenext

			If rs.EOF Then Exit For
		next
	else
        strCommentsList = "<tr><td colspan=""3"" align=""center"">&nbsp;</td></tr>"
	end if

	strCommentsList = strCommentsList & "<tr>"

    call CloseDataBase()
end sub

'-----------------------------------------------
' ADD COMMENTS
'-----------------------------------------------
sub addComments
	dim strSQL
	dim intID
	intID = request("id")

	dim strComment

	strComment		= Replace(Request.Form("txtComment"),"'","''")

	Call OpenDataBase()

	strSQL = "INSERT INTO tbl_comments (comments, gra_id, comment_date, comment_created_by) VALUES ("
	strSQL = strSQL & " '" & server.htmlencode(strComment) & "',"
	strSQL = strSQL & " '" & intID & "',"
	strSQL = strSQL & " getdate(),"
	strSQL = strSQL & " '" & session("UsrUserID") & "')"

	on error resume next
	conn.Execute strSQL

	if err <> 0 then
		strMessageText = err.description
	else
		Set JMail=CreateObject("JMail.SMTPMail")

		JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Subject		= "GRA: New comment has been posted (" & session("model_no") & ") by: " & session("storename") & ""
		JMail.Sender		= "AVsales-aus@music.yamaha.com"
		JMail.SenderName	= "Yamaha GRA"
		JMail.AddRecipient 		("AVsales-aus@music.yamaha.com")

		JMail.Body  	= "Hello Yamaha," & vbCrLf _
						& "" & vbCrLf _
						& "A comment has been posted to this GRA (" & session("model_no") & ") by " & session("storename") & " (" & session("branch") & ")" & vbCrLf _
						& " " & strComment & vbCrLf _
						& " " & vbCrLf _
						& "To reply to this comment, please click here: " & vbCrLf _
						& "http://intranet:78/update_gra.asp?id=" & intID & "" & vbCrLf _
						& " " & vbCrLf _
						& "This is an automated email, please do not reply to this email."

		'JMail.BodyFormat = 0
		'JMail.MailFormat = 0
		JMail.Execute

		set JMail = nothing

		strMessageText = "The comment has been sent to the Yamaha."
	end if

	Call CloseDataBase()
end sub

sub main
	call UTL_validateLogin
	call getReturn
	call listComments
	session("return_id") = request("id")

	select case trim(request("Action"))
		case "Update"
			call updateReturn
			call getReturn
		case "Add"
			call addComments
			call listComments
	end select
end sub

call main

dim strMessageText
dim strCommentsList
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" height="100%" class="main_content_table">
  <!-- #include file="include/header.asp" -->
  <tr>
    <td valign="top"><table border="0" width="100%" cellpadding="4" cellspacing="0">
        <tr>
          <td colspan="3" align="left"><div align="center"><font color="red"><%= strMessageText %></font></div>
            <h2 align="center">Update Goods Return</h2></td>
        </tr>
        <tr>
          <td colspan="3"><h3>1. Product details:</h3></td>
        </tr>
        <form action="" method="post" name="form_add_return" id="form_add_return" onsubmit="return validateFormOnSubmit(this)">
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><table width="100%" border="0" cellspacing="4" cellpadding="0">
                <tr>
                  <td width="20%">Model no<span class="mandatory">*</span>:</td>
                  <td width="80%"><%= session("model_no") %></td>
                </tr>
                <tr>
                  <td>Serial no<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtSerialNo" id="txtSerialNo" maxlength="30" size="35" value="<%= session("serial_no") %>" <% if session("status") = "0" then Response.Write "disabled" end if%> /></td>
                </tr>
                <tr>
                  <td>Yamaha invoice no<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtInvoiceNo" id="txtInvoiceNo" maxlength="30" size="35" value="<%= session("invoice_no") %>" <% if session("status") = "0" then Response.Write "disabled" end if%> /></td>
                </tr>
                <tr>
                  <td>Date purchased<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtDatePurchased" id="txtDatePurchased" maxlength="10" size="20" value="<%= session("date_purchased") %>" <% if session("status") = "0" then Response.Write "disabled" end if%> />
                    <em>DD/MM/YYYY</em></td>
                </tr>
                <tr>
                  <td>Claim no<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtClaimNo" id="txtClaimNo" maxlength="30" size="35" value="<%= session("claim_no") %>" <% if session("status") = "0" then Response.Write "disabled" end if%> /></td>
                </tr>
				<tr>
                  <td>No of Carton(s)<span class="mandatory">*</span>:</td>
                  <td><input type="text" name="txtQty" id="txtQty" maxlength="30" size="35" value="<%= session("qty") %>" <% if session("status") = "0" then Response.Write "disabled" end if%> /></td>
                </tr>
                <tr>
                  <td>Replacement order no:</td>
                  <td><input type="text" name="txtOrderNo" id="txtOrderNo" maxlength="30" size="35" value="<%= session("replacement_order_no") %>" <% if session("status") = "0" then Response.Write "disabled" end if%> /></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td colspan="3"><h3>2. Reason for return<span class="mandatory">*</span>:
                <select name="cboReason" <% if session("status") = "0" then Response.Write "disabled" end if%>>
                  <option value="">...</option>
                  <option <% if session("reason") = "1" then Response.Write " selected" end if%> value="1">1. Damaged In Transit / Dead On Arrival (Under 2 weeks old)</option>
                  <option <% if session("reason") = "2" then Response.Write " selected" end if%> value="2">2. Faulty - Display Model (Under 2 weeks old)</option>
                  <option <% if session("reason") = "3" then Response.Write " selected" end if%> value="3">3. Faulty - Customer Purchase (Under 2 months old)</option>
                  <option <% if session("reason") = "4" then Response.Write " selected" end if%> value="4">4. Faulty - 3rd Time (2 verified services by Authorised Yamaha Service Agent and within warranty period)</option>
                  <option <% if session("reason") = "5" then Response.Write " selected" end if%> value="5">5. Yamaha Sales Manager Nominates Return</option>
                </select>
              </h3></td>
          </tr>
          <tr>
            <td colspan="3"><h3>3. Describe nature of fault<span class="mandatory">*</span>:</h3></td>
          </tr>
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="90%" colspan="2"><textarea name="txtFault" id="txtFault" cols="90" rows="3" onkeydown="limitText(this.form.txtFault,this.form.countdown,300);"
onkeyup="limitText(this.form.txtFault,this.form.countdown,300);" <% if session("status") = "0" then Response.Write "disabled" end if%>><%= session("fault") %></textarea>
              <em>Max: 300 characters</em></td>
          </tr>
          <tr>
            <td colspan="3"><h3>4. Describe tests performed to verify fault<span class="mandatory">*</span>:</h3></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><textarea name="txtTests" id="txtTests" cols="90" rows="3" onkeydown="limitText(this.form.txtTests,this.form.countdown,300);"
onkeyup="limitText(this.form.txtTests,this.form.countdown,300);" <% if session("status") = "0" then Response.Write "disabled" end if%>><%= session("test_performed") %></textarea>
              <em>Max: 300 characters</em></td>
          </tr>
          <tr>
            <td colspan="3"><h3>5. Have you ensured that all accessories are complete?<span class="mandatory">*</span>
                <select name="cboAccessories" <% if session("status") = "0" then Response.Write "disabled" end if%>>
                  <option value="">...</option>
                  <option <% if session("accessories") = "1" then Response.Write " selected" end if%> value="1">Yes</option>
                  <option <% if session("accessories") = "0" then Response.Write " selected" end if%> value="0">No</option>
                </select>
              </h3></td>
          </tr>
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="45%"><em><strong>Please note that missing accessories will be charged as below:</strong></em></td>
            <td width="45%"><em><strong>Replacement cost (inc. GST)</strong></em></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Instruction Manual</td>
            <td>$15.00</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Remote Control</td>
            <td>$27.50</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Cables &amp; Interconnects</td>
            <td>$5.50</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ AM &amp; FM Antenna</td>
            <td>$5.50</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ YPAO / Intellibeam microphone</td>
            <td>$22.00</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>+ Admin fee</td>
            <td>$15.00</td>
          </tr>
          <tr>
            <td colspan="3"><h3>6. Please select one to indicate the following has been checked<span class="mandatory">*</span>:
                <select name="cboPackaging" <% if session("status") = "0" then Response.Write "disabled" end if%>>
                  <option value="">...</option>
                  <option <% if session("packaging") = "1" then Response.Write " selected" end if%> value="1">Original / suitable carton(s)</option>
                  <option <% if session("packaging") = "2" then Response.Write " selected" end if%> value="2">Original / suitable protective packaging</option>
                  <option <% if session("packaging") = "3" then Response.Write " selected" end if%> value="3">Once packed ensure cartons are properly sealed</option>
                </select>
              </h3></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><input type="hidden" name="Action" />
              <input type="submit" <% if session("status") = "0" then Response.Write "disabled" end if%> value="Update" /></td>
          </tr>
          <tr>
            <td colspan="3" align="center"><h3><img src="images/forward_arrow.gif" border="0" /> <a href="upload/<%= session("return_id") %>/<%= session("uploaded_filename") %>" target="_blank">View the receipt</a></h3></td>
          </tr>
        </form>
        <tr>
          <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="4" class="thin_border">
              <tr>
                <td colspan="2"><h3>7. Yamaha Internal Sales Comments:</h3></td>
              </tr>
              <tr>
                <td colspan="2"><%= session("comments") %></td>
              </tr>
              <tr>
                <td width="20%"><h3>8. Status:</h3></td>
                <td width="80%"><h3>
                    <% 	Select Case	session("status")
					case 1
						response.Write("Open")
					case 2
						response.Write("Processing")
					case 3
						response.Write("<font color=""red"">Rejected</font>")
					case 0
						response.Write("<font color=""green"">Approved</font>")
			 	end select
			 %>
                  </h3></td>
              </tr>
              <% if session("status") = 0 then %>
              <tr>
                <td><h3>9. GRA no:</h3></td>
                <td><h3><%= session("gra_no") %></h3></td>
              </tr>
              <% end if %>
            </table></td>
        </tr>
        <tr>
          <td colspan="3"><h3>Correspondence History:</h3>
            <table width="100%" border="0" cellspacing="0" cellpadding="4" class="thin_border_white">
              <tr bgcolor="#f0f0f0">
                <td width="80%"><strong>Message (This is for notifying Yamaha)</strong></td>
                <td width="10%"><strong>Date</strong></td>
                <td width="10%"><strong>By</strong></td>
              </tr>
              <%= strCommentsList %>
              <tr>
                <td valign="top"><form action="" method="post" onsubmit="return submitComment(this)">
                    <input type="text" name="txtComment" id="txtComment" maxlength="100" size="120" />
                    <input type="hidden" name="Action" />
                    <input type="submit" value="Send" />
                  </form></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
            <p><img src="images/backward_arrow.gif" width="6" height="12" border="0" /> <a href="home.asp">Back to Home</a></p></td>
        </tr>
      </table></td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>
