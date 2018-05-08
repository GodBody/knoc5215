<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



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


<script>
	var result = '${msg}';
	if (result == 'SUCCESS') {
		alert("Complete!");
	}
</script>

<script>
	$(document).ready(
			function() {

				$('#searchBtn').on(
						"click",
						function(event) {

							self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + $('#keywordInput').val();

						});

				$('#newBtn').on("click", function(evt) {

					self.location = "register";

				});

			});
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

		<div class="col-md-12">
			<!-- general form elements -->

			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Search Board</h3>
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
						<table class="table table-bordered">
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th>조회수</th>
							</tr>

							<c:forEach items="${list}" var="Board">
								<tr>
									<td>${Board.bno}</td>
									<td><a
										href='/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${Board.bno}'>${Board.title }
											<strong>[ ${Board.replycnt } ]</strong>
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
				<div class="box-footer">Footer</div>
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

		</div>
	</div>
</body>
</html>
