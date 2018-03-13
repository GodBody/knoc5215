package org.knoc.controller;

import java.util.List;

import javax.inject.Inject;

import org.knoc.domain.PlayerVO;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.TeamStatsDTO;
import org.knoc.service.LOLService;
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

	@RequestMapping(value = "/infoPage")
	public void getInfoPage() {
		logger.info("getInfoByName GET....");
	}

	@RequestMapping(value = "/infoPage", method = RequestMethod.POST)
	public String getInfoByNamePOST(@RequestParam(value = "summonerName") String summonerName, Model model)
			throws Exception {

		SummonerVO summonerVO = service.insertUser(summonerName);

		logger.info("View로 보낼 객체 : " + summonerVO.toString());
		model.addAttribute("summonerVO", summonerVO);

		List<MatchReferenceDTO> list = service.insertMatchInfo(summonerVO.getAccountId());
		for(int i=0; i<list.size(); i++) {
		service.insertMathTableData(list.get(i).getGameId());
		logger.info("matchId로 table에 json으로 data insert complete!");
		}
		model.addAttribute("list", list);

		return "/lol/infoPage";

	}

	@RequestMapping(value = "/viewMatch", method = RequestMethod.GET)
	public void setMatchAndView(@RequestParam(value = "gameId") long gameId, Model model) throws Exception {

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
		for(int i=0; i<voList.length; i++) {
			logger.info(voList[i].toString());
		}

		logger.info("service.getMatchInfo(gameId)...로 부터 받은 객체 :" + voList.toString());

		model.addAttribute("teamStats", teamStats);
		model.addAttribute("playerList", voList);

	}

}
