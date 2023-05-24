<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // 데이터베이스 연결 정보 설정
    String dbURL = "jdbc:mysql://localhost:3306/jsp12";
    String dbUsername = "root";
    String dbPassword = "kbc0924";

    // 폼으로부터 전달된 로그인 정보 수집
    String UPASS = request.getParameter("ID");
    String UPASS = request.getParameter("UPASS");

    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        // 입력된 아이디와 비밀번호로 회원 조회 쿼리 실행
        String query = "SELECT * FROM Users WHERE ID = ? AND UPASS = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, ID);
        pstmt.setString(2, UPASS);
        rs = pstmt.executeQuery();

        // 회원 인증 성공 시 로그인 세션 생성
        if (rs.next()) {
            String name = rs.getString("Username");
            // 로그인 세션 생성
            session.setAttribute("ID", ID);
            session.setAttribute("UPASS", UPASS);
            response.sendRedirect("Test.html"); // 로그인 성공 후 이동할 페이지
        } else {
            // 인증 실패 시 로그인 페이지로 이동 또는 오류 처리
            response.sendRedirect("login.html"); // 로그인 실패 시 이동할 페이지
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

create table User