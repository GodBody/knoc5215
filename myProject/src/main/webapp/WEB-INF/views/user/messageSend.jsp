<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Starter</title>
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
<!--Custom JavaScript src -->
<script type="text/javascript" src="/resources/js/upload.js"></script>
<!-- handlebars -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<style type="text/css">
</style>

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

					<div class="box box-primary">
						<div class="box-header"></div>
						<!-- /.box-header -->

						<form name='sendForm' role="form" id='messageForm'
							action="<c:url value="/user/messageSend"/>" method="post">
							<div class="box-body">
								<div class="form-group">
									<label for="sender">발신자</label> <input type="text"
										name='sender' id='sender' class="form-control"
										value="${sessionScope.login.uid}" readonly="readonly">
								</div>
								<div class="form-group">
									<label for="receiver">수신자</label> <input type="text"
										name="receiver" id="receiver" class="form-control"
										value="${receiver}" readonly="readonly">
								</div>
								<div class="form-group">
									<label for="content">내용</label>
									<textarea class="form-control" name="content" rows="8"
										placeholder="보낼 메세지를 입력하세요"></textarea>
								</div>
							</div>
							<!-- /.box-body -->

							<div class="box-footer">
								<button type="button" onclick="check()" class="btn btn-primary"
									id="sendBtn">전송</button>
								<button id="cancelBtn" type="button" class="btn btn-warning">취소</button>
							</div>
							<!-- /.box-footer -->
						</form>
						<!--  /.form tag -->
					</div>
					<!-- /.box -->
				</div>
				<!--/.col (left) -->
			</div>
			<!--  /.container -->
		</div>
		<!-- /. page-content-wrapper -->
	</div>
	<!-- /. wrapper -->

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
	
		function check() {
			if (document.sendForm.content.value == "") {
				alert("내용을 입력하세요.");
				document.messageSendForm.content.focus();
			} else if (document.sendForm.receiver.value == "") {
				alert("잘못된 접근입니다.");
				self.close();
			} else {
				$("#messageForm").submit();
				alert("전송되었습니다.");
			}
		}
	
	
		$(document).ready(function() {
	
	
			$("#cancelBtn").on("click", function() {
				self.close();
			});
		});
	</script>
</body>
</html>
