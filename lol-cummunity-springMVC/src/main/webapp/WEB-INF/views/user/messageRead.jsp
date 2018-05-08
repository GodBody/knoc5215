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
					<!-- general form elements -->

					<div class="box box-primary">
						<div class="box-header">
							번호 : <span id="mnoSpan">${messageVO.mno }</span>
						</div>
						<!-- /.box-header -->

						<form role='form' action="messageRemove" method="post">
							<input type="hidden" name="mno" id="mnoForm"
								value=${messageVO.mno }>
						</form>


						<div class="box-body">
							<div class="form-group">
								<label for="sender">발신자</label> <input type="text" name='sender'
									id='sender' class="form-control" value="${messageVO.sender}"
									readonly="readonly">
							</div>
							<div class="form-group">
								<label for="content">내용</label>
								<textarea class="form-control" name="content" rows="8"
									readonly="readonly">${messageVO.content}</textarea>
							</div>
							<div class="form-group">
								<label for="regdate">등록시간</label>
								<p>
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${messageVO.regdate}" />
								</p>
							</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<button id="replyBtn" type="submit" class="btn btn-primary">답장</button>
							<button id="removeBtn" type="submit" class="btn btn-warning">삭제</button>
						</div>
						<!-- /.box-footer -->

					</div>
					<!-- /.box-primary -->
				</div>
				<!--/.col (left) -->
			</div>
			<!--  /.container -->
		</div>
		<!-- /. page-content-wrapper -->
	</div>
	<!-- /. wrapper -->
	<script>
		$(document).ready(function() {
			console.log($("#mnoSpan").val());

			$("#replyBtn").on("click", function() {
				var receiver = $("#sender").val();
				console.log(receiver);

				self.location = "/user/messageSend?receiver=" + receiver;
			});

			$("#removeBtn").on("click", function() {

				var mno = $("#mnoForm").val();
				console.log(mno);

				$.ajax({
					type : 'delete',
					url : '/user/messageRemove/' + mno,
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					success : function(result) {
						console.log("result: " + result);
						if (result == 'SUCCESS') {
							alert("메세지가 삭제되었습니다.");
							window.close();
						}
					}
				});
			});

		});
	</script>
</body>
</html>