<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리 페이지</title>
</head>
<body>


<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터의 인코딩 설정

    // 폼에서 전달된 회원가입 정보 가져오기
    String userID = request.getParameter("ID");
    String name = request.getParameter("UNAME");
    String password = request.getParameter("UPASS");
    String email = request.getParameter("UEMAIL");
    String phoneNumber = request.getParameter("UTELL");

    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;

    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";

    try {
        // 데이터베이스 연결
        Class.forName(driverName);
        conn = DriverManager.getConnection(dbURL, "root", "kbc0924");

        // 회원 등록을 위한 쿼리 실행
        String query = "INSERT INTO USER (ID, UNAME, UPASS, UEMAIL, UTELL) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userID);
        pstmt.setString(2, name);
        pstmt.setString(3, password);
        pstmt.setString(4, email);
        pstmt.setString(5, phoneNumber);
        pstmt.executeUpdate();

        // 회원 등록 성공
        out.println("회원 등록 성공!");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 사용한 리소스 해제
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
    out.println("<meta http-equiv='Refresh' content='1;URL=login.html'>");
%>

<p><hr>

</body>
</html>