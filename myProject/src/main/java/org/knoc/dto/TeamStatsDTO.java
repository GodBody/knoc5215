package org.knoc.dto;

public class TeamStatsDTO {
	
	private int teamId;
	private boolean firstBlood;
	private boolean firstTower;

	public int getTeamId() {
		return teamId;
	}

	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}

	public boolean isFirstBlood() {
		return firstBlood;
	}

	public void setFirstBlood(boolean firstBlood) {
		this.firstBlood = firstBlood;
	}

	public boolean isFirstTower() {
		return firstTower;
	}

	public void setFirstTower(boolean firstTower) {
		this.firstTower = firstTower;
	}

	@Override
	public String toString() {
		return "TeamStatsDTO [teamId=" + teamId + ", firstBlood=" + firstBlood + ", firstTower=" + firstTower + "]";
	}

}
