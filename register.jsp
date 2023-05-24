<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%-- 导入所需的Java类库 --%><%-- 필요한 Java 클래스 라이브러리 가져오기 --%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<%
    // 数据库连接参数 //데이터베이스 연결 매개 변수
    String jdbcDriver = "数据库驱动程序";
    String dbUrl = "jdbc:mysql://localhiost:3306/jsp12";
    String dbUsername = "root";
    String dbPassword = "kbc0924";

    // 定义变量用于存储注册结果 //등록 결과를 저장하기 위한 변수 정의
    boolean registrationSuccess = false;

    if (request.getMethod().equals("POST")) {
        try {
            // 建立数据库连接 //데이터베이스 연동 설정
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // 创建SQL语句 //SQL 만들기
            String sql = "INSERT INTO 用户表 (id, name, password, email, mobile) VALUES (?, ?, ?, ?, ?)";

            // 创建PreparedStatement对象 //PreparedStatement 개체 만들기
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // 设置参数值 //매개 변수 값 설정
            pstmt.setString(1, request.getParameter("tel"));
            pstmt.setString(2, request.getParameter("code"));
            pstmt.setString(3, request.getParameter("psw"));
            pstmt.setString(4, request.getParameter("repsw"));
            pstmt.setString(5, request.getParameter("repsw"));

            // 执行插入操作 //삽입 작업 수행
            pstmt.executeUpdate();

            // 关闭PreparedStatement和数据库连接 //PreparedStatement와 데이터베이스 연결 닫기
            pstmt.close();
            conn.close();

            // 注册成功 //회원가입 성공
            registrationSuccess = true;
        } catch (Exception e) {
            e.printStackTrace();
            // 注册失败 //회원가입 실패
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="css/normalize.css" />
    <link rel="stylesheet" href="css/register.css" />
    <script src="js/jquery.min.js"></script>
    <script src="js/register.js"></script>
</head>
<body>
    <div class="w">
        <header>

        </header>
        <div class="registerarea">
            <div class="regist-header">
                <a href="Test.html" id="logo1"><img src="./images/logo1.png" alt=""></a>
            </div>
            <div class="reg_form">
                <% if (registrationSuccess) { %>
                    <h2>회원가입 성공！</h2>
                <% } else { %>
                    <form method="post" action="register.jsp">
                        <ul>
                            <li>
                                <label for="tel">아이디:</label>
                                <input type="text" class="inp" id="tel" name="tel">
                            </li>
                            <li>
                                <label for="code">이름:</label>
                                <input type="text" class="inp" id="code" name="code">
                            </li>
                            <li class="password">
                                <label for="psw">비밀번호:
                                    <img src="images/close.png" width="24px" alt="">
                                </label>
                                <input type="password" class="inp" id="psw" name="psw">
                            </li>
                            <li class="repassword">
                                <label for="repsw" ><span>이메일:</span>
                                    <img src="images/close.png" width="24px" alt="">
                                </label>
                                <input type="password" class="inp" id="repsw" name="repsw">
                            </li>
                            <li class="repassword">
                                <label for="repsw" ><span>전화번호:</span>
                                    <img src="images/close.png" width="24px" alt="">
                                </label>
                                <input type="password" class="inp" id="repsw" name="repsw">
                            </li>
                            <li class="agree">
                                <input type="checkbox">
                                동의하고 등록
                                <a href="#">《중고문고 등록약정과 프라이버시 정책》</a>
                            </li>
                            <div class="buttons">
                                <button type="submit">
                                    <a href="./login.html">등록완료</a>
                                </button>
                            </div>
                        </ul>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
