<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<script language="javascript">
// window.onbeforeunload = function(event){
// 	$.ajax({
// 		url:"logout.do",
// 		data: {"id" : '${loginVO.id}'},
// 	});
// };
$(document).ready(function(){
	$.ajax({
		url:"getRecentFeed.do",
		type:"get",
		data: {
			"id" : '${loginVO.id}',
			"TXT_NUM" : '${friendsFeed[0].TXT_NUM}'},
		success : function(data){ 
			if(data){
				var iDiv = document.createElement('div');
				iDiv.className="feed";
				iDiv.id="imsi_NUM_"+'${friendsFeed[0].TXT_NUM}';
				$(".top").append(iDiv);
				$(".feed").empty();
				$(".feed").append(data);
			} else{
			}
		},
		error : function(data){
		}
	});
	$.ajax({
		url:"getMyFeed.do",
		type:"post",
		async:false,
		data: {
			"id" : '${loginVO.id}'},
		success : function(data){ 
			for(var i=0 ; i < data.length ; i++){
				var iDiv = document.createElement('div');
				iDiv.className = "myFeed";
				iDiv.id = "imsi_NUM_"+data[i];
				$(".myFeeds").append(iDiv);
				$.ajax({
					url:"getRecentFeed.do",
					type:"get",
					async:false,
					data: {
						"id" : '${loginVO.id}',
						"TXT_NUM" : data[i]},
					success : function(data1){ 
						$(".myFeed:last").append(data1);
					},
					error : function(data1){
					}
				});
			}
		},
		error : function(data){
		}
	});
	$('#plus').click(function(){
		if(document.getElementById("updateId").style.display!='none'){
			document.getElementById("updateId").style.display='none';
		} else{
			document.getElementById("updateId").style.display='';
		}
	});
	
	$('.thumbnail').click(function(){
		var id = $(this).children('.thumbImg').children(':nth-child(3)').attr('value');
		var TXT_NUM = $(this).children('.thumbImg').children(':nth-child(2)').attr('value'); 
		
		$.ajax({
			url:"getFeed.do",
			type:"get",
			data: {
				"id" : id,
				"TXT_NUM" : TXT_NUM},
			success : function(data){ 
				if(data){
					$(".feed")[0].setAttribute("id", ("imsi_NUM_"+TXT_NUM));
					$(".feed").empty();
					$(".feed").append(data);
				} else{
				}
			},
			error : function(data){
			}
		});
		
	});
	var num_btn=0;
	$('.prev_btn').click(function(){
	      if (num_btn > 0){ num_btn -= 1;}
	      $('.thumbDiv').css({
	         "transform" : "translateX(-" + 99 * num_btn + "px)"
	      });
	   });
	   $('.next_btn').click(function(){
	      num_btn += 1;
	      $('.thumbDiv').css({
	         "transform" : "translateX(-" + 99 * num_btn + "px)"
	      });
	   });
});
	
</script>
<div class="top">
				<button type="button" class="prev_btn">PREV</button>
				<div class="thumbnails">
					<div class="thumbDiv">
					<c:if test="${friendsFeed[0] ne null}">
					<c:forEach var="x" items="${friendsFeed }">
						<div class="thumbnail"> 
						<c:set var="thumbImg" value="${fn:split(x.TXT_FILE, '/') }"/>
							<div class="thumbImg">
								<c:choose>
									<c:when test="${x.TXT_FILE ne null}"><img src="<c:url value="/resources/img/feed/${thumbImg[0] } "/>"></c:when>
									<c:when test="${x.TXT_FILE eq null}"><p>${x.txt }</p></c:when>
								
								</c:choose>
								<input type="hidden" name="TXT_NUM" value="${x.TXT_NUM }">
								<input type="hidden" name="id" value="${x.id }">
							</div>
							<div class="thumbId">${x.id}</div>
						</div>
					</c:forEach>				
					</c:if>
					<c:if test="${friendsFeed[0] eq null}">
						<div class="thumbnail2"> 친구의 피드가 없습니다 </div>
					</c:if>
					</div>
				</div>
				<button type="button" class="next_btn">NEXT</button>
			</div>
			<div class="bottom">
				<div class="feedPlus">
					<button id="plus">피드추가</button>
					<jsp:include page="/WEB-INF/views/update.jsp" flush="false"/>
				</div>
				
			</div>
			<div class="myFeeds">
			</div>