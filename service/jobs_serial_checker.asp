<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsJob.asp" -->

<%
    dim userSerialNo

    userSerialNo = Request.QueryString("user_serial_no")

    'Response.Write(userSerialNo)

    Response.Write(doesSerialNumberExist(userSerialNo))
%>