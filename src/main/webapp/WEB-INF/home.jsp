<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Gothic+A1&family=Gowun+Batang&family=Hahmlet&family=Song+Myung&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

<style type="text/css">
body, body * {
	font-family: 'Gowun Batang';
}
</style>

</head>
<body>
	<h2>
		<b>Jenkins에 Maven Project 배포연습~!</b>
	</h2>

	<h3>자동빌드테스트</h3>
	<div>
		<textarea style="width: 100%; height: 120px" class="form-control"
			id="msg">프로젝트 진행 중...</textarea>
	</div>
	<div class="input-group" style="width: 250px; margin-left: 50px;">
		<select id="seltrans" class="form-select">
			<option value="en">영어</option>
			<option value="ja">일어</option>
			<option value="zh-CN">중국어</option>
			<option value="es">스페인어</option>
			<option value="de">독일어</option>
		</select>
		<button type="button" id="btntrans" class="btn btn-outline-secondary">번역하기</button>
		<i class="bi bi-megaphone speak voicespeak"
			style="font-size: 30px; margin-left: 10px; cursor: pointer;"></i>
	</div>

	<div id="trans"
		style="margin-top: 20px; width: 100%; margin-left: 30px; font-size: 18px; font-weight: bold;"></div>

	<script type="text/javascript">
		$("#btntrans").click(function() {
			// 입력메세지
			let msg = $("#msg").val();
			// 선택한 나라 기호
			let lang = $("#seltrans").val();

			$.ajax({
				type : "post",
				url : "./trans",
				data : {
					"msg" : msg,
					"lang" : lang
				},
				dataType : "text",
				success : function(res) {
					//alert(res);

					// String json변환
					let j = JSON.parse(res);

					// 번역한 문자열 얻기
					let s = j.message.result.translatedText;

					// div에 출력
					$("#trans").html(s);

				}
			});
		});

		// 스피커 클릭시
		$(".voicespeak").click(
				function() {
					// 입력메세지
					let msg = $("#trans").text();
					// 선택한 나라 기호
					let lang = $("#seltrans").val();

					if (lang == 'en' || lang == 'ja' || lang == 'zh-CN'
							|| lang == 'es' || lang == 'ko') {

						$.ajax({
							type : "get",
							url : "./voice",
							data : {
								"msg" : msg,
								"lang" : lang
							},
							dataType : "text",
							success : function(res) { // res -> mp3 text 파일명
								//alert(res);
								let audio = new Audio(res);
								audio.play();
							}
						});
					} else {
						alert("현재 서비스하지 않는 언어입니다.");
					}
				});
	</script>

</body>
</html>






















