<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<head>
<meta charset="UTF-8">
<title>SignUp</title>
<style>
.title {
	width: 330px;
	height: 40px;
	border-bottom: 1px solid #ff9900;
	margin-bottom: 30px;
	padding-bottom: 5px;
	box-sizing: border-box;
	font-size: 30px;
	color: #ff9900;
	text-align: center;
}
.labelid {
	font-size: 14px;
	color: #666;
	margin-left: 20px;
	margin-right: 50px;
}

.labelpw {
	font-size: 14px;
	color: #666;
	margin-left: 20px;
	margin-right: 50px;
}

.labelname {
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
	margin-bottom: 5px;
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
	<form action="memInsert.do" method="post" onsubmit="return fn_pwChk();">
		<table border="0" align="center">
			<tr>
				<th colspan="3" class="title">Sign Up</th>
			</tr>
			</table>
			<br>
			<table border="0" align="center">
			<tr>
				<td class="labelid">● ID</td>
				<td align="left"><input type="text" name="id" id="idC" placeholder="영문, 숫자 조합 4~12자" class="textbox" autofocus required></td>
				<td><button type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button></td>
				
			</tr>
			<tr>
				<td class="labelpw">● 비밀번호</td>
				<td align="left"><input type="password" name="pw" id="pw1" placeholder="영문, 숫자 조합 4~12자" class="textbox" required></td>
			</tr>
			<tr>
				<td class="labelpw">● 비밀번호 확인</td>
				<td align="left"><input type="password" id="pw2" class="textbox" required></td>
			</tr>
			<tr>
				<td class="labelname">● 이름</td>
				<td align="left"><input type="text" name="memname" class="textbox" required></td>
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
				<td colspan="3" align="center" class="btnwrap2">
					<input type="submit" value="가입완료" class="btn-sign">&nbsp;
					<input type="button" value="취소" class="btn-signIn" onclick="history.back()">
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
function fn_idChk(){
	var chk_id = $('#idC').val();
	if(/^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{4,12}$/.test(chk_id)){
		$.ajax({
			url:"idCheck.do",
			type:"POST",
			async:false,
			dataType:"text",
			data: {"id" : $("#idC").val()},
			success : function(data){
				if(data=='fail'){
					alert("이미 사용중인 ID입니다");
					$("#idC").val('');
				} else{
					alert("사용 가능한 ID입니다");
					document.getElementById("idChk").value = "Y";
				}
			},
		});
	} else{
		alert('영문/숫자 조합 4~12자로 입력해주세요');
	}
}

</script>
<script>
function fn_pwChk(){
	var chk_pw = $('#pw1').val();
	if($('#pw1').val() == $('#pw2').val()){
		if(/^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{4,12}$/.test(chk_pw)){
			if(document.getElementById("idChk").value == "Y" && document.getElementById("numCheckB").value == "Y"){
				return true;	
			} else if(document.getElementById("idChk").value == "Y" && document.getElementById("numCheckB").value == "N"){
				alert('이메일 인증을 진행해주세요');
				return false;
			} else{
				alert('id 체크를 진행해주세요');
				return false;
			}
				
		} else{
			alert('비밀번호는 영문/숫자 조합 4~12자로 입력해주세요');
			return false;
		}
	} else{
		alert('비밀번호를 확인해주세요');
		return false;
	}
}
</script>

<!-- 이메일 인증 -->
<script>
var num;
function fn_emailChk(){
	$.ajax({
		url : "searchEmail.do",
		type : "POST",
		dataType : "text",
		data : {"e_mail" : $("#sendEmail").val()},
		success : function(data){
			if(data == 'none'){
				email_next();
			} else{
				alert('이미 해당 이메일로 가입된 계정이 있습니다.');
			}
		}
	});
}
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
				console.log(data);
			}
		});
	} else{
		alert('이메일을 입력해주세요.');
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
</script>

</html>