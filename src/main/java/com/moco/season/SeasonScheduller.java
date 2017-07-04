package com.moco.season;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.moco.season.SeasonDTO;
import com.moco.season.SeasonService;

@Component
@EnableScheduling
public class SeasonScheduller {
	
	@Autowired
	private SeasonService seasonService;
	private Date date = new Date();
	private long curDate = date.getTime();
	
	/*@Scheduled(fixedDelay = 10000)*/
	@Scheduled(cron="0 0 0 * * ?")
	public void scTest() throws Exception{
		// 매일 오전 12시에 1번 실행
		System.out.println("Season Auto Update!!");
		// user
		List<SeasonDTO> userList = seasonService.adminOrderSelect("user");		
		this.seaonAuto(userList);
		// actor
		List<SeasonDTO> actorList = seasonService.adminOrderSelect("actor");
		this.seaonAuto(actorList);
	}
	
	public void seaonAuto(List<SeasonDTO> ar) throws Exception{
		for (SeasonDTO seasonDTO : ar) {
			Date startDate = seasonDTO.getStartDate();
			long startDatee = startDate.getTime(); 
			Date endDate = seasonDTO.getEndDate();
			long endDatee = endDate.getTime();
			if(curDate>=startDatee && curDate<=endDatee){
				seasonService.adminOrderStart(seasonDTO.getNum());
			}else{
				seasonService.adminOrderEnd(seasonDTO.getNum());
			}
		}
	}
	
}
