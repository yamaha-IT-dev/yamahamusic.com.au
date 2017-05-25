<% 

function Search() {
	this.searchterms = new Array();
	this.query = new String();
	this.catalogue = new String();
	this.resultset = null;
	this.resultresponse = new String();
	this.Q = Server.CreateObject("ixsso.Query");

	this._getResultResponse = _getResultResponse;
	this._getResultSet = _getResultSet;
	
	this._setQuery = _setQuery;
	this._setCatalogue = _setCatalogue;
	this._setSearchTerms = _setSearchTerms;

	this._doSearch = _doSearch;
	this._close = _close;
}


function _getResultResponse() 	{ return this.resultresponse; }
function _getResultSet() 		{ return this.resultset; }

function _setQuery(value) 		{ this.query = value; }
function _setCatalogue(value) 	{ this.catlogue = value; }
function _setSearchTerms(value) { this.searchterms = value; }


function _doSearch() {

	try {
	
		var additionalSearch = new String();
		var searchString = new String();

		if (new String(this.searchterms[0]).indexOf('undefined') < 0) {
			if (new String(this.searchterms[0]).length > 0) {
				searchString = "@all \'" + this.searchterms[0] + "\'";
			}
		}

		if (new String(this.searchterms[1]).indexOf('undefined') < 0 && new String(this.searchterms[1]).indexOf(' ') != 0) {
			if (new String(this.searchterms[0]).length > 0) {
				searchString += " & ";
			}
			searchString += "#vpath = *\\" + this.searchterms[1] + "\\*";
		} else {
			searchString += " & !#vpath = *\\common\\* & !#vpath = *\\images\\* & !#vpath = *\\_* & !#vpath *\\search\\* & !#vpath = *\\sitemap\\* & !#vpath = *.xml & !#vpath = *header.*";
		}
		searchString += " & !#vpath = *\\ssl\\* & !#vpath = *\\src\\* & !#vpath = *\\amp\\* & !#vpath = *\\resources\\* & !#vpath = *\\common\\* & !#vpath = *\\images\\* & !#vpath = *\\_* & !#vpath *\\search\\* & !#vpath = *\\sitemap\\* & !#vpath = *.csv & !#vpath = *.xls  & !#vpath = *.css & !#vpath = *.xml & !#vpath = *header.*";

// Response.Write(searchString);

			this.Q.Query = searchString ;
			this.Q.SortBy = "rank[d]";

			this.Q.DefineColumn("description (DBTYPE_WSTR) = d1b5d3f0-c0b3-11cf-9a92-00a0c908dbf1 description");

			this.Q.Columns = "DocTitle, vpath, filename, characterization, write";

			this.Q.Catalog = GBL_SEARCH_CATALOGUE;

		var rs = this.Q.CreateRecordSet("nonsequential");
			rs.PageSize = 10;

			this.resultset = rs;
			
			
	} catch(e) {
		this.resultresponse = e.description;
	}

	if (this.searchterms.length > 0) {
		if (this.resultset) {
			if (!this.resultset.EOF || !this.resultset.BOF) {
				//this.resultresponse = "Your search returned " + this.resultset.RecordCount + " document" + (this.resultset.RecordCount>1?"s":"") + " matching your search query '" + this.searchterms[0] + "'";
				this.resultresponse = this.resultset.RecordCount + " document" + (this.resultset.RecordCount>1?"s were":" was") + " found.";
				if (new String(this.searchterms[1]).indexOf('undefined') < 0) {
					//this.resultresponse += " pertaining to " + this.searchterms[1];
				}
			} else {
				this.resultresponse = "No documents were found matching your search query '<strong>" + this.searchterms[0] + "</strong>'";
				if (new String(this.searchterms[1]).indexOf('undefined') < 0) {
					this.resultresponse += " in " + this.searchterms[1];
				}
				this.resultset = null;
			}
		} else {
			this.resultresponse = "Sorry : " + this.resultresponse + "<br/>";// + this.Q.Query;
		}
	} else {
		this.resultresponse = "You need to enter at least one search term." + this.searchterms;
	}
}

function _close() {
	this.query = null;
	this.catalogue = null;
	this.resultset = null;
	this.resultresponse = null;
	this.Q = null;
}

%>