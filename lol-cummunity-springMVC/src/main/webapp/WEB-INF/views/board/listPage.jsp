<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>

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
<style type="text/css">
* {
	font-family: NanumGothic, 'Malgun Gothic';
}

body {
	padding-top: 50px;
}
</style>
</head>

<script>
	var result = '${msg}';
	if (result == 'SUCCESS') {
		alert("Complete!");
	}
</script>

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
				<div class="box-header with-border">
					<h3 class="box-title">Board List</h3>
				</div>
				<div class="box-body">
					<div class="box">
						<h3 class="box-title">List Page</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered">
							<tr>
								<th style="width: 10px">BNO</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>REGDATE</th>
								<th style="width: 40px">VIEWCNT</th>
							</tr>

							<c:forEach items="${list}" var="Board">
								<tr>
									<td>${Board.bno}</td>
									<td><a
										href='/board/readPage${pageMaker.makeQuery(pageMaker.cri.page) }&bno=${Board.bno}'>${Board.title }</a></td>
									<td>${Board.writer }</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
											value="${Board.regdate}" /></td>
									<td><span class="badge bg-red">${Board.viewcnt }</span></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="box-footer">Footer</div>
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li><a
								href="listPage${pageMaker.makeQuery(pageMaker.startPage-1) }">&laquo;</a>
							</li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
								<a href="listPage${pageMaker.makeQuery(idx) }">${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li><a
								href="listPage${pageMaker.makeQuery(pageMaker.endPage+1) }">&raquo;</a>
							</li>

						</c:if>
					</ul>
				</div>
			</div>

		</div>
	</div>


</body>
</html>
