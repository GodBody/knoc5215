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
	body
	{
	padding-top
	:
	50px;
}

input:focus::-webkit-input-placeholder {
	color: transparent;
}

input:focus::-moz-placeholder {
	color: transparent;
}

input:focus:-ms-input-placeholder {
	color: transparent;
}

input:focus::-ms-input-placeholder {
	color: transparent;
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

		<!-- general form elements -->
		<div id="page-content-wrapper">
			<div class="container-fluid">
				<div class="col-md-16">
					<div class="box box-primary">
						<div class="box-header with-border">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
					Menu</a>
							<h3 class="box-title">공지사항</h3>
						</div>
						<div class="box-body">

							<div class='box-body'>

								<select name="searchType">
									<option value="n"
										<c:out value="${cri.searchType == null?'selected':''}"/>>
										전체</option>
									<option value="patch"
										<c:out value="${cri.searchType eq 'patch'?'selected':''}"/>>
										패치노트</option>
									<option value="lotation"
										<c:out value="${cri.searchType eq 'lotation'?'selected':''}"/>>
										로테이션</option>
								</select>

								<button class="glyphicon glyphicon-search" id='searchBtn'></button>
								<button class="glyphicon glyphicon-refresh" id='updateBtn'></button>

							</div>
							<div class="box-body">

								<table class="table table-striped">
									<tr>
										<th style="width: 10px">번호</th>
										<th>제목</th>
										<th>날짜</th>
										<th style="width: 40px">조회수</th>
									</tr>

									<c:forEach items="${list}" var="UpdateVO">
										<tr>
											<td>${UpdateVO.bno}</td>
											<td><a
												href='http://www.leagueoflegends.co.kr/?m=news&cate=update${UpdateVO.content }'>${UpdateVO.title }
											</a></td>
											<%-- <td><a href='/uboard/readPage?bno=${UpdateVO.bno}'>${UpdateVO.title }
									</a></td> --%>

											<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
													value="${UpdateVO.regdate}" /></td>
											<td><span class="badge">${UpdateVO.viewcnt }</span></td>
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
			<!-- /.container -->
		</div>
		<!-- /. page-content-wrapper -->
	</div>
	<!-- /.wrapper -->

	<script>
		$(document)
				.ready(
						function() {
							
						<!-- Auto Toggled -->
							$('#searchBtn')
									.on(
											"click",
											function(event) {
												if ($("select option:selected")
														.val() == "patch") {
													self.location = "list"
															+ '${pageMaker.makeQuery(1)}'
															+ "&searchType="
															+ $(
																	"select option:selected")
																	.val()
															+ "&keyword="
															+ "패치 노트";
												} else if ($(
														"select option:selected")
														.val() == "lotation") {
													self.location = "list"
															+ '${pageMaker.makeQuery(1)}'
															+ "&searchType="
															+ $(
																	"select option:selected")
																	.val()
															+ "&keyword="
															+ "로테이션";
												} else {
													self.location = "list"
															+ '${pageMaker.makeQuery(1)}'
															+ "&searchType="
															+ $(
																	"select option:selected")
																	.val()
															+ "&keyword="
															+ $('#keywordInput')
																	.val();
													;
												}

											});

							$('#newBtn').on("click", function(evt) {

								self.location = "register";

							});

						});

		$("#updateBtn").on("click", function() {
			$.get("/uboard/update")
			alert("게시글 업데이트 완료.");
			self.location = "/uboard/list";
		});
		<!-- Menu Toggle Script -->
			$("#menu-toggle").click(function(e) {
				e.preventDefault();
				$("#wrapper").toggleClass("toggled");
			});			
		<!-- Modal Action -->
			$(document).ready(function() {
				$("#loginModalBtn").click(function() {
					$("#loginModal").modal();
				});
			});
	</script>
</body>
</html>