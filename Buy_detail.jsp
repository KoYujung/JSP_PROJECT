<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %> <!-- JDBC 관련 클래스 import -->

<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터의 인코딩 설정

    HttpSession sessionObj = request.getSession();

    String userID = (String) sessionObj.getAttribute("userID");
    String uname = (String) sessionObj.getAttribute("UNAME");


    if (uname == null && userID != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String driverName = "org.gjt.mm.mysql.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/mysql12?useUnicode=true&characterEncoding=UTF-8";

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
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="Test.css">
    <link rel="stylesheet" href="book.css">
    <style>
      #comment_button {
        margin-left: 10px;
        border: none; 
        border-radius: 5px; 
        background-color: #3A98B9; 
        color: white; 
        width: 70px; 
        height: 65px;
        text-align: center;
      }
    </style>
  </head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String pno = request.getParameter("pno");
    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12?useUnicode=true&characterEncoding=UTF-8";
    String sql = "select * from BUY_BOOK where BUY_ID = " + pno;
    int rowCount = 0;

    try {
        Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(sql);
        ResultSet result = pstmt.executeQuery();

  while (result.next()) {
%>

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
          <li><a href="Sell_BookList.jsp">홈</a></li>
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
    <div class="container">
      <div class="item">
        <div class="info">
          <p style="color: #ffd700; font-size: 24px;">삽니다 &nbsp;&nbsp;<span style="color: #ff6200; font-size: 24px;">카테고리 : &nbsp;<%= result.getString(6) %></span></p></p>
          <h1 style="font-size: 36px;">책 제목: &nbsp;<%= result.getString(2) %></h1> 
          <p> 저자:&nbsp; <%= result.getString(3) %></p> 
          <p> 희망가:&nbsp; <%= result.getString(5) %></p>
          <p> 출판사:&nbsp; <%= result.getString(4) %></p> 
        </div>  
      </div>
    </div>
  </main>
<footer>
  <div id="comment-section" style="margin-left: 10%;">
    <h2>댓글 달기</h2>
    <form action="Add_BComment.jsp" method="POST">
      <div style="display: flex;">
        <textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요" style="border: solid #aaaaaa 1px; border-radius: 5px;"></textarea>
        <input type="hidden" name="post_id" value="<%= pno %>">
        <input type="hidden" name="user_id" value="<%= userID %>">
        <input type="submit" value="댓글 작성" id="comment_button" <% if(userID == null) { %>disabled<% } %>>
      </div>
    </form>
    <div id="comment-list">
      <h2>댓글 목록</h2>
      <%-- 댓글 목록 조회 --%>
      <%
          Connection commentConn = null;
          PreparedStatement commentStmt = null;
          ResultSet commentResult = null;

          try {
              String commentQuery = "SELECT * FROM BCOMMENTS WHERE POST_ID=?";
              commentConn = DriverManager.getConnection(dbURL, "root", "kbc0924");
              commentStmt = commentConn.prepareStatement(commentQuery);
              commentStmt.setInt(1, Integer.parseInt(pno));
              commentResult = commentStmt.executeQuery();

              while (commentResult.next()) {
                  String commentContent = commentResult.getString("CONTENT");
                  String commentUser = commentResult.getString("USER_ID");
                  String commentCreatedAt = commentResult.getString("CREATED_AT");
      %>
      <p style="font-size: 12px; color: #6b6b6b;">작성자: <%= commentUser %> &nbsp; &nbsp;
      <span>작성일: <%= commentCreatedAt %></span> </p>
      <p style="color:#3f3f3f"> <%= commentContent %></p> 
      <hr>
      <%
              }
          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              if (commentResult != null) {
                  try {
                      commentResult.close();
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
              }
              if (commentStmt != null) {
                  try {
                      commentStmt.close();
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
              }
              if (commentConn != null) {
                  try {
                      commentConn.close();
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
              }
          }
      %>
  </div>
</footer>

<%
   rowCount++;
    }
    result.close();        
    }
    catch(Exception e) {
       out.println("MySql 데이터베이스의 BUY_BOOK 조회에 문제가 있습니다. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
%>
</center>
</body>
</html>
