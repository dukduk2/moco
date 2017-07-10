package com.moco.directorBoard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.moco.directorBoard.invest.InvestDTO;
import com.moco.directorBoard.invest.InvestService;

@Component
public class UpdateState {
	@Inject
	DirectorBoardService directorBoardService;
	@Inject
	InvestService investService;
	
	@Scheduled(cron = "0 0 0 * * ?") // cron = "0/5 * * * * ?" 매 5초마다 cron = "0 0 0 * * ?" 매일 0시
	public void test(){
		try {
			System.out.println("Update State Test");
			directorBoardService.stateUpdate(); // state 1 -> 0 업데이트
			List<InvestDTO> investorList = new ArrayList<InvestDTO>(); // 투자자 리스트
			List<DirectorBoardDTO> deadlineList = directorBoardService.compareDate(); // targetDate가 오늘날짜 && 목표달성 실패 리스트
			
			for(DirectorBoardDTO directorBoardDTO : deadlineList){
				investorList = investService.investorList(directorBoardDTO.getNum()); // pnum 투자자 리스트
				for(InvestDTO investDTO : investorList){
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("kind", "investor");
					map.put("flag", "plus");
					map.put("money", investDTO.getMoney());
					map.put("id", investDTO.getId());
					investService.avaliableLikesUpdate(map);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
