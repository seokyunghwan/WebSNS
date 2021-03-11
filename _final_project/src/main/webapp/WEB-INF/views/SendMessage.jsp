<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>   
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
   $(".closebtn").click(function() {
      $(".imsi_msgbox_view2").empty();
   });
   $('.sendmsg_btn').click(function() {
      var msg = $('#msgArea').val();
      $.ajax({
         url: "SendMSG2.do",
         data:{
            "send_id" : "${loginVO.id}",
            "read_id" : "${read_id}",
            "msg" : msg
         },
         success : function(data){ 
            if(data){
               const data = {
                        "type" : "MSG",
                         "message" : "none",
                         "friend_id" : "${read_id}"
                     };
               if (socket.readyState !== 1) return;
                  socket.send(data.type + "," + data.message + "," + data.friend_id);
               $('.imsi_msgbox_view2').empty();
            }
         }
      })
   });
</script>
<meta charset="UTF-8">
<style>

.msgContainer {
   display: grid;
   grid-template-columns: 77px 239px 50px;
   grid-template-row: minmax(2px, auto);
   grid-gap: 2px;
   background-color: #ff9900;
   border: 1px solid white;
   width: 374px;
   height: auto;
   padding: 1 1 1 1;
}
.msgContainer .title{
   grid-columns: 1/2;
   grid-row: 2/3;
   width:100%;
   height:20;
   color : #fff;
   font-size: 14px;
   font-family: 'Malgun Gothic';
   font-weight: bold;
}

.msgContainer .title1{
   grid-columns: 2/3;
   grid-row:2/3;
   width:100%;
   height:20;
   color : #fff;
   font-size: 14px;
   font-family: 'Malgun Gothic';
   font-weight: bold;
}
.msgContainer .content{
   color : #fff;
   font-size: 14px;
   font-family: 'Malgun Gothic';
   font-weight: bold;   
}
h3 {
   grid-column: 1/4;
   grid-row:1/2;
   background-color: #ff9900;
   color: white;
   margin: 3;
}

.msgContainer .content1{
   grid-column: 1/4;
}
.msgContainer .btn-wrap{
   grid-column: 1/4;
}
.msgContainer .btnwrap a {
   color: #fff;
   font-size: 14px;
   font-weight: bold;   
}

</style>

</head>
<body>
   <div class="msgContainer">
      <h3 align="center">메세지 보내기</h3>

      <div class="title">받는 사람</div>
      <div class="title1" >${read_id}</div>
      <br>
      
      <div class="content">내용</div>
      
      <div class="content1" align="center">
         <textarea id="msgArea" style="resize:none;" cols="45" rows="20" placeholder="내용을 입력하세요."></textarea>
      </div>
      <br>
      
      
      <div class="btnwrap" align="center">
         <div class="sendbtn">
            <a href="#" class="sendmsg_btn">보내기</a>
         </div>
         <div class="closebtn">
            <a href="#" class="closebtn">창 닫기</a>
         </div>   
      </div>
   </div>


</body>
</html>