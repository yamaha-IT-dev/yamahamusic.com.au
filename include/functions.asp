<%
'------------------------------------------------------ (UPDATE) GET FUNCTIONS -------------------------------------------------------------------
'*****************************************************
' Purpose: 	Create a job folder when adding a new job
' Inputs:	
' Returns: 	A new folder in tech
' Author:	
' Revision:
' Date:
' Files:	update_job.asp, view_job.asp
'*****************************************************
function CreateJobfolder(strClientCode, strJobCode, strJobTitle)

    '=== remove any invalid charracters from the filepath
    strJobTitle = replace(strJobTitle,"\","")
    strJobTitle = replace(strJobTitle,"/","")
    strJobTitle = replace(strJobTitle,":","")
    strJobTitle = replace(strJobTitle,"*","")
    strJobTitle = replace(strJobTitle,"?","")
    strJobTitle = replace(strJobTitle,"""","")
    strJobTitle = replace(strJobTitle,"<","")
    strJobTitle = replace(strJobTitle,">","")
    strJobTitle = replace(strJobTitle,"|","")

    dim fs
    set fs = Server.CreateObject("Scripting.FileSystemObject")
    
    '=== if the parent folder exists
    if(fs.FolderExists(strProjectFolderPath))then
    
  '  Dim x
  '  x = fs.Dir(strProjectFolderPath &"\*")
        '=== check if clients folder exists, if not create it
        if not(fs.FolderExists(strProjectFolderPath & strClientCode))then
            fs.CreateFolder strProjectFolderPath & strClientCode
        end if
        
        '=== check if job folder exists, if not create it
        if not(fs.FolderExists(strProjectFolderPath & strClientCode &"\"& strClientCode &"-"& strJobCode & " - " & strJobTitle))then
            fs.CopyFolder strProjectFolderPath & "\..\ZZ_Job Folders Directory",strProjectFolderPath & strClientCode &"\"& strClientCode &"-"& strJobCode & " - " & strJobTitle    
        end if
    
    end if
     
    set fs=nothing

'Dir("C:\Jobs\Adhoc\4999*", vbDirectory)

end function 

'*****************************************************
' Purpose: 	Checks if a folder existis on the project folders
' Inputs: 	The strings that make up the folder path
' Returns: 	boolean
' Author:	
' Revision:
' Date:
' Files:
'*****************************************************

function JobfolderExists(strClientCode, strJobCode, strJobTitle)
    dim fs
    set fs = Server.CreateObject("Scripting.FileSystemObject")
    JobfolderExists =  fs.FolderExists(strProjectFolderPath & strClientCode &"\"& strClientCode &"-"& strJobCode & " - " & strJobTitle)
    set fs=nothing
end function 

'**********************************************************
' Purpose: 	Listing all result per page numbers for client list
' Inputs: 	NA
' Returns: 	a list of all available result per page numbers
' Author: 	Harsono
' Revision:
' Date:
' Files: 	list_client.asp
'**********************************************************
function getClientResultSize

    dim arrResultText
    dim arrResultID
    dim intCounter

    arrResultText = split(arrPageSizeText, ",")
    arrResultID = split(arrPageSizeID, ",")
    
    ' We check if there is anything
    if isarray(arrResultID) then
        if ubound(arrResultID) > 0 then
        
            for intCounter = 0 to ubound(arrResultID)
                if trim(request("cboClientResultSize")) = trim(arrResultID(intCounter)) or trim(session("client_record_per_page")) = trim(arrResultID(intCounter)) then
                    strClientResultList = strClientResultList & "<option selected value=" & arrResultID(intCounter) & ">" & arrResultText(intCounter) & "</option>"                    
                else
                    strClientResultList = strClientResultList & "<option value=" & arrResultID(intCounter) & ">" & arrResultText(intCounter) & "</option>"
                end if
             
            next
        end if
    
    end if

end function

'*****************************************************
' Purpose: 	This gets all current Quetstring elements to main search & sort on the job page.
'           If new valeus are added to this querystring this function will need to incorporate them
' Inputs: 	NA
' Returns: 	a string of querystring values
' Author: 	Steve J
' Revision:
' Date:
' Files: list_job.asp, view_job, update_job, header
'*****************************************************
function createQuerystring()

Dim strQs

strQs = strQs & "sortitem="              & Request("sortitem") 
strQs = strQs & "&order="                & Request("order") 
strQs = strQs & "&txtSearch="            & Request("txtSearch") 
strQs = strQs & "&cboDepartment="        & Request("cboDepartment") 
strQs = strQs & "&cboJobCode="           & Request("cboJobCode") 
strQs = strQs & "&cboJobStatus="         & Request("cboJobStatus") 
strQs = strQs & "&cboJobType="           & Request("cboJobType") 
strQs = strQs & "&cboPriority="          & Request("cboPriority") 
strQs = strQs & "&cboPrimaryResource="   & Request("cboPrimaryResource") 

createQuerystring = strQs

end function

'P1********************************************************************************
'Procedure		:DATE_ddMMMyyyy
'Arguments		:dateString		- given date to format
'Purpose		:Takes the given date and formats it into dd MMM yyyy eg 02 JUN 2003
'Output			:Formatted date
'Dependancies	:NA
'Special Info	:NA
'P2********************************************************************************
Function DATE_ddMMMyyyy(dateString)

 'check the date is 10 chars long, to be formatted
 if len (dateString)>=10 then

    Dim monthName

	'=== set a string for the correct month
	Select case DatePart("M", dateString)
	    case 1   monthName = "JAN"
	    case 2   monthName = "FEB"
	    case 3   monthName = "MAR"
	    case 4   monthName = "APR"
	    case 5   monthName = "MAY"
	    case 6   monthName = "JUN"
	    case 7   monthName = "JUL"
	    case 8   monthName = "AUG"
	    case 9   monthName = "SEP"
        case 10  monthName = "OCT"
        case 11  monthName = "NOV"
        case 12  monthName = "DEC"	
	end Select
		
	'=== pad a leading zero to day if necessary
	If DatePart("D", dateString) < 10 Then
		UTL_JoinStrings DATE_ddMMMyyyy, "0"
	End If
	
	'=== concatenate the date parts to produce the  output string
	UTL_JoinStrings DATE_ddMMMyyyy, DatePart("D", dateString) & " " & monthName & " " & DatePart("YYYY", dateString)
    DATE_ddMMMyyyy = "<NOBR>" & DATE_ddMMMyyyy & "</NOBR>"
	 else
	    DATE_ddMMMyyyy =" - "
	 end if
	 	
End Function

'*****************************************************
' Purpose: 	Get the State from /include/constants.asp
' Inputs: 	NA
' Returns: 	a dropdown list of all states 
' Author: 	Harsono Setiono
' Revision:
' Date:		15 Sept 2009
' Files: 	add_customer.asp, update_customer.asp
'*****************************************************

function getState

    dim arrStateFillText
    dim arrStateFillID
    dim intCounter

    arrStateFillText = split(arrStateText, ",")
    arrStateFillID 	 = split(arrStateID, ",")
    
    strStateList = strStateList & "<option value=''>...</option>"
    
    'We check if there is anything
    if isarray(arrStateFillID) then
        if ubound(arrStateFillID) > 0 then        
            for intCounter = 0 to ubound(arrStateFillID)                
                if trim(session("state")) = trim(arrStateFillID(intCounter)) then
                	strStateList = strStateList & "<option selected value=" & arrStateFillID(intCounter) & ">" & arrStateFillText(intCounter) & "</option>"
                else
                   	strStateList = strStateList & "<option value=" & arrStateFillID(intCounter) & ">" & arrStateFillText(intCounter) & "</option>"
                end if             
            next
        end if    
    end if

end function

'*****************************************************
' Purpose: 	Get the Month from /include/constants.asp
' Inputs: 	NA
' Returns: 	a dropdown list of all months
' Author: 	Harsono Setiono
' Revision:
' Date:		15 Sept 2009
' Files: 	add_customer.asp, update_customer.asp
'*****************************************************

function getMonth

    dim arrMonthFillText
    dim arrMonthFillID
    dim intCounter

    arrMonthFillText = split(arrMonthText, ",")
    arrMonthFillID 	 = split(arrMonthID, ",")
    
    strMonthList = strMonthList & "<option value=''>...</option>"
    
    'We check if there is anything
    if isarray(arrMonthFillID) then
        if ubound(arrMonthFillID) > 0 then        
            for intCounter = 0 to ubound(arrMonthFillID)                
                if trim(session("purchase_month")) = trim(arrMonthFillID(intCounter)) then
                	strMonthList = strMonthList & "<option selected value=" & arrMonthFillID(intCounter) & ">" & arrMonthFillText(intCounter) & "</option>"
                else
                   	strMonthList = strMonthList & "<option value=" & arrMonthFillID(intCounter) & ">" & arrMonthFillText(intCounter) & "</option>"
                end if             
            next
        end if    
    end if

end function

'*****************************************************
' Purpose: 	Get the Year from /include/constants.asp
' Inputs: 	NA
' Returns: 	a dropdown list of year 2008 / 2009
' Author: 	Harsono Setiono
' Revision:
' Date:		15 Sept 2009
' Files: 	add_customer.asp, update_customer.asp
'*****************************************************

function getYear

    dim arrYearFillText
    dim arrYearFillID
    dim intCounter

    arrYearFillText = split(arrYearText, ",")
    arrYearFillID 	= split(arrYearID, ",")
    
    strYearList = strYearList & "<option value=''>...</option>"
    
    'We check if there is anything
    if isarray(arrYearFillID) then
        if ubound(arrYearFillID) > 0 then        
            for intCounter = 0 to ubound(arrYearFillID)                
                if trim(session("purchase_year")) = trim(arrYearFillID(intCounter)) then
                	strYearList = strYearList & "<option selected value=" & arrYearFillID(intCounter) & ">" & arrYearFillText(intCounter) & "</option>"
                else
                   	strYearList = strYearList & "<option value=" & arrYearFillID(intCounter) & ">" & arrYearFillText(intCounter) & "</option>"
                end if             
            next
        end if    
    end if

end function

'*****************************************************
' Purpose: 	Get the Product from /include/constants.asp
' Inputs: 	NA
' Returns: 	a dropdown list of all products
' Author: 	Harsono Setiono
' Revision:
' Date:		15 Sept 2009
' Files: 	add_customer.asp, update_customer.asp
'*****************************************************

function getProduct

    dim arrProductFillText
    dim arrProductFillID
    dim intCounter

    arrProductFillText 	= split(arrProductText, ",")
    arrProductFillID 	= split(arrProductID, ",")
    
    strProductList = strProductList & "<option value=''>...</option>"
    
    'We check if there is anything
    if isarray(arrProductFillID) then
        if ubound(arrProductFillID) > 0 then        
            for intCounter = 0 to ubound(arrProductFillID)                
                if trim(session("model_no")) = trim(arrProductFillID(intCounter)) then
                	strProductList = strProductList & "<option selected value=" & arrProductFillID(intCounter) & ">" & arrProductFillText(intCounter) & "</option>"
                else
                   	strProductList = strProductList & "<option value=" & arrProductFillID(intCounter) & ">" & arrProductFillText(intCounter) & "</option>"
                end if             
            next
        end if    
    end if

end function


' I placed this in a function so I wouldn't have to worry about
' any namespace collisions.  For example... if this was inline
' code and someone named a variable strSQL in a file this file
' gets included into you'd get an error.  This way you don't and
' there's no chance of the variables overwriting one another!
Function RetrieveAndIncrementCount()
	' From adovbs.inc:
	Const adOpenKeyset = 1
	Const adLockPessimistic = 2
	Const adCmdText = &H0001

	' Local variables
	Dim strFilename
	Dim strSQL
	Dim rsCounter
	Dim iCount

	' Get filename and build SQL query
	strFilename = Request.ServerVariables("SCRIPT_NAME")
	strSQL = "SELECT page_name, hit_count FROM hit_count WHERE page_name='" & strFilename & "';"

	' Open our recordset
	Set rsCounter = Server.CreateObject("ADODB.Recordset")
	
	' Access version:
	'rsCounter.Open strSQL, _
	'	"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("counter_db.mdb") & ";", _
	'	adOpenKeyset, adLockPessimistic, adCmdText
	
	' SQL Server version:
	call OpenDataBase()
	'rsCounter.Open strSQL, "Provider=SQLOLEDB;Data Source=10.2.2.133;" _
	'	& "Initial Catalog=samples;User Id=samples;Password=password;" _
	'	& "Connect Timeout=15;Network Library=dbmssocn;", _
	'	adOpenKeyset, adLockPessimistic, adCmdText

	' If we've got a record then we read the current value
	' If we don't then we create one, set the filename, and start at 0
	If rsCounter.EOF Then
		rsCounter.AddNew

		iCount = 0

		rsCounter.Fields("page_name").Value = strFilename
	Else
		rsCounter.MoveFirst

		iCount = rsCounter.Fields("hit_count").Value
	End If

	' Increment the count and update the DB
	rsCounter.Fields("hit_count").Value = iCount + 1
	rsCounter.Update

	' Close our connection
	rsCounter.Close
	Set rsCounter = Nothing

	' Return the count (pre-incrementation).
	RetrieveAndIncrementCount = iCount
End Function



%>