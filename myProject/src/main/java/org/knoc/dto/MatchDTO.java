package org.knoc.dto;

import java.util.List;

public class MatchDTO {
	private int seasonId;
	private int queueId;
	private long gameId;
	private List<ParticipantIdentityDTO> participantIdentities;
	private List<TeamStatsDTO> teams;
	private List<ParticipantDTO> participants;
	private long gameCreation;
	private long gameDuration;
	
	

	public long getGameCreation() {
		return gameCreation;
	}

	public void setGameCreation(long gameCreation) {
		this.gameCreation = gameCreation;
	}

	public long getGameDuration() {
		return gameDuration;
	}

	public void setGameDuration(long gameDuration) {
		this.gameDuration = gameDuration;
	}

	public int getSeasonId() {
		return seasonId;
	}

	public void setSeasonId(int seasonId) {
		this.seasonId = seasonId;
	}

	public int getQueueId() {
		return queueId;
	}

	public void setQueueId(int queueId) {
		this.queueId = queueId;
	}

	public long getGameId() {
		return gameId;
	}

	public void setGameId(long gameId) {
		this.gameId = gameId;
	}

	public List<ParticipantIdentityDTO> getParticipantIdentities() {
		return participantIdentities;
	}

	public void setParticipantIdentities(List<ParticipantIdentityDTO> participantIdentities) {
		this.participantIdentities = participantIdentities;
	}

	public List<TeamStatsDTO> getTeams() {
		return teams;
	}

	public void setTeams(List<TeamStatsDTO> teams) {
		this.teams = teams;
	}

	public List<ParticipantDTO> getParticipants() {
		return participants;
	}

	public void setParticipants(List<ParticipantDTO> participants) {
		this.participants = participants;
	}

	@Override
	public String toString() {
		return "MatchDTO [seasonId=" + seasonId + ", queueId=" + queueId + ", gameId=" + gameId
				+ ", participantIdentities=" + participantIdentities + ", teams=" + teams + ", participants="
				+ participants + ", gameCreation=" + gameCreation + ", gameDuration=" + gameDuration + "]";
	}

}
