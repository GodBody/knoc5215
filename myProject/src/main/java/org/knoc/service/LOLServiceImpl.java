package org.knoc.service;

import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.LOLDAO;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.SummonerDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class LOLServiceImpl implements LOLService {

	private static Logger logger = LoggerFactory.getLogger(LOLServiceImpl.class);

	@Inject
	private LOLDAO dao;

	@Override
	public void insertUser(SummonerDTO dto) throws Exception {
		// TODO Auto-generated method stub

		logger.info("INTO insertUser SERVICE");
		
		int count = dao.checkDuplicate(dto.getId());
		
		if(count < 1) {
		dao.insertUser(dto);
		}
		else {
		dao.updateUser(dto); 
		}

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

}
