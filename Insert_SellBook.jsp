<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>책 정보 연동 페이지(판매)</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
	Statement stmt = null;
    StringBuffer SQL = new StringBuffer("insert into BOOK(TITLE, AUTH, PUBL, FIXED, SELL, DET, IMG, COVER, HIGHPEN, PENCIL, WNAME, FPART, CATE) "); 
    SQL.append("values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

	String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/jspi";

    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "jspi", "jspteami!1");
 //       pstmt = con.prepareStatement(sql);
 //       pstmt.executeUpdate();

        pstmt = con.prepareStatement(SQL.toString());
        pstmt.setString(1, request.getParameter("TITLE"));
        pstmt.setString(2, request.getParameter("AUTH"));
        pstmt.setString(3, request.getParameter("PUBL"));
        int fixed = Integer.parseInt(request.getParameter("FIXED"));
		pstmt.setInt(4, fixed);
        int sell = Integer.parseInt(request.getParameter("SELL"));
		pstmt.setInt(5, sell);
        pstmt.setString(6, request.getParameter("DET"));
        pstmt.setString(7, request.getParameter("IMG"));
        pstmt.setString(8, request.getParameter("COVER"));
        pstmt.setString(9, request.getParameter("HIGHPEN"));
        pstmt.setString(10, request.getParameter("PENCIL"));
        pstmt.setString(11, request.getParameter("WNAME"));
        pstmt.setString(12, request.getParameter("FPART"));
        pstmt.setString(13, request.getParameter("CATE_ID"));

        int rowCount = pstmt.executeUpdate();        
        if (rowCount == 1) out.println("책 레코드 하나가 성공적으로 삽입 되었습니다.<hr>");
        else out.println("책 레코드 삽입에 문제가 있습니다.");

        stmt = con.createStatement();

    }
    catch(Exception e) {
    	out.println("MySql 데이터베이스 jspi의 BOOK 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
	out.println("<meta http-equiv='Refresh' content='1;URL=list.jsp'>");
%>

<p><hr>

</body>
</html>