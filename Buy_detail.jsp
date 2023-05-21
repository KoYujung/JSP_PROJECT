<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
    String sno = request.getParameter("pno");
    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";
    String sql = "select * from BOOK where BK_CD = " + pno;
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
        <a href="login.html">로그인</a>
        <a href="register.html">회원가입</a>
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
                <a href="Sell.html">글 작성</a>
                <a href="BookList.jsp">책 목록</a>
              </div>
            </div>
          </li>
          <li>
            <div class="dropdown">
              <p class="dropbtn">책 요청</p>
              <div class="dropdown-content">
                <a href="Buy.html">글 작성</a>
                <a href="BookList.jsp">책 목록</a>
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
        <div class="slider">
          <input type="radio" name="slide" id="slide1" checked>
          <input type="radio" name="slide" id="slide2">
          <input type="radio" name="slide" id="slide3">
          <input type="radio" name="slide" id="slide4">
          <ul id="imgholder" class="imgs">
              <li><img class="book_img" src=""></li>
              <li><img class="book_img" src=""></li>
              <li><img class="book_img" src=""></li>
              <li><img class="book_img" src=""></li>
          </ul>
          <div class="bullets">
              <label for="slide1">&nbsp;</label>
              <label for="slide2">&nbsp;</label>
              <label for="slide3">&nbsp;</label>
              <label for="slide4">&nbsp;</label>
          </div>
        </div>
      </div>
      <div class="item">
        <div class="info">
          <p style="color: #ffd700; font-size: 24px;">삽니다 &nbsp;&nbsp;<span style="color: #ff6200; font-size: 24px;">카테고리 : &nbsp;<%= result.getString(14) %></span></p></p>
          <h1 style="font-size: 36px;">책 제목: &nbsp;<%= result.getString(2) %></h1> 
          <p> 저자:&nbsp; <%= result.getString(3) %><!-- 데이터베이스 연동으로 책 정보 가져오도록 --></p> 
          <p> 희망가:&nbsp; <%= result.getString(6) %><!-- 데이터베이스 연동으로 책 정보 가져오도록 --></p>
          <p> 출판사:&nbsp; <%= result.getString(4) %><!-- 데이터베이스 연동으로 책 정보 가져오도록 --></p> 
          <hr>
          <br>
          <a href="chat.html" id="chat"><img src="chat.png", width="550"></a>
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
       out.println("MySql 데이터베이스의 BOOK 조회에 문제가 있습니다. <hr>");
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