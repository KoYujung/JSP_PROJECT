<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 페이지</title>
</head>
<body>

<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터의 인코딩 설정

    // 폼에서 전달된 회원가입 정보 가져오기
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

        // 회원 등록을 위한 쿼리 실행
        String query = "UPDATE USER SET UPASS=?, UEMAIL=?, UTELL=? WHERE ID=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, password);
        pstmt.setString(2, email);
        pstmt.setString(3, phoneNumber);
        pstmt.setString(4, userID);
        pstmt.executeUpdate();

        // 세션 정보 업데이트
        HttpSession sessionObj = request.getSession();
        
        // 아래 라인에서 세션에 저장되는 속성 이름을 변경하여 중복을 피합니다.
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

<meta http-equiv='Refresh' content='1;URL=MyPage.jsp'>
<p><hr>
</body>
</html>
