package com.moco.actorPR;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@EnableScheduling
public class VoteList {

	@Autowired
	private ActorPRService actorPRService;
	
	@Scheduled(cron="0 0 0 * * ?")
	public void voteListDelete() throws Exception{
		actorPRService.voteListDelete();
	}
}
