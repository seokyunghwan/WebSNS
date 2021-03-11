<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<script>
function MSG_Click(msg_num){

	$.ajax({
		url:"msg_pop.do",
		type:"get",
		data:{"msgnum" : msg_num},
		success : function(data){
			if(data) {
				$('.msgbosmain').hide();
				$(".imsi_msgbox_view").append(data);
			}
			else{

			}
		},
		error : function(data){
			
		}
	});
}

function msgPageMove(data){
	var listpage = document.getElementsByClassName("list_page");	
	for(var i=0 ; i< listpage.length ; i++){
		if(data == i+1){	
			listpage[i].style.display="";
		} else{
			listpage[i].style.display="none";
		}
	}
	
	
}
</script>
<style>
.msgbosmain{
	display:grid;
	grid-template-columns: 77px 239px 50px;
 	grid-template-row: minmax(2px, auto); 
	grid-gap:2px;
	background-color: #ff9900;
	border:1px solid white;
	width: 374px;
	height: auto;
	padding: 1 1 1 1;
}
.msgbosmain .titleItem{
	background-color: white;
	font-size: 14px;
	font-family: 'Malgun Gothic';
	font-weight: bold;
}

.msgbosmain .listItem{
	background-color: white;
}
.list_page{
	display:grid;
	grid-template-columns: 77px 239px 50px;
	grid-gap:2px;
	background-color: #ff9900;
	grid-column : 1/4;
}
h3{
	grid-column : 1/4;
	background-color: #ff9900;
	color: white;
	margin: 3;
}

.pageNumC{
	grid-column : 1/4;
	
}
.pageNumC a{
	font-size: 20px;
	color: white;
	text-decoration:none;
}
</style>
<div class="msgbosmain">
<c:set var="PageSize" value="${fn:length(alist)/5 + 1}"></c:set>
<fmt:parseNumber var="PageMaxNum" value="${PageSize}" integerOnly='true'/>
<c:set var="count" value="0"></c:set>
<h3 align="center">쪽지함</h3>
	<div class="titleItem" align="center">보낸 사람</div>
	<div class="titleItem" align="center">메세지 내용</div>
	<div class="titleItem" align="center">확인</div>
	<c:forEach varStatus="status" begin="1" end="${PageMaxNum }">
		<c:choose>
			<c:when test="${status.index eq 1}"><div class="list_page ${ status.index}"></c:when>
			<c:when test="${status.index ne 1}"><div class="list_page ${status.index }" style="display:none;"></c:when>
		</c:choose>
			<c:forEach var="data" items="${alist}" begin="${count }" end="${count+4 }">
			<div class="listItem" align="center">${data.send_id}</div>
			<div class="listItem" align="center">
				<%-- <a href="#" onclick="friendOK_Click('${data.send_id}', '${data.read_id}')"> --%>
				<a href="#" onclick="MSG_Click('${data.msgnum}')">
				<c:choose>
					<c:when test="${data.add_Friend ne 'None'}"> ${data.send_id}님의 친구신청입니다. 
					(<c:choose>
						<c:when test="${data.add_Friend eq 'X'}">클릭함</c:when>
						<c:when test="${data.add_Friend eq 'O'}">클릭안함</c:when>
					</c:choose>)
					</c:when>
					<c:when test="${data.add_Friend eq 'None'}"> ${data.msg} </c:when>		
				</c:choose></a>
			</div>
			<div class="listItem" align="center">${data.mstate}</div>
		</c:forEach>
		</div>
	<c:set var="count" value="${count+5 }"></c:set>
</c:forEach>
	<div align="center" class="pageNumC">
	<c:if test="${fn:length(alist) % 5 eq 0 }">
		<c:forEach varStatus="status" begin="1" end="${PageMaxNum-1 }">
			<a href="javascript:msgPageMove(${status.count });" id="pageNum">${status.count }</a>
		</c:forEach>	
	</c:if>
	<c:if test="${fn:length(alist) % 5 ne 0 }">
		<c:forEach varStatus="status" begin="1" end="${PageMaxNum }">
			<a href="javascript:msgPageMove(${status.count });" id="pageNum">${status.count }</a>
		</c:forEach>	
	</c:if>
	</div>
</div>
	
