<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title></title>
        <link rel="stylesheet" href="Test.css">
        <link rel="stylesheet" href="book.css">
      </head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
    String pno = request.getParameter("pno");
    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";
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
          <li><a href="MyPage.html">마이페이지</a></li>
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