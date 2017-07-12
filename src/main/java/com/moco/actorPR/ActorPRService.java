package com.moco.actorPR;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moco.season.SeasonDTO;

@Service
public class ActorPRService {

	@Inject
	private ActorPRDAO actorPRDAO;
	
	public String voteListSelect(String id) throws Exception{
		return actorPRDAO.voteListSelect(id);
	}
	
	public int voteListInsert(String id) throws Exception{
		return actorPRDAO.voteListInsert(id);
	}
	
	public int voteListDelete() throws Exception{
		return actorPRDAO.voteListDelete();
	}
	
	public int hitUpdate(boolean check, int num) throws Exception{
		return actorPRDAO.hitUpdate(check, num);
	}
	
	public String onameSelect(String name) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("actor", "배우");
		return actorPRDAO.onameSelect(map);
	}
	
	public int totalCount(Map<String, Object> map) throws Exception{
		int result=actorPRDAO.totalCount(map);
		return result;
	}
	
	public int actorPRDelete(int num) throws Exception{
		int result=actorPRDAO.actorPRDelete(num);
		return result;
	}
	
	public int voteCountUpdate(String writer) throws Exception{
		int result=actorPRDAO.voteCountUpdate(writer);
		return result;
	}
	
	public int actorPRUpdate(ActorPRDTO actorPRDTO) throws Exception{
		int result=actorPRDAO.actorPRUpdate(actorPRDTO);
		return result;
	}
	
	public ActorPRDTO actorPRView(int num) throws Exception{
		ActorPRDTO actorPRDTO=new ActorPRDTO();
		
		actorPRDTO=actorPRDAO.actorPRview(num);
		return actorPRDTO;
	}
	
	public List<ActorPRDTO> actorPRList1(Map<String, Object> map) throws Exception{
		System.out.println("season"+map.get("season"));
		return actorPRDAO.actorPRList1(map);
	}
	
	public List<ActorPRDTO> actorPRList2(Map<String, Object> map) throws Exception{
		return actorPRDAO.actorPRList2(map);
	}
	
	public int actorPRWrite(ActorPRDTO actorPRDTO) throws Exception{
		int result=actorPRDAO.actorPRWrite(actorPRDTO);
		return result;
	}
	
	public List<ActorPRDTO> homeList() throws Exception{
		return actorPRDAO.homeList();
	}
	
	
}
