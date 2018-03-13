package org.knoc.service;

import java.util.List;

import org.knoc.domain.PlayerVO;
import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.TeamStatsDTO;

public interface LOLService {
	public SummonerVO insertUser(String summonerName) throws Exception;

	public void insertSoloRankInfo(LeaguePositionDTO dto_SOLO);

	public SummonerVO selectUserInfo(String summonerName);

	public void insertMatch(MatchReferenceDTO matchReferenceDTO);

	public List<MatchReferenceDTO> getMatchList(int summonerId);

	public List<MatchReferenceDTO> insertMatchInfo(long accountId);

	public PlayerVO[] getMatchInfo(long gameId);

	public List<TeamStatsDTO> getTeamStats(long gameId);

	public void insertMathTableData(long gameId);

	public PlayerVO getMatchSummory(long gameId, String summonerName);

}
