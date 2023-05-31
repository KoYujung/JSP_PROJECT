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
    <title>판매글 작성</title>
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
    <% if(userID != null) { %>
      <form accept-charset="euc-kr" action="Insert_SellBook.jsp" method="post" enctype="multipart/form-data">
        <div class="left">
        <table class="Sell" cellpadding="15" cellspacing="5">
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
            <td><label>책 제목</label></td>
            <td><input type="text" id="TITLE" name="TITLE" placeholder="책 제목"></td>
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
            <td><label>정가</label></td>
            <td><input type="number" id="FIXED" name="FIXED" placeholder="정가"></td>
          </tr>
          <tr>
            <td><label>판매가</label></td>
            <td><input type="number" id="SELL" name="SELL" placeholder="판매가"></td>
          </tr>
        </table>
        </div>
  
        <div class="right">
        <table cellpadding="15" cellspacing="5">
          <tr>
            <td>겉표지 훼손</td>
            <td>
                <input type="radio" name="COVER" value="없음" checked>없음
                <input type="radio" name="COVER" value="있음">있음
            </td>
          </tr>
          <tr>
            <td>이름 기입</td>
            <td>
                <input type="radio" name="WNAME" value="없음" checked>없음
                <input type="radio" name="WNAME" value="있음">있음
            </td>
          </tr>
          <tr>
            <td>필기</td>
            <td>
                <input type="checkbox" name="HIGHPEN" value="형광펜">형광펜
                <input type="checkbox" name="PENCIL" value="연필/샤프">연필/샤프
            </td>
          </tr>
          <tr>
            <td>분철</td>
            <td>
              <input type="radio" name="FPART" value="안함" checked>안함
              <input type="radio" name="FPART" value="했음">했음
            </td>
          </tr>
          <tr>
            <td>사진</td>
            <td><input type="file" name="IMG"></td>
          </tr>
          <tr>
            <td>상세설명</td>
            <td><textarea name="DET"></textarea></td>
          </tr>
        </table>
        </div>
        <div style="clear: both;">
          <hr width="80%">
          <input type="reset" value="취소" class="regButton">&nbsp;&nbsp;&nbsp;
          <input type="submit" value="등록" class="regButton">
        </div>
        </form>
    <% } else { %>
        <br><br><br><br><br><h1>로그인 후 이용 가능합니다.</h1>
    <% } %>
</main>
  <footer>
  </footer>
</body>
</html>