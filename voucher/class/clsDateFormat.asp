<%
function displayDateFormatted(strDateInput)	
	if IsNull(strDateInput) or strDateInput = "01/01/1900" or strDateInput = "1/1/1900"  then 
		response.write "-"
	else
		response.write "" & FormatDateTime(strDateInput,1)
	end if
end function
%>