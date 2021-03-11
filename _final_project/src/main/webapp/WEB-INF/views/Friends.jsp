<%@page import="java.util.List"%>
<%@page import="com.finalproject.sns.vo.FriendVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

	function list() {
		$(".contextMenuTest").empty();
		//$("#offlineFr").empty();
		//$("#onlineFr").append('<p>온라인</p>');
		//$("#offlineFr").append('<p>오프라인</p>');
		<c:forEach var="imsi" items="${alist}">
		<c:choose>
			<c:when test="${imsi.loginstate eq 'On'}">
				$("#onlineFr ul").append('<li id="${imsi.frid}">${imsi.frname}(${imsi.frid})</li>');
			</c:when>
			<c:when test="${imsi.loginstate eq 'Off'}">
				$("#offlineFr ul").append('<li id="${imsi.frid}">${imsi.frname}(${imsi.frid})</li>');
			</c:when>
		</c:choose>
		</c:forEach>
		 
	}
$(function(){
	list();
});
</script>
<div id='friendList'>
	<p>친구목록</p>
	<div id="Frlist" class="Frlist">
	
	<div id="onlineFr" class="onlineFr" style="height: 50%;">
		온라인<br/>
		<ul class="contextMenuTest">
		</ul>
	</div>
	<hr>
		<div id="offlineFr" class="offlineFr" style="height: 50%;">
		오프라인<br/>
		<ul class="contextMenuTest2">
		</ul>
	</div>
</div>
</div>