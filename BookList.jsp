<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>등록된 (구매)책 목록</title>
        <link rel="stylesheet" href="Test.css">
        <!-- style 시작 -->
        <style type="text/css">
            #tb_base {
              width: 100%;
            }
            #tb_item {
              background-color: #FFF1DC;
              width: 100%;
            }
            #td_image {
              width: 100px;
              height: 150px;
            }
            #tb_item #td_title {
              height: 90px;
              font-size: 56px;
            }
            #td_content {
              width: 60%;
              text-align: start;
            }
            #td_bookmark {
              width: 100px;
              height: 150px;
            }
            #search_bar {
              width: 300px;
              height: 50px;
              font-size: x-large;
            }
            #search_button {
              height: 56px;
            }
        </style>
        <!-- style 종료 -->
      </head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";
    String sql = "select * from BOOK";
    int rowCount = 0;

    try {
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, "root", "kbc0924");
        pstmt = con.prepareStatement(sql);
        ResultSet result = pstmt.executeQuery();
%>

    <header>
        <nav>
        <a href="#" id="mark"><img src="mark.png" width="50"></a>
        <div id="login">
            <a href="login.html">로그인</a>
            <a href="register.html">회원가입</a>
        </div>
        <div id="logo" >
            <form action="Search.html" method="get" style="text-align: center;">
            <table style="border: none; width: 100%; text-align: center;">
                <tr>
                <td style="width: 40%;">&nbsp;</td>
                <td style="width: 20%;">
                    <a href="#"><img src="logo.png" width="180" style="text-align: center;"></a>
                </td>
                <td style="width: 30%;">
                    <input id="search_bar" type="text" name="search" style="position: relative; top: -7px;">
                    <button id="search_button" type="submit" style="position: relative; top: 5px;">
                    <img src="search_icon.png">
                    </button>
                </td>
                <td style="width: 10%;">&nbsp;</td>
                </tr>
            </table>
            </form>
        </div>
        <div id="navbar">
            <ul>
              <li><a href="Test.html">홈</a></li>
              <li>
                <div class="dropdown">
                  <a class="dropbtn">책 판매</a>
                  <div class="dropdown-content">
                    <a href="Sell.html">글 작성</a>
                    <a href="Sell_detail.html">책 목록</a>
                  </div>
                </div>
              </li>
              <li>
                <div class="dropdown">
                  <p class="dropbtn">책 요청</p>
                  <div class="dropdown-content">
                    <a href="Buy.html">글 작성</a>
                    <a href="Buy_detail.html">책 목록</a>
                  </div>
                </div>
              </li>
              <li><a href="MyPage.html">마이페이지</a></li>
            </ul>
          </div>
        </nav>
    </header>
    <main>
        <table id="tb_base">
        <!-- 조회 목록 설정 시작 -->
        <!-- <tr>
            <td>
            설정 창
            </td>
        </tr> -->
        <!-- 조회 목록 설정 끝 -->
        <!-- JSP For 문 묶음 시작 -->
        <tr>
            <td>
            <table id="tb_item">
                <tr>
                <td id="td_image" rowspan="3">
                    <img src="./book.jpg"> <!--IMG-->
                </td>
                <td id="td_title" colspan="2">
                    직업과 영성 <!--TITLE-->
                </td>
                <td id="td_bookmark" rowspan="3">
                    <img src="./bookmark_empty.jpg">
                </td>
                </tr>
                <tr>
                <td>
                    저자
                </td>
                <td id="td_content">
                    장종현, 김대인, 김진하, 정회현, 최규명, 한만오 <!--AUTH-->
                </td>
                </tr>
                <tr>
                <td>
                    출판사 
                </td>
                <td id="td_content">
                    뷰리 <!--PUBL-->
                </td>
                </tr>
            </table>
            </td>
        </tr>
        <!-- JSP For 문 묶음 종료 -->
<%
    while (result.next()) {
%>
    <tr>
    <!-- IMG,TITLE,AUTH,PUBL -->
      <td align=center><a href=Buy_detail.html?pno=<%= result.getString("BK_CD") %>><%= result.getString("BK_CD") %></a></td>
      <td align=center><%= result.getString(8) %></a></td> <!--책 사진-->
      <td align=center><%= result.getString(2) %></td><!--책 이름-->
      <td align=center><%= result.getString(3) %></td><!--저자-->
      <td align=center><%= result.getString(4) %></td><!--출판사-->
    </tr>
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
</table>
</main>

<p><hr><font color=blue>
<%
    if (rowCount == 0) 
    out.println("등록된 도서가 없습니다.");
    else 
    out.println("등록된 도서가 " + rowCount + "권 입니다.");    
%>
</font>  
</body>
</html>