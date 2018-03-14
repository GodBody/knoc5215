package org.knoc.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public static <T> HttpEntity<T> setHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		headers.set("User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/64.0.3282.186 Safari/537.36");
		headers.set("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
		headers.set("X-Riot-Token", "RGAPI-d1c5289a-7a65-4ac4-adcb-6561b6e71708");

		return new HttpEntity<T>(headers);

	}

	@Inject
	private LOLDAO dao;

	@Override
	public SummonerVO insertUser(String summonerName) throws Exception {
		// TODO Auto-generated method stub

		// logger.info("INTO insertUser SERVICE");
		String api = "https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/";
		HttpEntity<SummonerDTO> requestEn = setHeaders();

		ResponseEntity<SummonerDTO> responseEn = restTemplate.exchange(api + summonerName, HttpMethod.GET, requestEn,
				SummonerDTO.class);
		// logger.info("검색된 SummonerDTO : " + responseEn.toString());

		SummonerDTO summonerDTO = responseEn.getBody();

		int count = dao.checkDuplicate(summonerDTO.getId());

		if (count < 1) {
			dao.insertUser(summonerDTO);
		} else {
			dao.updateUser(summonerDTO);
		}

		long summonerId = summonerDTO.getId();
		// logger.info("getId : " + summonerId);
		String api2 = "https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/";
		HttpEntity<LeaguePositionDTO[]> requestEn2 = setHeaders();

		ResponseEntity<LeaguePositionDTO[]> responseEn2 = restTemplate.exchange(api2 + summonerId, HttpMethod.GET,
				requestEn2, LeaguePositionDTO[].class);

		LeaguePositionDTO[] leaguePositionDTO_LIST = responseEn2.getBody();

		// logger.info("getbody : " + leaguePositionDTO_LIST.length);

		if (leaguePositionDTO_LIST.length < 1) {
			LeaguePositionDTO dto_NULL = new LeaguePositionDTO();
			dto_NULL.setRank("unranked");
			dto_NULL.setQueueType("SOLO_unranked");
			dto_NULL.setWins(0);
			dto_NULL.setLosses(0);
			dto_NULL.setLeagueName("unranked");
			dto_NULL.setPlayerOrTeamName(summonerDTO.getName());
			dto_NULL.setPlayerOrTeamId(summonerDTO.getId());
			dto_NULL.setTier("unranked");
			dto_NULL.setLeaguePoints(0);

			// logger.info("UN_RANKED DTO : " + dto_NULL.toString());
			dao.insertSoloRankInfo(dto_NULL);
		}

		else {
			int index = 0;
			for (int i = 0; i < leaguePositionDTO_LIST.length; i++) {
				// logger.info("INDEX[ " + i + " ] = " + leaguePositionDTO_LIST[i].toString());
				if (leaguePositionDTO_LIST[i].getQueueType().equals("RANKED_SOLO_5x5")) {
					// logger.info("QueueType : " + leaguePositionDTO_LIST[i].getQueueType());
					index = i;
					break;
				}
			}

			LeaguePositionDTO dto_SOLO = leaguePositionDTO_LIST[index];
			// logger.info("SOLO_RANK DTO : " + dto_SOLO.toString());

			dao.insertSoloRankInfo(dto_SOLO);
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
		ResponseEntity<MatchListDTO> responseEn = restTemplate.exchange(api + accountId, HttpMethod.GET, requestEn,
				MatchListDTO.class);

		List<MatchReferenceDTO> matches = responseEn.getBody().getMatches();
		for (int i = 0; i < matches.size(); i++) {
			matches.get(i).setId(accountId);
			// logger.info("Match with Summoner [ " + i + " ] = " +
			// matches.get(i).toString());
		}
		for (int i = 0; i < matches.size(); i++) {
			// logger.info("InsertMatchInfo()....");
			dao.insertMatch(matches.get(i));
		}

		List<MatchReferenceDTO> list = dao.getMatchList(accountId);
		// logger.info("Controller에 List<MatchReferenceDTO> 를 전달...");

		return list;

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
	public List<MatchReferenceDTO> getMatchList(int summonerId) {
		// TODO Auto-generated method stub
		return dao.getMatchList(summonerId);
	}

	@Override
	public PlayerVO[] getMatchInfo(long gameId) {

		logger.info("INTO getMatchInfo SERVICE");

		HttpEntity<MatchDTO> reqEntity = setHeaders();

		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;

		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		MatchDTO match = resEntity.getBody();

		List<ParticipantIdentityDTO> pIden = match.getParticipantIdentities();

		List<PlayerDTO> player = new ArrayList<>();
		for (int i = 0; i < pIden.size(); i++) {
			player.add(pIden.get(i).getPlayer());
		}

		List<TeamStatsDTO> teamStats = match.getTeams();
		for (int i = 0; i < teamStats.size(); i++) {
			logger.info("teamStats : " + teamStats.get(i).toString());
		}

		List<ParticipantDTO> participant = match.getParticipants();

		List<ParticipantStatsDTO> pStats = new ArrayList<>();
		for (int i = 0; i < participant.size(); i++) {
			pStats.add(participant.get(i).getStats());
		}

		PlayerVO[] vo = new PlayerVO[10];
		long[] dealingList = new long[10];
		for (int i = 0; i < 10; i++) {

			vo[i] = new PlayerVO();
			vo[i].setSummonerName(player.get(i).getSummonerName());
			vo[i].setSummonerId(player.get(i).getSummonerId());
			vo[i].setAccountId(player.get(i).getAccountId());
			vo[i].setTeamId(participant.get(i).getTeamId());

			vo[i].setWin(participant.get(i).getStats().isWin());

			vo[i].setParticipantId(participant.get(i).getParticipantId());
			vo[i].setHighestAchievedSeasonTier(participant.get(i).getHighestAchievedSeasonTier());
			vo[i].setChampionId(participant.get(i).getChampionId());
			vo[i].setSpell1Id(participant.get(i).getSpell1Id());
			vo[i].setSpell2Id(participant.get(i).getSpell2Id());
			vo[i].setPerk0(participant.get(i).getStats().getPerk0());
			vo[i].setPerkSubStyle(participant.get(i).getStats().getPerkSubStyle());

			vo[i].setTotalDamageDealtToChampions(participant.get(i).getStats().getTotalDamageDealtToChampions());
			vo[i].setTotalDamageTaken(participant.get(i).getStats().getTotalDamageTaken());
			vo[i].setTotalMinionsKilled(participant.get(i).getStats().getTotalMinionsKilled());
			vo[i].setNeutralMinionsKilled(participant.get(i).getStats().getNeutralMinionsKilled());
			vo[i].setGoldEarned(participant.get(i).getStats().getGoldEarned());
			vo[i].setChampLevel(participant.get(i).getStats().getChampLevel());
			vo[i].setKills(participant.get(i).getStats().getKills());
			vo[i].setDeaths(participant.get(i).getStats().getDeaths());
			vo[i].setAssists(participant.get(i).getStats().getAssists());
			vo[i].setDoubleKills(participant.get(i).getStats().getDoubleKills());
			vo[i].setTripleKills(participant.get(i).getStats().getTripleKills());
			vo[i].setQuadraKills(participant.get(i).getStats().getQuadraKills());
			vo[i].setPentaKills(participant.get(i).getStats().getPentaKills());
			vo[i].setItem0(participant.get(i).getStats().getItem0());
			vo[i].setItem1(participant.get(i).getStats().getItem1());
			vo[i].setItem2(participant.get(i).getStats().getItem2());
			vo[i].setItem3(participant.get(i).getStats().getItem3());
			vo[i].setItem4(participant.get(i).getStats().getItem4());
			vo[i].setItem5(participant.get(i).getStats().getItem5());
			vo[i].setItem6(participant.get(i).getStats().getItem6());
			vo[i].setWardsKilled(participant.get(i).getStats().getWardsKilled());
			vo[i].setWardsPlaced(participant.get(i).getStats().getWardsPlaced());
			vo[i].setVisionWardsBoughtInGame(participant.get(i).getStats().getVisionWardsBoughtInGame());
			dealingList[i] = vo[i].getTotalDamageDealtToChampions();

		}

		Arrays.sort(dealingList);
		System.out.println("최대 딜량 : " + dealingList[dealingList.length - 1]);
		long maxDeal = dealingList[dealingList.length - 1];

		for (int i = 0; i < vo.length; i++) {
			vo[i].setRatio(maxDeal);
		}

		return vo;

	}

	@Override
	public List<TeamStatsDTO> getTeamStats(long gameId) {
		logger.info("INTO getTeamStats()... SERVICE");

		HttpEntity<MatchDTO> reqEntity = setHeaders();

		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;

		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		MatchDTO match = resEntity.getBody();

		List<TeamStatsDTO> teamStats = match.getTeams();
		for (int i = 0; i < teamStats.size(); i++) {
			logger.info("teamStats : " + teamStats.get(i).toString());
		}
		return teamStats;
	}

	@Override
	public void insertMathTableData(long gameId) {
		// TODO Auto-generated method stub
		logger.info("INTO insertMatchTableData SERVICE");

		HttpEntity<MatchDTO> reqEntity = setHeaders();

		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;

		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		MatchDTO match = resEntity.getBody();

		Gson gson = new Gson();

		String json = gson.toJson(match);

		int count = dao.checkDuplicateMatchTableData(gameId);

		if (count < 1) {
			dao.insertMatchTableJSON(json, gameId);
		} else {
			return;
		}

	}

	@Override
	public PlayerVO getMatchSummory(long gameId, String summonerName) {
		// TODO Auto-generated method stub
		logger.info("INTO getMatchSummary...SERVICE");

		String summary = dao.getMatchSummary(gameId);
		logger.info("Summary by gameId " + gameId + " = " + summary.toString());

		Gson gson = new Gson();
		MatchDTO convert = gson.fromJson(summary, MatchDTO.class);
		logger.info("Convert from JSON toMatchDTO : " + convert.toString());
		PlayerVO vo = new PlayerVO();

		List<ParticipantIdentityDTO> pIden = convert.getParticipantIdentities();
		int index = 0;
		for (int i = 0; i < pIden.size(); i++) {
			logger.info("pIden[" + i + "] 소환사 이름 : " + pIden.get(i).getPlayer().getSummonerName());
			if ((pIden.get(i).getPlayer().getSummonerName()).equals(summonerName)) {
				index = i;
				break;
			}
		}
		logger.info("인덱스 : " + index);

		vo.setGameId(gameId);
		vo.setSummonerName(pIden.get(index).getPlayer().getSummonerName());
		vo.setSummonerId(pIden.get(index).getPlayer().getSummonerId());

		vo.setKills(convert.getParticipants().get(index).getStats().getKills());
		vo.setDeaths(convert.getParticipants().get(index).getStats().getDeaths());
		vo.setAssists(convert.getParticipants().get(index).getStats().getAssists());

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

		logger.info("vo : " + vo.toString());

		return vo;
	}

}
