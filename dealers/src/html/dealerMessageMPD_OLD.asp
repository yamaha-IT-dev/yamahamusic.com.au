<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Yamaha Connect - Your Request</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<script type="text/javascript" src="/utility.js"></script>
<style type="text/css" media="screen">
@import "/yamahamusic.css";
</style>
<style type="text/css" media="print">
@import "/yamahamusic.print.css";
</style>
<style type="text/css" media="screen">
@import "/yamahamusic.nav.css";
</style>
<style type="text/css" media="screen">
@import "yamahamusic.dealerextranet.css";
#message {
	float : left;
	margin : 0 20px 0 0;
}
#messageitems {
	float : left;
	width : 350px;
	padding : 0 10px 10px 10px;
}
p.whatsit {
	clear : both;
	margin : 0 0px 0 0;
}
div.thing {
	float : left;
}
a.remove {
	display : block;
	float:right;
}
</style>
</head>
<body>
<!--#include file="../../include/header.asp " -->
<table align="center" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" height="600" class="main_table">
  <tr>
    <td class="border_1">&nbsp;</td>
    <td class="border_2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" class="login_column"><h1>Request Items</h1>
      <% 
	if (message.length > 0) {
		%>
      <p class="alert"><%= message %></p>
      <%
	}
%>
      <form action="<%= CONTROLLER %>" method="post">
        <fieldset id="message">
          <input type="hidden" name="action" value="<%= SEND_MESSAGE %>">          
          <h2>Store Details - <font color="red">ONLY COMPLETE THIS PART BEFORE SUBMITTING!</font></h2>          
          <table width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr>
              <td>Store name<span class="mandatory">*</span>:</td>
              <td><input name="store_name" type="text" style="width:200px;" value="<%= M._getMessageStoreName() %>" maxlength="40" /></td>
            </tr>
            <tr>
              <td>Store address<span class="mandatory">*</span>:</td>
              <td><input name="store_address" type="text" style="width:250px;" value="<%= M._getMessageStoreAddress() %>" maxlength="30" /></td>
            </tr>
            <tr>
              <td>Suburb<span class="mandatory">*</span>:</td>
              <td><input name="store_suburb" type="text" style="width:100px;" value="<%= M._getMessageStoreSuburb() %>" maxlength="20" /></td>
            </tr>
            <tr>
              <td>State<span class="mandatory">*</span>:</td>
              <td><select name="store_state" style="width:200px;">
                  <option value="">Please select a state...</option>
                  <%
			for (var i=0; i < GBL_STATES_SHORT.length; i++) {
				%>
                  <option value="<%= GBL_STATES_SHORT[i] %>"<%= M._getMessageStoreState().indexOf(GBL_STATES_SHORT[i])==0?" selected=\"selected\"":"" %>><%= GBL_STATES_LONG[i] %></option>
                  <%
			}
		%>
                </select></td>
            </tr>
            <tr>
              <td>Postcode<span class="mandatory">*</span>:</td>
              <td><input name="store_postcode" type="text" style="width:50px;" value="<%= M._getMessageStorePostcode() %>" maxlength="5" /></td>
            </tr>
            <tr>
              <td>Contact person<span class="mandatory">*</span>:</td>
              <td><input name="name" type="text" style="width:150px;" value="<%= M._getMessageName() %>" maxlength="20" /></td>
            </tr>
            <tr>
              <td>Contact person's phone no<span class="mandatory">*</span>:</td>
              <td><input name="store_phone" type="text" style="width:100px;" value="<%= M._getMessageStorePhone() %>" maxlength="12" /></td>
            </tr>
            <tr>
              <td>Contact person's email<span class="mandatory">*</span>:</td>
              <td><input name="email" type="text" style="width:200px;" value="<%= M._getMessageEmail() %>" maxlength="40" /></td>
            </tr>
          </table>
          <hr />
          <p><strong>Notes</strong></p>
          <p><textarea name="message" rows="2" style="width:250px;"><%= M._getMessageMessage() %></textarea></p>
          <p>
            <input type="submit" name="submit" value="submit" />
          </p>
        </fieldset>
        <fieldset id="messageitems">
          <% 
	%>
          <%
	if (M._getMessageItems().length > 0) {
		%>
          <h2>Requested Items</h2>
          <p><strong>Please fill in quantity box once you are ready to submit</strong></p>
          <table width="400" class="noborder" cellpadding="0" cellspacing="0">
            <tr>
              <td width="20" valign="top"><table class="noborder" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><input name="quantity0" type="text" style="width:20px;" value="<%= M._getMessageQuantity0() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity1" type="text" style="width:20px;" value="<%= M._getMessageQuantity1() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity2" type="text" style="width:20px;" value="<%= M._getMessageQuantity2() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity3" type="text" style="width:20px;" value="<%= M._getMessageQuantity3() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity4" type="text" style="width:20px;" value="<%= M._getMessageQuantity4() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity5" type="text" style="width:20px;" value="<%= M._getMessageQuantity5() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity6" type="text" style="width:20px;" value="<%= M._getMessageQuantity6() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity7" type="text" style="width:20px;" value="<%= M._getMessageQuantity7() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity8" type="text" style="width:20px;" value="<%= M._getMessageQuantity8() %>" maxlength="5" /></td>
                  </tr>
                  <tr>
                    <td style="padding-top:5px;"><input name="quantity9" type="text" style="width:20px;" value="<%= M._getMessageQuantity9() %>" maxlength="5" /></td>
                  </tr>
                </table></td>
              <td width="380" valign="top"><%
		for (i = 0; i < M._getMessageItems().length; i++) {
			R._loadResource(M._getMessageItems()[i]);
			%>
                <p class="whatsit">
                  <input type="hidden" name="itemz" value="<%= i %>" />
                <div class="thing"><%= R._getResourceName() %></div>
                <a href="<%= CONTROLLER %>?action=<%= REMOVE_ITEM %>&amp;resourceid=<%= R._getResourceID() %>" class="remove"><img src="http://www.yamahamusic.com.au/dealers/images/icon_trash.png" /></a>
                </p>
                <br />
                <%

		}
		%></td>
            </tr>
          </table>
          <div class="clearing"></div>
          <p><strong>Looking for more?</strong></p>
          <p>You don't have to make this request <em>right now</em> you can<br/>
            <a href="default.asp">return to the homepage</a> and add more items if you wish.<br/>
            Unfortunately though, if you close your internet browser,<br/>
            your selection may be lost.</p>
          <%
	}

%>
        </fieldset>
      </form></td>
  </tr>
  <tr>
    <td class="border_3">&nbsp;</td>
    <td class="border_4">&nbsp;</td>
  </tr>
</table>
<!--#include file="../../include/footer.asp " -->
</body>
</html>