package org.knoc.controller;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.knoc.domain.PlayerVO;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
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

		model.addAttribute("most", most);
		model.addAttribute("list", list);
		model.addAttribute("voList", voList);
		model.addAttribute("winCnt", winCnt);

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

		}


		model.addAttribute("summonerId", summonerId);
		model.addAttribute("teamStats", teamStats);
		model.addAttribute("playerList", voList);

	}

}
