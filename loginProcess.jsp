<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*" %>
<%
    // 데이터베이스 연결 정보 설정
    String url = "jdbc:mysql://localhost:3306/jspi";

    // 폼으로부터 전달된 로그인 정보 수집
    String id = request.getParameter("Userid");
    String password = request.getParameter("UPassword");

    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.DriverManager.getConnection(dbURL, "jspi", "jspteami!1");

        // 입력된 아이디와 비밀번호로 회원 조회 쿼리 실행
        String query = "SELECT * FROM Users WHERE ID = ? AND Password = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, id);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        // 회원 인증 성공 시 로그인 세션 생성
        if (rs.next()) {
            String name = rs.getString("Name");
            // 로그인 세션 생성
            session.setAttribute("Username", id);
            session.setAttribute("Name", name);
            response.sendRedirect("Test.html"); // 로그인 성공 후 이동할 페이지
        } else {
            // 인증 실패 시 로그인 페이지로 이동 또는 오류 처리
            response.sendRedirect("login.html"); // 로그인 실패 시 이동할 페이지
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
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
    out.println("<meta http-equiv='Refresh' content='1;URL=test.html'>");
%>