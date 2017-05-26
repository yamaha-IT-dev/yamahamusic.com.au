<div id="navigation">
<%

if (Session("yma_userid")) {

	var Cat = new Category();
	var rsAllCategories = Cat._getAllCategories(_DIVISION);

	if (rsAllCategories && !rsAllCategories.EOF) {
		
		while (!rsAllCategories.EOF) {
			
			rsAllCategories.MoveNext()
		}
		
	if (_DIVISION == "MPD")
	{
		
	}
	else if (_DIVISION == "TRAD")
	{
		%><%
	}

	}

}

%>

</div>