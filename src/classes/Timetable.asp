<% 

function Timetable() {

	this.id = null;
	this.status = null;
	this.centreid = null;
	this.courseid = null;
	this.term = 0;
	this.day = null;
	this.time = new String();
	this.datestart = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getTimetableID = _getTimetableID;
	this._getTimetableStatus = _getTimetableStatus;
	this._getTimetableCentreID = _getTimetableCentreID;
	this._getTimetableCourseID = _getTimetableCourseID;
	this._getTimetableTerm = _getTimetableTerm;
	this._getTimetableDay = _getTimetableDay;
	this._getTimetableTime = _getTimetableTime;
	this._getTimetableDatestart = _getTimetableDatestart;
	this._getTimetableDatecreated = _getTimetableDatecreated;
	this._getTimetableDatemodified = _getTimetableDatemodified;

	this._setTimetableID = _setTimetableID;
	this._setTimetableStatus = _setTimetableStatus;
	this._setTimetableCentreID = _setTimetableCentreID;
	this._setTimetableCourseID = _setTimetableCourseID;
	this._setTimetableTerm = _setTimetableTerm;
	this._setTimetableDay = _setTimetableDay;
	this._setTimetableTime = _setTimetableTime;
	this._setTimetableDatestart = _setTimetableDatestart;
	this._setTimetableDatecreated = _setTimetableDatecreated;
	this._setTimetableDatemodified = _setTimetableDatemodified;

	this._getTimetable = _getTimetable;
	this._getSelectedCourseByID = _getSelectedCourseByID;
	
	this._loadTimetable = _loadTimetable;
	this._addTimetable = _addTimetable;
	this._saveTimetable = _saveTimetable;
	this._deleteTimetable = _deleteTimetable;
}


function _getTimetableID()					{ return this.id; }
function _getTimetableStatus() 				{ return this.status; }
function _getTimetableCentreID()			{ return this.centreid; }
function _getTimetableCourseID()			{ return this.courseid; }
function _getTimetableTerm()				{ return this.term; }
function _getTimetableDay()					{ return this.day; }
function _getTimetableTime()				{ return this.time; }
function _getTimetableDatestart()			{ return this.datestart; }
function _getTimetableDatecreated()			{ return this.datecreated; }
function _getTimetableDatemodified()		{ return this.datemodified; }

function _setTimetableID(value)				{ this.id = value; }
function _setTimetableStatus(value)			{ this.status = value; }
function _setTimetableCentreID(value)		{ this.centreid = value; }
function _setTimetableCourseID(value)		{ this.courseid = value; }
function _setTimetableTerm(value)			{ this.term = value; }
function _setTimetableDay(value)			{ this.day = value; }
function _setTimetableTime(value)			{ this.time = value; }
function _setTimetableDatestart(value)		{ this.datestart = value; }
function _setTimetableDatecreated(value)	{ this.datecreated = value; }
function _setTimetableDatemodified(value)	{ this.datemodified = value; }


function _getTimetable(courseid, centreid, day, state, term) {
	
	var rs = null;

	var strTerm = term!=null&&term!=0?" AND ymec_timetable.term = " + term:"";
	var strCourse = courseid!=null?" AND ymec_timetable.courseid = " + courseid:"";
	var strCentre = centreid!=null?" AND ymec_timetable.centreid = " + centreid:"";
	var strDay = day!=null?" AND ymec_timetable.day = " + day:"";
	var strState = state.length!=0?" AND ymec_centre.state = '" + state + "'":"";

	var strSQL = "SELECT " +
		"	ymec_timetable.[id], " +
		"	ymec_timetable.[status], " +
		"	ymec_centre.[id] as centreid, " +
		"	ymec_centre.[state], " +
		"	ymec_centre.[name] as centre, " +
		"	ymec_course.[id] as courseid, " +
		"	ymec_course.[name] as course, " +
		"	ymec_course.[age], " +
		"	ymec_timetable.[term], " +
		"	ymec_timetable.[day], " +
		"	ymec_timetable.[time], " +
		"	ymec_timetable.[datestart] " +
		"FROM " +
		"	ymec_timetable " +
		"	INNER JOIN ymec_centre ON ymec_centre.id = ymec_timetable.centreid " + 
		"	INNER JOIN ymec_course ON ymec_course.id = ymec_timetable.courseid " +
		"WHERE 1=1 " +
		"	" + strTerm +
		"	" + strCourse +
		"	" + strCentre +
		"	" + strDay +
		"	" + strState +
		"	AND ymec_centre.[status] = 1 " +
		"ORDER BY " +
		"	ymec_centre.[state] ASC, " +
		"	ymec_centre.[name] ASC, " +
		"	ymec_timetable.[day] ASC, " +
		"	ymec_timetable.[time] ASC";

// Response.Write(strSQL);

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);


	if (rs && !rs.EOF) {
		return rs;
	} else {
		return null;
	}

}


function _getSelectedCourseByID(id) {

	var rs = null;
	var strCourse = new String();

	var strSQL = "SELECT " +
		"	ymec_timetable.[id], " +
		"	ymec_centre.[state], " +
		"	ymec_centre.[name] as centre, " +
		"	ymec_course.[name] as course, " +
		"	ymec_course.[age], " +
		"	ymec_timetable.[term], " +
		"	ymec_timetable.[day], " +
		"	ymec_timetable.[time], " +
		"	ymec_timetable.[status], " +
		"	ymec_timetable.[datestart] " +
		"FROM " +
		"	ymec_timetable " +
		"	INNER JOIN ymec_centre ON ymec_centre.id = ymec_timetable.centreid " + 
		"	INNER JOIN ymec_course ON ymec_course.id = ymec_timetable.courseid " +
		"WHERE 1=1 " +
		"	AND ymec_timetable.id = " + id +
		"	AND ymec_centre.[status] = 1 " +
		"ORDER BY " +
		"	ymec_centre.[state] ASC, " +
		"	ymec_centre.[name] ASC, " +
		"	ymec_timetable.[day] ASC, " +
		"	ymec_timetable.[time] ASC";

// Response.Write(strSQL);

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 2);

	if (rs && !rs.EOF) {
		strCourse = "Term " + rs("term") + " " + rs("course") + " at " + rs("centre") + " on " + GBL_DAYS[rs("day")] + ", " + rs("time");
		return strCourse;
	} else {
		return strCourse;
	}
}



function _loadTimetable(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM ymec_timetable WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = parseInt(rs("id"));
			this.status = parseInt(rs("status"));
			this.centreid = parseInt(rs("centreid"));
			this.courseid = parseInt(rs("courseid"));
			this.term = parseInt(rs("term"));
			this.day = parseInt(rs("day"));
			this.time = new String(rs("time"));
			this.datestart = new String(rs("datecreated"));
			this.datecreated = new String(rs("datecreated"));
			this.datemodified = new String(rs("datemodified"));
		}
	}
}

function _addTimetable() {
	var insertParams = "status, centreid, courseid, term, day, time, datestart, datecreated";
	var insertValues = this.status + ", " + this.centreid+ ", " + this.courseid + ", " + this.term + ", " + this.day + ", '" + this.time + "', '" + this.datestart + "', getdate()";

	try {
		var strSQL = "INSERT INTO ymec_timetable (" + insertParams + ") VALUES (" + insertValues + ")";
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


function _saveTimetable() {
	var updateStr = "status = " + this.status + ", " +
					"centreid = " + this.centreid + ", " +
					"courseid = " + this.courseid + ", " +
					"term = " + this.term + ", " +
					"day = " + this.day + ", " +
					"time = '" + this.time + "', " +
					"datestart = " + (this.datestart?"'" + this.datestart + "'":null) + ", " +
					"datemodified = GETDATE()";

	try {
		var strSQL = "UPDATE ymec_timetable SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteTimetable() {
	try {
		var strSQL = "DELETE FROM ymec_timetable WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


%>