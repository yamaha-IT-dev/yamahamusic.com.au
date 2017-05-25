<%

function Upload() {

	this.id = null;
	this.userid = null;
	this.filesrc = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this.CONN_XLS = null;
	this.RS_XLS = null;

	this._getUploadID = function()					{ return this.id; }
	this._getUploadUserID = function()				{ return this.userid; }
	this._getUploadFilesrc = function()				{ return this.filesrc; }
	this._getUploadDatecreated = function()			{ return this.datecreated; }
	this._getUploadDatemodified = function()		{ return this.datemodified; }

	this._getUploadConn = function()				{ return this.CONN_XLS; }
	this._getUploadRS = function()					{ return this.RS_XLS; }

	this._setUploadID = function(value)				{ this.id = value; }
	this._setUploadUserID = function(value)			{ this.userid = value; }
	this._setUploadFilesrc = function(value)		{ this.filesrc = value; }
	this._setUploadDatecreated = function(value)	{ this.datecreated = value; }
	this._setUploadDatemodified = function(value)	{ this.datemodified = value; }

	this._setUploadConn = function(value)			{ this.CONN_XLS = value; }
	this._setUploadRS = function(value)				{ this.RS_XLS = value; }

	this._loadUpload = function(id)
	{
		if (id) {
			try {
				var strSQL = "SELECT * FROM yma_resource WHERE id = " + id;
				var rs = GBL_CONN.Execute(strSQL);
			} catch(e) {
				Response.Write("Attempted Load : " + e.description + "<br/>" + strSQL);
				Response.Flush();
			}
			if (!rs.EOF) {
				this.id = new Number(rs("id"));
				this.userid = new Number(rs("userid"));
				this.filesrc = new String(rs("filesrc"));
				this.datecreated = new String(rs("datecreated"));
				this.datemodified = new String(rs("datemodified"));
			}
		}
	}


	this._addUpload = function()
	{
		var insertParams = "userid, filesrc, datecreated";
		var insertValues = "'" + this.userid + ", '" + this.filesrc + "', getdate()";

		try {
			var strSQL = "INSERT INTO yma_resource (" + insertParams + ") VALUES (" + insertValues + ")";
			GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Insert : " + e.description + "<br>" + strSQL);
			Response.Flush();
			//return;
		}

		var rs = GBL_CONN.Execute("SELECT @@IDENTITY");
			this.id = rs.Fields(0).value;

		rs.close();
		rs = null;

		return this.id;
	}


	this._saveUpload = function()
	{
		var updateStr = "userid = " + this.userid + ", " +
						"filesrc = '" + this.filesrc + "', " +
						"datemodified = GETDATE()";

		try {
			var strSQL = "UPDATE yma_resource SET " + updateStr + " WHERE id = " + this.id;
			GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
	}


	this._deleteUpload = function()
	{
		try {
			var strSQL = "DELETE FROM yma_resource WHERE id =  " + this.id;
			GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
	}


	this._parse = function(strpath, strfilename, SC)
	{
		var FSO = Server.CreateObject("Scripting.FileSystemObject");
		var strMapped = Server.MapPath("../" + strpath) + "\\" + strfilename;
		var arrClaims = new Array();
		var bobTheRecordSet = null;

// Response.Write(Server.MapPath("../" + strpath) + "/" + strfilename + "<br/>");

		var fileExists = FSO.FileExists(strMapped);

// Response.Write("strMapped = " + strMapped + "<br/>");

		if (fileExists)
		{

// Response.Write("File exists, opening document connection...<br/>");


			var xlsCONN = Server.CreateObject("ADODB.Connection");
				xlsCONN.Open("Driver={Microsoft Excel Driver (*.xls)};Dbq=" + strMapped);

			this.CONN_XLS = xlsCONN;

// Response.Write("Connection open, selecting...<br/>");

			var	bobTheRecordSet = Server.CreateObject("ADODB.Recordset");
				bobTheRecordSet.Open("SELECT * FROM [Claims$]", xlsCONN, 3, 2);


// Response.Write("Recordset Open, selection made...<br/>");

// Response.Write("EOF? : " + bobTheRecordSet.EOF + "<br/>");

// Response.Write("first column / row : " + bobTheRecordSet.Fields(0) + "<br/>");

// Response.Write("Oh God, something broke..." + e.description + "<br/>");


		}

		return bobTheRecordSet;
	}



	this._close_safely = function()
	{
		if (this.CONN_XLS && this.CONN_XLS.state == 1)
		{
			this.CONN_XLS.close();
			this.CONN_XLS = null;
		}
	}



}





function dateParse(str) {
	var arrstr = new String(str).split("/");

	var intDD = parseInt(arrstr[0]);
	var intMM = parseInt(arrstr[1]);
	var intYY = parseInt(arrstr[2]);

	var strDD = arrstr[0];
	var strMM = arrstr[1];
	var strYY = arrstr[2];

	if (isNaN(intDD) && isNaN(intMM) && isNaN(intYY)) {
		return false;
	} else {
//Response.Write("<span style='color:red;'>" + (intYY+2000) + "/" + GBLLZ(strMM, 2) + "/" + GBLLZ(strDD, 2) + " 00:00:00" + "</span>");

		var date = new Date((intYY+2000) + "/" + GBLLZ(strMM, 2) + "/" + GBLLZ(strDD, 2) + " 00:00:00");
		return date;
	}


}


%>

