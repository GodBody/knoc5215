package org.knoc.controller;

import java.util.ArrayList;
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

		SummonerVO summonerVO = service.insertUser(summonerName);

		logger.info("View로 보낼 객체 : " + summonerVO.toString());
		model.addAttribute("summonerVO", summonerVO);

		List<MatchReferenceDTO> list = service.insertMatchInfo(summonerVO.getAccountId());

		// List<PlayerVO> summary = new ArrayList<>();
		PlayerVO[] voList = new PlayerVO[20];

		for (int i = 0; i < list.size(); i++) {
			service.insertMathTableData(list.get(i).getGameId());
			logger.info("게임아이디 : " + list.get(i).getGameId());
			// logger.info("matchId로 table에 json으로 data insert complete!");
			// summary.add(i, service.getMatchSummory(list.get(i).getGameId(),
			// summonerName));
			voList[i] = service.getMatchSummory(list.get(i).getGameId(), summonerName);
		}
		int winCnt = 0;
		for (int i = 0; i < voList.length; i++) {
			logger.info("객체[" + i + "] = " + voList[i].toString());
			if (voList[i].isWin() == true) {
				winCnt++;
			}
		}

		MostChampionSummaryDTO[] most = MostChampionUtil.getSummary(voList);
		for (int i = 0; i < most.length; i++)
			logger.info(most[i].toString());

		model.addAttribute("list", list);
		model.addAttribute("voList", voList);
		model.addAttribute("winCnt", winCnt);

		/*
		 * 최빈값 3개 찾기 ( 모스트 3 챔피언 분석 )
		 */
		// int mode = 0;
		// int[] counter = new int[498];
		// int max = Integer.MIN_VALUE;
		//
		// for (int i = 0; i < voList.length; i++) {
		// counter[voList[i].getChampionId()]++;
		// }
		// for (int i = 0; i < counter.length; i++) {
		// if (max < counter[i]) {
		// max = counter[i];
		// mode = i;
		// }
		// }
		//
		// int max2 = Integer.MIN_VALUE;
		// int mode2 = 0;
		// int[] counter2 = new int[498];
		//
		// for (int i = 0; i < voList.length; i++) {
		// if (i == 99)
		// continue;
		//
		// counter2[voList[i].getChampionId()]++;
		// }
		// for (int i = 0; i < counter2.length; i++) {
		// if (i == 99)
		// continue;
		//
		// if (max2 < counter2[i]) {
		// max2 = counter2[i];
		// mode2 = i;
		// }
		// }
		//
		// int max3 = Integer.MIN_VALUE;
		// int mode3 = 0;
		// int[] counter3 = new int[498];
		//
		// for (int i = 0; i < voList.length; i++) {
		// if (i == 99 || i == 154)
		// continue;
		//
		// counter3[voList[i].getChampionId()]++;
		// }
		// for (int i = 0; i < counter3.length; i++) {
		// if (i == 99 || i == 154)
		// continue;
		//
		// if (max3 < counter3[i]) {
		// max3 = counter3[i];
		// mode3 = i;
		// }
		// }
		//
		// System.out.println("최빈값 : " + mode + " , " + max + " 번");
		// System.out.println("최빈값2 : " + mode2 + " , " + max2 + " 번");
		// System.out.println("최빈값3 : " + mode3 + " , " + max3 + " 번");
		//
		// int win = 0;
		// int win2 = 0;
		// int win3 = 0;
		//
		// long[] modeDeal = new long[max];
		// long[] modeDeal2 = new long[max2];
		// long[] modeDeal3 = new long[max3];
		//
		// int modeDealIdx = 0;
		// int modeDealIdx2 = 0;
		// int modeDealIdx3 = 0;
		//
		// float kda = 0;
		// float kda2 = 0;
		// float kda3 = 0;
		//
		// for (int i = 0; i < voList.length; i++) {
		// if (voList[i].getChampionId() == mode) {
		// modeDeal[modeDealIdx] = voList[i].getTotalDamageDealtToChampions();
		// modeDealIdx++;
		// if (voList[i].getDeaths() == 0) {
		// kda = (float) (kda + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
		// } else {
		// kda = kda + (voList[i].getKills() + voList[i].getAssists()) /
		// voList[i].getDeaths();
		// }
		// if (voList[i].isWin() == true) {
		// win++;
		//
		// }
		// } else if (voList[i].getChampionId() == mode2) {
		// modeDeal2[modeDealIdx2] = voList[i].getTotalDamageDealtToChampions();
		// modeDealIdx2++;
		// if (voList[i].getDeaths() == 0) {
		// kda2 = (float) (kda2 + (voList[i].getKills() + voList[i].getAssists()) *
		// 1.2);
		// } else {
		// kda2 = kda2 + (voList[i].getKills() + voList[i].getAssists()) /
		// voList[i].getDeaths();
		// }
		// if (voList[i].isWin() == true) {
		// win2++;
		// }
		// } else if (voList[i].getChampionId() == mode3) {
		// modeDeal3[modeDealIdx3] = voList[i].getTotalDamageDealtToChampions();
		// modeDealIdx3++;
		// if (voList[i].getDeaths() == 0) {
		// kda3 = (float) (kda3 + (voList[i].getKills() + voList[i].getAssists()) *
		// 1.2);
		// } else {
		// kda3 = kda3 + (voList[i].getKills() + voList[i].getAssists()) /
		// voList[i].getDeaths();
		// }
		// if (voList[i].isWin() == true) {
		// win3++;
		// }
		// }
		//
		// }
		//
		// System.out.println("최빈값 : " + mode + ", " + max + "번, " + "승수 : " + win + ",
		// KDA : " + kda + ", 딜량 : "
		// + modeDeal.toString());
		// System.out.println("최빈값 : " + mode2 + ", " + max2 + "번, " + "승수 : " + win2 +
		// ", KDA : " + kda2 + ", 딜량 : "
		// + modeDeal2.toString());
		// System.out.println("최빈값 : " + mode3 + ", " + max3 + "번, " + "승수 : " + win3 +
		// ", KDA : " + kda3 + ", 딜량 : "
		// + modeDeal3.toString());
		//
		// for(int i=0; i<modeDeal.length; i++) {
		// System.out.println(mode +"딜량");
		// System.out.println(modeDeal[i]);
		// }
		// for(int i=0; i<modeDeal2.length; i++) {
		// System.out.println(mode2 +"딜량");
		// System.out.println(modeDeal2[i]);
		// }
		// for(int i=0; i<modeDeal3.length; i++) {
		// System.out.println(mode3 +"딜량");
		// System.out.println(modeDeal3[i]);
		// }

		return "/lol/infoPage";

	}

	@RequestMapping(value = "/viewMatch", method = RequestMethod.GET)
	public void setMatchAndView(@RequestParam(value = "gameId") long gameId,
			@RequestParam(value = "summonerId") long summonerId, Model model) throws Exception {

		logger.info("INTO viewMatch Controller...");

		List<TeamStatsDTO> teamStats = service.getTeamStats(gameId);

		PlayerVO[] voList = service.getMatchInfo(gameId);
		for (int i = 0; i < voList.length; i++) {
			SummonerVO summonerVO = service.insertUser(voList[i].getSummonerName());
			logger.info("service.insertUser(voList[i].getSummonerName()... : " + summonerVO.toString());
			voList[i].setTier(summonerVO.getTier());
			voList[i].setRank(summonerVO.getRank());
			logger.info("각 유저에 대한 Rank & Tier Setter");
		}

		logger.info("viewMatch.jsp로 보낼 player[10]===================================");
		for (int i = 0; i < voList.length; i++) {
			// logger.info(voList[i].toString());

		}

		logger.info("service.getMatchInfo(gameId)...로 부터 받은 객체 :" + voList.toString());
		model.addAttribute("summonerId", summonerId);
		model.addAttribute("teamStats", teamStats);
		model.addAttribute("playerList", voList);

	}

}
