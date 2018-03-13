package org.knoc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.SummonerDTO;
import org.springframework.stereotype.Repository;

@Repository
public class LOLDAOImpl implements LOLDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.knoc.mapper.LeagueOfLegendMapper";

	@Override
	public void insertUser(SummonerDTO dto) {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insertUser", dto);
	}

	@Override
	public void insertSoloRankInfo(LeaguePositionDTO dto_SOLO) {
		// TODO Auto-generated method stub
		session.update(namespace + ".insertSoloRankInfo", dto_SOLO);
	}

	@Override
	public SummonerVO selectUserInfo(String summonerName) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".selectUserInfo", summonerName);
	}

	@Override
	public int checkDuplicate(long id) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".checkDuplicate", id);
	}

	@Override
	public void updateUser(SummonerDTO dto) {
		// TODO Auto-generated method stub
		session.update(namespace + ".updateUser", dto);
	}

	@Override
	public void insertMatch(MatchReferenceDTO matchReferenceDTO) {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insertMatch", matchReferenceDTO);
	}

	@Override
	public List<MatchReferenceDTO> getMatchList(long summonerId) {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getMatchList", summonerId);
	}

	@Override
	public void insertMatchTableJSON(String json, long gameId) {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("json", json);
		paramMap.put("gameId", gameId);
		session.insert(namespace + ".insertMatchTableJSON", paramMap);
	}
}
