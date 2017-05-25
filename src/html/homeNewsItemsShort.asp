<div id="newsItems">
	<h1>News &amp; Events</h1>
<%
	var R = new Resource();
	var rsAllResources = R._getAllResourcesByCategoryByType(2, GBL_TYPE_NEWS, true, 5);
	if (rsAllResources && !rsAllResources.EOF) {
		while (!rsAllResources.EOF) {
			%><div class="item">
			<h3><%= rsAllResources("title") %></h3><% 
			if (new String(rsAllResources("filesrcsm")).length > 0) {
				%><img src="<%= rsAllResources("filesrcsm") %>" alt="<%= rsAllResources("title") %>" title="<%= rsAllResources("title") %>"/><% 
			}
			%>
			<p><%= cleanForText(rsAllResources("extract")) %>&nbsp;<%
			var strLink = "read more...";
			if (new String(rsAllResources("link")).length != 0 && new String(rsAllResources("link")).indexOf("null") != 0) {
				strLink = cleanForText(rsAllResources("link"));
			}
			if (new String(rsAllResources("url")).length != 0) {
				%><a href="<%= rsAllResources("url") %>"><%= strLink %></a><% 
			} else {
				%><a href="/news/news.asp?action=view_item&amp;resourceid=<%= rsAllResources("id") %>"><%= strLink %></a><% 
			}
			%></p>
			</div><%
			rsAllResources.moveNext();
		}
	}

%>
</div>