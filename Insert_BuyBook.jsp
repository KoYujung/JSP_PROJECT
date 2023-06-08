<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<html>
<head>
<meta charset="UTF-8">
<title>책 정보 연동 페이지(구매)</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
    Connection con = null;
    request.setCharacterEncoding("UTF-8");

    PreparedStatement pstmt = null;
	Statement stmt = null;
    StringBuffer SQL = new StringBuffer("insert into BUY_BOOK(TITLE, AUTH, PUBL, HOPE, CATE) "); 
    SQL.append("values (?, ?, ?, ?, ?)");

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12?useUnicode=true&characterEncoding=UTF-8";

    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
 //       pstmt = con.prepareStatement(sql);
 //       pstmt.executeUpdate();

        pstmt = con.prepareStatement(SQL.toString());
        pstmt.setString(1, request.getParameter("TITLE"));
        pstmt.setString(2, request.getParameter("AUTH"));
        pstmt.setString(3, request.getParameter("PUBL"));
        int hope = Integer.parseInt(request.getParameter("HOPE"));
		pstmt.setInt(4, hope);
        pstmt.setString(5, request.getParameter("CATE"));

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1) out.println("책 레코드 하나가 성공적으로 삽입 되었습니다.<hr>");
        else out.println("책 레코드 삽입에 문제가 있습니다.");

        stmt = con.createStatement();

    }
    catch(Exception e) {
    	out.println("MySql 데이터베이스의 BUY_BOOK 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
	out.println("<meta http-equiv='Refresh' content='1;URL=Buy_BookList.jsp'>");
%>

<p><hr>

</body>
</html>