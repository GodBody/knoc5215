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

<style type="text/css">
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
				<li><a href="http://localhost:8080/lol/infoPage">전적검색</a></li>
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
							<h3 style="text-align: center;" class="box-title">전적검색</h3>

							<div>
								<form style="text-align: center;" role="form" method="get">
									<strong>소환사</strong> : <input type="text" name="summonerName"
										id="summonerName">
									<button type="submit" id="submitBtn"
										class="glyphicon glyphicon-search"></button>
								</form>
							</div>

							<div
								style="text-align: center; border-width: 2px; border-style: groove;"
								class="info">

								<c:if test="${summonerVO ne null }">
									<c:set var="summonerVO" value="${summonerVO}" scope="session" />

									<!-- <img id="srcTag" width="50px;" height="50px;"
										src=""> -->
									<img id="srcTag" width="30px;" height="30px;"
										src="https://opgg-static.akamaized.net/images/profile_icons/profileIcon<c:url value="${summonerVO.profileIconId }"/>.jpg" />
									<span> &nbsp;&nbsp;&nbsp;&nbsp; <strong>${summonerVO.name }</strong>
										(Lv. ${summonerVO.summonerLevel}) / ${summonerVO.tier}
										${summonerVO.rank } : ${summonerVO.leaguePoints }pt /
										${summonerVO.wins }승 ${summonerVO.losses }패 /
										${summonerVO.accountId } / 최근 20전 <strong>${winCnt}</strong>승

									</span>
								</c:if>
							</div>

						</div>
						<!-- /.box-header -->

						<br>

						<div class="box-body">
							<table class="table table-condensed">
								<tr>
									<th>결과</th>
									<th>챔피언</th>
									<th>스펠</th>
									<th>룬</th>
									<th>레벨</th>
									<th>KDA</th>
									<th>아이템</th>
									<th>CS</th>
									<th>분석</th>
								</tr>

								<c:forEach items="${voList}" var="player">
									<c:choose>
										<c:when test="${player.win eq true }">
											<tr style="background: #D4E4FE;">
												<td>승리</td>
												<td><img width="30px" height="30px"
													src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" />
													<c:choose>
														<c:when
															test="${ (player.doubleKills eq 0 ) and (player.tripleKills eq 0) and (player.quadraKills eq 0) and (player.pentaKills eq 0)}">
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills eq 0) and (player.quadraKills eq 0) and (player.pentaKills eq 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">더블킬</span>
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills ne 0) and (player.quadraKills eq 0) and (player.pentaKills eq 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">트리플킬</span>
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills ne 0) and (player.quadraKills ne 0) and (player.pentaKills eq 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">쿼드라킬</span>
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills ne 0) and (player.quadraKills ne 0) and (player.pentaKills ne 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">펜타킬</span>
														</c:when>


													</c:choose></td>

												<td><img width="20px" height="20px"
													src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
													width="20px" height="20px"
													src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
												<td><img width="20px" height="20px"
													src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
													width="20px" height="20px"
													src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
												<td>${player.champLevel}&nbsp;&nbsp;</td>
												<td>${player.kills}/<strong style="color: #c6443e;">${player.deaths}</strong>/${player.assists}<br />
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
												<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
												<td>
													<form role="form"
														action="<c:url value = "/lol/viewMatch"/>" method="get">
														<input type="hidden" name="gameId"
															value="${player.gameId }"> <input type="hidden"
															name="summonerId" value="${player.summonerId }">
														<!-- <input type="submit" value="게임 조회"> -->
														<%-- <button
															onclick="window.open('<c:url value = "/lol/viewMatch?gameId="/> + ${player.gameId }','_blank');"
															type="button" value="게임 조회">상세</button> --%>
														<button class="glyphicon glyphicon-align-justify"
															type="submit"></button>
													</form>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr style="background: #FFEEEE;">
												<td>패배</td>
												<td><img width="30px" height="30px"
													src="http://z.fow.kr/champ/<c:url value="${player.championId}"/>.png" />
													<c:choose>
														<c:when
															test="${ (player.doubleKills eq 0 ) and (player.tripleKills eq 0) and (player.quadraKills eq 0) and (player.pentaKills eq 0)}">
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills eq 0) and (player.quadraKills eq 0) and (player.pentaKills eq 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">더블킬</span>
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills ne 0) and (player.quadraKills eq 0) and (player.pentaKills eq 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">트리플킬</span>
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills ne 0) and (player.quadraKills ne 0) and (player.pentaKills eq 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">쿼드라킬</span>
														</c:when>
														<c:when
															test="${ (player.doubleKills ne 0 ) and (player.tripleKills ne 0) and (player.quadraKills ne 0) and (player.pentaKills ne 0)}">
															<span class="Kill"
																style="display: inline-block; background: #ee5a52; border: 1px solid #c6443e; border-radius: 15px; padding: 2px 8px; color: #f2f2f2;">펜타킬</span>
														</c:when>


													</c:choose></td>


												<td><img width="20px" height="20px"
													src="http://z.fow.kr/spell/<c:url value="${player.spell1Id}"/>.png" /><img
													width="20px" height="20px"
													src="http://z.fow.kr/spell/<c:url value="${player.spell2Id}"/>.png" /></td>
												<td><img width="20px" height="20px"
													src="http://opgg-static.akamaized.net/images/lol/perk/<c:url value="${player.perk0}"/>.png" /><img
													width="20px" height="20px"
													src="http://opgg-static.akamaized.net/images/lol/perkStyle/<c:url value="${player.perkSubStyle}"/>.png" /></td>
												<td>${player.champLevel}&nbsp;&nbsp;</td>
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
												<td>${player.totalMinionsKilled}(${player.neutralMinionsKilled })</td>
												<td>
													<form role="form"
														action="<c:url value = "/lol/viewMatch"/>" method="get">
														<input type="hidden" name="gameId"
															value="${player.gameId }"> <input type="hidden"
															name="summonerId" value="${player.summonerId }">
														<!-- <input type="submit" value="게임 조회"> -->
														<%-- 	<button
															onclick="window.open('<c:url value = "/lol/viewMatch?gameId="/> + ${player.gameId }','_blank');"
															type="button" value="게임 조회">상세</button> --%>
														<button class="glyphicon glyphicon-align-justify"
															type="submit"></button>
													</form>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</table>
						</div>
						<!--  /.box-body -->
						<div class="box-footer">
							<table>
								<tr>
									<th class="idHeader">챔피언</th>
									<th class="gameHeader">게임 수</th>
									<th class="winHeader">승</th>
									<th class="lossHeader">패</th>
									<td class="kdaBody1">KDA</td>
									<th class="dealHeader">딜량</th>
								</tr>
								<c:forEach items="${most }" var="most">
									<tr>
										<td><img width="30px" height="30px"
											src="http://z.fow.kr/champ/<c:url value="${most.championId}"/>.png" />
										<td class="gameBody1">${most.frequency }전</td>
										<td class="winBody1">${most.win }승</td>
										<td class="lossBody1">${most.losses }패</td>
										<td class="kdaBody1"><fmt:formatNumber
												value="${most.kdaRatio }" pattern="0.00" /></td>
										<td class="dealBody1"><c:forEach
												items="${most.dealingList }" var="dealing">
												${dealing} 
											</c:forEach></td>
									</tr>
								</c:forEach>

							</table>
						</div>
						<!--  /.box-footer -->
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

