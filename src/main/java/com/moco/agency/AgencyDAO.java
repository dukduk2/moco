package com.moco.agency;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class AgencyDAO {

	@Inject
	private SqlSession sqlSession;
	private String namespace="AgencyMapper.";
	
	public List<AgencyDTO> agencyList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"agencyList", map);
	}
	
	public List<AgencyDTO> agencyCommitList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"agencyCommitList", map);
	}
	
	public List<AgencyDTO> agencyUncommitList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"agencyUncommitList", map);
	}
	
	public int agencyListCount(String name) throws Exception{
		return sqlSession.selectOne(namespace+"agencyListCount", name);
	}
	
	public int agencyCommitCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(namespace+"agencyCommitCount", map);
	}
	
	public int agencyUncommitCount() throws Exception{
		return sqlSession.selectOne(namespace+"agencyUncommitCount");
	}
	
	public AgencyDTO agencyView(int num) throws Exception{
		return sqlSession.selectOne(namespace+"agencyView", num);
	}
	
	public int agencyUpdate(AgencyDTO agencyDTO) throws Exception{
		return sqlSession.update(namespace+"agencyUpdate", agencyDTO);
	}
	
	public int agencyDelete(int num) throws Exception{
		return sqlSession.delete(namespace+"agencyDelete", num);
	}
	
	/*public List<AgencyDTO> agencyList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"agencyList", map);
	}*/
	
	public int agencyRequest(AgencyDTO agencyDTO) throws Exception{
		int result=sqlSession.insert(namespace+"agencyRequest", agencyDTO);
		return result;
	}
	
	public int agencyCommit(int num) throws Exception{
		int result=sqlSession.update(namespace+"agencyCommit", num);
		return result;
	}
	
	public int agencyCommitCancel(int num) throws Exception{
		return sqlSession.update(namespace+"agencyCommitCancel", num);
	}
}
