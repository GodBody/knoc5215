package org.knoc.dao;

import java.util.List;

import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.SummonerDTO;

public interface LOLDAO {

	public void insertUser(SummonerDTO dto);

	public void insertSoloRankInfo(LeaguePositionDTO dto_SOLO);

	public SummonerVO selectUserInfo(String summonerName);

	public int checkDuplicate(long id);

	public void updateUser(SummonerDTO dto);

	public void insertMatch(MatchReferenceDTO matchReferenceDTO);

	public List<MatchReferenceDTO> getMatchList(long accountId);

	public void insertMatchTableJSON(String json, long gameId);

}
