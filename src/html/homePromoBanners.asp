<div id="promoBanners">
<%

	var R = new Resource();
	var rsAllResources = R._getAllResourcesByType(GBL_TYPE_BANNER, 7, true);
	if (rsAllResources && !rsAllResources.EOF) {

		while (!rsAllResources.EOF) {

			var strLink = (new String(cleanForText(rsAllResources("link"))).length != 0 && new String(cleanForText(rsAllResources("link"))).indexOf("null") != 0)?cleanForText(cleanForText(rsAllResources("link"))):"read more...";
			var strURL = new String(cleanForText(rsAllResources("url"))).length != 0?cleanForSQL(cleanForText(rsAllResources("url"))):"/news/news.asp?action=view_item&amp;resourceid=" + cleanForText(rsAllResources("id"));
			var strBGColor = new String(cleanForText(rsAllResources("bgcolor"))).length != 0?"background-color:" + cleanForText(rsAllResources("bgcolor")) + ";":"";
			var strBGImage = new String(cleanForText(rsAllResources("filesrclg"))).length > 0?"background-image:url(" + cleanForText(rsAllResources("filesrclg")) + ");":"";

			%><div onclick="javascript:document.location.href='<%= strURL %>'" class="item" style="<%= strBGColor %><%= strBGImage %>">
				<h1><%= doBRTags(doBRTags(cleanForText(rsAllResources("title")))) %></h1>
					<%= doBRTags(doBRTags(cleanForText(rsAllResources("body")))) %>&nbsp;<a href="<%= strURL %>"><%= strLink %></a>
			</div><%

			rsAllResources.MoveNext();
		}

	}

%>
</div>