package com.moco.directorBoard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.moco.directorBoard.invest.InvestDTO;
import com.moco.directorBoard.invest.InvestService;

@Component
public class UpdateState {
	@Scheduled(cron = "0 0 0 * * ?") // cron = "0/5 * * * * ?" 매 5초마다 cron = "0 0 0 * * ?" 매일 0시
	public void test(){
		
		DirectorBoardService directorBoardService = new DirectorBoardService();
		InvestService investService = new InvestService();
		
		try {
			directorBoardService.stateUpdate(); // state 1 -> 0 업데이트
			List<InvestDTO> investorList = new ArrayList<InvestDTO>();
			
			List<DirectorBoardDTO> deadlineList = directorBoardService.compareDate(); // targetDate가 오늘날짜와 같은 리스트
			// director 포인트 업데이트(plus)
			for(DirectorBoardDTO directorBoardDTO : deadlineList){
				Map<String, Object> map = new HashMap<String, Object>();
				int totalMoney = investService.totalMoney(directorBoardDTO.getNum());
				map.put("id", directorBoardDTO.getWriter());
				map.put("kind", "director");
				map.put("totalMoney", totalMoney);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
