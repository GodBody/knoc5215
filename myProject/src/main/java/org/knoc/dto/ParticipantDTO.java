package org.knoc.dto;

public class ParticipantDTO {
	private ParticipantStatsDTO stats;
	private int participantId;
	private String highestAchievedSeasonTier;
	private int championId;

	public ParticipantStatsDTO getStats() {
		return stats;
	}

	public void setStats(ParticipantStatsDTO stats) {
		this.stats = stats;
	}

	public int getParticipantId() {
		return participantId;
	}

	public void setParticipantId(int participantId) {
		this.participantId = participantId;
	}

	public String getHighestAchievedSeasonTier() {
		return highestAchievedSeasonTier;
	}

	public void setHighestAchievedSeasonTier(String highestAchievedSeasonTier) {
		this.highestAchievedSeasonTier = highestAchievedSeasonTier;
	}

	public int getChampionId() {
		return championId;
	}

	public void setChampionId(int championId) {
		this.championId = championId;
	}

	@Override
	public String toString() {
		return "ParticipantDTO [stats=" + stats + ", participantId=" + participantId + ", highestAchievedSeasonTier="
				+ highestAchievedSeasonTier + ", championId=" + championId + "]";
	}

}
