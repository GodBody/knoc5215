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

input:focus::-webkit-input-placeholder { color: transparent; } 
input:focus::-moz-placeholder { color: transparent; } 
input:focus:-ms-input-placeholder { color: transparent; } 
input:focus::-ms-input-placeholder { color: transparent; }

</style>

<script>
	$(document).ready(
			function() {

				$('#searchBtn').on(
						"click",
						function(event) {
							if($("select option:selected").val() == "patch") {
								self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + "패치 노트";
							}
							else if($("select option:selected").val() == "lotation") {
								self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + "로테이션";
							}
							else {
								self.location = "list"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword=" + $('#keywordInput').val();;
							}

							
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
					<h3 class="box-title">Notice</h3>
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
						</select> <input type="text" name='keyword' id="keywordInput" placeholder="검색어를 입력하세요"
							value='${cri.keyword }'>
						<button class="glyphicon glyphicon-search" id='searchBtn'></button>
						<!-- <button class="glyphicon glyphicon-pencil" id='newBtn'></button> -->

					</div>

					<div class="box-body">

						<table class="table table-bordered">
							<tr>
								<th style="width: 10px">글번호</th>
								<th>제목</th>
								<th>등록일</th>
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
