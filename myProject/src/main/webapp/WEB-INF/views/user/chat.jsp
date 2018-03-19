<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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
<!-- json2 -->
<script type="text/javascript"
	src="<c:url value="/resources/js/json2.js"/>"></script>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
</head>
<style type="text/css">
</style>

<title>채팅</title>

<body>

	<div id="wrapper">
		<!-- Sidebar -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a
					href="http://localhost:8080/user/home"> Start Bootstrap </a></li>
				<li><a href="http://localhost:8080/uboard/list">공지사항</a></li>
				<li><a href="http://localhost:8080/sboard/list">자유게시판</a></li>
				<li><a href="http://localhost:8080/lol/infoPageStart">전적검색</a></li>
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
				<!-- <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2"> -->
				<div class="col-md-12">
					<div class="box-primary">
						<div class="box-header">
							<!-- menu-toggle -->
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h2 style="text-align: center;">채팅</h2>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							회원 : <input type="text" id="sender" readonly="readonly"
								value="${sessionScope.login.uid }"
								style="background-color: #e2e2e2;" /> <br /> <input
								type="text" id="message" onkeyup="enterKey();" /> <input
								type="button" id="sendBtn" value="전송" />
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<div id="chatMessage" style="overFlow: auto; max-height: 500px;">
								<textarea id="textarea" rows="20" cols="40" readonly="readonly"></textarea>
							</div>

							<!-- /.chatMessage -->
						</div>
						<!-- /.box-footer -->
					</div>
					<!-- /.box-primary -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /. container -->
		</div>
		<!-- /. page-content-wrapper -->
	</div>
	<!-- /. wrapper -->

	<!-- Login Modal -->
	<div class="modal fade" id="loginModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4>
						<span class="glyphicon glyphicon-lock"></span> 로그인
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">

					<form action="<c:url value='/user/loginProcess' />" method="post">
						<div class="form-group">
							<label for="uid"><span class="glyphicon glyphicon-user"></span>아이디</label>
							<input type="text" class="form-control" name="uid"
								placeholder="ID를 입력하세요">
						</div>
						<div class="form-group">
							<label for="upw"><span
								class="glyphicon glyphicon-eye-open"></span> Password</label> <input
								type="text" class="form-control" name="upw"
								placeholder="비밀번호를 입력하세요">
						</div>
						<div class="checkbox">
							<label><input type="checkbox" name="useCookie" checked>자동
								로그인</label>
						</div>
						<button type="submit" class="btn btn-success btn-block">
							<span class="glyphicon glyphicon-off"></span> 로그인
						</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger btn-default pull-left"
						data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span>취소
					</button>
					<p>
						<a href="register">회원가입</a> <a href="naverLogin">네이버로 회원가입</a>
					</p>
					<p>
						<a href="forgetID">아이디 찾기</a> <a href="forgetPW">비밀번호 찾기</a>
					</p>
				</div>
			</div>

		</div>
	</div>

	<script type="text/javascript">

<!-- Menu Toggle Script --> 
$("#menu-toggle").click(function(e) {
	e.preventDefault();
	$("#wrapper").toggleClass("toggled");
});

<!-- Modal Action -->
$("#loginModalBtn").click(function() {
	$("#loginModal").modal();
});
	$(document).ready(function() {

		$("#sendBtn").on("click", function() {
			sendMessage();
		});

	});

	var sock = new SockJS("<c:url value="/echo-ws"/>");

	sock.onmessage = onMessage;

	sock.onclose = onClose;

	function sendMessage() {
		sock.send($("#message").val() + "<br/>");
	}

	function onMessage(evt) {
		var data = evt.data;

		var userArr = data.split(":");
		userID = userArr[0];
		console.log(userID);

		$("#textarea").append(data + "\n");
		console.log('채팅 : ' + data);

	}

	function onClose(evt) {
		$("#textarea").append(userID + "접속이 종료되었습니다.");
	}

	function enterKey() {
		if (window.event.keyCode == 13) {
			sendMessage();
		}
	}
</script>
</body>

</html>