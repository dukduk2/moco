package com.moco.screen;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ScreenDAO {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "ScreenMapper.";
	
	public int insert(ScreenDTO screenDTO) throws Exception {
		return sqlSession.insert(NAMESPACE+"insert", screenDTO);
	}
	public List<ScreenDTO> list(int multi_num) throws Exception{
		return sqlSession.selectList(NAMESPACE+"list", multi_num);
	}
	
	public int totalCount() throws Exception{
		return sqlSession.selectOne(NAMESPACE+"unCommitTotalCount");
	}
	//commit=0인 list
	public List<ScreenDTO> unCommitList() throws Exception{
		return sqlSession.selectList(NAMESPACE+"unCommitList");
	}
}
