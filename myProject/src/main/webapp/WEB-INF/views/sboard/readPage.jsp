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
<!--Custom JavaScript src -->
<script type="text/javascript" src="/resources/js/upload.js"></script>
<!-- handlebars -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>

<style type="text/css">
.popup {
	position: absolute;
}

.back {
	background-color: gray;
	opacity: 0.5;
	width: 100%;
	height: 300%;
	overflow: hidden;
	z-index: 1101;
}

.front {
	z-index: 1110;
	opacity: 1;
	boarder: 1px;
	margin: auto;
}

.show {
	position: relative;
	max-width: 1200px;
	max-height: 800px;
	overflow: auto;
}

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

	<div class='popup back' style="display: none;"></div>
	<div id="popup_front" class='popup front' style="display: none;">
		<img id="popup_img">
	</div>

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
						<div class="box-header">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
					Menu</a>
							<h3 class="box-title"></h3>
						</div>
						<!-- /.box-header -->

						<!--  form  -->
						<form role="form" action="modifyPage" method="post">
							<input type='hidden' name='bno' value="${board.bno}"> <input
								type='hidden' name='page' value="${cri.page}"> <input
								type='hidden' name='perPageNum' value="${cri.perPageNum}">
							<input type='hidden' name='searchType' value="${cri.searchType}">
							<input type='hidden' name='keyword' value="${cri.keyword}">
						</form>

						<div class="box-body">
							<div class="form-group">
								<label for="title">제목</label> <input type="text" name='title'
									class="form-control" value="${board.title}" readonly="readonly">
							</div>
							<div class="form-group">
								<label for="content">내용</label>
								<textarea class="form-control" name="content" rows="3"
									readonly="readonly">${board.content}</textarea>
							</div>
							<div class="form-group">
								<label for="writer">작성자</label> <input type="text" name="writer"
									class="form-control" value="${board.writer}"
									readonly="readonly">
							</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">

							<div>
								<hr>
							</div>

							<ul class="mailbox-attachments clearfix uploadedList">

							</ul>
							<c:if test="${login.uid == board.writer }">
								<button type="submit" class="btn btn-warning" id="modifyBtn">Modify</button>
								<button type="submit" class="btn btn-danger" id="removeBtn">REMOVE</button>
							</c:if>
							<button type="submit" class="btn btn-primary" id="goListBtn">LIST</button>
						</div>
						<!-- /.box-footer -->

					</div>
					<!-- /.box -->
				</div>
				<!--/.col (left) -->

				<div class="row">
					<div class="col-md-12">
						<div class="box box-success">
							<c:if test="${not empty login }">
								<div class="box-body">
									<label for="newReplyWriter">작성자</label> <input
										class="form-control" type="text" id="newReplyWriter"
										placeholder="USER ID" value="${login.uid }"
										readonly="readonly"> <label for="newReplyText">댓글</label>
									<input class="form-control" type="text" id="newReplyText"
										placeholder="REPLY TEXT">
								</div>
								<!--  /.box-body -->
								<div class="box-footer">
									<button type="submit" class="btn btn-primary" id="replyAddBtn">등록</button>
								</div>
							</c:if>
							<br /> <br />

							<c:if test="${empty login }">
								<div class="box-body">
									<div>
										<a href="http://localhost:8080/user/login">로그인</a>
									</div>
								</div>
							</c:if>

							<div class="box-footer" id="repliesDiv">
								<c:forEach items="${replyList}" var="reply">
									<c:choose>
										<c:when test="${sessionScope.login.uid eq reply.replyer}">
											<p>
												<strong><span>${reply.replyer}</span></strong> :
												${reply.replytext } - <span id="rnoSpan">${reply.rno }</span>
											</p>
											<a class="btn btn-primary btn-xs" data-toggle="modal"
												data-target="#modifyModal">Modify</a>
										</c:when>
										<c:otherwise>
											<p>
												<strong><span>${reply.replyer}</span></strong> :
												${reply.replytext } - <span id="rnoSpan">${reply.rno }</span>
											</p>
										</c:otherwise>
									</c:choose>

								</c:forEach>
							</div>


						</div>

					</div>
					<!-- /. col -->
				</div>
				<!--  /.row -->
			</div>
			<!--  /.container -->
		</div>
		<!-- /. page-content-wrapper -->
	</div>
	<!-- /. wrapper -->

	<!-- Modal -->
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">수정 및 삭제</h4>
				</div>
				<div class="modal-body" data-rno>
					<p>
						<input type="text" id="replytext" class="form-control">
					</p>
				</div>
				<div class="modal-footer">


					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

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
		$("#replyAddBtn").on("click", function() {

			var replyerObj = $("#newReplyWriter");
			var replytextObj = $("#newReplyText");
			var replyer = replyerObj.val();
			var replytext = replytextObj.val();

			$.ajax({
				type : 'post',
				url : '/replies/',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					console.log("result: " + result);
					if (result == 'SUCCESS') {
						alert("Insert Complete!");
						replyPage = 1;
						location.reload();
					}
				}
			});
		});

		$("#replyModBtn").on("click", function() {

			var rno = $("#rnoSpan").html();
			var replytext = $("#replytext").val();
			console.log(rno);

			$.ajax({
				type : 'put',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({
					replytext : replytext
				}),
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if (result == 'SUCCESS') {
						alert("Modify Complete!");
						location.reload();
					}
				}
			});
		});

		$("#replyDelBtn").on("click", function() {

			var rno = $("#rnoSpan").html();
			var replytext = $("#replytext").val();

			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if (result == 'SUCCESS') {
						alert("Delete Complete!");
						location.reload();
					}
				}
			});
		});
	</script>

	<script>
		$(document).ready(function() {

			var formObj = $("form[role='form']");

			console.log(formObj);

			$("#modifyBtn").on("click", function() {
				formObj.attr("action", "/sboard/modifyPage");
				formObj.attr("method", "get");
				formObj.submit();
			});

			$("#removeBtn").on("click", function() {

				var replyCnt = $("#repliesDiv").html().replace(/[^0-9]/g, "");

				if (replyCnt > 0) {
					alert("댓글이 있는 글은 지울 수 없습니다.");
					return;
				}

				var arr = [];
				$(".uploadedList li").each(function(index) {
					arr.push($(this).attr("data-src"));
				});

				if (arr.length > 0) {
					$.post("/deleteAllFiles", {
						files : arr
					}, function() {

					});
				}

				formObj.attr("action", "/sboard/removePage");
				formObj.submit();
			});

			$("#goListBtn ").on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/sboard/list");
				formObj.submit();
			});

		});
	</script>

	<script id="templateAttach" type="text/x-handlebars-template">
<li data-src='{{fullName}}'>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
  </div>
</li>                
</script>

	<script>
		var bno = ${board.bno};
		//var bno = ${board.bno};
		var template = Handlebars.compile($("#templateAttach").html());

		$.getJSON("/sboard/getAttach/" + bno, function(list) {
			$(list).each(function() {

				var fileInfo = getFileInfo(this);

				var html = template(fileInfo);

				$(".uploadedList").append(html);

			});
		});

		$(".uploadedList").on("click", ".mailbox-attachment-info a",
				function(event) {

					var fileLink = $(this).attr("href");

					if (checkImageType(fileLink)) {

						event.preventDefault();

						var imgTag = $("#popup_img");
						imgTag.attr("src", fileLink);

						console.log(imgTag.attr("src"));

						$(".popup").show('slow');
						imgTag.addClass("show");
					}
				});

		$("#popup_img").on("click", function() {

			$(".popup").hide('slow');

		});
	</script>
</body>
</html>