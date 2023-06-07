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
    <title>å ��û ���</title>
    <link rel="stylesheet" href="Test.css">
    <!-- style ???? -->
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
        #tb_item #td_title {
          padding: 10px;
          height: 50px;
          font-size: 56px;
        }
        /* #td_title {
            text-align: center;
        } */
        #td_title > a {
          color: black;
        }
        #td_content {
          width: 92%;
          text-align: start;
          color: #3A98B9;
        }
        /* #td_bookmark {
          width: 100px;
          height: 150px;
        } */
        #search_bar {
          width: 300px;
          height: 40px;
          /* font-size: x-large; */
          font-size: 110%;
        }
        #search_button {
          height: 56px;
          border: none;
          background: url("search_icon.png") no-repeat;
          cursor: pointer;
        }
    </style>
    <!-- style ???? -->
  </head>
<body>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    String driverName = "org.gjt.mm.mysql.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/mysql12";
    String sql = "select * from BUY_BOOK";

    String tsearch = request.getParameter("search");
    if (tsearch == null || tsearch == "") {
      // Do Nothing
    } else {
      // tsearch = URLEncoder.encode(tsearch, "euc-kr");
      sql = sql + " where TITLE like '%" + tsearch + "%'";
    }
    
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
      <a href="login.html">�α���</a>
      <a href="register.html">ȸ������</a>
    <% } else { %>
      <!-- <span><%= userID %></span> -->
      <a href="logout.jsp">�α׾ƿ�</a>
    <% } %>
  </div>
  <div id="logo">
    <form accept-charset="euc-kr" action="Buy_BookList.jsp" method="get" style="text-align: center;">
    <table style="border: none; width: 100%; text-align: center;">
        <tr>
        <td style="width: 40%;">&nbsp;</td>
        <td style="width: 20%;">
            <a href="#"><img src="logo.png" width="180" style="text-align: center;"></a>
        </td>
        <td style="width: 30%;">
            <input id="search_bar" type="text" name="search" placeholder="å �������� �˻����ּ���" style="position: relative; top: -7px;">
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
          <p class="dropbtn">å �Ǹ�</p>
          <div class="dropdown-content">
            <a href="Sell.jsp">�� �ۼ�</a>
            <a href="Sell_BookList.jsp">å ���</a>
          </div>
        </div>
      </li>
      <li>
        <div class="dropdown">
          <p class="dropbtn">å ��û</p>
          <div class="dropdown-content">
            <a href="Buy.jsp">�� �ۼ�</a>
            <a href="Buy_BookList.jsp">å ���</a>
          </div>
        </div>
      </li>
      <li><a href="MyPage.jsp">����������</a></li>
    </ul>
  </div>
</nav>
</header>
<div style="height: 600px; margin-left: 10%; margin-right: 10%; overflow: auto;"> 
  <table id="tb_base">
  <!-- ??? ??? ???? ???? -->
  <!-- <tr>
      <td>
      ???? ?
      </td>
  </tr> -->
  <!-- ??? ??? ???? ?? -->
  <!-- JSP For ?? ???? ???? -->
  <%
    while (result.next()) {
  %>
  <tr>
    <td>
      <table id="tb_item">
        <tr>
          <td id="td_title" colspan="2">
            <a href=Buy_detail.jsp?pno=<%= result.getString("BUY_ID") %>><%= result.getString(2) %> <!--TITLE-->
          </td>
          <!-- <td id="td_bookmark" rowspan="3">
              <img src="./bookmark_empty.jpg">
          </td> -->
      </tr>
      <tr>
        <td>
            ����
        </td>
        <td id="td_content">
            <%= result.getString(3) %> <!--AUTH-->
        </td>
      </tr>
      <tr>
        <td>
            ���ǻ�
        </td>
        <td id="td_content">
            <%= result.getString(4) %> <!--PUBL-->
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
      out.println("MySql �����ͺ��̽��� BOOK ��ȸ�� ������ �ֽ��ϴ�. <hr>");
        out.println(e.toString());
        e.printStackTrace();
    }
    finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
%>
  <!-- JSP For ?? ???? ???? -->
  </table>
</div><br>
<footer style="margin-left: 10%;">
<font color=black>
<%
if (rowCount == 0) 
out.println("��ϵ� �Ǹŵ����� �����ϴ�.");
else 
out.println("��ϵ� �Ǹŵ����� �� " + rowCount + "�� �Դϴ�.");    
%>
</font>   
</footer>
</body>
</html>