<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>유저검색결과</h1>
<div id ="searchFr" class="searchFr">
	<ul class="contextMenuTest3">
		<c:forEach var="data" items="${alist}">
			<li id="${data.id}"> ${data.memname}(${data.id})</li>
		</c:forEach>
	</ul>
</div>