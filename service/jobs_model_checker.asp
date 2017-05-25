<!--#include file="../include/connection.asp" -->
<!--#include file="class/clsJob.asp" -->

<%
    dim userModelNo

    userModelNo = Request.Form("user_model_no")

    Response.Write isModelNoAChangeover(userModelNo)
%>