<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/news2.css"/>">
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="<c:url value="/resources/js/news.js"/>"></script>
<script>
<c:forEach var="result2" items="${result}">
	<c:if test="${result2.id eq loginVO.id}">
		<c:set var="initGoodBad" value="${result2.GOODBAD}"/>
	</c:if>
</c:forEach>

$(document).ready(function(){
	if('${initGoodBad}' == 'O'){
		$("#imsi_NUM_"+'${textVO.TXT_NUM}'+" #btn1")[0].className += " on";
		$("#imsi_NUM_"+'${textVO.TXT_NUM}'+" #btn2")[0].className += "goodbad bad";
	} else if('${initGoodBad}' == 'X'){
		$("#imsi_NUM_"+'${textVO.TXT_NUM}'+" #btn2")[0].className += " on";
		$("#imsi_NUM_"+'${textVO.TXT_NUM}'+" #btn1")[0].className = "goodbad good";
	} else{return;}
});

</script>
<body>
	<div class="news">
		<div class="myinfo">
			<div class="profile">
				<img alt="프로필사진" src="<c:url value="/profile/${feedOwner.memimg }"/>" width="48px" height="48px">
				<!-- 프로필 사진 들어올곳 --><!-- loginVO.memimg 말고 게시했던 사람의 프사 -->
			</div>
			<div class="profile">
				<div class="name">
					<b class="id">${feedOwner.memname }</b>
					<!-- 이름 받아와야할 공간 -->
<!-- 					<span class="friend"> 친구 태그시 표시될 친구 닉네임 -->
<!-- 						<b class="friend_id">▶ 친구 이름</b> -->
<!-- 					</span> -->
				</div>
				<div class="date">
				<fmt:formatDate var="feedYear" value="${textVO.TXT_DATE }" pattern="yyyy"/>
				<c:set var="now" value="<%=new java.util.Date() %>"/>
				<fmt:formatDate var="currentYear" value="${now }" pattern="yyyy"/>
				
				<c:if test="${feedYear>=currentYear  }">
					<fmt:formatDate value="${textVO.TXT_DATE }" pattern="M월 dd일 HH시 mm분"/>
				</c:if>
				<c:if test="${feedYear<currentYear  }">
					<fmt:formatDate value="${textVO.TXT_DATE }" pattern="yyyy년 MM월 dd일"/>
				</c:if>
				
								
				
					<!-- 게시글 올라온 날짜 -->
				</div>
			</div>

		</div>
		<div class="contents">
			<div class="txt"><!-- 게시글 내용 받아옴 -->
				<textarea class="txtArea" disabled="disabled" >${textVO.txt }</textarea>
			</div>
	
			<div class="file">
				<!-- 업로드한 사진및 동영상 받아옴 -->
				<c:if test="${textVO.TXT_FILE ne null }">
					<c:set var="feedImg" value="${fn:split(textVO.TXT_FILE, '/') }"/>
					<c:forEach var="ImgName" items="${feedImg }">
						<div class="item"><img src="<c:url value="/resources/img/feed/${ImgName } "/>" name="${ImgName }" onclick="showBigImg('${textVO.TXT_NUM}', '${ImgName }');"></div>
					</c:forEach>
				</c:if>
<%-- 				<c:if test="${textVO.TXT_FILE eq null }"> --%>
<!-- 					<script></script> -->
<%-- 				</c:if> --%>
			</div>
		</div>
		<div class="comment_num">
			<!-- 좋아요 : xx  싫어요 : xx       댓글: xx개  갯수표시-->
			<div class="txtUpDown">
				<img alt="좋아요" src="<c:url value="/resources/img/good2.png"/>" width="24px"> <label for="up"> ${goodBadVO.like }</label>
			</div>
			<div class="txtUpDown">
				<img alt="싫어요" src="<c:url value="/resources/img/bad2.png"/>" width="24px"> <label for="down"> ${goodBadVO.hate }</label>
			</div>
			<div class="txtUpDown reply">
				댓글 : ${fn:length(commentList) }개
			</div>
		</div>
		<div class="comment_btn">
			<!-- 좋아요 싫어요 댓글달기 버튼 -->
			<input class="goodbad good" id="btn1" type="button" value="좋아요" onclick="goodbad('${textVO.TXT_NUM}', '${loginVO.id }' , 'good');">
			<input class="goodbad bad" id="btn2" type="button" value="싫어요" onclick="goodbad('${textVO.TXT_NUM}', '${loginVO.id }' , 'bad');">
			<input id="btn3" type="button" value="댓글달기"  onclick="showReply('${textVO.TXT_NUM}');">
		</div>
		<div class="comment_area" id="reply">

			<!-- 댓글 표시란 -->
			<!-- 댓글단사람 프로필사진 이름 댓글 내용 -->
			<c:forEach var="comments" items="${commentList }"> 
				<div class="comment">
					<div class="comment_profile">
						<img alt="댓글란 프로필사진" src="<c:url value="/profile/${comments.MEMIMG }"/>" width="25px" height="25px"><!-- 댓글단사람 프로필사진 받아올곳 -->
					</div>
					<div class="comment_txt">
						<div>
							<b>${comments.CM_ID }</b><!-- 댓글단사람 이름 받아올곳 -->
						</div>
						<div>
							<p>${comments.CM_COMMENT }</p>
						</div>

					</div>
					<div class="date comment">
						<fmt:formatDate var="feedYear" value="${comments.COMMENT_DATE}" pattern="yyyy"/>
						<c:set var="now" value="<%=new java.util.Date() %>"/>
						<fmt:formatDate var="currentYear" value="${now }" pattern="yyyy"/>
						
						<c:if test="${feedYear>=currentYear  }">
							<fmt:formatDate value="${comments.COMMENT_DATE }" pattern="M월 dd일 HH시 mm분"/>
						</c:if>
						<c:if test="${feedYear<currentYear  }">
							<fmt:formatDate value="${comments.COMMENT_DATE }" pattern="yyyy년 MM월 dd일"/>
						</c:if>
					</div>
				</div>
			</c:forEach>
			<!-- 댓글 다는 공간 -->
			<div class="regReply">
				<form action="addComment.do" method="post">
					<input type="hidden" value="${textVO.TXT_NUM }" name="TXT_NUM">
					<input type="hidden" value="${loginVO.id}" name="CM_ID">
					<textarea class="comment_upload" id="commentUpload" rows="1" cols="" placeholder="댓글을 입력해주세요..." spellcheck="false" name="CM_COMMENT" required></textarea>
					<input class="submit" type="submit" value="댓글입력">
				</form>
				
				
			</div>
			
		</div>
		<div class="bigimgC" id="bigimg" style="display:none;" onclick="closeBigImg('${textVO.TXT_NUM}');">
			<img src="" width="400px" height="400px" >
		</div>
	</div>
	
</body>
</html>