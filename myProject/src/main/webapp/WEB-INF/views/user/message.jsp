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
							<!-- menu-toggle -->
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h3 class="box-title"></h3>
						</div>
						<!-- /.box-header -->


						<form name='messageForm' role="form" method="post">
							<div class="box-body">

								<div class="form-group">
									<label for="sender">발신자</label> <input type="text"
										class="form-control" name="sender" value="${userVO.uid}"
										readonly="readonly">
								</div>

								<div class="form-group">
									<label for="receiver">수신자</label> <input type="text"
										class="form-control" name="receiver" placeholder="수신자를 입력하세요.">
								</div>

								<div class="form-group">
									<label for="Content">내용</label>
									<textarea class="form-control" name="content" id="content"
										rows="3" placeholder="메시지를 입력하세요."></textarea>
								</div>
							</div>
							<!-- /. box-body -->
							<div class="box-footer">

								<button type="submit" class="btn btn-primary" onclick="check()">전송</button>
							</div>

						</form>
						<!-- /.form tag -->
					</div>
					<!--  /.box-primary -->
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title"></h3>
						</div>
						<!-- /.box-header -->

						<div class="box-body">
							<table class="table table-striped">
								<tr>
									<th>발신자</th>
									<th>내용</th>
									<th>등록시간</th>
									<th>조회수</th>
								</tr>
								<tbody>
									<c:forEach items="${list}" var="msg">
										<tr>
											<td>${msg.sender}</td>
											<c:choose>
												<c:when test="${msg.viewcnt >= 1}">
													<td><a
														href='/user/messageRead${pageMaker.makeQuery(pageMaker.cri.page) }&mno=${msg.mno}'
														style="color: black"
														onclick="window.open(this.href,'_blank', 'width=500,height=500,left=0,top=0');return false;">${msg.content }
													</a></td>
												</c:when>
												<c:otherwise>
													<td><a
														href='/user/messageRead${pageMaker.makeQuery(pageMaker.cri.page) }&mno=${msg.mno}'
														onclick="window.open(this.href,'_blank', 'width=500,height=500,left=0,top=0');return false;"><strong>${msg.content }</strong>
													</a></td>
												</c:otherwise>
											</c:choose>
											<td><fmt:formatDate pattern="MM-dd HH:mm"
													value="${msg.regdate}" /></td>
											<td><span class="badge badge-pill badge-info">${msg.viewcnt }</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="box-footer">
							<div class="text-center">
								<ul class="pagination">
									<c:if test="${pageMaker.prev }">
										<li><a
											href="message${pageMaker.maekQuery(pageMaker.startPage-1) }">&laquo;</a>
										</li>
									</c:if>
									<c:forEach begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }" var="idx">
										<li
											<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
											<a href="message${pageMaker.makeQuery(idx) }">${idx }</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
										<li><a
											href="message${pageMaker.makeQuery(pageMaker.endPage+1) }">&raquo;</a>
										</li>

									</c:if>
								</ul>
							</div>
						</div>
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
	
		var result = '${msg}';
		if (result == 'SEND') {
			alert("메시지 전송 완료!");
		}
		
		else if (result == 'SEND_FAIL') {
			alert("존재하지 않는 사용자입니다.");
		}

		function check() {
			if (document.messageForm.receiver.length == 0
					|| document.messageForm.receiver.value == "") {
				alert("수신자를 입력하세요");
				document.messageForm.receiver.focus();
				event.preventDefault();
			}

			else if (document.messageForm.receiver.value == document.messageForm.sender.value) {
				alert("자신에게 보낼 수 없습니다");
				document.messageForm.receiver.focus();
				event.preventDefault();
			}

			else if (document.messageForm.content.length == 0
					|| document.messageForm.content.value == "") {
				alert("메시지를 입력하세요");
				document.messageForm.content.focus();
				event.preventDefault();
			}
		}
	</script>
</body>
</html>

