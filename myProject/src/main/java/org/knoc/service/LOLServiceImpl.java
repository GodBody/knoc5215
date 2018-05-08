package org.knoc.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.LOLDAO;
import org.knoc.domain.PlayerVO;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchDTO;
import org.knoc.dto.MatchListDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.ParticipantDTO;
import org.knoc.dto.ParticipantIdentityDTO;
import org.knoc.dto.ParticipantStatsDTO;
import org.knoc.dto.PlayerDTO;
import org.knoc.dto.SummonerDTO;
import org.knoc.dto.TeamStatsDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;

@Service
public class LOLServiceImpl implements LOLService {

	private static Logger logger = LoggerFactory.getLogger(LOLServiceImpl.class);

	private static RestTemplate restTemplate = new RestTemplate();
	// static 제네릭 메소드로 각 타입에 맞는 엔터티에 헤더를 삽입하여 반
	public static <T> HttpEntity<T> setHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		headers.set("User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/64.0.3282.186 Safari/537.36");
		headers.set("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
		headers.set("X-Riot-Token", "RGAPI-38b1ec53-a9e2-42a9-8b68-d44e950b7b5c");

		return new HttpEntity<T>(headers);

	}

	@Inject
	private LOLDAO dao;

	@Override
	public SummonerVO insertUser(String summonerName) throws Exception {
		// TODO Auto-generated method stub

		String api = "https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/";
		HttpEntity<SummonerDTO> requestEn = setHeaders();

		ResponseEntity<SummonerDTO> responseEn = restTemplate.exchange(api + summonerName, HttpMethod.GET, requestEn,
				SummonerDTO.class);

		SummonerDTO summonerDTO = responseEn.getBody();

		int count = dao.checkDuplicate(summonerDTO.getId());

		if (count < 1) {
			dao.insertUser(summonerDTO);
		} else {
			dao.updateUser(summonerDTO);
		}

		long summonerId = summonerDTO.getId();
		String api2 = "https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/";
		HttpEntity<LeaguePositionDTO[]> requestEn2 = setHeaders();

		ResponseEntity<LeaguePositionDTO[]> responseEn2 = restTemplate.exchange(api2 + summonerId, HttpMethod.GET,
				requestEn2, LeaguePositionDTO[].class);

		LeaguePositionDTO[] leaguePositionDTO_LIST = responseEn2.getBody();


		// 배치고사 이전이라면? 길이가 1보다 작기때문에
		// 언랭 dto를 생성하여 dao에 전
		if (leaguePositionDTO_LIST.length < 1) {
			LeaguePositionDTO leaguePositionDTO = new LeaguePositionDTO();
			leaguePositionDTO.setRank("unranked");
			leaguePositionDTO.setQueueType("SOLO_unranked");
			leaguePositionDTO.setWins(0);
			leaguePositionDTO.setLosses(0);
			leaguePositionDTO.setLeagueName("unranked");
			leaguePositionDTO.setPlayerOrTeamName(summonerDTO.getName());
			leaguePositionDTO.setPlayerOrTeamId(summonerDTO.getId());
			leaguePositionDTO.setTier("unranked");
			leaguePositionDTO.setLeaguePoints(0);

			dao.insertSoloRankInfo(leaguePositionDTO);
		}
		// 배치를 받았다면?
		else {
			int index = 0;
			for (int i = 0; i < leaguePositionDTO_LIST.length; i++) {
					// 솔로랭크 부분만을 추
				if (leaguePositionDTO_LIST[i].getQueueType().equals("RANKED_SOLO_5x5")) {
					index = i;
					break;
				}
			}

			LeaguePositionDTO positionSolo = leaguePositionDTO_LIST[index];
			// logger.info("SOLO_RANK DTO : " + dto_SOLO.toString());

			dao.insertSoloRankInfo(positionSolo);
		}

		SummonerVO summonerVO = dao.selectUserInfo(summonerName);
		// logger.info("Controller로 보낼 객체 : " + summonerVO.toString());

		return summonerVO;

	}

	@Override
	public List<MatchReferenceDTO> insertMatchInfo(long accountId) {
		// TODO Auto-generated method stub
		// logger.info("INTO insertMatchInfo SERVICE");
		String api = "https://kr.api.riotgames.com/lol/match/v3/matchlists/by-account/";

		HttpEntity<MatchListDTO> requestEn = setHeaders();
		ResponseEntity<MatchListDTO> responseEn = restTemplate.exchange(api + accountId + "?endIndex=20", HttpMethod.GET,
				requestEn, MatchListDTO.class);
		// MatchListDTO안에 있는 List<MatchReferenceDTO>를
		List<MatchReferenceDTO> matches = responseEn.getBody().getMatches();

		for (int i = 0; i < matches.size(); i++) {
			// MatchReferenceDTO에 소환사의 accountId를 추가하
			matches.get(i).setId(accountId);
		}
		for (int i = 0; i < matches.size(); i++) {
			// accountId가 참여한 game을 db에 insert
			// accountId + championId + gameId + queue + lane ...등
			dao.insertMatch(matches.get(i));
		}

	
		return matches;

	}

	@Override
	public void insertSoloRankInfo(LeaguePositionDTO dto_SOLO) {
		// TODO Auto-generated method stub
		dao.insertSoloRankInfo(dto_SOLO);
	}

	@Override
	public SummonerVO selectUserInfo(String summonerName) {
		// TODO Auto-generated method stub
		return dao.selectUserInfo(summonerName);

	}

	@Override
	public void insertMatch(MatchReferenceDTO matchReferenceDTO) {
		// TODO Auto-generated method stub
		dao.insertMatch(matchReferenceDTO);
	}

	

	@Override
	public PlayerVO[] getMatchInfo(long gameId, List<TeamStatsDTO> teamStats) {

		logger.info("INTO getMatchInfo SERVICE");

		HttpEntity<MatchDTO> reqEntity = setHeaders();

		// 해당하는 gameId에 대한 game 정보
		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;

		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		MatchDTO match = resEntity.getBody();

		List<ParticipantIdentityDTO> participantIdentityDTO = match.getParticipantIdentities();

		List<PlayerDTO> playerDTO = new ArrayList<>();
		for (int i = 0; i < participantIdentityDTO.size(); i++) {
			playerDTO.add(participantIdentityDTO.get(i).getPlayer());
		}


		List<ParticipantDTO> participant = match.getParticipants();

		List<ParticipantStatsDTO> participantStatsDTO = new ArrayList<>();
		for (int i = 0; i < participant.size(); i++) {
			participantStatsDTO.add(participant.get(i).getStats());
		}

		PlayerVO[] playerVO = new PlayerVO[10];
		// 10명의 소환사의 dealingToChampion을 저장하기 위한 array
		long[] dealingList = new long[10];

		for (int i = 0; i < 10; i++) {

			playerVO[i] = new PlayerVO();
			playerVO[i].setSummonerName(playerDTO.get(i).getSummonerName());
			playerVO[i].setSummonerId(playerDTO.get(i).getSummonerId());
			playerVO[i].setAccountId(playerDTO.get(i).getAccountId());
			playerVO[i].setTeamId(participant.get(i).getTeamId());

			playerVO[i].setParticipantId(participant.get(i).getParticipantId());
			playerVO[i].setTeamId(playerVO[i].getParticipantId());

			playerVO[i].setWin(participant.get(i).getStats().isWin());

			playerVO[i].setParticipantId(participant.get(i).getParticipantId());
			playerVO[i].setHighestAchievedSeasonTier(participant.get(i).getHighestAchievedSeasonTier());
			playerVO[i].setChampionId(participant.get(i).getChampionId());
			playerVO[i].setSpell1Id(participant.get(i).getSpell1Id());
			playerVO[i].setSpell2Id(participant.get(i).getSpell2Id());
			playerVO[i].setPerk0(participant.get(i).getStats().getPerk0());
			playerVO[i].setPerkSubStyle(participant.get(i).getStats().getPerkSubStyle());

			playerVO[i].setTotalDamageDealtToChampions(participant.get(i).getStats().getTotalDamageDealtToChampions());
			playerVO[i].setTotalDamageTaken(participant.get(i).getStats().getTotalDamageTaken());
			playerVO[i].setTotalMinionsKilled(participant.get(i).getStats().getTotalMinionsKilled());
			playerVO[i].setNeutralMinionsKilled(participant.get(i).getStats().getNeutralMinionsKilled());
			playerVO[i].setGoldEarned(participant.get(i).getStats().getGoldEarned());
			playerVO[i].setChampLevel(participant.get(i).getStats().getChampLevel());
			playerVO[i].setKills(participant.get(i).getStats().getKills());
			playerVO[i].setDeaths(participant.get(i).getStats().getDeaths());
			playerVO[i].setAssists(participant.get(i).getStats().getAssists());

			playerVO[i].setKdaRatio();

			if (playerVO[i].getTeamId() == 100) {
				playerVO[i].setKillInvolvement(teamStats.get(0).getTotalKills());
			} else {
				playerVO[i].setKillInvolvement(teamStats.get(1).getTotalKills());
			}

			playerVO[i].setDoubleKills(participant.get(i).getStats().getDoubleKills());
			playerVO[i].setTripleKills(participant.get(i).getStats().getTripleKills());
			playerVO[i].setQuadraKills(participant.get(i).getStats().getQuadraKills());
			playerVO[i].setPentaKills(participant.get(i).getStats().getPentaKills());
			playerVO[i].setItem0(participant.get(i).getStats().getItem0());
			playerVO[i].setItem1(participant.get(i).getStats().getItem1());
			playerVO[i].setItem2(participant.get(i).getStats().getItem2());
			playerVO[i].setItem3(participant.get(i).getStats().getItem3());
			playerVO[i].setItem4(participant.get(i).getStats().getItem4());
			playerVO[i].setItem5(participant.get(i).getStats().getItem5());
			playerVO[i].setItem6(participant.get(i).getStats().getItem6());
			playerVO[i].setWardsKilled(participant.get(i).getStats().getWardsKilled());
			playerVO[i].setWardsPlaced(participant.get(i).getStats().getWardsPlaced());
			playerVO[i].setVisionWardsBoughtInGame(participant.get(i).getStats().getVisionWardsBoughtInGame());

			// 해당하는 index의 소환사의 딜량을 array에 저장
			dealingList[i] = playerVO[i].getTotalDamageDealtToChampions();

		}

		// 오름차순으로 정렬하고
		Arrays.sort(dealingList);
		// 최대 딜량값을 추출한다
		System.out.println("최대 딜량 : " + dealingList[dealingList.length - 1]);
		long maxDeal = dealingList[dealingList.length - 1];

		// view에서의 progressbar로
		// 해당 게임에서의 최대 딜량의 얼마만큼의 딜을 해당 소환사가 넣었는지에 대해 progressbar width를 계산하기 위해
		// 따로 구성한다
		for (int i = 0; i < playerVO.length; i++) {
			playerVO[i].setRatio(maxDeal);
			// vo의 setRatio(long maxDeal)
			// this.ratio = (long) ((float) this.totalDamageDealtToChampions / maxDeal *
			// 100);
		}

		return playerVO;

	}

	@Override
	public List<TeamStatsDTO> getTeamStats(long gameId) {
		logger.info("INTO getTeamStats()... SERVICE");

		HttpEntity<MatchDTO> reqEntity = setHeaders();

		// 전달받은 gameId에 대한 팀 스탯 정보를 추
		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;

		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		MatchDTO match = resEntity.getBody();

		List<TeamStatsDTO> teamStats = match.getTeams();
		for (int i = 0; i < teamStats.size(); i++) {
			logger.info("teamStats : " + teamStats.get(i).toString());
		}

	

		List<ParticipantDTO> participant = match.getParticipants();

		
		int killCnt = 0;
		int deathCnt = 0;
		int assistCnt = 0;
		for (int i = 0; i < 5; i++) {
			killCnt = killCnt + participant.get(i).getStats().getKills();
			deathCnt = deathCnt + participant.get(i).getStats().getDeaths();
			assistCnt = assistCnt + participant.get(i).getStats().getAssists();
		}

		int killCnt2 = 0;
		int deathCnt2 = 0;
		int assistCnt2 = 0;
		for (int i = 5; i < 10; i++) {
			killCnt2 = killCnt2 + participant.get(i).getStats().getKills();
			deathCnt2 = deathCnt2 + participant.get(i).getStats().getDeaths();
			assistCnt2 = assistCnt2 + participant.get(i).getStats().getAssists();
		}

		teamStats.get(0).setTotalKills(killCnt);
		teamStats.get(0).setTotalDeaths(deathCnt);
		teamStats.get(0).setTotalAssist(assistCnt);

		teamStats.get(1).setTotalKills(killCnt2);
		teamStats.get(1).setTotalDeaths(deathCnt2);
		teamStats.get(1).setTotalAssist(assistCnt2);
		logger.info("teamStat 0 : " + teamStats.get(0).toString());
		logger.info("teamStat 1 : " + teamStats.get(1).toString());

		return teamStats;
	}

	@Override
	public void insertMathTableData(long gameId) {
		// TODO Auto-generated method stub
		logger.info("INTO insertMatchTableData SERVICE");

		// Get match by match ID.
		// Return value: MatchDto

		HttpEntity<MatchDTO> reqEntity = setHeaders();

		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;

		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		MatchDTO match = resEntity.getBody();

		// Gson을 이용해 db에 json으로 insert
		Gson gson = new Gson();

		// MatchDTO를 json Type으로 convert
		String json = gson.toJson(match);

		// db에 이미 저장된 gameId인지 check하기 위한 count
		int count = dao.checkDuplicateMatchTableData(gameId);

		if (count < 1) {
			// 저장되지 않은 gameId라면 저장하
			dao.insertMatchTableJSON(json, gameId);
		} else {
			// 이미 존재하면 메소드 return;
			return;
		}

	}

	@Override
	public PlayerVO getMatchSummory(long gameId, String summonerName) {
		// TODO Auto-generated method stub
		logger.info("INTO getMatchSummary...SERVICE");

		// param으로 받은 gameId에 해당하는 game의 전반적인 data를 추출하고
		// json Type으로 저장되있기에 String에 넣어주
		String summary = dao.getMatchSummary(gameId);
		logger.info("Summary by gameId " + gameId + " = " + summary.toString());

		// Gson을 이용하여 json 을 해당 객체로 convert
		Gson gson = new Gson();
		MatchDTO convert = gson.fromJson(summary, MatchDTO.class);
		logger.info("Convert from JSON to MatchDTO : " + convert.toString());

		// 단일 PlayerVo 객체를 생성하
		PlayerVO vo = new PlayerVO();

		// MatchDTO 안에 존재하는 List<ParticipantIdentityDTO>를 추
		List<ParticipantIdentityDTO> pIden = convert.getParticipantIdentities();

		// List의 안의 각 ParticipantIdentityDTO를 돌면서
		// summonerName param과 일치하는 index를 찾기 위한 새로운 index 변수를 만들
		int index = 0;

		for (int i = 0; i < pIden.size(); i++) {

			logger.info("pIden[" + i + "] 소환사 이름 : " + pIden.get(i).getPlayer().getSummonerName());
			// summonerName 과 ParticipantIdentityDTO 안의 PlayerDTO에 있는 summonerName이 같다
			if ((pIden.get(i).getPlayer().getSummonerName().toLowerCase()).equals(summonerName.toLowerCase())) {
				// 해당 i를 index에 저장하고
				// for문을 빠져나온
				index = i;
				break;
			}
		}
		logger.info("인덱스 : " + index);

		// 추출한 index는 = 검색된 소환사의 data가 존재하는 부분이기에
		// vo에 각 필드값을 setting

		vo.setGameId(gameId);
		vo.setSummonerName(pIden.get(index).getPlayer().getSummonerName());
		vo.setSummonerId(pIden.get(index).getPlayer().getSummonerId());

		vo.setKills(convert.getParticipants().get(index).getStats().getKills());
		vo.setDeaths(convert.getParticipants().get(index).getStats().getDeaths());
		vo.setAssists(convert.getParticipants().get(index).getStats().getAssists());

		vo.setDoubleKills(convert.getParticipants().get(index).getStats().getDoubleKills());
		vo.setTripleKills(convert.getParticipants().get(index).getStats().getTripleKills());
		vo.setQuadraKills(convert.getParticipants().get(index).getStats().getQuadraKills());
		vo.setPentaKills(convert.getParticipants().get(index).getStats().getPentaKills());

		// vo.setMultiKill();

		vo.setKdaRatio();

		vo.setWin(convert.getParticipants().get(index).getStats().isWin());

		vo.setChampionId(convert.getParticipants().get(index).getChampionId());
		vo.setChampLevel(convert.getParticipants().get(index).getStats().getChampLevel());

		vo.setTotalMinionsKilled(convert.getParticipants().get(index).getStats().getTotalMinionsKilled());
		vo.setNeutralMinionsKilled(convert.getParticipants().get(index).getStats().getNeutralMinionsKilled());
		vo.setTotalDamageDealtToChampions(
				convert.getParticipants().get(index).getStats().getTotalDamageDealtToChampions());
		vo.setSpell1Id(convert.getParticipants().get(index).getSpell1Id());
		vo.setSpell2Id(convert.getParticipants().get(index).getSpell2Id());

		vo.setPerk0(convert.getParticipants().get(index).getStats().getPerk0());
		vo.setPerkSubStyle(convert.getParticipants().get(index).getStats().getPerkSubStyle());

		vo.setItem0(convert.getParticipants().get(index).getStats().getItem0());
		vo.setItem1(convert.getParticipants().get(index).getStats().getItem1());
		vo.setItem2(convert.getParticipants().get(index).getStats().getItem2());
		vo.setItem3(convert.getParticipants().get(index).getStats().getItem3());
		vo.setItem4(convert.getParticipants().get(index).getStats().getItem4());
		vo.setItem5(convert.getParticipants().get(index).getStats().getItem5());
		vo.setItem6(convert.getParticipants().get(index).getStats().getItem6());

		List<ParticipantDTO> participant = convert.getParticipants();

		if (index > 0 && index <= 5) {
			int killCnt = 0;
			for (int i = 0; i < 5; i++) {
				killCnt = killCnt + participant.get(i).getStats().getKills();
			}
			logger.info("상단 킬카운트 : " + killCnt);
			vo.setKillInvolvement(killCnt);
		} else {
			int killCnt = 0;
			for (int i = 5; i < 10; i++) {
				killCnt = killCnt + participant.get(i).getStats().getKills();
			}
			logger.info("하단 킬카운트 : " + killCnt);
			vo.setKillInvolvement(killCnt);
		}

		return vo;
	}

}
