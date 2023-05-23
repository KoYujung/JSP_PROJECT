<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" language="java" %>
<html>
    <head>
	<meta charset="euc-kr">
        <title>???? (????)? ???</title>
        <link rel="stylesheet" href="Test.css">
        <!-- style ???? -->
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
            #td_title {
                text-align: center;
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
    String sql = "select * from SELL_BOOK";
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
            <a href="login.html">?α???</a>
            <a href="register.html">???????</a>
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
              <li><a href="Test.html">?</a></li>
              <li>
                <div class="dropdown">
                  <a class="dropbtn">? ???</a>
                  <div class="dropdown-content">
                    <a href="Sell.html">?? ???</a>
                    <a href="Sell_detail.html">? ???</a>
                  </div>
                </div>
              </li>
              <li>
                <div class="dropdown">
                  <p class="dropbtn">? ???</p>
                  <div class="dropdown-content">
                    <a href="Buy.html">?? ???</a>
                    <a href="Buy_detail.html">? ???</a>
                  </div>
                </div>
              </li>
              <li><a href="MyPage.html">??????????</a></li>
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
                              <%= result.getString("IMG") %><br>
                              <img src="./contents/<%= letfile%> "> <!--IMG-->
                            </td>
                            <td id="td_title" colspan="2">
                                <%= result.getString(2) %> <!--TITLE-->
                            </td>
                            <td id="td_bookmark" rowspan="3">
                                <img src="./bookmark_empty.jpg">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ????
                            </td>
                            <td id="td_content">
                                <%= result.getString(3) %> <!--AUTH-->
                            </td>
                        </tr>
                        <tr>
                            <td>
                                ?????
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
                out.println("MySql ???????????? BOOK ????? ?????? ??????. <hr>");
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
    </div>
    <footer>
       <font color=blue>
<%
    if (rowCount == 0) 
    out.println("???? ?????? ???????.");
    else 
    out.println("???? ?????? " + rowCount + "?? ????.");    
%>
</font>   
    </footer>

</b