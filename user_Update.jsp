<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- JDBC 관련 클래스 import -->

<%
    HttpSession sessionObj = request.getSession();

    String userID = (String) sessionObj.getAttribute("userID");
    String uname = (String) sessionObj.getAttribute("UNAME");

    if (uname == null && userID != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String driverName = "org.gjt.mm.mysql.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/mysql12";

        try {
            Class.forName(driverName);
            conn = DriverManager.getConnection(dbURL, "root", "kbc0924");

            String query = "SELECT UNAME FROM USER WHERE ID=?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                uname = rs.getString("UNAME");
                sessionObj.setAttribute("UNAME", uname);
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
    }
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보수정</title>
    <link rel="stylesheet" href="Test.css">
    <link rel="stylesheet" href="user_update.css">
  </head>
  <body>
    <header>
      <nav>
        <a href="#" id="mark"><img src="mark.png" width="50"></a>
        <div id="login">
            <% if(userID == null) { %>
              <a href="login.html">로그인</a>
              <a href="register.html">회원가입</a>
            <% } else { %>
              <a href="logout.jsp">로그아웃</a>
            <% } %>
          </div>
        <div id="logo">
          <a href="#"><img src="logo.png" width="180"></a>
        </div>
        <div id="navbar">
          <ul>
            <li><a href="Sell.jsp">책 판매</a></li>
            <li><a href="Buy.jsp">책 요청</a></li>
            <li><a href="MyPage.jsp">마이페이지</a></li>
          </ul>
        </div>
      </nav>
    </header>
    <main>
        <div>
            <div><br><h1 style="padding: 20px;">회원정보 수정</h1>
                <form action="user_UpdateProcess.jsp" method="post">
                    <ul>
                        <li>
                            <label for="tel">아이디:</label>
                            <input type="text" class="inp" id="ID" name="ID" value="<%= userID %>" readonly>
                        </li>
                        <li class="password">
                            <label for="psw">비밀번호:
                            </label>
                            <input type="Password" class="inp" id="UPASS" name="UPASS" required>
                        </li>
                        </li>
                        <li class="repassword">
                            <label for="repsw" ><span>이메일:</span>
                            </label>
                            <input type="text" class="inp" id="UEMAIL" name="UEMAIL" required>
                        </li>
                        <li class="repassword">
                            <label for="repsw" ><span>전화번호:</span>
                            </label>
                            <input type="text" class="inp" id="UTELL" name="UTELL" required>
                        </li>
                        <div style="padding: 15px;">
                            <input type="submit" class="buttons" value="수정 완료" style="font-size: 15px; cursor: pointer; color: white;">
                        </div>
                    </ul>
                </form>
            </div>
        </div>
    </main>
  </body>
</html>
