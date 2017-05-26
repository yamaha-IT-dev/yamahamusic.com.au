<%@LANGUAGE="JScript"%>
<!--#include file="../../src/global.asp" -->
<!--#include file="../../src/utility.asp" -->
<%




	var strSQL = "SELECT " +
				 "    ymadex_resource.* " +
				 "FROM " +
				 "    ymadex_resource " +
				 "WHERE " +
				 "    1 = 1 " +
				 "    AND ymadex_resource.division = 'TRAD' " +
				 "ORDER BY " +
				 "    ymadex_resource.datecreated DESC";

	var rs = Server.CreateObject("ADODB.Recordset");
		rs.Open(strSQL, GBL_CONN, 3, 3);

	var FSO = Server.CreateObject("Scripting.FileSystemObject");

	var destination = Server.MapPath("../images/dealerex/trad/");

	if (!rs.EOF)
	{

		while (!rs.EOF)
		{
			if (rs("filesrclg") != "")
			{
				var filesrcsm = new String(rs("filesrclg"));
					filesrcsm = filesrcsm.substring(24, filesrcsm.length);
				%>Tryin' : <strong><%= filesrcsm %></strong> <%

				try {

					var original = Server.MapPath("../../amp/resources/images/" + filesrcsm);

// Response.Write(original + " - " + destination);

					if (FSO.FileExists(original) && FSO.FolderExists(destination))
					{
						// FSO.CopyFile(original, destination, true)

						FSO.CopyFile("c:\\inetpub\\redev\\amp\\resources\\images\\" + filesrcsm,
									 "c:\\inetpub\\redev\\dealers\\images\\dealerex\\trad\\", true)

						%> - Done!<%
					}
					else
					{
						%> - didn't exist?!<%
					}

				} catch (e) {

					%> - SHIT - <%= e.description %><%
				}
			}
			%><br/><%
			rs.MoveNext();
		}




	}




%>
