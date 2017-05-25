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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Yamaha Goods Return Authority - Print GRA</title>
<link rel="stylesheet" href="include/stylesheet.css" type="text/css" />
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

	'strSqlQuery = "SELECT GRA.*, USR.username, USR.firstname, USR.lastname, USR.storename, USR.dealer_code, USR.branch, USR.address, USR.city, USR.state, USR.postcode, USR.phone FROM yma_gra GRA LEFT JOIN tbl_users USR ON GRA.created_by = USR.user_id WHERE gra_id = " & intID
	strSqlQuery = "SELECT GRA.*, USR.username, USR.firstname, USR.lastname, USR.storename, USR.dealer_code, USR.branch, USR.address, USR.city, USR.state, USR.postcode, USR.phone FROM yma_gra GRA LEFT JOIN tbl_users USR ON GRA.created_by = USR.user_id WHERE created_by = " & session("UsrUserID") & "AND gra_id = " & intID
	
	rs.Open strSqlQuery, conn

	'response.write strSqlQuery

    if not DB_RecSetIsEmpty(rs) Then
		session("username") 	= rs("username")
		session("firstname") 	= rs("firstname")
		session("lastname") 	= rs("lastname")
		session("storename") 	= rs("storename")
		session("dealer_code") 	= rs("dealer_code")
		session("branch") 		= rs("branch")
		session("address") 		= rs("address")
		session("city") 		= rs("city")
		session("state") 		= rs("state")
		session("postcode") 	= rs("postcode")
		session("phone") 		= rs("phone")		
		session("model_no") 		= rs("model_no")
		session("serial_no") 		= rs("serial_no")
		session("invoice_no") 		= rs("invoice_no")
		session("date_purchased") 	= rs("date_purchased")
		session("claim_no") 		= rs("claim_no")
		session("replacement_order_no") = rs("replacement_order_no")
		session("reason") 			= rs("reason")
		session("fault") 			= rs("fault")
		session("test_performed") 	= rs("test_performed")
		session("accessories") 		= rs("accessories")
		session("packaging") 		= rs("packaging")
		session("gra_no") 			= rs("gra_no")
		session("status") 			= rs("status")
		session("date_created") 	= rs("date_created")
		session("created_by") 		= rs("created_by")
		session("date_modified") 	= rs("date_modified")
		session("modified_by") 		= rs("modified_by")
		session("comments") 		= rs("comments")
    end if

    call CloseDataBase()

end sub

sub main
	call UTL_validateLogin
	call getReturn
end sub

call main

dim strMessageText
%>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" align="center" height="100%" class="main_content_table">
  <tr>
    <td valign="top">
    <% if session("status") = 0 then %>
    <table border="0" width="100%" cellpadding="4" cellspacing="0">
        <tr>
          <td colspan="2" align="left"><p align="right"><% Response.Write WeekDayName(WeekDay(Date, vbLongDate)) & ", " & FormatDateTime(Date, vbLongDate) %></p>
          <h2 align="center">Yamaha Goods Return - Waiting for pick up</h2>
          <p align="center"><strong>(Please stick this print out onto the packaging box)</strong></p>
          <div align="right"><a href="javascript:window.print()">Print</a> <a href="javascript:window.print()"><img src="images/icon_printer.gif" alt="Printer Friendly" border="0" /></a></div>
            <h2 align="center">Status:
              <% Select Case session("status")
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
            </h2>
            </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><table width="90%" border="0" cellspacing="0" cellpadding="4" class="thin_border_white">
              <tr>
                <td colspan="2"><h2>Pick up details</h2></td>
              </tr>
              <tr>
                <td width="20%"><strong>GRA number:</strong></td>
                <td width="80%"><%= session("gra_no") %></td>
              </tr>
              <tr>
                <td><strong>Con note:</strong></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><strong>Expected pick up:</strong></td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><table width="90%" border="0" cellspacing="0" cellpadding="4" class="thin_border_white">
              <tr>
                <td colspan="2"><h2>Dealer details</h2></td>
              </tr>
              <tr>
                <td width="20%"><strong>Contact name:</strong></td>
                <td width="80%"><%= session("lastname") %>, <%= session("firstname") %> (<a href="mailto:<%= session("username") %>"><%= session("username") %></a>)</td>
              </tr>
              <tr>
                <td><strong>Dealer:</strong></td>
                <td><%= session("storename") %></td>
              </tr>
              <tr>
                <td><strong>Dealer code:</strong></td>
                <td><%= session("dealer_code") %></td>
              </tr>
              <tr>
                <td><strong>Branch:</strong></td>
                <td><%= session("branch") %></td>
              </tr>
              <tr>
                <td><strong>Address:</strong></td>
                <td><%= session("address") %></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><%= session("city") %>, <%= session("state") %>, <%= session("postcode") %></td>
              </tr>
              <tr>
                <td><strong>Phone:</strong></td>
                <td><%= session("phone") %></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td width="5%">&nbsp;</td>
          <td width="95%"><table width="90%" border="0" cellspacing="0" cellpadding="4" class="thin_border_white">
              <tr>
                <td colspan="2"><h2>Product details</h2></td>
              </tr>
              <tr>
                <td width="20%"><strong>Model no:</strong></td>
                <td width="80%"><%= session("model_no") %></td>
              </tr>
              <tr>
                <td><strong>Serial no:</strong></td>
                <td><%= session("serial_no") %></td>
              </tr>
              <tr>
                <td><strong>Yamaha invoice no:</strong></td>
                <td><%= session("invoice_no") %></td>
              </tr>
              <tr>
                <td><strong>Date purchased:</strong></td>
                <td><%= session("date_purchased") %></td>
              </tr>
              <tr>
                <td><strong>Claim no:</strong></td>
                <td><%= session("claim_no") %></td>
              </tr>
              <tr>
                <td><strong>Replacement order no:</strong></td>
                <td><%= session("replacement_order_no") %></td>
              </tr>
              <tr>
                <td><strong>Reason for return:</strong></td>
                <td><% if session("reason") = "1" then Response.Write "Damaged In Transit / Dead On Arrival (Under 2 weeks old)" end if%>
              <% if session("reason") = "2" then Response.Write "Faulty - Display Model (Under 2 weeks old)" end if%>
              <% if session("reason") = "3" then Response.Write "Faulty - Customer Purchase (Under 2 months old)" end if%>
              <% if session("reason") = "4" then Response.Write "Faulty - 3rd Time (2 verified services by Authorised Yamaha Service Agent and within warranty period)" end if%>
              <% if session("reason") = "5" then Response.Write "Yamaha Sales Manager Nominates Return" end if%></td>
              </tr>
              <tr>
                <td><strong>Comments:</strong></td>
                <td><%= session("comments") %></td>
              </tr>
            </table>            
            </td>
        </tr>
        <tr>
          <td colspan="2"><p><img src="images/backward_arrow.gif" width="6" height="12" border="0" /> <a href="home.asp">Back to Home</a></p></td>
        </tr>
      </table>
      <% else %>
      <h2>This GRA has not been approved yet.</h2>
      <p><a href="home.asp">Click here to go back to home</a>.</p>
      <% end if %>
      </td>
  </tr>
  <!-- #include file="include/footer.asp" -->
</table>
</body>
</html>