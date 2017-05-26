<%
'-----------------------------------------------
' GET CATEGORIES
'-----------------------------------------------
function getCategoryList
    dim strSQL
    dim rs
	dim strCategory
	
    call OpenDataBase()
    
	strSQL = "SELECT DISTINCT prod_category FROM tbl_product_1113 "
	strSQL = strSQL & "	ORDER BY prod_category"
		
	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)
    
    'strCategoryList = strCategoryList & "<option value=''>...</option>"
     
    if not DB_RecSetIsEmpty(rs) Then
        do until rs.EOF			
        	strCategory 	= trim(rs("prod_category"))			
            'if trim(session("prod_category")) = strCategory then
            '    strCategoryList = strCategoryList & "<option selected value=" & strCategory & ">" & strCategory & "</option>"
            'else
                strCategoryList = strCategoryList & "<option value=" & strCategory & ">" & strCategory & "</option>"
            'end if                    
        rs.Movenext
        loop
    end if
    
    call CloseDataBase()
end function

'-----------------------------------------------
' GET SUB CATEGORIES
'-----------------------------------------------
function getSubCategoryList(strCategory)
    dim strSQL
    dim rs
	dim strSubCategory
	
    call OpenDataBase()
    
	strSQL = "SELECT DISTINCT prod_sub_category FROM tbl_product_1113 "
	strSQL = strSQL & "	WHERE prod_category LIKE '%" & strCategory & "%'"
	strSQL = strSQL & "	ORDER BY prod_sub_category"
		
	response.write strSQL	
		
	set rs = server.CreateObject("ADODB.Recordset")
    set rs = conn.execute(strSQL)
    
    strSubCategoryList = strSubCategoryList & "<option value=''>All Sub Categories</option>"
     
    if not DB_RecSetIsEmpty(rs) Then
        do until rs.EOF			
        	strSubCategory 	= trim(rs("prod_sub_category"))			
            'if trim(session("prod_category")) = strSubCategory then
            '    strSubCategoryList = strSubCategoryList & "<option selected value=" & strSubCategory & ">" & strSubCategory & "</option>"
            'else
                strSubCategoryList = strSubCategoryList & "<option value=" & strSubCategory & ">" & strSubCategory & "</option>"
            'end if                    
        rs.Movenext
        loop
    end if
    
    call CloseDataBase()
end function
%>