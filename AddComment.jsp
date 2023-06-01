<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %> <!-- JDBC 관련 클래스 import -->

<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터의 인코딩 설정

    String postID = request.getParameter("post_id");
    String userID = request.getParameter("user_id");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;

    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12?useUnicode=true&characterEncoding=UTF-8";

    try {
        Class.forName(driverName);
        conn = DriverManager.getConnection(dbURL, "root", "kbc0924");

        String query = "INSERT INTO COMMENTS (POST_ID, USER_ID, CONTENT) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(postID));
        pstmt.setString(2, userID);
        pstmt.setString(3, content);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<%
    String redirectURL = "Buy_BookList.jsp?pno=" + postID;
    response.sendRedirect(redirectURL);
%>
