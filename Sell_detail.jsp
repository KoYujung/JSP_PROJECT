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

<h2>테이블 student 조회하는 프로그램 </h2>
<hr><center>
<h2>학생정보</h2>

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
  <table border=1 cellpadding=1>
  <tr>
    <th width=50>번호</th>
    <td align=center><%= result.getString("tno") %></td>
  </tr>
  <tr>
    <th width=50>ID</th>
    <td align=center><%= result.getString(2) %></td>
  </tr>
  <tr>
    <th width=50>Password</th>
    <td align=center><%= result.getString(3) %></td>
  </tr>
  <tr>
    <th width=50>이름</th>
    <td align=center><%= result.getString(4) %></td>
  </tr>
  <tr>
    <th width=50>입학년도</th>
    <td align=center><%= result.getString(5) %></td>
  </tr>
  <tr>
    <th width=50>학번</th>
    <td align=center><%= result.getString(6) %></td>
  </tr>
  <tr>
    <th width=50>학과</th>
    <td align=center><%= result.getString(7) %></td>
  </tr>
  <tr>
    <th width=50>휴대전화</th>
    <td align=center><%= result.getString(8) %>-<%= result.getString(9) %></td>
  </tr>
  <tr>
    <th width=50>주소</th>
    <td align=center><%= result.getString(10) %></td>
  </tr>
  <tr>
    <th width=50>이메일</th>
    <td align=center><%= result.getString(11) %></td>
  </tr>
</table>
<br>

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