<%@page import="com.finalproject.sns.vo.MemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
    
<%
	String beforePage = request.getHeader("REFERER");
	if(request.getAttribute("loginVO") != null){
		session.setAttribute("loginVO", request.getAttribute("loginVO"));
		if(beforePage.contains("loginpage")){
		%>
			<form action="sessOK.do" method="post" name="form">
				<input type="hidden" name="id" value="${loginVO.id}">
			</form>
			<script>
				form.submit();
			</script>
		<%}
		else if(beforePage.contains("mainpage")){
		%>
		<script>
			alert('회원 정보 수정 완료');
			location.href="mainpage.do";
		</script>
		<%} else if(beforePage.contains("mypage")){%>
		<script>
			alert('프로필 사진 변경 완료');
			location.href="mypage.do";
		</script>
		<% }
	} else{%>
		<script>
			alert("아이디 혹은 비밀번호를 확인하세요");
			location.href="loginpage.do";
		</script>
	<%} %>

