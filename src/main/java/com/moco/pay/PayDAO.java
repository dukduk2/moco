package com.moco.pay;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class PayDAO {

	@Inject
	private SqlSession sqlSession;
	private String namespace="PayMapper.";
	
	public List<PayDTO> paySelectList() throws Exception{
		return sqlSession.selectList(namespace+"paySelectList");
	}
	
	public int payInsert(Map<String, Object> map) throws Exception{
		return sqlSession.insert(namespace+"payInsert", map);
	}
}
