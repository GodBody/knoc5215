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
.fileDrop {
	width: 80%;
	height: 100px;
	border: 1px dotted gray;
	background-color: lightslategrey;
	margin: auto;
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
					<!-- general form elements -->
					<div class="box box-primary">
						<div class="box-header">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
						</div>
						<!-- /.box-header -->

						<!-- Form tag -->
						<form id='registerForm' role="form" method="post">
							<div class="box-body">
								<div class="form-group">
									<label for="title">제목</label> <input type="text" name='title'
										class="form-control" placeholder="제목을 입력하세요">
								</div>
								<div class="form-group">
									<label for="content">내용</label>
									<textarea class="form-control" name="content" rows="3"
										placeholder="내용을 입력하세요"></textarea>
								</div>
								<div class="form-group">
									<label for="writer">작성자</label> <input type="text"
										name="writer" class="form-control" value=${login.uid }
										readonly="readonly">
								</div>
								<div class="form-group">
									<label for="attach">첨부</label>
									<div class="fileDrop"></div>
								</div>
							</div>
							<!-- /.box-body -->

							<div class="box-footer">
								<div>
									<hr>
								</div>

								<ul class="mailbox-attachments clearfix uploadedList">
								</ul>
								<button type="submit" class="btn btn-primary">작성</button>
							</div>
						</form>
						<!-- /. Form tag -->
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

	
	<script id="template" type="text/x-handlebars-template">
<li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn btn-default btn-xs pull-right delbtn"><i class="glyphicon glyphicon-trash"></i></a>
	</span>
  </div>
</li>                
</script>

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
		var template = Handlebars.compile($("#template").html());
	
		$(".fileDrop").on("dragenter dragover", function(event) {
			event.preventDefault();
		});
	
		$(".fileDrop").on("drop", function(event) {
			event.preventDefault();
	
			var files = event.originalEvent.dataTransfer.files;
	
			var file = files[0];
	
			var formData = new FormData();
	
			formData.append("file", file);
	
			$.ajax({
				url : '/uploadAjax',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
	
					var fileInfo = getFileInfo(data);
	
					var html = template(fileInfo);
	
					$(".uploadedList").append(html);
				}
			});
		});
	
		$("#registerForm").submit(
			function(event) {
				event.preventDefault();
	
				var that = $(this);
	
				var str = "";
				$(".uploadedList .delbtn").each(
					function(index) {
						str += "<input type='hidden' name='files["
							+ index + "]' value='"
							+ $(this).attr("href") + "'> ";
					});
	
				that.append(str);
	
				that.get(0).submit();
			});
	</script>
</body>
</html>