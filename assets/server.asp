<html>
<body>
<p> <b>server_software:</b>
  <%Response.Write(Request.ServerVariables("server_software"))%>
</p>
<p><b>server_name:</b>
  <%Response.Write(Request.ServerVariables("server_name"))%>
</p>
<p> <b>server_port:</b>
  <%Response.Write(Request.ServerVariables("server_port"))%>
</p>
<p> <b>URL:</b>
  <%Response.Write(Request.ServerVariables("URL"))%>
</p>

<p> <b>HTTPS:</b>
  <%Response.Write(Request.ServerVariables("HTTPS"))%>
</p>

</body>
</html>