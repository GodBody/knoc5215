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
.modal-header, h4, .close {
	background-color: #5cb85c;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
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
					<div class="box box-primary">
						<div class="box-header with-border">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h3 class="box-title">자유게시판</h3>
						</div>
						<div class="box-body">

							<div class='box-body'>

								<select name="searchType">
									<option value="n"
										<c:out value="${cri.searchType == null?'selected':''}"/>>
										---</option>
									<option value="t"
										<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
										Title</option>
									<option value="c"
										<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
										Content</option>
									<option value="w"
										<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
										Writer</option>
									<option value="tc"
										<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
										Title OR Content</option>
									<option value="cw"
										<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
										Content OR Writer</option>
									<option value="tcw"
										<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
										Title OR Content OR Writer</option>
								</select> <input type="text" name='keyword' id="keywordInput"
									value='${cri.keyword }'>
								<button class="glyphicon glyphicon-search" id='searchBtn'></button>
								<button class="glyphicon glyphicon-pencil" id='newBtn'></button>
							</div>
							<div class="box-body">
								<table class="table table-striped">
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>날짜</th>
										<th>조회수</th>
									</tr>

									<c:forEach items="${list}" var="Board">
										<tr>
											<td>${Board.bno}</td>
											<td><a
												href='/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${Board.bno}'>${Board.title }
													<strong>[ 댓글 수 : ${Board.replycnt } ]</strong>
											</a></td>
											<td>${Board.writer }</td>
											<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
													value="${Board.regdate}" /></td>
											<td><span class="badge bg-red">${Board.viewcnt }</span></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
						<div class="box-footer">
							<div class="text-center">
								<ul class="pagination">
									<c:if test="${pageMaker.prev }">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a>
										</li>
									</c:if>
									<c:forEach begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }" var="idx">
										<li
											<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
											<a href="list${pageMaker.makeSearch(idx) }">${idx }</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="list${pageMaker.makeSearch(pageMaker.endPage+1) }">&raquo;</a>
										</li>

									</c:if>
								</ul>
							</div>
						</div>
						<!-- /.footer -->
					</div>

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
		var result = '${msg}';
		if (result == 'SUCCESS') {
			alert("Complete!");
		}
		
		<!-- Menu Toggle Script --> 
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
		
		<!-- Modal Action -->
		
		$("#loginModalBtn").click(function() {
			$("#loginModal").modal();
		});
	
		
		$(document).ready(
								
				function() {

					$('#searchBtn').on(
							"click",
							function(event) {

								self.location = "list"
										+ '${pageMaker.makeQuery(1)}'
										+ "&searchType="
										+ $("select option:selected").val()
										+ "&keyword="
										+ $('#keywordInput').val();

							});

					$('#newBtn').on("click", function(evt) {

						self.location = "register";

					});

				});
	</script>
</body>
</html>
