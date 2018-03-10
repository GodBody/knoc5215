<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<script type="text/javascript" src="/resources/jquery-3.2.1.min.js"></script>

<style type="text/css">
* {
	font-family: NanumGothic, 'Malgun Gothic';
}

body {
	padding-top: 50px;
}

.starter-template {
	padding: 40px 15px;
	text-align: center;
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
				<a class="navbar-brand" href="#"><b>Admin</b></a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="http://localhost:8080/admin/noticeList">Notice</a></li>
					<li><a href="http://localhost:8080/admin/boardList">Board</a></li>
					<li><a href="http://localhost:8080/admin/accountList">Account</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<h1 style="text-align: center;">Account Info</h1>


			<div class="box-body">
				<h4>회원 목록</h4>
				<table class="table table-bordered">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>상태</th>
						<th>권한</th>
					</tr>

					<c:forEach items="${accountlist}" var="account">
						<tr>
							<td>${account.uid }</td>
							<td>${account.uname }</td>
							<td>${account.unickname }</td>
							<td>${account.uemail }</td>
							<td>${account.status }</td>
							<td>${account.authority }</td>
						</tr>
					</c:forEach>
				</table>
				<h4>수</h4>
				<table class="table table-bordered">
					<tr>
						<th>회원</th>
						<th>자유게시판</th>
						<th>업데이트</th>
						<th>쪽지</th>
					</tr>

					<tr>
						<c:set var="account" value="${accountlist}" />
						<td>${fn:length(account)}</td>
						<td>${board }</td>
						<td>${update }</td>
						<td>${message }</td>
					</tr>
				</table>

			</div>
		</div>

	</div>

</body>
</html>

