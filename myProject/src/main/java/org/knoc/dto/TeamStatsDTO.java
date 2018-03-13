package org.knoc.dto;

public class TeamStatsDTO {
	
	private int teamId;
	private boolean firstBlood;
	private boolean firstTower;
	private int baronKills;
	private int dragonKills;
	private int towerKills;
	
	

	public int getBaronKills() {
		return baronKills;
	}

	public void setBaronKills(int baronKills) {
		this.baronKills = baronKills;
	}

	public int getDragonKills() {
		return dragonKills;
	}

	public void setDragonKills(int dragonKills) {
		this.dragonKills = dragonKills;
	}

	public int getTowerKills() {
		return towerKills;
	}

	public void setTowerKills(int towerKills) {
		this.towerKills = towerKills;
	}

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
		return "TeamStatsDTO [teamId=" + teamId + ", firstBlood=" + firstBlood + ", firstTower=" + firstTower
				+ ", baronKills=" + baronKills + ", dragonKills=" + dragonKills + ", towerKills=" + towerKills + "]";
	}

}
