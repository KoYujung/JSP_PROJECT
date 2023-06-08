<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>책 정보 연동 페이지(판매)</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
    Connection con = null;
    request.setCharacterEncoding("UTF-8");

    PreparedStatement pstmt = null;
	Statement stmt = null;
    StringBuffer SQL = new StringBuffer("insert into SELL_BOOK(TITLE, AUTH, PUBL, FIXED, SELL, DET, IMG, COVER, HIGHPEN, PENCIL, WNAME, FPART, CATE) "); 
    SQL.append("values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12?useUnicode=true&characterEncoding=UTF-8";

    try {
        String encoding    = "euc-kr";
		int sizeLimit = 10 * 1024 * 1024; 
		String relativeDirectory = "contents/";
		ServletContext context = getServletContext();
		String realDirectory = context.getRealPath(relativeDirectory);
		MultipartRequest multi = new MultipartRequest(request, realDirectory, sizeLimit, encoding, new DefaultFileRenamePolicy());
		// String name = multi.getParameter("fname");
		String my_image = multi.getFilesystemName("IMG");

		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
 //       pstmt = con.prepareStatement(sql);
 //       pstmt.executeUpdate();

        pstmt = con.prepareStatement(SQL.toString());
        // String parameter = request.getParameter("TITLE");
        // String encodedParameter = new String(parameter.getBytes("ISO-8859-1"), "UTF-8");
        // pstmt.setString(1, encodedParameter);
        // out.println(request.getParameter("TITLE"));
        // out.println(parameter);
        // out.println(encodedParameter);
        pstmt.setString(1, multi.getParameter("TITLE"));
        pstmt.setString(2, multi.getParameter("AUTH"));
        pstmt.setString(3, multi.getParameter("PUBL"));
        int fixed = Integer.parseInt(multi.getParameter("FIXED"));
		pstmt.setInt(4, fixed);
        int sell = Integer.parseInt(multi.getParameter("SELL"));
		pstmt.setInt(5, sell);
        pstmt.setString(6, multi.getParameter("DET"));
        pstmt.setString(7, my_image);
        pstmt.setString(8, multi.getParameter("COVER"));
        pstmt.setString(9, multi.getParameter("HIGHPEN"));
        pstmt.setString(10, multi.getParameter("PENCIL"));
        pstmt.setString(11, multi.getParameter("WNAME"));
        pstmt.setString(12, multi.getParameter("FPART"));
        pstmt.setString(13, multi.getParameter("CATE"));

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1) out.println("책 레코드 하나가 성공적으로 삽입 되었습니다.<hr>");
        else out.println("책 레코드 삽입에 문제가 있습니다.");

        stmt = con.createStatement();

    }
    catch(Exception e) {
    	out.println("MySql 데이터베이스의 BOOK 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
    out.println("<meta http-equiv='Refresh' content='1;URL=Sell_BookList.jsp'>");
%>

<p><hr>

</body>
</html>