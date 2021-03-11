<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if((Boolean)request.getAttribute("success")){
		session.setAttribute("loginVO", request.getAttribute("loginVO"));
	%>
	<script>
		alert('회원 가입을 축하합니다')
		location.href="mainpage.do";
	</script>
	<% } else{%>
	<script>
		alert('회원 가입 오류');
		location.href = "loginpage.do";
	</script>
	<%} %>
</body>
</html>