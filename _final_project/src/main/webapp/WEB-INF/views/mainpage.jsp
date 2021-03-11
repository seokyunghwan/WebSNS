<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.5.1.min.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/chat.css??after"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/main.css??after1"/>">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<% if(session.getAttribute("loginVO") != null){ %>
<div class="mainView">
	<div class="head">
	<div class="headgrid">
		<div>
			<a onClick="location='mainpage.do'" style="cursor: pointer;"><img
				src="<c:url value='/resources/img/home.png'/>"
				style="width: 30px; height: 30px;" title="새로고침"></a>
		</div>

		<div>
			<div class="box">
				<div class="container-1">	
					 
					<input type="text" id="searchTxt" class="textbox" placeholder="검색...">
					<button class="btn_search"><span class="icon"><i class="fa fa-search"></i></span></button>
					<span class="imsi_1" style=" z-index: 1; margin-right: 1"></span>
					<span class="imsi_2" style=" z-index: 1; margin-right: 1"></span>
					<span class="imsi_3" style=" z-index: 1; margin-right: 1"></span>
				</div>
			</div>
		</div>

		<div>
			<button class="btn-signIn" onclick="location='logout.do?id=${loginVO.id}'">Logout</button>
		</div>

		<div>
<!-- 			<button class="regFeed">피드 등록하기</button> -->
<!-- 			<button class="getFeed">피드 보여주기</button> -->
			<button class="myPage">My page</button>
		</div>

		<div align="right">
			<button class="btn_Message"><img src="<c:url value='/resources/img/msg.png'/>" style="width:25px ; height:px; background-color"></button>
		</div>
		</div>
		</div>
		<div class="centerMenu" id="centerMenu">
			<jsp:include page="/WEB-INF/views/center1.jsp" flush="false"/>
		</div>
		<div class="rightMenu" id="rightMenu">
			<jsp:include page="/WEB-INF/views/Friends.jsp" flush="false"/>
		</div>
		<div class="ftMenu">
   			<p> (주) kajaSNS </p>
		    <p> (주) 주소: 서울특별시 종로3가 </p>
		    <p> (주) 대표이사 : xxx | 사업자등록번호: xxx-xx-xxxxx </p>
		    <p> 전화번호 : xxxx-xxxx </p>
		    <p> 전자우편주소: xxxxx@xxxxxx.com </p>
		    <p> Copyright 4조. All rights reserved. </p>
			<jsp:include page="/WEB-INF/views/TestChat.jsp" flush="false"/>
		</div>
	</div>
	</div>
		<jsp:include page="/WEB-INF/views/mouseright.jsp" flush="false"/>
		<span class="imsi_msgbox_view"></span>
		<span class="imsi_msgbox_view2"></span>
		<span class="friendpage"></span>
<span class="frienPOP">
         <div align="center">
         </div>
      </span>
<% } else { %> 
	<script>
		location.href="loginpage.do"
	</script>
<% } %>