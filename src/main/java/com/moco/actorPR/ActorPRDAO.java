package com.moco.actorPR;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.season.SeasonDTO;

@Repository
public class ActorPRDAO {

	@Inject
	private SqlSession sqlSession;
	private String namespace="ActorPRMapper.";
	
	public String voteListSelect(String id) throws Exception{
		return sqlSession.selectOne(namespace+"voteListSelect", id);
	}
	
	public int voteListInsert(String id) throws Exception{
		return sqlSession.insert(namespace+"voteListInsert", id);
	}
	
	public int voteListDelete() throws Exception{
		return sqlSession.delete(namespace+"voteListDelete");
	}
	
	public int hitUpdate(boolean check, int num) throws Exception{
		if(check){
			return sqlSession.update(namespace+"hitUpdate1", num);
		}else{
			return sqlSession.update(namespace+"hitUpdate2", num);
		}
	}
		
	public String onameSelect(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(namespace+"onameSelect", map);
	}
	
	public int totalCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(namespace+"totalCount", map);
	}
	
	public int actorPRDelete(int num) throws Exception{
		int result=sqlSession.delete(namespace+"actorPRDelete", num);
		return result;
	}
	
	public int voteCountUpdate(String writer) throws Exception{
		int result=sqlSession.update(namespace+"voteCountUpdate", writer);
		return result;
	}
	
	public List<ActorPRDTO> actorPRList1(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"actorPRList1", map);
	} 
	
	public List<ActorPRDTO> actorPRList2(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"actorPRList2", map);
	}
	
	public int actorPRWrite(ActorPRDTO actorPRDTO) throws Exception{
		int result=sqlSession.insert(namespace+"actorPRWrite", actorPRDTO);
		return result;
	}
	
	public int actorPRUpdate(ActorPRDTO actorPRDTO) throws Exception{
		int result=sqlSession.update(namespace+"actorPRUpdate", actorPRDTO);
		return result;
	}
	
	public ActorPRDTO actorPRview(int num) throws Exception{
		ActorPRDTO actorPRDTO=null;
		actorPRDTO=sqlSession.selectOne(namespace+"actorPRView", num);
		return actorPRDTO;
	}
	
	public List<ActorPRDTO> homeList() throws Exception{
		return sqlSession.selectList(namespace+"homeList");
	}
}
