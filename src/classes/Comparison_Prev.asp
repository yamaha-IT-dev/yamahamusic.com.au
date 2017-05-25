<% 

function Comparison(file) {

	this.category = null;
	this.property = null;
	this.models = new Array();
	this.file = file;
	this.path = Server.MapPath("./");
	this.comparisonset = null;
	this.conn;

	this._getComparisonCategory	= function() { return this.category; };
	this._getComparisonProperty	= function() { return this.property; };
	this._getComparisonModels 	= function() { return this.models; };

	this._setComparisonCategory	= function(value) { this.category = value; };
	this._setComparisonProperty	= function(value) { this.property = value; };
	this._setComparisonModels 	= function(value) { this.models = value; };

	this._loadModelList = function() {

		try
		{
			var str_conn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.path + ";Extended Properties=\"text;HDR=Yes;FMT=Delimited\"";
			//var str_conn = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + this.file + ";Extensions=asc,csv,tab,txt;"
			this.conn = Server.CreateObject("ADODB.Connection");
			this.conn.open(str_conn);		

			var str_sql = "SELECT TOP 1 * FROM " + this.file + "";
			this.comparisonset = this.conn.Execute(str_sql);

			for (i = 2; i < this.comparisonset.Fields.Count; i++) {
				this.models.push(this.comparisonset.Fields(i).Name);
			}

			this.models.sort()

		}
		catch(e)
		{
			Response.Write("everything's not kosher : " + e.description + "<br/>");
		}
	}


	this._loadComparisonSet = function(models) {
	
		this.models = models;

		try
		{
			var str_conn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.path + ";Extended Properties=\"text;HDR=Yes;FMT=Delimited\"";
			//var str_conn = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + this.file + ";Extensions=asc,csv,tab,txt;"
			this.conn = Server.CreateObject("ADODB.Connection");
			this.conn.open(str_conn);		

			var str_sql = "SELECT CATEGORY, PROPERTY, " + this.models + " FROM " + this.file + "";

			this.comparisonset = this.conn.Execute(str_sql);
			
		}
		catch(e)
		{
			Response.Write("everything's not kosher : " + e.description + "<br/>");
		}
	}

	
	this._drawComparisonSet = function() {
	
		if (this.comparisonset && !this.comparisonset.EOF) 
		{
			col_width = 100/(this.models.length+1)
			%><table cellpadding="0" cellspacing="0" border="0" class="avit-border" style="width:775;">
			<tr>
				<td style="width:<%= col_width %>%;">&nbsp;</td>
				<%
				for (var i = 0; i < this.models.length; i++) {
				%>
				<td style="width:<%= col_width %>%;"><strong><%= this.models[i] %></strong></td><%
				}
				%>
			</tr>
			<%
			var tmp_category = new String("");
			while (!this.comparisonset.EOF)
			{
				if (tmp_category.indexOf(this.comparisonset("category")) != 0) {
				%>
				<tr>
					<th colspan="<%= this.models.length+1 %>"><%= this.comparisonset("category") %></th>
				</tr>
				<%
					tmp_category = new String(this.comparisonset("category"));
				}

				%>
				<tr>
					<td class="property"><%= this.comparisonset("property") %></td>
					<%
					for (var i = 0; i < this.models.length; i++) {
						%><td><%= this.comparisonset(this.models[i]) %>&nbsp;</td><%
					}
					%>
				</tr>
				<%
				this.comparisonset.MoveNext();
			}
			%></table><%
		}
		else
		{
			%><p>Your comparison set is empty</p><%
		}
		
	
	
	}


	this._drawModelForm = function(models) {

		%>
		<form action="compare-previous.asp" method="post" style="width : 700px;">
			<fieldset>
				<legend>Choose the models you wish to compare</legend>
				
				<div style="border:1px #FFF solid;">
				
				<% 
				var count = 1;
				for (i = 0; i < this.models.length; i++)
				{	
					var checked = false;
					for (j = 0; j < models.length; j++) {
						if (this.models[i].indexOf(models[j]) == 0) {
							checked = true;
							break;
						}
					}
					%><div style="float:left;width:8em;padding-right:10px;">
						<input type="checkbox" name="models" value="<%= this.models[i] %>"<%= checked?" checked=\"checked\"":"" %>
							>&nbsp;<%= this.models[i] %></div><%
					if (count == 4)
					{
						%><div class="clearing"></div></div><div style="border:1px #FFF solid;"><%
						count = 0;
					}
					count++;
				}
				
				%><div class="clearing"></div></div>
				

			</fieldset>
			<p><input type="submit" name="submit" value="compare" class="button"/></p>
		</form><%
	
	
	}


	this._closeComparisonSet = function() {

		if (this.comparisonset) 
		{
			this.comparisonset.close();
			this.comparisonset = null;
		}
		if (this.conn)
		{
			this.conn.close();
			this.conn = null;
		}
	
	}


}



%>