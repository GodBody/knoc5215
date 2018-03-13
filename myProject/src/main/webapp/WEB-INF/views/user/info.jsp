<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Starter</title>
<!-- jQuery -->
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- Bootstrap core CSS -->
<link
	href="<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />"
	rel="stylesheet">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/simple-sidebar.css"/>"
	rel="stylesheet">
<!-- Bootstrap core JavaScript -->
<script type="text/javascript"
	src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<style type="text/css">
</style>
</head>
<body>
	<div id="wrapper">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li class="sidebar-brand"><a
					href="http://localhost:8080/user/home"> Start Bootstrap </a></li>
				<li><a href="http://localhost:8080/uboard/list">공지사항</a></li>
				<li><a href="http://localhost:8080/sboard/list">자유게시판</a></li>
				<li><a href="http://localhost:8080/lol/infoPage">전적검색</a></li>
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
						<div class="box-header">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h3 class="box-title">회원정보</h3>
							<button id="infoChangeBtn" class="glyphicon glyphicon-user"
								value="회원정보 변경"></button>
						</div>
						<!-- /.box-header -->
						<br>
						<div class="box-body">
							<table class="table table-striped">
								<tr>
									<th>이름</th>
									<th>아이디</th>
									<th>이메일</th>
									<th>닉네임</th>

								</tr>

								<tr>
									<td id="uname">${sessionScope.login.uname}</td>
									<td id="uid">${sessionScope.login.uid}</td>
									<td id="uemail">${sessionScope.login.uemail}</td>
									<td id="unickname">${sessionScope.login.unickname}</td>
								</tr>
							</table>
						</div>
						<!--  /.box-body -->
					</div>
					<!--  /.box-primary -->
				</div>
				<!-- /.col -->
			</div>
			<!--  /.container -->
		</div>
		<!-- /. page-content-wrapper -->
	</div>
	<!-- /. wrapper -->
	<script>
	
	<!-- Menu Toggle Script --> 
	$("#menu-toggle").click(function(e) {
		e.preventDefault();
		$("#wrapper").toggleClass("toggled");
	});
	
	<!-- Modal Action -->
	$("#loginModalBtn").click(function() {
		$("#loginModal").modal();
	});
		
	$(document).on('click', '#infoChangeBtn', function() {
		
			var uid = document.getElementById("uid").innerHTML
			
			var password = prompt("비밀번호를 입력하세요", "");
			
			console.log("uid: "+ uid + " / upw: " + password);
			
			var postData = {
					'uid' : uid,
					'upw' : password
			};
			
			$.ajax({
				url : '/user/pwCheck',
				type : 'POST',
				data : JSON.stringify(postData),
				contentType : "application/json; charset=UTF-8",
				
				success : function (data) {
					if(data == 'success') {
						
						self.location = "/user/infoChange";
					}
					else {
						alert("비밀번호가 틀렸습니다.");
						location.reload();
					}
				}
			});
			
			
		});
	</script>
</body>
</html>

