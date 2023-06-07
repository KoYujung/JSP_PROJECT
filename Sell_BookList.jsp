<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" language="java" %>

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

<html>
  <head>
    <meta charset="euc-kr">
    <title>책 판매 목록</title>
    <link rel="stylesheet" href="Test.css">
    <style type="text/css">
        #tb_base {
          width: 100%;
        }
        #tb_item {
          background-color: #FFF1DC;
          border-radius: 10px;
          width: 100%;
          padding: 20px;
        }
        #td_image {
          width: 100px;
          height: 150px;
        }
        #tb_item #td_title {
          padding: 10px;
          height: 50px;
          font-size: 56px;
        }
        #td_title > a {
          color: black;
        }
        #td_content {
          width: 85%;
          text-align: start;
          color: #3A98B9;
        }
        #search_bar {
          width: 300px;
          height: 40px;
          font-size: 120%;
        }
        #search_button {
          height: 56px;
          border: none;
          background: url("search_icon.png") no-repeat;
          cursor: pointer;
        }
    </style>
  </head>
<body>

<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";
    String sql = "select * from SELL_BOOK";

    String tsearch = request.getParameter("search");
    if (tsearch == null || tsearch == "") {
      // Do Nothing
    } else {
      sql = sql + " where TITLE like '%" + tsearch + "%'";
    }

    sql = sql + " order by SELL_ID desc";
    
    String sfile = "";
    String letfile = "";
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
    <% if(userID == null) { %>
      <a href="login.html">로그인</a>
      <a href="register.html">회원가입</a>
    <% } else { %>
      <a href="logout.jsp">로그아웃</a>
    <% } %>
  </div>
  <div id="logo">
    <form accept-charset="euc-kr" action="Sell_BookList.jsp" method="get" style="text-align: center;">
      <table style="border: none; width: 100%; text-align: center;">
        <tr>
          <td style="width: 40%;">&nbsp;</td>
          <td style="width: 20%;">
            <a href="#"><img src="logo.png" width="180" style="text-align: center;"></a>
        </td>
        <td style="width: 30%;">
            <input id="search_bar" type="text" name="search" placeholder="책 제목으로 검색해주세요" style="position: relative; top: -7px;">
            <button id="search_button" type="submit" style="position: relative; top: 5px;">
            <img src="search_icon.png" width="30px">
            </button>
        </td>
        <td style="width: 10%;">&nbsp;</td>
        </tr>
    </table>
    </form>
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
<div style="height: 600px; margin-left: 10%; margin-right: 10%; overflow: auto;"> 
  <table id="tb_base">
  <%
    while (result.next()) {
      sfile = result.getString("IMG");
      if (sfile == null || sfile == "") {
        letfile = "noimg.jpg";
      } else {
        letfile = java.net.URLEncoder.encode(sfile, "euc-kr");
      }
  %>
  <tr>
    <td>
      <table id="tb_item">
        <tr>
          <td id="td_image" rowspan="3">
            <img src="./contents/<%= letfile %> ">
          </td>
          <td id="td_title" colspan="2">
            <a href=Sell_detail.jsp?pno=<%= result.getString("SELL_ID") %>><%= result.getString(2) %>
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
            <%= result.getString(3) %>
        </td>
      </tr>
      <tr>
        <td>
            출판사
        </td>
        <td id="td_content">
            <%= result.getString(4) %>
        </td>
        </tr>
      </table>
    </td>
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
</div><br>
<footer style="margin-left: 10%;">
<font color=black>
<%
if (rowCount == 0) 
out.println("등록된 판매도서가 없습니다.");
else 
out.println("등록된 판매도서는 총 " + rowCount + "권 입니다.");    
%>
</font>   
</footer>
</body>
</html>