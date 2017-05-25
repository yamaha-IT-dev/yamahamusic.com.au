<%

Response.AddHeader("Content-Disposition", "filename=BATCH_" + new Date().formatDate("Ymd") + ".txt");
Response.ContentType = "text/csv";

	if (rsClaims && !rsClaims.EOF) {

	while (!rsClaims.EOF) {
		Response.Write(rsClaims("claimnumber") + "\t" +
			"0\t" + // rsClaims("creditflag") + "\t" +
			rsClaims("rctiflag") + "\t" +
			rsClaims("vendorcode") + "\t" +
			"\t" +
			"\t" +
			"\t" +
			rsClaims("modelnumber") + "\t" +
			"1\t" + // rsClaims("oldmodelflag") + "\t" +
			rsClaims("serialnumber") + "\t" +
			new Date(Date.parse(rsClaims("datepurchased"))).formatDate("dmy") + "\t" +
			rsClaims("dealercode") + "000\t" +
			cleanForTextNoCR(rsClaims("faultreport")) + "\t" +
			cleanForTextNoCR(rsClaims("repairreport")) + "\t" +
			cleanForTextNoCR(rsClaims("extcomment")) + "\t" +
			rsClaims("invoicenumber") + "\t" +
			"\t" +
			"\t" +
			rsClaims("repaircode") + "\t" +
			new Number(rsClaims("labourcharge")).toFixed(2) + "\t" +
			new Number(rsClaims("partscharge")).toFixed(2) + "\t" +
			new Number(rsClaims("gstcharge")).toFixed(2) + "\r\n");
			rsClaims.moveNext();
		}
	}
%>
