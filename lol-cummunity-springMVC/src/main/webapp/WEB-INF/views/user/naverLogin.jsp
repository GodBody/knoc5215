<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>네이버 계정으로 회원가입</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

<!-- Bootstrap core CSS -->
<link
	href="<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/simple-sidebar.css"/>"
	rel="stylesheet">
<!-- Bootstrap core JavaScript -->
<script type="text/javascript"
	src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
html, div, body, h3 {
	margin: 0;
	padding: 0;
}

h3 {
	display: inline-block;
	padding: 0.6em;
}
</style>
</head>
<script>
	$(document).ready(function() {
		self.location = "${url}";
	});
	
	<!-- Menu Toggle Script --> 
	$("#menu-toggle").click(function(e) {
		e.preventDefault();
		$("#wrapper").toggleClass("toggled");
	});

	<!-- Modal Action -->
	$("#loginModalBtn").click(function() {
		$("#loginModal").modal();
	});
		$("#naverBtn").on("click", function() {
			self.location = "/user/naverLogin";
		});
</script>

<body>

	<div id="wrapper">
		<!-- Sidebar -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a
					href="http://localhost:8080/user/home"> Start Bootstrap </a></li>
				<li><a href="http://localhost:8080/uboard/list">공지사항</a></li>
				<li><a href="http://localhost:8080/sboard/list">자유게시판</a></li>
				<c:choose>
					<c:when test="${sessionScope.login eq null}">
						<li id="loginModalBtn"><a href="#">로그인</a></li>
					</c:when>
					<c:when test="${sessionScope.login ne null}">

						<li><a href="http://localhost:8080/user/info">회원정보</a></li>
						<li><a href="http://localhost:8080/user/message">메세지</a></li>
						<li><a href="http://localhost:8080/user/chat">채팅</a></li>
						<li><a href="http://localhost:8080/user/logout">로그아웃</a></li>
					</c:when>
				</c:choose>
			</ul>
		</div>
		<!-- /#sidebar-wrapper -->
		<div id="page-content-wrapper">
			<div class="container-fluid">
				<div class="col-md-12">
					<!-- general form elements -->
					<div
						style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
						<h3>Naver</h3>
					</div>
					<br>
					<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
					<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
					<div id="naver_id_login" style="text-align: center">
						<a href="${url}"><img width="223"
							src="${pageContext.request.contextPath}/resources/img/naver_Bn_Green.PNG" /></a>
					</div>
					<br>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.container -->
		</div>
		<!-- /.page-content-wrapper -->
	</div>
	<!-- /. wrapper -->
</body>
</html>