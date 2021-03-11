<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>

<div class="container">
	<h1>페이지 만들기</h1>
	<div>페이지 정보</div>
	<form action="addGroup.do" method="post">
	<div><input type="text" name="groupName"></div>
	<div><input type="text" name="groupInfo"></div>
	<div><input type="submit" value="전송"></div>
	</form>
</div>
</body>
</html>