<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
.progress-bar {
	height: 30px;
	color: #fff;
	font-weight: bold;
	text-align: right;
	background: #ee5a52;
	width: 0px;
	padding: 0.8em;
}

th, td {
	vertical-align: center;
	padding: 10px;
	border-bottom: 1px solid #444444;
}

table {
	border-top: 1px solid #444444;
}
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

						<div style="margin: auto;" class="box-header">
							<a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle
								Menu</a>
							<h3 style="text-align: center;" class="box-title">전적검색</h3>
							<form style="text-align: center;" role="form"
								action="<c:url value = "/lol/infoPage"/>" method="get">
								<strong>소환사</strong> : <input type="text" name="summonerName"
									id="summonerName">
								<button type="submit" id="submitBtn"
									class="glyphicon glyphicon-search"></button>
							</form>

						</div>
						<!-- /.box-header -->

						<br>

						<div class="box-body">
							<table class="table table-condensed">
								<tr style="background-color: #e8eaea;">
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
									<c:if test="${player.summonerId eq summonerId}">
										<tr style="background: #C6DBE9;">
											<td>${player.highestAchievedSeasonTier }</td>
											<td>${player.tier }-${player.rank }</td>
											<td><img width="30px" height="30px"
												src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
												href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
											<td><img width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
												width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
											<td><img width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
												width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
											<td>${player.champLevel}</td>
											<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
												<c:if test="${player.deaths eq 0 }">
													<strong>Perfect</strong>
												</c:if> <fmt:formatNumber value="${player.kdaRatio }"
													pattern="0.00" />
													<p style="color: #c6443e;">킬관여 ${player.killInvolvement }%</p>
											</td>
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
											<td><fmt:formatNumber value="${player.goldEarned}"
													type="number" /></td>
											<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
											<td class="tdTag"><fmt:formatNumber
													value="${player.totalDamageDealtToChampions}" type="number" />(<fmt:formatNumber
													value="${player.totalDamageTaken}" type="number" />)
												<div class='progress-bar-holder'>
													<div class="progressbar">
														<div class="progress-bar">${player.ratio}%</div>
													</div>
												</div></td>
											<td><img src="http://z.fow.kr//items3/2055.png"
												alt="제어와드 설치 수"
												style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
										</tr>
									</c:if>


									<c:if test="${not (player.summonerId eq summonerId)}">
										<tr style="background: #D4E4FE;">
											<td>${player.highestAchievedSeasonTier }</td>
											<td>${player.tier }-${player.rank }</td>
											<td><img width="30px" height="30px"
												src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
												href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
											<td><img width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
												width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
											<td><img width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
												width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
											<td>${player.champLevel}</td>
											<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
												<c:if test="${player.deaths eq 0 }">
													<strong>Perfect</strong>
												</c:if> <fmt:formatNumber value="${player.kdaRatio }"
													pattern="0.00" />
													<p style="color: #c6443e;">킬관여 ${player.killInvolvement }%</p>
											</td>
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
											<td><fmt:formatNumber value="${player.goldEarned}"
													type="number" /></td>
											<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
											<td class="tdTag"><fmt:formatNumber
													value="${player.totalDamageDealtToChampions}" type="number" />(<fmt:formatNumber
													value="${player.totalDamageTaken}" type="number" />)
												<div class='progress-bar-holder'>
													<div class="progressbar">
														<div class="progress-bar">${player.ratio}%</div>
													</div>
												</div></td>
											<td><img src="http://z.fow.kr//items3/2055.png"
												alt="제어와드 설치 수"
												style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
										</tr>
									</c:if>
								</c:forEach>
								<c:forEach items="${teamStats }" var="teamStats">
									<c:if test="${teamStats.teamId == 100 }">
										<tr style="background: #D4E4FE;">
											<td style="text-align: center;"><strong>승리</strong></td>
											<td><c:if test="${teamStats.firstBlood == true}">
													<strong>퍼블</strong>
												</c:if></td>
											<td><c:if test="${teamStats.firstTower == true}">
													<strong>포블</strong>
												</c:if></td>
											<td><c:if test="${teamStats.firstInhibitor == true}">
													<strong>퍼억</strong>
												</c:if></td>
											<td><c:if test="${teamStats.firstRiftHerald == true}">
													<strong>전령</strong>
												</c:if></td>
											<td colspan="2" style="text-align: center;"><img
												style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/score.png">
												${teamStats.totalKills } / <strong style="color: #c6443e;">${teamStats.totalDeaths }</strong>
												/ ${teamStats.totalAssist }</td>
											<td></td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/baron_100.png"> 바론 :
												${teamStats.baronKills }</td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/dragon_100.png"> 드래곤 :
												${teamStats.dragonKills }</td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/turret_100.png"> 포탑 :
												${teamStats.towerKills }</td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/inhibitor_100.png"> 억제기 :
												${teamStats.inhibitorKills }</td>
										</tr>
									</c:if>

									<c:if test="${teamStats.teamId == 200 }">
										<tr style="background: #FFEEEE;">
											<td style="text-align: center;"><strong>패배</strong></td>
											<td><c:if test="${teamStats.firstBlood == true}">
													<strong>퍼블</strong>
												</c:if></td>
											<td><c:if test="${teamStats.firstTower == true}">
													<strong>포블</strong>
												</c:if></td>
											<td><c:if test="${teamStats.firstInhibitor == true}">
													<strong>퍼억</strong>
												</c:if></td>
											<td><c:if test="${teamStats.firstRiftHerald == true}">
													<strong>전령</strong>
												</c:if></td>
											<td colspan="2" style="text-align: center;"><img
												style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/score.png">
												${teamStats.totalKills } /<strong style="color: #c6443e;">${teamStats.totalDeaths }</strong>
												/ ${teamStats.totalAssist }</td>
											<td></td>

											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/baron_200.png"> 바론 :
												${teamStats.baronKills }</td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/dragon_200.png"> 드래곤 :
												${teamStats.dragonKills }</td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/turret_200.png"> 포탑 :
												${teamStats.towerKills }</td>
											<td><img style="border: 0px; height: 15px;"
												src="//z.fow.kr/img/common/inhibitor_200.png"> 억제기 :
												${teamStats.inhibitorKills }</td>
										</tr>
									</c:if>
								</c:forEach>
								<c:forEach items="${playerList}" var="player" begin="5" end="9">

									<c:if test="${player.summonerId eq summonerId}">
										<tr style="background: #E1D1D0;">
											<td>${player.highestAchievedSeasonTier }</td>
											<td>${player.tier }-${player.rank }</td>
											<td><img width="30px" height="30px"
												src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
												href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
											<td><img width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
												width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
											<td><img width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
												width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
											<td>${player.champLevel}</td>
											<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
												<c:if test="${player.deaths eq 0 }">
													<strong>Perfect</strong>
												</c:if> <fmt:formatNumber value="${player.kdaRatio }"
													pattern="0.00" />
													<p style="color: #c6443e;">킬관여 ${player.killInvolvement }%</p>
											</td>
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
											<td><fmt:formatNumber value="${player.goldEarned}"
													type="number" /></td>
											<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
											<td class="tdTag"><fmt:formatNumber
													value="${player.totalDamageDealtToChampions}" type="number" />(<fmt:formatNumber
													value="${player.totalDamageTaken}" type="number" />)
												<div class='progress-bar-holder'>
													<div class="progressbar">
														<div class="progress-bar">${player.ratio}%</div>
													</div>
												</div></td>
											<td><img src="http://z.fow.kr//items3/2055.png"
												alt="제어와드 설치 수"
												style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
										</tr>
									</c:if>
									<c:if test="${not (player.summonerId eq summonerId)}">
										<tr style="background: #FFEEEE;">
											<td>${player.highestAchievedSeasonTier }</td>
											<td>${player.tier }-${player.rank }</td>
											<td><img width="30px" height="30px"
												src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
												href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
											<td><img width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
												width="20px" height="20px"
												src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
											<td><img width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
												width="20px" height="20px"
												src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
											<td>${player.champLevel}</td>
											<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
												<c:if test="${player.deaths eq 0 }">
													<strong>Perfect</strong>
												</c:if> <fmt:formatNumber value="${player.kdaRatio }"
													pattern="0.00" />
													<p style="color: #c6443e;">킬관여 ${player.killInvolvement }%</p>
											</td>
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
											<td class="deal"><fmt:formatNumber
													value="${player.goldEarned}" type="number" /></td>
											<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
											<td class="tdTag"><fmt:formatNumber
													value="${player.totalDamageDealtToChampions}" type="number" />(<fmt:formatNumber
													value="${player.totalDamageTaken}" type="number" />)
												<div class='progress-bar-holder'>
													<div class="progressbar">
														<div class="progress-bar">${player.ratio}%</div>
													</div>
												</div></td>
											<td><img src="http://z.fow.kr//items3/2055.png"
												alt="제어와드 설치 수"
												style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
										</tr>

									</c:if>
								</c:forEach>




								<%-- <c:forEach items="${playerList}" var="player">
									<c:choose>
										<c:when test="${player.win eq true }">
											<c:if test="${player.summonerId eq summonerId}">
												<tr style="background: #C6DBE9;">
													<td>${player.highestAchievedSeasonTier }</td>
													<td>${player.tier }-${player.rank }</td>
													<td><img width="30px" height="30px"
														src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
														href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
													<td><img width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
														width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
													<td><img width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
														width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
													<td>${player.champLevel}</td>
													<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
														<c:if test="${player.deaths eq 0 }">
															<strong>Perfect</strong>
														</c:if> <fmt:formatNumber value="${player.kdaRatio }"
															pattern="0.00" />
													</td>
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
													<td><fmt:formatNumber value="${player.goldEarned}"
															type="number" /></td>
													<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
													<td class="tdTag"><fmt:formatNumber
															value="${player.totalDamageDealtToChampions}"
															type="number" />(<fmt:formatNumber
															value="${player.totalDamageTaken}" type="number" />)
														<div class='progress-bar-holder'>
															<div class="progressbar">
																<div class="progress-bar">${player.ratio}%</div>
															</div>
														</div></td>
													<td><img src="http://z.fow.kr//items3/2055.png"
														alt="제어와드 설치 수"
														style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
												</tr>
											</c:if>


											<c:if test="${not (player.summonerId eq summonerId)}">
												<tr style="background: #D4E4FE;">
													<td>${player.highestAchievedSeasonTier }</td>
													<td>${player.tier }-${player.rank }</td>
													<td><img width="30px" height="30px"
														src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
														href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
													<td><img width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
														width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
													<td><img width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
														width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
													<td>${player.champLevel}</td>
													<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
														<c:if test="${player.deaths eq 0 }">
															<strong>Perfect</strong>
														</c:if> <fmt:formatNumber value="${player.kdaRatio }"
															pattern="0.00" />
													</td>
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
													<td><fmt:formatNumber value="${player.goldEarned}"
															type="number" /></td>
													<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
													<td class="tdTag"><fmt:formatNumber
															value="${player.totalDamageDealtToChampions}"
															type="number" />(<fmt:formatNumber
															value="${player.totalDamageTaken}" type="number" />)
														<div class='progress-bar-holder'>
															<div class="progressbar">
																<div class="progress-bar">${player.ratio}%</div>
															</div>
														</div></td>
													<td><img src="http://z.fow.kr//items3/2055.png"
														alt="제어와드 설치 수"
														style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
												</tr>
											</c:if>
										</c:when>

										<c:otherwise>
											<c:if test="${player.summonerId eq summonerId}">
												<tr style="background: #E1D1D0;">
													<td>${player.highestAchievedSeasonTier }</td>
													<td>${player.tier }-${player.rank }</td>
													<td><img width="30px" height="30px"
														src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
														href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
													<td><img width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
														width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
													<td><img width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
														width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
													<td>${player.champLevel}</td>
													<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
														<c:if test="${player.deaths eq 0 }">
															<strong>Perfect</strong>
														</c:if> <fmt:formatNumber value="${player.kdaRatio }"
															pattern="0.00" />
													</td>
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
													<td><fmt:formatNumber value="${player.goldEarned}"
															type="number" /></td>
													<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
													<td class="tdTag"><fmt:formatNumber
															value="${player.totalDamageDealtToChampions}"
															type="number" />(<fmt:formatNumber
															value="${player.totalDamageTaken}" type="number" />)
														<div class='progress-bar-holder'>
															<div class="progressbar">
																<div class="progress-bar">${player.ratio}%</div>
															</div>
														</div></td>
													<td><img src="http://z.fow.kr//items3/2055.png"
														alt="제어와드 설치 수"
														style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
												</tr>
											</c:if>
											<c:if test="${not (player.summonerId eq summonerId)}">
												<tr style="background: #FFEEEE;">
													<td>${player.highestAchievedSeasonTier }</td>
													<td>${player.tier }-${player.rank }</td>
													<td><img width="30px" height="30px"
														src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" /><a
														href="http://localhost:8080/lol/infoPage?summonerName=${player.summonerName}">${player.summonerName}</a></td>
													<td><img width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
														width="20px" height="20px"
														src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
													<td><img width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
														width="20px" height="20px"
														src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
													<td>${player.champLevel}</td>
													<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths }</strong>/${player.assists}<br />
														<c:if test="${player.deaths eq 0 }">
															<strong>Perfect</strong>
														</c:if> <fmt:formatNumber value="${player.kdaRatio }"
															pattern="0.00" />
													</td>
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
													<td class="deal"><fmt:formatNumber
															value="${player.goldEarned}" type="number" /></td>
													<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
													<td class="tdTag"><fmt:formatNumber
															value="${player.totalDamageDealtToChampions}"
															type="number" />(<fmt:formatNumber
															value="${player.totalDamageTaken}" type="number" />)
														<div class='progress-bar-holder'>
															<div class="progressbar">
																<div class="progress-bar">${player.ratio}%</div>
															</div>
														</div></td>
													<td><img src="http://z.fow.kr//items3/2055.png"
														alt="제어와드 설치 수"
														style="width: 14px; border: 0; height: 14px; margin: 4px; vertical-align: middle;">${player.visionWardsBoughtInGame }<br />${player.wardsPlaced}/${player.wardsKilled }</td>
												</tr>

											</c:if>
										</c:otherwise>
									</c:choose>
								</c:forEach> --%>



							</table>

						</div>

						<div class="box-footer">
							<c:forEach items="${teamStats }" var="team">
								${team.teamId } / ${team.firstBlood} / ${team.firstTower } / ${team.baronKills } / ${team.dragonKills } / ${team.towerKills } <br />
							</c:forEach>
						</div>
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
	
		$(document).ready(function() {
			$(".progress-bar").each(function() {
				var value = parseInt($(this).html());
				$(this).animate({
					'width' : '' + value + 'px'
				}, 800);
			});
		});
	
		<!-- Menu Toggle Script -->
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
	
		<!-- Modal Action -->
		$("#loginModalBtn").click(function() {
			$("#loginModal").modal();
		});
	</script>
</body>
</html>

