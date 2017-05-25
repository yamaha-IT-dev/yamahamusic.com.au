<%

var local_address = Request.ServerVariables("LOCAL_ADDR");
var server_name = Request.ServerVariables("SERVER_NAME");
var remote_ip = Request.ServerVariables("REMOTE_ADDR");

/*
if (local_address == "172.29.64.9" || local_address == "172.29.64.60") {

	// local (development)
	var strConn = "Driver={SQL Server};Server=172.29.64.9;Database=YMADEV;User ID=webuser;Password=w3bu53r;"
	// var strConn = "Provider=sqloledb; Data Source=172.29.64.9; Network Library=DBMSSOCN; Initial Catalog=YMADEV; User ID=webuser;Password=w3bu53r;";
	var strConnAltProvider = "Provider=sqloledb; Data Source=172.29.64.9; Network Library=DBMSSOCN; Initial Catalog=YMADEV; User ID=webuser;Password=w3bu53r;";
	var GBL_SEARCH_CATALOGUE = "yamtest";
	var GBL_GOOGLEMAPS_APIKEY = "ABQIAAAAFuA-zOogCQ7IsWVvvEOvvxTnVy6LjfS6ps5ftTF5d19pW5Lw0xRPRZv2Wwp-O3Q5whReVczLF2ZgvQ";
	var GBL_MAIL_SERVER = "172.29.64.13";
	var GBL_DOMAIN = "redev";

} else {
*/

	// remote (webcentral)
	var strConn = "Driver={SQL Server};Server=wic007q.server-sql.com,4656;Database=vs130299_1;User ID=vs130299_1;Password=ZfD4LTaiD6;"
	var strConnAltProvider = "Provider=sqloledb; Network Library=DBMSSOCN; Data Source=wic007q.server-sql.com,4656; Initial Catalog=vs130299_1; User ID=vs130299_1; Password=ZfD4LTaiD6;";
	var GBL_SEARCH_CATALOGUE = "vs130299";
	var GBL_GOOGLEMAPS_APIKEY = "ABQIAAAAFuA-zOogCQ7IsWVvvEOvvxR-Ri5tZe2aLjTlKmkJGUXEs5p_GhRLjL767D4pMD_NVP8OMb0bMIelgw";
	var GBL_MAIL_SERVER = "smtp.bne.server-mail.com";
	var GBL_DOMAIN = "www.yamahamusic.com.au";

// }

var GBL_DAYS = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");
var GBL_MONTHS = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
var GBL_TITLES = new Array("", "Mr", "Ms", "Mrs", "Dr");

var GBL_WARRANTY = new Array()
	GBL_WARRANTY[1]  = "Audio Visual";
	GBL_WARRANTY[2]  = "Guitars";
	GBL_WARRANTY[3]  = "Professional Audio";
	GBL_WARRANTY[6]  = "Band & Orchestral";
	GBL_WARRANTY[8]  = "Clavinova Digital Piano";
	GBL_WARRANTY[9]  = "Portable Keyboards";
	GBL_WARRANTY[12] = "Yamaha Digital Piano";
	GBL_WARRANTY[13] = "P-Series Digital Piano";
	GBL_WARRANTY[14] = "Vox Equipment";
	GBL_WARRANTY[15] = "Paiste Cymbals";
	GBL_WARRANTY[16] = "Yamaha Drums";
	GBL_WARRANTY[17] = "Commercial Audio";

var GBL_WARRANTYIDS = new Array(0, 1, 2, 3, 6, 8, 9, 12, 13, 14, 15, 16, 17);
var GBL_WARRANTYTYPES = new Array("", "Audio Visual", "Guitars", "Professional Audio", "Band &amp; Orchestral", "Clavinova Digital Piano", "Portable Keyboards", "Yamaha Digital Pianos", "P-Series Digital Pianos", "Vox Equipment", "Paiste Cymbals", "Yamaha Drums", "Commercial Audio");
var GBL_WARRANTYDOCS = new Array("", "warrantyAVIT.asp", "warrantyGuitar.asp", "warrantyProAudio.asp", "warrantyBO.asp", "warrantyClavinova.asp", "warrantyKeyboard.asp", "warrantyKeyboard.asp", "warrantyKeyboard.asp", "warrantyVox.asp", "warrantyPaiste.asp", "warrantyDrums.asp", "warrantyCA.asp");

var GBL_STATES_LONG = new Array("Victoria", "New South Wales", "Australia Capital Territory", "Queensland", "Northern Territory", "Western Australia", "South Australia", "Tasmania", "Other country");
var GBL_STATES_SHORT = new Array("VIC", "NSW", "ACT", "QLD", "NT", "WA", "SA", "TAS", "OS");
var GBL_SCHOOLLEVEL = new Array("pre-school","kindergarten","prep","grade 1","grade 2","grade 3","grade 4","grade 5","grade 6","year 7","year 8","year 9","year 10","year 11","year 12", "other");

var GBL_REGIONS = new Array("VIC - Bayside", "VIC - Eastern", "VIC - North West", "NSW - Southern", "NSW - Hills", "NSW - Central", "WA - Perth", "PMC - Australia");
var GBL_REGIONS_EMAIL = new Array("rcvic_bay@gmx.yamaha.com", "rcvic_east@gmx.yamaha.com", "rcvic_nw@gmx.yamaha.com", "rcnsw_south@gmx.yamaha.com", "rcnsw_hills@gmx.yamaha.com", "rcnsw_central@gmx.yamaha.com", "rc_wa@gmx.yamaha.com", "rc_pmc@gmx.yamaha.com");

var GBL_WARRANTY_STATUS = new Array("OPEN", "REJECTED", "PENDING", "CLOSED");
var GBL_COUNTRIES = new Array("Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos Islands", "Colombia", "Comoros", "Congo", "Cook Islands", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea (North)", "Korea (South)", "Kosovo", "Kuwait", "Kyrgyzstan", "Lao Peoples Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia", "Moldova Republic", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint LUCIA", "Saint Vincent and the Grenadines", "Samoa", "San Marino", " Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands British", "Virgin Islands US", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe");

var GBL_CATEGORY_NEWS = 2;
var GBL_CATEGORY_SERVICE = 5;
var GBL_CATEGORY_FAQ = 6;
var GBL_CATEGORY_CA_NEWS = 22;

var GBL_CATEGORY_YMEC = 9;
var GBL_CATEGORY_YMEC_SYDNEY = 8;
var GBL_CATEGORY_YMEC_MELB = 12;
var GBL_CATEGORY_YMEC_PERTH = 28;
var GBL_CATEGORY_YMEC_CLASSROOM = 13;
var GBL_CATEGORY_YMEC_NEWS = 14;
var GBL_CATEGORY_YMEC_ADMIN = 15;
var GBL_CATEGORY_SERVICE_NEWS = 19;


var GBL_TYPE_NEWS = 1;
var GBL_TYPE_PROMO = 6;
var GBL_TYPE_BANNER = 7;

var GBL_USERTYPE_ADMIN = 1
var GBL_USERTYPE_SUPPORTTEAM = 4
var GBL_USERTYPE_TEACHER = 5
var GBL_USERTYPE_SERVICE = 6


var GBL_PRIVACY_STATEMENT = new String("\n\nIf you do not wish to receive further updates from Yamaha Music Australia, or you would like to gain access to the information about you that we hold, please contact our Privacy Officer at one of the reference points below. If you would like us to stop sending updates to you, please allow two weeks for your request to be actioned.\n" +
							"a: Level 1, 99 Queensbridge Street Southbank, Victoria 3006\n" +
							"e: privacy_au@gmx.yamaha.com\n" +
							"p: +61 3 9693 5111\n" +
							"f: +61 3 9699 2332\n");


var GBL_CONN = Server.CreateObject("ADODB.Connection");
	GBL_CONN.open(strConn);

var GBL_CONN_ALTPROVIDER = Server.CreateObject("ADODB.Connection");
	GBL_CONN_ALTPROVIDER.open(strConnAltProvider);


var GBL_SYNERGETIC = "http://synergetic.yamahamusic.com.au:7008/";
	if (new String(remote_ip).indexOf("172.29.") == 0 || new String(remote_ip).indexOf("203.221.101.") == 0) {
		GBL_SYNERGETIC = "http://203.221.101.250:7008/";
	}

var GBL_WARRANTY_REPAIRCODE_S = new Array();
var GBL_WARRANTY_REPAIRCODE_L = new Array();

//	GBL_WARRANTY_REPAIRCODE_S.push("SAS");	GBL_WARRANTY_REPAIRCODE_L.push("SAS - Audio Products Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SAW");	GBL_WARRANTY_REPAIRCODE_L.push("SAW - Audio Products (Not CD Players)");
//	GBL_WARRANTY_REPAIRCODE_S.push("SBS");	GBL_WARRANTY_REPAIRCODE_L.push("SBS - Band & Orchestral Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SBW");	GBL_WARRANTY_REPAIRCODE_L.push("SBW - Band & Orchestral Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SCS");	GBL_WARRANTY_REPAIRCODE_L.push("SCS - Computer Products Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("SCW");	GBL_WARRANTY_REPAIRCODE_L.push("SCW - Multimedia Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SDS");	GBL_WARRANTY_REPAIRCODE_L.push("SDS - Compact Disc Players Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("SDW");	GBL_WARRANTY_REPAIRCODE_L.push("SDW - Compact Disc Players");
//	GBL_WARRANTY_REPAIRCODE_S.push("SES");	GBL_WARRANTY_REPAIRCODE_L.push("SES - Electone Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SEW");	GBL_WARRANTY_REPAIRCODE_L.push("SEW - Electone Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SFS");	GBL_WARRANTY_REPAIRCODE_L.push("SFS - DE Products Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("SGS");	GBL_WARRANTY_REPAIRCODE_L.push("SGS - DE Products");
	GBL_WARRANTY_REPAIRCODE_S.push("SGW");	GBL_WARRANTY_REPAIRCODE_L.push("SGW - Guitar Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("SHS");	GBL_WARRANTY_REPAIRCODE_L.push("SHS - Guitars");
	GBL_WARRANTY_REPAIRCODE_S.push("SHW");	GBL_WARRANTY_REPAIRCODE_L.push("SHW - PA / Audio Techica Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SJS");	GBL_WARRANTY_REPAIRCODE_L.push("SJS - Drums Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SJW");	GBL_WARRANTY_REPAIRCODE_L.push("SJW - Drum Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SKS");	GBL_WARRANTY_REPAIRCODE_L.push("SKS - Mini Keyboards Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("SKW");	GBL_WARRANTY_REPAIRCODE_L.push("SKW - Mini Keyboards");
//	GBL_WARRANTY_REPAIRCODE_S.push("SLS");	GBL_WARRANTY_REPAIRCODE_L.push("SLS - Clavinova Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SLW");	GBL_WARRANTY_REPAIRCODE_L.push("SLW - Clavinova Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SMS");	GBL_WARRANTY_REPAIRCODE_L.push("SMS - Vox Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SMW");	GBL_WARRANTY_REPAIRCODE_L.push("SMW - Vox Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SPS");	GBL_WARRANTY_REPAIRCODE_L.push("SPS - Portable Keyboards Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SPW");	GBL_WARRANTY_REPAIRCODE_L.push("SPW - Portable Keyboards");
//	GBL_WARRANTY_REPAIRCODE_S.push("STS");	GBL_WARRANTY_REPAIRCODE_L.push("STS - Audio Technica Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("STW");	GBL_WARRANTY_REPAIRCODE_L.push("STW - Audio Technica Warranty");
//	GBL_WARRANTY_REPAIRCODE_S.push("SXS");	GBL_WARRANTY_REPAIRCODE_L.push("SXS - Piano Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SXW");	GBL_WARRANTY_REPAIRCODE_L.push("SXW - Piano Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SYS");	GBL_WARRANTY_REPAIRCODE_L.push("SYS - Disklavier Stock Code");
	GBL_WARRANTY_REPAIRCODE_S.push("SYW");	GBL_WARRANTY_REPAIRCODE_L.push("SYW - Disklavier Products");
//	GBL_WARRANTY_REPAIRCODE_S.push("SZS");	GBL_WARRANTY_REPAIRCODE_L.push("SZS - CDR Stock Code");
//	GBL_WARRANTY_REPAIRCODE_S.push("SZW");	GBL_WARRANTY_REPAIRCODE_L.push("SZW - CDR Products");


//Response.Write(GBL_CONN.state);

%>
