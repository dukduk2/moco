package com.moco.movieSchedule;

import java.util.Date;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
public class timeScheduller {

	@Inject
	private MovieScheduleService movieScheduleService; 
	
	@Scheduled(fixedDelay = 10000)
	/*@Scheduled(cron="58 19 0 * * ?")*/
	public void getTime() throws Exception{
		Date date = new Date();
		long curDate = date.getTime();
		System.out.println(curDate);
		movieScheduleService.getCurTime(curDate);
	}
	
}
