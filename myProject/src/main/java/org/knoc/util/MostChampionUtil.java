package org.knoc.util;

import org.knoc.domain.PlayerVO;
import org.knoc.dto.MostChampionSummaryDTO;

public class MostChampionUtil {

	public static MostChampionSummaryDTO[] getSummary(PlayerVO[] voList) {
		int mode = 0;
		int[] counter = new int[498];
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

		int max2 = Integer.MIN_VALUE;
		int mode2 = 0;
		int[] counter2 = new int[498];

		for (int i = 0; i < voList.length; i++) {
			if (i == 99)
				continue;

			counter2[voList[i].getChampionId()]++;
		}
		for (int i = 0; i < counter2.length; i++) {
			if (i == 99)
				continue;

			if (max2 < counter2[i]) {
				max2 = counter2[i];
				mode2 = i;
			}
		}

		int max3 = Integer.MIN_VALUE;
		int mode3 = 0;
		int[] counter3 = new int[498];

		for (int i = 0; i < voList.length; i++) {
			if (i == 99 || i == 154)
				continue;

			counter3[voList[i].getChampionId()]++;
		}
		for (int i = 0; i < counter3.length; i++) {
			if (i == 99 || i == 154)
				continue;

			if (max3 < counter3[i]) {
				max3 = counter3[i];
				mode3 = i;
			}
		}

		System.out.println("최빈값 : " + mode + " , " + max + " 번");
		System.out.println("최빈값2 : " + mode2 + " , " + max2 + " 번");
		System.out.println("최빈값3 : " + mode3 + " , " + max3 + " 번");

		int win = 0;
		int win2 = 0;
		int win3 = 0;

		long[] modeDeal = new long[max];
		long[] modeDeal2 = new long[max2];
		long[] modeDeal3 = new long[max3];

		int modeDealIdx = 0;
		int modeDealIdx2 = 0;
		int modeDealIdx3 = 0;

		float kda = 0;
		float kda2 = 0;
		float kda3 = 0;

		for (int i = 0; i < voList.length; i++) {
			if (voList[i].getChampionId() == mode) {
				modeDeal[modeDealIdx] = voList[i].getTotalDamageDealtToChampions();
				modeDealIdx++;
				if (voList[i].getDeaths() == 0) {
					kda = (float) (kda + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
				} else {
					kda = kda + (voList[i].getKills() + voList[i].getAssists()) / voList[i].getDeaths();
				}
				if (voList[i].isWin() == true) {
					win++;

				}
			} else if (voList[i].getChampionId() == mode2) {
				modeDeal2[modeDealIdx2] = voList[i].getTotalDamageDealtToChampions();
				modeDealIdx2++;
				if (voList[i].getDeaths() == 0) {
					kda2 = (float) (kda2 + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
				} else {
					kda2 = kda2 + (voList[i].getKills() + voList[i].getAssists()) / voList[i].getDeaths();
				}
				if (voList[i].isWin() == true) {
					win2++;
				}
			} else if (voList[i].getChampionId() == mode3) {
				modeDeal3[modeDealIdx3] = voList[i].getTotalDamageDealtToChampions();
				modeDealIdx3++;
				if (voList[i].getDeaths() == 0) {
					kda3 = (float) (kda3 + (voList[i].getKills() + voList[i].getAssists()) * 1.2);
				} else {
					kda3 = kda3 + (voList[i].getKills() + voList[i].getAssists()) / voList[i].getDeaths();
				}
				if (voList[i].isWin() == true) {
					win3++;
				}
			}

		}

		System.out.println("최빈값 : " + mode + ", " + max + "번, " + "승수 : " + win + ", KDA : " + kda + ", 딜량 : "
				+ modeDeal.toString());
		System.out.println("최빈값 : " + mode2 + ", " + max2 + "번, " + "승수 : " + win2 + ", KDA : " + kda2 + ", 딜량 : "
				+ modeDeal2.toString());
		System.out.println("최빈값 : " + mode3 + ", " + max3 + "번, " + "승수 : " + win3 + ", KDA : " + kda3 + ", 딜량 : "
				+ modeDeal3.toString());

		for (int i = 0; i < modeDeal.length; i++) {
			System.out.println(mode + "딜량");
			System.out.println(modeDeal[i]);
		}
		for (int i = 0; i < modeDeal2.length; i++) {
			System.out.println(mode2 + "딜량");
			System.out.println(modeDeal2[i]);
		}
		for (int i = 0; i < modeDeal3.length; i++) {
			System.out.println(mode3 + "딜량");
			System.out.println(modeDeal3[i]);
		}

		MostChampionSummaryDTO most = new MostChampionSummaryDTO();
		most.setChampionId(mode);
		most.setWin(win);
		most.setFrequency(max);
		most.setLosses();
		most.setKdaRatio(kda/max);
		most.setDealingList(modeDeal);

		MostChampionSummaryDTO most2 = new MostChampionSummaryDTO();
		most2.setChampionId(mode2);
		most2.setWin(win2);
		most2.setFrequency(max2);
		most2.setLosses();
		most2.setKdaRatio(kda2/max2);
		most2.setDealingList(modeDeal2);

		MostChampionSummaryDTO most3 = new MostChampionSummaryDTO();
		most3.setChampionId(mode3);
		most3.setWin(win3);
		most3.setFrequency(max3);
		most3.setLosses();
		most3.setKdaRatio(kda3/max2);
		most3.setDealingList(modeDeal3);

		MostChampionSummaryDTO[] list = new MostChampionSummaryDTO[3];
		list[0] = most;
		list[1] = most2;
		list[2] = most3;

		return list;

	}

}
