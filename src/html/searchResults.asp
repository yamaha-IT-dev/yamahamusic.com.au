<% 

	var strSearchTerm = new String(Request("SearchTerms"));
	var strSearchDir = new String(Request("SearchDirectory"));
	var strPostSubmit = new String(Request.Form);
	var strGetSubmit = new String(Request.QueryString);

//Response.Write("Request.Form = " + Request.Form + "<br>");
//Response.Write("strSubmit = " + strSubmit + "<br>");

if (strPostSubmit.length > 0 && strPostSubmit.indexOf("undefined") < 0 || strGetSubmit.length > 0 && strGetSubmit.indexOf("undefined") < 0) {

	if ((strSearchTerm.length > 0 && strSearchTerm.indexOf("undefined") < 0) 
			|| (strSearchDir.length > 0 && strSearchDir.indexOf("undefined") < 0)) {

		var arrSearch = new Array(3);
			arrSearch[0] = strSearchTerm;
		
		if (strSearchDir.length > 0 && strSearchDir.indexOf("undefined") < 0) {
			arrSearch[1] = strSearchDir;
		}

		var S = new Search();
			S._setSearchTerms(arrSearch);
			S._doSearch();

		Response.Write("<h2>" + S._getResultResponse() + "</h2>");

		var rs = S._getResultSet();
		var pathtositeroot = new String(Server.MapPath("/")).toLowerCase();

		if (rs) { 
			%><div id="search-results"><%
			while (!rs.EOF) { 
				var p = new String(rs("vpath"));
				var dt = new String(rs("docTitle"));
					//dt = dt.substr(10, dt.length);

				%>
				<dl>
					<dt><a href="<%= p %>"><%= dt.indexOf("null")==0?"no title":dt %></a></dt>
					<dd>
							<%= new String(rs("characterization")).indexOf("null")==0?"":"" + rs("characterization") %>
							<br/><a href="<%= p %>"><%= new String(rs("vpath")) %></a>
							<%
								if (new String(rs("write")).indexOf("null")==0)
								{
									var date_modified = new Date(Date.parse(rs("write"))).dateFormat("jS M Y h:i a");
									%><br/><em>Last modified: <%= date_modified %></em><%
								}
							%>
					</dd>
				</dl>
				<%
				rs.MoveNext();
			} 
			%>
			</div><%
		}
		
		if (rs) { rs.Close(); rs = null; }
		if (S) 	{ S._close(); S = null; }
	} else {
		Response.Write("<p>You must enter a search term or at least choose a search topic.");
	}
} else {

%>
<!--	<p class="alert">You must enter some search terms</p> -->
<%

}



%>
