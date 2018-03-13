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
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
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
<style type="text/css">
</style>
</head>
<body>
	<div id="wrapper">
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
							<h3 class="box-title">Custom 전적검색</h3>
							<form role="form" method="post">
									<strong>소환사</strong> : <input type="text" name="summonerName"
										id="summonerName"> <input type="submit" value="검색"
										id="submitBtn" placeholder="소환사명...">
								</form>

						</div>
						<!-- /.box-header -->

						<br>

						<div class="box-body">
							<table class="table table-striped">
								<tr>
									<th>전시즌</th>
									<th>S8</th>
									<th>챔피언/이름</th>
									<th>스펠</th>
									<th>룬</th>
									<th>레벨</th>
									<th>평점</th>
									<th>아이템</th>
									<th>골드</th>
									<th>CS</th>
									<th>딜량(탱)</th>
									<th>와드(제거)</th>
								</tr>

								<c:forEach items="${playerList}" var="player" begin="0" end="4">
									<tr style="background: #D4E4FE;">
										<td>${player.highestAchievedSeasonTier }</td>
										<td>${player.tier }-${player.rank }</td>
										<td><img width="30px" height="30px"
											src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" />${player.summonerName}</td>
										<td><img width="20px" height="20px"
											src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
											width="20px" height="20px"
											src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
										<td><img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
											width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
										<td>${player.champLevel}</td>
										<td>${player.kills}/${player.deaths}/${player.assists}</td>
										<td><img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item0}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item1}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item2}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item3}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item4}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item5}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item6}"/>.png" />
										</td>
										<td>${player.goldEarned}</td>
										<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
										<td>${player.totalDamageDealtToChampions}(${player.totalDamageTaken})</td>
										<td>${player.wardsPlaced}/${player.wardsKilled }</td>
									</tr>
								</c:forEach>


							</table>
							<table class="table table-striped">
								<tr>
									<th>전시즌</th>
									<th>S8</th>
									<th>챔피언/이름</th>
									<th>스펠</th>
									<th>룬</th>
									<th>레벨</th>
									<th>평점</th>
									<th>아이템</th>
									<th>골드</th>
									<th>CS</th>
									<th>딜량(탱)</th>
									<th>와드(제거)</th>
								</tr>

								<c:forEach items="${playerList}" var="player" begin="5" end="9">
									<tr style="background: #FFEEEE;">
										<td>${player.highestAchievedSeasonTier }</td>
										<td>${player.tier }-${player.rank }</td>
										<td><img width="30px" height="30px"
											src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" />${player.summonerName}</td>
										<td><img width="20px" height="20px"
											src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
											width="20px" height="20px"
											src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
										<td><img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
											width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
										<td>${player.champLevel}</td>
										<td>${player.kills}/${player.deaths}/${player.assists}</td>
										<td><img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item0}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item1}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item2}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item3}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item4}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item5}"/>.png" />
											<img width="20px" height="20px"
											src="http://opgg-static.akamaized.net/images/lol/item/<c:url value="${player.item6}"/>.png" />
										</td>
										<td>${player.goldEarned}</td>
										<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
										<td>${player.totalDamageDealtToChampions}(${player.totalDamageTaken})</td>
										<td>${player.wardsPlaced}/${player.wardsKilled }</td>
									</tr>
								</c:forEach>
							</table>
						</div>

						<div class="box-footer"></div>
						<!--  /.box-body -->
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
		var result = "${result}";
		if (result == 'success') {
			alert("소환사의 정보가 등록되었습니다.");
		}

		var profileIconId = "${summonerVO.profileIconId}";
		var src = "https://opgg-static.akamaized.net/images/profile_icons/profileIcon"
				+ profileIconId + ".jpg";

		console.log(profileIconId + " / " + src);
		$("#srcTag").attr("src", src);

		$("#submitBtn").on("click", function() {
			$("#view").submit();
		});
	</script>
</body>
</html>

