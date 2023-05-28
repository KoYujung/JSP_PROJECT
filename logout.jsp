<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null) {
        sessionObj.invalidate(); // 현재 세션 무효화
    }
%>

<!DOCTYPE html>
<html>
    <center><p>로그아웃 되었습니다.</p></center>
<%
    out.println("<meta http-equiv='Refresh' content='1;URL=Buy.jsp'>");
%>
</html>
