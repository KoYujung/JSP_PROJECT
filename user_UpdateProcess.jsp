<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터의 인코딩 설정

    // 폼에서 전달된 회원정보 가져오기
    String userID = request.getParameter("ID");
    String password = request.getParameter("UPASS");
    String email = request.getParameter("UEMAIL");
    String phoneNumber = request.getParameter("UTELL");

    Connection conn = null;
    PreparedStatement pstmt = null;

    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";

    try {
        // 데이터베이스 연결
        Class.forName(driverName);
        conn = DriverManager.getConnection(dbURL, "root", "kbc0924");

        // 회원 정보 수정을 위한 쿼리 실행
        String query = "UPDATE USER SET UPASS=?, UEMAIL=?, UTELL=? WHERE ID=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, password);
        pstmt.setString(2, email);
        pstmt.setString(3, phoneNumber);
        pstmt.setString(4, userID);
        pstmt.executeUpdate();

        // 세션 정보 업데이트
        HttpSession sessionObj = request.getSession();
        sessionObj.setAttribute("SESSION_UPASS", password);
        sessionObj.setAttribute("SESSION_UEMAIL", email);
        sessionObj.setAttribute("SESSION_UTELL", phoneNumber);

        // 회원 정보 수정 성공
        out.println("회원정보가 수정되었습니다.");

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
%>
