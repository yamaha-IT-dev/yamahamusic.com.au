<%
   if (Request.ServerVariables("SERVER_PORT")== 80) {
      strSecureURL = "https://www.yamahamusic.com.au/products/musicproduction/steinberg/regEnquiry.asp";
      Response.Redirect (strSecureURL);
   }
%>