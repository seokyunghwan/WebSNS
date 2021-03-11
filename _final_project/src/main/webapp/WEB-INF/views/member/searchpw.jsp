<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Search Password</title>
<style>
.title {
	width: 330px;
	height: 40px;
	border-bottom: 1px solid #ff9900;
	margin-bottom: 30px;
	padding-bottom: 5px;
	box-sizing: border-box;
	font-size: 25px;
	color: #ff9900;
	text-align: center;
}
.labelid {
	font-size: 14px;
	color: #666;
	margin-left: 20px;
	margin-right: 50px;
}

.labelemail {
	font-size: 14px;
	color: #666;
	margin-left: 20px;
	margin-right: 50px;
}
.btn-sign {
	cursor: pointer; 
	width : 129px;
	height: 35px;
	background-color: #ff9900;
	border: none;
	border-radius: 3px;
	color: #fff;
	font-size: 14px;
	font-weight: bold;
	position: relative;
	top: 1px;
	margin-bottom: 10px;
	width: 129px;
}
.btn-signIn {
	cursor : pointer;
	width: 129px;
	height: 35px;
	background-color: #999;
	border : none;
	text-decoration: none;
	display: inline-block;
	border-radius: 3px;
	color: #fff;
	font-size: 14px;
	font-weight: bold;
	line-height: 35px;
	
}

</style>
</head>
<body>
	<form action="searchpw.do" onsubmit="return sendCheck();">
		<table border="0" align="center">
			<tr>
				<th colspan="3" class="title">Search Password</th>
			</tr>
			</table>
			<br>
			<table border="0" align="center">
			<tr>
				<td class="labelid">● ID</td>
				<td align="left"><input type="text" name="id" class="textbox" autofocus></td>
			</tr>
			<tr>
				<td class="labelemail">● 이메일</td>
				<td align="left"><input type="email" id="sendEmail" name="email" placeholder="hello@hello.com" class="textbox" required></td>
				<td><button type="button" id="emailChk" name="e_mail" onclick="fn_emailChk();">이메일 인증</button>
			</tr>
			<tr id="emailnum" style="display:none;">
			<td></td>
				<td><input type="text" id="numInput" placeholder="인증번호를 입력해주세요" ></td>
				<td><button type="button" id="numCheckB" name="numChk" value="N" onclick="numCheck();">인증번호 확인</button></td>
			</tr>
			</table>
			<br>
		
			<table border="0" align="center">
			<tr>
				<td colspan="2">
					<input type="submit" value="PW 찾기" class="btn-sign">&nbsp;
					<input type="button" value="뒤로" class="btn-signIn" onclick="history.back()">
				</td>
			</tr>
		</table>
	</form>
</body>

<script>
var num;
function fn_emailChk(){
	$.ajax({
		url : "searchEmail.do",
		type : "POST",
		dataType : "text",
		async: false,
		data : {"e_mail" : $("#sendEmail").val()},
		success : function(data){
			if(data == 'none'){
				alert('해당 이메일로 가입된 계정이 없습니다.');
			} else{
				email_next();
			}
		}
	});

function email_next(){
		
		if($("#sendEmail").val() != ""){
			alert('인증번호가 전송 되었습니다. 이메일 확인 후 인증번호를 입력해주세요.');
			$("#emailnum").show();
			$.ajax({
				url : "auth.do",
				type : "POST",
				async: false,
				dataType:"text",
				data : {"e_mail" : $("#sendEmail").val()},
				success : function(data){
					num = data;
				}
			});
		} else{
			alert('이메일을 입력해주세요.');
		}
	} 
}

function numCheck(){

	if($('#numInput').val() == num){
		alert('인증번호 일치');
		document.getElementById("numCheckB").value = "Y";
	} else{
		alert('인증번호를 확인해주세요');
		emailComplete = "N";
	}
	
}

function sendCheck(){
	if(document.getElementById("numCheckB").value == "Y"){
		return true;
	} else{
		alert('이메일 인증을 진행해주세요');
		return false;
	}
}
</script>
</html>