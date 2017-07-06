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
			// 진행 중이지 않은 시즌 0 ->1
			if(seasonDTO.getState() ==0){
				//start
				if(curDate>=startDatee && curDate<=endDatee){
					seasonService.adminOrderStart(seasonDTO.getNum());
					System.out.println("season Start");
				}
			// 진행중인 시즌 1 ->0
			}else{
				if(curDate>endDatee){
					seasonService.adminOrderEnd(seasonDTO.getNum());
					System.out.println("season End");
					if(seasonDTO.getKind().equals("user")){ // kind가 user일 때
						// 시즌이 끝나면 likes, avaliableLikes Update
						seasonService.seasonEndLikesUpdate(seasonDTO.getSeason());
						System.out.println("member likes 지급");
					}
				}
			}
		}
	}

}
