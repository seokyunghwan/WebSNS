<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.msgbosmain2{
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
.msgbosmain2 .MsgPop_id{
	background-color: white;
	font-size: 14px;
	font-family: 'Malgun Gothic';
	font-weight: bold;
}

.msgbosmain2 .MsgPop_msg{
	background-color: white;
	grid-column : 2/4;
}
.msgbosmain2 .MsgPop_msg_t{
	background-color: white;
	grid-column : 1/2;
}
.msgbosmain2 .MsgPop_evt{
	background-color: white;
	grid-column : 1/4;
}
h3{
	grid-column : 1/4;
	background-color: #ff9900;
	color: white;
	margin: 3;
}
</style>
<script>
function friendOK_Click(id, fid, num){
	$.ajax({
		url: "addFriend.do",
		type:"get",
		data:{"id" : id,
			  "fid" : fid,
			  "msgnum" : num},
		success : function(data){
			if(data) {
				const data = {
		            	"type" : "OKFriend",
		                "message" : "none",
		                "friend_id" : id
		            };
				if (socket.readyState !== 1) return;
	            socket.send(data.type + "," + data.message + "," + data.friend_id);
	            $(".imsi_msgbox_view").empty();
			}
			else{

			}
		},
		error : function(data){
			
		}
	});
}
function friendNO_Click(id, fid, num){
	$.ajax({
		url: "NoFriend.do",
		type:"get",
		data:{"id" : id,
			  "fid" : fid,
			  "msgnum" : num},
		success : function(data){
			if(data) {
				const data = {
		            	"type" : "NOFriend",
		                "message" : "none",
		                "friend_id" : id
		            };
				if (socket.readyState !== 1) return;
	            socket.send(data.type + "," + data.message + "," + data.friend_id);
	            $(".imsi_msgbox_view").empty();
			}
			else{

			}
		},
		error : function(data){
			
		}
	});
}
</script>
<div class="msgbosmain2">
<input type="hidden" value="${msgpop.msgnum}" id="msgnum"/>
<h3 align="center">쪽지함</h3>
<div class="MsgPop_id">보낸 사람</div>
<div class="MsgPop_id">${msgpop.send_id}</div>
<c:choose>
	<c:when test="${msgpop.add_Friend ne 'None'}">
		<div class="MsgPop_msg_t">내   용</div>
		<div class="MsgPop_msg">${msgpop.send_id}님의 친구신청입니다.</div>
		<c:choose>
		<c:when test="${msgpop.add_Friend eq 'O'}">
			<div class="MsgPop_evt">
				<a href="#" onclick="friendOK_Click('${msgpop.send_id}', '${msgpop.read_id}', '${msgpop.msgnum}')">수락</a>
				<a href="#" onclick="friendNO_Click('${msgpop.send_id}', '${msgpop.read_id}', '${msgpop.msgnum}')">거절</a>
			</div>
		</c:when>
		<c:when test="${msgpop.add_Friend eq 'X'}">
			<div class="MsgPop_evt">이미 처리한 내용입니다.</div>
		</c:when>
		</c:choose>
	</c:when>
	<c:when test="${msgpop.add_Friend eq 'None'}">
		<div class="MsgPop_msg_t">내   용</div>
		<div class="MsgPop_msg">${msgpop.msg}</div>
	</c:when>		
</c:choose>
</div>
<%-- 
보낸 사람 : ${msgpop.send_id}
   내   용 : ${msgpop.msg}
   
   private int msgnum;
	private String send_id;
	private String read_id;
	private String msg;
	private String mstate;
	private String add_Friend; --%>