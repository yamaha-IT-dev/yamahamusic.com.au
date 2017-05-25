<% 

function EdCourse() {

	this.id = 0;
	this.name = new String();
	this.age = new String();
	this.datecreated = new String();
	this.datemodified = new String();

	this._getEdCourseID = _getEdCourseID;
	this._getEdCourseName = _getEdCourseName;
	this._getEdCourseAge = _getEdCourseAge;
	this._getEdCourseDatecreated = _getEdCourseDatecreated;
	this._getEdCourseDatemodified = _getEdCourseDatemodified;

	this._setEdCourseID = _setEdCourseID;
	this._setEdCourseName = _setEdCourseName;
	this._setEdCourseAge = _setEdCourseAge;
	this._setEdCourseDatecreated = _setEdCourseDatecreated;
	this._setEdCourseDatemodified = _setEdCourseDatemodified;

	this._getAllCourses = _getAllCourses;
	
}


function _getEdCourseID()			{ return this.id; }
function _getEdCourseName()			{ return this.name; }
function _getEdCourseAge()			{ return this.age; }
function _getEdCourseDatecreated()	{ return this.datecreated; }
function _getEdCourseDatemodified()	{ return this.datemodified; }

function _setEdCourseID(value)			{ this.id = value; }
function _setEdCourseName(value)		{ this.name = value; }
function _setEdCourseAge(value)			{ this.age = value; }
function _setEdCourseDatecreated(value)	{ this.datecreated = value; }
function _setEdCourseDatemodified(value){ this.datemodified = value; }



function _getAllCourses() {

	var	strSQL = "SELECT ymec_course.* FROM ymec_course";

	var rsAC = Server.CreateObject("ADODB.Recordset");
		rsAC.Open(strSQL, GBL_CONN, 2, 2);

	if (rsAC && !rsAC.EOF) {
		return rsAC;
	} else {
		return null;
	}
}



%>