<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search ID Result</title>
<style>
.title {
	width: 330px;
	height: 40px;
	border-bottom: 1px solid #ff9900;
	margin-bottom: 30px;
	padding-bottom: 5px;
	box-sizing: border-box;
	font-size: 30px;
	color: #ff9900;
	text-align: center;
}
.label {
	font-size: 14px;
	color: #666;
	margin-left: 20px;
	margin-right: 50px;
}
.btn-sign {
	cursor: pointer; 
	width : 129px;
	height: 35px;
	background-color: #ff9900;
	border: none;
	border-radius: 3px;
	color: #fff;
	font-size: 14px;
	font-weight: bold;
	position: relative;
	top: 1px;
	margin-bottom: 5px;
	width: 129px;
}

.btn-signIn {
	cursor : pointer;
	width: 129px;
	height: 35px;
	background-color: #999;
	border : none;
	text-decoration: none;
	display: inline-block;
	border-radius: 3px;
	color: #fff;
	font-size: 14px;
	font-weight: bold;
	line-height: 35px;
	
}
</style>
</head>
<body>
<%
	if(request.getAttribute("id") == null){%>
		 <script> 
		 	alert('해당 이름과 이메일로 가입된 계정이 없습니다');
			 location.href="searchIdForm.do";
		 </script>
	<%}
%>

	<table border="0" align="center">
	<tr>
				<th colspan="3" class="title">Search ID</th>
			</tr>
			</table>
			<br>
		<table border="0" align="center">	
		<tr>
			<td class="label" align="center">고객님의 아이디는 [ ${id } ] 입니다.</td>
		</tr>
		</table>
		<br>
		<table border="0"  align="center">
			<td align="center">
				<input type="button" value="로그인" class="btn-sign" onclick="location.href='loginpage.do'">&nbsp;
				<input type="button" value="PW찾기" class="btn-signIn" onclick="location.href='searchPwForm.do'">&nbsp;
				<input type="button" value="뒤로가기" class="btn-signIn" onclick="history.back()">
			</td>
		</tr>
	</table>
</body>
</html>