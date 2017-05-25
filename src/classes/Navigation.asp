<% 

function Navigation() {

	//this.strPage = new String(Request("page"));
	this.strPage = new String(Request.ServerVariables("PATH_INFO"));
	this.xmlPath = Server.MapPath("/") + "\\src\\xml\\sitestructure.xml";

//Response.Write(this.strPage);

	this.xmlDoc = Server.CreateObject("Msxml2.DOMDocument");
	this.xmlDoc.async = false;
	this.xmlDoc.resolveExternals = false;
	this.xmlDoc.preserveWhiteSpace = false;	
	this.xmlDoc.load(this.xmlPath);
	
	this._drawLeftNav = _drawLeftNav;
	this._drawTopNav = _drawTopNav;
	this._drawBreadCrumb = _drawBreadCrumb;
	this._drawStylesheet = _drawStylesheet;
	this._drawSitemap = _drawSitemap;
	this._drawProductNav = _drawProductNav;
}



function _drawLeftNav(objXML, curLevel, startLevel) {

	var root = objXML.documentElement;
	var level = String.fromCharCode(curLevel + 96);

	var blnTarget = curLevel >= startLevel?true:false;

	if (curLevel == startLevel) {
		%><h1><%= root.childNodes(0).xml %></h1><%
	}

	if (blnTarget) { %>
	<ul><% }	

	var objNav = root.getElementsByTagName("nav[@level = '" + level + "']");
	for (var i=0; i < objNav.length; i++) {

		var strHref = new String(objNav.item(i).childNodes(0).getAttribute("href"));
		var tmpClass = new String(objNav.item(i).getAttribute("class"));
		var strClass = tmpClass.indexOf("null")!=0?" class=\"" + tmpClass + "\"":"";

		if (this.strPage.indexOf(strHref)==0) {
			objNav.item(i).childNodes(0).setAttribute("style", "font-weight:bold;");
		}

		if (blnTarget) { %>
		<li<%= strClass %>><%= objNav.item(i).childNodes(0).xml %><% }

		
		var tmpXML = Server.CreateObject("Msxml2.DOMDocument");
			tmpXML.async = false;
			tmpXML.resolveExternals = false;

			tmpXML.loadXML(objNav.item(i).xml);

			woot = tmpXML.documentElement;

			var blnInHere = false;
			var nodelist = woot.selectNodes("//a");
			for (n = 0; n < nodelist.length; n++) {
				if (new String(nodelist.item(n).getAttribute("href")).indexOf(this.strPage) == 0) {
					blnInHere = true;
					break;
				}
			}

			nextLevel = String.fromCharCode(curLevel + 96 + 1);
			nextNav = woot.getElementsByTagName("nav[@level = '" + nextLevel + "']");

			if (nextNav.length > 0 && blnInHere) {
				this._drawLeftNav(tmpXML, curLevel+1, startLevel);
			}

		if (blnTarget) { %></li><% }
	}
	if (blnTarget) { %>
	</ul><% }
}


function _drawTopNav(objXML, intLevel) {
	var root = objXML.documentElement;
	level = String.fromCharCode(intLevel + 96);
	%><ul<%= intLevel==1?" id=\"nav\"":"" %>><%
	
	var objNav = root.getElementsByTagName("nav[@level = '" + level + "']");

	for (var i=0; i < objNav.length; i++) {

		var strTitle = objNav.item(i).childNodes(0).text;
		var strClass = new String(objNav.item(i).getAttribute("class"));
		var strHref = new String(objNav.item(i).childNodes(0).getAttribute("href"));
		var blnOn = this.strPage.indexOf(strHref)==0?true:false;
		var strBold = blnOn?" style=\"font-weight:bold;\"":"";
		var strClass = strClass.indexOf("null")!=0?" class=\"" + strClass + "\"":"";

		%><li<%= strClass %>><a href="<%= strHref %>"<%= strBold %>><%= strTitle  %></a><% 

		var tmpXML = Server.CreateObject("Msxml2.DOMDocument");
			tmpXML.async = false;
			tmpXML.resolveExternals = false;

			tmpXML.loadXML(objNav.item(i).xml);

			woot = tmpXML.documentElement;

			nextLevel = String.fromCharCode(intLevel + 96 + 1);
			nextNav = woot.getElementsByTagName("nav[@level = '" + nextLevel + "']");

			if (nextNav.length > 0 && intLevel <= 1) {
				this._drawTopNav(tmpXML, intLevel+1);
			}

		%></li>
		<%
	}
	%></ul><%
}

function _drawBreadCrumb(objXML, intLevel) {
	var root = objXML.documentElement;
	level = String.fromCharCode(intLevel + 96);

	var objNav = root.getElementsByTagName("nav[@level = '" + level + "']");
	for (var i=0; i < objNav.length; i++) {

		var strTitle = objNav.item(i).childNodes(0).text;
		var strHref = new String(objNav.item(i).childNodes(0).getAttribute("href"));
		var blnOn = this.strPage.indexOf(strHref)==0?true:false;
		var strBold = blnOn?" style=\"font-weight:bold;\"":"";

		
		var tmpXML = Server.CreateObject("Msxml2.DOMDocument");
			tmpXML.async = false;
			tmpXML.resolveExternals = false;

			tmpXML.loadXML(objNav.item(i).xml);

			woot = tmpXML.documentElement;
			var blnIn = new String(woot.xml).indexOf(this.strPage)>0?true:false;

			/*
				Differently from the other recursive nav functions we need to
				change the way we decide to keep recursing for the breadcrumb.
				Sometimes, some pages might share a common href to a central
				page (/warranty.asp) for instance, we need to create a breadcrumb
				for the first instance of this.
			*/
			if (blnIn) { 

				%><li><a href="<%= strHref %>"<%= strBold %>><%= strTitle %></a></li><%

				nextLevel = String.fromCharCode(intLevel + 96 + 1);
				nextNav = woot.getElementsByTagName("nav[@level = '" + nextLevel + "']");

				if (blnIn) {
					this._drawBreadCrumb(tmpXML, intLevel+1);
				}
				break;
			}
	}
}


function _drawStylesheet(objXML, intLevel) {
	var root = objXML.documentElement;
	level = String.fromCharCode(intLevel + 96);

	var objNav = root.getElementsByTagName("nav[@level = '" + level + "']");
	for (var i=0; i < objNav.length; i++) {

		var strHref = new String(objNav.item(i).childNodes(0).getAttribute("href"));
		var strStylesheet = objNav.item(i).getAttribute("stylesheet");
		var blnOn = this.strPage.indexOf(strHref)==0?true:false;
		var strBold = blnOn?" style=\"font-weight:bold;\"":"";

		
		var tmpXML = Server.CreateObject("Msxml2.DOMDocument");
			tmpXML.async = false;
			tmpXML.resolveExternals = false;

			tmpXML.loadXML(objNav.item(i).xml);

			woot = tmpXML.documentElement;
			var blnIn = new String(woot.xml).indexOf(this.strPage)>0?true:false;
			nextLevel = String.fromCharCode(intLevel + 96 + 1);
			nextNav = woot.getElementsByTagName("nav[@level = '" + nextLevel + "']");

			if (nextNav.length > 0 && (blnOn || blnIn)) {
				if (strStylesheet != null) {
					%><style type="text/css" media="screen">@import "<%= strStylesheet %>";</style><%
//Response.Write("<pre>" + strStylesheet + "</pre>");
				}
				this._drawStylesheet(tmpXML, intLevel+1);
			}
	}
}


function _drawSitemap(objXML, intLevel) {
	var root = objXML.documentElement;
	level = String.fromCharCode(intLevel + 96);

	%><ul>
	<%

	var objNav = root.getElementsByTagName("nav[@level = '" + level + "']");
	for (var i=0; i < objNav.length; i++) {

		var strTitle = objNav.item(i).childNodes(0).text;
		var strHref = new String(objNav.item(i).childNodes(0).getAttribute("href"));

		%><li><a href="<%= strHref %>"><%= strTitle  %></a><%
		
		var tmpXML = Server.CreateObject("Msxml2.DOMDocument");
			tmpXML.async = false;
			tmpXML.resolveExternals = false;

			tmpXML.loadXML(objNav.item(i).xml);

			woot = tmpXML.documentElement;

			nextLevel = String.fromCharCode(intLevel + 96 + 1);
			nextNav = woot.getElementsByTagName("nav[@level = '" + nextLevel + "']");

			if (nextNav.length > 0) {
				this._drawSitemap(tmpXML, intLevel+1);
			}

		%></li>
		<%
	}
	%></ul>
	<%
}


function _drawProductNav(objXML, intLevel, targetLevel) {
	var root = objXML.documentElement;
	level = String.fromCharCode(intLevel + 96);

	var blnTarget = intLevel >= targetLevel?true:false;

	if (intLevel == targetLevel) {
		var strSection = root.childNodes(0).text
		var strHref = new String(root.childNodes(0).getAttribute("href"));
		%><h1>Our Products</h1><%
	}

	if (blnTarget) { %><ul><% }	

	var objNav = root.getElementsByTagName("nav[@level = '" + level + "']");
	for (var i=0; i < objNav.length; i++) {

		var strTitle = objNav.item(i).childNodes(0).text;
		var strHref = new String(objNav.item(i).childNodes(0).getAttribute("href"));
		var strTarget = new String(objNav.item(i).childNodes(0).getAttribute("target"));
			strTarget = strTarget.indexOf("null")!=0?" target=\"" + strTarget + "\" ":"";
		var strClass = new String(objNav.item(i).childNodes(0).getAttribute("class"));
			strClass = strClass.indexOf("null")!=0?" class=\"" + strClass + "\" ":"";
		var blnOn = this.strPage.indexOf(strHref)==0?true:false;
		var strBold = blnOn?" style=\"font-weight:bold;\"":"";

		if (blnTarget) { %><li><a href="<%= strHref %>"<%= strTarget %><%= strClass %><%= strBold %>><%= strTitle  %></a><% }
		
		var tmpXML = Server.CreateObject("Msxml2.DOMDocument");
			tmpXML.async = false;
			tmpXML.resolveExternals = false;

			tmpXML.loadXML(objNav.item(i).xml);

			woot = tmpXML.documentElement;
			var blnIn = new String(woot.xml).indexOf(this.strPage)>0?true:false;

			nextLevel = String.fromCharCode(intLevel + 96 + 1);
			nextNav = woot.getElementsByTagName("nav[@level = '" + nextLevel + "']");

			if (nextNav.length > 0 && (blnOn || blnIn)) {
				this._drawProductNav(tmpXML, intLevel+1, targetLevel);
			}

		if (blnTarget) { %></li><% }
	}
	if (blnTarget) { %></ul><% }
}


var Nav = new Navigation();


%>