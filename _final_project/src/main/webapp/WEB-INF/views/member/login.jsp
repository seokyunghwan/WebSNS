<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<%if(session.getAttribute("loginVO") != null){%>
	<script>
		location.href="mainpage.do";
	</script>
<%} %>
<body>
	<form action="login.do" method="post">
		<table class="logintable" border="0">
			<tr>
				<td colspan="2"><h1 align="center" class="title">Login</h1></td>
			</tr>
			<tr>
				<td class="labelid" >● ID</td>
				<td><input type="text" name="id" class="loginid" autofocus></td>
			</tr>
			<tr>
				<td class="labelpw" >● 비밀번호</td>
				<td><input type="password" name="pw" class="loginpw"></td>
			</tr>
			
			<tr>
				<td colspan="2" class="btnwrap">
					<input type="submit" value="로그인" id="loginbtn" style="cursor:pointer;">
					<a href="signup.do">회원가입</a>
					<a href="searchIdForm.do">ID찾기</a>
					<a href="searchPwForm.do">PW찾기</a>
					<!--  <input type="button" value="회원가입" class="btn" onclick="location.href='signup.do'">&nbsp;
					<input type="button" value="ID찾기" class="btn" onclick="location.href='searchIdForm.do'">
					<input type="button" value="PW찾기" class="btn" onclick="location.href='searchPwForm.do'"> -->
				</td>
			</tr>
		</table>
	</form>
</body>
</html>