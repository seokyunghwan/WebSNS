<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/update.css"/>">
<title>글쓰기</title>
</head>
<script type="text/javascript">
	var str1 = "";
	$(document).ready(function(e) {
		$(".update-btn").click(function(e) {

		});
		$("#uploadFile").change(function(e) {

			$('#preview').empty();

			var files = e.target.files;
			var arr = Array.prototype.slice.call(files);

			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
			}

			preview(arr);

		});
		$('#txt_area').keyup( function(e) {
			var key = event.charCode || event.keyCode || 0;
			if(key != 16 && $('#txt_area').val().charAt($('#txt_area').val().length - 1) == '@'){

			}
		});
		
		function checkExtension(fileName, fileSize) {

			var regex = new RegExp("(.*?)\.(bmp|gif|jpeg|png|mp4|avi|jpg|JPG)$");
			var maxSize = 20971520; //20MB

			if (fileSize >= maxSize) {
				alert('파일 사이즈 초과');
				$("input[type='file']").val("");
				return false;
			}

			if (!regex.test(fileName)) {
				alert('사진및 동영상을 업로드 하세요');
				$("input[type='file']").val("");
				return false;
			}
			return true;
		}

		function preview(arr) {
			arr.forEach(function(f) {

				var str = '<div style="padding: 10px; display:inline-block;">';

				if (f.type.match('image.*')) {
					var reader = new FileReader();
					reader.onload = function(e) {
						str += '<img src="'+e.target.result+'"width=200px>';
						str += '</li></div>';
						$(str).appendTo('#preview');
					}
					reader.readAsDataURL(f);
				} else {
					str += '<img src="<c:url value="/resources/img/video.png"/>" width=300 height=300>';
					$(str).appendTo('#preview');
				}
			});
		}
	});
</script>
<body>
	<div class="update" id="updateId" style="display:none;">
		<form action="writeFeed.do" enctype="multipart/form-data" method="post">
			<input type="hidden" name="id" value="${loginVO.id }"/>
			<div class="title">
				<!-- 타이틀 공간 -->
				<span id="title"> <strong>게시물 만들기</strong>
				</span> <span><input type="reset" value=" " class="x"></span>

			</div>

			<div class="myinfo">
				<!-- 내정보 공간 및 공개범위 설정 -->
				<div class="profile">
					<img src="<c:url value="/profile/${loginVO.memimg }"/>" width="48px" height="48px" alt="">
					<!-- 프로필사진들어와야할 곳 -->
				</div>
				<div class="profile">
					<div>
						<b class="id">${loginVO.memname}</b>
					</div>
					<!-- id -->
					<select name="privacy">
						<option value="everyone" selected="selected">전체 공개</option>
						<option value="me">나만 보기</option>
						<option value="friend">친구만</option>
					</select>
				</div>
			</div>

			<div class="write">
				<!-- 글내용 적는 공간 -->
				<textarea rows="10" cols="68" name="txt" placeholder="게시할 글을 작성해주세요." required></textarea>

			</div>
			<div id="preview"></div>
			<br>
			<div class="add">
				<!-- 사진및 친구 태그 설정 -->
				<div class="add-b">
					<b>게시물에 추가</b>
				</div>
				<div class="add-camera">
					<label for="uploadFile" title="사진/동영상"> 
					<img alt="사진/동영상" src="<c:url value="/resources/img/camera.png"/>">
					</label> 
					<input type="file" id="uploadFile" name="txtFile2" multiple="multiple" accept="image/*, video/*">
				</div>

			</div>

			<div class="update">
				<!-- 게시물 올리기 -->
				<input class="update-btn" type="submit" value="게시">
			</div>
		</form>
	</div>
</body>
</html>