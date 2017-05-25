<%
function addCustomer(strFirstname, strLastname, strAddress, strCity, strState, intPostcode, strPhone, strEmail, strProduct, strPurchaseDate, strDeliveryDate, strSerialNo, intDealerID, strComments)
	dim strSQL
	
	call OpenDataBase()
		
	strSQL = "INSERT INTO yma_premium_care (firstname, lastname, address, city, state, postcode, phone, email, product, purchase_date, delivery_date, serial_no, comments, dealer_id, online, serial_no_check, status) VALUES ("
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strFirstname)) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strLastname)) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strAddress)) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strCity)) & "',"		
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strState)) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(intPostcode)) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strPhone)) & "',"
	strSQL = strSQL & "'" & Trim(strEmail) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strProduct)) & "',"
	strSQL = strSQL & "CONVERT(datetime,'" & Trim(strPurchaseDate) & "',103),"
	strSQL = strSQL & "CONVERT(datetime,'" & Trim(strDeliveryDate) & "',103),"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strSerialNo)) & "',"
	strSQL = strSQL & "'" & Server.HTMLEncode(Trim(strComments)) & "',"
	strSQL = strSQL & "'" & intDealerID & "',1,0,0)"
	
	response.Write strSQL
	on error resume next
	conn.Execute strSQL
	
	if err <> 0 then
		strMessageText = err.description
	else						
		Set JMail=CreateObject("JMail.SMTPMail")
		
		JMail.ServerAddress = "smtp.bne.server-mail.com"
		JMail.Subject		= "Premium Piano Care Program"
		JMail.Sender		= "au_webmaster@gmx.yamaha.com"
		JMail.SenderName	= "Yamaha Music Australia"	
		JMail.AddRecipient (strEmail)		
		JMail.Body    	= "Dear " & strFirstname & " " & strLastname & "," & vbCrLf _
						& "" & vbCrLf _
						& "Thank you for your online Yamaha piano registration which has been received successfully. A record of your purchase will be kept by Yamaha to assist in the unlikely event of a warranty claim. " & vbCrLf _
						& "" & vbCrLf _
						& "By registering online, you have been made eligible for a complimentary tuning of your new Yamaha piano. Once your registration details have been confirmed, you will be sent a voucher for your free tuning (or multiple vouchers in the case of C Series grand pianos). Please allow up to four weeks for your voucher(s) to arrive." & vbCrLf _ 
						& "" & vbCrLf _
						& "Your piano will have received a set-up and tune by your piano dealer prior to its delivery so will be ready to play from the moment you receive it in to your home. It is normal, however, for your piano to go slightly out of tune following delivery due to it settling into its new environment. Yamaha Music Australia recommends having your first in-home tune performed between one and three months after delivery by which time your piano should have fully settled." & vbCrLf _ 
						& "" & vbCrLf _
						& "Once you have received your tuning voucher(s) in the mail, please contact the piano dealer from whom you purchased your piano to organise your first in-home tuning. The piano technician who performs this first in-home tuning will require you to provide the tuning voucher(s) at the time of the visit so it is important to keep the voucher in a safe place." & vbCrLf _
						& "" & vbCrLf _
						& "It is generally recommended that you tune your piano at least once every six months following the initial in-home tuning, however, this may vary depending on your local conditions and personal circumstances, so please discuss this with the piano technician who performs your initial tuning." & vbCrLf _ 
						& "" & vbCrLf _
						& "If you have an urgent tuning requirement, or if you have any questions about the registration process, please contact the piano dealer from whom you purchased your piano or, alternatively, contact me on 03 9693 5213." & vbCrLf _ 
						& "" & vbCrLf _
						& "Congratulations on your purchase. I trust that it will provide you with a lifetime of musical enjoyment and satisfaction." & vbCrLf _ 
						& "" & vbCrLf _	
						& "Yours sincerely," & vbCrLf _
						& " " & vbCrLf _
						& "Eric Ong" & vbCrLf _
						& "Piano Technical Manager" & vbCrLf _
						& "Yamaha Music Australia" & vbCrLf _
						& "eric.ong@music.yamaha.com"
		JMail.Execute			
		set JMail = nothing	
		response.Redirect("thank-you.html")
	end if
	
	call CloseDataBase()
end function
%>