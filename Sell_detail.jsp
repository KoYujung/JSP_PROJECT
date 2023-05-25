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
    String sql = "select * from SELL_BOOK where SELL_ID = " + pno;
    String sfile = "";
    String letfile = "";
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
                <a href="Sell_BookList.jsp">책 목록</a>
              </div>
            </div>
          </li>
          <li>
            <div class="dropdown">
              <p class="dropbtn">책 요청</p>
              <div class="dropdown-content">
                <a href="Buy.html">글 작성</a>
                <a href="Buy_BookList.jsp">책 목록</a>
              </div>
            </div>
          </li>
          <li><a href="MyPage.html">마이페이지</a></li>
        </ul>
      </div>
    </nav>
  </header>
  <%
    sfile = result.getString("IMG");
    if (sfile == null || sfile == "") {
      letfile = "noimg.jpg";
    } else {
      letfile = java.net.URLEncoder.encode(sfile, "euc-kr");
    }
  %>
  <main>
    <div class="container">
      <div class="item">
        <img class="book_img" src="./contents/<%= letfile %> ">
        <!-- <div class="slider">
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
        </div> -->
      </div>
      <div class="item">
        <div class="info">
          <p style="color: #ffd700; font-size: 24px;">팝니다 &nbsp;&nbsp;<span style="color: #ff6200; font-size: 24px;">카테고리 : &nbsp;<%= result.getString(14) %></span></p></p>
          <h1 style="font-size: 36px;">책 제목: &nbsp;<%= result.getString(2) %></h1> 
          <p> 저자:&nbsp; <%= result.getString(3) %>&nbsp;
          정가:&nbsp; <%= result.getString(5) %></p> 
          <p> 출판사:&nbsp; <%= result.getString(4) %>&nbsp;
          판매가:&nbsp; <%= result.getString(6) %></p> 
          <hr>
          <p>겉표지 훼손: &nbsp; <%= result.getString(9) %>&nbsp;
            이름기입: &nbsp; <%= result.getString(12) %></p>
          <p>연필/ 샤프: &nbsp; <%
              String pencshar = result.getString(11);
              if (pencshar == null || pencshar == "") {
                out.println("없음");
              } else {
                out.println(pencshar);
              }
            %>&nbsp;
            형광펜/ 볼펜: &nbsp; <%
              String highball = result.getString(10);
              if (highball == null || highball == "") {
                out.println("없음");
              } else {
                out.println(highball);
              }
            %></p>
          <br>
          <a href="chat.html" id="chat"><img src="chat.png", width="80%"></a>
          <p></p>   
          <div class="info_detail">
            <p style="text-align: center;">책 상세설명</p>
            <p style="text-align: center; margin: 15px 15px 15px 15px;"><%= result.getString(7) %></p>
          </div>
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