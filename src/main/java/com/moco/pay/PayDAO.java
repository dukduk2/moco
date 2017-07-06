package com.moco.pay;

import java.util.List;

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
	
	public int payInsert(PayDTO payDTO) throws Exception{
		return sqlSession.insert(namespace+"payInsert", payDTO);
	}
	
	public PayDTO paySelectOne1(PayDTO payDTO) throws Exception{
		return sqlSession.selectOne(namespace+"paySelectOne1", payDTO);
	}
	
	public PayDTO paySelectOne2(PayDTO payDTO) throws Exception{
		return sqlSession.selectOne(namespace+"paySelectOne2", payDTO);
	}
}
