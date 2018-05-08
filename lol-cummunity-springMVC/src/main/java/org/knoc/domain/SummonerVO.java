package org.knoc.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class SummonerVO {
	private int profileIconId;
	private String name;
	private long summonerLevel;
	private long revisionDate;
	private long id;
	private long accountId;
	private String tier;
	private String rank;
	private int leaguePoints;
	private int wins;
	private int losses;

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public int getLeaguePoints() {
		return leaguePoints;
	}

	public void setLeaguePoints(int leaguePoints) {
		this.leaguePoints = leaguePoints;
	}

	public int getWins() {
		return wins;
	}

	public void setWins(int wins) {
		this.wins = wins;
	}

	public int getLosses() {
		return losses;
	}

	public void setLosses(int losses) {
		this.losses = losses;
	}

	@Override
	public String toString() {
		return "SummonerVO [profileIconId=" + profileIconId + ", name=" + name + ", summonerLevel=" + summonerLevel
				+ ", revisionDate=" + revisionDate + ", id=" + id + ", accountId=" + accountId + ", tier=" + tier
				+ ", rank=" + rank + ", leaguePoints=" + leaguePoints + ", wins=" + wins + ", losses=" + losses + "]";
	}

	public String getTier() {
		return tier;
	}

	public void setTier(String tier) {
		this.tier = tier;
	}

	public int getProfileIconId() {
		return profileIconId;
	}

	public void setProfileIconId(int profileIconId) {
		this.profileIconId = profileIconId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getSummonerLevel() {
		return summonerLevel;
	}

	public void setSummonerLevel(long summonerLevel) {
		this.summonerLevel = summonerLevel;
	}

	public long getRevisionDate() {
		return revisionDate;
	}

	public void setRevisionDate(long revisionDate) {
		this.revisionDate = revisionDate;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getAccountId() {
		return accountId;
	}

	public void setAccountId(long accountId) {
		this.accountId = accountId;
	}

	public SummonerVO(int profileIconId, String name, long summonerLevel, long revisionDate, long id, long accountId) {
		this.profileIconId = profileIconId;
		this.name = name;
		this.summonerLevel = summonerLevel;
		this.revisionDate = revisionDate;
		this.id = id;
		this.accountId = accountId;
	}

	public SummonerVO() {
	}

}
