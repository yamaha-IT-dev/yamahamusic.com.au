<% 
	if (Session("yma_userid")) {	

		// Nav._drawBreadCrumb(Nav.xmlDoc, 1);

		var bcCatID = parseInt(Request("categoryid"));
		if (bcCatID > 0) {
			var Cat = new Category();
				Cat._loadCategory(bcCatID);
			%>
      <h1><%= Cat._getCategoryTitle() %></h1>
      <%
		}	

		var bcTypeID = parseInt(Request("typeid"));
		if (bcTypeID > 0) {
			var R = new Resource();
			var strType = R._getResourceTypeNameByID(bcTypeID);
			%>
      <h1><%= strType %></h1>
      <%
		}
	}
%>