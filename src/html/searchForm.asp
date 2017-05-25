<% 

	arrDir = new Array();

	arrDir.push(new Array("products", "Yamaha Products"));
	arrDir.push(new Array("artists", "Yamaha Artists"));

%>

<form name="searchForm" action="search.asp" method="POST">
  <fieldset>
    <p>
      <select name="SearchDirectory" id="SearchDirectory" style="font-size:1.8em;">
        <% 
	for (var i=0; i < arrDir.length; i++) { 
		%>
        <option value="<%= arrDir[i][0] %>" <%= new String(Request("SearchDirectory")).indexOf(arrDir[i][0])==0?" selected=\"selected\"":"" %> ><%= arrDir[i][1] %></option>
        <%
	}
%>
      </select>
      &nbsp;
      <input name="SearchTerms" id="SearchTerms" type="text" size="10" value="<%= Request("SearchTerms") %>" style="width:180px;font-size:1.8em;" />
      <input name="SearchButton" id="SearchButton" type="submit" value="Search" class="button" style="font-size:1.8em;" />
    </p>
    <p>Can't find it? Feel welcome to <a href="mailto:au_webmaster@gmx.yamaha.com">contact the webmaster</a> who can help you locate what you're looking for.</p>
  </fieldset>
</form>
