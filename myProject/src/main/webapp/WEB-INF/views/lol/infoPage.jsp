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
							<h3 class="box-title">전적검색</h3>

						</div>
						<!-- /.box-header -->

						<br>

						<div class="box-body">
							<div class="table table-striped">
								<form role="form" method="post">
									<strong>소환사</strong> : <input type="text" name="summonerName"
										id="summonerName"> <input type="submit" value="검색"
										id="submitBtn" placeholder="소환사명...">
								</form>
							</div>
						</div>

						<div class="box-footer">
							<div class="table">

								<c:if test="${summonerVO ne null }">
									<c:set var="summonerVO" value="${summonerVO}" scope="session" />

									<!-- <img id="srcTag" width="50px;" height="50px;"
										src=""> -->
									<img id="srcTag" width="50px;" height="50px;"
										src="https://opgg-static.akamaized.net/images/profile_icons/profileIcon<c:url value="${summonerVO.profileIconId }"/>.jpg" />
									<span> &nbsp;&nbsp;&nbsp;&nbsp; <strong>${summonerVO.name }</strong>
										(Lv. ${summonerVO.summonerLevel}) / ${summonerVO.tier}
										${summonerVO.rank } : ${summonerVO.leaguePoints }pt /
										${summonerVO.wins }승 ${summonerVO.losses }패 /
										${summonerVO.accountId }
									</span>
								</c:if>
							</div>
							<div>
								<table>
									<c:forEach items="${list}" var="matchVO">
										<tr>
											<td><img width="30px" height="30px"
												src="http://z.fow.kr/champ/<c:url value="${matchVO.champion}"/>.png" /></td>
											<td>
												<form role="form" action="<c:url value = "/lol/viewMatch"/>"
													method="get">
													<input type="hidden" name="gameId"
														value="${matchVO.gameId }">
													<!-- <input type="submit" value="게임 조회"> -->
													<button
														onclick="window.open('<c:url value = "/lol/viewMatch?gameId="/> + ${matchVO.gameId }','_blank');"
														type="button" value="게임 조회">상세</button>
												</form>
											</td>

										</tr>
									</c:forEach>
								</table>
							</div>
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
		var result = "${result}";
		if (result == 'success') {
			alert("소환사의 정보가 등록되었습니다.");
		}

		/* var profileIconId = "${summonerVO.profileIconId}";
		var src = "https://opgg-static.akamaized.net/images/profile_icons/profileIcon"
				+ profileIconId + ".jpg";

		console.log(profileIconId + " / " + src);
		$("#srcTag").attr("src", src); */

		$("#submitBtn").on("click", function() {
			$("#view").submit();
		});
	</script>
</body>
</html>
