<%

function endProcess() {
	if (GBL_CONN && GBL_CONN.state == 1) {
		GBL_CONN.close();
		GBL_CONN = null;
	}
	Response.Redirect(CONTROLLER);
}

function endProcessPlus(qstring) {
	if (GBL_CONN && GBL_CONN.state == 1) {
		GBL_CONN.close();
		GBL_CONN = null;
	}
	Response.Redirect(CONTROLLER + "?" + qstring);
}


function doBRTags(str) {
	var r, re;
	var s = new String(str);

	re = /\n/g; r = s.replace(re, "<br/>"); s = r;

	return(r);
}



function lightRinseForSQL(str) {
	var r, re;
	var s = new String(str);

	re = /UPDATE/g; r = s.replace(re, ""); s = r;
	re = /DELETE/g; r = s.replace(re, ""); s = r;
	re = /\//g; r = s.replace(re, "&#47;"); s = r;		//'replace forward slash
	re = /\"/g; r = s.replace(re, "&#34;"); s = r;		//'replace double quote
	re = /\'/g; r = s.replace(re, "&#39;"); s = r;		//'replace single quote

	return(r);
}
//"\

function cleanForSQL(str) {
	var r, re;
	var s = new String(str);

	re = /UPDATE/g; r = s.replace(re, ""); s = r;
	re = /DELETE/g; r = s.replace(re, ""); s = r;
	re = /</g; r = s.replace(re, "&#60;"); s = r;
	re = />/g; r = s.replace(re, "&#62;"); s = r;
	re = /&/g; r = s.replace(re, "&amp;"); s = r;
	re = /\//g; r = s.replace(re, "&#47;"); s = r;		//'replace forward slash
	re = /\"/g; r = s.replace(re, "&#34;"); s = r;		//'replace double quote
	re = /\'/g; r = s.replace(re, "&#39;"); s = r;		//'replace single quote

	return(r);
}
//"\

function cleanForText(str) {
	var r, re;
	var s = new String(str);

	re = /&#60;/g; r = s.replace(re, "<"); s = r;
	re = /&#62;/g; r = s.replace(re, ">"); s = r;
	re = /&amp;/g; r = s.replace(re, "&"); s = r;
	re = /&lt;/g; r = s.replace(re, "<"); s = r;
	re = /&gt;/g; r = s.replace(re, ">"); s = r;
	re = /&#34;/g; r = s.replace(re, "\""); s = r;		//'replace double quote
	re = /&#39;/g; r = s.replace(re, "\'"); s = r;		//'replace single quote
	re = /&#47;/g; r = s.replace(re, "/"); s = r;

	return(r);
}

function cleanForTextNoCR(str) {
	var r, re;
	var s = new String(str);

	re = /&#60;/g; r = s.replace(re, "<"); s = r;
	re = /&#62;/g; r = s.replace(re, ">"); s = r;
	re = /&amp;/g; r = s.replace(re, "&"); s = r;
	re = /&lt;/g; r = s.replace(re, "<"); s = r;
	re = /&gt;/g; r = s.replace(re, ">"); s = r;
	re = /&#34;/g; r = s.replace(re, "\""); s = r;		//'replace double quote
	re = /&#39;/g; r = s.replace(re, "\'"); s = r;		//'replace single quote
	re = /&#47;/g; r = s.replace(re, "/"); s = r;
	re = /\n/g; r = s.replace(re, " "); s = r;

	return(r);
}

function lightRinseForSQLNoCR(str) {
	var r, re;
	var s = new String(str);

	re = /UPDATE/g; r = s.replace(re, ""); s = r;
	re = /DELETE/g; r = s.replace(re, ""); s = r;
	re = /\//g; r = s.replace(re, "&#47;"); s = r;		//'replace forward slash
	re = /\"/g; r = s.replace(re, "&#34;"); s = r;		//'replace double quote
	re = /\'/g; r = s.replace(re, "&#39;"); s = r;		//'replace single quote
	re = /\r\n/g; r = s.replace(re, " "); s = r;		//'replace single quote

	return(r);
}
//"\

function cleanForSQLNoCR(str) {
	var r, re;
	var s = new String(str);

	re = /UPDATE/g; r = s.replace(re, ""); s = r;
	re = /DELETE/g; r = s.replace(re, ""); s = r;
	re = /</g; r = s.replace(re, "&#60;"); s = r;
	re = />/g; r = s.replace(re, "&#62;"); s = r;
	re = /&/g; r = s.replace(re, "&amp;"); s = r;
	re = /\//g; r = s.replace(re, "&#47;"); s = r;		//'replace forward slash
	re = /\"/g; r = s.replace(re, "&#34;"); s = r;		//'replace double quote
	re = /\'/g; r = s.replace(re, "&#39;"); s = r;		//'replace single quote
	re = /\n/g; r = s.replace(re, " "); s = r;		//'replace single quote

	return(r);
}
//"\

function badLanguage(str) {
	var result = false;
	var arrNasty = new Array("fuck", "cunt", "shit", "arse", "slut", "rape", "bitch", "whore", "cock", "dick", "twat", "wanker", "tosser", "jihad", "jiz", "tits", "boobs");
	for (var i=0; i < arrNasty.length; i++) {
		if (str.toLowerCase().indexOf(arrNasty[i]) >= 0) {
			result = true;
			break;
		}
	}
	return result;
}

var GBLLZ = GBLLeadingZeros;

function GBLLeadingZeros(number, count) {
	var strN = new String(number);
	var strZ = new String();
	if (strN.length < count) {
		for (var i=0; i < count-strN.length; i++) {
			strZ += "0";
		}
	}
// Response.Write(strZ + "<br/>");
	strN = strZ + strN;
	return strN;
}


function GBLMakeDate(day, month, year, hours, minutes, seconds) {

	var tmpDate = new Date();

	var tmpDay = day?new Number(day):tmpDate.getDay();
	var tmpMonth = month?new Number(month):tmpDate.getMonth();
	var tmpYear = year?new Number(year):tmpDate.getFullYear();
	var tmpHours = hours?new Number(hours):tmpDate.getHours();
	var tmpMinutes = minutes?new Number(minutes):tmpDate.getMinutes();
	var tmpSeconds = seconds?new Number(seconds):tmpDate.getSeconds();

	var strDate = new String(GBLLeadingZeros(tmpMonth, 1) + "/" + GBLLeadingZeros(tmpDay, 1) + "/" + GBLLeadingZeros(tmpYear, 1) + " " + GBLLeadingZeros(tmpHours, 1)  + ":" + GBLLeadingZeros(tmpMinutes, 1) + ":" + GBLLeadingZeros(tmpSeconds, 1));

// Response.Write("strDate = " + strDate + "<br/>");
	return strDate;
}



Array.prototype.exists = function (x) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == x) return true;
    }
    return false;
}

Date.prototype.formatDate = function (input,time) {
    // formatDate :
    // a PHP date like function, for formatting date strings
    // See: http://www.php.net/date
    //
    // input : format string
    // time : epoch time (seconds, and optional)
    //
    // if time is not passed, formatting is based on
    // the current "this" date object's set time.
    //
    // supported:
    // a, A, B, d, D, F, g, G, h, H, i, j, l (lowercase L), L,
    // m, M, n, O, r, s, S, t, U, w, W, y, Y, z
    //
    // unsupported:
    // I (capital i), T, Z

    var switches =    ["a", "A", "B", "d", "D", "F", "g", "G", "h", "H",
                       "i", "j", "l", "L", "m", "M", "n", "O", "r", "s",
                       "S", "t", "U", "w", "W", "y", "Y", "z"];
    var daysLong =    ["Sunday", "Monday", "Tuesday", "Wednesday",
                       "Thursday", "Friday", "Saturday"];
    var daysShort =   ["Sun", "Mon", "Tue", "Wed",
                       "Thu", "Fri", "Sat"];
    var monthsShort = ["Jan", "Feb", "Mar", "Apr",
                       "May", "Jun", "Jul", "Aug", "Sep",
                       "Oct", "Nov", "Dec"];
    var monthsLong =  ["January", "February", "March", "April",
                       "May", "June", "July", "August", "September",
                       "October", "November", "December"];
    var daysSuffix = ["st", "nd", "rd", "th", "th", "th", "th", // 1st - 7th
                      "th", "th", "th", "th", "th", "th", "th", // 8th - 14th
                      "th", "th", "th", "th", "th", "th", "st", // 15th - 21st
                      "nd", "rd", "th", "th", "th", "th", "th", // 22nd - 28th
                      "th", "th", "st"];                        // 29th - 31st

    function a() {
        // Lowercase Ante meridiem and Post meridiem
        return self.getHours() > 11? "pm" : "am";
    }
    function A() {
        // Uppercase Ante meridiem and Post meridiem
        return self.getHours() > 11? "PM" : "AM";
    }

    function B(){
        // Swatch internet time. code simply grabbed from ppk,
        // since I was feeling lazy:
        // http://www.xs4all.nl/~ppk/js/beat.html
        var off = (self.getTimezoneOffset() + 60)*60;
        var theSeconds = (self.getHours() * 3600) +
                         (self.getMinutes() * 60) +
                          self.getSeconds() + off;
        var beat = Math.floor(theSeconds/86.4);
        if (beat > 1000) beat -= 1000;
        if (beat < 0) beat += 1000;
        if ((""+beat).length == 1) beat = "00"+beat;
        if ((""+beat).length == 2) beat = "0"+beat;
        return beat;
    }

    function d() {
        // Day of the month, 2 digits with leading zeros
        return new String(self.getDate()).length == 1?
        "0"+self.getDate() : self.getDate();
    }
    function D() {
        // A textual representation of a day, three letters
        return daysShort[self.getDay()];
    }
    function F() {
        // A full textual representation of a month
        return monthsLong[self.getMonth()];
    }
    function g() {
        // 12-hour format of an hour without leading zeros
        return self.getHours() > 12? self.getHours()-12 : self.getHours();
    }
    function G() {
        // 24-hour format of an hour without leading zeros
        return self.getHours();
    }
    function h() {
        // 12-hour format of an hour with leading zeros
        if (self.getHours() > 12) {
          var s = new String(self.getHours()-12);
          return s.length == 1?
          "0"+ (self.getHours()-12) : self.getHours()-12;
        } else {
          var s = new String(self.getHours());
          return s.length == 1?
          "0"+self.getHours() : self.getHours();
        }
    }
    function H() {
        // 24-hour format of an hour with leading zeros
        return new String(self.getHours()).length == 1?
        "0"+self.getHours() : self.getHours();
    }
    function i() {
        // Minutes with leading zeros
        return new String(self.getMinutes()).length == 1?
        "0"+self.getMinutes() : self.getMinutes();
    }
    function j() {
        // Day of the month without leading zeros
        return self.getDate();
    }
    function l() {
        // A full textual representation of the day of the week
        return daysLong[self.getDay()];
    }
    function L() {
        // leap year or not. 1 if leap year, 0 if not.
        // the logic should match iso's 8601 standard.
        var y_ = Y();
        if (
            (y_ % 4 == 0 && y_ % 100 != 0) ||
            (y_ % 4 == 0 && y_ % 100 == 0 && y_ % 400 == 0)
            ) {
            return 1;
        } else {
            return 0;
        }
    }
    function m() {
        // Numeric representation of a month, with leading zeros
        return self.getMonth() < 9?
        "0"+(self.getMonth()+1) :
        self.getMonth()+1;
    }
    function M() {
        // A short textual representation of a month, three letters
        return monthsShort[self.getMonth()];
    }
    function n() {
        // Numeric representation of a month, without leading zeros
        return self.getMonth()+1;
    }
    function O() {
        // Difference to Greenwich time (GMT) in hours
        var os = Math.abs(self.getTimezoneOffset());
        var h = ""+Math.floor(os/60);
        var m = ""+(os%60);
        h.length == 1? h = "0"+h:1;
        m.length == 1? m = "0"+m:1;
        return self.getTimezoneOffset() < 0 ? "+"+h+m : "-"+h+m;
    }
    function r() {
        // RFC 822 formatted date
        var r; // result
        //  Thu    ,     21          Dec         2000
        r = D() + ", " + j() + " " + M() + " " + Y() +
        //        16     :    01     :    07          +0200
            " " + H() + ":" + i() + ":" + s() + " " + O();
        return r;
    }
    function S() {
        // English ordinal suffix for the day of the month, 2 characters
        return daysSuffix[self.getDate()-1];
    }
    function s() {
        // Seconds, with leading zeros
        return new String(self.getSeconds()).length == 1?
        "0"+self.getSeconds() : self.getSeconds();
    }
    function t() {
        // Number of days in the given month
        if (n()-1 == 1) return 28 + L(); // if february
        // thanks to Marek Lewczuk for finding a typo here.
        switch ((n()-1) % 2) { // otherwise
            case 0 : return 31; break;
            default : return 30;
        }
    }

    function U() {
        // Seconds since the Unix Epoch (January 1 1970 00:00:00 GMT)
        return Math.round(self.getTime()/1000);
    }

    function W() {
        // Weeknumber, as per ISO specification:
        // http://www.cl.cam.ac.uk/~mgk25/iso-time.html

        // if the day is three days before newyears eve,
        // there's a chance it's "week 1" of next year.
        // here we check for that.
        var beforeNY = 364+L() - z();
        var afterNY  = z();
        var weekday = w()!=0?w()-1:6; // makes sunday (0), into 6.
        if (beforeNY <= 2 && weekday <= 2-beforeNY) {
            return 1;
        }
        // similarly, if the day is within threedays of newyears
        // there's a chance it belongs in the old year.
        var ny = new Date("January 1 " + Y() + " 00:00:00");
        var nyDay = ny.getDay()!=0?ny.getDay()-1:6;
        if (
            (afterNY <= 2) &&
            (nyDay >=4)  &&
            (afterNY >= (6-nyDay))
            ) {
            // Since I'm not sure we can just always return 53,
            // i call the function here again, using the last day
            // of the previous year, as the date, and then just
            // return that week.
            var prevNY = new Date("December 31 " + (Y()-1) + " 00:00:00");
            return prevNY.formatDate("W");
        }

        // week 1, is the week that has the first thursday in it.
        // note that this value is not zero index.
        if (nyDay <= 3) {
            // first day of the year fell on a thursday, or earlier.
            return 1 + Math.floor( ( z() + nyDay ) / 7 );
        } else {
            // first day of the year fell on a friday, or later.
            return 1 + Math.floor( ( z() - ( 7 - nyDay ) ) / 7 );
        }
    }
    function w() {
        // Numeric representation of the day of the week
        return self.getDay();
    }

    function Y() {
        // A full numeric representation of a year, 4 digits

        // we first check, if getFullYear is supported. if it
        // is, we just use that. ppks code is nice, but wont
        // work with dates outside 1900-2038, or something like that
        if (self.getFullYear) {
            var newDate = new Date("January 1 2001 00:00:00 +0000");
            var x = newDate .getFullYear();
            if (x == 2001) {
                // i trust the method now
                return self.getFullYear();
            }
        }
        // else, do this:
        // codes thanks to ppk:
        // http://www.xs4all.nl/~ppk/js/introdate.html
        var x = self.getYear();
        var y = x % 100;
        y += (y < 38) ? 2000 : 1900;
        return y;
    }
    function y() {
        // A two-digit representation of a year
        var y = Y()+"";
        return y.substring(y.length-2,y.length);
    }
    function z() {
        // The day of the year, zero indexed! 0 through 366
        var t = new Date("January 1 " + Y() + " 00:00:00");
        var diff = self.getTime() - t.getTime();
        return Math.floor(diff/1000/60/60/24);
    }

    var self = this;
    if (time) {
        // save time
        var prevTime = self.getTime();
        self.setTime(time);
    }

    var ia = input.split("");
    var ij = 0;
    while (ia[ij]) {
        if (ia[ij] == "\\") {
            // this is our way of allowing users to escape stuff
            ia.splice(ij,1);
        } else {
            if (switches.exists(ia[ij])) {
                ia[ij] = eval(ia[ij] + "()");
            }
        }
        ij++;
    }
    // reset time, back to what it was
    if (prevTime) {
        self.setTime(prevTime);
    }
    return ia.join("");
}
















function saveImage(fieldname, imagename, path) {

	var message = new String();
	var result = false;
	var strserverpath = new String(path);

	/*
		documentFile initially stores the full path of the image from the client machine
		this will usually appear in the format C:\blah\blah\blah\filename.jpg
		we get the position of the last \ and the length of the filename to lift the
		filename out of the complete filepath.
	*/
	var documentfile = new String(UPL.form(fieldname).UserFilename);

	if (documentfile.length > 0) {
		documentfile = documentfile.substring(documentfile.lastIndexOf("\\")+1, documentfile.length);

		var FSO = new ActiveXObject("Scripting.FileSystemObject");

		var potentialPath = Server.MapPath("../" + strserverpath) + "/" + documentfile;
		var fileExists = FSO.FileExists(potentialPath);

		var overwrite = new Number(UPL.form(fieldname + "_OVERWRITE"));

		if (!fileExists || overwrite > 0) {

			/*
				if the documentFile is valid. (sad validation i know) we then perform a server.mapPath
				and then use the SAFileUP.SaveInVirtual method to place the file on the server.
				in the path that we want. we then properly name tempImage to match whats on the server
				and bingo boingo - we're done. Complete the rest of the saving and it's all sor'ed
			*/
			arrDF = documentfile.split(".");
			ext = new String(arrDF[arrDF.length-1]).toLowerCase();

			if (UPL.Form(fieldname).TotalBytes < 50000000) {
				if (documentfile.length > 0 && (ext.indexOf("gif") == 0 ||
												ext.indexOf("jpg") == 0 ||
												ext.indexOf("doc") == 0 ||
												ext.indexOf("xls") == 0 ||
												ext.indexOf("ppt") == 0 ||
												ext.indexOf("pdf") == 0 ||
												ext.indexOf("txt") == 0 ||
												ext.indexOf("wav") == 0 ||
												ext.indexOf("mp3") == 0 ||
												ext.indexOf("docx") == 0 ||
												ext.indexOf("pptx") == 0 ||
												ext.indexOf("xlsx") == 0 ||
												ext.indexOf("png") == 0 ||
												ext.indexOf("zip") == 0)) {

					var wholeFilePath = "../" + strserverpath + "/" + documentfile;
					if (imagename != null && new String(imagename).indexOf("undefined") != 0) {
						wholeFilePath = "../" + strserverpath + "/" + imagename + "." + ext;
					}
					try {
						UPL.Path = Server.MapPath("../" + strserverpath);
						UPL.Form(fieldname).SaveInVirtual(wholeFilePath);

						message += wholeFilePath;
						result = true;

					} catch (e) {
						message += "<p style=\"color:red;\"><b>Oops</b>, something went horribly wrong :<br>" + e.description;
					}
				} else {
					message += "<p style=\"color:red;\"><b>Oops</b>, please check your image type - we only accept .gif and .jpg images, pdf documents (.pdf) Excel (.xls), Word (.doc) or PowerPoint (.ppt) documents. Make sure that you've named your files correctly and that there are no spaces in the filenames.";
				}
			} else {
				message += "<p style=\"color:red;\"><b>Oops</b>, please check the size of your file - we cannot accept files larger than 50 MB.";
			}
		} else {
			message += "<p style=\"color:red;\"><b>Oops</b>, it appears that you're trying to upload a file that already exists - are you sure that you want to do this?";
			message += "<p>If this is okay, <a href=\"javascript:history.go(-1);\">go back</a> and check the overwrite field.";
		}
	}
// Response.Write("result, message = " + result + ", " + message + "<br>");
	return new Array(result, message)
}





function GBLValidateDate(year, month, day) {

	var valid = true;
	var leap = 0;

	/* Validation leap-year / february / day */
	if ((year % 4 == 0) || (year % 100 == 0) || (year % 400 == 0)) {
		leap = 1;
	}
	if ((month == 2) && (leap == 1) && (day > 29)) {
		valid = false;
	}
	if ((month == 2) && (leap != 1) && (day > 28)) {
		valid = false;
	}
	/* Validation of other months */
	if ((day > 31) && ((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))) {
		valid = false;
	}
	if ((day > 30) && ((month == 4) || (month == 6) || (month == 9) || (month == 11))) {
		valid = false;
	}

	return valid;
}












%>
