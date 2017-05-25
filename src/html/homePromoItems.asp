<div id="promoItems">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<%
	var count = 0;
	var rpp = 3
	var arrPromos = new Array();

	var R = new Resource();
	var rsAllResources = R._getAllResourcesByType(GBL_TYPE_PROMO, null, true);
	if (rsAllResources && !rsAllResources.EOF) {

		while (!rsAllResources.EOF) {
			var arrPromoItem = new Array();
				arrPromoItem.push(cleanForText(rsAllResources("id")));
				arrPromoItem.push(doBRTags(cleanForText(rsAllResources("title"))));
				arrPromoItem.push(doBRTags(cleanForText(rsAllResources("body"))));
				arrPromoItem.push(cleanForText(rsAllResources("link")));
				arrPromoItem.push(cleanForText(rsAllResources("url")));
				arrPromoItem.push(cleanForText(rsAllResources("filesrclg")));
				arrPromoItem.push(cleanForText(rsAllResources("bgcolor")));

				arrPromos.push(arrPromoItem);

			rsAllResources.MoveNext();
		}

	var arrDisplayed = new Array();
	var intRCount = arrPromos.length;
	if (arrPromos.length < 3)
	{
		rpp = arrPromos.length
	}


		/*
			We need to randomise the display set of four,
			making sure not to display any item twice.
			This is crude, but it appears to work.
		*/
		for (var i=0; i<rpp; i++) {
			intRand = Math.floor(Math.random() * intRCount);
			arrDisplayed[i] = intRand;
			while (new String(arrDisplayed).indexOf(intRand + ",") >= 0) {
				intRand = Math.floor(Math.random() * intRCount);
				arrDisplayed[i] = intRand;
			}
		}

		for (var i=0; i<arrDisplayed.length; i++) {

			var arrPromoItem = arrPromos[arrDisplayed[i]];
			var strLink = (new String(arrPromoItem[3]).length != 0 && new String(arrPromoItem[3]).indexOf("null") != 0)?cleanForText(arrPromoItem[3]):"read more...";
			var strURL = new String(arrPromoItem[4]).length != 0?cleanForSQL(arrPromoItem[4]):"/news/news.asp?action=view_item&amp;resourceid=" + arrPromoItem[0];
			var strBGColor = new String(arrPromoItem[6]).length != 0?"background-color:" + arrPromoItem[6] + ";":"";
			var strBGImage = new String(arrPromoItem[5]).length > 0?"background-image:url(" + arrPromoItem[5] + ");":"";

			%><td onclick="javascript:document.location.href='<%= strURL %>'" class="<%= i==0?"first":"" %>" style="<%= strBGColor %><%= strBGImage %>">&nbsp;</td>
			<%
			count ++;

		}

	}

%>
</tr>
</table>
</div>