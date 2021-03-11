function goodbad(txt_num, id, data){
	var selectedDiv = "#imsi_NUM_"+txt_num+" ";
	var like = document.querySelectorAll("#imsi_NUM_"+txt_num+" #btn1")[0].className.includes('on');
	var hate = document.querySelectorAll("#imsi_NUM_"+txt_num+" #btn2")[0].className.includes('on');
	
	if(!like && !hate){	//아무것도 안눌러져 있는 상태 
		if(data=='good'){// good bad switchtogood switchtobad none
			$.ajax({
				url : "goodButtonPlus.do",
				type : "post",
				async : false,
				data : {"TXT_NUM" : txt_num,
						"id" : id,
						"data" : data},
				success : function(data){
					$(selectedDiv+"label[for='up']").text(data);
				}
			});
			$(selectedDiv+"#btn1")[0].className += " on";
			$(selectedDiv+"#btn2")[0].className = "goodbad bad";
//			document.getElementById(selectedDiv+"btn1").className += " on";
//			document.getElementById(selectedDiv+"btn2").className = "goodbad bad";
		} else if(data=='bad'){
			$.ajax({
				url : "badButtonPlus.do",
				type : "post",
				async : false,
				data : {"TXT_NUM" : txt_num,
						"id" : id,
						"data" : data},
				success : function(data){
					$(selectedDiv+"label[for='down']").text(data);
				}
			});
			$(selectedDiv+"#btn1")[0].className = "goodbad good";
			$(selectedDiv+"#btn2")[0].className += " on";
		}
		
	} else if(like && !hate){ //좋아요 눌린 상태
		if(data=='good'){ //다시 좋아요 누르기
			$.ajax({
				url : "deleteGoodBad.do",
				type : "post",
				async : false,
				data : {"TXT_NUM" : txt_num,
						"id" : id,
						"data" : data},
				success : function(data){
					$(selectedDiv+"label[for='up']").text(data);
				}
			});	
			$(selectedDiv+"#btn1")[0].className = "goodbad good";
			$(selectedDiv+"#btn2")[0].className = "goodbad bad";
		} else if(data=='bad'){ //싫어요로 바꾸기 
			$.ajax({
				url : "updateGoodBad.do",
				type : "post",
				async : false,
				data : {"TXT_NUM" : txt_num,
						"id" : id,
						"data" : data},
						success : function(data){
							$(selectedDiv+"label[for='up']").text(data.like);
							$(selectedDiv+"label[for='down']").text(data.hate);
						}
			});	
			$(selectedDiv+"#btn1")[0].className = "goodbad good";
			$(selectedDiv+"#btn2")[0].className += " on";
		}
	} else if(!like && hate){ //싫어요 눌린 상태
		if(data=='bad'){ //다시 싫어요 누르기
			$.ajax({
				url : "deleteGoodBad.do",
				type : "post",
				async : false,
				data : {"TXT_NUM" : txt_num,
						"id" : id,
						"data" : data},
				success : function(data){
					$(selectedDiv+"label[for='down']").text(data);
				}
			});	
			$(selectedDiv+"#btn1")[0].className = "goodbad good";
			$(selectedDiv+"#btn2")[0].className = "goodbad bad";
		} else if(data=='good'){ //좋아요로 바꾸기  
			$.ajax({
				url : "updateGoodBad.do",
				type : "post",
				async : false,
				data : {"TXT_NUM" : txt_num,
						"id" : id,
						"data" : data},
				success : function(data){
					$(selectedDiv+"label[for='up']").text(data.like);
					$(selectedDiv+"label[for='down']").text(data.hate);
				}
			});	
			$(selectedDiv+"#btn1")[0].className += " on";
			$(selectedDiv+"#btn2")[0].className = "goodbad bad";
		}
		
	}
}

$(".feed #btn3").click(function(){
	$(".top .comment_area")[0].style.display="block";
});


//$(".myFeed #btn3").click(function(){
//	var divPath = $(this).parents("div");
//	var num = divPath[2].className.split(' ')[1];
//	var classN = ".myFeed .comment_area";
//	$(classN)[num].style.display="block";
//});

function showReply(txt_num){
	$("#imsi_NUM_"+txt_num+" #reply")[0].style.display="block";
}

$("#commentUpload").on("propertychange change keyup paste input",function(){
    $(this)[0].style.height='10px';
    $(this).height( $(this).prop('scrollHeight')-1);     
});

function showBigImg(txt_num, imgName){
	var imgSrc = '/sns/resources/img/feed/' + imgName;
	$("#imsi_NUM_"+txt_num+" #bigimg")[0].style.display="block";
	$("#imsi_NUM_"+txt_num+" #bigimg img").attr("src", imgSrc);
}


function closeBigImg(txt_num){
	$("#imsi_NUM_"+txt_num+" #bigimg")[0].style.display="none";
}
//$(".feed .item img").click(function(){
//	var imgSrc = '/sns/resources/img/feed/' + this.name;
//	document.getElementById("bigimg").style.display='block';
//	$("#bigimg img").attr("src", imgSrc);
//});
//
//
//
//
//$(".myFeed #bigimg").click(function(){
//	console.log(this);
//	this.style.display = 'none';
//});
