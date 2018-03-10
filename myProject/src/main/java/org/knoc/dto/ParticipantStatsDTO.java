package org.knoc.dto;

public class ParticipantStatsDTO {

	private boolean win;
	private long totalDamageDealtToChampions;
	private long totalDamageTaken;
	private int totalMinionsKilled;
	private int kills;
	private int deaths;
	private int assists;

	public boolean isWin() {
		return win;
	}

	public void setWin(boolean win) {
		this.win = win;
	}

	public int getTotalMinionsKilled() {
		return totalMinionsKilled;
	}

	public void setTotalMinionsKilled(int totalMinionsKilled) {
		this.totalMinionsKilled = totalMinionsKilled;
	}

	public long getTotalDamageDealtToChampions() {
		return totalDamageDealtToChampions;
	}

	public void setTotalDamageDealtToChampions(long totalDamageDealtToChampions) {
		this.totalDamageDealtToChampions = totalDamageDealtToChampions;
	}

	public long getTotalDamageTaken() {
		return totalDamageTaken;
	}

	public void setTotalDamageTaken(long totalDamageTaken) {
		this.totalDamageTaken = totalDamageTaken;
	}

	public int getKills() {
		return kills;
	}

	public void setKills(int kills) {
		this.kills = kills;
	}

	public int getAssists() {
		return assists;
	}

	public void setAssists(int assists) {
		this.assists = assists;
	}

	public int getDeaths() {
		return deaths;
	}

	public void setDeaths(int deaths) {
		this.deaths = deaths;
	}

	@Override
	public String toString() {
		return "ParticipantStatsDTO [win=" + win + ", totalDamageDealtToChampions=" + totalDamageDealtToChampions
				+ ", totalDamageTaken=" + totalDamageTaken + ", totalMinionsKilled=" + totalMinionsKilled + ", kills="
				+ kills + ", deaths=" + deaths + ", assists=" + assists + "]";
	}

}
