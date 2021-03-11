<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>
<script>
var socket = null;
var Name = null;
$(function(){
	connect();
	function connect(){
		var ws = new WebSocket("ws://localhost:8082/sns/Chat");
		socket = ws;
		ws.onopen = function() { console.log('연결성공'); };
		ws.onmessage = function(event) {
	    	var txt = event.data;
	    	var text = txt.split(',');
	    	if(text[0] == "chat"){
	    		if(!document.getElementById('layer1' + '${loginVO.id}' + text[3]) && text[1] != Name){
	    			var clone2 = $('#layer1').clone();
	    			clone2.attr('id','layer1'+'${loginVO.id}'+text[3]);
	    			$('#imsichat').append(clone2);
	    			$('#layer1'+'${loginVO.id}'+ text[3] + ' #hd_vl').val(text[3]);
	    			Chat.init(text[3]);
	    			$("[id*='layer1']").draggable();
	    		}
	        	const LR = (text[1] != Name)? "left" : "right";
	        	appendMessageTag(LR, text[1], text[2], text[3]);
	        	if($('#layer1'+'${loginVO.id}'+ text[3]).css('display') == 'none'){
	        		PopMsg(text[2], text[1], text[3]);
	        	}
	    	}
	    	else if(text[0] == ("on_off")){
	    		$.ajax({
	    			url:"FrReload.do",
	    			type:"post",
	    			data: {"id" : '${loginVO.id}'},
	    			success : function(data){ 
	    				if(data){
	    					$(".contextMenuTest").find("li").remove();
	    					$(".contextMenuTest2").find("li").remove();
	    					var arrData = data.split("||");
	    					for(var i=0; i<arrData.length; i++) {
	    						if(arrData[i].trim()) {
	    							var temp = arrData[i].split("///");
	        						var name= temp[1];
	        						var id = temp[0];
	        						var html = "<li id='" + id + "'>" + name + "(" + id + ")</li>";
	        						if(temp[2] == 'On') $("#friendList .onlineFr ul").append(html);
	        						else if(temp[2] == 'Off') $("#friendList .offlineFr ul").append(html);
	    						}
	    					}
	    				} else{
	    				}
	    			},
	    			error : function(data){
	    			}
	    		});
	    	}
	    	else if(text[0] == "AddFriend"){
	              var html = text[1] + '님의 친구신청';
	              $('.frienPOP div').empty();
	              $('.frienPOP div').append(html);
	              setTimeout(function(){$('.frienPOP div').empty()}, 3000);
	          }
	    	else if(text[0] == "MSG"){
	        	var html = text[1];
	    	}
	    };
		ws.onclose = function(event) {	console.log('연결종료');	};
		ws.onerror = function(event) {	console.log('연결에러');	};
		
		function appendMessageTag(LR_className, senderName, message, reid) {
			const chatLi = createMessageTag(LR_className, senderName, message);
			var target1 = 'layer1'+'${loginVO.id}' + $('#layer1'+'${loginVO.id}'+ reid + ' #hd_vl').val();
	        
	        $('#' + target1 + ' .chat:not(.format) ul').append(chatLi);
	        $('#' + target1 + ' .chat ul').scrollTop($('#' + target1 + ' .chat ul').prop('scrollHeight'));
	    }
		
		function createMessageTag(LR_className, senderName, message) {
	        let chatLi = $('#layer1 .chat.format ul li').clone();

	        chatLi.addClass(LR_className);
	        chatLi.find('.sender span').text(senderName);
	        chatLi.find('.message span').text(message);
	        
	        return chatLi;
	    }
	}
	
	function friend_page(id){
			$.ajax({
				url:"friendpage.do",
				type:"get",
				data: {"read_id" : id},
				success : function(data){ 
					if(data){
						$("#centerMenu").empty();
	    				$("#centerMenu").append(data);
					} else{
					}
				},
				error : function(data){
				}
			});
  	}
	
	 //메세지 보내기
    function message_go(read_id){
		var el = document.querySelector('.imsi_msgbox_view2 div');
		if(el != null){
			$('.imsi_msgbox_view2').empty();
		}
		else {
			var absoluteTop = $('.contextMenuTest').offset().top;
			var absoluteleft = $('.contextMenuTest').offset().left;
			$.ajax({
				url:"SendMSG.do",
				type:"post",
				data: {"read_id" : read_id},
				success : function(data){ 
				if(data){
					$(".imsi_msgbox_view2").append(data);
				} else{
				}
			},
				error : function(data){
					
				}
			});
			$(".imsi_msgbox_view2").css({
				"top": absoluteTop + "px", 
				"left":absoluteleft - 300 + "px",
				"position": "absolute"
			}).show();
		}
	}
	
	$('#searchTxt').on('keyup', function() {
		$.ajax({
			type: "POST",
			url: "srcajax.do",
			data:{"searchTxt": $('#searchTxt').val()},
			success: function(data) {
				if(data){
					if($('#searchTxt').val() != ""){
						var temp = data.split("///");
						$('.imsi_1').html('<p style="background-color: white;">검색된 유저 : <a class="frcnt_a" href="#">' + temp[0] + '</a> 건</p>');
						$('.imsi_2').html('<p style="background-color: white;">검색된 게시글 : <a class="txtcnt_a" href="#">' + temp[1] + '</a> 건</p>');
					} else{
						$('.imsi_1').empty();
						$('.imsi_2').empty();
					}
				}else{
					idc=false;
				}
			}
		});
	});
	
    $('.btn_search').click(function(){
    	$.ajax({
			url:"searchUser.do",
			type:"get",
			data: {"searchTxt" : $('input#searchTxt').val()},
			success : function(data){ 
				if(data){
					$("#centerMenu").empty();
    				$("#centerMenu").append(data);
				} else{
				}
			},
			error : function(data){
			}
		});
    });
    $('.regFeed').click(function(){
    	$.ajax({
			url:"updatepage.do",
			type:"get",
			success : function(data){ 
				if(data){
					$("#centerMenu").empty();
    				$("#centerMenu").append(data);
				} else{
				}
			},
			error : function(data){
			}
		});
    });

 	$('.getFeed').click(function(){
 		$.ajax({
			url:"getFeed.do",
			type:"get",
			data: {"TXT_NUM" : 3},
			success : function(data){ 
				if(data){
					$("#centerMenu").empty();
 				$("#centerMenu").append(data);
				} else{

				}
			},
			error : function(data){
			}
		});
	});
 	
 	$('.myPage').click(function(){
 		$.ajax({
			url:"mypage.do",
			type:"get",
			data: {"" : ""},
			success : function(data){ 
				if(data){
					$("#centerMenu").empty();
 					$("#centerMenu").append(data);
				} else{

				}
			},
			error : function(data){
			}
		});
	});
 	$(document).on("click",".frcnt_a",function(){

    	$.ajax({
			url:"searchUser.do",
			type:"get",
			data: {"searchTxt" : $('#searchTxt').val()},
			success : function(data){ 
				if(data){
					$("#centerMenu").empty();
    				$("#centerMenu").append(data);
				} else{

				}
			},
			error : function(data){
			}
		});
    });
    
 	$(document).on("click",".txtcnt_a",function(){
 		$.ajax({
 			url:"getscFeed.do",
 			type:"post",
 			async:false,
 			data: {
 				"txt" : $('#searchTxt').val()},
 			success : function(data){
 				var arrData = data.split("||");

 				$.ajax({
    	    		url:"getMyFeed2.do",
    	    		type:"post",
    	    		async:false,
    	    		data: {
    	    			"id" : "id"},
    	    		success : function(data4){ 
    	    			$('.centerMenu').empty();
    	    			$('.centerMenu').append(data4);
    	    		}
    	    	});
 				for(var i=0 ; i < arrData.length ; i++){
 					if(arrData[i].trim()) {
	 					var arrData2 = arrData[i].split("///");
	 					var iDiv = document.createElement('div');
	 					iDiv.className = "myFeed";
	 					iDiv.id = "imsi_NUM_"+arrData2[1];
	 					$(".myFeeds").append(iDiv);
	 					$.ajax({
	 						url:"getRecentFeed.do",
	 						type:"get",
	 						async:false,
	 						data: {
	 							"id" : arrData2[0],
	 							"TXT_NUM" : arrData2[1]},
	 						success : function(data1){ 
	 							$(".myFeed:last").append(data1);
	 						},
	 						error : function(data1){
	 						}
	 					});
 					}
 				}
 			},
 			error : function(data){
 			}
 		});
    });
    
    function PopMsg(imsichat, imsiname, imsipop){
    	var num = Math.floor((Math.random()*10000000)*10000000);
    	var html = "<span class='PopView' id='" + num + "'><div class='Pop'><p>" + imsiname + "</p><p> 내용 : " + imsichat + "</p></div></span>";
    	var create = document.createElement("div");
    	create.innerHTML = html;
    	$('.imsiPop').append(create);
    	var clone = $('.imsiPop').find('span').clone();
    	$('.imsiPop').empty();
    	$('#pop_view').append(clone);
    	setTimeout(function(){clone.remove()}, 5000);
    	clone.find('div').click(function (){
    		chat_go(imsipop);
    		clone.remove();
    	});
    };
    function chat_go(divid){
		if(!document.getElementById('layer1' + '${loginVO.id}' + divid)){
			var clone2 = $('#layer1').clone();
			clone2.attr('id','layer1'+'${loginVO.id}'+ divid);
			$('#imsichat').append(clone2);
			$('#layer1'+'${loginVO.id}'+ divid + ' #hd_vl').val(divid);
			Chat.init(divid);
			$("[id*='layer1']").draggable();
		}
        var $href = '#layer1' + '${loginVO.id}' + divid;
        layer_popup($href);
    }
    function layer_popup(el){

        var $el = $(el);
        var isDim = $el.prev().hasClass('dimBg');

        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

        $el.find('a.btn-layerClose').click(function(){
            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut();
            return false;
        });

        $('.layer .dimBg').click(function(){
            $('.dim-layer').fadeOut();
            return false;
        });
        
    }
    function feed(id){/////////////////
    	$.ajax({
    		url:"getMyFeed.do",
    		type:"post",
    		async:false,
    		data: {
    			"id" : id},
    		success : function(data){
    			$.ajax({
    	    		url:"getMyFeed2.do",
    	    		type:"post",
    	    		async:false,
    	    		data: {
    	    			"id" : id},
    	    		success : function(data3){ 
    	    			$('.centerMenu').empty();
    	    			$('.centerMenu').append(data3);
    	    		}
    	    	});
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
    }
    function Add_Friends(friend_id){/////////////////
    	const data = {
            	"type" : "AddFriend",
                "message" : "none",
                "friend_id" : friend_id
            };
    	$.ajax({
			url:"addfriendDB.do",
			type:"get",
			data: {"send_id" : '${loginVO.id}',
				   "read_id" : friend_id},
			success : function(data){ 
				if(data){

				} else{

				}
			},
			error : function(data){
			}
		});
     
            if (socket.readyState !== 1) return;
            socket.send(data.type + "," + data.message + "," + data.friend_id);
    }
    $.contextMenu({
        selector: '.contextMenuTest li',
        build: function ($trigger) {
        	var targ;
    		if (!e) {
    			var e = window.event;
    		}
    		if (e.target) {
    			targ=e.target;
    		} else if (e.srcElement) {
    			targ=e.srcElement;
    		}
            
            var options= {
                items: {},
                callback: function (key) {
                    if (key == "edit") {
                    	chat_go(targ.id);
    					return location.href="#"
                    }
                    if (key == "edit1") {
                    	feed(targ.id);
                        return location.href="#"
    				}
                    if (key == "edit2") {
						message_go(targ.id);
						return location.href="#"
    				}

                    if (key == 'quit') return;
                    return false;
                }
            };
            options.items["edit"] = { 
                name: "1:1 채팅",
                icon: function () {
                }
            };
    		options.items["edit1"] = { 
    			name: "게시글 보기",
    			icon: function () {
    			}
    		};
            options.items["edit2"] = { 
    			name: "메세지 보내기",
    			icon: function () {
    			}
    		};
            return options;
        }
    });
    $.contextMenu({
		selector : '.contextMenuTest2 li',
		build : function($trigger) {
			var targ;
			
			if (!e) {
				var e = window.event;
			}
			if (e.target) {
				targ = e.target;
			} else if (e.srcElement) {
				targ = e.srcElement;
			}
			//targ.id
			var options = {
				items : {},
				callback : function(key) {

					if (key == "edit") {
						message_go(targ.id);
						return location.href="#"
					}
					if (key == "edit1") {
						feed(targ.id);
						return location.href = "#"
					}
					if (key == "edit2") {
						friend_page(targ.id);
						return location.href = "#"
					}

					if (key == 'quit')
						return;
					return false;
				}
			};
			options.items["edit"] = {
				name : "메세지 보내기",
				icon : function() {
				}
			};
			options.items["edit1"] = {
				name : "게시글 보기",
				icon : function() {
				}
			};
			options.items["edit2"] = {
				name : "친구 프로필보기",
				icon : function() {
				}
			};
			return options;
		}
	});
	$(document).click(function() {
		$(".contextmenu").hide();
	});
	$('.btn_Message').click(function(){
		var el = document.querySelector('.imsi_msgbox_view div');
		if(el != null){
			$('.imsi_msgbox_view').empty();
		}
		else {
			var absoluteTop = $('.btn_Message').offset().top;
			var absoluteleft = $('.btn_Message').offset().left;
			$.ajax({
				url:"ShowMSG.do",
				type:"post",
				data: {"read_id" : "${loginVO.id}"},
				success : function(data){ 
					if(data){
						$(".imsi_msgbox_view").append(data);
					} else{
					}
				},
				error : function(data){
				}
			});
			$(".imsi_msgbox_view").css({
				"top": absoluteTop + "px", 
				"left":absoluteleft + 30 + "px",
				"position": "absolute"
			}).show();
		}
	});
	
	$.contextMenu({
		selector : '.contextMenuTest3 li',
		build : function($trigger) {
			var targ;
			if (!e) {
				var e = window.event;
			}
			if (e.target) {
				targ = e.target;
			} else if (e.srcElement) {
				targ = e.srcElement;
			}
			var options = {
				items : {},
				callback : function(key) {
					if (key == "edit") {
						Add_Friends(targ.id);
						return location.href = "#"
					}
					if (key == "edit1") {
						feed(targ.id);
						return location.href = "#"
					}
					if (key == "edit2") {
						 if (key == "edit2") {
		                       message_go(targ.id);
		                        return location.href="#"
		                }
						return location.href = "#"
					}
					if (key == 'quit')
						return;
					return false;
				}
			};
			options.items["edit"] = {
				name : "친구 신청",
				icon : function() {
				}
			};
			options.items["edit1"] = {
				name : "게시글 보기",
				icon : function() {
				}
			};
			options.items["edit2"] = {
				name : "메세지 보내기",
				icon : function() {
				}
			};
			return options;
		}
	});
    $(document).click(function(){
	    $(".contextmenu").hide();
	  });
    const Chat = (function(){
        const myName = '${loginVO.memname}';
        Name = myName;
        // init 함수
        function init(str1) {
            // enter 키 이벤트
            $(document).on('keydown', '#layer1'+'${loginVO.id}' + str1 + ' .input-div textarea', function(e){
                if(e.keyCode == 13 && !e.shiftKey) {
                    e.preventDefault();
                    const message = $(this).val();
     
                    // 메시지 전송
                    sendMessage(message, str1);
                    // 입력창 clear
                    clearTextarea();
                }
            });
        }
     
        // 메세지 전송
        function sendMessage(message, divid) {
            // 서버에 전송하는 코드로 후에 대체
            const data = {
            	"type" : "chat",
                "message" : message,
                "readName" : $('#layer1'+'${loginVO.id}'+ divid + ' #hd_vl').val(),
            };
     
            // 통신하는 기능이 없으므로 여기서 receive
            if (socket.readyState !== 1) return;
            socket.send(data.type + "," + data.message + "," + data.readName);
        }
     
        // 메세지 입력박스 내용 지우기
        function clearTextarea() {
        	$('div.input-div textarea').val('');
        }
        return {
            'init': init
        };
    })();
});
</script>
<div id="imsichat"></div>
<div id="layer1" class="pop-layer">
<input type="hidden" value="" id="hd_vl"/>
<div class="chat_wrap">
	<div class="close" align="right">
		<a href="#" class="btn-layerClose">닫기</a>
	</div>
    <div class="header">
        CHAT
    </div>
    <div class="chat" >
        <ul>
            <!-- 동적 생성 -->
        </ul>
    </div>
    <div class="input-div">
        <textarea placeholder="Press Enter for send message." style="resize: none;"></textarea>
    </div>
    <!-- format -->
 
    <div class="chat format">
        <ul >
            <li>
                <div class="sender">
                    <span></span>
                </div>
                <div class="message">
                    <span></span>
                </div>
            </li>
        </ul>
    </div>
</div>
</div>
<br/><br/>
<a href="#layer2" class="btn-example" style="display: none">딤처리 팝업레이어 1</a>
<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="layer2" class="pop-layer">
        <div class="pop-container">
            <div class="pop-conts">
                <!--content //-->
                <p class="ctxt mb20">Thank you.<br></p>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose">Close</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<span style="display:block; position: absolute; bottom: 0; right: 0; width: 250px; height: auto;">
<span class="PopView" id="pop_view">
</span>
</span>
<div class="imsiPop" style="display: none"></div>