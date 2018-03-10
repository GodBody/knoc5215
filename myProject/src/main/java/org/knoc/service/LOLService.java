package org.knoc.service;

import java.util.List;

import org.knoc.domain.SummonerVO;
import org.knoc.dto.LeaguePositionDTO;
import org.knoc.dto.MatchReferenceDTO;
import org.knoc.dto.SummonerDTO;

public interface LOLService {
	public void insertUser(SummonerDTO dto) throws Exception;

	public void insertSoloRankInfo(LeaguePositionDTO dto_SOLO);

	public SummonerVO selectUserInfo(String summonerName);

	public void insertMatch(MatchReferenceDTO matchReferenceDTO);

	public List<MatchReferenceDTO> getMatchList(int summonerId);

}
