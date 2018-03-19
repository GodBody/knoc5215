package org.knoc.util;

import org.knoc.domain.PlayerVO;
import org.knoc.dto.MostChampionSummaryDTO;

public class MostChampionUtil {
	/*
	 * 최근 20경기 중 가장 많이 한 챔피언에 대한 정보를 추출하는 함수 최빈값 알고리즘 응용 최빈값 3개를 구한다
	 */
	public static MostChampionSummaryDTO[] getSummary(PlayerVO[] voList) {

		/*
		 * Most 1 Champion
		 */

		int mode = 0;
		int[] counter = new int[600];
		int max = Integer.MIN_VALUE;

		for (int i = 0; i < voList.length; i++) {
			counter[voList[i].getChampionId()]++;
		}
		for (int i = 0; i < counter.length; i++) {
			if (max < counter[i]) {
				max = counter[i];
				mode = i;
			}
		}

		/*
		 * Most 2 Champion
		 */

		int max2 = Integer.MIN_VALUE;
		int mode2 = 0;
		int[] counter2 = new int[600];

		for (int i = 0; i < voList.length; i++) {
			// most 1에 해당되는 챔피언은 건너뛴다
			if (i == mode)
				continue;
			else
				counter2[voList[i].getChampionId()]++;
		}
		for (int i = 0; i < counter2.length; i++) {
			// most 1에 해당되는 counter index는 건너뛴다
			if (i == mode)
				continue;

			else {
				if (max2 < counter2[i]) {
					max2 = counter2[i];
					mode2 = i;
				}
			}
		}

		/*
		 * Most 3 Champion
		 */

		int max3 = Integer.MIN_VALUE;
		int mode3 = 0;
		int[] counter3 = new int[600];

		for (int i = 0; i < voList.length; i++) {
			// most 1과 2에 해당되는 챔피언은 건너뛴다
			if (i == mode || i == mode2)
				continue;
			else
				counter3[voList[i].getChampionId()]++;
		}
		for (int i = 0; i < counter3.length; i++) {
			// most 1과 2에 해당되는 counter index는 건너뛴다
			if (i == mode || i == mode2)
				continue;
			else {
				if (max3 < counter3[i]) {
					max3 = counter3[i];
					mode3 = i;
				}
			}
		}

		System.out.println("Most 1 ChampionId : " + mode + " , frequnecy :  " + max + " 번");
		System.out.println("Most 2 ChampionId : " + mode2 + " , frequnecy : " + max2 + " 번");
		System.out.println("Most 3 ChampionId : " + mode3 + " , frequnecy :  " + max3 + " 번");

		// 승수를 체크하기 위한 win Counter 변수
		int win = 0;
		int win2 = 0;
		int win3 = 0;

		// 해당하는 champion을 한 game에서의 dealingToChampion을 추출하여 long type의 array
		long[] modeDeal = new long[max];
		long[] modeDeal2 = new long[max2];
		long[] modeDeal3 = new long[max3];

		// index 변수 선
		int modeDealIdx = 0;
		int modeDealIdx2 = 0;
		int modeDealIdx3 = 0;

		// 누적 kda를 계산하기 위한 변수
		float kda = 0;
		float kda2 = 0;
		float kda3 = 0;

		/*
		 * Most 1 Champion
		 */

		for (int i = 0; i < voList.length; i++) {
			// most 1 챔피언이라면?
			if (voList[i].getChampionId() == mode) {
				// 딜량을 array에 넣어준다
				modeDeal[modeDealIdx] = voList[i].getTotalDamageDealtToChampions();
				// array index값을 1 증가
				modeDealIdx++;
				// perfact 게임일때
				if (voList[i].getDeaths() == 0) {
					kda = (float) (kda + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
				} else {
					kda = kda + (float) (voList[i].getKills() + voList[i].getAssists()) / voList[i].getDeaths();
				}
				// 해당 게임을 이겼다면?
				if (voList[i].isWin() == true) {
					win++;
				}
			}
		}

		/*
		 * Most 2 Champion
		 */

		for (int i = 0; i < voList.length; i++) {
			// most 1 챔피언이라면 continue로 다음 루프로 이동
			if (i == mode)
				continue;
			else {
				if (voList[i].getChampionId() == mode2) {
					modeDeal2[modeDealIdx2] = voList[i].getTotalDamageDealtToChampions();
					modeDealIdx2++;
					if (voList[i].getDeaths() == 0) {
						kda2 = (float) (kda2 + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
					} else {
						kda2 = kda2 + (float) (voList[i].getKills() + voList[i].getAssists()) / voList[i].getDeaths();
					}
					if (voList[i].isWin() == true) {
						win2++;
					}
				}
			}
		}

		/*
		 * Most 3 Champion
		 */

		for (int i = 0; i < voList.length; i++) {
			// mose 1, 2 챔피언이라면 continue로 다음 루프로 이동
			if (i == mode || i == mode2)
				continue;
			else {
				if (voList[i].getChampionId() == mode3) {
					modeDeal3[modeDealIdx3] = voList[i].getTotalDamageDealtToChampions();
					modeDealIdx3++;
					if (voList[i].getDeaths() == 0) {
						kda3 = (float) (kda3 + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
					} else {
						kda3 = kda3 + (float) (voList[i].getKills() + voList[i].getAssists()) / voList[i].getDeaths();
					}
					if (voList[i].isWin() == true) {
						win3++;
					}
				}
			}

		}

		

		MostChampionSummaryDTO most = new MostChampionSummaryDTO();
		most.setChampionId(mode);
		most.setWin(win);
		most.setFrequency(max);
		most.setLosses();
		most.setKdaRatio(kda / max);
		most.setDealingList(modeDeal);

		MostChampionSummaryDTO most2 = new MostChampionSummaryDTO();
		most2.setChampionId(mode2);
		most2.setWin(win2);
		most2.setFrequency(max2);
		most2.setLosses();
		most2.setKdaRatio(kda2 / max2);
		most2.setDealingList(modeDeal2);

		MostChampionSummaryDTO most3 = new MostChampionSummaryDTO();
		most3.setChampionId(mode3);
		most3.setWin(win3);
		most3.setFrequency(max3);
		most3.setLosses();
		most3.setKdaRatio(kda3 / max2);
		most3.setDealingList(modeDeal3);

		MostChampionSummaryDTO[] list = new MostChampionSummaryDTO[3];
		list[0] = most;
		list[1] = most2;
		list[2] = most3;

		return list;

	}

}
