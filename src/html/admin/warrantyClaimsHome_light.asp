<!--#include file="_gblHeader.asp"--> 
          <script language="javascript" type="text/javascript">

	function checkAllClaims()
	{
        var inputs = document.getElementsByTagName("input");

    	for (var i = 0; i < inputs.length; i++)
    	{
            var element = inputs[i];
            var e_name = new String(element.id);
            if (e_name.indexOf("claimid") == 0)
            {
                //element.setAttribute("checked", "checked");
                if (!element.checked)
                {
                    element.checked = true;
                }
                else
                {
                    element.checked = false;
                }
            }
    	}
	}

</script>
          <h1>Service Centres Warranty Claims (OPEN)</h1>
          <%

	if (rsClaims && !rsClaims.EOF) {

		var intRecordCount = rsClaims.RecordCount;
		var intStart = !isNaN(parseInt(Request("start")))?parseInt(Request("start")):0;
		var intPageSize = 100;
		var intCount = 0
		var intPageCount = Math.ceil(intRecordCount/intPageSize);
/*
Response.Write("intRecordCount = " + intRecordCount + "<br/>");
Response.Write("intStart = " + intStart + "<br/>");
Response.Write("intPageSize = " + intPageSize + "<br/>");
Response.Write("intCount = " + intCount + "<br/>");
Response.Write("intPageCount = " + intPageCount + "<br/>");
*/
		%>
          <p>Go to page :
            <%
		for (var i=0; i<intPageCount; i++) {
			var strBold = Math.floor(intStart/intPageSize)==i?" style=\"font-weight:bold;\"":"";
			if (Math.floor(intStart/intPageSize)!=i)
			{
				%>
            <a href="<%= CONTROLLER %>?start=<%= i*intPageSize %>"<%= strBold %>><%= i+1 %></a>&nbsp;&nbsp;
            <%
			}
			else
			{
				%>
            <strong><%= i+1 %></strong>&nbsp;&nbsp;
            <%
			}
		}
		if (Math.floor(intStart/intPageSize)+1 != intPageCount) {
			%>
            <a href="<%= CONTROLLER %>?start=<%= intStart+intPageSize %>">[next]</a>
            <%
		}
		%>
          </p>
          <%


		rsClaims.Move(intStart);

		%>
          <form action="<%= CONTROLLER %>" method="post">
            <input type="hidden" name="action" value="<%= MODIFY_MULTIPLE %>" />
            <input type="hidden" name="userid" value="<%= Session("yma_userid") %>" />
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="border">
              <tr>
                <th>&nbsp;</th>
                <th style="padding-right:0;"><a href="javascript:checkAllClaims();">All?</a></th>
                <th>Service Code</th>
                <th>Vendor Code</th>
                <th>Yamaha Claim #</th>
                <th>Vendor Claim #</th>
                <th>Received</th>
                <th>Completed</th>
                <th>Time to repair</th>
                <th>Labour $</th>
                <th>Parts $</th>
                <th>GST $</th>
                <th>Total $</th>
                <th>Model</th>
                <th>Status</th>
                <th>Created</th>
                <th>Modified</th>
                <th>&nbsp;</th>
              </tr>
              <%
		while (!rsClaims.EOF) {
			%>
              <tr>
                <td><%
				if (new String(rsClaims("status")).indexOf("CLOSED") != 0) {
					%>
                  <a href="<%= CONTROLLER %>?action=<%= EDIT_CLAIM %>&claimid=<%= rsClaims("id") %>" class="button">Edit</a>
                  <%
				} else {
					%>
                  &nbsp;
                  <%
				}
				%></td>
                <td style="text-align:center;"><%
				if (new String(rsClaims("status")).indexOf("CLOSED") != 0) {
					%>
                  <input type="checkbox" name="claimid" id="claimid_<%= rsClaims("id") %>" value="<%= rsClaims("id") %>" />
                  <%
				} else {
					%>
                  &nbsp;
                  <%
				}
				%></td>
                <td><a href="<%= CONTROLLER %>?action=<%= VIEW_CLAIM %>&claimid=<%= rsClaims("id") %>"><%= rsClaims("dealercode") %></a></td>
                <td><a href="<%= CONTROLLER %>?action=<%= VIEW_CLAIM %>&claimid=<%= rsClaims("id") %>"><%= rsClaims("vendorcode") %></a></td>
                <td><%
				if (new String(rsClaims("claimnumber")).length > 0 && new String(rsClaims("claimnumber")).indexOf("undefined") != 0) {
					%>
                  <strong><%= rsClaims("claimnumber") %></strong>
                  <%
				} else {
					%>
                  <span style="color:red;">Not yet assigned</span>
                  <%
				}
				%>
                  &nbsp;</td>
                <td><%
				if (new String(rsClaims("rctinumber")).length > 0)
				{
					%>
                  <%= rsClaims("rctinumber") %>
                  <%
				} else {
					%>
                  <%= rsClaims("invoicenumber") %>
                  <%
				}
				%></td>
                <td><%
					if (new String(rsClaims("datereceived")) != "null") {
						Response.Write(new Date(Date.parse(rsClaims("datereceived"))).formatDate("d/m/Y"));
					}
				%></td>
                <td><%
					if (new String(rsClaims("datecompleted")) != "null") {
						Response.Write(new Date(Date.parse(rsClaims("datecompleted"))).formatDate("d/m/Y"));
					}
				%></td>
                <td>
				<% if (rsClaims("repairdays") >= 20) {
	  			Response.Write("<font color=red>");
	  		}	 	  
	  %>
				<%= rsClaims("repairdays") %> days</td>
                <td style="text-align:right;"><% if (rsClaims("labourcharge") >= 80) {
	  			Response.Write("<font color=red>");
	  		}	 	  
	  %>
                  <%= parseFloat(rsClaims("labourcharge")).toFixed(2) %></td>
                <td style="text-align:right;"><% if (rsClaims("partscharge") >= 20) {
	  			Response.Write("<font color=red>");
	  		}	 	  
	  %>
                  <%= parseFloat(rsClaims("partscharge")).toFixed(2) %></td>
                <td style="text-align:right;"><%= parseFloat(rsClaims("gstcharge")).toFixed(2) %></td>
                <td style="text-align:right;font-weight:bold;"><%
					total = parseFloat(rsClaims("labourcharge")) + parseFloat(rsClaims("partscharge")) + parseFloat(rsClaims("gstcharge"));
				%>
                  <%= total.toFixed(2) %></td>
                <td><%= rsClaims("modelnumber") %></td>
                <td><%= rsClaims("status") %></td>
                <td><%
					if (new String(rsClaims("datecreated")) != "null") {
						Response.Write(new Date(Date.parse(rsClaims("datecreated"))).formatDate("d/m/Y"));
					}
				%></td>
                <td>&nbsp;
                  <%
					if (new String(rsClaims("datemodified")) != "null") {
						Response.Write(new Date(Date.parse(rsClaims("datemodified"))).formatDate("d/m/Y"));
					}
				%></td>                
                <td><a href="<%= CONTROLLER %>?action=<%= DELETE_CLAIM %>&claimid=<%= rsClaims("id") %>" onclick="return confirm('Are you sure you want to delete this claim?');"><img src="../images/btn_delete.gif" /></a></td>
              </tr>
              <%
			rsClaims.moveNext();
			intCount++;
			if (intCount == intPageSize) {
				break;
			}
		}
		%>
            </table>
            <fieldset style="border:1px solid #999;padding : 10px;">
              <legend style="font-weight:bold;">With selected claims</legend>
              <p style="font-size:1.6em;">Set status &raquo;
                <select name="status">
                  <option value="">choose...</option>
                  <%
						for (var i=0; i < GBL_WARRANTY_STATUS.length; i++) {
							%>
                  <option value="<%= GBL_WARRANTY_STATUS[i] %>"<%= WC._getClaimStatus() == GBL_WARRANTY_STATUS[i]?" selected=\"selected\"":"" %>><%= GBL_WARRANTY_STATUS[i] %></option>
                  <%
						}
				%>
                </select>
                &nbsp;&nbsp;
                and set repair code &raquo;
                <select name="repaircode">
                  <option value="">choose...</option>
                  <%
						for (var i=0; i < GBL_WARRANTY_REPAIRCODE_S.length; i++) {
							%>
                  <option value="<%= GBL_WARRANTY_REPAIRCODE_S[i] %>"<%= WC._getClaimRepaircode() == GBL_WARRANTY_REPAIRCODE_S[i]?" selected=\"selected\"":"" %>><%= GBL_WARRANTY_REPAIRCODE_S[i] %></option>
                  <%
						}
				%>
                </select>
                &nbsp;&nbsp;
                and assign claim number &nbsp;
                <input type="submit" name="submit" value="update claims &raquo;" class="button" style="display:inline;" />
              </p>
            </fieldset>
          </form>
          <%
	} else {
		%>
          <p>You have not yet made any online claims</p>
          <%
	}

%>
          <!--#include file="_gblFooter.asp"-->