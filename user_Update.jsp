<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
//<% request.setCharacterEncoding("UTF-8"); %>
<%
    // 데이터베이스 연결 정보 설정
    String dbURL = "jdbc:mysql://localhost:3306/jsp12";

    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, "root", "kbc0924");

        // 회원 정보를 데이터베이스에 저장하는 쿼리 실행
        StringBuffer SQL = new StringBuffer("insert into Users(Userid, Username, UPassword, Email, Phone) "); 

        try {
            String Username    = request.getParameter("Username");

            Class.forName(driverName);
            con = DriverManager.getConnection(dbURL, dbID, dbPW);

            pstmt = con.prepareStatement(SQL.toString());
            //삽입할 레코드 데이터 입력
            pstmt.setString(1, request.getParameter("Userid"));
            pstmt.setString(2, request.getParameter("Username"));
            pstmt.setString(3, request.getParameter("UPassword"));
            pstmt.setString(4, request.getParameter("Email"));
            pstmt.setString(5, request.getParameter("Phone"));

            int rowCount = pstmt.executeUpdate();        
            //if (rowCount == 1) out.println("회원정보가 수정 되었습니다.");

            //다시 학생 조회
            stmt = con.createStatement();
            //else out.println("레코드 삽입에 문제가 있습니다.");
            
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
    out.println("<meta http-equiv='Refresh' content='1;URL=MyPage.html'>");
%>
