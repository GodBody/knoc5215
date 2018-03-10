package org.knoc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchDTO;
import org.knoc.dto.MatchListDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.ParticipantIdentityDTO;
import org.knoc.dto.PlayerDTO;
import org.knoc.dto.SummonerDTO;
import org.knoc.service.LOLService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.deser.DataFormatReaders.Match;

@Controller
@RequestMapping("/lol/*")
public class LOLController {
	private static Logger logger = LoggerFactory.getLogger(LOLController.class);

	@Inject
	private LOLService service;

	private static RestTemplate restTemplate = new RestTemplate();
	private static HttpHeaders headers = new HttpHeaders();

	private static HttpEntity<SummonerDTO> httpEntity = null;
	private static ResponseEntity<SummonerDTO> entity = null;

	public static HttpEntity<SummonerDTO> setHeaders() {
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		headers.set("User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36");
		headers.set("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
		headers.set("X-Riot-Token", "RGAPI-079654f7-88df-4b78-9244-43d3b3b8592b");

		return new HttpEntity<SummonerDTO>(headers);

	}

	@RequestMapping(value = "/infoPage")
	public void getInfoPage() {
		logger.info("getInfoByName GET....");
	}

	@RequestMapping(value = "/infoPage", method = RequestMethod.POST)
	public String getInfoByNamePOST(@RequestParam(value = "summonerName") String summonerName, Model model)
			throws Exception {
		httpEntity = setHeaders();

		String api = "https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/";
		String url = api + summonerName;

		logger.info("entity set for insertUser!!");
		entity = restTemplate.exchange(url, HttpMethod.GET, httpEntity, SummonerDTO.class);

		logger.info("검색된 SummonerDTO : " + entity.toString());
		SummonerDTO dto = entity.getBody();

		service.insertUser(dto);

		/////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////

		long summonerId = dto.getId();
		String tierApi = "https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/";

		logger.info("entity set for setTier!!");
		ResponseEntity<LeaguePositionDTO[]> entityList = restTemplate.exchange(tierApi + summonerId, HttpMethod.GET,
				httpEntity, LeaguePositionDTO[].class);

		LeaguePositionDTO[] dtoList = entityList.getBody();
		int index = 0;
		for (int i = 0; i < dtoList.length; i++) {
			logger.info("INDEX[ " + i + " ] = " + dtoList[i].toString());
			if (dtoList[i].getQueueType().equals("RANKED_SOLO_5x5")) {
				logger.info("QueueType : " + dtoList[i].getQueueType());
				index = i;
				break;
			}
		}

		LeaguePositionDTO dto_SOLO = dtoList[index];
		logger.info("SOLO_RANK DTO : " + dto_SOLO.toString());

		service.insertSoloRankInfo(dto_SOLO);

		SummonerVO summonerVO = service.selectUserInfo(summonerName);
		logger.info("View로 보낼 객체 : " + summonerVO.toString());
		model.addAttribute("summonerVO", summonerVO);
		return "/lol/infoPage";

	}

	@RequestMapping(value = "/viewMatch", method = RequestMethod.GET)
	public void setMatchListGET(@RequestParam(value = "summonerId") int summonerId, Model model,
			HttpServletRequest request) {

		logger.info("setMatchListGET()...");

		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		headers.set("User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36");
		headers.set("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
		headers.set("X-Riot-Token", "RGAPI-079654f7-88df-4b78-9244-43d3b3b8592b");

		HttpEntity<MatchListDTO> reqEntity = new HttpEntity<MatchListDTO>(headers);

		String Matchapi = "https://kr.api.riotgames.com/lol/match/v3/matchlists/by-account/" + summonerId;
		// ResponseEntity<MatchReferenceDTO[]> entityList =
		// restTemplate.exchange(Matchapi, HttpMethod.GET, httpEntity,
		// MatchReferenceDTO[].class);

		ResponseEntity<MatchListDTO> entityList = restTemplate.exchange(Matchapi, HttpMethod.GET, reqEntity,
				MatchListDTO.class);

		logger.info(entityList.toString());
		logger.info(entityList.getBody().toString());
		logger.info(entityList.getBody().getMatches().toString());

		List<MatchReferenceDTO> matches = entityList.getBody().getMatches();
		for (int i = 0; i < matches.size(); i++) {
			matches.get(i).setId(summonerId);
			logger.info("Match with Summoner [ " + i + " ] = " + matches.get(i).toString());
		}

		for (int i = 0; i < matches.size(); i++) {
			logger.info("InsertMatchInfo()....");
			service.insertMatch(matches.get(i));
		}

		logger.info("viewMatch.jsp에 id에 관한 List<MatchReferenceDTO> 를 전달...");
		List<MatchReferenceDTO> list = service.getMatchList(summonerId);

		model.addAttribute("list", list);
		model.addAttribute("summonerVO", request.getAttribute("summonerVO"));

	}

	@RequestMapping(value = "/viewMatch", method = RequestMethod.POST)
	public void setMatchAndView(@RequestParam(value = "gameId") long gameId, Model model, HttpServletRequest request) {
		logger.info("setMatchAndView..." + gameId);
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		headers.set("User-Agent",
				"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36");
		headers.set("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
		headers.set("X-Riot-Token", "RGAPI-079654f7-88df-4b78-9244-43d3b3b8592b");

		HttpEntity<MatchDTO> reqEntity = new HttpEntity<MatchDTO>(headers);

		String api = "https://kr.api.riotgames.com/lol/match/v3/matches/" + gameId;
		ResponseEntity<MatchDTO> resEntity = restTemplate.exchange(api, HttpMethod.GET, reqEntity, MatchDTO.class);

		logger.info(resEntity.getBody().toString());
		logger.info(resEntity.getBody().getParticipantIdentities().toString());
		logger.info(resEntity.getBody().getParticipants().toString());
		logger.info(resEntity.getBody().getTeams().toString());

		MatchDTO match = resEntity.getBody();
		logger.info("match : " + match.toString());
		List<ParticipantIdentityDTO> pIden = match.getParticipantIdentities();
		logger.info("pIden : " + pIden.toString());
		for (int i = 0; i < pIden.size(); i++) {
			PlayerDTO player = pIden.get(i).getPlayer();
			logger.info("player : " + player);
		}
	}

}
