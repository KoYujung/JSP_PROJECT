<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*" %>
<%
    // 데이터베이스 연결 정보 설정
    String url = "jdbc:mysql://localhost:3306/jspi";

    // 폼으로부터 전달된 회원 정보 수집
    String id = request.getParameter("Userid");
    String name = request.getParameter("Username");
    String password = request.getParameter("UPassword");
    String email = request.getParameter("Email");
    String phone = request.getParameter("Phone");

    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, "jspi", "jspteami!1");

        // 회원 정보를 데이터베이스에 저장하는 쿼리 실행
        String query = "INSERT INTO Users (ID, Name, Password, Email, Phone) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, id);
        pstmt.setString(2, name);
        pstmt.setString(3, password);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.executeUpdate();

        // 회원가입 성공 시 로그인 페이지로 이동 또는 환영 메시지 출력
        response.sendRedirect("login.jsp"); // 회원가입 성공 시 이동할 페이지
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
    out.println("<meta http-equiv='Refresh' content='1;URL=login.html'>");
%>
