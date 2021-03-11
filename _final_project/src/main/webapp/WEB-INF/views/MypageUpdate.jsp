<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my page update</title>
<link rel="stylesheet" href="<c:url value="/resources/css/mypage.css"/>">



</head>
<body>

<!--  header.jsp들어갈 부분 -->
<hr>
<div class="userContainer" align="center">
		<form action="UserUpdateConfirm.do" method="post" onsubmit="return pwchk();" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${loginVO.id}" >
			<div>
				<table border="0" align="center">
					<tr>
						<th colspan="3" class="title">정보 수정</th>
					</tr>
					</table>
					<br>
					<br>
					<table border="0" align="center">

					<tr>
						<td class="labelpw">● 비밀번호</td>
						<td colspan=2 align="left" >
							<input type="password" id="pw1" class="pwchk" name="pw" maxlength="12" size=30>
						</td>
					</tr>
					<tr>
						<td class="labelpw">● 비밀번호 확인</td>
						<td colspan=2 align="left" >
							<input type="password" id="pw2" class="pwchk"  maxlength="12" size=30>
						</td>
					</tr>
					<tr>
						<td class="labelname">● 이름</td>
						<td colspan=2 align="left">
							<input type="text" class="textbox" name="memname" maxlength="12" size=30 value="${loginVO.memname}" ></td>
					</tr>
					<tr>
						<td class="labelemail">● 이메일</td>
						<td colspan=2 align="left">
							<input type="text" class="textbox" name="email" maxlength="12" size=30 value="${loginVO.email}" ></td>
					</tr>
					</table>
					<br>
					<table border="0" align="center">
					<tr>
						<td colspan="3" align="center" class="btnwrap2">
							<input type="submit" value="수정" class="btn-sign" >
							<input type="reset" value="초기화" class="btn-signIn">
							<input type="button" value="취소" class="btn-signIn" onclick="history.back()">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
<hr>

</body>



<script>
function pwchk(){
	var chk_pw = $('#pw1').val();
	if($('#pw1').val() == $('#pw2').val()){
		if(/^[a-zA-Z0-9]{4,12}$/.test(chk_pw)){
			return true;	
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

</html>