<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리 페이지</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터의 인코딩 설정

    // 폼에서 전달된 사용자 아이디와 비밀번호 가져오기
    String userID = request.getParameter("ID");
    String password = request.getParameter("UPASS");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";

    try {
        // 데이터베이스 연결
        Class.forName(driverName);
        conn = DriverManager.getConnection(dbURL, "root", "kbc0924");

        // 사용자 인증을 위한 쿼리 실행
        String query = "SELECT * FROM USER WHERE ID=? AND UPASS=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userID);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 로그인 성공
            out.println("로그인 성공!");

            // 세션에 아이디 저장
            HttpSession sessionObj = request.getSession(); // 변수 이름 수정
            sessionObj.setAttribute("userID", userID); // 변수 이름 수정

            out.println("<meta http-equiv='Refresh' content='1;URL=MyPage.jsp'>");
        } else {
            // 로그인 실패
            out.println("로그인 실패!");
            out.println("<meta http-equiv='Refresh' content='1;URL=login.html'>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 사용한 리소스 해제
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
%>

<p><hr>

</body>
</html>
