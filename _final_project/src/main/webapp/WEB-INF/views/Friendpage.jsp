<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="<c:url value="/resources/css/mypage.css"/>">

</head>
<body>
	<script>
		$(".closebtn").click(function() {
			$(".friendpage").empty();
		});
	</script>
	
	<form name="friendpage" action="friendProfile.do" method="post"
		enctype="multipart/form-data" >
		<input type="hidden" name="id" value="">
		<table class="friendtable" border="0" align="center">
			<tr>
				<td colspan="2" class="title"> <!-- 친구이름 -->Page</td>
			</tr>
			<tr>
				<td colspan="2" class="labelpic"><input type="file" id="upload"
					name="file" class="input" accept="image/*" style="display: none;">
					<img id="profile"
					src="<c:url value="/profile/${loginVO.memimg}"/>" width="200px"
					height="200px" onclick="imgSelect();"></td>
			</tr>
	

		
			<tr>
				<td class="labelid">● ID</td>
				<td class="updateid" colspan=2 align="left"></td>
			</tr>

			<tr>
				<td class="labelname">● 이름</td>
				<td class="updatename" colspan=2 align="left"></td>
			</tr>
			<tr>
				<td class="labelemail">● 이메일 </td>
				<td class="updateemail" colspan=2 align="left"></td>
			</tr>

		</table>

	</form>
</body>
</html>