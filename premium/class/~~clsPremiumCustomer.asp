<%
function addPremiumCustomer
	Dim cmdObj, paraObj, strMessageText

    call OpenDataBase

    Set cmdObj = Server.CreateObject("ADODB.Command")
    cmdObj.ActiveConnection = conn
    cmdObj.CommandText = "spAddPremiumCustomer"
    cmdObj.CommandType = AdCmdStoredProc

    session("firstname") 	= Replace(Trim(Request.Form("txtFirstname")),"'","''")
	session("lastname") 	= Replace(Trim(Request.Form("txtLastname")),"'","''")
	session("address")		= Replace(Trim(Request.Form("txtAddress")),"'","''")
	session("city")			= Replace(Trim(Request.Form("txtCity")),"'","''")
	session("state")		= Trim(Request.Form("cboState"))
	session("postcode")		= Trim(Request.Form("txtPostcode"))
	session("phone")		= Replace(Trim(Request.Form("txtPhone"))," ","")
	session("email")		= Lcase(Replace(Trim(Request.Form("txtEmail"))," ",""))
	session("product")		= Replace(Trim(Request.Form("txtProduct")),"'","''")
	session("purchase_date")= Replace(Trim(Request.Form("txtPurchaseDate")),"'","''")
	session("delivery_date")= Replace(Trim(Request.Form("txtDeliveryDate")),"'","''")
	session("serial_no")	= Replace(Trim(Request.Form("txtSerialNo")),"'","''")
	session("dealer_id")	= Trim(Request.Form("cboDealer"))
	session("comments")		= Replace(Trim(Request.Form("txtComments")),"'","''")
	
	if Trim(Request.Form("chkCashBack")) = "" then
		session("cashback")		= 0
	else
		session("cashback")		= Trim(Request.Form("chkCashBack"))
	end if
	
	Set paraObj = cmdObj.CreateParameter("@firstname",AdVarChar,AdParamInput,50, session("firstname"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@lastname",AdVarChar,AdParamInput,50, session("lastname"))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("@address",AdVarChar,AdParamInput,100, session("address"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@city",AdVarChar,AdParamInput,50, session("city"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@state",AdVarChar,AdParamInput,10, session("state"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@postcode",AdVarChar,AdParamInput,10, session("postcode"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@phone",AdVarChar,AdParamInput,50, session("phone"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@email",AdVarChar,AdParamInput,50, session("email"))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("@product",AdVarChar,AdParamInput,80, session("product"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@purchase_date",AdVarChar,AdParamInput,20, session("purchase_date"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@delivery_date",AdVarChar,AdParamInput,20, session("delivery_date"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@serial_no",AdVarChar,AdParamInput,15, session("serial_no"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@comments",AdVarChar,AdParamInput,255, session("comments"))
	cmdObj.Parameters.Append paraObj
	Set paraObj = cmdObj.CreateParameter("@dealer_id",AdInteger,AdParamInput,2, session("dealer_id"))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("@cashback",AdInteger,AdParamInput,2, session("cashback"))
	cmdObj.Parameters.Append paraObj	
	Set paraObj = cmdObj.CreateParameter("new_id",AdInteger,adParamInputOutput,4,0)
	cmdObj.Parameters.Append paraObj
	
    On Error Resume Next
        Dim rs
        Dim id
        set rs = cmdObj.Execute
        id = rs(0)
        set rs = nothing
    On error Goto 0

    if CheckForSQLError(conn,"Add",MessageText) = TRUE then
		strMessageText = err.description
		
		response.write "Error" & err.description
    else
		session("new_id") 	= cmdObj("new_id")
		
		Set JMail=CreateObject("JMail.SMTPMail")
		
			JMail.ServerAddress = "smtp.bne.server-mail.com"
			JMail.Subject		= "Premium Piano Care Program"
			JMail.Sender		= "eric.ong@music.yamaha.com"
			JMail.SenderName	= "Yamaha Music Australia"
			JMail.AddRecipient (session("email"))
			JMail.Body    	= "Dear " & session("firstname") & " " & session("lastname") & "," & vbCrLf _
							& "" & vbCrLf _
							& "Thank you for your online Yamaha piano registration which has been received successfully. A record of your purchase will be kept by Yamaha to assist in the unlikely event of a warranty claim. Your piano is backed back our 10 year manufacturer's warranty, which gives you peace of mind in your precious investment (for more information about the Yamaha Manufacturer's Warranty for pianos, please visit http://au.yamaha.com/en/support/warranty_non_warranty_cases/piano/)." & vbCrLf _
							& "" & vbCrLf _
							& "By registering online, you also have been made eligible for a complimentary tuning of your new Yamaha piano. Once your registration details have been confirmed, you will be emailed an e-voucher for your free tuning. Please allow up to five working days for the voucher to be processed." & vbCrLf _
							& "" & vbCrLf _
							& "Your piano will have received a set-up and tune by your piano dealer prior to its delivery so will be ready to play from the moment you receive it in to your home. It is normal, however, for your piano to go slightly out of tune following delivery due to it settling into its new environment. Yamaha Music Australia recommends having your first in-home tune performed between one and three months after delivery by which time your piano should have fully settled." & vbCrLf _
							& "" & vbCrLf _
							& "Once you have received your tuning e-voucher, please contact the piano dealer from whom you purchased your piano to organise your first in-home tuning. Alternatively, you can visit http://yamaha-corporation.force.com/dealers/au_servicecentre to locate your Yamaha Accredited Service Agent. The Yamaha Accredited Service Agent who performs this first in-home tuning will require you to provide the tuning e-voucher at the time of the visit so it is important to print this voucher off and keep it in a safe place." & vbCrLf _
							& "" & vbCrLf _
							& "It is generally recommended that you tune your piano at least once every six months following the initial in-home tuning, however, this may vary depending on your local conditions and personal circumstances, so please discuss this with the Yamaha Accredited Service Agent who performs your initial tuning." & vbCrLf _
							& "" & vbCrLf _
							& "If you have an urgent tuning requirement, or if you have any questions about the registration process, please contact the piano dealer from whom you purchased your piano or, alternatively, contact me on 03 9693 5213." & vbCrLf _
							& "" & vbCrLf _
							& "Congratulations on your " & session("product") & " purchase. I trust that it will provide you with a lifetime of musical enjoyment and satisfaction." & vbCrLf _
							& "" & vbCrLf _
							& "Yours sincerely," & vbCrLf _
							& " " & vbCrLf _
							& "Eric Ong" & vbCrLf _
							& "Piano Technical Manager" & vbCrLf _
							& "Yamaha Music Australia" & vbCrLf _
							& "eric.ong@music.yamaha.com"
			JMail.Execute			
			set JMail = nothing	
		
		if session("cashback") = "1" then	
			Response.Redirect("upload.asp")
		else					
			Response.Redirect("thank-you.html")
		end if	
    end if

    Call DB_closeObject(paraObj)
    Call DB_closeObject(cmdObj)

    call CloseDataBase
end function
%>