<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>마이페이지</title>
    <link rel="stylesheet" href="MyPage.css">
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
          <!-- <span><%= userID %></span> -->
          <a href="logout.jsp">로그아웃</a>
        <% } %>
      </div>
      <div id="logo">
        <a href="#"><img src="logo.png" width="180"></a>
      </div>
      <div id="navbar">
        <ul>
          <li>
            <div class="dropdown">
              <p class="dropbtn">책 판매</p>
              <div class="dropdown-content">
                <a href="Sell.jsp">글 작성</a>
                <a href="Sell_BookList.jsp">책 목록</a>
              </div>
            </div>
          </li>
          <li>
            <div class="dropdown">
              <p class="dropbtn">책 요청</p>
              <div class="dropdown-content">
                <a href="Buy.jsp">글 작성</a>
                <a href="Buy_BookList.jsp">책 목록</a>
              </div>
            </div>
          </li>
          <li><a href="MyPage.jsp">마이페이지</a></li>
        </ul>
      </div>
    </nav>
  </header>
  <main>
    <br>
    <div id="myProHead"><br>
      <h3>내 정보</h3>
      <% if(userID == null) { %>
        <p>로그인이 필요합니다.</p>
      <% } else if (uname == null) { %>
        <p>회원 정보를 불러올 수 없습니다. 다시 로그인해주세요.</p>
      <% } else { %>
        <h1><span style="color: #3A98B9;"><%= uname %></span>님, 안녕하세요 !</h1>
      <% } %>
    </div>

    <div id="myProBody">
      
      <% if(userID != null && uname != null) { %>
        <hr>
        <button><a href="#">내가 쓴 글보기</a></button>
        <button><a href="#">북마크</a></button>
        <button><a href="user_Update.jsp">개인정보 수정</a></button>
      <% } %>
    </div>
  </main>

</body>
</html>
