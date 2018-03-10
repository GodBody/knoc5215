<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<style type="text/css">
.box-body {
	text-align: center;
}

.box-footer {
	text-align: center;
}
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
					<div class="box-primry">
						<div class="box-header">
							<!-- menu-toggle -->
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h1 style="text-align: center;">아이디 찾기</h1>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div>
								<form>
									<strong>이름</strong> : <input type="text" name="uname" id="name">
									<strong>이메일</strong> : <input type="text" name="uemail"
										id="email">
								</form>
							</div>
							<button class="glyphicon glyphicon-search" id='searchIDBtn'></button>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<span id="idSpan"></span>
						</div>
						<!-- /.box-footer -->
					</div>
					<!-- /.box-primary -->
					<br/>
					<br/>
					<br/>
					<br/>
					
					<div class="box-primary">
						<div class="box-header">
							<h1 style="text-align: center;">비밀번호 찾기</h1>
						</div>

						<div class="box-body">
							<form>
								<strong>아이디</strong> : <input type="text" name="uid" id="id_pw"><br>
								<strong>이름</strong> : <input type="text" name="uname"
									id="name_pw"><br> <strong>이메일</strong> : <input
									type="text" name="uemail" id="email_pw"><br>
							</form>
							<button class="glyphicon glyphicon-search" id='searchPWBtn'></button>
						</div>

						<div class="box-footer">
							<span id="pwSpan"></span>
						</div>
					</div>
				</div>
				<!--  /. col div -->


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
	<!-- /.LoginModal -->

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

$(document).on('click', '#searchIDBtn', function() {
			var name = $('#name').val();
			var email = $('#email').val();
			console.log(name + "/" + email);

			var postData = {
				'uname' : name,
				'uemail' : email
			};

			$.ajax({
				url : '/user/idSearch',
				type : 'POST',
				data : postData,
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType : "json",

				success : function(data) {
					var id = data.uid;
					var err = 'null';
					if(id != err) {
					$("#idSpan").append("<h4> " + "찾으시는 아이디는 " + id + " 입니다.<h4>");
					}
					else {
						$("#idSpan").append("이름 혹은 이메일을 확인해주세요");
					}
					
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('다시 입력하세요');
				}
			});
	});
	
$(document).on('click', '#searchPWBtn', function() {
		var id = $('#id_pw').val();
		var name = $('#name_pw').val();
		var email = $('#email_pw').val();

		var postData = {
				'uid' : id,
			'uname' : name,
			'uemail' : email
		};

		$.ajax({
			url : '/user/pwSearch',
			type : 'POST',
			data : postData,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : "json",

			success : function() {
				alert("등록하신 이메일로 비밀번호 변경 링크를 보냈습니다");
			},
			error : function() {
				alert('다시 입력하세요');
			}
		});
	});
</script>
</body>
</html>

