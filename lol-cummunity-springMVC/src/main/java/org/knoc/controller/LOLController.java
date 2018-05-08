package org.knoc.controller;

import java.util.List;

import javax.inject.Inject;

import org.knoc.domain.PlayerVO;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.MostChampionSummaryDTO;
import org.knoc.dto.TeamStatsDTO;
import org.knoc.service.LOLService;
import org.knoc.util.MostChampionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/lol/*")
public class LOLController {
	private static Logger logger = LoggerFactory.getLogger(LOLController.class);

	@Inject
	private LOLService service;

	@RequestMapping(value = "/infoPageStart", method = RequestMethod.GET)
	public void getInfoPage() {
		logger.info("infoPageStart....");
	}

	@RequestMapping(value = "/infoPage", method = RequestMethod.GET)
	public String getInfoByNamePOST(@RequestParam(value = "summonerName") String summonerName, Model model)
			throws Exception {

		// 검색하고자 하는 소환사 이름으로 우선 db에 insert
		SummonerVO summonerVO = service.insertUser(summonerName);

		// view 상단에 검색된 소환사의 기본적인 정보를 제공
		logger.info("View로 보낼 객체 : " + summonerVO.toString());
		model.addAttribute("summonerVO", summonerVO);

		// 검색된 소환사의 accountId로 match 정보를 service로 부터 받아 List로 저장
		// 소환사가 참여한 Match에 대한 정보가 들어있음
		List<MatchReferenceDTO> list = service.insertMatchInfo(summonerVO.getAccountId());

		// List<PlayerVO> summary = new ArrayList<>();
		PlayerVO[] voList = new PlayerVO[20];

		for (int i = 0; i < list.size(); i++) {
			// List<MatchReferenceDTO> 의 각 객체에서 gameId를 추출
			// 해당 gameId에 부합하는 game에 대한 정보를 저장하기 위한 메소

			// gameId에 미리 할당하고
			long gameId = list.get(i).getGameId();

			service.insertMathTableData(gameId);
			logger.info("게임아이디 : " + gameId);

			// 해당하는 소환사가 참여한 game에서의 전적을 추출하기 위한 부분
			// PlayerVO에 미리 gameId getter/setter를 추가적으로 구성했음.
			voList[i] = service.getMatchSummory(gameId, summonerName);
		}

		// view에 최근 20게임 중 승수를 계산하기 위한 count 변
		int winCnt = 0;
		for (int i = 0; i < voList.length; i++) {
			logger.info("getSummary로 받은 playerVO[" + i + "] = " + voList[i].toString());
			// 해당 게임에 win 필드가 true
			if (voList[i].isWin() == true) {
				// 승수 count를 올리
				winCnt++;
			}
		}
		// view에 승수를 attr
		model.addAttribute("winCnt", winCnt);

		// MOST champion 3개에 대한 data를 추출하는 부분
		// frequency, win, loss, kda, dealingToChampion[]

		// 별도의 util class에 최빈값 알고리즘을 구현한 static method
		MostChampionSummaryDTO[] most = MostChampionUtil.getSummary(voList);
		for (int i = 0; i < most.length; i++)
			logger.info(most[i].toString());

		model.addAttribute("most", most);
		// Most 3 Champion Summary Info (championId, frequency, win/loss, KDA,
		// DealingList[]
		// model.addAttribute("list", list);
		model.addAttribute("voList", voList); // 검색된 소환사의 최근 20게임 정보

		return "/lol/infoPage";

	}

	@RequestMapping(value = "/viewMatch", method = RequestMethod.GET)
	public void setMatchAndView(@RequestParam(value = "gameId") long gameId,
			@RequestParam(value = "summonerId") long summonerId, Model model) throws Exception {

		logger.info("INTO viewMatch Controller...");

		List<TeamStatsDTO> teamStats = service.getTeamStats(gameId);
		

		// param으로 받은 gameId에 대한 game 정보를 추출해서
		// 해당 game의 정보 안에 들어있는 10명의 소환사에 대한 game 내 활동 기록을
		// PlayerVO[] 로 구성하여 저장
		PlayerVO[] voList = service.getMatchInfo(gameId, teamStats);

		for (int i = 0; i < voList.length; i++) {
			// 해당 게임의 검색된 소환사 1명을 포함하여 함께 게임한 9명 총 10명 모두를
			// 자동으로 db에 insert하고
			SummonerVO summonerVO = service.insertUser(voList[i].getSummonerName());

			// 10명에 대한 소환사들의 티어와 랭크를 setting
			voList[i].setTier(summonerVO.getTier());
			voList[i].setRank(summonerVO.getRank());
			
			logger.info("Send to viewMatch.jsp :" + voList[i].toString());

		}
		// 검색된 소환사의 부분의 tr 색상을 다르게 하기 위해
		model.addAttribute("summonerId", summonerId);
		// 승리팀과 패배팀의 teamStat 정보로 팀 요약 정보를 구성하기 위해
		model.addAttribute("teamStats", teamStats);
		// 참여한 10명의 소환사들에 대한 List
		model.addAttribute("playerList", voList);

	}

}
