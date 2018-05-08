<!DOCTYPE html>
<html lang="kor">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Starter</title>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css"
	rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js
	"></script>

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");

		console.log(formObj);

		$(".btn-warning").on("click", function() {
			formObj.attr("action", "/board/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});
		$(".btn-danger").on("click", function() {
			formObj.attr("action", "/board/removePage");
			formObj.submit();
		});
		$(".btn-primary").on("click", function() {
			self.location = "/board/listPage";
		});
	});
</script>

<style type="text/css">
* {
	font-family: NanumGothic, 'Malgun Gothic';
}

body {
	padding-top: 50px;
}
</style>
</head>
<body>

	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle Navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Starter</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">Intro</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">

		<div class="col-md-12">
			<!-- general form elements -->

			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Read Board PAGE</h3>
				</div>
				<!-- /.box-header -->

				<form role="form" action="modifyPage" method="post">
					<input type="hidden" name="bno" value="${board.bno }"> <input
						type="hidden" name="page" value="${cri.page }"> <input
						type="hidden" name="perPageNum" value="${cri.perPageNum }">
				</form>

				<div class="box-body">
					<div class="form-group">
						<label for="title">Title</label> <input type="text" name='title'
							class="form-control" value="${board.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="content">Content</label>
						<textarea class="form-control" name="content" rows="3"
							readonly="readonly">${board.content}</textarea>
					</div>
					<div class="form-group">
						<label for="writer">Writer</label> <input type="text"
							name="writer" class="form-control" value="${board.writer}"
							readonly="readonly">
					</div>
				</div>
				<!-- /.box-body -->
				<div class="box-footer">
					<button type="submit" class="btn btn-warning" id="modifyBtn">Modify</button>
					<button type="submit" class="btn btn-danger" id="removeBtn">REMOVE</button>
					<button type="submit" class="btn btn-primary" id="goListBtn">LIST</button>
				</div>
				<!-- /.box-footer -->

			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->
	</div>
</body>
</html>

