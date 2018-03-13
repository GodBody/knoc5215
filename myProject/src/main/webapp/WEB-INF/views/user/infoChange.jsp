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
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
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
				<div class="col-md-12">

					<div class="box-primary">
						<div class="box-header">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h2 style="text-align: center;">회원정보 변경</h2>
						</div>


						<div class="box-body">

							<form name='userRegisterForm' role='form' method="post">

								<div class="form-group">
									<label for="uid">아이디</label> <input type="text" name="uid"
										class="form-control" placeholder="Enter ID"
										value="${sessionScope.login.uid}" readonly="readonly">
								</div>
								<div class="form-group">
									<label for="upw">비밀번호</label> <input type="password" name="upw"
										class="form-control" placeholder="새로운 비밀번호를 입력하세요">
								</div>
								<div class="form-group">
									<label for="upw2">비밀번호 확인</label> <input type="password"
										name="upw2" class="form-control" placeholder="비밀번호 확인">
								</div>
								<div class="form-group">
									<label for="uname">이름</label> <input type="text" id="uname"
										name="uname" class="form-control"
										value="${sessionScope.login.uname}" readonly="readonly">
								</div>
								<div class="form-group">
									<label for="uname">닉네임</label> <input type="text"
										name="unickname" id="unickname" class="form-control"
										placeholder="변경할 닉네임을 입력하세요" readonly="readonly">

								</div>
								<div class="form-group">
									<label for="uname">이메일</label> <input type="text" id="uemail"
										name="uemail" class="form-control"
										value="${sessionScope.login.uemail}" readonly="readonly">
								</div>
								<button id="submitBtn" class="btn btn-primary" onclick="check()"
									type="submit" value="전송">전송</button>
							</form>

							<button id="cancelBtn" class="btn btn-warning" onclick="cancel()"
								value="취소">취소</button>
						</div>

						<div class="box-footer"></div>
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
		$(document).ready(function() {

			$("#submitBtn").on("click", function() {

				alert("수정되었습니다.");
				location.href = "http://localhost:8080/user/info";
			});
		});

		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		$("#loginModalBtn").click(function() {
			$("#loginModal").modal();
		});

		function check() {

			if (document.userRegisterForm.upw.value == "") {
				alert("비밀번호를 입력하세요.");
				document.userRegisterForm.upw.focus();
				event.preventDefault();
			}

			else if (document.userRegisterForm.upw2.value == "") {
				alert("비밀번호 확인을 입력하세요.");
				document.userRegisterForm.upw2.focus();
				event.preventDefault();
			}

			else if (document.userRegisterForm.unickname.value == "") {
				alert("닉네임을 입력하세요.");
				document.userRegisterForm.unickname.focus();
				event.preventDefault();
			}

			if ((document.userRegisterForm.upw.value != document.userRegisterForm.upw2.value)
					&& ((document.userRegisterForm.upw.length != 0) && (document.userRegisterForm.upw2.length != 0))) {
				alert("비밀번호가 일치하지 않습니다.");
				document.userRegisterForm.upw.focus();
				event.preventDefault();
			}

		}

		function cancel() {
			location.href = "http://localhost:8080/user/info";
		}

		var uid = document.userRegisterForm.uid.value;

		var nickname = document.getElementById("unickname");

		nickname.onclick = function() {
			var newNickname = prompt("새로운 닉네임을 입력하세요", "");
			console.log(newNickname);

			var postData = {
				"uid" : uid,
				"unickname" : newNickname
			};

			$
					.ajax({
						url : '/user/nicknameCheck',
						type : 'POST',
						data : JSON.stringify(postData),
						contentType : "application/json; charset=UTF-8",

						success : function(data) {
							if (data == 'success') {
								alert("사용가능한 닉네임입니다.")
								document.getElementById("unickname").value = newNickname;
							} else {
								alert("중복된 닉네임입니다.");
								location.reload();
							}
						}
					});
		}
	</script>

</body>
</html>