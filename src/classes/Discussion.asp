<% 

function Discussion() {

	this.id = null;
	this.parentid = null;
	this.topicid = null;
	this.userid = null;
	this.usernotify = null;
	this.status = null;
	this.subject = new String();
	this.message = new String();
	this.dateposted = null;
	this.remoteip = null;

	this._getDiscussionID = _getDiscussionID;
	this._getDiscussionParentID = _getDiscussionParentID;
	this._getDiscussionTopicID = _getDiscussionTopicID;
	this._getDiscussionUserID = _getDiscussionUserID;
	this._getDiscussionUsernotify = _getDiscussionUsernotify;
	this._getDiscussionStatus = _getDiscussionStatus;
	this._getDiscussionSubject = _getDiscussionSubject;
	this._getDiscussionMessage = _getDiscussionMessage;
	this._getDiscussionDateposted = _getDiscussionDateposted;
	this._getDiscussionRemoteIP = _getDiscussionRemoteIP;

	this._setDiscussionID = _setDiscussionID;
	this._setDiscussionParentID = _setDiscussionParentID;
	this._setDiscussionTopicID = _setDiscussionTopicID;
	this._setDiscussionUserID = _setDiscussionUserID;
	this._setDiscussionUsernotify = _setDiscussionUsernotify;
	this._setDiscussionStatus = _setDiscussionStatus;
	this._setDiscussionSubject = _setDiscussionSubject;
	this._setDiscussionMessage = _setDiscussionMessage;
	this._setDiscussionDateposted = _setDiscussionDateposted;
	this._setDiscussionRemoteIP = _setDiscussionRemoteIP;

	this._getAllDiscussionByTopic = _getAllDiscussionByTopic;
	this._getAllDiscussionByParent = _getAllDiscussionByParent;

	this._loadDiscussion = _loadDiscussion;
	this._addDiscussion = _addDiscussion;
	this._saveDiscussion = _saveDiscussion;
	this._deleteDiscussion = _deleteDiscussion;

	this._drawItemLite = _drawItemLite;
	this._drawItemFull = _drawItemFull;
	this._drawThread = _drawThread;
	
	this._countReplies = _countReplies;

}


function _getDiscussionID() 			{ return this.id; }
function _getDiscussionParentID() 		{ return this.parentid; }
function _getDiscussionTopicID() 		{ return this.topicid; }
function _getDiscussionUserID() 		{ return this.userid; }
function _getDiscussionUsernotify() 	{ return this.usernotify; }
function _getDiscussionStatus()			{ return this.status; }
function _getDiscussionSubject()		{ return this.subject; }
function _getDiscussionMessage()		{ return this.message; }
function _getDiscussionDateposted() 	{ return this.dateposted; }
function _getDiscussionRemoteIP() 		{ return this.remoteip; }

function _setDiscussionID(value) 			{ this.id = value; }
function _setDiscussionParentID(value) 		{ this.parentid = value; }
function _setDiscussionTopicID(value) 		{ this.topicid = value; }
function _setDiscussionUserID(value)		{ this.userid = value; }
function _setDiscussionUsernotify(value)	{ this.usernotify = value; }
function _setDiscussionStatus(value) 		{ this.status = value; }
function _setDiscussionSubject(value) 		{ this.subject = value; }
function _setDiscussionMessage(value) 		{ this.message = value; }
function _setDiscussionDateposted(value)	{ this.dateposted = value; }
function _setDiscussionRemoteIP(value) 		{ this.remoteip = value; }



function _getAllDiscussionByTopic(topicid) {
	var Keys = new Array();
	var rs = GBL_CONN.Execute("SELECT id FROM yma_discussion WHERE parentid = 0 AND topicid = " + topicid + " ORDER BY dateposted DESC");
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("id"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}

function _getAllDiscussionByParent(id) {
	var Keys = new Array();
	var rs = GBL_CONN.Execute("SELECT id FROM yma_discussion WHERE parentid = " + id + " ORDER BY dateposted ASC");
	var i = 0;
	while (!rs.EOF) {
		Keys[i] = new Number(rs("id"));
		rs.MoveNext();
		i++;
	}
	return Keys;
}


function _loadDiscussion(id) {
	if (id) {
		try {
			var strSQL = "SELECT * FROM yma_discussion WHERE id = " + id;
			var rs = GBL_CONN.Execute(strSQL);
		} catch(e) {
			Response.Write("Attempted Load : " + e.description + "<br>" + strSQL);
			Response.Flush();
		}
		if (!rs.EOF) {
			this.id = new Number(rs("id"));
			this.parentid = new Number(rs("parentid"));
			this.topicid = new Number(rs("topicid"));
			this.userid = new Number(rs("userid"));
			this.usernotify = new Number(rs("usernotify"));
			this.status = new Number(rs("status"));
			this.subject = new String(rs("subject"));
			this.message = new String(rs("message"));
			this.dateposted = new String(rs("dateposted"));
			this.remoteip = new String(rs("remoteip"));
		}
	}
}

function _addDiscussion() {
	var insertParams = "parentid, topicid, userid, usernotify, status, subject, message, dateposted, remoteip";
	var insertValues = this.parentid + ", " + this.topicid + ", " + this.userid + ", " + this.usernotify + ", " + this.status + ", '" + this.subject + "', '" + this.message + "', getdate(), '" + this.remoteip + "'";

	try {
		var strSQL = "INSERT INTO yma_discussion (" + insertParams + ") VALUES (" + insertValues + ")";
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

function _saveDiscussion() {
	var updateStr = "parentid = " + this.parentid + ", " +
					"topicid = " + this.topicid + ", " +
					"userid = " + this.userid + ", " +
					"usernotify = " + this.usernotify + ", " +
					"status = " + this.status + ", " +
					"subject = '" + this.subject + "', " +
					"message = '" + this.message + "', " +
					"remoteip = '" + this.remoteip + "'";

	try {
		var strSQL = "UPDATE yma_discussion SET " + updateStr + " WHERE id = " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Save : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}

function _deleteDiscussion() {
	try {
		var strSQL = "DELETE FROM yma_discussion WHERE id =  " + this.id;
		GBL_CONN.Execute(strSQL);
	} catch(e) {
		Response.Write("Attempted Delete : " + e.description + "<br>" + strSQL);
		Response.Flush();
	}
}


function _drawItemLite(discussionid, threadid, U, P, depthcount) {
		
	if (discussionid > 0) {	

		this._loadDiscussion(discussionid);
		U._loadUser(this._getDiscussionUserID());
		var c_replies = this._countReplies(discussionid);
		%><a href="discuss.asp?action=read_post&threadid=<%= threadid %>&discussionid=<%= this._getDiscussionID() %>#<%= this._getDiscussionID() %>" style="padding-left:<%= depthcount*10 %>px;"><b><%= this._getDiscussionSubject() %></b></a> - posted by <%= U._getUserUsername() %> on <%= new Date(Date.parse(this._getDiscussionDateposted())).formatDate("j/m/Y, g:i A") %> | <%= c_replies %>&nbsp;<%= c_replies==1?"reply":"replies" %><br/><%
		replycount = 0;
	}
}

function _drawItemFull(discussionid, threadid, U, P, depthcount) {
		
	if (discussionid > 0) {	

		this._loadDiscussion(discussionid);
		U._loadUser(this._getDiscussionUserID());
		d = new Date(Date.parse(this._getDiscussionDateposted()));
		%>
		<a name="<%= this._getDiscussionID() %>"></a>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-left:<%= depthcount*10 %>px #F0EDFB solid;">
		<tr>
			<th style="width:90%;"><strong><%= this._getDiscussionSubject() %></strong><br/><%= d.formatDate("jS F Y, g:i A") %></td>
			<th style="white-space:nowrap;text-align:right;">Author : <strong><%= U._getUserUsername() %></strong><br/>
				<a href="<%= CONTROLLER %>?action=<%= REPORT_ABUSE %>&discussionid=<%= this._getDiscussionID() %>" title="Inform the moderator of this post">Report Abuse</a> |
				<a href="#form" onclick="document.forms['discussionForm'].elements['parentid'].value=<%= this._getDiscussionID() %>;" title="Reply to this post">Reply</a>
			</th>
		</tr>
		<tr>
			<td colspan="2"><%= this._getDiscussionMessage() %></td>
		</tr>
		</table>
		<%
	}
}

function _drawThread(currentid, parentid, U, P, depthcount, full) {

	var arrDiscussion = this._getAllDiscussionByParent(currentid); 
	var d = new Date()

	if (arrDiscussion.length > 0) {
		depthcount++;
		for (var i=0; i < arrDiscussion.length; i++) {
			
			var intDiscussionID = arrDiscussion[i];
		
			if (full) {
				this._drawItemFull(intDiscussionID, parentid, U, P, depthcount);
			} else {
				this._drawItemLite(intDiscussionID, parentid, U, P, depthcount);
			}
		
			var arrChildren = this._getAllDiscussionByParent(intDiscussionID);
			if (arrChildren.length > 0) {
				this._drawThread(intDiscussionID, parentid, U, P, depthcount, full);
			}
		}
	} else {
		if (depthcount == 0) {
			%>Sorry, there are no contributions to this topic yet.<%
		}
	}
}

var replycount = 0;

function _countReplies(currentid) {

	var arrDiscussion = this._getAllDiscussionByParent(currentid); 

	if (arrDiscussion.length > 0) {
		
		for (var i=0; i < arrDiscussion.length; i++) {

			replycount++
			var intDiscussionID = arrDiscussion[i];
		
			var arrChildren = this._getAllDiscussionByParent(intDiscussionID);
			if (arrChildren.length > 0) {
				this._countReplies(intDiscussionID);
			}
		}
	}
	return replycount;
}







%>