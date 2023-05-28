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
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>요청글 작성</title>
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
      <li><a href="Test.html">홈</a></li>
      <li>
        <div class="dropdown">
          <a class="dropbtn">책 판매</a>
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
    <% if(userID != null) { %>
        <form action="Insert_BuyBook.jsp" method="get" enctype="multipart/form-data">
            <table cellpadding="20px" cellspacing="10px">
                <tr>
                    <td>카테고리</td>
                    <td>
                        <select name="CATE">
                          <option value="언어">언어</option>
                          <option value="경제">경제</option>
                          <option value="컴퓨터">컴퓨터</option>
                          <option value="예술">예술</option>
                          <option value="종교">종교</option>
                      </select>
                    </td>
                </tr>
                <tr>
                    <td><label>도서 이름</label></td>
                    <td><input type="text" id="TITLE" name="TITLE" placeholder="책 이름"></td>
                </tr>
                <tr>
                    <td><label>저자</label></td>
                    <td><input type="text" id="AUTH" name="AUTH" placeholder="저자"></td>
                </tr>
                <tr>
                    <td><label>출판사</label></td>
                    <td><input type="text" id="PUBL" name="PUBL" placeholder="출판사"></td>
                </tr>
                <tr>
                    <td><label>희망가</label></td>
                    <td><input type="number" id="HOPE" name="HOPE" placeholder="희망가"></td>
                </tr>
            </table>
            <hr width="70%">
            <input type="reset" value="취소" class="regButton">&nbsp;&nbsp;&nbsp;
            <input type="submit" value="등록" class="regButton">
        </form>
    <% } else { %>
        <h1>로그인 후 이용 가능합니다.</h1>
    <% } %>
</main>
<footer>
</footer>
</body>
</html>
